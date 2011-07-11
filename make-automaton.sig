
signature MAKE_AUTOMATON =
   sig

      val makeAutomaton : Symbol.symbol 
                            -> (Symbol.symbol option * Automaton.precedence * bool ref) SymbolDict.dict
                            -> (int list * Symbol.symbol * bool ref) SymbolDict.dict 
                            -> Automaton.rule Vector.vector 
                            -> Automaton.automaton

   end
