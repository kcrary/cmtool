
signature CODEGEN =
   sig

      exception Error

      val writeProgram : string -> Automaton.parser -> unit

   end
