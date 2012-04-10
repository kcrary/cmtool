
structure Token =
   struct

      type pos = int

      datatype token =
         IDENT of string
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
