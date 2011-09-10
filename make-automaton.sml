
structure MakeAutomaton
   :> MAKE_AUTOMATON
   =
   struct

      structure S = SymbolSet
      structure D = SymbolDict
      type symbol = Symbol.symbol

      open Automaton

      structure ItemOrdered =
         struct
            type t = item

            fun eq ((rulenum1, read1, _):item, (rulenum2, read2, _)) =
               rulenum1 = rulenum2
               andalso
               read1 = read2

            fun compare ((rulenum1, read1, _), (rulenum2, read2, _)) =
               (case Int.compare (rulenum1, rulenum2) of
                   EQUAL =>
                      Int.compare (read1, read2)
                 | order => order)
         end

      structure ItemHashable =
         struct
            type t = item

            val eq = ItemOrdered.eq

            fun hash (rulenum, read, _) =
               JenkinsHash.hashInc (Word.fromInt rulenum) (Word.fromInt read)
         end

      structure ItemDict =
         SplayDict (structure Key = ItemOrdered)

      structure ItemListHashable =
         ListHashable (structure Elem = ItemHashable)

      structure ItemListTable =
         HashTable (structure Key = ItemListHashable)

      structure SymbolTable =
         HashTable (structure Key = SymbolHashable)



      type ctx = { nonterminals : (int list * symbol * bool ref) D.dict,
                   rules : rule Vector.vector,
                   nullableTable : bool SymbolTable.table,
                   firstTable : S.set SymbolTable.table }
      


      fun nullableMain (ctx as {nonterminals, rules, nullableTable, ...}:ctx) trail symbol =
         (case SymbolTable.find nullableTable symbol of
             SOME b => b
           | NONE =>
                not (S.member trail symbol)  (* don't loop *)
                andalso
                (case D.find nonterminals symbol of
                    NONE =>
                       (* terminal *)
                       false
                  | SOME (rulenums, _, _) =>
                       let
                          val trail' = S.insert trail symbol
                       in
                          List.exists
                          (fn rulenum =>
                              let
                                 val (_, _, _, rhs, _, _, _, _, _) = Vector.sub (rules, rulenum)
                              in
                                 List.all (nullableMain ctx trail') rhs
                              end)
                          rulenums
                       end))

      fun nullable (ctx as {nullableTable, ...}:ctx) symbol =
         (case SymbolTable.find nullableTable symbol of
             SOME b => b
           | NONE =>
                let
                   val b = nullableMain ctx S.empty symbol
                in
                   SymbolTable.insert nullableTable symbol b;
                   b
                end)



      fun firstMain (ctx as {nonterminals, rules, firstTable, ...}:ctx) trail symbol =
         if S.member trail symbol then
            S.empty  (* don't loop *)
         else
            (case SymbolTable.find firstTable symbol of
                SOME set => set
              | NONE =>
                   (case D.find nonterminals symbol of
                       NONE =>
                          (* terminal *)
                          S.singleton symbol
                     | SOME (rulenums, _, _) =>
                          let
                             val trail' = S.insert trail symbol
                          in
                             foldl
                             (fn (rulenum, acc) =>
                                 let
                                    val (_, _, _, rhs, _, _, _, _, _) = Vector.sub (rules, rulenum)
                                 in
                                    S.union
                                       acc
                                       (rhsFirstMain ctx trail' rhs)
                                 end)
                             S.empty
                             rulenums
                          end))
   
      and rhsFirstMain ctx trail rhs =
         (case rhs of
             [] =>
                S.empty
           | symbol :: rest =>
                if nullable ctx symbol then
                   S.union
                      (firstMain ctx trail symbol)
                      (rhsFirstMain ctx trail rest)
                else
                   firstMain ctx trail symbol)

      fun first (ctx as {firstTable, ...}:ctx) symbol =
         (case SymbolTable.find firstTable symbol of
             SOME set => set
           | NONE =>
                let
                   val set = firstMain ctx S.empty symbol
                in
                   SymbolTable.insert firstTable symbol set;
                   set
                end)
         
      fun rhsFirst ctx rhs lookahead =
         (case rhs of
             [] =>
                lookahead
           | symbol :: rest =>
                if nullable ctx symbol then
                   S.union
                      (first ctx symbol)
                      (rhsFirst ctx rest lookahead)
                else
                   first ctx symbol)

      

      fun closure (ctx as {nonterminals, rules, ...}:ctx) d =
         let
            val queue = IQueue.iqueue ()
            val () = app (IQueue.insert queue) (ItemDict.toList d)

            fun loop d =
               if IQueue.isEmpty queue then
                  d
               else
                  let
                     val ((_, _, remaining), lookahead) = IQueue.remove queue
                  in
                     (case remaining of
                         [] =>
                            loop d
                       | symbol :: following =>
                            (case D.find nonterminals symbol of
                                NONE =>
                                   (* terminal *)
                                   loop d
                              | SOME (rulenums, _, reachable) =>
                                   let
                                      val () = reachable := true

                                      val lookahead' =
                                         rhsFirst ctx following lookahead

                                      val d' =
                                         foldl
                                         (fn (rulenum, d) =>
                                             let
                                                val (_, _, _, rhs, _, _, _, _, _) = Vector.sub (rules, rulenum)
   
                                                val item = (rulenum, 0, rhs)
                                             in
                                                (case ItemDict.find d item of
                                                    NONE =>
                                                       (
                                                       IQueue.insert queue (item, lookahead');
                                                       ItemDict.insert d item lookahead'
                                                       )
                                                  | SOME lookaheadOld =>
                                                       if S.subset (lookahead', lookaheadOld) then
                                                          d
                                                       else
                                                          (* The LR(0) item is there, but it is needs additional lookahead so keep going. *)
                                                          let
                                                             val lookaheadNew = 
                                                                S.union lookahead' lookaheadOld
                                                          in
                                                             IQueue.insert queue (item, lookaheadNew);
                                                             ItemDict.insert d item lookaheadNew
                                                          end)
                                             end)
                                         d
                                         rulenums
                                   in
                                      loop d'
                                   end))
                  end
            
         in
            loop d
         end



      type prestate =
         int                     (* state number *)
         *
         int D.dict              (* transition table (ie, action/goto table without reduce actions) *)
         *
         S.set ItemDict.dict     (* LR(0) items, mapped to lookahead *)


         
      val shiftConflicts = ref false
      val reduceConflicts = ref false

      fun prestateToState terminals nonterminals rules (ref (_, trans, items)) =
         let
            val action =
               ItemDict.foldr
               (fn ((rulenum, _, remaining), lookahead, action) =>
                   (case remaining of
                       [] =>
                          S.foldl
                          (fn (symbol, action) =>
                              D.insertMerge action symbol
                              ([Reduce rulenum], NoConflict)
                              (fn (l, _) =>
                                  (
                                  reduceConflicts := true;
                                  (Reduce rulenum :: l, Conflict)
                                  )))
                          action
                          lookahead
                     | _ =>
                          action))
               D.empty
               items

            val (action', goto) =
               D.foldl
               (fn (symbol, statenum, (action, goto)) =>
                   if D.member nonterminals symbol then
                      (action,
                       D.insert goto symbol statenum)
                   else
                      (D.insertMerge action symbol
                          ([Shift statenum], NoConflict)
                          (fn (l, Conflict) =>
                                 (* We've seen a reduce-reduce conflict already, so don't bother using precedence. *)
                                 (
                                 shiftConflicts := true;
                                 (Shift statenum :: l, Conflict)
                                 )
                            | ([Reduce rulenum], NoConflict) =>
                                 let
                                    val (_, _, _, _, _, _, _, reducepreco, _) = Vector.sub (rules, rulenum)
                                    val (_, shiftpreco, _) = D.lookup terminals symbol
                                 in
                                    (case reducepreco of
                                        SOME reduceprec =>
                                           (case shiftpreco of
                                               SOME shiftprec =>
                                                  if reduceprec > shiftprec then
                                                     ([Reduce rulenum, Shift statenum], Resolved)
                                                  else if shiftprec > reduceprec then
                                                     ([Shift statenum, Reduce rulenum], Resolved)
                                                  else
                                                     (
                                                     shiftConflicts := true;
                                                     ([Shift statenum, Reduce rulenum], Conflict)
                                                     )
                                             | NONE =>
                                                     (
                                                     shiftConflicts := true;
                                                     ([Shift statenum, Reduce rulenum], Conflict)
                                                     ))
                                      | NONE =>
                                           (
                                           shiftConflicts := true;
                                           ([Shift statenum, Reduce rulenum], Conflict)
                                           ))
                                 end
                            | _ =>
                                 (* At most one shift action per state/terminal, so we can only be seeing reduce actions here,
                                    and no conflict means just one of them.
                                 *)
                                 raise (Fail "invariant")),
                       goto))
               (action, D.empty)
               trans

            val () =
               D.app
               (fn (_, (Reduce rulenum :: _, _)) =>
                      if rulenum = ~1 then
                         ()
                      else
                         let
                            val (_, _, _, _, _, _, _, _, reduced) = Vector.sub (rules, rulenum)
                         in
                            reduced := true
                         end
                 | _ => ())
               action'
         in
            (action', goto, ItemDict.toList items)
         end



      (* The lexer ensures that this identifier will not be in use. *)
      val finalSymbol = Symbol.fromValue "$"

      fun makeAutomaton start terminals nonterminals rules =
         let
            val nullableTable = SymbolTable.table 50
            val firstTable = SymbolTable.table 50
            val ctx =
               { nonterminals=nonterminals,
                 rules=rules,
                 nullableTable=nullableTable,
                 firstTable=firstTable }

            val initialDict =
               closure ctx (ItemDict.singleton (~1, 0, [start]) (S.singleton finalSymbol))
            val initialPrestate =
               ref (0, D.empty, initialDict)
            
            val stateCount = ref 1

            val stateTable : prestate ref ItemListTable.table = ItemListTable.table 200
            val () = ItemListTable.insert stateTable (ItemDict.domain initialDict) initialPrestate

            val queue = IQueue.iqueue ()
            val () = IQueue.insert queue initialPrestate

            val stateList : prestate ref list ref = ref [initialPrestate]

            fun getState d =
               let
                  val items = ItemDict.domain d
               in
                  (case ItemListTable.find stateTable items of
                      NONE =>
                         let
                            val statenum = !stateCount
                            val st = ref (statenum, D.empty, d)
                         in
                            stateCount := statenum + 1;
                            ItemListTable.insert stateTable items st;
                            IQueue.insert queue st;
                            stateList := st :: !stateList;
                            statenum
                         end
                    | SOME st =>
                         let
                            val (statenum, _, d') = !st

                            val added = ref false

                            val d'' =
                               ItemDict.union d d'
                               (fn (item as (rulenum, read, _), lookahead, lookahead') =>
                                   (
                                   if S.subset (lookahead, lookahead') then
                                      lookahead'
                                   else
                                      (
                                      added := true;
                                      S.union lookahead lookahead'
                                      )
                                   ))
                         in
                            if !added then
                               (
                               st := (statenum, D.empty, d'');
                               IQueue.insert queue st;
                               statenum
                               )
                            else
                               statenum
                         end)
               end

            fun loop n =
               if IQueue.isEmpty queue then
                  ()
               else
                  let
                     val st = IQueue.remove queue
                     val (rulenum, _, d) = !st

                     val pretrans =
                        ItemDict.foldl
                        (fn ((rulenum, read, remaining), lookahead, pretrans) =>
                            (case remaining of
                                [] =>
                                   pretrans
                              | symbol :: following =>
                                   D.insertMerge pretrans symbol
                                   (ItemDict.singleton (rulenum, read+1, following) lookahead)
                                   (fn d' =>
                                       ItemDict.insert d' (rulenum, read+1, following) lookahead)))
                        D.empty
                        d

                     val trans =
                        D.map (fn d' => getState (closure ctx d')) pretrans

                     val (_, _, d) = !st  (* lookahead might have changed *)
                  in
                     st := (rulenum, trans, d);
                     loop ()
                  end

            val () = loop ()

            val () = shiftConflicts := false
            val () = reduceConflicts := false
            val states = map (prestateToState terminals nonterminals rules) (rev (!stateList))

            val () =
               if !reduceConflicts then
                  print "Warning: reduce-reduce conflicts.\n"
               else
                  ()

            val () =
               if !shiftConflicts then
                  (
                  print "Warning: shift-reduce conflicts.\n"
                  )
               else
                  ()

            val () =
               Vector.app
               (fn (_, localnum, lhs, _, _, _, _, _, reduced) =>
                   if !reduced then
                      ()
                   else
                      (
                      print "Warning: rule ";
                      print (Int.toString localnum);
                      print " of nonterminal ";
                      print (Symbol.toValue lhs);
                      print " is never reduced.\n"
                      ))
               rules

            val () =
               D.app
               (fn (nonterminal, (_, _, reachable)) =>
                   if !reachable then
                      ()
                   else
                      (
                      print "Warning: nonterminal ";
                      print (Symbol.toValue nonterminal);
                      print " is unreachable.\n"
                      ))
               nonterminals
               
         in
            (!stateCount, states, rules, start)
         end

   end
