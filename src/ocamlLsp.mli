open Import

type t

val ofInitializeResult : LanguageClient.InitializeResult.t -> t

val interfaceSpecificLangId : t -> bool

val canHandleSwitchImplIntf : t -> bool
