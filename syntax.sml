
structure Syntax =
   struct

      type symbol = Symbol.symbol

      datatype constituent =
         Unlabeled of symbol
       | Labeled of symbol * symbol  (* (label, symbol) *)

      type production = constituent list * symbol

      datatype directive =
         Name of symbol
       | Start of symbol
       | Terminal of symbol * symbol option
       | Nonterminal of symbol * symbol * production list

   end
