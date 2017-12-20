
module type S =
   sig
   
      module Strm : Streamable.S

      type terminal
      type value

      val next5x1 : string -> int -> int -> int
      val next6x1 : string -> int -> int -> int
      val next7x1 : string -> int -> int -> int
      val next8x1 : string -> int -> int -> int
      val next9x1 : string -> int -> int -> int
      val next5x2 : string -> int -> int -> int
      val next6x2 : string -> int -> int -> int
      val next7x2 : string -> int -> int -> int
      val next8x2 : string -> int -> int -> int
      val next9x2 : string -> int -> int -> int

      type action = value list -> value list

      type 'a table =
         (int -> int -> int)             (* action table *)
         *
         (int -> int -> int)             (* goto table *)
         *
         (int * int * action) array      (* reduction information: lhs ordinal, rhs size, function *)
         *
         (value -> 'a)                   (* result destructor *)
         *
         (terminal Strm.t -> exn)        (* error function *)

      val parse : 'a table -> terminal Strm.t -> 'a * terminal Strm.t

   end


module Make (M : sig
                    module Strm : Streamable.S
                    type terminal
                    type value
                    val dummy : value
                    val read : terminal -> int * value
                 end)
   : S with type 'a Strm.t = 'a M.Strm.t
       and type terminal = M.terminal
       and type value = M.value
   =
   struct

      module Strm = M.Strm

      type terminal = M.terminal
      type value = M.value

      (* Transition function for a 5-bit symbols, with 1-byte results. *)
      let next5x1 table state symbol =
         let i = 32 * state + symbol
         in                       
            int_of_char (String.get table i) - 128

      let next6x1 table state symbol =
         let i = 64 * state + symbol
         in                       
            int_of_char (String.get table i) - 128

      let next7x1 table state symbol =
         let i = 128 * state + symbol
         in                       
            int_of_char (String.get table i) - 128

      let next8x1 table state symbol =
         let i = 256 * state + symbol
         in                       
            int_of_char (String.get table i) - 128

      let next9x1 table state symbol =
         let i = 512 * state + symbol
         in                       
            int_of_char (String.get table i) - 128

      let next5x2 table state symbol =
         let i = 64 * state + 2 * symbol
         in                       
            int_of_char (String.get table i) * 256 +
            int_of_char (String.get table (i+1))
            - 32768

      let next6x2 table state symbol =
         let i = 128 * state + 2 * symbol
         in                       
            int_of_char (String.get table i) * 256 +
            int_of_char (String.get table (i+1))
            - 32768

      let next7x2 table state symbol =
         let i = 256 * state + 2 * symbol
         in                       
            int_of_char (String.get table i) * 256 +
            int_of_char (String.get table (i+1))
            - 32768

      let next8x2 table state symbol =
         let i = 512 * state + 2 * symbol
         in                       
            int_of_char (String.get table i) * 256 +
            int_of_char (String.get table (i+1))
            - 32768

      let next9x2 table state symbol =
         let i = 1024 * state + 2 * symbol
         in                       
            int_of_char (String.get table i) * 256 +
            int_of_char (String.get table (i+1))
            - 32768


      type action = value list -> value list

      type 'a table =
         (int -> int -> int)             (* action table *)
         *
         (int -> int -> int)             (* goto table *)
         *
         (int * int * action) array      (* reduction information: lhs, size of rhs, letctions to call *)
         *
         (value -> 'a)                   (* result destructor *)
         *
         (terminal Strm.t -> exn)        (* error letction *)

      let parse (action, goto, reduce, destruct, error) s =
         let rec loop ststack valstack s =
            (match Strm.front s with
                Strm.Nil ->
                   loopRead ststack valstack 0 M.dummy s s
              | Strm.Cons (term, s') ->
                   let (ordinal, value) = M.read term
                   in
                      loopRead ststack valstack ordinal value s s')
            
         and loopRead ststack valstack ordinal value s s' =
            (match ststack with
                [] ->
                   raise (Failure "bad parsing table")
              | state :: rest ->
                   let n = action state ordinal
                   in
                      if n = 0 then
                         raise (error s)
                      else if n > 0 then
                         (* shift *)
                         loop (n-1 :: ststack) (value :: valstack) s'
                      else if n = -1 then
                         (* accept *)
                         (valstack, s)
                      else
                         (* reduce *)
                         let (lhs, rhssize, f) = Array.get reduce (-n - 2)
                         in
                         let ststack' = ListUtil.drop ststack rhssize
                         in
                            loopRead (goto (List.hd ststack') lhs :: ststack') (f valstack) ordinal value s s')

         in
            (match loop [0] [] s with
                ([value], s') -> (destruct value, s')
              | _ ->
                   raise (Failure "bad parsing table"))

   end
