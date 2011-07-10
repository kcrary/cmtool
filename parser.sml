
structure Parser =
   struct

      exception Error

      open Syntax

      type pos = int

      structure Arg =
         struct
            type pos_symbol = pos * Symbol.symbol
            type pos = pos

            type ident = Symbol.symbol
            fun ident {ident=(_, sym)} = sym
  
            type constituent = constituent
            fun unlabeled_item {ident} = Unlabeled ident
            fun labeled_item {label, ident} = Labeled (label, ident)
            fun paren_item {constituent} = constituent
  
            type constituents = constituent list
            fun nil_constituents {} = []
            fun cons_constituents {head, tail} = head :: tail
  
            type productions = production list
            fun nil_productions {} = []
            fun cons_productions {constituents, action, tail} = (constituents, action) :: tail
  
            type directive = directive
            fun name_directive {ident} = Name ident
            fun terminal_directive {ident} = Terminal (ident, NONE)
            fun terminalOf_directive {ident, tp} = Terminal (ident, SOME tp)
            fun nonterminal_directive {ident, tp, arms} = Nonterminal (ident, tp, arms)
            fun start_directive {ident} = Start ident
  
            type directives = directive list
            fun nil_directives {} = []
            fun cons_directives {head, tail} = head :: tail
  
            datatype terminal = datatype Token.token
  
            fun error s =
               (case Stream.front s of
                   Stream.Nil =>
                      (
                      print "Syntax error at end of file.\n";
                      Error
                      )
                 | Stream.Cons (h, _) =>
                      let
                         val pos =
                            (case h of
                                IDENT (pos, _) => pos
                              | ARROW pos => pos
                              | COLON pos => pos
                              | EQUAL pos => pos
                              | NAME pos => pos
                              | NONTERMINAL pos => pos
                              | LPAREN pos => pos
                              | OF pos => pos
                              | RPAREN pos => pos
                              | START pos => pos
                              | TERMINAL pos => pos)
                         in
                            print "Syntax error at ";
                            print (Int.toString pos);
                            print ".\n";
                            Error
                         end)
         end

      structure ParseMain =
         ParseMainFun
         (structure Streamable = StreamStreamable
          structure Arg = Arg)

      fun parse s =
         #1 (ParseMain.parse (Lexer.lex s))

   end
