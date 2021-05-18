open! Import

type t =
  { interfaceSpecificLangId : bool
  ; handleSwitchImplIntf : bool
  ; handleInferIntf : bool
  }

let default =
  { interfaceSpecificLangId = false
  ; handleSwitchImplIntf = false
  ; handleInferIntf = false
  }

let default_field key decode default json =
  let open Json.Decode in
  try_default default (field key decode) json

let of_json (json : Json.t) =
  let open Json.Decode in
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
    { interfaceSpecificLangId; handleSwitchImplIntf; handleInferIntf }
  with
  | Json.Decode_error _ ->
    show_message `Warn
      "unexpected experimental capabilities from lsp server. Some features \
       might be missing";
    default

let of_initialize_result (t : Language_client.Initialize_result.t) =
  let open Language_client in
  match Server_capabilities.experimental (Initialize_result.capabilities t) with
  | None -> default
  | Some json -> (
    match Json.Decode.field "ocamllsp" of_json json with
    | s -> s
    | exception Json.Decode_error _ -> default)

let has_interface_specific_lang_id t = t.interfaceSpecificLangId

let can_handle_switch_impl_intf t = t.handleSwitchImplIntf

let can_handle_infer_intf t = t.handleSwitchImplIntf
