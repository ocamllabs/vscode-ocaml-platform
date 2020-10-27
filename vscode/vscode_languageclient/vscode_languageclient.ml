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
  type serverInfo =
    { name : string
    ; version : string or_undefined
    }
  [@@js]

  type t = private (* interface *) Ojs.t [@@js]

  val capabilities : t -> ServerCapabilities.t [@@js.get]

  val serverInfo : t -> serverInfo or_undefined [@@js.get]
end

module DocumentFilter = struct
  type t = private (* interface *) Ojs.t [@@js]

  val language : t -> string or_undefined [@@js.get]

  val scheme : t -> string or_undefined [@@js.get]

  val pattern : t -> string or_undefined [@@js.get]

  val createLanguage :
    language:string -> ?scheme:string -> ?pattern:string -> unit -> t
    [@@js.builder]

  val createScheme :
    ?language:string -> scheme:string -> ?pattern:string -> unit -> t
    [@@js.builder]

  val createPattern :
    ?language:string -> ?scheme:string -> pattern:string -> unit -> t
    [@@js.builder]
end

module DocumentSelector = struct
  type selector =
    ([ `Filter of DocumentFilter.t
     | `String of string
     ]
    [@js.union])
  [@@js]

  let selector_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> `Filter ([%js.to: DocumentFilter.t] js_val)

  type t = selector array [@@js]

  let language ?(scheme = "file") ?pattern l =
    `Filter (DocumentFilter.createLanguage ~language:l ~scheme ?pattern ())
end

module ClientOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val documentSelector : t -> DocumentSelector.t or_undefined [@@js.get]

  val outputChannel : t -> Vscode.OutputChannel.t or_undefined [@@js.get]

  val revealOutputChannelOn : t -> RevealOutputChannelOn.t [@@js.get]

  val create :
       ?documentSelector:DocumentSelector.t
    -> ?outputChannel:Vscode.OutputChannel.t
    -> ?revealOutputChannelOn:RevealOutputChannelOn.t
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

module ServerOptions = Executable

module LanguageClient = struct
  type t = private (* class *) Ojs.t [@@js]

  val make :
       id:string
    -> name:string
    -> serverOptions:ServerOptions.t
    -> clientOptions:ClientOptions.t
    -> ?forceDebug:bool
    -> unit
    -> t
    [@@js.new "vscode_languageclient.LanguageClient"]

  val start : t -> unit [@@js.call]

  val stop : t -> unit [@@js.call]

  val onReady : t -> Promise.void [@@js.call]

  val initializeResult : t -> InitializeResult.t [@@js.get]

  let readyInitializeResult t =
    let open Promise.Syntax in
    let+ () = onReady t in
    initializeResult t

  val sendRequest :
       t
    -> meth:string
    -> data:Jsonoo.t
    -> ?token:Vscode.CancellationToken.t
    -> unit
    -> Jsonoo.t Promise.t
    [@@js.call]
end
