let sep =
  match Sys.unix with
  | true -> "/"
  | false -> "\\\\"

type t = string list

let ofString s = Array.to_list (Js.String.split sep s)

let v = ofString

let toString s = Js.Array.joinWith sep (Array.of_list s)

let compare x y = String.compare (toString x) (toString y)

let show = toString

let ( / ) p x = p @ [ x ]

let join x y = x @ y
