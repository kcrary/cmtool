
structure Token =
   struct

      type pos = int

      datatype token =
         IDENT of pos * string
       | NUMBER of pos * int
       | STRING of pos * int list
       | ALPHABET of pos
       | AND of pos
       | ANY of pos
       | ARROW of pos
       | COLON of pos
       | EOS of pos
       | EMPT of pos
       | ENABLE of pos
       | EPSILON of pos
       | EQUAL of pos
       | FUNCTION of pos
       | LPAREN of pos
       | MINUS of pos
       | NAME of pos
       | OR of pos
       | PLUS of pos
       | QUESTION of pos
       | RANGE of pos
       | REGEXP of pos
       | RPAREN of pos
       | SEQ of pos
       | SET of pos
       | STAR of pos
       | TILDE of pos

   end
