open Belt.Result

let ( >>= ) = flatMap

let ( >>| ) = map

let ( |! ) o f =
  match o with
  | None -> f ()
  | _ -> ()

let toResult msg = function
  | Some x -> Ok x
  | None -> Error msg

let return x = Ok x

let fail x = Error x
