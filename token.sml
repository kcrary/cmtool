
structure Token =
   struct

      datatype token =
         Ident of Symbol.symbol
       | Arrow
       | Colon
       | Equal
       | Name
       | Nonterminal
       | LParen
       | Of
       | RParen
       | Start
       | Terminal

   end
