
signature WRITE_AUTOMATA =
   sig

      val writeAutomata : TextIO.outstream -> (string * 'a * Automata.automaton) list -> unit

   end
