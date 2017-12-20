
structure Lexer
   :> LEXER 
      where type token = Token.token
   =
   struct

      open Token

      structure Table =
         HashTable (structure Key = StringHashable)
         
      val keywords : token option Table.table = Table.table 60

      (* Reserved words in cmlex. *)
      val () =
         List.app
         (fn (str, token) => Table.insert keywords str (SOME token))
         [
         ("alphabet", ALPHABET),
         ("and", AND),
         ("any", ANY),
         ("empty", EMPT),
         ("eos", EOS),
         ("epsilon", EPSILON),
         ("function", FUNCTION),
         ("name", NAME),
         ("or", OR),
         ("range", RANGE),
         ("regexp", REGEXP),
         ("seq", SEQ),
         ("set", SET),

         ("monadic", OPTION "monadic"),
         ("sml", OPTION "sml"),
         ("haskell", OPTION "haskell"),
         ("ocaml", OPTION "ocaml")
         ]

        

      open Stream

      type pos = int

      type t = int -> (token * pos) front
      type u = int -> char stream * int
  
      type self = { lexmain : char stream -> t,
                    skipcomment : char stream -> u }

      type info = { match : char list,
                    len : int, 
                    start : char stream, 
                    follow : char stream, 
                    self : self }

      exception Error

      fun action f ({ match, len, follow, self, ... }:info) pos =
         Cons (f (match, len, pos), lazy (fn () => #lexmain self follow (pos+len)))

      fun simple token ({ len, follow, self, ... }:info) pos =
         Cons ((token, pos), lazy (fn () => #lexmain self follow (pos+len)))

      structure Arg =
         struct
            type symbol = char
            val ord = Char.ord
  
            type t = t
            type u = u
            type self = self
            type info = info

            fun eof _ _ = Nil
  
            val ident = 
               action
               (fn (chars, _, pos) => 
                      let
                         val str = implode chars
                      in
                         (case Table.find keywords str of
                             NONE =>
                                (IDENT str, pos)
                           | SOME NONE =>
                                (
                                print "Illegal identifier at ";
                                print (Int.toString pos);
                                print ".\n";
                                raise Error
                                )
                           | SOME (SOME token) =>
                                (token, pos))
                      end)
  
            val number = 
               action 
               (fn (chars, _, pos) =>
                      ((case Int.fromString (implode chars) of
                           SOME n => 
                              (NUMBER n, pos)
                         | NONE =>
                              raise (Fail "invariant"))
                       handle Overflow => 
                                 (
                                 print "Illegal constant at ";
                                 print (Int.toString pos);
                                 print ".\n";
                                 raise Error
                                 )))
  
            fun skip ({ len, follow, self, ... }:info) pos = #lexmain self follow (pos+len)
  
            val char = 
               action
               (fn (chars, _, pos) =>
                      (* By construction, chars should be '<ch> . *)
                      (case chars of
                          [_, ch] =>
                             (NUMBER (Char.ord ch), pos)
                        | _ =>
                             raise (Fail "invariant")))
  
            fun lcomment ({ len, follow, self, ...}:info) pos =
                let
                   val (follow', pos') = #skipcomment self follow (pos+len)
                in
                   #lexmain self follow' pos'
                end
  
            val string =
               action
               (fn (chars, len, pos) =>
                      (* By construction, chars should begin and end with ". *)
                      (STRING (List.map ord (List.take (List.tl chars, len-2))), pos))
  
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
            val dot = simple DOT
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
  
            fun comment_open ({ len, follow, self, ... }:info) pos =
                let
                   val (follow', pos') = #skipcomment self follow (pos+len)
                in
                   #skipcomment self follow' pos'
                end
  
            fun comment_close ({ len, follow, ...}:info) pos = 
                (follow, pos+len)
  
            fun comment_skip ({ len, follow, self, ... }:info) pos =
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
