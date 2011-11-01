
structure Token =
   struct

      type pos = int

      datatype token =
         LIDENT of string
       | UIDENT of string
       | NUMBER of int
       | ARROW 
       | COLON 
       | DATA
       | DOT
       | EQUAL 
       | FOLLOWER 
       | MONADIC
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
