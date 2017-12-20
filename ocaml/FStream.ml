
type 'a front = Nil | Cons of 'a * 'a stream
and 'a stream = 'a front Lazy.t
type 'a t = 'a stream

let front = Lazy.force
let eager = Lazy.from_val
let laz l = l

let rec fromProcess f = 
   lazy
   (match f () with
       None ->
          Nil
     | Some x ->
          Cons (x, fromProcess f))

let rec fromList l =
   lazy
   (match l with
       [] -> Nil
     | h :: t -> Cons (h, fromList t))

let rec fromLoop f seed =
   lazy
   (match f seed with
       None ->
          Nil
     | Some (seed', x) ->
          Cons (x, fromLoop f seed'))

let rec fromTable get table i =
   lazy
   (try Cons (get table i, fromTable get table (i+1))
    with Invalid_argument _ -> Nil)
             

let fromString str = fromTable String.get str 0

let rec fromInstream ins =
   lazy
   (try Cons (input_char ins, fromInstream ins)
    with End_of_file -> Nil)



let rec fix f = f (lazy (front (fix f)))


let rec hd s =
   (match front s with
       Nil ->
          raise (Failure "FStream.hd")
     | Cons (x, _) ->
          x)

let rec tl s =
   (match front s with
       Nil ->
          raise (Failure "FStream.tl")
     | Cons (_, s') ->
          s')

 
let rec append s1 s2 =
   lazy
   (match front s1 with
       Nil ->
          front s2
     | Cons (h, t) ->
          Cons (h, append t s2))

let (@) = append


let rec take s n =
   if n < 0 then
      raise (Invalid_argument "FStream.take")
   else if n = 0 then
      []
   else
      (match front s with
          Nil ->
             raise (Failure "FStream.take")
        | Cons (x, s') ->
             x :: take s' (n-1))


let rec drop s n =
   if n < 0 then
      raise (Invalid_argument "FStream.drop")
   else if n = 0 then
      s
   else
      (match front s with
          Nil ->
             raise (Failure "FStream.take")
        | Cons (x, s') ->
             drop s' (n-1))

let rec map f s =
   lazy
   (match front s with
       Nil ->
          Nil
     | Cons (x, s') ->
          Cons (f x, map f s'))


let rec app f s =
   (match front s with 
       Nil -> ()
     | Cons (x, s') -> (f x; app f s'))


let rec fold f x s =
   (match front s with
       Nil -> x
     | Cons (h, t) ->
          f h (lazy (fold f x t)))
