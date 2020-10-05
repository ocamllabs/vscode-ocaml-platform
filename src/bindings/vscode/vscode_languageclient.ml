open Interop

module RevealOutputChannelOn = struct
  type t =
    | Info [@js 1]
    | Warn [@js 2]
    | Error [@js 3]
    | Never [@js 4]
  [@@js.enum] [@@js]
end

module ServerCapabilities = struct
  type t = private (* interface *) Ojs.t [@@js]

  val experimental : t -> Jsonoo.t or_undefined [@@js.get]

  val create : ?experimental:Jsonoo.t -> unit -> t [@@js.builder]
end

module InitializeResult = struct
  type server_info =
    { name : string
    ; version : string or_undefined
    }
  [@@js]

  type t = private (* interface *) Ojs.t [@@js]

  val capabilities : t -> ServerCapabilities.t [@@js.get]

  val server_info : t -> server_info or_undefined [@@js.get]
end

module DocumentFilter = struct
  type t = private (* interface *) Ojs.t [@@js]

  val language : t -> string or_undefined [@@js.get]

  val scheme : t -> string or_undefined [@@js.get]

  val pattern : t -> string or_undefined [@@js.get]

  val create_language :
    language:string -> ?scheme:string -> ?pattern:string -> unit -> t
    [@@js.builder]

  val create_scheme :
    ?language:string -> scheme:string -> ?pattern:string -> unit -> t
    [@@js.builder]

  val create_pattern :
    ?language:string -> ?scheme:string -> pattern:string -> unit -> t
    [@@js.builder]
end

module DocumentSelector = struct
  type selectors =
    ([ `Filter of DocumentFilter.t
     | `String of string
     ]
    [@js.union])
  [@@js]

  let selectors_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> `Filter (DocumentFilter.t_of_js js_val)

  type t = selectors array [@@js]

  let language ?(scheme = "file") ?pattern l =
    `Filter (DocumentFilter.create_language ~language:l ~scheme ?pattern ())
end

module ClientOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val document_selector : t -> DocumentSelector.t or_undefined [@@js.get]

  val output_channel : t -> Vscode_core.OutputChannel.t or_undefined [@@js.get]

  val reveal_output_channel_on : t -> RevealOutputChannelOn.t [@@js.get]

  val create :
       ?document_selector:DocumentSelector.t
    -> ?output_channel:Vscode_core.OutputChannel.t
    -> ?reveal_output_channel_on:RevealOutputChannelOn.t
    -> unit
    -> t
    [@@js.builder]
end

module ExecutableOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val cwd : t -> string or_undefined [@@js.get]

  val env : t -> string Dict.t or_undefined [@@js.get]

  val detached : t -> bool or_undefined [@@js.get]

  val shell : t -> bool or_undefined [@@js.get]

  val create :
       ?cwd:string
    -> ?env:string Dict.t
    -> ?detached:bool
    -> ?shell:bool
    -> unit
    -> t
    [@@js.builder]
end

module Executable = (* interface *) struct
  type t = private Ojs.t [@@js]

  val command : t -> string [@@js.get]

  val args : t -> string list or_undefined [@@js.get]

  val options : t -> ExecutableOptions.t or_undefined [@@js.get]

  val create :
       command:string
    -> ?args:string list
    -> ?options:ExecutableOptions.t
    -> unit
    -> t
    [@@js.builder]
end

module ServerOptions = Executable (* TODO other union types *)

module LanguageClient = struct
  type t = private (* class *) Ojs.t [@@js]

  val make :
       id:string
    -> name:string
    -> server_options:ServerOptions.t
    -> client_options:ClientOptions.t
    -> ?force_debug:bool
    -> unit
    -> t
    [@@js.new "vscode_languageclient.LanguageClient"]

  val start : t -> unit [@@js.call]

  val stop : t -> unit [@@js.call]

  val on_ready : t -> Promise.void [@@js.call]

  val initialize_result : t -> InitializeResult.t [@@js.get]

  let ready_initialize_result t =
    let open Promise.Syntax in
    on_ready t >>= fun () -> Promise.return (initialize_result t)

  val send_request :
       t
    -> meth:string
    -> data:Jsonoo.t
    -> ?token:Vscode_core.CancellationToken.t
    -> unit
    -> Jsonoo.t Promise.t
    [@@js.call]
end

include LanguageClient
