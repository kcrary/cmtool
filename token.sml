
structure Token =
   struct

      type pos = int

      datatype token =
         IDENT of pos * Symbol.symbol
       | ARROW of pos
       | COLON of pos
       | EQUAL of pos
       | NAME of pos
       | NONTERMINAL of pos
       | LPAREN of pos
       | OF of pos
       | RPAREN of pos
       | START of pos
       | TERMINAL of pos

   end
