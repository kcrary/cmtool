
structure SymbolDict = ListDict (structure Key = SymbolOrdered)
structure SymbolSet = ListHashableSet (structure ElemOrdered = SymbolOrdered
                                       structure ElemHashable = SymbolHashable)

structure Automaton =
   struct

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

      datatype action =
         Shift of int
       | Reduce of int

      type item =
         int                 (* rule number *)
         *
         int                 (* number of symbols read *)
         *
         Symbol.symbol list  (* remaining symbols *)

      type state =
         action list SymbolDict.dict  (* action table: each list nonempty, ordered in decreasing priority *)
         *
         int SymbolDict.dict          (* goto table *)
         *
         (item * SymbolSet.set) list  (* LR(1) items *)

      type automaton =
         int                 (* total states *)
         *
         state list          (* states *)
         *
         rule Vector.vector  (* rules *)
         *
         Symbol.symbol       (* start symbol *)

      type parser =
         string                                       (* functor name *)
         *
         SymbolSet.set                                (* type arguments *)
         *
         Symbol.symbol option SymbolDict.dict         (* terminals *)
         *
         (int list * Symbol.symbol) SymbolDict.dict   (* nonterminals *)
         *
         automaton                                    (* the automaton *)

   end
