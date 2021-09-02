
signature LANGUAGE =
   sig

      datatype language = SML | HASKELL | OCAML | RAW

      val toString : language -> string
      val extension : language -> string

      val reserved : language -> string -> bool
      val legalLongid : language -> string list -> bool

   end