
signature MAKE_AUTOMATON =
   sig

      val makeAutomaton : Symbol.symbol                                                                    (* start symbol *)
                            -> (Symbol.symbol option * Automaton.precedence * bool ref) SymbolDict.dict    (* terminals *)
                            -> (int list * Symbol.symbol * bool ref) SymbolDict.dict                       (* nonterminals *)
                            -> SymbolSet.set                                                               (* parse followers *)
                            -> Automaton.rule Vector.vector                                                (* rules *)
                            -> Automaton.automaton

   end
