open Import

type command =
  { id : string
  ; handler : Extension_instance.t -> unit -> unit
        (* [handler] is intended to be used partially applied;
           [handler extension_instance] is passed as a callback to [Commands.registerCommand] *)
  }

let commands = ref []

(** creates a new command and stores in a mutable [commands] list *)
let command id handler =
  let command = { id; handler } in
  commands := command :: !commands;
  command

let select_sandbox =
  let handler (instance : Extension_instance.t) () =
    let open Promise.Syntax in
    let current_toolchain = instance.toolchain in
    let (_ : unit Promise.t) =
      let* package_manager = Toolchain.select_sandbox () in
      match package_manager with
      | None (* sandbox selection cancelled *) -> Promise.return ()
      | Some pm ->
        let new_toolchain = Toolchain.make pm in
        if Toolchain.equal current_toolchain new_toolchain then
          (* TODO: or should we relaunch so that user wishes to "restart" their toolchain *)
          Promise.return ()
        else
          let* () =
            Extension_instance.update_on_new_toolchain instance new_toolchain
            |> Promise.Result.iter ~error:(fun e ->
                   show_message `Error "Error: %s" e)
          in
          Toolchain.save_to_settings instance.toolchain
    in
    ()
  in
  command select_sandbox_command_id handler

let restart_language_server =
  let handler (instance : Extension_instance.t) () =
    let open Promise.Syntax in
    let (_ : unit Promise.t) =
      LanguageClient.stop instance.client;
      let+ r = Extension_instance.start_language_server instance.toolchain in
      match r with
      | Ok (client, ocaml_lsp) ->
        instance.client <- client;
        instance.ocaml_lsp <- ocaml_lsp
      | Error e -> show_message `Error "%s" e
    in
    ()
  in
  command "ocaml.server.restart" handler

let select_sandbox_and_open_terminal =
  let handler _instance () =
    let (_ : unit option Promise.t) =
      let open Promise.Option.Syntax in
      let+ pm = Toolchain.select_sandbox () in
      let toolchain = Toolchain.make pm in
      Extension_instance.open_terminal toolchain
    in
    ()
  in
  command "ocaml.open-terminal-select" handler

let open_terminal =
  let handler (instance : Extension_instance.t) () =
    Extension_instance.open_terminal instance.toolchain
  in
  command "ocaml.open-terminal" handler

let switch_impl_intf =
  let handler (instance : Extension_instance.t) () =
    let try_switching () =
      let open Option.O in
      let+ editor = Window.activeTextEditor () in
      let document = TextEditor.document editor in
      let client = instance.client in
      (* extension needs to be activated; otherwise, just ignore the switch try *)
      let ocaml_lsp = instance.ocaml_lsp in
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
  List.iter ~f:register_command !commands
