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
    with Jsonoo.Decode_error err ->
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
  | None -> None
  | Some { name; version } ->
    if String.equal name "ocamllsp" then version
    else (
      log_chan ~section:"Ocaml_lsp.get_version" `Warn
        "the language server is not ocamllsp";
      (* practically impossible but let's be defensive *)
      None)

let lsp_versions =
  (* We define a mapping from OCaml version prefixes e.g. (4, 11, x) to
     available versions of ocamllsp for this prefix. The last element in the
     array of lsp versions is the latest version of ocamllsp for that prefix *)
  let main =
    [ ( (4, 12)
      , [| "1.5.0"
         ; "1.6.0"
         ; "1.6.1"
         ; "1.7.0"
         ; "1.8.0"
         ; "1.8.1"
         ; "1.8.2"
         ; "1.8.3"
         ; "1.9.0"
        |] )
    ; ( (4, 13)
      , [| "1.9.1"
         ; "1.10.0"
         ; "1.10.1"
         ; "1.10.2"
         ; "1.10.3"
         ; "1.10.4"
         ; "1.10.5"
        |] )
    ; ( (4, 14)
      , [| "1.1.0-724-gc5def3b700" (* "1.9.2~4.14preview" *)
         ; "1.10.6"
         ; "1.11.0"
         ; "1.11.1"
         ; "1.11.2"
         ; "1.11.3"
        |] )
    ]
  in
  let rest =
    let lsp = [| "1.0.0"; "1.1.0"; "1.2.0"; "1.3.0"; "1.4.0"; "1.4.1" |] in
    List.range ~start:`inclusive ~stop:`inclusive 6 11
    |> List.map ~f:(fun minor -> ((4, minor), lsp))
  in
  main @ rest

let available_versions version =
  let prefix = (Ocaml_version.major version, Ocaml_version.minor version) in
  List.Assoc.find lsp_versions ~equal:Poly.equal prefix

let is_version_up_to_date t ocaml_v =
  let ocamllsp_version = get_version_from_serverInfo t in
  let res =
    (* if the server doesn't have a version, we assume it's ancient and we can
       offer an upgrade *)
    match ocamllsp_version with
    | None -> (
      match available_versions ocaml_v with
      | Some v -> Error (`Newer_available (None, Array.last v))
      | None -> Ok ())
    | Some v -> (
      match available_versions ocaml_v with
      | None -> Ok ()
      | Some available -> (
        match Array.findi available ~f:(fun _ -> String.equal v) with
        | None -> Ok ()
        | Some (pos, _) ->
          let last = Array.length available - 1 in
          if Int.equal pos last then Ok ()
          else Error (`Newer_available (Some v, available.(last)))))
  in
  Result.map_error res ~f:(fun err ->
      let msg =
        match err with
        | `Newer_available (old, new_) ->
          let upgrade =
            match old with
            | None -> sprintf "to %s" new_
            | Some old -> sprintf "from %s to %s" old new_
          in
          sprintf
            "There is a newer version of ocaml-lsp-server available. Consider \
             upgrading %s. Hint: $ opam install ocaml-lsp-server=%s and \
             restart the lsp server"
            upgrade new_
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
