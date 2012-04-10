
signature REVERSE_DFA =
   sig

      val reverseDfa : ('a, 'b) Automata.dfa -> ('b, 'a) Automata.nfa

   end
