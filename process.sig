
signature PROCESS =
   sig

      exception Error

      val process : Syntax.directive list -> Automaton.parser

   end
