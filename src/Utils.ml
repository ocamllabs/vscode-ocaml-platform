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

let getSubDict dict key =
  ((dict |. Js.Dict.get) key |. Belt.Option.flatMap) Js.Json.decodeObject

let mergeDicts dict1 dict2 =
  Js.Dict.fromArray
    (Js.Array.concat (Js.Dict.entries dict1) (Js.Dict.entries dict2))

let okThen f =
  let open Js.Promise in
  then_ (fun x ->
      resolve
        ( match x with
        | Ok x -> f x
        | Error e -> Error e ))

module Result = struct
  open Belt.Result

  let ( >>= ) = flatMap

  let ( >>| ) = map

  let return x = Ok x

  let fail x = Error x
end
