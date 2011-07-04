
structure Codegen
   :> CODEGEN
   =
   struct

      structure S = SymbolSet
      structure D = SymbolDict

      open Automaton


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

      fun writeTableEntry write stateSize adjust entry =
         app
            (fn ch => write (Char.toString ch))
            (intToChars stateSize (entry + adjust))
         


      exception Error

      fun writeProgram outfile (functorName, types, terminals, nonterminals, automaton as (stateCount, states, rules, start)) =
         let
            val (terminalOrdinals, terminalCount) =
               D.foldl
               (fn (terminal, _, (ordinals, count)) =>
                   (D.insert ordinals terminal count,
                    count+1))
               (D.singleton (Symbol.fromString "$") 0, 1)
               terminals

            val (nonterminalOrdinals, nonterminalCount) =
               D.foldl
               (fn (nonterminal, _, (ordinals, count)) =>
                   (D.insert ordinals nonterminal count,
                    count+1))
               (D.empty, 0)
               nonterminals

            val minorLimit = Int.max (terminalCount, nonterminalCount)
            val (minorLimit', minorSize) =
               if minorLimit <= 32 then
                  (32, "5")
               else if minorLimit <= 64 then
                  (64, "6")
               else if minorLimit <= 128 then
                  (128, "7")
               else if minorLimit <= 256 then
                  (256, "8")
               else if minorLimit <= 512 then
                  (512, "9")
               else if minorLimit = D.size terminals then
                  (
                  print "Error: too many terminals.\n";
                  raise Error
                  )
               else
                  (
                  print "Error: too many nonterminals.\n";
                  raise Error
                  )

            val majorLimit =
               Int.max (stateCount, Vector.length rules + 1)
                  
            val (majorSize, adjust) =
               if majorLimit <= 127 then
                  (1, 128)
               else if majorLimit <= 32767 then
                  (2, 32768)
               else if majorLimit = stateCount then
                  (
                  print "Error: too many states.\n";
                  raise Error
                  )
               else
                  (
                  print "Error: too many rules.\n";
                  raise Error
                  )

            val outs = TextIO.openOut outfile
            fun write str = TextIO.output (outs, str)
         in
            write "(*\n\n";
            WriteAutomaton.writeAutomaton outs automaton;
            write "\n*)\n\n";

            write "functor ";
            write functorName;
            write " (structure Streamable : STREAMABLE\n";

            S.app
               (fn tp =>
                   (
                   write "type ";
                   write (Symbol.toString tp);
                   write "\n"
                   ))
               types;

            Vector.app
               (fn (_, _, lhs, rhs, args, action) =>
                   let
                      val (_, lhstp) = D.lookup nonterminals lhs
                   in
                      write "val ";
                      write (Symbol.toString action);
                      write " : {";

                      ListPair.foldlEq
                         (fn (_, NONE, first) =>
                                first
                           | (symbol, SOME label, first) =>
                                let
                                   val tp =
                                      (case D.find nonterminals symbol of
                                          SOME (_, tp) => tp
                                        | NONE =>
                                             (case D.lookup terminals symbol of
                                                 NONE =>
                                                    (* We've already generated an error in this case. *)
                                                    raise (Fail "invariant")
                                               | SOME tp => tp))
                                in
                                   if first then
                                      ()
                                   else
                                      write ", ";
                                   write (Symbol.toString label);
                                   write ":";
                                   write (Symbol.toString tp);
                                   false
                                end)
                         true
                         (rhs, args);
                      
                      write "} -> ";
                      write (Symbol.toString lhstp);
                      write "\n"
                   end)
               rules;

            write "datatype terminal =\n";
            D.foldl
               (fn (symbol, tpo, first) =>
                      (
                      if first then
                         ()
                      else
                         write "| ";
                      write (Symbol.toString symbol);
                      (case tpo of
                          NONE => ()
                        | SOME tp =>
                             (
                             write " of ";
                             write (Symbol.toString tp)
                             ));
                      write "\n";
                      false
                      ))
               true
               terminals;

            write "val error : terminal Streamable.t -> exn\n)\n=\nstruct\nlocal\nstructure Value = struct\ndatatype nonterminal =\nDUMMY\n";

            S.app
               (fn tp =>
                   (
                   write "| ";
                   write (Symbol.toString tp);
                   write " of ";
                   write (Symbol.toString tp);
                   write "\n"
                   ))
               types;

            write "end\nstructure ParseEngine = ParseEngineFun (structure Streamable = Streamable\ntype terminal = terminal\ntype value = Value.nonterminal\nval dummy = Value.DUMMY\nfun read terminal =\n(case terminal of\n";

            D.foldl
               (fn (terminal, tpo, first) =>
                   (
                   if first then
                      ()
                   else
                      write "| ";
                   (case tpo of
                       NONE =>
                          (
                          write (Symbol.toString terminal);
                          write " => (";
                          write (Int.toString (D.lookup terminalOrdinals terminal));
                          write ", Value.DUMMY)\n"
                          )
                     | SOME tp =>
                          (
                          write (Symbol.toString terminal);
                          write " terminal => (";
                          write (Int.toString (D.lookup terminalOrdinals terminal));
                          write ", Value.";
                          write (Symbol.toString tp);
                          write " terminal)\n"
                          ));
                   false
                   ))
            true
            terminals;

            write ")\n)\nin\nval parse = ParseEngine.parse (\nParseEngine.next";
            write minorSize;
            write "x";
            write (Int.toString majorSize);
            write " \"";

            app
               (fn (d, _, _) =>
                   let
                      val arr =
                         (* initialize with 0, which represents error *)
                         Array.array (minorLimit', 0)
                   in
                      D.app
                         (fn (terminal, Shift n :: _) =>
                                Array.update (arr, D.lookup terminalOrdinals terminal, n+1)
                           | (terminal, Reduce n :: _) =>
                                Array.update (arr, D.lookup terminalOrdinals terminal, ~(n+2))
                           | _ =>
                                raise (Fail "invariant"))
                         d;

                      Array.app (writeTableEntry write majorSize adjust) arr
                   end)
               states;

            write "\",\nParseEngine.next";
            write minorSize;
            write "x";
            write (Int.toString majorSize);
            write " \"";

            app
               (fn (_, d, _) =>
                   let
                      val arr =
                         Array.array (minorLimit', 0)
                   in
                      D.app
                         (fn (nonterminal, n) =>
                             Array.update (arr, D.lookup nonterminalOrdinals nonterminal, n))
                         d;

                      Array.app (writeTableEntry write majorSize adjust) arr
                   end)
               states;

            write "\",\nVector.fromList [";

            Vector.foldl
               (fn ((_, _, lhs, rhs, args, action), first) =>
                   (
                   if first then
                      ()
                   else
                      write ",\n";
                   write "(";
                   write (Int.toString (D.lookup nonterminalOrdinals lhs));
                   write ",";
                   write (Int.toString (length rhs));
                   write ",(fn ";

                   ListPair.appEq
                      (fn (_, NONE) =>
                             write "_::"
                        | (symbol, SOME label) =>
                             let
                                val tp =
                                   (case D.find nonterminals symbol of
                                       SOME (_, tp) => tp
                                     | NONE =>
                                          valOf (D.lookup terminals symbol))
                             in
                                write "Value.";
                                write (Symbol.toString tp);
                                write "(";
                                write (Symbol.toString label);
                                write ")::"
                             end)
                      (rev rhs, rev args);

                   write "start => Value.";
                   write (Symbol.toString (#2 (D.lookup nonterminals lhs)));
                   write "(";
                   write (Symbol.toString action);
                   write " {";

                   let
                      val noargs =
                         foldl
                            (fn (NONE, first) => first
                              | (SOME label, first) =>
                                   (
                                   if first then
                                      ()
                                   else
                                      write ",";
                                   write (Symbol.toString label);
                                   write "=";
                                   write (Symbol.toString label);
                                   false
                                   ))
                            true
                            args
                   in
                      write "})::start";
                      if noargs then
                         ()
                      else
                         write "|_=>raise (Fail \"bad parser\")"
                   end;
                   write "))";
                   false
                   ))
               true
               rules;

            write "],\n(fn Value.";
            write (Symbol.toString (#2 (D.lookup nonterminals start)));
            write " start => start | _ => raise (Fail \"bad parser\")), error)\nend\nend\n";

            TextIO.closeOut outs
         end

   end
