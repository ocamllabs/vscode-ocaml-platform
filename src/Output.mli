(** [languageServerOutputChannel] is the output channel
    that should be used by all ocamllsp LanguageClients *)
val languageServerOutputChannel : Vscode.Window.OutputChannel.t Lazy.t

(** [extensionOutputChannel] is the output channel
    that should be used for logs by the extension *)
val extensionOutputChannel : Vscode.Window.OutputChannel.t Lazy.t
