
signature MAKE_AUTOMATON =
   sig

      type action = int * string

      (* makeAutomaton alphabet-size Rs

         then  (Q, q_init, Q_final, delta) is a dfa for Rs
               Q = { 0 .. count-1 }
               q_init in Q
               Q_final = { 1 .. lastfinal }
               0 is a sink state (ie, delta(0) is empty)
               trans = [ a_0 .. a_count-1 ]
               for i = 0 .. count-1 . a_i = [ delta(i, 0) .. delta(i, charLimit-1) ]
               finals = [ action(1) .. action(lastfinal) ]
               NB: finals is missing entry 0
               and
               return (count, q_init, lastfinal, finals, trans)
      *)
      val makeAutomaton : int -> (Regexp.regexp * action) list -> Automata.automaton

   end
