
structure Lexer
   :> LEXER 
   =
   struct

      open Token

      structure Table =
         HashTable (structure Key = StringHashable)
         
      val keywords : token option Table.table = Table.table 60

      (* Illegal identifiers (most are SML reserved words). *)
      val () =
         List.app
         (fn str => Table.insert keywords str NONE)
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
         "op",
         "open",
         "ord",
         "orelse",
         "raise",
         "sharing",
         "sig",
         "signature",
         "struct",
         "structure",
         "then",
         "val",
         "where",
         "while",
         "withtype",
         "type",

         "DUMMY",
         "error",
         "exn",
         "Fail"
         ]


      (* Reserved words in cmyacc. *)
      val () =
         List.app
         (fn (str, token) => Table.insert keywords str (SOME token))
         [
         ("name", Name),
         ("nonterminal", Nonterminal),
         ("of", Of),
         ("start", Start),
         ("terminal", Terminal)
         ]

        

      open Stream

      type arg = { str : char list,
                   len : int, 
                   start : char stream, 
                   follow : char stream, 
                   self : { lexmain : char stream -> int -> token front,
                            skipcomment : char stream -> int -> char stream * int} }

      exception Error

      fun action f ({ str, len, follow, self, ... }:arg) pos =
          Cons (f (str, len, pos), lazy (fn () => #lexmain self follow (pos+len)))

      fun simple token ({ len, follow, self, ... }:arg) pos =
          Cons (token, lazy (fn () => #lexmain self follow (pos+len)))

      structure LexMain =
         LexMainFun
         (structure Streamable = StreamStreamable
          type symbol = char
          val ord = Char.ord

          type t = int -> token front
          type u = int -> char stream * int

          fun eof _ _ = Nil

          val ident = 
             action
             (fn (chars, _, pos) => 
                    let
                       val str = implode chars
                    in
                       (case Table.find keywords str of
                           NONE =>
                              Ident (Symbol.fromString str)
                         | SOME NONE =>
                              (
                              print "Illegal identifier at ";
                              print (Int.toString pos);
                              print ".\n";
                              raise Error
                              )
                         | SOME (SOME token) =>
                              token)
                    end)

          fun skip ({ len, follow, self, ... }:arg) pos = #lexmain self follow (pos+len)

          fun lcomment ({ len, follow, self, ...}:arg) pos =
              let
                 val (follow', pos') = #skipcomment self follow (pos+len)
              in
                 #lexmain self follow' pos'
              end

          fun error _ pos =
             (
             print "Lexical error at ";
             print (Int.toString pos);
             print ".\n";
             raise Error
             )
                 
          val arrow = simple Arrow
          val colon = simple Colon
          val equal = simple Equal
          val lparen = simple LParen
          val rparen = simple RParen

          fun comment_open ({ len, follow, self, ... }:arg) pos =
              let
                 val (follow', pos') = #skipcomment self follow (pos+len)
              in
                 #skipcomment self follow' pos'
              end

          fun comment_close ({ len, follow, ...}:arg) pos = 
              (follow, pos+len)

          fun comment_skip ({ len, follow, self, ... }:arg) pos =
              #skipcomment self follow (pos+len)

          fun comment_error _ pos =
             (
             print "Unclosed comment at ";
             print (Int.toString pos);
             print ".\n";
             raise Error
             )
                 
         )


      fun lex s = lazy (fn () => LexMain.lexmain s 0)

   end
