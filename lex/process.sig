
signature PROCESS =
   sig

      exception Error

      val process : Syntax.directive list -> Language.language * Automata.lexer

   end
