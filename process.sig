
signature PROCESS =
   sig

      exception Error

      val process : Syntax.directive list -> Automata.lexer

   end
