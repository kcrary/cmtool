
structure Parser =
   struct

      exception Error

      open Syntax

      type pos = int

      structure Arg =
         struct
            type pos_symbol = pos * Symbol.symbol
            type pos_int = pos * int
            type pos = pos

            type symbol = Symbol.symbol
            fun sole_ident {ident=(_, sym)} = sym

            type int = int
            fun sole_number {num=(_, n)} = n
  
            type constituent = constituent
            fun unlabeled_item {ident} = Unlabeled ident
            fun labeled_item {label, ident} = Labeled (label, ident)
            fun paren_item {constituent} = constituent
  
            type constituents = constituent list
            fun nil_constituents {} = []
            fun cons_constituents {head, tail} = head :: tail
  
            type precedence = precedence
            fun empty_precedence {} = EmptyPrec
            fun left_precedence {num} = PrecLeft num
            fun right_precedence {num} = PrecRight num
            fun no_precedence {} = PrecNone

            type production = production
            fun sole_production {constituents, action, prec} = (constituents, action, prec)

            type productions = production list
            fun nil_productions {} = []
            fun cons_productions {head, tail} = head :: tail
  
            type directive = directive
            fun name_directive {ident} = Name ident
            fun terminal_directive {ident, prec} = Terminal (ident, NONE, prec)
            fun terminal_of_directive {ident, tp, prec} = Terminal (ident, SOME tp, prec)
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
                              | NUMBER (pos, _) => pos
                              | ARROW pos => pos
                              | COLON pos => pos
                              | EQUAL pos => pos
                              | NAME pos => pos
                              | NONTERMINAL pos => pos
                              | LPAREN pos => pos
                              | NOPREC pos => pos
                              | OF pos => pos
                              | PRECL pos => pos
                              | PRECR pos => pos
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
