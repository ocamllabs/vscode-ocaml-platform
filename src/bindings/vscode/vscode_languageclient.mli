module RevealOutputChannelOn : sig
  type t =
    | Info
    | Warn
    | Error
    | Never

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module ServerCapabilities : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val experimental : t -> Jsonoo.t option

  val create : ?experimental:Jsonoo.t -> unit -> t
end

module InitializeResult : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val capabilities : t -> ServerCapabilities.t

  type server_info =
    { name : string
    ; version : string option
    }

  val server_info : t -> server_info option
end

module DocumentFilter : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val language : t -> string option

  val scheme : t -> string option

  val pattern : t -> string option

  val create_language :
    language:string -> ?scheme:string -> ?pattern:string -> unit -> t

  val create_scheme :
    ?language:string -> scheme:string -> ?pattern:string -> unit -> t

  val create_pattern :
    ?language:string -> ?scheme:string -> pattern:string -> unit -> t
end

module DocumentSelector : sig
  type t = selectors array

  and selectors =
    [ `Filter of DocumentFilter.t
    | `String of string
    ]

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val language : ?scheme:string -> ?pattern:string -> string -> selectors
end

module ClientOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val document_selector : t -> DocumentSelector.t option

  val output_channel : t -> Vscode_core.OutputChannel.t option

  val reveal_output_channel_on : t -> RevealOutputChannelOn.t

  val create :
       ?document_selector:DocumentSelector.t
    -> ?output_channel:Vscode_core.OutputChannel.t
    -> ?reveal_output_channel_on:RevealOutputChannelOn.t
    -> unit
    -> t
end

module ExecutableOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val cwd : t -> string option

  val env : t -> (string, string) Core_kernel.Hashtbl.t option

  val detached : t -> bool option

  val shell : t -> bool option

  val create :
       ?cwd:string
    -> ?env:(string, string) Core_kernel.Hashtbl.t
    -> ?detached:bool
    -> ?shell:bool
    -> unit
    -> t
end

module Executable : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val command : t -> string

  val args : t -> string list option

  val options : t -> ExecutableOptions.t option

  val create :
       command:string
    -> ?args:string list
    -> ?options:ExecutableOptions.t
    -> unit
    -> t
end

module ServerOptions = Executable

module LanguageClient : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val make :
       id:string
    -> name:string
    -> server_options:ServerOptions.t
    -> client_options:ClientOptions.t
    -> ?force_debug:bool
    -> unit
    -> t

  val start : t -> unit

  val stop : t -> unit

  val on_ready : t -> Promise.void

  val initialize_result : t -> InitializeResult.t

  val ready_initialize_result : t -> InitializeResult.t Promise.t

  val send_request :
       t
    -> meth:string
    -> data:Jsonoo.t
    -> ?token:Vscode_core.CancellationToken.t
    -> unit
    -> Jsonoo.t Promise.t
end

include module type of LanguageClient
