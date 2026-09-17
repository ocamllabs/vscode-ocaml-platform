open Import

type t =
  { mutable sandbox : Sandbox.t
  ; mutable repl : Terminal_sandbox.t option
  ; mutable ocaml_version : Ocaml_version.t option
    (** assumption: it must be set before initializing the language server;
        the lang server initialization needs the ocaml version *)
  ; mutable lsp_client : (LanguageClient.t * Ocaml_lsp.t) option
  ; mutable documentation_view : Documentation_view.t option
  ; extension_uri : Uri.t
  ; sandbox_info : StatusBarItem.t
  ; ast_editor_state : Ast_editor_state.t
  ; mutable standard_hover : bool option
  }

let sandbox t = t.sandbox
let language_client t = Option.map ~f:fst t.lsp_client
let ocaml_lsp t = Option.map ~f:snd t.lsp_client
let lsp_client t = t.lsp_client
let ocaml_version t = t.ocaml_version

let send_configuration t client =
  let enable_setting setting =
    Option.map (Settings.get setting) ~f:(fun enable ->
      Ocaml_lsp.OcamllspSettingEnable.create ~enable)
  in
  let extendedHover = enable_setting Settings.server_extendedHover_setting in
  let standardHover =
    Option.map t.standard_hover ~f:(fun enable ->
      Ocaml_lsp.OcamllspSettingEnable.create ~enable)
  in
  let codelens =
    Option.map (Settings.get Settings.server_codelens_setting) ~f:(fun enable ->
      Ocaml_lsp.OcamllspSettingCodeLens.create
        ?forNestedBindings:
          (Settings.get Settings.server_codelens_for_nested_bindings_setting)
        ~enable
        ())
  in
  let duneDiagnostics = enable_setting Settings.server_duneDiagnostics_setting in
  let inlayHints =
    let hintPatternVariables =
      Settings.get Settings.server_inlayHints_hintPatternVariables_setting
    in
    let hintLetBindings =
      Settings.get Settings.server_inlayHints_hintLetBindings_setting
    in
    let hintFunctionParams =
      Settings.get Settings.server_inlayHints_hintFunctionParams_setting
    in
    match hintPatternVariables, hintLetBindings, hintFunctionParams with
    | None, None, None -> None
    | _ ->
      Some
        (Ocaml_lsp.OcamllspSettingInlayHints.create
           ?hintPatternVariables
           ?hintLetBindings
           ?hintFunctionParams
           ())
  in
  let syntaxDocumentation = enable_setting Settings.server_syntaxDocumentation_setting in
  let shortenMerlinDiagnostics =
    enable_setting Settings.server_shortenMerlinDiagnostics_setting
  in
  let settings =
    Ocaml_lsp.OcamllspSettings.create
      ~extendedHover
      ~standardHover
      ~codelens
      ~duneDiagnostics
      ~inlayHints
      ~syntaxDocumentation
      ~shortenMerlinDiagnostics
  in
  let payload =
    let settings =
      LanguageClient.DidChangeConfiguration.create
        ~settings:([%js.of: Ocaml_lsp.OcamllspSettings.t] settings)
        ()
    in
    [%js.of: LanguageClient.DidChangeConfiguration.t] settings
  in
  LanguageClient.sendNotification client "workspace/didChangeConfiguration" payload
;;

let set_configuration t ?standard_hover () =
  Option.iter standard_hover ~f:(fun standard_hover -> t.standard_hover <- standard_hover);
  match t.lsp_client with
  | None -> ()
  | Some (client, (_ : Ocaml_lsp.t)) -> send_configuration t client
;;

let stop_server t =
  match t.lsp_client with
  | None -> Promise.return ()
  | Some (client, (_ : Ocaml_lsp.t)) ->
    t.lsp_client <- None;
    if LanguageClient.isRunning client
    then LanguageClient.stop client
    else Promise.return ()
;;

let check_ocaml_lsp_available (sandbox : Sandbox.t) =
  match sandbox with
  | Dune dune ->
    let open Promise.Syntax in
    let+ dune_lsp_present = Dune.is_ocamllsp_present dune in
    if dune_lsp_present
    then Ok ()
    else Error "\"ocaml-lsp-server\" is not installed in the current dune sandbox."
  | _ ->
    let ocaml_lsp_version sandbox =
      Sandbox.get_command sandbox "ocamllsp" [ "--version" ] `Tool
    in
    let cwd = Sandbox.workspace_root () in
    Cmd.output ?cwd (ocaml_lsp_version sandbox)
    |> Promise.Result.fold
         ~ok:(fun (_ : string) -> ())
         ~error:(fun (_ : string) ->
           "Sandbox initialization failed: \"ocaml-lsp-server\" is not installed in the \
            current sandbox.")
;;

let update_ocaml_info t =
  let open Promise.Syntax in
  let+ ocaml_version =
    let cwd = Sandbox.workspace_root () in
    let+ r =
      Sandbox.get_command t.sandbox "ocamlc" [ "-version" ] `Exec |> Cmd.output ?cwd
    in
    match r with
    | Ok v ->
      Ocaml_version.of_string v
      |> Result.map_error ~f:(function m -> `Unable_to_parse_version (`Version v, m))
    | Error e ->
      log_chan
        ~section:"Ocaml.version_semver"
        `Warn
        "Error running \"ocamlc -version\": %s"
        e;
      Error `Ocamlc_missing
  in
  match ocaml_version with
  | Ok ocaml_version -> t.ocaml_version <- Some ocaml_version
  | Error e ->
    (* [t.ocaml_version <- None] because we don't want [t.ocaml_version] to be
       left over from a previous sandbox, which successfully set it *)
    t.ocaml_version <- None;
    (match e with
     | `Unable_to_parse_version (`Version v, `Msg msg) ->
       show_message
         `Error
         "OCaml bytecode compiler \"ocamlc\" version could not be parsed. Version: %s. \
          Error %s"
         v
         msg
     | `Ocamlc_missing ->
       let (_ : unit Promise.t) =
         let+ maybe_choice =
           Window.showWarningMessage
             ~message:
               "OCaml bytecode compiler \"ocamlc\" was not found in the current sandbox. \
                Do you have OCaml installed in the current sandbox?"
             ~choices:
               [ ( "Pick another sandbox"
                 , fun () ->
                     let (_ : unit Promise.t) =
                       Command_api.(execute Internal.select_sandbox) ()
                     in
                     () )
               ]
             ()
         in
         Option.iter maybe_choice ~f:(fun f -> f ())
       in
       ())
;;

module Language_server_init : sig
  val start_language_server : t -> unit Promise.t
end = struct
  let client_options () =
    let documentSelector =
      LanguageClient.DocumentSelector.
        [| language "ocaml"
         ; language "ocaml.interface"
         ; language "ocaml.ocamllex"
         ; language "ocaml.menhir"
         ; language "ocaml.mlx"
         ; language "reason"
        |]
    in
    let (lazy outputChannel) = Output.language_server_output_channel in
    let revealOutputChannelOn = LanguageClient.RevealOutputChannelOn.Never in
    LanguageClient.ClientOptions.create
      ~outputChannel
      ~revealOutputChannelOn
      ~documentSelector
      ()
  ;;

  let server_options t =
    let open Promise.Syntax in
    let args = Settings.(get server_args_setting) |> Option.value ~default:[] in
    let command =
      match t.sandbox with
      | Dune _ -> Cmd.Spawn { bin = Path.of_string "ocamllsp"; args }
      | _ -> Sandbox.get_command t.sandbox "ocamllsp" args `Tool
    in
    Cmd.log command;
    let env =
      let extra_env_vars =
        Settings.server_extraEnv () |> Option.value ~default:Interop.Dict.empty
      in
      Interop.Dict.union (fun _k _v1 v2 -> Some v2) (Process.Env.env ()) extra_env_vars
    in
    let+ env =
      match t.sandbox with
      | Dune dune ->
        let+ output = Cmd.output ~cwd:dune.root (Dune.env dune) in
        let paths =
          Stdlib.Scanf.sscanf (Result.ok_or_failwith output) "export PATH=%s" Fn.id
        in
        Interop.Dict.add "PATH" paths env
      | _ -> Promise.return env
    in
    match command with
    | Shell command ->
      let options = LanguageClient.ExecutableOptions.create ~env ~shell:true () in
      LanguageClient.Executable.create ~command ~options ()
    | Spawn { bin; args } ->
      let command = Path.to_string bin in
      let options = LanguageClient.ExecutableOptions.create ~env ~shell:false () in
      LanguageClient.Executable.create ~command ~args ~options ()
  ;;

  let suggest_or_install_ocaml_lsp_server t =
    let open Promise.Syntax in
    match t.sandbox with
    | Dune _ ->
      let+ () = Command_api.(execute Internal.install_dune_lsp) () in
      ()
    | _ ->
      let install_lsp_text = "Install OCaml-LSP server" in
      let select_different_sandbox = "Select a different Sandbox" in
      let* selection =
        Window.showInformationMessage
          ~message:
            "Failed to start the language server. \"ocaml-lsp-server\" is not installed \
             in the current sandbox."
          ~choices:
            [ install_lsp_text, `Install_lsp; select_different_sandbox, `Select_sandbox ]
          ()
      in
      (match selection with
       | Some `Install_lsp ->
         let+ () = Command_api.(execute Internal.install_ocaml_lsp_server) () in
         ()
       | Some `Select_sandbox ->
         let+ () = Command_api.(execute Internal.select_sandbox) () in
         ()
       | _ -> Promise.return ())
  ;;

  let client_capabilities =
    let fillClientCapabilities ~capabilities =
      let experimental = Jsonoo.Encode.(object_ [ "jumpToNextHole", bool true ]) in
      LanguageClient.ClientCapabilities.set_experimental capabilities (Some experimental)
    in
    let initialize ~capabilities:_ ~documentSelector:_ = () in
    let clear () = () in
    LanguageClient.StaticFeature.make ~fillClientCapabilities ~initialize ~clear ()
  ;;

  let start_language_server t =
    let open Promise.Syntax in
    let* () = stop_server t in
    let* ocamllsp_present = check_ocaml_lsp_available t.sandbox in
    match ocamllsp_present with
    | Ok () ->
      let* () = update_ocaml_info t in
      let+ res =
        let* client =
          let+ serverOptions = server_options t in
          let clientOptions = client_options () in
          LanguageClient.make
            ~id:"ocaml"
            ~name:"OCaml Platform VS Code extension"
            ~serverOptions
            ~clientOptions
            ()
        in
        LanguageClient.registerFeature client ~feature:client_capabilities;
        let+ () = LanguageClient.start client in
        let initialize_result = LanguageClient.initializeResult client in
        let ocaml_lsp = Ocaml_lsp.of_initialize_result initialize_result in
        t.lsp_client <- Some (client, ocaml_lsp);
        (match ocaml_version t with
         | Some version ->
           (match Ocaml_lsp.is_version_up_to_date ocaml_lsp (sandbox t) version with
            | Ok () -> ()
            | Error (`Msg _) -> ())
         | None -> ());
        send_configuration t client;
        Ok ()
      in
      (match res with
       | Ok () -> ()
       | Error s ->
         show_message
           `Error
           "An error occurred starting the language server \"ocamllsp\". %s"
           s)
    | Error _ -> suggest_or_install_ocaml_lsp_server t
  ;;
end

include Language_server_init

let install_ocaml_lsp_server sandbox =
  let open Promise.Syntax in
  let* () = Sandbox.install_packages sandbox [ "ocaml-lsp-server" ] in
  let* () = Command_api.(execute Internal.refresh_switches) () in
  let+ () = Command_api.(execute Internal.refresh_sandbox) () in
  ()
;;

let upgrade_ocaml_lsp_server sandbox =
  let open Promise.Syntax in
  let* () = Sandbox.upgrade_packages sandbox ~packages:[ "ocaml-lsp-server" ] in
  let* () = Command_api.(execute Internal.refresh_switches) () in
  let+ () = Command_api.(execute Internal.refresh_sandbox) () in
  ()
;;

module Sandbox_info : sig
  val make : Sandbox.t -> StatusBarItem.t
  val update : StatusBarItem.t -> new_sandbox:Sandbox.t -> unit
end = struct
  let make_status_bar_item_text sandbox =
    Printf.sprintf "$(package) %s" @@ Sandbox.to_pretty_string sandbox
  ;;

  let make sandbox =
    let status_bar_item =
      Window.createStatusBarItem ~alignment:StatusBarAlignment.Left ()
    in
    let status_bar_item_text = make_status_bar_item_text sandbox in
    StatusBarItem.set_text status_bar_item status_bar_item_text;
    StatusBarItem.set_command
      status_bar_item
      (Some (`String Command_api.Internal.select_sandbox.id));
    StatusBarItem.show status_bar_item;
    status_bar_item
  ;;

  let update sandbox_info ~new_sandbox =
    let status_bar_item_text = make_status_bar_item_text new_sandbox in
    StatusBarItem.set_text sandbox_info status_bar_item_text
  ;;
end

let make ~extension_uri () =
  let sandbox = Sandbox.Global in
  let sandbox_info = Sandbox_info.make sandbox in
  let ast_editor_state = Ast_editor_state.make () in
  { sandbox
  ; lsp_client = None
  ; sandbox_info
  ; extension_uri
  ; repl = None
  ; ocaml_version = None
  ; ast_editor_state
  ; documentation_view = None
  ; standard_hover = None
  }
;;

let close_documentation t =
  Option.iter t.documentation_view ~f:Documentation_view.dispose;
  t.documentation_view <- None
;;

let set_sandbox t new_sandbox =
  Sandbox_info.update t.sandbox_info ~new_sandbox;
  t.sandbox <- new_sandbox;
  close_documentation t;
  let (_ : unit Promise.t) = Command_api.(execute Internal.refresh_sandbox) ()
  and (_ : unit Promise.t) = Command_api.(execute Internal.refresh_switches) () in
  ()
;;

let show_documentation t ~path ~package_name =
  let root = Path.to_string path in
  let view =
    match t.documentation_view with
    | Some view
      when (not (Documentation_view.is_disposed view))
           && String.equal (Documentation_view.root view) root -> view
    | _ ->
      close_documentation t;
      let panel =
        Window.createWebviewPanelWithOptions
          ~viewType:"ocaml.documentation"
          ~title:"OCaml Documentation"
          ~showOptions:(`ViewColumn ViewColumn.Beside)
          ~options:
            { enableFindWidget = Some true
            ; retainContextWhenHidden = Some true
            ; enableScripts = Some true
            ; enableForms = Some false
            ; enableCommandUris = None
            ; localResourceRoots = None
            ; portMapping = None
            }
          ()
      in
      let view = Documentation_view.create ~panel ~root ~extension_uri:t.extension_uri in
      t.documentation_view <- Some view;
      view
  in
  Documentation_view.show view ~path:(Node.Path.join [ package_name; "index.html" ])
  |> Promise.catch ~rejected:(fun error ->
    show_message `Error "Could not open documentation: %s" (Node.JsError.message error);
    Promise.return ())
;;

let repl t = t.repl
let set_repl t repl = t.repl <- Some repl
let close_repl t = t.repl <- None

let open_terminal sandbox =
  let terminal = Terminal_sandbox.create sandbox in
  Terminal_sandbox.show ~preserveFocus:false terminal
;;

let ast_editor_state t = t.ast_editor_state

let disposable t =
  Disposable.make ~dispose:(fun () ->
    StatusBarItem.dispose t.sandbox_info;
    let (_ : unit Promise.t) = stop_server t in
    close_documentation t)
;;
