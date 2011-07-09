
structure Parser
   :> PARSER
   =
   struct

      open Token

      structure Parsing = ParsingFun (type token = token)
      open Parsing
      
      fun literal token =
         test_ (fn token' => token = token')

      val ident =
         wrap
         (fn IDENT x => x
           | _ => raise SyntaxError)
         accept

      val number =
         wrap
         (fn NUMBER x => x
           | _ => raise SyntaxError)
         accept

      val string =
         wrap
         (fn STRING x => x
           | _ => raise SyntaxError)
         accept

      fun sexp token p =
          seq (literal LPAREN)
             (seq (literal token)
                 (bind p
                     (fn x => seq (literal RPAREN) (return x))))



      fun charset s =
         alt
         [
         wrap Syntax.Svar ident,
         wrap Syntax.Ssymbol number,
         wrap Syntax.Srange (sexp RANGE (many (andthen number number))),
         replace Syntax.Sempty (literal EMPT),
         wrap Syntax.Sunion (sexp OR (many charset)),
         wrap Syntax.Sintersection (sexp AND (many charset)),
         wrap Syntax.Sdifference (sexp MINUS (andthen charset (many charset))),
         wrap Syntax.Scomplement (sexp TILDE (many charset)),
         replace Syntax.Sany (literal ANY)
         ] s

      fun regexp s =
          alt
          [
          wrap Syntax.Var ident,
          wrap Syntax.Symbol number,
          wrap Syntax.String string,
          replace Syntax.Any (literal ANY),
          replace Syntax.Epsilon (literal EPSILON),
          replace Syntax.Empty (literal EMPT),
          wrap Syntax.Concat (sexp COLON (many regexp)),
          wrap Syntax.Concat (sexp SEQ (many regexp)),
          wrap Syntax.Union (sexp OR (many regexp)),
          wrap Syntax.Option (sexp QUESTION regexp),
          wrap Syntax.Closure (sexp STAR regexp),
          wrap Syntax.Plus (sexp PLUS regexp),
          replace Syntax.Eos (literal EOS)
          ] s

      val arm = andthen regexp (seq (literal ARROW) ident)

      val arms = manyplus arm

      fun directive s =
          alt
          [
          wrap Syntax.Name (seq (literal NAME) ident),
          wrap Syntax.Enable (seq (literal ENABLE) ident),
          wrap Syntax.Alphabet (seq (literal ALPHABET) number),
          wrap Syntax.Regexp (seq (literal REGEXP) (andthen ident (seq (literal EQUAL) regexp))),
          wrap Syntax.Set (seq (literal SET) (andthen ident (seq (literal EQUAL) charset))),
          wrap Syntax.Function
             (seq 
                 (literal FUNCTION) 
                 (andthen3
                     (ident,
                      seq (literal COLON) ident,
                      seq (literal EQUAL) arms)))
          ] s

      exception Error
          
      fun parse s =
          (let
              val (l, s') = many directive (Lexer.lex s)
           in
              (case Stream.front s' of
                  Stream.Nil =>
                     l
                | Stream.Cons _ =>
                     raise SyntaxError)
           end
           handle SyntaxError =>
                     (
                     print "Syntax error.\n";
                     raise Error
                     ))

   end
