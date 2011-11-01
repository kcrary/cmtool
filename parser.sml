
structure Parser
   :> PARSER
   =
   struct

      exception Error = Lexer.Error

      open Syntax

      type pos = int

      fun identity x = x
      fun lift x () = x
      fun null () = []

      structure Arg =
         struct
            type string = string
            type int = int
            type intlist = int list

            type string = string
            val ident = identity

            type int = int
            val number = identity

            type numpairs = (int * int) list
            val nil_numpairs = null
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
            val nil_charsets = null
            val cons_charsets = op ::
            
            type regexp = regexp
            val ident_regexp = Var
            val number_regexp = Symbol
            val string_regexp = String
            val any_regexp = lift Any
            val epsilon_regexp = lift Epsilon
            val empty_regexp = lift Empty
            val concat_regexp = Concat
            val seq_regexp = Concat
            val union_regexp = Union
            val option_regexp = Optional
            val closure_regexp = Closure
            val plus_regexp = Plus
            val equal_regexp = Exactly
            val geq_regexp = AtLeast
            val repeat_regexp = Repeat
            val eos_regexp = lift Eos

            type regexps = regexp list
            val nil_regexps = null
            val cons_regexps = op ::

            type arm = regexp * string
            val sole_arm = identity

            type arms = arm list
            fun sing_arms arm = [arm]
            val cons_arms = op ::

            type directive = directive
            fun name_directive str = Option ("name", str)
            val alphabet_directive = Alphabet
            val regexp_directive = Regexp
            val set_directive = Set
            val function_directive = Function

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
         ParseMainFun
         (structure Streamable = StreamWithPos
          structure Arg = Arg)

      fun parse s =
         #1 (ParseMain.parse (Lexer.lex s))

   end
