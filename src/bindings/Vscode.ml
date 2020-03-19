module TextDocument = struct
  type uri =
    { scheme : string
    ; fsPath : string
    }

  type event = { uri : uri }
end

module Folder = struct
  type t = { uri : TextDocument.uri }

  let key f = f.uri.fsPath
end

module WorkspaceConfiguration = struct
  type t

  external get : t -> string -> string Js.Nullable.t = "get" [@@bs.send]

  external update : t -> string -> string -> int -> unit Js.Promise.t = "update"
    [@@bs.send]
end

module Workspace = struct
  type workspaceFoldersChangeEvent =
    { added : Folder.t array
    ; removed : Folder.t array
    }

  external rootPath : string = "rootPath"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]

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

  external textDocuments : TextDocument.event array = "textDocuments"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]

  external getConfiguration : string -> WorkspaceConfiguration.t
    = "getConfiguration"
    [@@bs.module "vscode"] [@@bs.scope "workspace"]
end

module Window = struct
  module QuickPickOptions = struct
    type t = < canPickMany : bool > Js.t

    external make : ?canPickMany:bool -> ?placeHolder:string -> unit -> t = ""
      [@@bs.obj]
  end

  external showQuickPick :
    (string array -> QuickPickOptions.t -> string Js.Nullable.t Js.Promise.t
    [@bs]) = "showQuickPick"
    [@@bs.module "vscode"] [@@bs.scope "window"]

  external showInformationMessage : string -> unit = "showInformationMessage"
    [@@bs.module "vscode"] [@@bs.scope "window"]

  external showErrorMessage : string -> 'a Js.Promise.t = "showErrorMessage"
    [@@bs.module "vscode"] [@@bs.scope "window"]

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

  external activeTextEditor : activeTextEditor option = "activeTextEditor"
    [@@bs.module "vscode"] [@@bs.scope "window"] [@@bs.val]

  type withProgessConfig = < title : string ; location : int > Js.t

  type progress = { report : (< increment : int > Js.t -> unit[@bs]) }

  external withProgress :
       withProgessConfig
    -> (progress -> ('a, 'b) result Js.Promise.t)
    -> ('a, 'b) result Js.Promise.t = "withProgress"
    [@@bs.module "vscode"] [@@bs.scope "window"]
end

type memento

module Commands = struct
  external get : filterInternal:bool -> string array Js.Promise.t
    = "getCommands"
    [@@bs.module "vscode"] [@@bs.scope "commands"]

  external register : command:string -> handler:(unit -> unit) -> unit
    = "registerCommand"
    [@@bs.module "vscode"] [@@bs.scope "commands"]
end

module ExtensionContext = struct
  type disposable = { dispose : (unit -> unit[@bs]) }

  type t =
    { extensionPath : string
    ; globalState : memento
    ; globalStoragePath : string
    ; logPath : string
    ; storagePath : string option
    ; subscriptions : disposable array
    ; workspaceState : memento
    ; asAbsolutePath : string -> string
    }
end

module Languages = struct
  type documentSelector =
    { scheme : string
    ; language : string
    }

  external registerDocumentFormattingEditProvider :
    documentSelector -> 'a -> unit = "registerDocumentFormattingEditProvider"
    [@@bs.module "vscode"] [@@bs.scope "languages"]
end

module Range = struct
  type t

  external create : int -> int -> int -> int -> t = "Range"
    [@@bs.module "vscode"] [@@bs.new]
end

module TextEdit = struct
  type t

  external replace : Range.t -> string -> t = "replace"
    [@@bs.module "vscode"] [@@bs.scope "TextEdit"]
end

module LanguageClient = struct
  type documentSelectorItem =
    { scheme : string
    ; language : string
    }

  type clientOptions = { documentSelector : documentSelectorItem array }

  type processOptions = { env : string Js.Dict.t }

  type serverOptions =
    { command : string
    ; args : string array
    ; options : processOptions
    }

  type t =
    { start : (unit -> unit[@bs])
    ; stop : (unit -> unit[@bs])
    }

  external make :
       id:string
    -> name:string
    -> serverOptions:serverOptions
    -> clientOptions:clientOptions
    -> t = "LanguageClient"
    [@@bs.new] [@@bs.module "vscode-languageclient"]
end
