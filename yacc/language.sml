
structure Language :> LANGUAGE =
   struct

      datatype language = SML | HASKELL | OCAML

      fun toString l =
         (case l of
             SML => "SML"
           | HASKELL => "Haskell"
           | OCAML => "OCaml")

      fun extension l =
         (case l of
             SML => "sml"
           | HASKELL => "hs"
           | OCAML => "ml")


      structure Table =
         HashTable (structure Key = StringHashable)

      val reservedSmlTable : unit Table.table = Table.table 60
      val reservedHaskellTable : unit Table.table = Table.table 60
      val reservedOcamlTable : unit Table.table = Table.table 60

      (* In principle we ought to fill these tables lazily, since we'll never need both,
         but it doesn't seem worth the trouble.
      *)

      val reservedSmlList =
         List.app
         (fn str => Table.insert reservedSmlTable str ())
         [
         "abstype",
         "andalso",
         "as",
         "case",
         "datatype",
         "do",
         "else",
         "end",
         "exception",
         "fn",
         "fun",
         "functor",
         "handle",
         "if",
         "in",
         "infix",
         "infixr",
         "include",
         "let",
         "local",
         "nonfix",
         "of",
         "op",
         "open",
         "orelse",
         "raise",
         "sharing",
         "sig",
         "signature",
         "struct",
         "structure",
         "then",
         "type",
         "val",
         "where",
         "while",
         "withtype",

         "before",
         "div",
         "mod",
         "o",

         "true",
         "false",
         "nil",
         "ref",

         "error",
         "exn"
         ]

      val reservedHaskellList =
         List.app
         (fn str => Table.insert reservedHaskellTable str ())
         [
         "case",
         "class",
         "data",
         "default",
         "deriving",
         "do",
         "else",
         "foreign",
         "if",
         "import",
         "in",
         "infix",
         "infixl",
         "infixr",
         "instance",
         "let",
         "module",
         "newtype",
         "of",
         "then",
         "type",
         "where",

         "error",
         "monad",
         "stream",
         "parse",
         "Prelude",
         "Arg"
         ]

      val () =
         List.app
         (fn str => Table.insert reservedOcamlTable str ())
         [
         "and",
         "as",
         "assert",
         "asr",
         "begin",
         "class",
         "constraint",
         "do",
         "done",
         "downto",
         "else",
         "end",
         "exception",
         "external",
         "false",
         "for",
         "fun",
         "function",
         "functor",
         "if",
         "in",
         "include",
         "inherit",
         "initializer",
         "land",
         "lazy",
         "let",
         "lor",
         "lsl",
         "lsr",
         "lxor",
         "match",
         "method",
         "mod",
         "module",
         "mutable",
         "new",
         "nonrec",
         "object",
         "of",
         "open",
         "or",
         "private",
         "rec",
         "sig",
         "struct",
         "then",
         "to",
         "true",
         "try",
         "type",
         "val",
         "virtual",
         "when",
         "while",
         "with",

         "true",
         "false",
         "nil",
         "ref",

         "error",
         "exn"
         ]



      fun reservedSml str = Table.member reservedSmlTable str
      fun reservedHaskell str = Table.member reservedHaskellTable str
      fun reservedOcaml str = Table.member reservedOcamlTable str

      fun reserved lang str =
         (case lang of
             SML => reservedSml str
           | HASKELL => reservedHaskell str
           | OCAML => reservedOcaml str)      

      fun legalLongid lang longid =
         (case lang of
             SML =>
                (case longid of
                    [str] =>
                       not (reservedSml str)
                  | _ => false)

           | HASKELL =>
                not (null longid)
                andalso
                List.all
                   (fn str =>
                       size str >= 1 
                       andalso 
                       Char.isUpper (String.sub (str, 0))
                       andalso
                       not (reservedHaskell str))
                   longid

           | OCAML =>
                (case longid of
                    [str] =>
                       size str >= 1
                       andalso
                       Char.isUpper (String.sub (str, 0))
                       andalso
                       not (reservedOcaml str)
                  | _ => false))

      fun legalConstructor lang id =
         (case lang of
             SML => true

           | HASKELL =>
                size id >= 1
                andalso
                Char.isUpper (String.sub (id, 0))

           | OCAML =>
                size id >= 1
                andalso
                Char.isUpper (String.sub (id, 0)))

   end