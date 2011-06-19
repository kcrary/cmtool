
signature LEXER =
   sig

      exception LexicalError of int
      exception IllegalIdentifier of int
      exception IllegalConstant of int

      val lex : char Stream.stream -> Token.token Stream.stream

   end
