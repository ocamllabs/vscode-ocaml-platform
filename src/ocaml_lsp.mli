open Import

type t

val of_initialize_result : LanguageClient.InitializeResult.t -> t

val is_version_up_to_date :
  t -> Ocaml_version.t -> (bool, [ `Msg of string ]) result

val can_handle_switch_impl_intf : t -> bool

val can_handle_infer_intf : t -> bool

val can_handle_typed_holes : t -> bool
