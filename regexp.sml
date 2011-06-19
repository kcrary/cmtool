
structure Regexp =
   struct

      datatype regexp =
         Set of SymbolSet.set
       | String of Automata.symbol list
       | Epsilon
       | Empty
       | Concat of regexp * regexp
       | Union of regexp * regexp
       | Option of regexp
       | Closure of regexp
       | Plus of regexp

   end
