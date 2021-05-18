type t = string

let equal = String.equal

let of_string s = s

let to_string s = s

let delimiter = 
  (* String.get Node.Path.delimiter 0 *)
  ';'

let is_absolute = Node.Path.is_absolute

let compare = String.compare

let dirname = Node.Path.dirname

let extname = Node.Path.extname

let basename x = Node.Path.basename x ()

let join x y = Node.Path.join [ x; y ]

let ( / ) = join

let relative = join

let relative_all p xs = Base.List.fold_left xs ~f:join ~init:p

let with_ext x ~ext = x ^ ext

let is_root = function
  | "" -> true
  | x -> equal (dirname x) x

let parent x =
  if is_root x then
    None
  else
    Some (dirname x)
