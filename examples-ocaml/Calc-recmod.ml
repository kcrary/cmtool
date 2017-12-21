
module Terminal =
   struct
      type terminal =
         NUMBER of int
       | PLUS
       | TIMES
       | LPAREN
       | RPAREN
   end

module rec Arg
   : sig
        type symbol = char
        val ord : symbol -> int

        type t = Terminal.terminal FStream.front

        type self = { lex : symbol FStream.t -> t }
        type info = (symbol list, symbol FStream.t, self) LexInfo.t

        val eof : info -> t
        val lparen : info -> t
        val number : info -> t
        val plus : info -> t
        val rparen : info -> t
        val times : info -> t
        val whitespace : info -> t
     end
   =
   struct
      open FStream
      open LexInfo
      open Terminal

      type symbol = char
      let ord = int_of_char

      type t = terminal front

      type self = { lex : char stream -> t }
      type info = (symbol list, symbol FStream.stream, self) LexInfo.t

      let number { matc; follow } =
        Cons (NUMBER (int_of_string (StringUtil.implode matc)),
              laz (lazy (Lexer.lex follow)))

      let simple terminal ({ follow }:info) =  (* this type annotation is necessary *)
        Cons (terminal, laz (lazy (Lexer.lex follow)))

      let plus = simple PLUS
      let times = simple TIMES
      let lparen = simple LPAREN
      let rparen = simple RPAREN

      let whitespace { follow } =
        Lexer.lex follow

      let eof _ = Nil
    end

and Lexer
   : sig
        val lex : Arg.symbol FStream.t -> Arg.t
     end
   =
   CalcLex.Fun
   (Streamable.StreamStreamable)
   (Arg)

module Parser =
   CalcParse.Fun
   (Streamable.StreamStreamable)
   (struct
       type t = int

       let id x = x

       let number_atom = id
       let paren_atom = id
       let atom_factor = id
       let times_factor x y = x * y
       let factor_term = id
       let plus_term x y = x + y

       include Terminal

       let error _ = Failure "syntax error"
     end)

let calc strm = fst (Parser.parse (FStream.laz (lazy (Lexer.lex strm))))
