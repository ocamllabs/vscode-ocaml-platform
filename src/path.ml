type t = string

let equal = String.equal

let of_string s = s

let to_string s = s

let is_absolute t = not (Filename.is_relative t)

let compare = String.compare

let dirname = Filename.dirname

let extname t = Filename.extension t

let basename t = Filename.basename t

let ( / ) = Filename.concat

let relative = ( / )

let relative_all p xs = List.fold_left Filename.concat p xs

let join x y = Filename.concat x y

let with_ext x ~ext = x ^ ext

let is_root = function
  | "" -> true
  | x -> Filename.dirname x = x

let parent x =
  if is_root x then
    None
  else
    Some (Filename.dirname x)
