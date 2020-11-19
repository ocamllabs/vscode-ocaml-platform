open Import

type t =
  { mutable toolchain : Toolchain.t option
  ; mutable client : LanguageClient.t option
  ; mutable ocaml_lsp_capabilities : Ocaml_lsp.t option
  ; mutable sandbox_info : StatusBarItem.t option
  ; dune_formatter : Dune_formatter.t
  ; dune_task_provider : Dune_task_provider.t
  }

let create () =
  { toolchain = None
  ; client = None
  ; ocaml_lsp_capabilities = None
  ; sandbox_info = None
  ; dune_formatter = Dune_formatter.create ()
  ; dune_task_provider = Dune_task_provider.create ()
  }

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
  LanguageClient.ClientOptions.create ~documentSelector ~outputChannel
    ~revealOutputChannelOn ()

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

let stop_language_server t =
  Option.iter t.client ~f:(fun client ->
      LanguageClient.stop client;
      t.client <- None)

let stop t =
  Dune_formatter.dispose t.dune_formatter;
  Dune_task_provider.dispose t.dune_task_provider;

  Option.iter t.sandbox_info ~f:(fun status_bar_item ->
      StatusBarItem.dispose status_bar_item;
      t.sandbox_info <- None);

  stop_language_server t;

  t.ocaml_lsp_capabilities <- None;
  t.toolchain <- None

let start_language_server t toolchain =
  let open Promise.Result.Syntax in
  let* () = Toolchain.run_setup toolchain in
  let serverOptions = server_options toolchain in
  let clientOptions = client_options () in
  let client =
    LanguageClient.make ~id:"ocaml" ~name:"OCaml Language Server" ~serverOptions
      ~clientOptions ()
  in
  t.client <- Some client;
  LanguageClient.start client;

  let open Promise.Syntax in
  let+ initialize_result = LanguageClient.readyInitializeResult client in
  let ocaml_lsp = Ocaml_lsp.of_initialize_result initialize_result in
  t.ocaml_lsp_capabilities <- Some ocaml_lsp;
  if
    (not (Ocaml_lsp.has_interface_specific_lang_id ocaml_lsp))
    || not (Ocaml_lsp.can_handle_switch_impl_intf ocaml_lsp)
  then
    show_message `Warn
      "The installed version of ocamllsp is out of date. Some features may be \
       unavailable or degraded in functionality: switching between \
       implementation and interface files, functionality in mli sources. \
       Consider updating ocamllsp.";
  Ok ()

let make_sandbox_info toolchain =
  let status_bar_item =
    Window.createStatusBarItem ~alignment:StatusBarAlignment.Left ()
  in
  let package_manager = Toolchain.package_manager toolchain in
  let status_bar_item_text =
    let package_icon =
      "$(package)"
      (* see https://code.visualstudio.com/api/references/icons-in-labels *)
    in
    Printf.sprintf "%s %s" package_icon
    @@ Toolchain.Package_manager.to_pretty_string package_manager
  in
  StatusBarItem.set_text status_bar_item status_bar_item_text;
  StatusBarItem.set_command status_bar_item (`String select_sandbox_command_id);
  StatusBarItem.show status_bar_item;
  status_bar_item

let start t toolchain =
  t.toolchain <- Some toolchain;
  Dune_formatter.register t.dune_formatter toolchain;
  Dune_task_provider.register t.dune_task_provider toolchain;
  t.sandbox_info <- Some (make_sandbox_info toolchain);
  start_language_server t toolchain

let open_terminal toolchain =
  match Terminal_sandbox.create toolchain with
  | Some terminal -> Terminal_sandbox.show terminal
  | None ->
    show_message `Error
      "Could not open a terminal in the current sandbox. The toolchain may not \
       have loaded yet."

let disposable t = Disposable.make ~dispose:(fun () -> stop t)
