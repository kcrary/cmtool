
structure Token =
   struct

      type pos = int

      datatype token =
         IDENT of Symbol.symbol
       | NUMBER of int
       | ARROW 
       | COLON 
       | EQUAL 
       | FOLLOWER 
       | NAME 
       | NONTERMINAL 
       | NOPREC 
       | LPAREN 
       | PRECL 
       | PRECR 
       | OF 
       | RPAREN 
       | START 
       | TERMINAL 

   end
