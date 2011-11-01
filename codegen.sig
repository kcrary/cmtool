
signature CODEGEN =
   sig

      exception Error

      val writeProgram : string -> Automata.lexer -> unit

   end
