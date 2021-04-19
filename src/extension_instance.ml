open Import

type t =
  { mutable sandbox : Sandbox.t
  ; mutable repl : Terminal_sandbox.t option
  ; mutable lsp_client : (LanguageClient.t * Ocaml_lsp.t) option
  ; sandbox_info : StatusBarItem.t
  }

let sandbox t = t.sandbox

let language_client t = Option.map ~f:fst t.lsp_client

let ocaml_lsp t = Option.map ~f:snd t.lsp_client

let lsp_client t = t.lsp_client

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
  let command = Sandbox.get_lsp_command sandbox in
  Cmd.log command;
  match command with
  | Shell command ->
    let options = LanguageClient.ExecutableOptions.create ~shell:true () in
    LanguageClient.Executable.create ~command ~options ()
  | Spawn { bin; args } ->
    let command = Path.to_string bin in
    let options = LanguageClient.ExecutableOptions.create ~shell:false () in
    LanguageClient.Executable.create ~command ~args ~options ()

let stop_server t =
  Option.iter t.lsp_client ~f:(fun (client, _) ->
      t.lsp_client <- None;
      LanguageClient.stop client)

let start_language_server t =
  stop_server t;
  let res =
    let open Promise.Result.Syntax in
    let* () =
      let open Promise.Syntax in
      let+ has_command = Sandbox.has_command t.sandbox "ocamllsp" in
      if has_command then
        Ok ()
      else
        Error "Sandbox initialisation failed: ocaml-lsp-server is not installed"
    in
    let serverOptions = server_options t.sandbox in
    let clientOptions = client_options () in
    let client =
      LanguageClient.make ~id:"ocaml" ~name:"OCaml Platform VS Code extension"
        ~serverOptions ~clientOptions ()
    in
    LanguageClient.start client;

    let open Promise.Syntax in
    let+ initialize_result = LanguageClient.readyInitializeResult client in
    let ocaml_lsp = Ocaml_lsp.of_initialize_result initialize_result in
    t.lsp_client <- Some (client, ocaml_lsp);
    if
      (not (Ocaml_lsp.has_interface_specific_lang_id ocaml_lsp))
      || (not (Ocaml_lsp.can_handle_switch_impl_intf ocaml_lsp))
      || not (Ocaml_lsp.can_handle_infer_intf ocaml_lsp)
      (* TODO: switch to ocaml-lsp version based approach Using
         [initializeResult] of [LanguageClient] we can get ocaml-lsp's version.
         We can use versions instead of capabilities to suggest the user to
         update their ocaml-lsp. *)
    then
      show_message `Warn
        "The installed version of ocamllsp is out of date. Some features may \
         be unavailable or degraded in functionality: switching between \
         implementation and interface files, functionality in mli sources. \
         Consider updating ocamllsp.";
    Ok ()
  in
  let open Promise.Syntax in
  let+ res = res in
  match res with
  | Ok () -> ()
  | Error s -> show_message `Error "Error starting server: %s" s

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
  { sandbox; lsp_client = None; sandbox_info; repl = None }

let set_sandbox t new_sandbox =
  Sandbox_info.update t.sandbox_info ~new_sandbox;
  t.sandbox <- new_sandbox;
  let (_ : Ojs.t option Promise.t) =
    Vscode.Commands.executeCommand
      ~command:Extension_consts.Commands.refresh_sandbox ~args:[]
  in
  ()

let repl t = t.repl

let set_repl t repl = t.repl <- Some repl

let close_repl t = t.repl <- None

let open_terminal sandbox =
  let terminal = Terminal_sandbox.create sandbox in
  Terminal_sandbox.show terminal

let disposable t =
  Disposable.make ~dispose:(fun () ->
      StatusBarItem.dispose t.sandbox_info;
      stop_server t)
