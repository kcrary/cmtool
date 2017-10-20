
structure CodegenHs
   :> CODEGEN
   =
   struct

      structure S = SymbolSet
      structure D = SymbolDict

      open Automaton

      fun appSeparated f g l =
          (case l of
              [] =>
                 ()
            | h :: t =>
                 (
                 f h;
                 app (fn x => (g (); f x)) t
                 ))

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
         then  l is a big-endian list of chars representing n
               |l| = stateSize
               l' = map Char.ord l
               and 
               return l'
      *)
      fun intToChars size n =
         let
            val l = 
               map 
               (fn w => Word.toInt w)
               (wordToBytelist (Word.fromInt n) [])
         in
            duplicateOnto (size - length l) 0 l
         end

      fun writeTableEntry write stateSize adjust entry =
         app
            (fn i => (write "\\"; write (Int.toString i)))
            (intToChars stateSize (entry + adjust))


      exception Error

      fun writeProgram outfile (options, types, terminals, nonterminals : (int list * Symbol.symbol * bool ref) D.dict, actions, automaton as (stateCount, states, rules, start)) =
         let
            val moduleName =
                (case D.find options (Symbol.fromValue "name") of
                    SOME name => name
                  | NONE =>
                       (
                       print "Error: no module name specified.\n";
                       raise Error
                       ))

            val terminalName =
                (case D.find options (Symbol.fromValue "data") of
                    SOME name => name
                  | NONE =>
                       (
                       print "Error: no terminal type name specified.\n";
                       raise Error
                       ))

            val monadic = D.member options (Symbol.fromValue "monadic")
         
            val (terminalOrdinals, terminalCount) =
               D.foldl
               (fn (terminal, _, (ordinals, count)) =>
                   (D.insert ordinals terminal count,
                    count+1))
               (D.singleton (Symbol.fromValue "$") 0, 1)
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

            val terminalTypes =
               let
                  val set =
                     D.foldl
                     (fn (_, (tpo, _, _), set) =>
                         (case tpo of
                             SOME tp =>
                                S.insert set tp
                           | NONE =>
                                set))
                     S.empty
                     terminals
               in
                  Mergesort.sort String.compare (map Symbol.toValue (S.toList set))
               end

            val allTypes =
               Mergesort.sort String.compare (map Symbol.toValue (S.toList types))


            val outs = TextIO.openOut outfile
            fun write str = TextIO.output (outs, str)
         in
            write "{-# LANGUAGE OverloadedStrings";
            if monadic then
               ()
            else
               write ", FlexibleContexts";
            write " #-}\n\n";

            write "{-\n\n";

            write "module ";
            write moduleName;
            write " exports:\n\ndata ";
            write terminalName;
            app (fn tp => (write " "; write tp)) terminalTypes;
            write " =\n";

            D.foldl
               (fn (symbol, (tpo, _, _), first) =>
                      (
                      if first then
                         write "   "
                      else
                         write " | ";
                      write (Symbol.toValue symbol);
                      (case tpo of
                          NONE => ()
                        | SOME tp =>
                             (
                             write " ";
                             write (Symbol.toValue tp)
                             ));
                      write "\n";
                      false
                      ))
               true
               terminals;

            write "\n";

            write "data Arg stream";
            if monadic then
               write " monad"
            else
               ();
            app (fn tp => (write " "; write tp)) allTypes;
            write " =\n   Arg { error :: stream (";
            write terminalName;
            app (fn tp => (write " "; write tp)) terminalTypes;
            write ") ->";
            if monadic then
               write " monad"
            else
               ();
            write " Control.Exception.SomeException,\n\n         {- type arguments -}\n";
            
            appSeparated
               (fn typeName =>
                   (
                   write "         ";
                   write typeName;
                   write " :: ";
                   if monadic then
                      write "monad "
                   else
                      ();
                   write typeName
                   ))
               (fn () => write ",\n")
               allTypes;

            write "\n\n         {- action arguments -}\n";

            appSeparated
               (fn (actionName, dom, cod) =>
                   let
                      val dom' =
                         Mergesort.sort
                         (fn ((Syntax.NumericLabel n, _), (Syntax.NumericLabel n', _)) => Int.compare (n, n')
                           | _ =>
                                (* Ident labels aren't permitted for Haskell. *)
                                raise (Fail "invariant"))
                         dom
                   in
                      write "         ";
                      write (Symbol.toValue actionName);
                      write " :: ";
   
                      (* By construction, we have a complete, no-duplicate sequence from 1 to some n. *)
                      app
                         (fn (_, tp) =>
                             (
                             write (Symbol.toValue tp);
                             write " -> "
                             ))
                         dom';
   
                      write (Symbol.toValue cod)
                   end)
               (fn () => write ",\n")
               actions;

            write " }\n\n";
            write "parse :: ParseEngine.Streamable stream ";
            if monadic then
               write "monad "
            else
               write "Data.Functor.Identity.Identity ";
            write "\n         => ";
            write moduleName;
            write ".Arg stream";
            if monadic then
               write " monad"
            else
               ();
            app (fn tp => (write " "; write tp)) allTypes;
            write " -> stream (";
            write terminalName;
            app (fn tp => (write " "; write tp)) terminalTypes;
            write ") -> ";
            if monadic then
               write "monad "
            else
               ();
            write "(";
            write (Symbol.toValue (#2 (D.lookup nonterminals start)));
            write ", stream (";
            write terminalName;
            app (fn tp => (write " "; write tp)) terminalTypes;
            write "))";

            write "\n\n\n";
            WriteAutomaton.writeAutomaton outs automaton;
            write "\n-}\n\n";

            write "module ";
            write moduleName;
            write " (";
            write moduleName;
            write ".";
            write terminalName;
            write "(..), Arg(..), parse) where {\nimport qualified Data.Array as Array;\nimport qualified Control.Exception;\n";
            if monadic then
               ()
            else
               write "import qualified Data.Functor.Identity;\n";
            write "import qualified Data.ByteString;\nimport qualified Data.ByteString.Char8;\nimport qualified Util.ParseEngine as ParseEngine;\n";
            write "data ";
            write terminalName;
            app (fn tp => (write " "; write tp)) terminalTypes;
            write " =\n";

            D.foldl
               (fn (symbol, (tpo, _, _), first) =>
                      (
                      if first then
                         ()
                      else
                         write "| ";
                      write (Symbol.toValue symbol);
                      (case tpo of
                          NONE => ()
                        | SOME tp =>
                             (
                             write " ";
                             write (Symbol.toValue tp)
                             ));
                      write "\n";
                      false
                      ))
               true
               terminals;

            write ";\ndata Arg stream";
            if monadic then
               write " monad"
            else
               ();
            app (fn tp => (write " "; write tp)) allTypes;
            write " = Arg { error :: stream (";
            write terminalName;
            app (fn tp => (write " "; write tp)) terminalTypes;
            write ") ->";
            if monadic then
               write " monad"
            else
               ();
            write " Control.Exception.SomeException";
            
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
            allTypes;

            app
               (fn (actionName, dom, cod) =>
                   let
                      val dom' =
                         Mergesort.sort
                         (fn ((Syntax.NumericLabel n, _), (Syntax.NumericLabel n', _)) => Int.compare (n, n')
                           | _ =>
                                (* Ident labels aren't permitted for Haskell. *)
                                raise (Fail "invariant"))
                         dom
                   in
                      write ",\n";
                      write (Symbol.toValue actionName);
                      write " :: ";
   
                      (* By construction, we have a complete, no-duplicate sequence from 1 to some n. *)
                      app
                         (fn (_, tp) =>
                             (
                             write (Symbol.toValue tp);
                             write " -> "
                             ))
                         dom';
   
                      write (Symbol.toValue cod)
                   end)
               actions;

            write " }\n;\n";
            write "data Value";
            app (fn tp => (write " "; write tp)) allTypes;
            write " =\nValue\n";

            S.app
               (fn tp =>
                   (
                   write "| Value";
                   write (Symbol.toValue tp);
                   write " ";
                   write (Symbol.toValue tp);
                   write "\n"
                   ))
               types;

            write ";\nterminal :: (";
            write terminalName;
            app (fn tp => (write " "; write tp)) terminalTypes;
            write ") -> (Int, Value";
            app (fn tp => (write " "; write tp)) allTypes;
            write ");\n";
            write "terminal t = case t of {";

            D.foldl
               (fn (terminal, (tpo, _, _), first) =>
                   (
                   if first then
                      write "\n"
                   else
                      write ";\n";
                   (case tpo of
                       NONE =>
                          (
                          write (Symbol.toValue terminal);
                          write " -> (";
                          write (Int.toString (D.lookup terminalOrdinals terminal));
                          write ", Value)"
                          )
                     | SOME tp =>
                          (
                          write (Symbol.toValue terminal);
                          write " x -> (";
                          write (Int.toString (D.lookup terminalOrdinals terminal));
                          write ", Value";
                          write (Symbol.toValue tp);
                          write " x)"
                          ));
                   false
                   ))
               true
               terminals;

            write "\n}\n;\n";

            write "parse :: ParseEngine.Streamable stream ";
            if monadic then
               write "monad "
            else
               write "Data.Functor.Identity.Identity ";
            write "=> ";
            write moduleName;
            write ".Arg stream";
            if monadic then
               write " monad"
            else
               ();
            app (fn tp => (write " "; write tp)) allTypes;
            write " -> stream (";
            write terminalName;
            app (fn tp => (write " "; write tp)) terminalTypes;
            write ") -> ";
            if monadic then
               write "monad "
            else
               ();
            write "(";
            write (Symbol.toValue (#2 (D.lookup nonterminals start)));
            write ", stream (";
            write terminalName;
            app (fn tp => (write " "; write tp)) terminalTypes;
            write "));\n";
            write "parse arg s = ";
            if monadic then
               ()
            else
               write "Data.Functor.Identity.runIdentity $ ";
            write "ParseEngine.parse (terminal, ParseEngine.next";
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
                         (fn (terminal, (Shift n :: _, _)) =>
                                Array.update (arr, D.lookup terminalOrdinals terminal, n+1)
                           | (terminal, (Reduce n :: _, _)) =>
                                (* When n = ~1, this is the accept action. *)
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

            write "\",\nArray.listArray (0, ";
            write (Int.toString (Vector.length rules - 1));
            write ") [";

            Vector.foldl
               (fn ((rulenum, _, lhs, rhs, args, solearg, action, _, _), first) =>
                   (
                   if first then
                      ()
                   else
                      write ",\n";
                   write "(";
                   write (Int.toString (D.lookup nonterminalOrdinals lhs));
                   write ",";
                   write (Int.toString (length rhs));
                   write ",(\\ (";

                   let
                      val len =
                         ListPair.foldrEq
                            (fn (_, NONE, n) =>
                                   (
                                   write "_:";
                                   n
                                   )
                              | (symbol, SOME _, n) =>
                                   let
                                      val tp =
                                         (case D.find nonterminals symbol of
                                             SOME (_, tp, _) => tp
                                           | NONE =>
                                                valOf (#1 (D.lookup terminals symbol)))
                                   in
                                      write "Value";
                                      write (Symbol.toValue tp);
                                      write "(arg";
                                      write (Int.toString n);
                                      write "):";
                                      n+1
                                   end)
                            0
                            (rhs, args)

                      val permutation = Array.array (len, ~1)
                   in
                      write "rest) -> Value";
                      write (Symbol.toValue (#2 (D.lookup nonterminals lhs)));
                      write "(";
                      write moduleName;
                      write ".";
                      write (Symbol.toValue action);
                      write " arg";

                      (* By construction, args is a complete, no-duplicate sequence from 1 to some n. *)
                      foldr
                         (fn (NONE, n) => n
                           | (SOME (Syntax.NumericLabel i), n) =>
                                (
                                Array.update (permutation, i-1, n);
                                n+1
                                )
                           | (SOME (Syntax.IdentLabel _), _) =>
                                (* Not allowed in Haskell. *)
                                raise (Fail "invariant"))
                         0
                         args;
                      
                      Array.app
                         (fn n =>
                             (
                             write " arg";
                             write (Int.toString n)
                             ))
                         permutation
                   end;

                   write "):rest))";
                   false
                   ))
               true
               rules;

            write "],\n(\\ (Value";
            write (Symbol.toValue (#2 (D.lookup nonterminals start)));
            write " x) -> x), ";

            if monadic then
               (
               write moduleName;
               write ".error arg"
               )
            else
               (
               write "return . ";
               write moduleName;
               write ".error arg"
               );
            write ") s;\n";

            write "}\n";
            TextIO.closeOut outs
         end

   end
