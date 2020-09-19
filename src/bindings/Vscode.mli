module Disposable : sig
  type t

  val create : dispose:(unit -> unit) -> t

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

module Uri : sig
  type t =
    { scheme : string
    ; fsPath : string
    }

  type change =
    < authority : string
    ; fragment : string
    ; path : string
    ; query : string
    ; scheme : string >
    Js.t

  val make_change :
       ?authority:string
    -> ?fragment:string
    -> ?path:string
    -> ?query:string
    -> ?scheme:string
    -> unit
    -> change

  val file : string -> t

  val with_ : t -> change -> t

  val parse : ?strict:bool -> string -> t

  val toString : t -> ?skipEncoding:bool -> unit -> string
end

module TextDocument : sig
  type event = { uri : Uri.t }

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
    ; uri : Uri.t
    ; version : int
    }

  val getText : t -> Range.t -> string

  val lineAt : t -> int -> TextLine.t
end

module StatusBarAlignment : sig
  type t =
    | Left
    | Right
  [@@bs.deriving { jsConverter = newType }]
end

module StatusBarItem : sig
  type t =
    < alignment : StatusBarAlignment.abs_t
    ; priority : int
    ; text : string [@bs.set]
    ; tooltip : string [@bs.set]
    ; color : string [@bs.set]
    ; command : string [@bs.set] >
    Js.t

  val dispose : t -> unit

  val hide : t -> unit

  val show : t -> unit
end

module Commands : sig
  val get : filterInternal:bool -> string array Promise.t

  val register : command:string -> handler:(unit -> unit) -> Disposable.t

  val executeCommand : command:string -> args:'a list -> unit Promise.t
end

module ExtensionContext : sig
  type t

  val subscribe : t -> Disposable.t -> unit
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

module ViewColumn : sig
  type t
end

module TextEditor : sig
  type t
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

  module InputBoxOptions : sig
    type t

    external make :
         ?ignoreFocusOut:bool
      -> ?password:bool
      -> ?placeHolder:string
      -> ?prompt:string
      -> ?value:string
      -> ?validateInput:(string -> string option)
      -> unit
      -> t = ""
      [@@bs.obj]
  end

  val showQuickPick :
    string array -> QuickPickOptions.t -> string option Promise.t

  val showQuickPickItems :
    (QuickPickItem.t * 'a) list -> QuickPickOptions.t -> 'a option Promise.t

  val showInputBox : InputBoxOptions.t -> string option Promise.t

  val showInformationMessage : string -> unit Promise.t

  val showInformationMessage' :
    string -> (string * 'a) list -> 'a option Promise.t

  val showErrorMessage : string -> 'a Promise.t

  val showWarningMessage : string -> unit Promise.t

  type activeTextEditor = { document : TextDocument.t }

  and line = { range : range }

  and range =
    { start : rangeEdge
    ; end_ : rangeEdge [@bs.as "end"]
    }

  and rangeEdge = { character : int }

  val activeTextEditor : unit -> activeTextEditor option

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

  val createStatusBarItem :
       ?alignment:StatusBarAlignment.abs_t
    -> ?priority:int
    -> unit
    -> StatusBarItem.t

  type textDocumentShowOptions

  val textDocumentShowOptions :
       ?preserveFocus:bool
    -> ?preview:bool
    -> ?selection:Range.t
    -> ?viewColumn:ViewColumn.t
    -> unit
    -> textDocumentShowOptions

  val showTextDocument :
       ?options:textDocumentShowOptions
    -> [ `Uri of Uri.t | `Document of TextDocument.t ]
    -> TextEditor.t Promise.t

  module Terminal : sig
    type t

    val dispose : t -> unit

    val hide : t -> unit

    val sendText : t -> string -> ?addNewLine:bool -> unit -> unit

    val show : t -> ?preserveFocus:bool -> unit -> unit
  end

  val createTerminal :
       ?name:string
    -> ?shellPath:string
    -> ?shellArgs:string array
    -> unit
    -> Terminal.t

  module OutputChannel : sig
    type t = { name : string }

    val append : t -> string -> unit

    val appendLine : t -> string -> unit

    val clear : t -> unit

    val dispose : t -> unit

    val hide : t -> unit

    val show : t -> ?preserveFocus:bool -> unit -> unit
  end

  val createOutputChannel : string -> OutputChannel.t
end

module Folder : sig
  type t =
    { uri : Uri.t
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

  val getWorkspaceFolder : Uri.t -> Folder.t option

  val onDidChangeWorkspaceFolders :
    (workspaceFoldersChangeEvent -> unit) -> unit

  val textDocuments : unit -> TextDocument.event array

  val getConfiguration : ?section:string -> unit -> WorkspaceConfiguration.t

  val findFiles :
       inc:string
    -> excl:string option
    -> maxResults:int option
    -> cancellationToken option
    -> Uri.t array Js.Promise.t

  type openTextDocumentOptions

  val openTextDocumentOptions :
    content:string -> language:string -> openTextDocumentOptions

  val openTextDocument :
       [ `Filename of string
       | `Uri of Uri.t
       | `Interactive of openTextDocumentOptions option
       ]
    -> TextDocument.t Promise.t
end

module ThemeIcon : sig
  type t

  val file : t

  val folder : t

  val make : id:string -> t
end

type iconsByColorTheme = < dark : Uri.t ; light : Uri.t > Js.t

type workpaceEditEntryMetadata =
  < description : string option
  ; iconPath :
      [ `Uri of Uri.t
      | `IconsByColorTheme of iconsByColorTheme
      | `ThemeIcon of ThemeIcon.t
      ]
  ; label : string
  ; needsConfirmation : bool >
  Js.t

module WorkspaceEdit : sig
  type t

  type createFileOptions

  val createFileOptions :
    ignoreIfExists:bool -> overwrite:bool -> createFileOptions

  val create : unit -> t

  val createFile :
       t
    -> ?options:createFileOptions
    -> ?metadata:workpaceEditEntryMetadata
    -> Uri.t
    -> unit
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
    type serverCapabilities = { experimental : Js.Json.t Js.Nullable.t }

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
    ; outputChannel : Window.OutputChannel.t [@bs.optional]
    ; revealOutputChannelOn : RevealOutputChannelOn.abs_t [@bs.optional]
    }
  [@@bs.deriving abstract]

  type processOptions =
    { env : string Js.Dict.t
    ; shell : bool (* accepts shell path (string) as well  *)
    }

  type serverOptions =
    { command : string
    ; args : string array
    ; options : processOptions
    }

  type t

  val make :
       id:string
    -> name:string
    -> serverOptions:serverOptions
    -> clientOptions:clientOptions
    -> t

  val stop : t -> unit

  val start : t -> unit

  val onReady : t -> unit Promise.t

  val sendRequest :
       t
    -> meth:string
    -> data:'a
    -> ?token:Workspace.cancellationToken
    -> unit
    -> 'b Promise.t

  val initializeResult : t -> InitializeResult.t Promise.t
end

module ShellExecution : sig
  type escape =
    { charsToEscape : string
    ; escapeChar : string
    }

  type shellQuotingOptions =
    { escape : escape option
    ; strong : string option
    ; weak : string option
    }

  type shellExecutionOptions =
    { cwd : string option
    ; env : string Js.Dict.t option
    ; executable : string option
    ; shellArgs : string array option
    ; shellQuoting : shellQuotingOptions option
    }

  type t =
    { args : string array option
    ; command : string option
    ; commandLine : string option
    ; options : shellExecutionOptions option
    }

  val makeCommandLine :
    commandLine:string -> ?options:shellExecutionOptions -> unit -> t

  val makeCommand :
       command:string
    -> args:string array
    -> ?options:shellExecutionOptions
    -> unit
    -> t
end

module ProcessExecution : sig
  type processExecutionOptions =
    { cwd : string option
    ; env : string Js.Dict.t option
    }

  type t =
    { args : string array
    ; options : processExecutionOptions option
    ; process : string
    }

  val make :
       process:string
    -> args:string array
    -> options:processExecutionOptions option
    -> t
end

module TaskGroup : sig
  type t

  val build : t

  val clean : t

  val rebuild : t

  val test : t

  val make : id:string -> label:string -> t
end

module Task : sig
  type taskDefinition = { type_ : string [@bs.as "type"] }

  type t = { mutable group : TaskGroup.t option }

  type scope =
    | Folder of Folder.t
    | Global
    | Workspace

  val make :
       ?group:TaskGroup.t
    -> taskDefinition:taskDefinition
    -> scope:scope
    -> name:string
    -> source:string
    -> execution:[ `Shell of ShellExecution.t | `Process of ProcessExecution.t ]
    -> problemMatchers:string array
    -> unit
    -> t
end

module TaskProvider : sig
  type t =
    { provideTasks :
        (Workspace.cancellationToken option -> Task.t array option Promise.t
        [@bs])
    ; resolveTask :
        (Task.t -> Workspace.cancellationToken option -> Task.t option Promise.t
        [@bs])
    }
end

module Tasks : sig
  val registerTaskProvider :
    typ:string -> provider:TaskProvider.t -> Disposable.t
end

module Env : sig
  val shell : unit -> string
end
