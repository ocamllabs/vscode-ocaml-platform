module Disposable = struct
  type t

  external create : dispose:(unit -> unit) -> t = "" [@@bs.obj]

  external dispose : t -> unit = "dispose" [@@bs.send]
end

module Range = struct
  type t

  external make :
    startLine:int -> startCharacter:int -> endLine:int -> endCharacter:int -> t
    = "Range"
    [@@bs.module "vscode"] [@@bs.new]
end

module TextLine = struct
  type t =
    { firstNonWhitespaceCharacterIndex : int
    ; isEmptyOrWhitespace : bool
    ; lineNumber : int
    ; range : Range.t
    ; rangeIncludingLineBreak : Range.t
    ; text : string
    }
end

module TextEdit = struct
  type t

  external replace : Range.t -> string -> t = "replace"
    [@@bs.module "vscode"] [@@bs.scope "TextEdit"]
end

module TextDocument = struct
  type uri =
    { scheme : string
    ; fsPath : string
    }

  type event = { uri : uri }

  type endOfLine =
    | CRLF [@bs.as 2]
    | LF [@bs.as 1]
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

  external getText : t -> Range.t -> string = "getText" [@@bs.send]

  external lineAt : t -> int -> TextLine.t = "lineAt" [@@bs.send]
end

module Folder = struct
  type t =
    { uri : TextDocument.uri
    ; index : int
    ; name : string
    }
end

module ViewColumn = struct
  type t
end

module TextEditor = struct
  type t
end

module WorkspaceConfiguration = struct
  type t

  external get : t -> string -> Js.Json.t option = "get" [@@bs.send]

  type configurationTarget =
    | Global [@bs.as 1]
    | Workspace [@bs.as 2]
    | WorkspaceFolder
  [@@bs.deriving { jsConverter = newType }]

  external update :
    t -> string -> Js.Json.t -> abs_configurationTarget -> unit Promise.t
    = "update"
    [@@bs.send]
end

module Workspace = struct
  type workspaceFoldersChangeEvent =
    { added : Folder.t array
    ; removed : Folder.t array
    }

  type formattingOptions =
    { insertSpaces : bool
    ; tabSize : int
    }

  type cancellationToken = { isCancellationRequested : bool }

  external _name : string option = "name"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]

  let name () = _name

  external _workspaceFolders : Folder.t array option = "workspaceFolders"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]

  let workspaceFolders () = _workspaceFolders |. Belt.Option.getWithDefault [||]

  external onDidOpenTextDocument : (TextDocument.event -> unit) -> unit
    = "onDidOpenTextDocument"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]

  external getWorkspaceFolder : TextDocument.uri -> Folder.t option
    = "getWorkspaceFolder"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]

  external onDidChangeWorkspaceFolders :
    (workspaceFoldersChangeEvent -> unit) -> unit
    = "onDidChangeWorkspaceFolders"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]

  external _textDocuments : TextDocument.event array = "textDocuments"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]

  let textDocuments () = _textDocuments

  external getConfiguration :
    ?section:string -> unit -> WorkspaceConfiguration.t = "getConfiguration"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]

  external findFiles :
       inc:string
    -> excl:string option
    -> maxResults:int option
    -> cancellationToken option
    -> TextDocument.uri array Js.Promise.t = "findFiles"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]

  external _openTextDocument :
       ([ `Filename of string | `Uri of TextDocument.uri ][@bs.unwrap])
    -> TextDocument.t Promise.t = "openTextDocument"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]

  type openTextDocumentOptions = < content : string ; language : string > Js.t

  external openTextDocumentOptions :
    content:string -> language:string -> openTextDocumentOptions = ""
    [@@bs.obj]

  external _openTextDocumentInteractive :
    ?interactive:openTextDocumentOptions -> TextDocument.t Promise.t
    = "openTextDocument"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]

  let openTextDocument t =
    match t with
    | `Interactive interactive -> _openTextDocumentInteractive ?interactive
    | `Filename _ as t -> _openTextDocument t
    | `Uri _ as t -> _openTextDocument t
end

module StatusBarAlignment = struct
  type t =
    | Left [@bs.as 1]
    | Right [@bs.as 2]
  [@@bs.deriving { jsConverter = newType }]
end

module StatusBarItem = struct
  type t =
    < alignment : StatusBarAlignment.abs_t
    ; priority : int
    ; text : string [@bs.set]
    ; tooltip : string [@bs.set]
    ; color : string [@bs.set]
    ; command : string [@bs.set] >
    Js.t

  external dispose : t -> unit = "dispose" [@@bs.send]

  external hide : t -> unit = "hide" [@@bs.send]

  external show : t -> unit = "show" [@@bs.send]
end

module Window = struct
  module QuickPickItem = struct
    type t

    external create :
         ?alwaysShow:bool
      -> ?description:string
      -> ?detail:string
      -> ?picked:bool
      -> label:string
      -> unit
      -> t = ""
      [@@bs.obj]
  end

  module QuickPickOptions = struct
    type t = < canPickMany : bool > Js.t

    external make : ?canPickMany:bool -> ?placeHolder:string -> unit -> t = ""
      [@@bs.obj]
  end

  module InputBoxOptions = struct
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

  module MessageItem = struct
    type t

    external create : ?title:string -> unit -> t = "" [@@bs.obj]
  end

  external showQuickPick :
    string array -> QuickPickOptions.t -> string option Promise.t
    = "showQuickPick"
    [@@bs.module "vscode"] [@@bs.scope "window"]

  external _showQuickPickItems :
       QuickPickItem.t array
    -> QuickPickOptions.t
    -> QuickPickItem.t option Promise.t = "showQuickPick"
    [@@bs.module "vscode"] [@@bs.scope "window"]

  let showQuickPickItems choices options =
    _showQuickPickItems (Array.of_list (List.map fst choices)) options
    |> Promise.map (fun choice ->
           choice |. Belt.Option.map (fun q -> List.assq q choices))

  external showInputBox : InputBoxOptions.t -> string option Promise.t
    = "showInputBox"
    [@@bs.module "vscode"] [@@bs.scope "window"]

  external showInformationMessage : string -> unit Promise.t
    = "showInformationMessage"
    [@@bs.module "vscode"] [@@bs.scope "window"]

  external _showInformationMessage' :
    string -> MessageItem.t array -> MessageItem.t option Promise.t
    = "showInformationMessage"
    [@@bs.module "vscode"] [@@bs.scope "window"] [@@bs.variadic]

  let showInformationMessage' msg choices =
    let choices =
      List.map
        (fun (title, choice) -> (MessageItem.create ~title (), choice))
        choices
    in
    _showInformationMessage' msg (choices |> List.map fst |> Array.of_list)
    |> Promise.map (fun choice ->
           choice |. Belt.Option.map (fun q -> List.assq q choices))

  external showErrorMessage : string -> 'a Promise.t = "showErrorMessage"
    [@@bs.module "vscode"] [@@bs.scope "window"]

  external showWarningMessage' : string -> 'a Promise.t = "showWarningMessage"
    [@@bs.module "vscode"] [@@bs.scope "window"]

  let showWarningMessage m =
    showWarningMessage' m |> Js.Promise.then_ (fun _ -> Js.Promise.resolve ())

  type rangeEdge = { character : int }

  type range =
    { start : rangeEdge
    ; end_ : rangeEdge [@bs.as "end"]
    }

  type line = { range : range }

  type document =
    { getText : unit -> string
    ; lineAt : int -> line
    ; lineCount : int
    ; fileName : string
    }

  type activeTextEditor = { document : document }

  external _activeTextEditor : activeTextEditor option = "activeTextEditor"
    [@@bs.module "vscode"] [@@bs.scope "window"] [@@bs.val]

  external activeTextEditor : unit -> activeTextEditor option
    = "activeTextEditor"
    [@@bs.module "vscode"] [@@bs.scope "window"] [@@bs.val]

  type location =
    | SourceControl [@bs.as 1]
    | Window [@bs.as 10]
    | Notification [@bs.as 15]
  [@@bs.deriving { jsConverter = newType }]

  type withProgressConfig = < title : string ; location : abs_location > Js.t

  type progress = { report : (< increment : int > Js.t -> unit[@bs]) }

  external withProgress :
       withProgressConfig
    -> (progress -> ('a, 'b) result Promise.t)
    -> ('a, 'b) result Promise.t = "withProgress"
    [@@bs.module "vscode"] [@@bs.scope "window"]

  external createStatusBarItem :
       ?alignment:StatusBarAlignment.abs_t
    -> ?priority:int
    -> unit
    -> StatusBarItem.t = "createStatusBarItem"
    [@@bs.module "vscode"] [@@bs.scope "window"]

  type textDocumentShowOptions =
    < preserveFocus : bool option
    ; preview : bool option
    ; selection : Range.t option
    ; viewColumn : ViewColumn.t option >
    Js.t

  external textDocumentShowOptions :
       ?preserveFocus:bool
    -> ?preview:bool
    -> ?selection:Range.t
    -> ?viewColumn:ViewColumn.t
    -> unit
    -> textDocumentShowOptions = ""
    [@@bs.obj]

  external _showTextDocument :
       doc:([ `Uri of TextDocument.uri | `Document of TextDocument.t ]
         [@bs.unwrap])
    -> ?options:textDocumentShowOptions
    -> TextEditor.t Promise.t = "showTextDocument"
    [@@bs.module "vscode"] [@@bs.scope "window"]

  let showTextDocument ?options doc = _showTextDocument ~doc ?options

  module Terminal = struct
    type t

    external dispose : t -> unit = "dispose" [@@bs.send]

    external hide : t -> unit = "hide" [@@bs.send]

    external sendText : t -> string -> ?addNewLine:bool -> unit -> unit
      = "sendText"
      [@@bs.send]

    external show : t -> ?preserveFocus:bool -> unit -> unit = "show"
      [@@bs.send]
  end

  external createTerminal :
       ?name:string
    -> ?shellPath:string
    -> ?shellArgs:string array
    -> unit
    -> Terminal.t = "createTerminal"
    [@@bs.module "vscode"] [@@bs.scope "window"]

  module OutputChannel = struct
    type t = { name : string }

    external append : t -> string -> unit = "append" [@@bs.send]

    external appendLine : t -> string -> unit = "appendLine" [@@bs.send]

    external clear : t -> unit = "clear" [@@bs.send]

    external dispose : t -> unit = "dispose" [@@bs.send]

    external hide : t -> unit = "hide" [@@bs.send]

    external show : t -> ?preserveFocus:bool -> unit -> unit = "show"
      [@@bs.send]
  end

  external createOutputChannel : string -> OutputChannel.t
    = "createOutputChannel"
    [@@bs.module "vscode"] [@@bs.scope "window"]
end

type memento

module Commands = struct
  external get : filterInternal:bool -> string array Promise.t = "getCommands"
    [@@bs.module "vscode"] [@@bs.scope "commands"]

  external register : command:string -> handler:(unit -> unit) -> Disposable.t
    = "registerCommand"
    [@@bs.module "vscode"] [@@bs.scope "commands"]

  external _executeCommand :
    command:string -> args:'a list -> unit Js.Nullable.t Promise.t
    = "executeCommand"
    [@@bs.module "vscode"] [@@bs.scope "commands"]

  let executeCommand ~command ~args =
    _executeCommand ~command ~args
    |> Promise.then_ (fun _ -> Promise.resolve ())
end

module ExtensionContext = struct
  type t =
    < extensionPath : string
    ; globalState : memento
    ; globalStoragePath : string
    ; logPath : string
    ; storagePath : string option
    ; subscriptions : Disposable.t array
    ; workspaceState : memento
    ; asAbsolutePath : string -> string >
    Js.t

  let subscribe t (x : Disposable.t) =
    let (_ : int) = Js.Array.push x t##subscriptions in
    ()
end

module Languages = struct
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

  external registerDocumentFormattingEditProvider :
    documentSelector -> documentFormattingEditProvider -> Disposable.t
    = "registerDocumentFormattingEditProvider"
    [@@bs.module "vscode"] [@@bs.scope "languages"]
end

module LanguageClient = struct
  module RevealOutputChannelOn = struct
    type t =
      | Info [@bs.as 1]
      | Warn [@bs.as 2]
      | Error [@bs.as 3]
      | Never [@bs.as 4]
    [@@bs.deriving { jsConverter = newType }]
  end

  module InitializeResult = struct
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

  type processOptions = { env : string Js.Dict.t }

  type serverOptions =
    { command : string
    ; args : string array
    ; options : processOptions
    }

  type t = { initializeResult : InitializeResult.t }

  external start : t -> unit = "start" [@@bs.send]

  external stop : t -> unit = "stop" [@@bs.send]

  external make :
       id:string
    -> name:string
    -> serverOptions:serverOptions
    -> clientOptions:clientOptions
    -> t = "LanguageClient"
    [@@bs.new] [@@bs.module "vscode-languageclient"]

  external onReady : t -> unit Promise.t = "onReady" [@@bs.send]

  let initializeResult (t : t) =
    let open Promise.O in
    onReady t >>| fun () -> t.initializeResult
end

module ShellExecution = struct
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

  external makeCommandLine :
    ?options:shellExecutionOptions option -> commandLine:string -> t
    = "ShellExecution"
    [@@bs.module "vscode"] [@@bs.new]

  external makeCommand :
       ?options:shellExecutionOptions option
    -> command:string
    -> args:string array
    -> t = "ShellExecution"
    [@@bs.module "vscode"] [@@bs.new]
end

module ProcessExecution = struct
  type processExecutionOptions =
    { cwd : string option
    ; env : string Js.Dict.t option
    }

  type t =
    { args : string array
    ; options : processExecutionOptions option
    ; process : string
    }

  external make :
       process:string
    -> args:string array
    -> options:processExecutionOptions option
    -> t = "ProcessExecution"
    [@@bs.module "vscode"] [@@bs.new]
end

module TaskGroup = struct
  type t

  external build : t = "Build" [@@bs.module "vscode"] [@@bs.scope "TaskGroup"]

  external clean : t = "Clean" [@@bs.module "vscode"] [@@bs.scope "TaskGroup"]

  external rebuild : t = "Rebuild"
    [@@bs.module "vscode"] [@@bs.scope "TaskGroup"]

  external test : t = "Test" [@@bs.module "vscode"] [@@bs.scope "TaskGroup"]

  external make : id:string -> label:string -> t = "TaskGroup"
    [@@bs.module "vscode"] [@@bs.new]
end

module Task = struct
  type taskDefinition = { type_ : string [@bs.as "type"] }

  type t = { mutable group : TaskGroup.t option }

  type scope =
    | Folder of Folder.t
    | Global
    | Workspace

  external _make :
       taskDefinition:taskDefinition
    -> scope:([ `Folder of Folder.t | `Enum of int ][@bs.unwrap])
    -> name:string
    -> source:string
    -> execution:
         ([ `Shell of ShellExecution.t | `Process of ProcessExecution.t ]
         [@bs.unwrap])
    -> problemMatchers:string array
    -> t = "Task"
    [@@bs.module "vscode"] [@@bs.new]

  let make ?group ~taskDefinition ~scope ~name ~source ~execution
      ~problemMatchers () =
    let scope =
      match scope with
      | Folder f -> `Folder f
      | Global -> `Enum 1
      | Workspace -> `Enum 2
    in
    let task =
      _make ~taskDefinition ~scope ~name ~source ~execution ~problemMatchers
    in
    task.group <- group;
    task
end

module TaskProvider = struct
  type t =
    { provideTasks :
        (Workspace.cancellationToken option -> Task.t array option Promise.t
        [@bs])
    ; resolveTask :
        (Task.t -> Workspace.cancellationToken option -> Task.t option Promise.t
        [@bs])
    }
end

module Tasks = struct
  external registerTaskProvider :
    typ:string -> provider:TaskProvider.t -> Disposable.t
    = "registerTaskProvider"
    [@@bs.module "vscode"] [@@bs.scope "tasks"]
end

module Env = struct
  external _shell : string = "shell" [@@bs.module "vscode"] [@@bs.scope "env"]

  let shell () = _shell
end
