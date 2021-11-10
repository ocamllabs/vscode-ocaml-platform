open Import

type t =
  { mutable sandbox : Sandbox.t
  ; mutable repl : Terminal_sandbox.t option
  ; mutable lsp_client : (LanguageClient.t * Ocaml_lsp.t) option
  ; mutable ocaml : Ocaml.t option
  ; sandbox_info : StatusBarItem.t
  ; ast_editor_state : Ast_editor_state.t
  }

let sandbox t = t.sandbox

let language_client t = Option.map ~f:fst t.lsp_client

let ocaml_lsp t = Option.map ~f:snd t.lsp_client

let lsp_client t = t.lsp_client

let stop_server t =
  Option.iter t.lsp_client ~f:(fun (client, _) ->
      t.lsp_client <- None;
      LanguageClient.stop client)

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
         ; language "reason"
        |]
    in
    let (lazy outputChannel) = Output.language_server_output_channel in
    let revealOutputChannelOn = LanguageClient.RevealOutputChannelOn.Never in
    LanguageClient.ClientOptions.create ~outputChannel ~revealOutputChannelOn
      ~documentSelector ()

  let server_options sandbox =
    let command = Sandbox.get_command sandbox "ocamllsp" [] in
    Cmd.log command;
    let env =
      let extra_env_vars =
        Settings.server_extraEnv () |> Option.value ~default:Interop.Dict.empty
      in
      Interop.Dict.union
        (fun _k _v1 v2 -> Some v2)
        Process.Env.env extra_env_vars
    in
    match command with
    | Shell command ->
      let options =
        LanguageClient.ExecutableOptions.create ~env ~shell:true ()
      in
      LanguageClient.Executable.create ~command ~options ()
    | Spawn { bin; args } ->
      let command = Path.to_string bin in
      let options =
        LanguageClient.ExecutableOptions.create ~env ~shell:false ()
      in
      LanguageClient.Executable.create ~command ~args ~options ()

  let check_ocaml_lsp_available sandbox =
    let ocaml_lsp_version sandbox =
      Sandbox.get_command sandbox "ocamllsp" [ "--version" ]
    in
    Cmd.output (ocaml_lsp_version sandbox)
    |> Promise.Result.fold
         ~ok:(fun (_ : string) -> ())
         ~error:(fun (_ : string) ->
           "Sandbox initialization failed: `ocaml-lsp-server` is not installed \
            in the current sandbox.")

  let start_language_server t =
    stop_server t;
    let open Promise.Syntax in
    let+ res =
      let open Promise.Result.Syntax in
      let* () = check_ocaml_lsp_available t.sandbox in
      let client =
        let serverOptions = server_options t.sandbox in
        let clientOptions = client_options () in
        LanguageClient.make ~id:"ocaml" ~name:"OCaml Platform VS Code extension"
          ~serverOptions ~clientOptions ()
      in
      LanguageClient.start client;
      let open Promise.Syntax in
      let+ initialize_result = LanguageClient.ready_initialize_result client in
      let ocaml_lsp = Ocaml_lsp.of_initialize_result initialize_result in
      t.lsp_client <- Some (client, ocaml_lsp);
      if
        (not (Ocaml_lsp.has_interface_specific_lang_id ocaml_lsp))
        || (not (Ocaml_lsp.can_handle_switch_impl_intf ocaml_lsp))
        || not (Ocaml_lsp.can_handle_infer_intf ocaml_lsp)
        (* TODO: switch to ocaml-lsp version based approach Using
           [initializeResult] of [LanguageClient] we can get ocaml-lsp's
           version. We can use versions instead of capabilities to suggest the
           user to update their ocaml-lsp. *)
      then
        show_message `Warn
          "The installed version of ocamllsp is out of date. Some features may \
           be unavailable or degraded in functionality: switching between \
           implementation and interface files, functionality in mli sources. \
           Consider updating ocamllsp.";
      Ok ()
    in
    match res with
    | Ok () -> ()
    | Error s -> show_message `Error "Error starting server: %s" s
end

include Language_server_init

module Sandbox_info : sig
  val make : Sandbox.t -> StatusBarItem.t

  val update : StatusBarItem.t -> new_sandbox:Sandbox.t -> unit
end = struct
  let make_status_bar_item_text sandbox =
    Printf.sprintf "$(package) %s" @@ Sandbox.to_pretty_string sandbox

  let make sandbox =
    let status_bar_item =
      Window.createStatusBarItem ~alignment:StatusBarAlignment.Left ()
    in
    let status_bar_item_text = make_status_bar_item_text sandbox in
    StatusBarItem.set_text status_bar_item status_bar_item_text;
    StatusBarItem.set_command status_bar_item
      (`String Extension_consts.Commands.select_sandbox);
    StatusBarItem.show status_bar_item;
    status_bar_item

  let update sandbox_info ~new_sandbox =
    let status_bar_item_text = make_status_bar_item_text new_sandbox in
    StatusBarItem.set_text sandbox_info status_bar_item_text
end

let make () =
  let sandbox = Sandbox.Global in
  let sandbox_info = Sandbox_info.make sandbox in
  let ast_editor_state = Ast_editor_state.make () in
  { sandbox
  ; lsp_client = None
  ; sandbox_info
  ; repl = None
  ; ocaml = None
  ; ast_editor_state
  }

let set_sandbox t new_sandbox =
  Sandbox_info.update t.sandbox_info ~new_sandbox;
  t.sandbox <- new_sandbox;
  let (_ : Ojs.t option Promise.t) =
    Vscode.Commands.executeCommand
      ~command:Extension_consts.Commands.refresh_sandbox ~args:[]
  and (_ : Ojs.t option Promise.t) =
    Vscode.Commands.executeCommand
      ~command:Extension_consts.Commands.refresh_switches ~args:[]
  in
  ()

let repl t = t.repl

let set_repl t repl = t.repl <- Some repl

let close_repl t = t.repl <- None

let update_ocaml_info t =
  let open Promise.Syntax in
  let+ ocaml = Ocaml.make t.sandbox in
  match ocaml with
  | Ok ocaml -> t.ocaml <- Some ocaml
  | Error `Ocamlc_missing ->
    (* we need to put [None] in [t.ocaml] because we don't want [t.ocaml] to be
       left over from a previous sandbox, which had [ocamlc] *)
    t.ocaml <- None;
    show_message `Error "OCaml binaries such as `ocamlc` are missing."
  | Error (`Unable_to_parse_version v) ->
    t.ocaml <- None;
    show_message `Error "Ocaml binary `ocamlc` version could not be parsed: %s"
      v

let open_terminal sandbox =
  let terminal = Terminal_sandbox.create sandbox in
  Terminal_sandbox.show terminal

let ast_editor_state t = t.ast_editor_state

let disposable t =
  Disposable.make ~dispose:(fun () ->
      StatusBarItem.dispose t.sandbox_info;
      stop_server t)
