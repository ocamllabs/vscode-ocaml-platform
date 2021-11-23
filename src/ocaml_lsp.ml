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

let get_version_from_serverInfo { serverInfo; experimental_capabilities = _ } =
  match serverInfo with
  | None -> Error `Missing_serverInfo (* ocamllsp should have [serverInfo] *)
  | Some { name; version } ->
    if String.equal name "ocamllsp" then
      match version with
      | None -> Error `ServerInfo_version_missing
      | Some v -> Ok v
    else (
      log_chan ~section:"Ocaml_lsp.get_version" `Warn
        "the language server is not ocamllsp";
      (* practically impossible but let's be defensive *)
      Error `Language_server_isn't_ocamllsp
    )

let get_version_semver t =
  match get_version_from_serverInfo t with
  | Ok v -> (
    match String.split v ~on:'-' |> List.hd with
    | Some v -> Ok v
    | None -> Error `Unable_to_parse_version)
  | Error _ as err -> err

let is_version_up_to_date t ocaml_v =
  let ocamllsp_version = get_version_semver t in
  let res =
    match ocamllsp_version with
    | Ok v -> (
      match ocaml_v with
      | _ when Ocaml_version.(ocaml_v < Releases.v4_06_0) ->
        Error (`Ocaml_version_not_supported ocaml_v)
      | _ when Ocaml_version.(ocaml_v < Releases.v4_12_0) ->
        Ok (String.equal v "1.4.1")
      | _ when Ocaml_version.(ocaml_v < Releases.v4_13_0) ->
        Ok (String.equal v "1.9.0")
      | _ when Ocaml_version.(ocaml_v < Releases.v4_14_0) ->
        Ok (String.equal v "1.9.0~4.13preview")
      | _ -> Error (`Ocaml_version_not_supported ocaml_v))
    | Error e -> Error (`Unexpected e)
  in
  Result.map_error res ~f:(fun err ->
      let msg =
        match err with
        | `Ocaml_version_not_supported v ->
          sprintf
            "The installed version of OCaml is not supported by `ocamllsp`: \
             %s. Consider upgrading OCaml version used in the current sandbox."
            (Ocaml_version.to_string v)
        | `Unexpected `Language_server_isn't_ocamllsp ->
          "Using a language server besides `ocamllsp` isn't expected by this \
           extension. Please, switch to using `ocamllsp` by installing the \
           package `ocaml-lsp-server` in your current sandbox."
        | `Unexpected `Missing_serverInfo
        | `Unexpected `ServerInfo_version_missing ->
          "The extension expected the server version to be sent by `ocamllsp`. \
           It is missing. Please, consider upgrading the package \
           `ocaml-lsp-server`."
        | `Unexpected `Unable_to_parse_version ->
          "The extension was unable to parse `ocamllsp` version. That's \
           strange. Consider filing an issue on the project GitHub with the \
           version of your `ocamllsp`."
      in
      `Msg msg)

let of_initialize_result (t : LanguageClient.InitializeResult.t) =
  let serverInfo = LanguageClient.InitializeResult.serverInfo t in
  let experimental_capabilities =
    Experimental_capabilities.of_initialize_result t
  in
  { serverInfo; experimental_capabilities }

let can_handle_switch_impl_intf t =
  t.experimental_capabilities.handleSwitchImplIntf

let can_handle_infer_intf t = t.experimental_capabilities.handleSwitchImplIntf

let can_handle_typed_holes t = t.experimental_capabilities.handleTypedHoles
