open Interop

module Process = struct
  val cwd : unit -> string [@@js.global "process.cwd"]

  val platform : string [@@js.global "process.platform"]

  val env : unit -> string Dict.t [@@js.get "process.env"]

  let set_env key value =
    Ojs.set (Ojs.variable "process") key (Ojs.string_to_js value)
end

module JsError = struct
  type t = Promise.error [@@js]

  let ofPromiseError (error : Promise.error) =
    let js_error = Promise.error_to_js error in
    if Ojs.has_property js_error "message" then
      Ojs.string_of_js (Ojs.get js_error "message")
    else
      "Unknown error"
end

module Buffer = struct
  type t = private Ojs.t [@@js]

  val to_string : t -> string [@@js.call]

  val from : string -> t [@@js.global "Buffer.from"]

  val concat : t array -> t [@@js.global "Buffer.concat"]
end

module Stream = struct
  type t = private Ojs.t [@@js]

  val on : t -> string -> (Buffer.t -> unit) -> unit [@@js.call]

  val write : t -> string -> unit [@@js.call]

  val end_ : t -> unit [@@js.call]
end

module Fs = struct
  val read_dir : string -> string list Promise.t [@@js.global "fs.readDir"]

  let read_dir path =
    read_dir path
    |> Promise.then_ ~fulfilled:Promise.Result.return
    |> Promise.catch ~rejected:(fun error ->
           Promise.return (Error (JsError.ofPromiseError error)))

  val read_file : string -> string Promise.t [@@js.global "fs.readFile"]

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
        ; stdout = Buffer.to_string !stdout
        ; stderr = Buffer.to_string !stderr
        } );

    match stdin with
    | Some text ->
      Stream.write (get_stdin cp) text;
      Stream.end_ (get_stdin cp)
    | None -> ()
end
