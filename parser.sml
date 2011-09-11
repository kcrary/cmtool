
structure Parser =
   struct

      exception Error

      open Syntax

      type pos = int

      fun lift x () = x
      fun identity x = x
      fun null () = []

      structure Arg =
         struct
            type pos_symbol = pos * Symbol.symbol
            type pos_int = pos * int
            type pos = pos

            type symbol = Symbol.symbol
            fun sole_ident (_, sym) = sym

            type int = int
            fun sole_number (_, n) = n
  
            type label = label
            val ident_label = IdentLabel
            val number_label = NumericLabel

            type constituent = constituent
            val unlabeled_item = Unlabeled
            val labeled_item = Labeled
            val paren_item = identity
  
            type constituents = constituent list
            val nil_constituents = null
            val cons_constituents = op ::
  
            type precedence = precedence
            val empty_precedence = lift EmptyPrec
            val left_precedence = PrecLeft
            val right_precedence = PrecRight
            val no_precedence = lift PrecNone

            type production = production
            fun sole_production (constituents, action, prec) = (constituents, action, prec)

            type productions = production list
            val nil_productions = null
            val cons_productions = op ::
  
            type directive = directive
            val name_directive = Name
            fun terminal_directive (ident, prec) = Terminal (ident, NONE, prec)
            fun terminal_of_directive (ident, tp, prec) = Terminal (ident, SOME tp, prec)
            val nonterminal_directive = Nonterminal
            val start_directive = Start
  
            type directives = directive list
            val nil_directives = null
            val cons_directives = op ::
  
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
