
module type S =
   sig

      type 'a t

      type 'a front = Nil | Cons of 'a * 'a t
      val front : 'a t -> 'a front

   end


module ListStreamable
   : S with type 'a t = 'a list


module StreamStreamable
   : S with type 'a t = 'a FStream.stream
