open! Import

type t =
  { interfaceSpecificLangId : bool
  ; handleSwitchImplIntf : bool
  ; handleInferIntf : bool
  ; handleTypedHoles : bool
  }

let default =
  { interfaceSpecificLangId = false
  ; handleSwitchImplIntf = false
  ; handleInferIntf = false
  ; handleTypedHoles = false
  }

let default_field key decode default json =
  let open Jsonoo.Decode in
  try_default default (field key decode) json

let of_json (json : Jsonoo.t) =
  let open Jsonoo.Decode in
  try
    let interfaceSpecificLangId =
      default_field "interfaceSpecificLangId" bool
        default.interfaceSpecificLangId json
    in
    let handleSwitchImplIntf =
      default_field "handleSwitchImplIntf" bool default.handleSwitchImplIntf
        json
    in
    let handleInferIntf =
      default_field "handleInferIntf" bool default.handleInferIntf json
    in
    let handleTypedHoles =
      default_field "handleTypedHoles" bool default.handleTypedHoles json
    in
    { interfaceSpecificLangId
    ; handleSwitchImplIntf
    ; handleInferIntf
    ; handleTypedHoles
    }
  with
  | Jsonoo.Decode_error _ ->
    show_message `Warn
      "unexpected experimental capabilities from lsp server. Some features \
       might be missing";
    default

let of_initialize_result (t : LanguageClient.InitializeResult.t) =
  let open LanguageClient in
  match ServerCapabilities.experimental (InitializeResult.capabilities t) with
  | None -> default
  | Some json -> (
    match Jsonoo.Decode.field "ocamllsp" of_json json with
    | s -> s
    | exception Jsonoo.Decode_error _ -> default)

let has_interface_specific_lang_id t = t.interfaceSpecificLangId

let can_handle_switch_impl_intf t = t.handleSwitchImplIntf

let can_handle_infer_intf t = t.handleSwitchImplIntf

let can_handle_typed_holes t = t.handleTypedHoles
