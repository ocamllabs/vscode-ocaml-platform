module Disposable : sig
  type t

  val dispose : t -> unit
end

module Range : sig
  type t

  val make :
    startLine:int -> startCharacter:int -> endLine:int -> endCharacter:int -> t
end

module TextLine : sig
  type t =
    { firstNonWhitespaceCharacterIndex : int
    ; isEmptyOrWhitespace : bool
    ; lineNumber : int
    ; range : Range.t
    ; rangeIncludingLineBreak : Range.t
    ; text : string
    }
end

module TextEdit : sig
  type t

  val replace : Range.t -> string -> t
end

module TextDocument : sig
  type uri =
    { scheme : string
    ; fsPath : string
    }

  type event = { uri : uri }

  type endOfLine =
    | CRLF
    | LF
  [@@bs.deriving { jsConverter = newType }]

  type t =
    { eol : abs_endOfLine
    ; fileName : string
    ; isClosed : bool
    ; isDirty : bool
    ; isUntitled : bool
    ; languageId : string
    ; lineCount : int
    ; uri : uri
    ; version : int
    }

  val getText : t -> Range.t -> string

  val lineAt : t -> int -> TextLine.t
end

module Commands : sig
  val get : filterInternal:bool -> string array Promise.t

  val register : command:string -> handler:(unit -> unit) -> unit

  val executeCommand : command:string -> args:'a list -> unit Promise.t
end

module ExtensionContext : sig
  type t
end

module WorkspaceConfiguration : sig
  type t

  val get : t -> string -> Js.Json.t option

  type configurationTarget =
    | Global
    | Workspace
    | WorkspaceFolder
  [@@bs.deriving { jsConverter = newType }]

  val update :
    t -> string -> Js.Json.t -> abs_configurationTarget -> unit Promise.t
end

module Window : sig
  module QuickPickItem : sig
    type t

    val create :
         ?alwaysShow:bool
      -> ?description:string
      -> ?detail:string
      -> ?picked:bool
      -> label:string
      -> unit
      -> t
  end

  module QuickPickOptions : sig
    type t = < canPickMany : bool > Js.t

    val make : ?canPickMany:bool -> ?placeHolder:string -> unit -> t
  end

  val showQuickPick :
    string array -> QuickPickOptions.t -> string option Promise.t

  val showQuickPickItems :
    (QuickPickItem.t * 'a) list -> QuickPickOptions.t -> 'a option Promise.t

  val showInformationMessage : string -> unit Promise.t

  val showInformationMessage' :
    string -> (string * 'a) list -> 'a option Promise.t

  val showErrorMessage : string -> 'a Promise.t

  val showWarningMessage : string -> unit Promise.t

  type activeTextEditor = { document : document }

  and document =
    { getText : unit -> string
    ; lineAt : int -> line
    ; lineCount : int
    ; fileName : string
    }

  and line = { range : range }

  and range =
    { start : rangeEdge
    ; end_ : rangeEdge [@bs.as "end"]
    }

  and rangeEdge = { character : int }

  val activeTextEditor : activeTextEditor option

  type location =
    | SourceControl
    | Window
    | Notification
  [@@bs.deriving { jsConverter = newType }]

  type withProgressConfig = < title : string ; location : abs_location > Js.t

  type progress = { report : (< increment : int > Js.t -> unit[@bs]) }

  val withProgress :
       withProgressConfig
    -> (progress -> ('a, 'b) result Promise.t)
    -> ('a, 'b) result Promise.t
end

module Folder : sig
  type t =
    { uri : TextDocument.uri
    ; index : int
    ; name : string
    }
end

module Workspace : sig
  type workspaceFoldersChangeEvent =
    { added : Folder.t array
    ; removed : Folder.t array
    }

  type formattingOptions =
    { insertSpaces : bool
    ; tabSize : int
    }

  type cancellationToken = { isCancellationRequested : bool }

  val name : unit -> string option

  val workspaceFolders : unit -> Folder.t array

  val onDidOpenTextDocument : (TextDocument.event -> unit) -> unit

  val getWorkspaceFolder : TextDocument.uri -> Folder.t option

  val onDidChangeWorkspaceFolders :
    (workspaceFoldersChangeEvent -> unit) -> unit

  val textDocuments : TextDocument.event array

  val getConfiguration : string -> WorkspaceConfiguration.t
end

module Languages : sig
  type documentSelector =
    { scheme : string
    ; language : string
    }

  type documentFormattingEditProvider =
    { provideDocumentFormattingEdits :
        (   TextDocument.t
         -> Workspace.formattingOptions
         -> Workspace.cancellationToken
         -> TextEdit.t array Promise.t
        [@bs])
    }

  val registerDocumentFormattingEditProvider :
    documentSelector -> documentFormattingEditProvider -> Disposable.t
end

module LanguageClient : sig
  module RevealOutputChannelOn : sig
    type t =
      | Info
      | Warn
      | Error
      | Never
    [@@bs.deriving { jsConverter = newType }]
  end

  module InitializeResult : sig
    type experimental =
      { ocamlInterface : bool Js.Nullable.t [@bs.as "ocaml.interface"] }

    type serverCapabilities = { experimental : experimental }

    type serverInfo =
      { name : string
      ; version : string Js.Nullable.t
      }

    type t =
      { capabilities : serverCapabilities
      ; serverInfo : serverInfo Js.Nullable.t
      }
  end

  type documentSelectorItem =
    { scheme : string
    ; language : string
    }

  type clientOptions =
    { documentSelector : documentSelectorItem array
    ; revealOutputChannelOn : RevealOutputChannelOn.abs_t [@bs.optional]
    }
  [@@bs.deriving abstract]

  type processOptions = { env : string Js.Dict.t }

  type serverOptions =
    { command : string
    ; args : string array
    ; options : processOptions
    }

  type t =
    { start : (unit -> unit[@bs])
    ; stop : (unit -> unit[@bs])
    ; initializeResult : InitializeResult.t
    }

  val make :
       id:string
    -> name:string
    -> serverOptions:serverOptions
    -> clientOptions:clientOptions
    -> t

  val onReady : t -> unit Promise.t
end
