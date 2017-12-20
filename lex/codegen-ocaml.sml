
structure CodegenOcaml :> CODEGEN =
   struct

      open CodegenUtil

      (* Ought to move common code into CodegenUtil. *)

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
         then  l is a big-endian byte list representing n
               |l| = stateSize
               and 
               return l
      *)
      fun intToBytes size n =
          let
             val l = 
                wordToBytelist (Word.fromInt n) []
          in
             duplicateOnto (size - length l) 0w0 l
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
                       loop i (j-1) (intToBytes stateSize state @ acc)
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
                       loop (i-1) (intToBytes stateSize state @ acc)
                    end
          in
             loop (count-1) []
          end

      fun byteToString b =
         if b < 0w16 then
            "\\x0" ^ Word.toString b
         else if b < 0w32 orelse b > 0w126 then
            "\\x" ^ Word.toString b
         else if b = 0w39 then
            "\\'"
         else if b = 0w34 then
            "\\\""
         else if b = 0w134 then
            "\\\\"
         else
            String.str (Char.chr (Word.toInt b))


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
            write "let ";
            write name;
            write " = (";
            write (Int.toString initial);
            write ", ";
            write (Int.toString lastFinalSink);
            write ", ";
            write (Int.toString lastFinal);
            write ", [|";
            appArraySeparated
               (fn name =>
                   if name = "" then
                      write "epsilon"
                   else
                      (
                      write "Arg.";
                      write name
                      ))
               (fn () => write ";")
               final;
            write "|], Engine.next";
            write minorstr;
            write "x";
            write majorstr;
            write " ";
            write (Int.toString symbolLimit');
            write " \"";
            app (fn ch => write (byteToString ch)) (genTransTable stateSize symbolLimit' count trans);
            write "\", Engine.next0x";
            write majorstr;
            write " \"";
            app (fn ch => write (byteToString ch)) (genEosTable stateSize count transEos);
            write "\")\n";

            ()
         end


      fun writeFunction outs functions keyword (name, _, _) =
          let
             fun write str = TextIO.output (outs, str)
          in
             write keyword;
             write name;
             write " s = Engine.lex {";

             appSeparated 
             (fn (fname, _, _) => 
                    (
                    write "Arg.";
                    write fname;
                    write "=";
                    write fname
                    ))
             (fn () => write "; ")
             functions;

             write "} Tables.";
             write name;
             write " s\n"
          end


      fun writeProgram filename (options, symbolLimit, types, actions, functions) =
          let
             val functorName =
                (case StringDict.find options "name" of
                    SOME name => name
                  | NONE =>
                       (
                       print "Error: no functor name specified.\n";
                       raise Error
                       ))

             val outs = TextIO.openOut filename
             fun write str = TextIO.output (outs, str)
          in
             write "(* File generated by CM-Lex version ";
             write Version.version;
             write " *)\n\nmodule ";
             write functorName;
             write "\n   (Strm : Streamable.S)\n   (Arg :\n       sig\n          type symbol\n          val ord : symbol -> int\n\n";

             app 
                (fn typeName =>
                       (
                       write "          type ";
                       write typeName;
                       write "\n"
                       ))
                types;

             write "\n          type self = { ";

             appSeparated
                (fn (fname, tp, _) =>
                    (
                    write fname;
                    write " : symbol Strm.t -> ";
                    write tp
                    ))
                (fn () => write ";\n                        ")
                functions;

             write " }\n          type info = (symbol list, symbol Strm.t, self) LexInfo.t\n\n";

             app
                (fn (actionName, actionType) =>
                       (
                       write "          val ";
                       write actionName;
                       write " : info -> ";
                       write actionType;
                       write "\n"
                       ))
                actions;

             write "       end)\n   :\n   sig\n";

             app
                (fn (fname, tp, _) =>
                    (
                    write "      val ";
                    write fname;
                    write " : Arg.symbol Strm.t -> Arg.";
                    write tp;
                    write "\n"
                    ))
                functions;

             write "   end\n=\n";

             write "\n(*\n\n";
             WriteAutomata.writeAutomata outs functions;
             write "\n*)\n\n";

             write "struct\nmodule Engine = LexEngine.Make\n(struct\nmodule Strm = Strm\ntype symbol = Arg.symbol\nlet ord = Arg.ord\nend)\nmodule Tables = struct\nlet epsilon _ = raise (Failure \"Illegal lexeme\")\n";
             app (writeTable outs symbolLimit functions) functions;
             write "end\n";

             writeFunction outs functions "let rec " (hd functions);
             app (writeFunction outs functions "and ") (tl functions);
             
             write "end\n";

             TextIO.closeOut outs
          end

   end
