
module Terminal =
   struct
      type terminal =
         NUMBER of int
       | PLUS
       | TIMES
       | LPAREN
       | RPAREN
   end

module rec Lexer 
   : sig
        val lex : char FStream.t -> Terminal.terminal FStream.front
     end
   =
   CalcLex.Fun
   (Streamable.StreamStreamable)
   (struct
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
 
       let simple terminal { follow } =
         Cons (terminal, laz (lazy (Lexer.lex follow)))
 
       let plus = simple PLUS
       let times = simple TIMES
       let lparen = simple LPAREN
       let rparen = simple RPAREN
 
       let whitespace { follow } =
         Lexer.lex follow
 
       let eof _ = Nil
     end)

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
