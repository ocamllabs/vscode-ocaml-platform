open Import

type t =
  { mutable toolchain : Toolchain.t
  ; mutable client : LanguageClient.t
  ; mutable ocaml_lsp : Ocaml_lsp.t
  ; sandbox_info : StatusBarItem.t
  }

let toolchain t = t.toolchain

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

let server_options toolchain =
  let command = Toolchain.get_lsp_command toolchain in
  Cmd.log command;
  match command with
  | Shell command ->
    let options = LanguageClient.ExecutableOptions.create ~shell:true () in
    LanguageClient.Executable.create ~command ~options ()
  | Spawn { bin; args } ->
    let command = Path.to_string bin in
    let options = LanguageClient.ExecutableOptions.create ~shell:false () in
    LanguageClient.Executable.create ~command ~args ~options ()

let start_language_server toolchain =
  let open Promise.Result.Syntax in
  let* () = Toolchain.run_setup toolchain in

  let serverOptions = server_options toolchain in
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
    || not (Ocaml_lsp.can_handle_switch_impl_intf ocaml_lsp)
    (* TODO: switch to ocaml-lsp version based approach
       Using [initializeResult] of [LanguageClient] we can get ocaml-lsp's version.
       We can use versions instead of capabilities to suggest the user to update their
       ocaml-lsp. *)
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
  let+ language_client, ocaml_lsp = start_language_server t.toolchain in
  t.client <- language_client;
  t.ocaml_lsp <- ocaml_lsp

module Sandbox_info : sig
  val make : Toolchain.t -> StatusBarItem.t

  val update : StatusBarItem.t -> new_toolchain:Toolchain.t -> unit
end = struct
  let make_status_bar_item_text package_manager =
    Printf.sprintf "%s %s" LabelIcons.package
    @@ Toolchain.Package_manager.to_pretty_string package_manager

  let make toolchain =
    let status_bar_item =
      Window.createStatusBarItem ~alignment:StatusBarAlignment.Left ()
    in
    let status_bar_item_text =
      make_status_bar_item_text @@ Toolchain.package_manager toolchain
    in
    StatusBarItem.set_text status_bar_item status_bar_item_text;
    StatusBarItem.set_command status_bar_item
      (`String Extension_consts.Commands.select_sandbox);
    StatusBarItem.show status_bar_item;
    status_bar_item

  let update sandbox_info ~new_toolchain =
    let status_bar_item_text =
      make_status_bar_item_text @@ Toolchain.package_manager new_toolchain
    in
    StatusBarItem.set_text sandbox_info status_bar_item_text
end

let make toolchain =
  let sandbox_info = Sandbox_info.make toolchain in
  let open Promise.Result.Syntax in
  let+ client, ocaml_lsp = start_language_server toolchain in
  { toolchain; client; ocaml_lsp; sandbox_info }

let update_on_new_toolchain t new_toolchain =
  Sandbox_info.update t.sandbox_info ~new_toolchain;
  LanguageClient.stop t.client;
  let open Promise.Result.Syntax in
  let+ client, ocaml_lsp = start_language_server new_toolchain in
  t.toolchain <- new_toolchain;
  t.client <- client;
  t.ocaml_lsp <- ocaml_lsp;
  ()

let open_terminal toolchain =
  match Terminal_sandbox.create toolchain with
  | Some terminal -> Terminal_sandbox.show terminal
  | None ->
    show_message `Error
      "Could not open a terminal in the current sandbox. The toolchain may not \
       have loaded yet."

let disposable t =
  Disposable.make ~dispose:(fun () ->
      StatusBarItem.dispose instance.sandbox_info;
      LanguageClient.stop instance.client)
