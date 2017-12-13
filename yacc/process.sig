
signature PROCESS =
   sig

      exception Error

      val process : Syntax.directive list -> Language.language * Automaton.parser

   end
