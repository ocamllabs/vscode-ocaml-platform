open Import

module ExtensionCommands = struct
  type command =
    { id : string
    ; handler : Extension_instance.t -> unit -> unit
    }

  let command id handler = { id; handler }

  let select_sandbox =
    let handler (instance : Extension_instance.t) () =
      let set_toolchain =
        let open Promise.Syntax in
        let* package_manager = Toolchain.select_and_save () in
        match package_manager with
        | None -> Promise.Result.return ()
        | Some pm ->
          Extension_instance.stop instance;
          let t = Toolchain.make pm in
          Extension_instance.start instance t
      in
      let (_ : unit Promise.t) =
        Promise.Result.iter set_toolchain ~error:(show_message `Error "%s")
      in
      ()
    in
    command select_sandbox_command_id handler

  let restart_instance =
    let handler (instance : Extension_instance.t) () =
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let* package_manager = Toolchain.of_settings () in
        match package_manager with
        | None ->
          select_sandbox.handler instance ();
          Promise.return ()
        | Some pm ->
          Extension_instance.stop_language_server instance;
          Extension_instance.start_language_server instance (Toolchain.make pm)
          |> Promise.Result.iter ~error:(show_message `Error "%s")
      in
      ()
    in
    command "ocaml.server.restart" handler

  let select_sandbox_and_open_terminal =
    let handler _instance () =
      let (_ : unit option Promise.t) =
        let open Promise.Option.Syntax in
        let+ pm = Toolchain.select () in
        let toolchain = Toolchain.make pm in
        Extension_instance.open_terminal toolchain
      in
      ()
    in
    command "ocaml.open-terminal-select" handler

  let open_terminal =
    let handler (instance : Extension_instance.t) () =
      match instance.toolchain with
      | None -> select_sandbox_and_open_terminal.handler instance ()
      | Some toolchain -> Extension_instance.open_terminal toolchain
    in
    command "ocaml.open-terminal" handler

  let switch_impl_intf =
    let handler (instance : Extension_instance.t) () =
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
          @@ show_message `Warn
               "The installed version of ocamllsp does not support switching \
                between implementation and interface files. Consider updating \
                ocamllsp."
      in
      let (_ : unit Promise.t option) = try_switching () in
      ()
    in
    command "ocaml.switch-impl-intf" handler

  let register_all_commands extension instance =
    let register_command { id; handler } =
      let callback ~args:_ = handler instance () in
      let disposable = Commands.registerCommand ~command:id ~callback in
      ExtensionContext.subscribe extension ~disposable
    in
    List.iter ~f:register_command
      [ select_sandbox
      ; restart_instance
      ; open_terminal
      ; select_sandbox_and_open_terminal
      ; switch_impl_intf
      ]
end

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
  | Some () -> ExtensionCommands.select_sandbox.handler instance ()

let activate (extension : ExtensionContext.t) =
  (* this env var update disables ocaml-lsp's logging to a file
     because we use vscode [output] pane for logs *)
  Process.Env.set "OCAML_LSP_SERVER_LOG" "-";
  let instance = Extension_instance.create () in
  ExtensionCommands.register_all_commands extension instance;
  ExtensionContext.subscribe extension
    ~disposable:(Extension_instance.disposable instance);
  let open Promise.Syntax in
  let* toolchain, is_fallback =
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
  Extension_instance.start instance toolchain
  |> Promise.Result.iter ~error:(fun e ->
         if not is_fallback then show_message `Error "%s" e)
  |> Promise.catch ~rejected:(fun e ->
         let error_message = Node.JsError.message e in
         show_message `Error "Error: %s" error_message;
         Promise.return ())

let () =
  let open Js_of_ocaml.Js in
  export "activate" (wrap_callback activate)
