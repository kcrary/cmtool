
let implode l =
   let a = Bytes.create (List.length l)
   in
      (
      List.iteri (fun i x -> Bytes.set a i x) l;
      Bytes.to_string a
      )


let explode str =
   let n = String.length str
   in
   let rec loop i acc =
      if i >= n then
         List.rev acc
      else
         loop (i+1) (String.get str i :: acc)
   in
      loop 0 []
