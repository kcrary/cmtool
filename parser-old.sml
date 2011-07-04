
structure Parser
   :> PARSER
   =
   struct

      open Token

      structure Parsing = ParsingFun (type token = token)
      open Parsing
      
      val eq = (fn (Ident sym, Ident sym') => Symbol.eq (sym, sym')
                 | (Arrow, Arrow) => true
                 | (Colon, Colon) => true
                 | (Eos, Eos) => true
                 | (Equal, Equal) => true
                 | (Name, Name) => true
                 | (Nonterminal, Nonterminal) => true
                 | (LParen, LParen) => true
                 | (Of, Of) => true
                 | (RParen, RParen) => true
                 | (Start, Start) => true
                 | (Terminal, Terminal) => true
                 | _ => false)

      fun literal token =
         test_ (fn token' => eq (token, token'))

      val ident =
         wrap
         (fn Ident x => x
           | _ => raise SyntaxError)
         accept

      fun item s =
         alt
            [
            wrap Syntax.Labeled (andthen ident (seq (literal Colon) ident)),
            wrap Syntax.Unlabeled ident,
            seq (literal LParen) (first item (literal RParen))
            ] s

      val production =
         andthen (many item) (seq (literal Arrow) ident)

      val directive =
          alt
          [
          wrap Syntax.Start (seq (literal Start) ident),
          wrap Syntax.Name (seq (literal Name) ident),
          wrap Syntax.Terminal
             (seq (literal Terminal) (andthen ident (option (seq (literal Of) ident)))),
          wrap Syntax.Nonterminal
             (seq (literal Nonterminal)
                 (andthen3
                     (ident, seq (literal Colon) ident, seq (literal Equal) (many production))))
          ]


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
