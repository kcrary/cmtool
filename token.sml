
structure Token =
   struct

      datatype token =
         Ident of Symbol.symbol
       | Arrow
       | Colon
       | Eos
       | Equal
       | Name
       | Nonterminal
       | LParen
       | Of
       | RParen
       | Start
       | Terminal

   end
