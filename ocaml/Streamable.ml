
module type S =
   sig

      type 'a t

      type 'a front = Nil | Cons of 'a * 'a t
      val front : 'a t -> 'a front

   end


module ListStreamable
   : S with type 'a t = 'a list
   =
   struct

      type 'a t = 'a list
      type 'a front = Nil | Cons of 'a * 'a t

      let rec front l =
         (match l with
             [] -> Nil
           | h :: t -> Cons (h, t))

   end


module StreamStreamable
   : S with type 'a t = 'a FStream.stream
   =
   FStream
