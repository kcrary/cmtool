
structure Determinize
   :> DETERMINIZE
   =
   struct

      structure Set =
         ListHashableSet
         (structure ElemOrdered = IntOrdered
          structure ElemHashable = IntHashable)

      structure Table =
         HashTable (structure Key = Set.Hashable)

      structure StateDict =
         ListDict (structure Key = IntOrdered)

      structure S = Set
      structure T = Table
      structure Q = IQueue
      structure D = SymbolDict
      structure SD = StateDict


      fun coalesceMain f key acc l =
          (case l of
              [] =>
                 (* Don't bother to reverse acc since Mergesort.sort isn't stable anyway. *)
                 [(acc, key)]
            | (item, key') :: rest =>
                 (case f (key, key') of
                     EQUAL =>
                        coalesceMain f key (item::acc) rest
                   | _ =>
                        (* Don't bother to reverse acc since Mergesort.sort isn't stable anyway. *)
                        (acc, key) :: coalesceMain f key' [item] rest))

      fun coalesce f l =
          (case Mergesort.sort (fn ((_, key), (_, key')) => f (key, key')) l of
              [] =>
                 []
            | (item, key) :: rest =>
                 coalesceMain f key [item] rest)


      (* findBest' f curr l

         if    f is transitive
         then  x in l union {curr}
               for all y in l union {curr} . x <= y
               and
               return x
      *)
      fun findBest' priority curr l =
          (case l of
              [] =>
                 curr
            | x :: rest =>
                 (case priority (curr, x) of
                     GREATER =>
                        findBest' priority x rest
                   | _ =>
                        findBest' priority curr rest))

      (* findBest f l

         if    f is transitive
               l is not nil
         then  x in l
               for all y in l . x <= y
               and
               return x
      *)
      fun findBest priority l =
          (case l of
              [] =>
                 (* l cannot be empty *)
                 raise (Fail "invariant")
            | x :: rest =>
                 findBest' priority x rest)


      fun epsilonClose trans set state =
          if S.member set state then
             set
          else
             let
                val (_, nexts) = Array.sub (trans, state)
                val set' = S.insert set state
             in
                epsilonCloseList trans set' nexts
             end

      and epsilonCloseList trans set states =
          foldl (fn (state', set') => epsilonClose trans set' state') set states


      (* To avoid confusion, we refer to states in the resulting machine as rstates. *)
      type rstate = int

      fun determinize ipriority fpriority (initial, final, trans) =
          let
             (* Initialize the table with 4 times the number of buckets as the
                the number of states in the input NFA.  This number may require
                some tuning.
             *)
             val factor = 4

             val table : Automata.state T.table = T.table (factor * Array.length trans)
             val rstateCountRef = ref 0
             val queue = Q.iqueue ()

             fun setToRstate set =
                 let
                    val rstateCandidate = !rstateCountRef
                 in
                    (case T.lookupOrInsert table set rstateCandidate of
                        NONE =>
                           (* new rstate *)
                           let
                              val () = rstateCountRef := rstateCandidate + 1
                              val () = Q.insert queue set
                           in
                              rstateCandidate
                           end
                      | SOME rstate =>
                           rstate)
                 end

             val rinitial =
                map (fn (states, action) =>
                           let
                              val set = epsilonCloseList trans S.empty states
                              val rstate = setToRstate set
                           in
                              (rstate, action)
                           end)
                (coalesce ipriority initial)

             fun loop transAcc =
                 if Q.isEmpty queue then
                    rev transAcc
                 else
                    let
                       val set = Q.remove queue

                       val rd =
                          S.foldl
                          (fn (state, rdAcc) => 
                                 let
                                    (* Symbol transitions (as a state list dict) *)
                                    val (d, _) =
                                       Array.sub (trans, state)

                                    (* Epsilon closure of the symbol transitions (as a set dict). *)
                                    val d' = 
                                       D.map (fn l => epsilonCloseList trans S.empty l) d
                                 in
                                    (* Epsilon closure of the symbol transitions, merged into the accumulator. *)
                                    D.union d' rdAcc
                                    (fn (_, set, set') => S.union set set')
                                 end)
                          D.empty
                          set

                       val rd' =
                          D.map (fn set => setToRstate set) rd
                    in
                       loop (rd' :: transAcc)
                    end

             val trans = loop []

             fun betterAction action1 action2 =
                (case fpriority (action1, action2) of
                    GREATER =>
                       action2
                  | _ =>
                       action1)

             val (finalset, finaldict) =
                foldl
                (fn ((state, action), (set, dict)) => 
                       (S.insert set state,
                        SD.insertMerge dict state action (betterAction action)))
                (S.empty, SD.empty)
                final

             val rfinal =
                T.fold
                (fn (set, rstate, acc) =>
                       let
                          val iset = S.intersection finalset set
                       in
                          if S.isEmpty iset then
                             acc
                          else
                             let
                                val actions =
                                   S.foldl
                                   (fn (state, actions) => SD.lookup finaldict state :: actions)
                                   []
                                   iset

                                val action =
                                   findBest fpriority actions
                             in
                                (rstate, action) :: acc
                             end
                       end)
                []
                table

          in
             (!rstateCountRef, rinitial, rfinal, trans)
          end

   end
