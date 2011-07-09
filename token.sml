
structure Token =
   struct

      datatype token =
         IDENT of Symbol.symbol
       | ARROW
       | COLON
       | EQUAL
       | NAME
       | NONTERMINAL
       | LPAREN
       | OF
       | RPAREN
       | START
       | TERMINAL

   end
