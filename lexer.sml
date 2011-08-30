
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

         "int",
         "list",
         "ord",
         "symbol"
         ]


      (* Reserved words in cmlex. *)
      val () =
         List.app
         (fn (str, token) => Table.insert keywords str (SOME token))
         [
         ("alphabet", ALPHABET),
         ("and", AND),
         ("any", ANY),
         ("empty", EMPT),
         ("enable", ENABLE),
         ("eos", EOS),
         ("epsilon", EPSILON),
         ("function", FUNCTION),
         ("name", NAME),
         ("or", OR),
         ("range", RANGE),
         ("regexp", REGEXP),
         ("seq", SEQ),
         ("set", SET)
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
                                IDENT (pos, str)
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
  
            val char = 
               action
               (fn (chars, _, pos) =>
                      (* By construction, chars should be '<ch> . *)
                      (case chars of
                          [_, ch] =>
                             NUMBER (pos, Char.ord ch)
                        | _ =>
                             raise (Fail "invariant")))
  
            fun lcomment ({ len, follow, self, ...}:arg) pos =
                let
                   val (follow', pos') = #skipcomment self follow (pos+len)
                in
                   #lexmain self follow' pos'
                end
  
            val string =
               action
               (fn (chars, len, pos) =>
                      (* By construction, chars should begin and end with ". *)
                      STRING (pos, List.map ord (List.take (List.tl chars, len-2))))
  
            fun error _ pos =
               (
               print "Lexical error at ";
               print (Int.toString pos);
               print ".\n";
               raise Error
               )
                   
            val ampersand = simple AND
            val arrow = simple ARROW
            val bar = simple OR
            val colon = simple COLON
            val equal = simple EQUAL
            val lparen = simple LPAREN
            val minus = simple MINUS
            val plus = simple PLUS
            val question = simple QUESTION
            val rparen = simple RPAREN
            val slash = simple RANGE
            val star = simple STAR
            val tilde = simple TILDE
            val geq = simple GEQ
            val starstar = simple REPEAT
  
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
