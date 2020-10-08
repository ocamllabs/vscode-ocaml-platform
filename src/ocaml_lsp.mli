open Import

type t

val of_initialize_result : LanguageClient.InitializeResult.t -> t

val interfaceSpecificLangId : t -> bool

val can_handle_switch_impl_intf : t -> bool
