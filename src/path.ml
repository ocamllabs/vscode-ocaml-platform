type t = string

let ofString s = s

let isAbsolute t = not (Filename.is_relative t)

let v = ofString

let toString s = s

let compare = String.compare

let dirname = Filename.dirname

let extname t = Filename.extension t

let basename t = Filename.basename t

let ( / ) = Filename.concat

let relative = ( / )

let relative_all p xs = List.fold_left Filename.concat p xs

let join x y = Filename.concat x y

let withExt x ~ext = x ^ ext

let isRoot = function
  | "" -> true
  | x -> Filename.dirname x = x

let parent x =
  if isRoot x then
    None
  else
    Some (Filename.dirname x)
