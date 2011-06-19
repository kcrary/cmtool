
signature CODEGEN =
   sig

      type lexer =
         string                                         (* functor name *)
         *
         int                                            (* alphabet size *)
         *
         string list                                    (* type arguments *)
         *
         (string * string) list                         (* action arguments *)
         *
         (string * (string * Automata.automaton)) list  (* lexing functions *)

      val writeProgram : string -> lexer -> unit

   end
