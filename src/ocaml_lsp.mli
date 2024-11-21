open Import

type t

val of_initialize_result : LanguageClient.InitializeResult.t -> t

val is_version_up_to_date :
  t -> Ocaml_version.t -> (unit, [ `Msg of string ]) result

val can_handle_switch_impl_intf : t -> bool

val can_handle_infer_intf : t -> bool

val can_handle_typed_holes : t -> bool

val can_handle_type_enclosing : t -> bool

val can_handle_construct : t -> bool

val can_handle_merlin_jump : t -> bool

module OcamllspSettingEnable : sig
  include Ojs.T

  val enable : t -> bool option

  val create : enable:bool -> t
end

module OcamllspSettings : sig
  include Ojs.T

  val codelens : t -> OcamllspSettingEnable.t option

  val extendedHover : t -> OcamllspSettingEnable.t option

  val duneDiagnostics : t -> OcamllspSettingEnable.t option

  val syntaxDocumentation : t -> OcamllspSettingEnable.t option

  val create :
       codelens:OcamllspSettingEnable.t option
    -> extendedHover:OcamllspSettingEnable.t option
    -> duneDiagnostics:OcamllspSettingEnable.t option
    -> syntaxDocumentation:OcamllspSettingEnable.t option
    -> t
end
