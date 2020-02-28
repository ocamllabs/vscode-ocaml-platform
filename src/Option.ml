open Belt.Option

let ( >>= ) = flatMap

let ( >>| ) = map

let ( |! ) o f =
  match o with
  | None -> f ()
  | _ -> ()

let toResult e = function
  | Some x -> Ok x
  | None -> Error e

let toPromise e = function
  | Some x -> x
  | None -> Js.Promise.resolve (Error e)
