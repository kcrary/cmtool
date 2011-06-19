
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
         (fn Ident x => x
           | _ => raise SyntaxError)
         accept

      val number =
         wrap
         (fn Number x => x
           | _ => raise SyntaxError)
         accept

      val string =
         wrap
         (fn String x => x
           | _ => raise SyntaxError)
         accept

      fun sexp token p =
          seq (literal LParen)
             (seq (literal token)
                 (bind p
                     (fn x => seq (literal RParen) (return x))))



      fun charset s =
         alt
         [
         wrap Syntax.Svar ident,
         wrap Syntax.Ssymbol number,
         wrap Syntax.Srange (sexp Range (many (andthen number number))),
         replace Syntax.Sempty (literal Empt),
         wrap Syntax.Sunion (sexp Or (many charset)),
         wrap Syntax.Sintersection (sexp And (many charset)),
         wrap Syntax.Sdifference (sexp Minus (andthen charset (many charset))),
         wrap Syntax.Scomplement (sexp Tilde (many charset)),
         replace Syntax.Sany (literal Any)
         ] s

      fun regexp s =
          alt
          [
          wrap Syntax.Var ident,
          wrap Syntax.Symbol number,
          wrap Syntax.String string,
          replace Syntax.Any (literal Any),
          replace Syntax.Epsilon (literal Epsilon),
          replace Syntax.Empty (literal Empt),
          wrap Syntax.Concat (sexp Colon (many regexp)),
          wrap Syntax.Concat (sexp Seq (many regexp)),
          wrap Syntax.Union (sexp Or (many regexp)),
          wrap Syntax.Option (sexp Question regexp),
          wrap Syntax.Closure (sexp Star regexp),
          wrap Syntax.Plus (sexp Plus regexp),
          replace Syntax.Eos (literal Eos)
          ] s

      val arm = andthen regexp (seq (literal Arrow) ident)

      val arms = manyplus arm

      fun directive s =
          alt
          [
          wrap Syntax.Name (seq (literal Name) ident),
          wrap Syntax.Alphabet (seq (literal Alphabet) number),
          wrap Syntax.Type (seq (literal Type) ident),
          wrap Syntax.Action (seq (literal Action) (andthen ident (seq (literal Colon) ident))),
          wrap Syntax.Function (seq (literal Function) (andthen ident (seq (literal Equal) arms))),
          wrap Syntax.Regexp (seq (literal Regexp) (andthen ident (seq (literal Equal) regexp))),
          wrap Syntax.Set (seq (literal Set) (andthen ident (seq (literal Equal) charset)))
          ] s

      fun parse s =
          let
             val (l, s') = many directive s
          in
             (case Stream.front s' of
                 Stream.Nil =>
                    l
               | Stream.Cons _ =>
                    raise SyntaxError)
          end

   end
