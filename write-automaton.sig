
signature WRITE_AUTOMATON =
   sig

      val writeAutomaton : TextIO.outstream -> Automaton.automaton -> unit

   end
