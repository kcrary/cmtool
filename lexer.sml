
structure Lexer
   :> LEXER 
   =
   struct

      open Token

      structure Table =
         HashTable (structure Key = StringHashable)
         
      val keywords : (pos -> token) option Table.table = Table.table 60

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

         "before",
         "div",
         "mod",
         "o",

         "error",
         "exn",

         "true",
         "false",
         "nil",
         "ref"
         ]


      (* Reserved words in cmyacc. *)
      val () =
         List.app
         (fn (str, token) => Table.insert keywords str (SOME token))
         [
         ("name", NAME),
         ("nonterminal", NONTERMINAL),
         ("noprec", NOPREC),
         ("of", OF),
         ("precl", PRECL),
         ("precr", PRECR),
         ("start", START),
         ("terminal", TERMINAL)
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
         Cons (token pos, lazy (fn () => #lexmain self follow (pos+len)))

      structure Arg =
         struct
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
                                IDENT (pos, Symbol.fromValue str)
                           | SOME NONE =>
                                (
                                print "Illegal identifier at ";
                                print (Int.toString pos);
                                print ".\n";
                                raise Error
                                )
                           | SOME (SOME token) =>
                                token pos)
                      end)

            val number = 
               action 
               (fn (chars, _, pos) =>
                      ((case Int.fromString (implode chars) of
                           SOME n => 
                              NUMBER (pos, n)
                         | NONE =>
                              raise (Fail "invariant"))
                       handle Overflow => 
                                 (
                                 print "Illegal constant at ";
                                 print (Int.toString pos);
                                 print ".\n";
                                 raise Error
                                 )))
  
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
                   
            val arrow = simple ARROW
            val colon = simple COLON
            val equal = simple EQUAL
            val lparen = simple LPAREN
            val rparen = simple RPAREN
  
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
         end

      structure LexMain =
         LexMainFun
         (structure Streamable = StreamStreamable
          structure Arg = Arg)


      fun lex s = lazy (fn () => LexMain.lexmain s 0)

   end
