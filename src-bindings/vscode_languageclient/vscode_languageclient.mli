open Interop

module RevealOutputChannelOn : sig
  type t =
    | Info
    | Warn
    | Error
    | Never

  include Ojs.T with type t := t
end

module ServerCapabilities : sig
  include Ojs.T

  val experimental : t -> Jsonoo.t option

  val create : ?experimental:Jsonoo.t -> unit -> t
end

module InitializeResult : sig
  include Ojs.T

  val capabilities : t -> ServerCapabilities.t

  type serverInfo =
    { name : string
    ; version : string option
    }

  val serverInfo : t -> serverInfo option
end

module DocumentFilter : sig
  include Ojs.T

  val language : t -> string option

  val scheme : t -> string option

  val pattern : t -> string option

  val createLanguage :
    language:string -> ?scheme:string -> ?pattern:string -> unit -> t

  val createScheme :
    ?language:string -> scheme:string -> ?pattern:string -> unit -> t

  val createPattern :
    ?language:string -> ?scheme:string -> pattern:string -> unit -> t
end

module DocumentSelector : sig
  type selector =
    [ `Filter of DocumentFilter.t
    | `String of string
    ]

  type t = selector array

  include Ojs.T with type t := t

  val language : ?scheme:string -> ?pattern:string -> string -> selector
end

module OcamllspSettingEnable : sig
  include Ojs.T

  val enable : t -> bool option

  val create : enable:bool -> unit -> t
end

module OcamllspSettings : sig
  include Ojs.T

  val codelens : t -> OcamllspSettingEnable.t option

  val extendedHover : t -> OcamllspSettingEnable.t option

  val create :
       ?codelens:OcamllspSettingEnable.t
    -> ?extendedHover:OcamllspSettingEnable.t
    -> unit
    -> t
end

module ClientOptions : sig
  include Ojs.T

  val documentSelector : t -> DocumentSelector.t option

  val outputChannel : t -> Vscode.OutputChannel.t option

  val revealOutputChannelOn : t -> RevealOutputChannelOn.t

  val initializationOptions : t -> Jsonoo.t

  val create :
       ?documentSelector:DocumentSelector.t
    -> ?outputChannel:Vscode.OutputChannel.t
    -> ?revealOutputChannelOn:RevealOutputChannelOn.t
    -> ?initializationOptions:Jsonoo.t
    -> unit
    -> t
end

module ExecutableOptions : sig
  include Ojs.T

  val cwd : t -> string option

  val env : t -> string Interop.Dict.t option

  val detached : t -> bool option

  val shell : t -> bool option

  val create :
       ?cwd:string
    -> ?env:string Interop.Dict.t
    -> ?detached:bool
    -> ?shell:bool
    -> unit
    -> t
end

module Executable : sig
  include Ojs.T

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

module InitializeParams : sig
  include Ojs.T
end

module ClientCapabilities : sig
  include Ojs.T

  val experimental : t -> Jsonoo.t or_undefined

  val set_experimental : t -> Jsonoo.t or_undefined -> unit
end

module StaticFeature : sig
  include Ojs.T

  val make :
       ?fillInitializeParams:(params:InitializeParams.t -> unit)
    -> fillClientCapabilities:(capabilities:ClientCapabilities.t -> unit)
    -> initialize:
         (   capabilities:ServerCapabilities.t
          -> documentSelector:DocumentSelector.t or_undefined
          -> unit)
    -> clear:(unit -> unit)
    -> unit
    -> t
end

module DidChangeConfiguration : sig
  include Ojs.T

  val create : settings:OcamllspSettings.t -> unit -> t
end

module LanguageClient : sig
  include Ojs.T

  val make :
       id:string
    -> name:string
    -> serverOptions:ServerOptions.t
    -> clientOptions:ClientOptions.t
    -> ?forceDebug:bool
    -> unit
    -> t

  val start : t -> unit Promise.t

  val isRunning : t -> bool

  val stop : t -> unit Promise.t

  (* TODO: the return type should be [InitializeResult.t option] *)
  val initializeResult : t -> InitializeResult.t

  val sendRequest :
       t
    -> meth:string
    -> data:Jsonoo.t
    -> ?token:Vscode.CancellationToken.t
    -> unit
    -> Jsonoo.t Promise.t

  val registerFeature : t -> feature:StaticFeature.t -> unit

  val sendNotification : t -> string -> Ojs.t -> unit
end
