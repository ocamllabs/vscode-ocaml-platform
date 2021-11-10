open! Import

module Experimental_capabilities = struct
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

  (** Creates [t] given a JSON of form [{ 'handleSwitchImplIntf' : true, .... }] *)
  let t_of_json (json : Jsonoo.t) =
    let experimental_caps_tbl = Jsonoo.Decode.(dict bool) json in
    let has_capability cap =
      Stdlib.Hashtbl.find_opt experimental_caps_tbl cap
      |> Option.value ~default:false
    in
    try
      let interfaceSpecificLangId = has_capability "interfaceSpecificLangId" in
      let handleSwitchImplIntf = has_capability "handleSwitchImplIntf" in
      let handleInferIntf = has_capability "handleInferIntf" in
      let handleTypedHoles = has_capability "handleTypedHoles" in
      { interfaceSpecificLangId
      ; handleSwitchImplIntf
      ; handleInferIntf
      ; handleTypedHoles
      }
    with
    | Jsonoo.Decode_error err ->
      show_message `Warn
        "Unexpected experimental capabilities from the language server. \
         Falling back to default: no experimental capabilities set.";
      log_chan `Error ~section:"Ocaml_lsp.of_json" "%s" err;
      default

  let of_initialize_result (t : LanguageClient.InitializeResult.t) =
    LanguageClient.InitializeResult.capabilities t
    |> LanguageClient.ServerCapabilities.experimental
    |> Option.bind ~f:Jsonoo.Decode.(try_optional (field "ocamllsp" t_of_json))
    |> Option.value ~default
end

type t =
  { serverInfo : LanguageClient.InitializeResult.serverInfo option
  ; experimental_capabilities : Experimental_capabilities.t
  }

let of_initialize_result (t : LanguageClient.InitializeResult.t) =
  let serverInfo = LanguageClient.InitializeResult.serverInfo t in
  let experimental_capabilities =
    Experimental_capabilities.of_initialize_result t
  in
  { serverInfo; experimental_capabilities }

let has_interface_specific_lang_id t =
  t.experimental_capabilities.interfaceSpecificLangId

let can_handle_switch_impl_intf t =
  t.experimental_capabilities.handleSwitchImplIntf

let can_handle_infer_intf t = t.experimental_capabilities.handleSwitchImplIntf

let can_handle_typed_holes t = t.experimental_capabilities.handleTypedHoles
