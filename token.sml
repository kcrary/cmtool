
structure Token =
   struct

      datatype token =
         Ident of string
       | Number of int
       | String of int list
       | Alphabet
       | And
       | Any
       | Arrow
       | Colon
       | Eos
       | Empt
       | Epsilon
       | Equal
       | Function
       | LParen
       | Minus
       | Name
       | Or
       | Plus
       | Question
       | Range
       | Regexp
       | RParen
       | Seq
       | Set
       | Star
       | Tilde

   end
