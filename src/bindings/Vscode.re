module TextDocument = {
  type uri = {
    scheme: string,
    fsPath: string,
  };
  type event = {uri};
};

module Folder = {
  type t = {uri: TextDocument.uri};
  let key = f => f.uri.fsPath;
};

module Workspace = {
  type workspaceFoldersChangeEvent = {
    added: array(Folder.t),
    removed: array(Folder.t),
  };
  [@bs.module "vscode"] [@bs.scope "workspace"]
  external rootPath: string = "rootPath";
  [@bs.module "vscode"] [@bs.scope "workspace"]
  external onDidOpenTextDocument: (TextDocument.event => unit) => unit =
    "onDidOpenTextDocument";
  [@bs.module "vscode"] [@bs.scope "workspace"]
  external getWorkspaceFolder: TextDocument.uri => option(Folder.t) =
    "getWorkspaceFolder";
  [@bs.module "vscode"] [@bs.scope "workspace"]
  external onDidChangeWorkspaceFolders:
    (workspaceFoldersChangeEvent => unit) => unit =
    "onDidChangeWorkspaceFolders";
  [@bs.module "vscode"] [@bs.scope "workspace"]
  external textDocuments: array(TextDocument.event) = "textDocuments";
  [@bs.module "vscode"] [@bs.scope "workspace"]
  external getConfiguration: string => 'a = "getConfiguration";
};

module Window = {
  [@bs.module "vscode"] [@bs.scope "window"]
  external showInformationMessage: string => unit = "showInformationMessage";
  [@bs.module "vscode"] [@bs.scope "window"]
  external showErrorMessage: string => Js.Promise.t('a) = "showErrorMessage";

  type activeTextEditor = {document}
  and document = {
    getText: unit => string,
    lineAt: int => line,
    lineCount: int,
    fileName: string,
  }
  and line = {range}
  and range = {
    start: rangeEdge,
    [@bs.as "end"]
    end_: rangeEdge,
  }
  and rangeEdge = {character: int};

  [@bs.module "vscode"] [@bs.scope "window"] [@bs.val]
  external activeTextEditor: option(activeTextEditor) = "activeTextEditor";

  /* [@bs.deriving {jsConverter: newType}] */
  /* type location = */
  /*   | [@bs.as 15] Notification */
  /*   | [@bs.as 1] SourceControl */
  /*   | [@bs.as 10] Window; */

  type withProgessConfig = {
    .
    "title": string,
    "location": int /* abs_location */,
  };
  type progress = {report: (. {. "increment": int}) => unit};
  [@bs.module "vscode"] [@bs.scope "window"]
  external withProgress:
    (withProgessConfig, progress => Js.Promise.t(result('a, 'b))) =>
    Js.Promise.t(result('a, 'b)) =
    "withProgress";
};

type memento;
module Commands = {
  [@bs.module "vscode"] [@bs.scope "commands"]
  external get: (~filterInternal: bool) => Js.Promise.t(array(string)) =
    "getCommands";
  [@bs.module "vscode"] [@bs.scope "commands"]
  external register: (~command: string, ~handler: unit => unit) => unit =
    "registerCommand";
};

module ExtensionContext = {
  type disposable = {dispose: (. unit) => unit};
  type t = {
    extensionPath: string,
    globalState: memento,
    globalStoragePath: string,
    logPath: string,
    storagePath: option(string),
    /* subscriptions is an array of disposables. client is a disposable */
    subscriptions: array(disposable),
    workspaceState: memento,
    asAbsolutePath: string => string,
  };
};

module Languages = {
  type documentSelector = {
    scheme: string,
    language: string,
  };

  [@bs.module "vscode"] [@bs.scope "languages"]
  external registerDocumentFormattingEditProvider:
    (documentSelector, 'a) => unit =
    "registerDocumentFormattingEditProvider";
};

module Range = {
  type t;
  [@bs.module "vscode"] [@bs.new]
  external create: (int, int, int, int) => t = "Range";
};

module TextEdit = {
  type t;

  [@bs.module "vscode"] [@bs.scope "TextEdit"]
  external replace: (Range.t, string) => t = "replace";
};

module LanguageClient = {
  type documentSelectorItem = {
    scheme: string,
    language: string,
  };
  type clientOptions = {documentSelector: array(documentSelectorItem)};
  type processOptions = {env: Js.Dict.t(string)};
  type serverOptions = {
    command: string,
    args: array(string),
    options: processOptions,
  };
  type t = {
    start: (. unit) => unit,
    stop: (. unit) => unit,
  };
  [@bs.new] [@bs.module "vscode-languageclient"]
  external make:
    (
      ~id: string,
      ~name: string,
      ~serverOptions: serverOptions,
      ~clientOptions: clientOptions
    ) =>
    t =
    "LanguageClient";
};
