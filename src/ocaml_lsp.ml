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

let of_json (json : Jsonoo.t) =
  let has_capability cap json =
    let decoder = Jsonoo.Decode.(field cap bool) in
    Jsonoo.Decode.try_default false decoder json
  in
  try
    let interfaceSpecificLangId =
      has_capability "interfaceSpecificLangId" json
    in
    let handleSwitchImplIntf = has_capability "handleSwitchImplIntf" json in
    let handleInferIntf = has_capability "handleInferIntf" json in
    let handleTypedHoles = has_capability "handleTypedHoles" json in
    { interfaceSpecificLangId
    ; handleSwitchImplIntf
    ; handleInferIntf
    ; handleTypedHoles
    }
  with
  | Jsonoo.Decode_error _ ->
    show_message `Warn
      "Unexpected experimental capabilities from the language server. Falling \
       back to default: no experimental capabilities set.";
    default

let of_initialize_result (t : LanguageClient.InitializeResult.t) =
  LanguageClient.InitializeResult.capabilities t
  |> LanguageClient.ServerCapabilities.experimental
  |> Option.bind ~f:Jsonoo.Decode.(try_optional (field "ocamllsp" of_json))
  |> Option.value ~default

let has_interface_specific_lang_id t = t.interfaceSpecificLangId

let can_handle_switch_impl_intf t = t.handleSwitchImplIntf

let can_handle_infer_intf t = t.handleSwitchImplIntf

let can_handle_typed_holes t = t.handleTypedHoles
