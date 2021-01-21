open Interop

module Process = struct
  val cwd : unit -> string [@@js.global "process.cwd"]

  val platform : string [@@js.global "process.platform"]

  module Env = struct
    val env : Ojs.t [@@js.global "process.env"]

    let get k = [%js.to: string or_undefined] (Ojs.get env k)

    let set k v = Ojs.set env k ([%js.of: string] v)
  end
end

module JsError = struct
  let message (error : Promise.error) =
    let js_error = [%js.of: Promise.error] error in
    if Ojs.has_property js_error "message" then
      [%js.to: string] (Ojs.get js_error "message")
    else
      "Unknown error"
end

module Buffer = struct
  include Class.Make ()

  val toString : t -> string [@@js.call]

  val from : string -> t [@@js.global "Buffer.from"]

  val concat : t array -> t [@@js.global "Buffer.concat"]
end

module Stream = struct
  include Class.Make ()

  val on : t -> string -> (Buffer.t -> unit) -> unit [@@js.call]

  val write : t -> string -> unit [@@js.call]

  val end_ : t -> unit [@@js.call]
end

module Path = struct
  val delimiter : string [@@js.global "path.delimiter"]

  let delimiter =
    assert (String.length delimiter = 1);
    delimiter.[0]

  val basename : string -> string [@@js.global "path.basename"]

  val dirname : string -> string [@@js.global "path.dirname"]

  val extname : string -> string [@@js.global "path.extname"]

  val isAbsolute : string -> bool [@@js.global "path.isAbsolute"]

  val join : (string list[@js.variadic]) -> string [@@js.global "path.join"]
end

module Fs = struct
  val readDir : string -> string list Promise.t [@@js.global "fs.readDir"]

  let readDir path =
    readDir path
    |> Promise.then_ ~fulfilled:Promise.Result.return ~rejected:(fun error ->
           Promise.return (Error (JsError.message error)))

  val readFile : string -> encoding:string -> string Promise.t
    [@@js.global "fs.readFile"]

  let readFile = readFile ~encoding:"utf8"

  val exists : string -> bool Promise.t [@@js.global "fs.exists"]
end

module ChildProcess = struct
  type t = private Ojs.t [@@js]

  val get_stdout : t -> Stream.t [@@js.get "stdout"]

  val get_stderr : t -> Stream.t [@@js.get "stderr"]

  val get_stdin : t -> Stream.t [@@js.get "stdin"]

  val on : t -> string -> (int -> unit) -> unit [@@js.call]

  let on_close t close = on t "close" close

  module Options = struct
    type t = private Ojs.t [@@js]

    val create : ?cwd:string -> ?env:string Dict.t -> unit -> t [@@js.builder]
  end

  type exec_result = private Ojs.t [@@js]

  val code : exec_result -> int [@@js.get]

  val exec :
       string
    -> Options.t
    -> (exec_result or_undefined -> string -> string -> unit)
    -> t
    [@@js.global "child_process.exec"]

  type return =
    { exitCode : int
    ; stdout : string
    ; stderr : string
    }

  let exec cmd ?stdin options =
    Promise.make @@ fun ~resolve ~reject:_ ->
    let cp =
      exec cmd options (fun err stdout stderr ->
          let exitCode =
            match err with
            | None -> 0
            | Some err -> code err
          in
          resolve { exitCode; stdout; stderr })
    in
    match stdin with
    | Some text ->
      Stream.write (get_stdin cp) text;
      Stream.end_ (get_stdin cp)
    | None -> ()

  val spawn : string -> string array -> Options.t -> t
    [@@js.global "child_process.spawn"]

  let spawn cmd args ?stdin options =
    Promise.make @@ fun ~resolve ~reject:_ ->
    let cp = spawn cmd args options in

    let stdout = ref (Buffer.from "") in
    Stream.on (get_stdout cp) "data" (fun data ->
        stdout := Buffer.concat [| !stdout; data |]);

    let stderr = ref (Buffer.from "") in
    Stream.on (get_stderr cp) "data" (fun data ->
        stderr := Buffer.concat [| !stderr; data |]);

    ( on_close cp @@ fun code ->
      resolve
        { exitCode = code
        ; stdout = Buffer.toString !stdout
        ; stderr = Buffer.toString !stderr
        } );

    match stdin with
    | Some text ->
      Stream.write (get_stdin cp) text;
      Stream.end_ (get_stdin cp)
    | None -> ()
end
