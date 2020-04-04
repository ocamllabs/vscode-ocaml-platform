include Vscode
module Process = Node.Process
module ChildProcess = Node.ChildProcess
module Fs = Node.Fs
module Path = Node.Path (* why do we have 2 path modules *)

let envSep =
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

let hiddenEsyDir root = Fpath.(root / ".vscode" / "esy")

module Result = struct
  open Belt.Result

  let ( >>= ) = flatMap

  let ( >>| ) = map

  let return x = Ok x

  let fail x = Error x

  let bind x ~f = x >>= f
end

module List = struct
  include List

  let rec find_map xs ~f =
    match xs with
    | [] -> None
    | x :: xs -> (
      match f x with
      | None -> find_map xs ~f
      | Some _ as e -> e )
end
