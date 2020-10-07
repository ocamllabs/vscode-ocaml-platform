open Import

type t

val of_initialize_result : LanguageClient.InitializeResult.t -> t

val interfaceSpecificLangId : t -> bool

val canHandleSwitchImplIntf : t -> bool
