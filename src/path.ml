let sep =
  match Sys.unix with
  | true -> "/"
  | false -> "\\\\"

type t = string

let ofString s = s

let isAbsolute t = Node.Path.isAbsolute t

let v = ofString

let toString s = s

let compare = String.compare

let extname t = Node.Path.extname t

let ( / ) = Filename.concat

let relative = ( / )

let relative_all p xs = List.fold_left Filename.concat p xs

let join x y = Filename.concat x y

let withExt x ~ext = x ^ ext
