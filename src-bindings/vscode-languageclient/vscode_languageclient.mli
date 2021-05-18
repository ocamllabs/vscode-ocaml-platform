open Es2015

module Reveal_output_channel_on : sig
  type t =
    | Info [@js 1]
    | Warn [@js 2]
    | Error [@js 3]
    | Never [@js 4]
  [@@js.enum]
end

module Server_capabilities : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val experimental : t -> Json.t or_undefined [@@js.get]

  val create : ?experimental:Json.t -> unit -> t [@@js.builder]
end

module Initialize_result : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  type server_info =
    { name : string
    ; version : string or_undefined
    }

  val capabilities : t -> Server_capabilities.t [@@js.get]

  val server_info : t -> server_info or_undefined [@@js.get "serverInfo"]
end

module Document_filter : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

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

module Document_selector : sig
  type selector =
    ([ `Filter of Document_filter.t
     | `String of string
     ]
    [@js.union])

  [@@@js.implem
  let selector_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> `Filter ([%js.to: Document_filter.t] js_val)]

  type t = selector array

  [@@@js.stop]

  val language : ?scheme:string -> ?pattern:string -> string -> selector

  [@@@js.start]

  [@@@js.implem
  let language ?(scheme = "file") ?pattern l =
    `Filter (Document_filter.create_language ~language:l ~scheme ?pattern ())]
end

module Client_options : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val document_selector : t -> Document_selector.t or_undefined
    [@@js.get "documentSelector"]

  val output_channel : t -> Vscode.Output_channel.t or_undefined
    [@@js.get "outputChannel"]

  val reveal_output_channel_on : t -> Reveal_output_channel_on.t
    [@@js.get "revealOutputChannelOn"]

  val create :
       ?document_selector:Document_selector.t
    -> ?output_channel:Vscode.Output_channel.t
    -> ?reveal_output_channel_on:Reveal_output_channel_on.t
    -> unit
    -> t
    [@@js.builder]
end

module Executable_options : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_cwd : t -> string [@@js.get "cwd"]

  val set_cwd : t -> string -> unit [@@js.set "cwd"]

  val get_env : t -> any [@@js.get "env"]

  val set_env : t -> any -> unit [@@js.set "env"]

  val get_detached : t -> bool [@@js.get "detached"]

  val set_detached : t -> bool -> unit [@@js.set "detached"]

  val get_shell : t -> bool [@@js.get "shell"]

  val set_shell : t -> bool -> unit [@@js.set "shell"]

  val create :
    ?cwd:string -> ?env:any -> ?detached:bool -> ?shell:bool -> unit -> t
    [@@js.builder]
end

module Executable : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val command : t -> string [@@js.get]

  val args : t -> string list or_undefined [@@js.get]

  val options : t -> Executable_options.t or_undefined [@@js.get]

  val create :
       command:string
    -> ?args:string list
    -> ?options:Executable_options.t
    -> unit
    -> t
    [@@js.builder]
end

module Server_options : sig
  include module type of struct
    include Executable
  end
end

module Language_client : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val make :
       id:string
    -> name:string
    -> server_options:Server_options.t
    -> client_options:Client_options.t
    -> ?forceDebug:bool
    -> unit
    -> t
    [@@js.new "vscode_languageclient.LanguageClient"]

  val start : t -> unit [@@js.call]

  val stop : t -> unit [@@js.call]

  val on_ready : t -> unit Promise.t [@@js.call "onReady"]

  val initialize_result : t -> Initialize_result.t [@@js.get "initializeResult"]

  val send_request :
       t
    -> meth:string
    -> data:Json.t
    -> ?token:Vscode.Cancellation_token.t
    -> unit
    -> Json.t Promise.t
    [@@js.call "sendRequest"]

  [@@@js.stop]

  val ready_initialize_result : t -> Initialize_result.t Promise.t

  [@@@js.start]

  [@@@js.implem
  let ready_initialize_result t =
    Promise.then_ (on_ready t)
      ~onfulfilled:(fun () -> Promise.resolve @@ initialize_result t)
      ()]
end
