
structure ReverseDFA
   :> REVERSE_DFA
   =
   struct

      structure D = SymbolDict


      fun reverseDfa (count, initial, final, trans) =
          let
             val rtrans = Array.array (count, (D.empty, []))

             fun loop state trans =
                 (case trans of
                     [] =>
                        ()
                   | d :: rest =>
                        let
                           val () = 
                              D.app
                              (fn (symbol, state') =>
                                     (* Automaton transitions from state to state' on symbol. *)
                                     let
                                        val (rd, rde) = Array.sub (rtrans, state')
                                        (* In fact, rde = [], but we won't rely on that. *)

                                        val rd' =
                                           D.insertMerge rd symbol [state] (fn states => state :: states)
                                     in
                                        Array.update (rtrans, state', (rd', rde))
                                     end)
                              d
                        in
                           loop (state+1) rest
                        end)
                 
             val () = loop 0 trans
                
          in
             (final, initial, rtrans)
          end

   end
