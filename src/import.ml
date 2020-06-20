include Vscode
module Process = Node.Process
module ChildProcess = Node.ChildProcess
module Fs = Node.Fs

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

let hiddenEsyDir root = Path.(root / ".vscode" / "esy")

module Option = struct
  open Belt.Option

  let ( >>= ) = flatMap

  let ( >>| ) = map

  let alternative l r =
    match (l, r) with
    | None, r -> r
    | l, _ -> l

  let join = function
    | None
    | Some None ->
      None
    | Some x -> x

  let return x = Some x

  let bind x ~f = x >>= f

  let iter t ~f = forEach t f

  let iterNone t ~f =
    match t with
    | None -> f ()
    | Some _ -> ()
end

module Result = struct
  open Belt.Result

  let ( >>= ) = flatMap

  let ( >>| ) = map

  let alternative l r =
    match (l, r) with
    | Error _, r -> r
    | l, _ -> l

  let return x = Ok x

  let fail x = Error x

  let bind x ~f = x >>= f

  let mapError x ~f =
    match x with
    | Ok _ as x -> x
    | Error x -> Error (f x)
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

module Or_error = struct
  type 'a t = ('a, string) result
end

module String = struct
  include String

  let chopPrefix s ~prefix =
    if Js.String.startsWith prefix s then
      let prefixLen = String.length prefix in
      Some (Js.String.sliceToEnd ~from:prefixLen s)
    else
      None
end

let sprintf = Printf.sprintf

let message kind fmt =
  let k =
    match kind with
    | `Warn -> Window.showWarningMessage
    | `Info -> Window.showInformationMessage
    | `Error -> Window.showErrorMessage
  in
  Printf.ksprintf
    (fun x ->
      let (_ : unit Promise.t) = k x in
      ())
    fmt

module Log : sig
  type field

  val field : _ -> field
end = struct
  type field

  external field : _ -> field = "%identity"
end

let log fmt = Printf.ksprintf (fun x -> Js.Console.log x) fmt

let logJson msg (fields : (string * Log.field) list) =
  let json = Js.Dict.fromList fields in
  Js.Console.log2 msg json
