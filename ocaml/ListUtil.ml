
let take l i =
   let rec loop l i acc =
      if i = 0 then
         List.rev acc
      else
         (match l with
          | [] -> raise (Failure "ListUtil.take")
          | h :: t -> loop t (i-1) (h :: acc))
   in
      if i < 0 then
         raise (Invalid_argument "ListUtil.take")
      else
         loop l i []


let drop l i =
   let rec loop l i =
      if i = 0 then
         l
      else
         (match l with
          | [] -> raise (Failure "ListUtil.drop")
          | h :: t -> loop t (i-1))
   in
      if i < 0 then
         raise (Invalid_argument "ListUtil.drop")
      else
         loop l i
