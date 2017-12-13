
structure Token =
   struct

      datatype token =
         IDENT of string
       | NUMBER of int
       | STRING of int list
       | OPTION of string
       | ALPHABET
       | AND
       | ANY
       | ARROW
       | COLON
       | DOT
       | EOS
       | EMPT
       | EPSILON
       | EQUAL
       | FUNCTION
       | GEQ
       | LPAREN
       | MINUS
       | NAME
       | OR
       | PLUS
       | QUESTION
       | RANGE
       | REGEXP
       | REPEAT
       | RPAREN
       | SEQ
       | SET
       | STAR
       | TILDE

   end
