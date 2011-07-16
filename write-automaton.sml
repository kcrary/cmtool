
structure WriteAutomaton
   :> WRITE_AUTOMATON
   =
   struct

      structure D = SymbolDict
      structure S = SymbolSet

      structure T =
         HashTable
         (structure Key = SetHashable (structure Set = S
                                       structure Elem = SymbolHashable))

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

      type ctx = { outs : TextIO.outstream,
                   rules : rule Vector.vector,
                   start : Symbol.symbol,
                   lookaheadCount : int ref,
                   lookaheadList : S.set list ref,
                   lookaheadTable : int T.table }

      fun lookaheadNumber ({lookaheadCount, lookaheadList, lookaheadTable, ...}:ctx) set =
         T.lookupOrInsert lookaheadTable set
         (fn () =>
             let
                val n = !lookaheadCount
             in
                lookaheadCount := n + 1;
                lookaheadList := set :: !lookaheadList;
                n
             end)

      fun writeItem (ctx as {outs, rules, start, ...}:ctx) ((rulenum, read, remaining), lookahead) =
         let
            fun write str = TextIO.output (outs, str)
   
            val (lhs, rhs) =
               if rulenum = ~1 then
                  ("start", [start])
               else
                  let
                     val (_, _, lhs, rhs, _, _, _, _) = Vector.sub (rules, rulenum)
                  in
                     (Symbol.toString lhs, rhs)
                  end
            
            fun loop n l =
               if n = 0 then
                  ()
               else
                  (case l of
                      [] =>
                         raise (Fail "invariant")
                    | symbol :: rest =>
                         (
                         write (Symbol.toString symbol);
                         write " ";
                         loop (n-1) rest
                         ))
         in
            if rulenum <> ~1 then
               (
               write (Int.toString rulenum);
               write " : "
               )
            else
               ();
            write lhs;
            write " -> ";
            loop read rhs;
            write ". ";
            app (fn symbol => (write (Symbol.toString symbol); write " ")) remaining;
            write " / ";
            write (Int.toString (lookaheadNumber ctx lookahead));
            write "\n"
         end

      fun writeState (ctx as {outs, ...}:ctx) statenum (action, goto, items) =
         let
            fun write str = TextIO.output (outs, str)
         in
            write "State ";
            write (Int.toString statenum);
            write ":\n\n";

            app (writeItem ctx) items;
            write "\n";

            D.app
               (fn (symbol, (actions, conflict)) =>
                   (
                   write (Symbol.toString symbol);
                   write " => ";
                   appSeparated
                      (fn Shift n =>
                             (
                             write "shift ";
                             write (Int.toString n)
                             )
                        | Reduce (~1) =>
                             write "accept"
                        | Reduce n =>
                             (
                             write "reduce ";
                             write (Int.toString n)
                             ))
                      (fn () => write ", ")
                      actions;
                   (case conflict of
                       NoConflict =>
                          ()
                     | Resolved =>
                          write "  PRECEDENCE"
                     | Conflict =>
                          write "  CONFLICT");
                   write "\n"
                   ))
               action;

            D.app
               (fn (symbol, n) =>
                   (
                   write (Symbol.toString symbol);
                   write " => goto ";
                   write (Int.toString n);
                   write "\n"
                   ))
               goto;

            write "\n-----\n\n"
         end

      fun writeAutomaton outs (_, states, rules, start) =
         let
            fun write str = TextIO.output (outs, str)

            val lookaheadList = ref []

            val ctx =
               { outs=outs,
                 rules=rules,
                 start=start,
                 lookaheadCount=ref 0,
                 lookaheadList=lookaheadList,
                 lookaheadTable=T.table 40 }

            val _ =
               foldl
               (fn (state, statenum) =>
                   (
                   writeState ctx statenum state;
                   statenum+1
                   ))
               0
               states

            val _ =
               foldr
               (fn (set, setnum) =>
                   (
                   write "lookahead ";
                   write (Int.toString setnum);
                   write " = ";
                   S.app (fn symbol => (write (Symbol.toString symbol); write " ")) set;
                   write "\n";
                   setnum+1
                   ))
               0
               (!lookaheadList)
                   
         in
            ()
         end

   end
