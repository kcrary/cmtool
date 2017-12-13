
structure SymbolSet = SplaySet (structure Elem = IntOrdered)
structure SymbolDict = SplayDict (structure Key = IntOrdered)
structure StringSet = SplaySet (structure Elem = StringOrdered)
structure StringDict = SplayDict (structure Key = StringOrdered)


structure Automata =
   struct

      type symbol = int
      type state = int

      type ('a, 'b) nfa = 
         (state * 'a) list  (* initial states *)
         *
         (state * 'b) list  (* final states *)
         *
         (state list SymbolDict.dict * state list) array
         
      type ('a, 'b) dfa =
         int                (* number of states *)
         *
         (state * 'a) list  (* initial states *)
         *
         (state * 'b) list  (* final states *)
         *
         state SymbolDict.dict list
 
      type automaton =
         int                (* total states *)
         *
         int                (* initial state *)
         *
         int                (* last final-sink state *)
         *
         int                (* last final state *)
         *
         string array       (* final states *)
         *
         int array array    (* transition function *)
         *
         int array          (* end-of-stream transition function *)

      type lexer =
         string StringDict.dict                         (* options *)
         *
         int                                            (* alphabet size *)
         *
         string list                                    (* type arguments, sorted *)
         *
         (string * string) list                         (* action arguments *)
         *
         (string * string * automaton) list             (* lexing functions *)

   end
