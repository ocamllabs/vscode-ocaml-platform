module R = Result

let env_sep =
  match Sys.unix with
  | true -> ":"
  | false -> ";"

let propertyExists json property =
  let open Js.Json in
  match classify json with
  | JSONObject json -> (
    match Js.Dict.get json property with
    | Some j -> (
      match classify j with
      | JSONNull -> false
      | _ -> true )
    | None -> false )
  | _ -> false

let mapResultAndResolvePromise f r =
  let open Js.Promise in
  let open R in
  r >>| f |> resolve

let bindResultAndResolvePromise f r =
  let open Js.Promise in
  let open R in
  r >>= f |> resolve

let getSubDict dict key =
  ((dict |. Js.Dict.get) key |. Belt.Option.flatMap) Js.Json.decodeObject

let mergeDicts dict1 dict2 =
  Js.Dict.fromArray
    (Js.Array.concat (Js.Dict.entries dict1) (Js.Dict.entries dict2))

let ( << ) f g x = f (g x)

let okThen f =
  let open Js.Promise in
  then_
    (resolve << function
     | Ok x -> f x
     | Error e -> Error e)
