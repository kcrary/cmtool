
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
   =
   struct

      module Strm = M.Strm
      type symbol = M.symbol

      (* Next state function for 7-bit symbols, with 1-byte results. *)
      let next7x1 symbolLimit table state symbol =
          if symbol >= symbolLimit then
             0
          else
             let i = 128 * state + symbol
             in                       
                int_of_char (String.get table i)

      let next8x1 symbolLimit table state symbol =
          if symbol >= symbolLimit then
             0
          else
             let i = 256 * state + symbol
             in                       
                int_of_char (String.get table i)

      let next9x1 symbolLimit table state symbol =
          if symbol >= symbolLimit then
             0
          else
             let i = 512 * state + symbol
             in                       
                int_of_char (String.get table i)

      let next10x1 symbolLimit table state symbol =
          if symbol >= symbolLimit then
             0
          else
             let i = 1024 * state + symbol
             in                       
                int_of_char (String.get table i)

      let next7x2 symbolLimit table state symbol =
          if symbol >= symbolLimit then
             0
          else
             let i = 256 * state + 2 * symbol
             in                       
                int_of_char (String.get table i) * 256 +
                int_of_char (String.get table (i+1))

      let next8x2 symbolLimit table state symbol =
          if symbol >= symbolLimit then
             0
          else
             let i = 512 * state + 2 * symbol
             in                       
                int_of_char (String.get table i) * 256 +
                int_of_char (String.get table (i+1))

      let next9x2 symbolLimit table state symbol =
          if symbol >= symbolLimit then
             0
          else
             let i = 1024 * state + 2 * symbol
             in                       
                int_of_char (String.get table i) * 256 +
                int_of_char (String.get table (i+1))

      let next10x2 symbolLimit table state symbol =
          if symbol >= symbolLimit then
             0
          else
             let i = 2048 * state + 2 * symbol
             in                       
                int_of_char (String.get table i) * 256 +
                int_of_char (String.get table (i+1))

      (* Next state function for end-of-stream, with 1-byte results. *)
      let next0x1 table state =
          int_of_char (String.get table state)

      let next0x2 table state =
          let i = 2 * state
          in
             int_of_char (String.get table i) * 256 +
             int_of_char (String.get table (i+1))


      type ('a, 'b) action = (symbol list, symbol Strm.t, 'b) LexInfo.t -> 'a

      type ('a, 'b) table =
         int * int * int * ('a, 'b) action array * (int -> int -> int) * (int -> int)

      let lex self (initial, lastAcceptSink, lastAccept, acceptTable, next, nextEos) s =
          let rec
             loop candidate candLen candChars candStream state len chars s =
                if state = 0 then
                   (candidate, candLen, candChars, candStream)
                else if state <= lastAccept then
                   if state <= lastAcceptSink then
                      (state, len, chars, s)
                   else
                      (match Strm.front s with
                          Strm.Nil ->
                             loop state len chars s (nextEos state) len chars s
                        | Strm.Cons (ch, s') ->
                             loop state len chars s (next state (M.ord ch)) (len+1) (ch :: chars) s')
                else
                   (match Strm.front s with
                       Strm.Nil ->
                          loop candidate candLen candChars candStream (nextEos state) len chars s
                     | Strm.Cons (ch, s') ->
                          loop candidate candLen candChars candStream (next state (M.ord ch)) (len+1) (ch :: chars) s')
             
          in let (acceptingState, len, chars, s') = 
                (* By construction, initial is an accepting state. *)
                loop initial 0 [] s initial 0 [] s

          in let f = Array.get acceptTable (acceptingState-1)
          in
             f { LexInfo.matc = List.rev chars;
                 LexInfo.len = len;
                 LexInfo.start = s;
                 LexInfo.follow = s';
                 LexInfo.self = self }

   end

