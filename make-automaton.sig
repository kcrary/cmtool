
signature MAKE_AUTOMATON =
   sig

      val makeAutomaton : Symbol.symbol 
                            -> (int list * Symbol.symbol * bool ref) SymbolDict.dict 
                            -> Automaton.rule Vector.vector 
                            -> Automaton.automaton

   end
