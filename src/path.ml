let sep =
  match Sys.unix with
  | true -> "/"
  | false -> "\\\\"

type t = string list

let ofString s = Array.to_list (Js.String.split sep s)

let v = ofString

let toString s = Js.Array.joinWith sep (Array.of_list s)

let compare x y = String.compare (toString x) (toString y)

let extname t = Node.Path.extname (toString t)

let ( / ) p x = p @ [ x ]

let relative = ( / )

let relative_all p xs = p @ xs

let join x y = x @ y
