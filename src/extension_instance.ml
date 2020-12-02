open Import

type t =
  { mutable sandbox : Sandbox.t
  ; mutable client : LanguageClient.t
  ; mutable ocaml_lsp : Ocaml_lsp.t
  ; sandbox_info : StatusBarItem.t
  }

let sandbox t = t.sandbox

let language_client t = t.client

let ocaml_lsp t = t.ocaml_lsp

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

let start_language_server sandbox =
  let open Promise.Result.Syntax in
  let* () = Sandbox.run_setup sandbox in

  let serverOptions = server_options sandbox in
  let clientOptions = client_options () in
  let client =
    LanguageClient.make ~id:"ocaml" ~name:"OCaml Platform VS Code extension"
      ~serverOptions ~clientOptions ()
  in
  LanguageClient.start client;

  let open Promise.Syntax in
  let+ initialize_result = LanguageClient.readyInitializeResult client in
  let ocaml_lsp = Ocaml_lsp.of_initialize_result initialize_result in
  if
    (not (Ocaml_lsp.has_interface_specific_lang_id ocaml_lsp))
    || (not (Ocaml_lsp.can_handle_switch_impl_intf ocaml_lsp))
    || not (Ocaml_lsp.can_handle_infer_intf ocaml_lsp)
    (* TODO: switch to ocaml-lsp version based approach Using [initializeResult]
       of [LanguageClient] we can get ocaml-lsp's version. We can use versions
       instead of capabilities to suggest the user to update their ocaml-lsp. *)
  then
    show_message `Warn
      "The installed version of ocamllsp is out of date. Some features may be \
       unavailable or degraded in functionality: switching between \
       implementation and interface files, functionality in mli sources. \
       Consider updating ocamllsp.";

  Ok (client, ocaml_lsp)

let restart_language_server t =
  let open Promise.Result.Syntax in
  LanguageClient.stop t.client;
  let+ language_client, ocaml_lsp = start_language_server t.sandbox in
  t.client <- language_client;
  t.ocaml_lsp <- ocaml_lsp

module Sandbox_info : sig
  val make : Sandbox.t -> StatusBarItem.t

  val update : StatusBarItem.t -> new_sandbox:Sandbox.t -> unit
end = struct
  let make_status_bar_item_text sandbox =
    Printf.sprintf "%s %s" LabelIcons.package
    @@ Sandbox.to_pretty_string sandbox

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

let make sandbox =
  let sandbox_info = Sandbox_info.make sandbox in
  let open Promise.Result.Syntax in
  let+ client, ocaml_lsp = start_language_server sandbox in
  { sandbox; client; ocaml_lsp; sandbox_info }

let update_on_new_sandbox t new_sandbox =
  Sandbox_info.update t.sandbox_info ~new_sandbox;
  LanguageClient.stop t.client;
  let open Promise.Result.Syntax in
  let+ client, ocaml_lsp = start_language_server new_sandbox in
  t.sandbox <- new_sandbox;
  t.client <- client;
  t.ocaml_lsp <- ocaml_lsp;
  ()

let open_terminal sandbox =
  match Terminal_sandbox.create sandbox with
  | Some terminal -> Terminal_sandbox.show terminal
  | None ->
    show_message `Error
      "Could not open a terminal in the current sandbox. The sandbox may not \
       have loaded yet."

let disposable t =
  Disposable.make ~dispose:(fun () ->
      StatusBarItem.dispose t.sandbox_info;
      LanguageClient.stop t.client)
