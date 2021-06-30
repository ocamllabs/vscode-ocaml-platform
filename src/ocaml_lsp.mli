open Import

type t

val of_initialize_result : LanguageClient.InitializeResult.t -> t

val has_interface_specific_lang_id : t -> bool

val can_handle_switch_impl_intf : t -> bool

val can_handle_infer_intf : t -> bool

val can_handle_typed_holes : t -> bool
