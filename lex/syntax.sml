
structure Syntax =
   struct

      datatype charset =
         Svar of string
       | Ssymbol of Automata.symbol
       | Srange of (Automata.symbol * Automata.symbol) list
       | Sempty
       | Sunion of charset list
       | Sintersection of charset list
       | Sdifference of charset * charset list
       | Scomplement of charset list
       | Sany

      datatype regexp =
         Var of string
       | Symbol of Automata.symbol
       | String of Automata.symbol list
       | Any
       | Epsilon
       | Empty
       | Concat of regexp list
       | Union of regexp list
       | Optional of regexp
       | Closure of regexp
       | Plus of regexp
       | Exactly of regexp * int
       | AtLeast of regexp * int
       | Repeat of regexp * int * int
       | Eos

      datatype directive =
         Option of string * string
       | Alphabet of int
       | Function of string * string * (regexp * string) list
       | Regexp of string * regexp
       | Set of string * charset

   end
