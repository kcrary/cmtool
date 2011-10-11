
structure CodeGen
   :> CODEGEN
   =
   struct

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

      (* intToChars size n

         if    0 <= n < 2^(8 * size)
         then  l is a big-endian character list representing n
               |l| = stateSize
               and 
               return l
      *)
      fun intToChars size n =
          let
             val l = 
                map 
                (fn w => Char.chr (Word.toInt w))
                (wordToBytelist (Word.fromInt n) [])
          in
             duplicateOnto (size - length l) (Char.chr 0) l
          end


      (* genTransTable stateSize symbolLimit count trans

         if    0 <= count < 2^(8*stateSize)
               |trans| = count
               for each 0 <= i < count . |trans[i]| = n_i <= symbolLimit
               for each 0 <= i < count, 0 <= j < n_i . 0 <= trans[i][j] < 2^(8*stateSize)
         then  charlist is a representation of trans
               - laid out state-major
               - each entry is big-endian and consists of stateSize bytes
               and
               returns charlist
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
                       loop i (j-1) (intToChars stateSize state @ acc)
                    end
          in
             loop (count-1) (symbolLimit-1) []
          end


      (* genEosTable stateSize count trans

         if    0 <= count < 2^(8*stateSize)
               |trans| = count
               for each 0 <= i < count . 0 <= trans[i] < 2^(8*stateSize)
         then  charlist is a representation of trans
               - each entry is big-endian and consists of stateSize bytes
               and
               returns charlist
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
                       loop (i-1) (intToChars stateSize state @ acc)
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


      fun writeTable outs symbolLimit functions (name, tp, (count, initial, lastFinalSink, lastFinal, final, trans, transEos)) =
         let
            fun write str = TextIO.output (outs, str)
            val (symbolLimit', minorstr) = tableSizeMinor symbolLimit
            val stateSize = tableSizeMajor count
            val majorstr = Int.toString stateSize
         in
            write "val ";
            write name;
            write " = (";
            write (Int.toString initial);
            write ", ";
            write (Int.toString lastFinalSink);
            write ", ";
            write (Int.toString lastFinal);
            write ", Vector.fromList [";
            appArraySeparated
               (fn name =>
                   if name = "" then
                      write "error"
                   else
                      (
                      write "Arg.";
                      write name
                      ))
               (fn () => write ",")
               final;
            write "], LexEngine.next";
            write minorstr;
            write "x";
            write majorstr;
            write " ";
            write (Int.toString symbolLimit');
            write " \"";
            app (fn ch => write (Char.toString ch)) (genTransTable stateSize symbolLimit' count trans);
            write "\", LexEngine.next0x";
            write majorstr;
            write " \"";
            app (fn ch => write (Char.toString ch)) (genEosTable stateSize count transEos);
            write "\")\n";

            ()
         end


      fun writeFunction outs functions keyword (name, _, _) =
          let
             fun write str = TextIO.output (outs, str)
          in
             write keyword;
             write name;
             write " s = LexEngine.lex {";

             appSeparated 
             (fn (fname, _, _) => 
                    (
                    write fname;
                    write "=";
                    write fname
                    ))
             (fn () => write ", ")
             functions;

             write "} Tables.";
             write name;
             write " s\n"
          end


      fun writeProgram filename (functorName, symbolLimit, types, actions, functions, options) =
          let
             val outs = TextIO.openOut filename
             fun write str = TextIO.output (outs, str)
          in
             write "(*\n\n";
             WriteAutomata.writeAutomata outs functions;
             write "\n*)\n\n";

             write "functor ";
             write functorName;
             write " (structure Streamable : STREAMABLE\nstructure Arg : sig\ntype symbol\nval ord : symbol -> int\n";

             app 
             (fn typeName =>
                    (
                    write "type ";
                    write typeName;
                    write "\n"
                    ))
             types;

             app
             (fn (actionName, actionType) =>
                    (
                    write "val ";
                    write actionName;
                    write " : { match : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {";

                    appSeparated
                    (fn (fname, tp, _) =>
                           (
                           write fname;
                           write " : symbol Streamable.t -> ";
                           write tp
                           ))
                    (fn () => write ", ")
                    functions;

                    write "} } -> ";
                    write actionType;
                    write "\n"
                    ))
             actions;

             write "end)\n=\nstruct\nlocal\nstructure LexEngine = LexEngineFun (structure Streamable = Streamable\ntype symbol = Arg.symbol\nval ord = Arg.ord)\nstructure Tables = struct\nfun error _ = raise (Fail \"Illegal lexeme\")\n";
             app (writeTable outs symbolLimit functions) functions;
             write "end\nin\n";

             writeFunction outs functions "fun " (hd functions);
             app (writeFunction outs functions "and ") (tl functions);
             
             write "end\nend\n";

             TextIO.closeOut outs
          end

   end
