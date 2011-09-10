
structure Parser
   :> PARSER
   =
   struct

      exception Error

      open Syntax

      type pos = int

      fun identity x = x
      fun lift x () = x

      structure Arg =
         struct
            type pos_string = pos * string
            type pos_int = pos * int
            type pos_intlist = pos * int list
            type pos = pos

            type string = string
            fun ident (_, str) = str

            type int = int
            fun number (_, n) = n

            type numpairs = (int * int) list
            fun nil_numpairs () = []
            fun cons_numpairs (first, last, tail) = (first, last) :: tail

            type charset = charset
            val ident_charset = Svar
            val number_charset = Ssymbol
            val range_charset = Srange
            val empty_charset = lift Sempty
            val union_charset = Sunion
            val intersect_charset = Sintersection
            val diff_charset = Sdifference
            val comp_charset = Scomplement
            val any_charset = lift Sany

            type charsets = charset list
            fun nil_charsets () = []
            val cons_charsets = op ::
            
            type regexp = regexp
            val ident_regexp = Var
            val number_regexp = Symbol
            fun string_regexp (_, str) = String str
            val any_regexp = lift Any
            val epsilon_regexp = lift Epsilon
            val empty_regexp = lift Empty
            val concat_regexp = Concat
            val seq_regexp = Concat
            val union_regexp = Union
            val option_regexp = Option
            val closure_regexp = Closure
            val plus_regexp = Plus
            fun equal_regexp {r, n} = Exactly (r, n)
            fun geq_regexp {r, n} = AtLeast (r, n)
            fun repeat_regexp {r, first, last} = Repeat (r, first, last)
            val eos_regexp = lift Eos

            type regexps = regexp list
            fun nil_regexps () = []
            val cons_regexps = op ::

            type arm = regexp * string
            fun sole_arm {r, action} = (r, action)

            type arms = arm list
            fun sing_arms arm = [arm]
            val cons_arms = op ::

            type directive = directive
            val name_directive = Name
            val enable_directive = Enable
            val alphabet_directive = Alphabet
            val regexp_directive = Regexp
            val set_directive = Set
            val function_directive = Function

            type directives = directive list
            fun nil_directives () = []
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
                              | STRING (pos, _) => pos
                              | ALPHABET pos => pos
                              | AND pos => pos
                              | ANY pos => pos
                              | ARROW pos => pos
                              | COLON pos => pos
                              | EOS pos => pos
                              | EMPT pos => pos
                              | ENABLE pos => pos
                              | EPSILON pos => pos
                              | EQUAL pos => pos
                              | FUNCTION pos => pos
                              | GEQ pos => pos
                              | LPAREN pos => pos
                              | MINUS pos => pos
                              | NAME pos => pos
                              | OR pos => pos
                              | PLUS pos => pos
                              | QUESTION pos => pos
                              | RANGE pos => pos
                              | REGEXP pos => pos
                              | REPEAT pos => pos
                              | RPAREN pos => pos
                              | SEQ pos => pos
                              | SET pos => pos
                              | STAR pos => pos
                              | TILDE pos => pos)
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
