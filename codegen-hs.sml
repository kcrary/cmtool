
structure CodegenHs :> CODEGEN =
   struct

      exception Error

      val () =
         if Word.wordSize < 16 then
            raise (Fail "Word size too small.")
         else
            ()


      fun appSeparated f g l =
          (case l of
              [] =>
                 ()
            | h :: t =>
                 (
                 f h;
                 app (fn x => (g (); f x)) t
                 ))

      fun appArraySeparated f g a =
          let
             val n = Array.length a

             fun loop i =
                 if i >= n then
                    ()
                 else
                    (
                    g ();
                    f (Array.sub (a, i));
                    loop (i+1)
                    )

          in
             if n = 0 then
                ()
             else
                (
                f (Array.sub (a, 0));
                loop 1
                )
          end


      (* Converts a word to a big-endian byte list. *)
      fun wordToBytelist w acc =
          if w = 0w0 then
             acc
          else
             let
                val lo = Word.andb (w, 0wxff)
                val hi = Word.>> (w, 0w8)
             in
                wordToBytelist hi (lo :: acc)
             end

      fun duplicateOnto n x acc =
          if n = 0 then
              acc
          else
             duplicateOnto (n-1) x (x :: acc)

      (* intToBytes size n

         if    0 <= n < 2^(8 * size)
         then  l is a big-endian int list representing n
               |l| = stateSize
               forall i in l . 0 <= i < 256
               and 
               return l
      *)
      fun intToBytes size n =
          let
             val l = 
                map Word.toInt
                (wordToBytelist (Word.fromInt n) [])
          in
             duplicateOnto (size - length l) 0 l
          end

      (* genTransTable stateSize symbolLimit count trans

         if    0 <= count < 2^(8*stateSize)
               |trans| = count
               for each 0 <= i < count . |trans[i]| = n_i <= symbolLimit
               for each 0 <= i < count, 0 <= j < n_i . 0 <= trans[i][j] < 2^(8*stateSize)
         then  intlist is a representation of trans
               - laid out state-major
               - each entry is big-endian and consists of stateSize bytes
               and
               returns intlist
      *)
      fun genTransTable stateSize symbolLimit count trans =
          let
             fun loop i j acc =
                 if i < 0 then
                    acc
                 else if j < 0 then
                    loop (i-1) (symbolLimit-1) acc
                 else
                    let
                       val state = 
                          Array.sub (Array.sub (trans, i), j)
                          handle Subscript =>
                                    (* Symbol out of range of array means illegal character. *)
                                    0
                    in
                       loop i (j-1) (intToBytes stateSize state @ acc)
                    end
          in
             loop (count-1) (symbolLimit-1) []
          end


      (* genEosTable stateSize count trans

         if    0 <= count < 2^(8*stateSize)
               |trans| = count
               for each 0 <= i < count . 0 <= trans[i] < 2^(8*stateSize)
         then  intlist is a representation of trans
               - each entry is big-endian and consists of stateSize bytes
               and
               returns intlist
      *)
      fun genEosTable stateSize count trans =
          let
             fun loop i acc =
                 if i < 0 then
                    acc
                 else
                    let
                       val state =
                          Array.sub (trans, i)
                    in
                       loop (i-1) (intToBytes stateSize state @ acc)
                    end
          in
             loop (count-1) []
          end


      (* The maximum value (1024) is hardcoded to correspond to symbolLimitMax in process.sml. *)
      fun tableSizeMinor limit =
         if limit <= 128 then
            (128, "7")
         else if limit <= 256 then
            (256, "8")
         else if limit <= 512 then
            (512, "9")
         else if limit <= 1024 then
            (1024, "10")
         else
            raise (Fail "Alphabet too large.")

      (* The maximum value (65536) is hardcoded to correspond to stateCountMax in process.sml. *)
      fun tableSizeMajor count =
         if count <= 256 then
            1
         else if count <= 65536 then
            2
         else
            raise (Fail "Table too large.")


      fun writeFunction outs moduleName symbolLimit monadic types actions (name, tp, (count, initial, lastFinalSink, lastFinal, final, trans, transEos)) =
         let
            fun write str = TextIO.output (outs, str)
            val (symbolLimit', minorstr) = tableSizeMinor symbolLimit
            val stateSize = tableSizeMajor count
            val majorstr = Int.toString stateSize
         in
            write name;
            write " :: LexEngine.Streamable stream ";
            if monadic then
               write "monad "
            else
               write "Control.Monad.Identity.Identity ";
            write "=> ";
            write moduleName;
            write ".Arg stream ";
            if monadic then
               write "monad "
            else
               ();
            write "symbol ";

            app
            (fn typeName =>
                (
                write typeName;
                write " "
                ))
            types;
            
            write "-> stream symbol -> ";
            if monadic then
               write "monad "
            else
               ();
            write tp;
            write ";\n";
            write name;
            write " arg s = ";
            if monadic then
               ()
            else
               write "Control.Monad.Identity.runIdentity $ ";
            write "LexEngine.lex (";
            write moduleName;
            write ".ord arg, ";
            write (Int.toString initial);
            write ", ";
            write (Int.toString lastFinalSink);
            write ", ";
            write (Int.toString lastFinal);
            write ", Array.listArray (0, ";
            write (Int.toString (Array.length final - 1));
            write ") [";
            if monadic then
               appArraySeparated
                  (fn action =>
                      if action = "" then
                         write "epsilon"
                      else
                         (
                         write moduleName;
                         write ".";
                         write action;
                         write " arg"
                         ))
                  (fn () => write ", ")
                  final
            else
               appArraySeparated
                  (fn action => 
                      (
                      write "Control.Monad.Identity.Identity . "; 
                      write moduleName;
                      write ".";
                      write action;
                      write " arg"
                      ))
                  (fn () => write ", ") 
                  final;
            write "], LexEngine.next";
            write minorstr;
            write "x";
            write majorstr;
            write " ";
            write (Int.toString symbolLimit');
            write " \"";

            app (fn b => (
                         write "\\";
                         write (Int.toString b)
                         ))
            (genTransTable stateSize symbolLimit' count trans);

            write "\", LexEngine.next0x";

            write majorstr;
            write " \"";
            
            app (fn b => (
                         write "\\";
                         write (Int.toString b)
                         ))
            (genEosTable stateSize count transEos);

            write "\") s;\n"
                
         end
            

      fun writeProgram filename (options, symbolLimit, types, actions, functions) =
         let
            val moduleName =
                (case StringDict.find options "name" of
                    SOME name => name
                  | NONE =>
                       (
                       print "Error: no module name specified.\n";
                       raise Error
                       ))

            val monadic = StringDict.member options "monadic"
         
            val outs = TextIO.openOut filename
            fun write str = TextIO.output (outs, str)
         in
            write "{-# LANGUAGE OverloadedStrings";
            if monadic then
               ()
            else
               write ", FlexibleContexts";
            write " #-}\n\n";

            write "{-\n\n";
            WriteAutomata.writeAutomata outs functions;
            write "\n-}\n\n";

            write "module ";
            write moduleName;
            write "(Arg(..)";

            app
               (fn (fname, _, _) =>
                   (
                   write ", ";
                   write moduleName;
                   write ".";
                   write fname
                   ))
               functions;

            write ") where {\nimport qualified Array;\nimport qualified Char;\n";
            if monadic then
               ()
            else
               write "import qualified Control.Monad.Identity;\n";
            write "import qualified Data.ByteString;\nimport qualified Data.ByteString.Char8;\nimport qualified Util.LexEngine as LexEngine;\ndata Arg stream ";
            if monadic then
               write "monad "
            else
               ();
            write "symbol ";

            app
            (fn typeName =>
                (
                write typeName;
                write " "
                ))
            types;

            write "= Arg { ord :: symbol -> Int";

            app
            (fn typeName =>
                (
                write ",\n";
                write typeName;
                write " :: ";
                if monadic then
                   write "monad "
                else
                   ();
                write typeName
                ))
            types;

            app
            (fn (actionName, actionType) =>
                (
                write ",\n";
                write actionName;
                write " :: LexEngine.LexInfo stream symbol -> ";
                if monadic then
                   write "monad "
                else
                   ();
                write actionType
                ))
            actions;

            write " };\nepsilon _ = Prelude.error \"Illegal lexeme\";\n";
            app (writeFunction outs moduleName symbolLimit monadic types actions) functions;

            write "}\n";
            TextIO.closeOut outs

         end

   end
