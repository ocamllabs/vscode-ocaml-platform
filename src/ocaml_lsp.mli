open Import

type t

val of_initialize_result : LanguageClient.InitializeResult.t -> t

val is_version_up_to_date :
     t
  -> Ocaml_version.t
  -> ( bool
     , [> `Ocaml_version_not_supported of Ocaml_version.t
       | `Unexpected of
         [> `Language_server_isn't_ocamllsp
         | `Missing_serverInfo
         | `Unable_to_parse_version
         | `ServerInfo_version_missing
         ]
       ] )
     result

val can_handle_switch_impl_intf : t -> bool

val can_handle_infer_intf : t -> bool

val can_handle_typed_holes : t -> bool
