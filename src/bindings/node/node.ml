open Interop

let __filename () =
  Js_of_ocaml.Js.Unsafe.eval_string "__filename" |> Js_of_ocaml.Js.to_string

let __dirname () =
  Js_of_ocaml.Js.Unsafe.eval_string "__dirname" |> Js_of_ocaml.Js.to_string

module Timeout = struct
  include Class.Make ()

  val hasRef : t -> bool [@@js.get]

  val ref : t -> t [@@js.get]

  val refresh : t -> t [@@js.get]

  val unref : t -> t [@@js.get]
end

val setInterval : (unit -> unit) -> int -> Timeout.t [@@js.global]

val setTimeout : (unit -> unit) -> int -> Timeout.t [@@js.global]

module Process = struct
  val cwd : unit -> string [@@js.global "process.cwd"]

  val platform : string [@@js.global "process.platform"]

  val arch : string [@@js.global "process.arch"]

  module Env = struct
    val env : Ojs.t [@@js.global "process.env"]

    let get k = [%js.to: string or_undefined] (Ojs.get env k)

    let set k v = Ojs.set env k ([%js.of: string] v)

    val env : string Interop.Dict.t [@@js.global "process.env"]
  end
end

module Os = struct
  val homedir : unit -> string [@@js.global "os.homedir"]
end

module JsError = struct
  type t = Promise.error [@@js]

  let message (error : t) =
    let js_error = [%js.of: t] error in
    if Ojs.has_property js_error "message" then
      [%js.to: string] (Ojs.get js_error "message")
    else
      "Unknown error"
end

module Buffer = struct
  include Class.Make ()

  val toString : t -> string [@@js.call]

  val from : string -> t [@@js.global "Buffer.from"]

  val concat : t list -> t [@@js.global "Buffer.concat"]

  let append buf other = buf := concat [ !buf; other ]

  val write :
       t
    -> string:string
    -> ?offset:int
    -> ?length:int
    -> ?encoding:string
    -> unit
    -> unit
    [@@js.call]
end

module Stream = struct
  module Writable = struct
    include Class.Make ()

    val on : t -> string -> Ojs.t -> unit [@@js.call]

    let on t = function
      | `Close f -> on t "close" @@ [%js.of: unit -> unit] f
      | `Drain f -> on t "drain" @@ [%js.of: unit -> unit] f
      | `Error f -> on t "error" @@ [%js.of: err:JsError.t -> unit] f
      | `Finish f -> on t "finish" @@ [%js.of: unit -> unit] f
      | `Pipe f -> on t "pipe" @@ [%js.of: src:t -> unit] f
      | `Unpipe f -> on t "unpipe" @@ [%js.of: src:t -> unit] f

    val write : t -> string -> unit [@@js.call]

    val end_ : t -> unit [@@js.call]
  end

  module Readable = struct
    include Class.Make ()

    val on : t -> string -> Ojs.t -> unit [@@js.call]

    type chunk =
      ([ `String of string
       | `Buffer of Buffer.t
       ]
      [@js.union])
    [@@js]

    let chunk_of_js js_val =
      match Ojs.type_of js_val with
      | "string" -> `String ([%js.to: string] js_val)
      | _ -> `Buffer ([%js.to: Buffer.t] js_val)

    let on t = function
      | `Close f -> on t "close" @@ [%js.of: unit -> unit] f
      | `Data f -> on t "data" @@ [%js.of: chunk:chunk -> unit] f
      | `End f -> on t "end" @@ [%js.of: unit -> unit] f
      | `Error f -> on t "error" @@ [%js.of: err:JsError.t -> unit] f
      | `Pause f -> on t "pause" @@ [%js.of: unit -> unit] f
      | `Readable f -> on t "readable" @@ [%js.of: unit -> unit] f
      | `Resume f -> on t "resume" @@ [%js.of: unit -> unit] f
  end
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
  include Class.Make ()

  val get_stdout : t -> Stream.Readable.t [@@js.get "stdout"]

  val get_stderr : t -> Stream.Readable.t [@@js.get "stderr"]

  val get_stdin : t -> Stream.Writable.t [@@js.get "stdin"]

  val on : t -> string -> Ojs.t -> unit [@@js.call]

  let on t = function
    | `Close f -> on t "close" @@ [%js.of: code:int -> signal:string -> unit] f
    | `Disconnect f -> on t "disconnect" @@ [%js.of: unit -> unit] f
    | `Error f -> on t "error" @@ [%js.of: err:JsError.t -> unit] f
    | `Exit f -> on t "exit" @@ [%js.of: code:int -> signal:string -> unit] f
    | `Message f ->
      on t "message" @@ [%js.of: message:Ojs.t -> sendHandle:Ojs.t -> unit] f

  module Options = struct
    include Interface.Make ()

    val create : ?cwd:string -> ?env:string Dict.t -> unit -> t [@@js.builder]
  end

  type exec_result = private Ojs.t [@@js]

  val exec :
       string
    -> ?options:Options.t
    -> ?callback:(exec_result or_undefined -> string -> string -> unit)
    -> unit
    -> t
    [@@js.global "child_process.exec"]

  val spawn : string -> string array -> ?options:Options.t -> unit -> t
    [@@js.global "child_process.spawn"]

  type return =
    { exitCode : int
    ; stdout : string
    ; stderr : string
    }

  type event =
    | Spawned
    | Stdout of string
    | Stderr of string
    | Closed

  let handle_child_process ?logger ?stdin cp resolve =
    let log = Option.value logger ~default:ignore in

    log Spawned;

    let stdout = ref (Buffer.from "") in
    let on_stdout ~chunk =
      match chunk with
      | `String s ->
        Buffer.append stdout (Buffer.from s);
        log @@ Stdout s
      | `Buffer b ->
        Buffer.append stdout b;
        log @@ Stdout (Buffer.toString b)
    in
    Stream.Readable.on (get_stdout cp) (`Data on_stdout);

    let stderr = ref (Buffer.from "") in
    let on_stderr ~chunk =
      match chunk with
      | `String s ->
        Buffer.append stderr (Buffer.from s);
        log @@ Stderr s
      | `Buffer b ->
        Buffer.append stderr b;
        log @@ Stderr (Buffer.toString b)
    in
    Stream.Readable.on (get_stderr cp) (`Data on_stderr);

    let close ~code ~signal:_ =
      log Closed;
      resolve
        { exitCode = code
        ; stdout = Buffer.toString !stdout
        ; stderr = Buffer.toString !stderr
        }
    in
    on cp (`Close close);

    match stdin with
    | Some text ->
      Stream.Writable.write (get_stdin cp) text;
      Stream.Writable.end_ (get_stdin cp)
    | None -> ()

  let exec ?logger ?stdin ?options cmd =
    Promise.make @@ fun ~resolve ~reject:_ ->
    let cp = exec cmd ?options () in
    handle_child_process cp ?logger ?stdin resolve

  let spawn ?logger ?stdin ?options cmd args =
    Promise.make @@ fun ~resolve ~reject:_ ->
    let cp = spawn cmd args ?options () in
    handle_child_process cp ?logger ?stdin resolve
end
