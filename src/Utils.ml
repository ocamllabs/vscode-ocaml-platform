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

module Fpath : sig
  type t

  val ofString : string -> t

  val v : string -> t

  val toString : t -> string

  val show : t -> string

  val ( / ) : t -> string -> t

  val join : t -> t -> t
end = struct
  let sep =
    match Sys.unix with
    | true -> "/"
    | false -> "\\\\"

  type t = string list

  let ofString = Array.to_list << Js.String.split sep

  let v = ofString

  let toString = Js.Array.joinWith sep << Array.of_list

  let show = toString

  let ( / ) p x = p @ [ x ]

  let join x y = x @ y
end

let okThen f =
  let open Js.Promise in
  then_
    (resolve << function
     | Ok x -> f x
     | Error e -> Error e)
