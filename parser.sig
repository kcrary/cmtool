
signature PARSER =
   sig
      exception SyntaxError
      val parse : Token.token Stream.stream -> Syntax.directive list
   end
