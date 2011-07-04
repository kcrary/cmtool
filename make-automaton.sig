
signature MAKE_AUTOMATON =
   sig

      val makeAutomaton : Symbol.symbol 
                            -> (int list * Symbol.symbol) SymbolDict.dict 
                            -> Automaton.rule Vector.vector 
                            -> Automaton.automaton

   end
