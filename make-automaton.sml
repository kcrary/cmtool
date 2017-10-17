
structure MakeAutomaton
   :> MAKE_AUTOMATON
   =
   struct

      type action = int * string


      structure D = SymbolDict

      (* Converts a 'a dict to an int array, with all missing entries filled with 0.
         Return any entry with key ~1 (representing eof-of-stream) separately.
      *)
      fun dictToArray symbolLimit f d =
          let
             val a = Array.array (symbolLimit, 0)

             val _ =
                SymbolDict.app
                (fn (symbol, x) =>
                       if symbol < 0 then
                          ()
                       else
                          Array.update (a, symbol, f x))
                d

             val minusone =
                (case SymbolDict.find d (~1) of
                    NONE => 
                       NONE
                  | SOME x =>
                       SOME (f x))
          in
             (a, minusone)
          end


      (* Put the final states at the front, put a sink state at 0,
         and move everything into arrays.
      *)
      fun rearrange symbolLimit armcount (count, initial, final, trans) =
          let
             val rcount = count+1

             val permutation = Array.array (rcount, ~1)
             (* ~1 means the state's new position has not been determined yet. *)

             val transArr = Array.fromList trans

             val utilization = Array.array (armcount+1, false)

             (* Place final-sink states (i.e., final states that only transition
                to the sink state) in the permutation.
             *)
             val (firstNonfinalsink, rfinalRev) =
                foldl
                (fn ((state, (armnumber, action)), (n, rfinalAcc)) =>
                       if D.isEmpty (Array.sub (transArr, state)) then
                          (* This is a final-sink state. *)
                          if Array.sub (permutation, state) = ~1 then
                             (
                             Array.update (utilization, armnumber, true);
                             Array.update (permutation, state, n);
                             (n+1, action :: rfinalAcc)
                             )
                          else
                             (* Final state appears multiple times, violating
                                the determinization postcondition.
                             *)
                             raise (Fail "invariant")
                       else
                          (* Not a final-sink state, handle in second pass. *)
                          (n, rfinalAcc))
                (1, [])
                final

             (* Place final states that are not final-sink states in the permutation. *)
             val (firstNonfinal, rfinalRev') =
                foldl
                (fn ((state, (armnumber, action)), (n, rfinalAcc)) =>
                       if D.isEmpty (Array.sub (transArr, state)) then
                          (* This is a final-sink state, handled in first pass. *)
                          (n, rfinalAcc)
                       else
                          (* Not a final-sink state. *)
                          if Array.sub (permutation, state) = ~1 then
                             (
                             Array.update (utilization, armnumber, true);
                             Array.update (permutation, state, n);
                             (n+1, action :: rfinalAcc)
                             )
                          else
                             (* Final state appears multiple times, violating
                                the determinization invariant.
                             *)
                             raise (Fail "invariant"))
                (firstNonfinalsink, rfinalRev)
                final
                
             (* Add non-final states to the permutation. *)
             val _ =
                foldl
                (fn (d, (state, n)) =>
                       if Array.sub (permutation, state) = ~1 then
                          (* Not in permutation already, so not a final state. *)
                          (
                          Array.update (permutation, state, n);
                          (state+1, n+1)
                          )
                       else
                          (* a final state *)
                          (state+1, n))
                (0, firstNonfinal)
                trans

             val rinitial =
                (case initial of
                    [] =>
                       0
                  | [(state, ())] => 
                       Array.sub (permutation, state)
                  | _ =>
                       (* There are multiple initial-state entries.  By construction,
                          there can be at most one initial state, so it appears multiple
                          times, violating the determinization postcondition.
                       *)
                       raise (Fail "invariant"))

             val rfinal = Array.fromList (rev rfinalRev')

             (* Initialize rtrans (an int array array) and rtransEos (an int array)
                with bogus arrays. *)
             val rtrans = Array.array (rcount, Array.array (0, 0))
             val rtransEos = Array.array (rcount, 0)

             (* Fill in the sink state, because it doesn't appear in trans. *)
             val () = Array.update (rtrans, 0, Array.array (symbolLimit, 0))

             val _ =
                foldl
                (fn (d, state) =>
                       let
                          val (rd, eos) = dictToArray symbolLimit (fn state => Array.sub (permutation, state)) d
                          val n = Array.sub (permutation, state)

                          val () =
                             if n = 0 then
                                (* Leave the sink state alone. *)
                                ()
                             else
                                (
                                Array.update (rtrans, n, rd);
                                (case eos of
                                    NONE => ()
                                  | SOME m =>
                                       Array.update (rtransEos, n, m))
                                )
                       in
                          state+1
                       end)
                0
                trans

             val inexhaustive =
                Array.sub (utilization, armcount)

             val () = Array.update (utilization, armcount, true)

             val redundancies =
                Array.foldli
                (fn (armnumber, used, redundancies) =>
                    if used then
                       redundancies
                    else
                       armnumber :: redundancies)
                []
                utilization

          in
             ((rcount, rinitial, firstNonfinalsink-1, firstNonfinal-1, rfinal, rtrans, rtransEos),
              redundancies, inexhaustive)
          end

      fun compareAction ((m, _), (n, _)) = Int.compare (m, n)

      fun makeAutomaton symbolLimit armcount res =
          let
             val res' = (Regexp.Epsilon, (armcount, "")) :: res  (* add error state *)
             val nfaRev = MakeNFA.makeRevNfa res'
             val dfaRev = Determinize.determinize compareAction (fn _ => EQUAL) nfaRev
             val nfa = ReverseDFA.reverseDfa dfaRev
             val dfa = Determinize.determinize (fn _ => EQUAL) compareAction nfa
             (* Brzozowski's Theorem:
                dfaRev is deterministic and accessible (by construction), so dfa is minimal.
             *)
          in
             rearrange symbolLimit armcount dfa
          end

   end
