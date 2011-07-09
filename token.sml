
structure Token =
   struct

      datatype token =
         IDENT of int * Symbol.symbol
       | ARROW of int
       | COLON of int
       | EQUAL of int
       | NAME of int
       | NONTERMINAL of int
       | LPAREN of int
       | OF of int
       | RPAREN of int
       | START of int
       | TERMINAL of int

   end
