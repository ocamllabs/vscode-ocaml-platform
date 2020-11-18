open Import

let select_sandbox_command_id = "ocaml.select-sandbox"

let restart_command_id = "ocaml.server.restart"

let open_terminal_command_id = "ocaml.open-terminal"

let open_terminal_select_command_id = "ocaml.open-terminal-select"

let switch_impl_intf_command_id = "ocaml.switch-impl-intf"

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

module Instance = struct
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
      LanguageClient.make ~id:"ocaml" ~name:"OCaml Language Server"
        ~serverOptions ~clientOptions ()
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
      message `Warn
        "The installed version of ocamllsp is out of date. Some features may \
         be unavailable or degraded in functionality: switching between \
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
    StatusBarItem.set_command status_bar_item
      (`String select_sandbox_command_id);
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
      message `Error
        "Could not open a terminal in the current sandbox. The toolchain may \
         not have loaded yet."

  let disposable t = Disposable.make ~dispose:(fun () -> stop t)
end

let select_sandbox (instance : Instance.t) () =
  let set_toolchain =
    let open Promise.Syntax in
    let* package_manager = Toolchain.select_and_save () in
    match package_manager with
    | None -> Promise.Result.return ()
    | Some pm ->
      Instance.stop instance;
      let t = Toolchain.make pm in
      Instance.start instance t
  in
  let (_ : unit Promise.t) =
    Promise.Result.iter set_toolchain ~error:(message `Error "%s")
  in
  ()

let restart_instance (instance : Instance.t) () =
  let (_ : unit Promise.t) =
    let open Promise.Syntax in
    let* package_manager = Toolchain.of_settings () in
    match package_manager with
    | None ->
      select_sandbox instance ();
      Promise.return ()
    | Some pm ->
      Instance.stop_language_server instance;
      Instance.start_language_server instance (Toolchain.make pm)
      |> Promise.Result.iter ~error:(message `Error "%s")
  in
  ()

let select_sandbox_and_open_terminal () =
  let (_ : unit option Promise.t) =
    let open Promise.Option.Syntax in
    let+ pm = Toolchain.select () in
    let toolchain = Toolchain.make pm in
    Instance.open_terminal toolchain
  in
  ()

let open_terminal (instance : Instance.t) () =
  match instance.toolchain with
  | None -> select_sandbox_and_open_terminal ()
  | Some toolchain -> Instance.open_terminal toolchain

let switch_impl_intf (instance : Instance.t) () =
  let try_switching () =
    let open Option.O in
    let* editor = Window.activeTextEditor () in
    let document = TextEditor.document editor in
    let* client = instance.client in
    (* extension needs to be activated; otherwise, just ignore the switch try *)
    let+ ocaml_lsp = instance.ocaml_lsp_capabilities in
    (* same as for instance.client; ignore the try if it's None *)
    if Ocaml_lsp.can_handle_switch_impl_intf ocaml_lsp then
      Switch_impl_intf.request_switch client document
    else
      (* if, however, ocamllsp doesn't have the capability, recommend updating ocamllsp*)
      Promise.return
      @@ message `Warn
           "The installed version of ocamllsp does not support switching \
            between implementation and interface files. Consider updating \
            ocamllsp."
  in
  let (_ : unit Promise.t option) = try_switching () in
  ()

let suggest_to_setup_toolchain instance =
  let open Promise.Syntax in
  let+ selection =
    Window.showInformationMessage
      ~message:
        "Extension is unable to find ocamllsp automatically. Please select \
         package manager you used to install ocamllsp for this project."
      ~choices:[ ("Select package manager", ()) ]
      ()
  in
  match selection with
  | None -> ()
  | Some () -> select_sandbox instance ()

let register_commands extension =
  List.iter ~f:(function command, callback ->
      let callback ~args:_ = callback () in
      ExtensionContext.subscribe extension
        ~disposable:(Commands.registerCommand ~command ~callback))

let activate (extension : ExtensionContext.t) =
  Process.Env.set "OCAML_LSP_SERVER_LOG" "-";
  let instance = Instance.create () in
  register_commands extension
    [ (select_sandbox_command_id, select_sandbox instance)
    ; (restart_command_id, restart_instance instance)
    ; (open_terminal_command_id, open_terminal instance)
    ; (open_terminal_select_command_id, select_sandbox_and_open_terminal)
    ; (switch_impl_intf_command_id, switch_impl_intf instance)
    ];
  ExtensionContext.subscribe extension
    ~disposable:(Instance.disposable instance);
  let open Promise.Syntax in
  let toolchain =
    let+ pm = Toolchain.of_settings () in
    let resources, is_fallback =
      match pm with
      | Some pm -> (pm, false)
      | None ->
        let (_ : unit Promise.t) = suggest_to_setup_toolchain instance in
        (Toolchain.Package_manager.Global, true)
    in
    (Toolchain.make resources, is_fallback)
  in
  let* toolchain, is_fallback = toolchain in
  Instance.start instance toolchain
  |> Promise.Result.iter ~error:(fun e ->
         if not is_fallback then message `Error "%s" e)
  |> Promise.catch ~rejected:(fun e ->
         let error_message = Node.JsError.message e in
         message `Error "Error: %s" error_message;
         Promise.return ())

let () =
  let open Js_of_ocaml.Js in
  export "activate" (wrap_callback activate)
