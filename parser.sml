
structure Parser
   :> PARSER
   =
   struct

      exception Error

      open Syntax

      structure Arg =
         struct
            type string = string
            type int = int
            type intlist = int list

            type numpairs = (int * int) list
            fun nil_numpairs {} = []
            fun cons_numpairs {first, last, tail} = (first, last) :: tail

            type charset = charset
            fun ident_charset {ident} = Svar ident
            fun number_charset {num} = Ssymbol num
            fun range_charset {l} = Srange l
            fun empty_charset {} = Sempty
            fun union_charset {l} = Sunion l
            fun intersect_charset {l} = Sintersection l
            fun diff_charset {head, l} = Sdifference (head, l)
            fun comp_charset {l} = Scomplement l
            fun any_charset {} = Sany

            type charsets = charset list
            fun nil_charsets {} = []
            fun cons_charsets {head, tail} = head :: tail
            
            type regexp = regexp
            fun ident_regexp {ident} = Var ident
            fun number_regexp {num} = Symbol num
            fun string_regexp {str} = String str
            fun any_regexp {} = Any
            fun epsilon_regexp {} = Epsilon
            fun empty_regexp {} = Empty
            fun concat_regexp {l} = Concat l
            val seq_regexp = concat_regexp
            fun union_regexp {l} = Union l
            fun option_regexp {r} = Option r
            fun closure_regexp {r} = Closure r
            fun plus_regexp {r} = Plus r
            fun eos_regexp {} = Eos

            type regexps = regexp list
            fun nil_regexps {} = []
            fun cons_regexps {head, tail} = head :: tail

            type arm = regexp * string
            fun arm {r, action} = (r, action)

            type arms = arm list
            fun sing_arms {arm} = [arm]
            fun cons_arms {head, tail} = head :: tail

            type directive = directive
            fun name_directive {ident} = Name ident
            fun enable_directive {ident} = Enable ident
            fun alphabet_directive {num} = Alphabet num
            fun regexp_directive {ident, r} = Regexp (ident, r)
            fun set_directive {ident, s} = Set (ident, s)
            fun function_directive {ident, tp, arms} = Function (ident, tp, arms)

            type directives = directive list
            fun nil_directives {} = []
            fun cons_directives {head, tail} = head :: tail

            datatype terminal = datatype Token.token

            fun error s = Error
         end

      structure ParseMain =
         ParseMainFun
         (structure Streamable = StreamStreamable
          structure Arg = Arg)

      fun parse s =
         #1 (ParseMain.parse (Lexer.lex s))

   end
