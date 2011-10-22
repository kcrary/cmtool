
structure Token =
   struct

      type pos = int

      datatype token =
         IDENT of pos * Symbol.symbol
       | NUMBER of pos * int
       | ARROW of pos
       | COLON of pos
       | EQUAL of pos
       | FOLLOWER of pos
       | NAME of pos
       | NONTERMINAL of pos
       | NOPREC of pos
       | LPAREN of pos
       | PRECL of pos
       | PRECR of pos
       | OF of pos
       | RPAREN of pos
       | START of pos
       | TERMINAL of pos

   end
