open Import

type t = string

let equal = String.equal

let of_string s = s

let to_string s = s

let delimiter = Node.Path.delimiter

let is_absolute t = Node.Path.isAbsolute t

let compare = String.compare

let dirname = Node.Path.dirname

let extname = Node.Path.extname

let basename = Node.Path.basename

let join x y = Node.Path.join [ x; y ]

let ( / ) = join

let relative = join

let relative_all p xs = List.fold_left xs ~f:join ~init:p

let with_ext x ~ext = x ^ ext

let is_root = function
  | "" -> true
  | x -> equal (dirname x) x

let parent x =
  if is_root x then
    None
  else
    Some (dirname x)

let asset name = of_string (Node.__filename () ^ "/../../assets/" ^ name)
