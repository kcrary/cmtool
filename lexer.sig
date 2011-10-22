
signature LEXER =
   sig

      exception Error

      type pos = int

      val lex : char Stream.stream -> (Token.token * pos) Stream.stream

   end
