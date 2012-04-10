
signature PARSER =
   sig
      exception Error
      val parse : char Stream.stream -> Syntax.directive list
   end
