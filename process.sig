
signature PROCESS =
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

      val process : Syntax.directive list -> lexer

   end
