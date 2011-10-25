
structure Token =
   struct

      datatype token =
         LIDENT of string
       | UIDENT of string
       | NUMBER of int
       | STRING of int list
       | ALPHABET
       | AND
       | ANY
       | ARROW
       | COLON
       | DOT
       | ENABLE
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
