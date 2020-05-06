external thisProjectsEsyJson : string = "thisProjectsEsyJson"
  [@@bs.module "./fs-stub.js"]

module CamlArray = Array
open Js

external __dirname : string = "__dirname" [@@bs.val]

external processPlatform : string = "platform" [@@bs.val] [@@bs.scope "process"]

module Process = struct
  type t

  external v : t = "process" [@@bs.val]

  external cwd : unit -> string = "cwd" [@@bs.val] [@@bs.scope "process"]

  external platform : string = "platform" [@@bs.val] [@@bs.scope "process"]

  external env : string Js.Dict.t = "env" [@@bs.val] [@@bs.scope "process"]

  module Stdout = struct
    type t

    external v : t = "process.stdout" [@@bs.val]

    external write : t -> string -> unit = "write" [@@bs.send]
  end
end

module JsError = struct
  type t = < message : string > Js.t

  external make : string -> t = "Error" [@@bs.new]

  let ofPromiseError =
    [%raw fun error -> "return error.message || 'Unknown error'"]
end

module Buffer = struct
  type t = < byteLength : int > Js.t

  external toString : t -> string = "toString" [@@bs.send]

  external from : string -> t = "from" [@@bs.val] [@@bs.scope "Buffer"]

  let ofString = from
end

module type STREAM = sig
  type t

  val on : t -> string -> (Buffer.t -> unit) -> unit
end

module StreamFunctor (S : sig
  type t
end) =
struct
  type t = S.t

  external on : t -> string -> (Buffer.t -> unit) -> unit = "on" [@@bs.send]

  external write : t -> string -> unit = "write" [@@bs.send]

  external end_ : t -> unit = "end" [@@bs.send]
end

module Stream = StreamFunctor (struct
  type t
end)

module Fs = struct
  module E = struct
    type t = PathNotFound

    let toString = function
      | PathNotFound -> "mkdir(~p=true) received home path and it was not found"
  end

  module Stat = struct
    type t

    external isDirectory : t -> bool = "isDirectory" [@@bs.send]
  end

  external stat' :
    (string -> (JsError.t Js.Nullable.t -> Stat.t -> unit) -> unit[@bs])
    = "stat"
    [@@bs.module "fs"]

  let stat p =
    Promise.make (fun ~resolve ~reject:_ ->
        (stat' p (fun err stat ->
             (resolve
                ( match Js.Nullable.toOption err with
                | Some _e -> Error "Couldn't stat"
                | None -> Ok stat ) [@bs])) [@bs]))

  external readDir' :
    (string -> (JsError.t Js.Nullable.t -> string array -> unit) -> unit[@bs])
    = "readdir"
    [@@bs.module "fs"]

  let readDir path =
    Promise.make (fun ~resolve ~reject:_ ->
        (readDir' path (fun error files ->
             match Js.Nullable.toOption error with
             | Some error -> ( resolve (Error error##message) [@bs] )
             | None -> ( resolve (Ok files) [@bs] )) [@bs]))

  type fd

  external writeSync : (fd -> Buffer.t -> unit[@bs]) = "writeSync"
    [@@bs.module "fs"]

  external writeFile : string -> string -> unit Promise.t = "writeFile"
    [@@bs.module "./fs-stub.js"]

  external readFile : string -> string Promise.t = "readFile"
    [@@bs.module "./fs-stub.js"]

  external mkdir' : string -> unit Promise.t = "mkdir"
    [@@bs.module "./fs-stub.js"]

  external exists : string -> bool Promise.t = "exists"
    [@@bs.module "./fs-stub.js"]

  external open_ : string -> string -> fd Promise.t = "open"
    [@@bs.module "./fs-stub.js"]

  external write : fd -> Buffer.t -> unit Promise.t = "write"
    [@@bs.module "./fs-stub.js"]

  external close : fd -> Buffer.t -> unit Promise.t = "close"
    [@@bs.module "./fs-stub.js"]

  external createWriteStream : string -> Stream.t = "createWriteStream"
    [@@bs.module "fs"]

  external unlink : string -> bool Promise.t = "unlink"
    [@@bs.module "./fs-stub.js"]

  let rec mkdir ?p path =
    let forceCreate =
      match p with
      | Some x -> x
      | None -> false
    in
    let open Promise in
    if forceCreate then
      exists path
      |> then_ (fun doesExist ->
             if doesExist then
               resolve (Ok ())
             else
               let homePath =
                 Sys.getenv
                   ( match Sys.unix with
                   | true -> "HOME"
                   | false -> "USERPROFILE" )
               in
               if path = homePath then
                 resolve (Error E.PathNotFound)
               else
                 mkdir ~p:true (Filename.dirname path)
                 |> then_ (function
                      | Ok () ->
                        mkdir' path |> then_ (fun () -> resolve (Ok ()))
                      | Error e -> Error e |> resolve))
    else
      mkdir' path |> then_ (fun () -> resolve (Ok ()))
end

module ChildProcess = struct
  type t = < exitCode : int > Js.t

  external get_stdin : t -> Stream.t = "stdin" [@@bs.get]

  module Options = struct
    type t

    external make : ?cwd:string -> ?env:string Js.Dict.t -> unit -> t = ""
      [@@bs.obj]
  end

  external exec :
       string
    -> Options.t
    -> (JsError.t Js.Nullable.t -> string -> string -> unit)
    -> t = "exec"
    [@@bs.val] [@@bs.module "child_process"]

  type return =
    { exitCode : int
    ; stdout : string
    ; stderr : string
    }

  let exec cmd ?stdin options =
    Promise.make @@ fun ~resolve ~reject:_ ->
    let cp = ref [%bs.obj { exitCode = 0 }] in
    cp :=
      exec cmd options (fun err stdout stderr ->
          if Js.Nullable.isNullable err then (
            resolve (Ok { exitCode = !cp##exitCode; stdout; stderr }) [@bs]
          ) else (
            resolve (Error {j| Exec failed during $cmd |j}) [@bs]
          ));
    match stdin with
    | Some text ->
      let stdinStream = get_stdin !cp in
      Stream.write stdinStream text;
      Stream.end_ stdinStream
    | None -> ()
end

module Path = struct
  external join : string array -> string = "join"
    [@@bs.module "path"] [@@bs.variadic]

  external basename : string -> string = "basename" [@@bs.module "path"]

  external extname : string -> string = "extname" [@@bs.module "path"]

  external dirname : string -> string = "dirname" [@@bs.module "path"]

  external isAbsolute : string -> bool = "isAbsolute" [@@bs.module "path"]
end

module Response = struct
  type t = < statusCode : int ; headers : string Js.Dict.t > Js.t

  external setEncoding : t -> string -> unit = "setEncoding" [@@bs.send]

  external on : t -> string -> (Buffer.t -> unit) -> unit = "on" [@@bs.send]
end

module Request = struct
  external request : string -> Stream.t = "request" [@@bs.module]
end

module RequestProgress = struct
  type t

  type state =
    < percent : float
    ; speed : int
    ; size : < total : int ; transferred : int > Js.t
    ; time : < elapsed : float ; remaining : float > Js.t >
    Js.t

  external requestProgress : Stream.t -> t = "request-progress" [@@bs.module]

  external onData' : t -> string -> (Buffer.t -> unit) -> unit = "on"
    [@@bs.send]

  let onData t cb = onData' t "data" cb

  external onProgress' : t -> string -> (state -> unit) -> unit = "on"
    [@@bs.send]

  let onProgress t cb = onProgress' t "progress" cb

  external onError' : t -> string -> (JsError.t -> unit) -> unit = "on"
    [@@bs.send]

  let onError t cb = onError' t "error" cb

  external onEnd' : t -> string -> (unit -> unit) -> unit = "on" [@@bs.send]

  let onEnd t cb = onEnd' t "end" cb

  external pipe : t -> Stream.t -> unit = "pipe" [@@bs.send]
end

module Https = struct
  module E = struct
    type t = Failure of string

    let toString = function
      | Failure url -> {j|Failed to place request to $url|j}
  end

  external get : string -> (Response.t -> unit) -> unit = "get"
    [@@bs.module "https"]

  let getCompleteResponse url =
    Promise.make (fun ~resolve ~reject:_ ->
        get url (fun response ->
            let _statusCode = response##statusCode in
            let responseText = ref "" in
            Response.on response "data" (fun c ->
                responseText := !responseText ^ Buffer.toString c);
            Response.on response "end" (fun _ ->
                (resolve (Ok !responseText) [@bs]));
            Response.on response "error" (fun _err ->
                (resolve
                   (Error
                      (E.Failure
                         {j|Error occurred while placing request to $url|j} [@explicit_arity
                                                                              ]))
                 [@bs]))))
end

module Os = struct
  external tmpdir : unit -> string = "tmpdir" [@@bs.module "os"]
end
