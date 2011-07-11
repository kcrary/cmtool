
structure Syntax =
   struct

      type symbol = Symbol.symbol

      datatype constituent =
         Unlabeled of symbol
       | Labeled of symbol * symbol  (* (label, symbol) *)

      datatype precedence =
         EmptyPrec
       | PrecNone
       | PrecLeft of int
       | PrecRight of int

      type production = constituent list * symbol * precedence

      datatype directive =
         Name of symbol
       | Start of symbol
       | Terminal of symbol * symbol option * precedence
       | Nonterminal of symbol * symbol * production list

   end
