
signature MAKE_NFA =
   sig

      (* makeRevNfa Rs

         then  (Q, q_init, Q_final, delta) is an nfa for rev(Rs)
               Q = { 0 .. count-1 }
               Q_init subset Q
               q_final in Q
               trans = [ delta(0) .. delta(count-1) ]
               and
               return (Q_init, q_final, trans)
      *)
      val makeRevNfa : (Regexp.regexp * 'a) list -> ('a, unit) Automata.nfa

   end
