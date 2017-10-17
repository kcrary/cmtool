
structure ParserHs =
   struct

      exception Error = LexerHs.Error

      open Syntax

      type pos = int

      fun lift x () = x
      fun identity x = x
      fun null () = []

      structure Arg =
         struct
            type int = int
            type string = string
            type symbol = Symbol.symbol

            val sole_uident = Symbol.fromValue
            val sole_lident = Symbol.fromValue

            val sole_number = identity
  
            type label = label
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
  
            type qident = string list
            fun sing_qident ident = [ident]
            fun cons_qident (h, t) = h :: "." :: t

            type directive = directive

            fun name_directive l = Option (Symbol.fromValue "name", String.concat l)
            fun data_directive str = Option (Symbol.fromValue "data", str)
            val monadic_directive = lift (Option (Symbol.fromValue "monadic", ""))

            fun terminal_directive (ident, prec) = Terminal (ident, NONE, prec)
            fun terminal_of_directive (ident, tp, prec) = Terminal (ident, SOME tp, prec)
            val nonterminal_directive = Nonterminal
            val start_directive = Start
            val follower_directive = Follower
  
            type directives = directive list
            val nil_directives = null
            val cons_directives = op ::
  
            datatype terminal = datatype TokenHs.token
  
            fun error s =
               (case Stream.front s of
                   Stream.Nil =>
                      (
                      print "Syntax error at end of file.\n";
                      Error
                      )
                 | Stream.Cons ((_, pos), _) =>
                      (
                      print "Syntax error at ";
                      print (Int.toString pos);
                      print ".\n";
                      Error
                      ))
         end

      structure StreamWithPos =
         CoercedStreamable (structure Streamable = StreamStreamable
                            type 'a item = 'a * pos
                            fun coerce (x, _) = x)

      structure ParseMain =
         ParseMainFunHs
         (structure Streamable = StreamWithPos
          structure Arg = Arg)

      fun parse s =
         #1 (ParseMain.parse (LexerHs.lex s))

   end
