
structure Symbol = SymbolFun (structure Value = StringHashable)
structure SymbolOrdered = SymbolOrderedFun (structure Symbol = Symbol)
structure SymbolHashable = SymbolHashableFun (structure Symbol = Symbol)
structure SymbolDict = SplayDict (structure Key = SymbolOrdered)
structure SymbolSet = SplaySet (structure Elem = SymbolOrdered)

structure Automaton =
   struct

      type precedence = int option

      type rule =
         int                        (* rule number *)
         *
         int                        (* rule number within nonterminal *)
         *
         Symbol.symbol              (* lhs *)
         *
         Symbol.symbol list         (* rhs *)
         *
         Symbol.symbol option list  (* arguments *)
         *
         Symbol.symbol              (* action *)
         *
         precedence                 (* precedence *)
         *
         bool ref                   (* reduced? *)

      datatype action =
         Shift of int
       | Reduce of int

      type item =
         int                 (* rule number *)
         *
         int                 (* number of symbols read *)
         *
         Symbol.symbol list  (* remaining symbols *)

      datatype conflict =
         NoConflict
       | Resolved
       | Conflict

      type state =
         (action list * conflict) SymbolDict.dict  (* action table: each list nonempty, ordered in decreasing priority *)
         *
         int SymbolDict.dict                       (* goto table *)
         *
         (item * SymbolSet.set) list               (* LR(1) items *)

      type automaton =
         int                 (* total states *)
         *
         state list          (* states *)
         *
         rule Vector.vector  (* rules *)
         *
         Symbol.symbol       (* start symbol *)

      type parser =
         string                                                          (* functor name *)
         *
         SymbolSet.set                                                   (* type arguments *)
         *
         (Symbol.symbol option * precedence * bool ref) SymbolDict.dict  (* terminals *)
         *
         (int list * Symbol.symbol * bool ref) SymbolDict.dict           (* nonterminals *)
         *
         automaton                                                       (* the automaton *)

   end
