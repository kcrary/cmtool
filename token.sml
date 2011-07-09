
structure Token =
   struct

      datatype token =
         IDENT of string
       | NUMBER of int
       | STRING of int list
       | ALPHABET
       | AND
       | ANY
       | ARROW
       | COLON
       | EOS
       | EMPT
       | ENABLE
       | EPSILON
       | EQUAL
       | FUNCTION
       | LPAREN
       | MINUS
       | NAME
       | OR
       | PLUS
       | QUESTION
       | RANGE
       | REGEXP
       | RPAREN
       | SEQ
       | SET
       | STAR
       | TILDE

   end
