
structure Symbol = SymbolFun (structure Value = StringHashable)

structure Syntax =
   struct

      type symbol = Symbol.symbol

      datatype label =
         IdentLabel of symbol
       | NumericLabel of int  (* nonnegative (zero is illegal too, but that's not enforced by the parser) *)

      datatype constituent =
         Unlabeled of symbol
       | Labeled of label * symbol

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
       | Follower of symbol

   end
