type t

val ofInitializeResult : Vscode.LanguageClient.InitializeResult.t -> t

val interfaceSpecificLangId : t -> bool
