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
    let current_toolchain = Extension_instance.toolchain instance in
    let (_ : unit Promise.t) =
      let* toolchain = Toolchain.select_toolchain () in
      match toolchain with
      | None (* sandbox selection cancelled *) -> Promise.return ()
      | Some new_toolchain ->
        if Toolchain.equal current_toolchain new_toolchain then
          (* TODO: or should we relaunch so that user wishes to "restart" their toolchain *)
          Promise.return ()
        else
          let* () =
            Extension_instance.update_on_new_toolchain instance new_toolchain
            |> Promise.Result.iter ~error:(fun e ->
                   show_message `Error "Error: %s" e)
          in
          Toolchain.save_to_settings new_toolchain
    in
    ()
  in
  command Extension_consts.Commands.select_sandbox handler

let restart_language_server =
  let handler (instance : Extension_instance.t) () =
    let (_ : unit Promise.t) =
      Extension_instance.restart_language_server instance
      |> Promise.Result.iter ~error:(show_message `Error "%s")
    in
    ()
  in
  command Extension_consts.Commands.restart_language_server handler

let select_sandbox_and_open_terminal =
  let handler _instance () =
    let (_ : unit option Promise.t) =
      let open Promise.Option.Syntax in
      let+ toolchain = Toolchain.select_toolchain () in
      Extension_instance.open_terminal toolchain
    in
    ()
  in
  command Extension_consts.Commands.select_sandbox_and_open_terminal handler

let open_terminal =
  let handler (instance : Extension_instance.t) () =
    Extension_instance.toolchain instance |> Extension_instance.open_terminal
  in
  command Extension_consts.Commands.open_terminal handler

let switch_impl_intf =
  let handler (instance : Extension_instance.t) () =
    let try_switching () =
      let open Option.O in
      let+ editor = Window.activeTextEditor () in
      let document = TextEditor.document editor in
      let client = Extension_instance.language_client instance in
      (* extension needs to be activated; otherwise, just ignore the switch try *)
      let ocaml_lsp = Extension_instance.ocaml_lsp instance in
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
  command Extension_consts.Commands.switch_impl_intf handler

let register_all_commands extension instance =
  let register_command { id; handler } =
    let callback ~args:_ = handler instance () in
    let disposable = Commands.registerCommand ~command:id ~callback in
    ExtensionContext.subscribe extension ~disposable
  in
  List.iter ~f:register_command !commands
