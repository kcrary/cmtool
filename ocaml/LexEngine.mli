
module type S =
   sig

      module Strm : Streamable.S

      type symbol

      val next7x1 : int -> string -> int -> int -> int
      val next8x1 : int -> string -> int -> int -> int
      val next9x1 : int -> string -> int -> int -> int
      val next10x1 : int -> string -> int -> int -> int
      val next7x2 : int -> string -> int -> int -> int
      val next8x2 : int -> string -> int -> int -> int
      val next9x2 : int -> string -> int -> int -> int
      val next10x2 : int -> string -> int -> int -> int

      val next0x1 : string -> int -> int
      val next0x2 : string -> int -> int

      type ('a, 'b) action = (symbol list, symbol Strm.t, 'b) LexInfo.t -> 'a

      type ('a, 'b) table =
         int * int * int * ('a, 'b) action array * (int -> int -> int) * (int -> int)

      val lex : 'b -> ('a, 'b) table -> symbol Strm.t -> 'a

   end


module Make (M : sig
                    module Strm : Streamable.S
                    type symbol
                    val ord : symbol -> int
                 end)
   : S with type 'a Strm.t = 'a M.Strm.t
       and type symbol = M.symbol
