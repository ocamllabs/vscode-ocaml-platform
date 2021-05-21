open Import

type t

val of_initialize_result : Language_client.Initialize_result.t -> t

val has_interface_specific_lang_id : t -> bool

val can_handle_switch_impl_intf : t -> bool

val can_handle_infer_intf : t -> bool
