open Import

type t =
  { mutable sandbox : Sandbox.t
  ; mutable repl : Terminal_sandbox.t option
  ; mutable ocaml_version : Ocaml_version.t option
    (** assumption: it must be set before initializing the language server;
        the lang server initialization needs the ocaml version *)
  ; mutable lsp_client : (LanguageClient.t * Ocaml_lsp.t) option
  ; mutable documentation_server : Documentation_server.t option
  ; documentation_server_info : StatusBarItem.t
  ; sandbox_info : StatusBarItem.t
  ; ast_editor_state : Ast_editor_state.t
  ; mutable codelens : bool option
  ; mutable extended_hover : bool option
  ; mutable standard_hover : bool option
  ; mutable dune_diagnostics : bool option
  ; mutable syntax_documentation : bool option
  ; mutable prompted_for_ocamlmerlin_mlx : bool
  }

let sandbox t = t.sandbox
let language_client t = Option.map ~f:fst t.lsp_client
let ocaml_lsp t = Option.map ~f:snd t.lsp_client
let lsp_client t = t.lsp_client
let ocaml_version_exn t = Option.value_exn t.ocaml_version

let send_configuration
      ~codelens
      ~extended_hover
      ~standard_hover
      ~dune_diagnostics
      ~syntax_documentation
      client
  =
  let codelens =
    Option.map codelens ~f:(fun enable -> Ocaml_lsp.OcamllspSettingEnable.create ~enable)
  in
  let extendedHover =
    Option.map extended_hover ~f:(fun enable ->
      Ocaml_lsp.OcamllspSettingEnable.create ~enable)
  in
  let standardHover =
    Option.map standard_hover ~f:(fun enable ->
      Ocaml_lsp.OcamllspSettingEnable.create ~enable)
  in
  let duneDiagnostics =
    Option.map dune_diagnostics ~f:(fun enable ->
      Ocaml_lsp.OcamllspSettingEnable.create ~enable)
  in
  let syntaxDocumentation =
    Option.map syntax_documentation ~f:(fun enable ->
      Ocaml_lsp.OcamllspSettingEnable.create ~enable)
  in
  let settings =
    Ocaml_lsp.OcamllspSettings.create
      ~codelens
      ~extendedHover
      ~standardHover
      ~duneDiagnostics
      ~syntaxDocumentation
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

let set_configuration
      t
      ?codelens
      ?extended_hover
      ?standard_hover
      ?dune_diagnostics
      ?syntax_documentation
      ()
  =
  Option.iter codelens ~f:(fun codelens -> t.codelens <- codelens);
  Option.iter extended_hover ~f:(fun extended_hover -> t.extended_hover <- extended_hover);
  Option.iter standard_hover ~f:(fun standard_hover -> t.standard_hover <- standard_hover);
  Option.iter dune_diagnostics ~f:(fun dune_diagnostics ->
    t.dune_diagnostics <- dune_diagnostics);
  Option.iter syntax_documentation ~f:(fun syntax_documentation ->
    t.syntax_documentation <- syntax_documentation);
  match t.lsp_client with
  | None -> ()
  | Some (client, (_ : Ocaml_lsp.t)) ->
    send_configuration
      ~codelens:t.codelens
      ~extended_hover:t.extended_hover
      ~standard_hover:t.standard_hover
      ~dune_diagnostics:t.dune_diagnostics
      ~syntax_documentation:t.syntax_documentation
      client
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

let suggest_to_run_dune_pkg_lock () =
  let open Promise.Syntax in
  let (_ : unit Promise.t) =
    let+ maybe_choice =
      Window.showWarningMessage
        ~message:
          "Dune Package Manager is selected as the active sandbox, but no lock file is \
           present. Do you want to run dune pkg lock?"
        ~choices:
          [ ( "Generate lockfile"
            , fun () ->
                let (_ : unit Promise.t) =
                  Command_api.(execute Internal.run_dune_pkg_lock) ()
                in
                () )
          ; ( "Pick another sandbox"
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
  ()
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

let check_ocamlmerlin_mlx_available (sandbox : Sandbox.t) =
  let ocamlmerlin_mlx_version sandbox =
    Sandbox.get_command sandbox "ocamlmerlin-mlx" [ "--version" ] `Tool
  in
  let cwd = Sandbox.workspace_root () in
  Cmd.output ?cwd (ocamlmerlin_mlx_version sandbox)
  |> Promise.Result.fold
       ~ok:(fun (_ : string) -> ())
       ~error:(fun (_ : string) ->
         "\"ocamlmerlin-mlx\" is not installed in the current sandbox.")
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
    let args = Settings.(get server_args_setting) |> Option.value ~default:[] in
    let command = Sandbox.get_command t.sandbox "ocamllsp" args `Tool in
    Cmd.log command;
    let env =
      let extra_env_vars =
        Settings.server_extraEnv () |> Option.value ~default:Interop.Dict.empty
      in
      Interop.Dict.union (fun _k _v1 v2 -> Some v2) (Process.Env.env ()) extra_env_vars
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
    | Dune _dune ->
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
      let+ res =
        let client =
          let serverOptions = server_options t in
          let clientOptions = client_options () in
          LanguageClient.make
            ~id:"ocaml"
            ~name:"OCaml Platform VS Code extension"
            ~serverOptions
            ~clientOptions
            ()
        in
        LanguageClient.registerFeature client ~feature:client_capabilities;
        let open Promise.Syntax in
        let+ () = LanguageClient.start client in
        let initialize_result = LanguageClient.initializeResult client in
        let ocaml_lsp = Ocaml_lsp.of_initialize_result initialize_result in
        t.lsp_client <- Some (client, ocaml_lsp);
        (match Ocaml_lsp.is_version_up_to_date ocaml_lsp (ocaml_version_exn t) with
         | Ok () -> ()
         | Error (`Msg _) -> ());
        send_configuration
          client
          ~codelens:t.codelens
          ~extended_hover:t.extended_hover
          ~standard_hover:t.standard_hover
          ~dune_diagnostics:t.dune_diagnostics
          ~syntax_documentation:t.syntax_documentation;
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

let documentation_server_info () =
  let status_bar =
    Vscode.Window.createStatusBarItem ~alignment:StatusBarAlignment.Right ~priority:100 ()
  in
  let command =
    Command.create
      ~title:"Open Command Palette"
      ~command:"workbench.action.quickOpen"
      ~arguments:[ [%js.of: string] ">OCaml: Stop Documentation server" ]
      ()
  in
  StatusBarItem.set_command status_bar (`Command command);
  StatusBarItem.set_text status_bar "$(radio-tower) OCaml Documentation";
  status_bar
;;

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

let install_ocamlmerlin_mlx sandbox =
  let open Promise.Syntax in
  let* () = Sandbox.install_packages sandbox [ "ocamlmerlin-mlx" ] in
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
      (`String Command_api.Internal.select_sandbox.id);
    StatusBarItem.show status_bar_item;
    status_bar_item
  ;;

  let update sandbox_info ~new_sandbox =
    let status_bar_item_text = make_status_bar_item_text new_sandbox in
    StatusBarItem.set_text sandbox_info status_bar_item_text
  ;;
end

let make () =
  let sandbox = Sandbox.Global in
  let sandbox_info = Sandbox_info.make sandbox in
  let documentation_server_info = documentation_server_info () in
  let ast_editor_state = Ast_editor_state.make () in
  { sandbox
  ; lsp_client = None
  ; sandbox_info
  ; documentation_server_info
  ; repl = None
  ; ocaml_version = None
  ; ast_editor_state
  ; documentation_server = None
  ; codelens = None
  ; extended_hover = None
  ; standard_hover = None
  ; dune_diagnostics = None
  ; syntax_documentation = None
  ; prompted_for_ocamlmerlin_mlx = false
  }
;;

let set_documentation_context ~running =
  let document_server_on = "ocaml.documentation-server-on" in
  let (_ : unit Promise.t) =
    Command_api.(execute Vscode.set_context) (document_server_on, running)
  in
  ()
;;

let stop_documentation_server t =
  match t.documentation_server with
  | None -> ()
  | Some server ->
    StatusBarItem.hide t.documentation_server_info;
    t.documentation_server <- None;
    Documentation_server.dispose server |> Disposable.dispose;
    set_documentation_context ~running:false
;;

let set_sandbox t new_sandbox =
  Sandbox_info.update t.sandbox_info ~new_sandbox;
  t.sandbox <- new_sandbox;
  stop_documentation_server t;
  let (_ : unit Promise.t) = Command_api.(execute Internal.refresh_sandbox) ()
  and (_ : unit Promise.t) = Command_api.(execute Internal.refresh_switches) () in
  ()
;;

let start_documentation_server t ~path =
  match
    match t.documentation_server with
    | None -> `Create
    | Some ds ->
      if Path.equal (Documentation_server.path ds) path then `Keep ds else `Create
  with
  | `Keep ds -> Promise.return (Ok ds)
  | `Create ->
    stop_documentation_server t;
    let open Promise.Syntax in
    let+ server = Documentation_server.start ~path in
    (match server with
     | Ok server ->
       StatusBarItem.show t.documentation_server_info;
       t.documentation_server <- Some server;
       set_documentation_context ~running:true;
       Ok server
     | Error e ->
       log "Error while starting the documentation server: %s" (Node.JsError.message e);
       Error ())
;;

let repl t = t.repl
let set_repl t repl = t.repl <- Some repl
let close_repl t = t.repl <- None

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

let open_terminal sandbox =
  let terminal = Terminal_sandbox.create sandbox in
  Terminal_sandbox.show ~preserveFocus:false terminal
;;

let ast_editor_state t = t.ast_editor_state

let suggest_or_install_ocamlmerlin_mlx t =
  let open Promise.Syntax in
  let install_mlx_text = "Install ocamlmerlin-mlx" in
  let select_different_sandbox = "Select a different Sandbox" in
  let* selection =
    Window.showInformationMessage
      ~message:
        "MLX support requires \"ocamlmerlin-mlx\". Without it, the language server may crash \
         when opening .mlx files."
      ~choices:[ install_mlx_text, `Install_mlx; select_different_sandbox, `Select_sandbox ]
      ()
  in
  match selection with
  | Some `Install_mlx ->
    let+ () = Command_api.(execute Internal.install_ocamlmerlin_mlx) () in
    ()
  | Some `Select_sandbox ->
    let+ () = Command_api.(execute Internal.select_sandbox) () in
    ()
  | _ -> Promise.return ()
;;

let check_mlx_file_opened t (document : TextDocument.t) =
  let file_name = TextDocument.fileName document in
  if String.is_suffix file_name ~suffix:".mlx" && not t.prompted_for_ocamlmerlin_mlx
  then (
    t.prompted_for_ocamlmerlin_mlx <- true;
    let (_ : unit Promise.t) =
      let open Promise.Syntax in
      let* ocamlmerlin_mlx_present = check_ocamlmerlin_mlx_available t.sandbox in
      match ocamlmerlin_mlx_present with
      | Ok () -> Promise.return ()
      | Error _ -> suggest_or_install_ocamlmerlin_mlx t
    in
    ())
;;

let register_mlx_check t =
  let listener document = check_mlx_file_opened t document in
  Workspace.onDidOpenTextDocument ~listener ()
;;

let disposable t =
  Disposable.make ~dispose:(fun () ->
    StatusBarItem.dispose t.sandbox_info;
    StatusBarItem.dispose t.documentation_server_info;
    let (_ : unit Promise.t) = stop_server t in
    stop_documentation_server t)
;;
