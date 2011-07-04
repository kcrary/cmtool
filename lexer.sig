
signature LEXER =
   sig

      exception Error

      val lex : char Stream.stream -> Token.token Stream.stream

   end
