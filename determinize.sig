
signature DETERMINIZE =
   sig

      (* determinize f g NFA

         if    f, g are transitive
         then  DFA accepts the same language as NFA
               no initial or final state appears multiple times in DFA
               and
               return DFA
      *)
      val determinize : ('a * 'a -> order) -> ('b * 'b -> order) -> ('a, 'b) Automata.nfa -> ('a, 'b) Automata.dfa

   end
