open Import

type command =
  { id : string
  ; handler : Extension_instance.t -> args:Ojs.t list -> unit
        (* [handler] is intended to be used partially applied; [handler
           extension_instance] is passed as a callback to
           [Commands.registerCommand] *)
  }

let make_command id handler = { id; handler }

let commands = ref []

(** creates a new command and stores in a mutable [commands] list *)
let command id handler =
  let command = { id; handler } in
  commands := command :: !commands;
  command

let select_sandbox =
  let handler (instance : Extension_instance.t) ~args:_ =
    let open Promise.Syntax in
    let (_ : unit Promise.t) =
      let* sandbox = Sandbox.select_sandbox () in
      match sandbox with
      | None (* sandbox selection cancelled *) -> Promise.return ()
      | Some new_sandbox ->
        Extension_instance.set_sandbox instance new_sandbox;
        let (_ : unit Promise.t) = Sandbox.save_to_settings new_sandbox in
        Extension_instance.start_language_server instance
    in
    ()
  in
  command Extension_consts.Commands.select_sandbox handler

let restart_language_server =
  let handler (instance : Extension_instance.t) ~args:_ =
    let (_ : unit Promise.t) =
      Extension_instance.start_language_server instance
    in
    ()
  in
  command Extension_consts.Commands.restart_language_server handler

let select_sandbox_and_open_terminal =
  let handler _instance ~args:_ =
    let (_ : unit option Promise.t) =
      let open Promise.Option.Syntax in
      let+ sandbox = Sandbox.select_sandbox () in
      Extension_instance.open_terminal sandbox
    in
    ()
  in
  command Extension_consts.Commands.select_sandbox_and_open_terminal handler

let open_terminal =
  let handler (instance : Extension_instance.t) ~args:_ =
    Extension_instance.sandbox instance |> Extension_instance.open_terminal
  in
  command Extension_consts.Commands.open_terminal handler

let switch_impl_intf =
  let handler (instance : Extension_instance.t) ~args:_ =
    let try_switching () =
      let open Option.O in
      let+ editor = Window.activeTextEditor () in
      let document = TextEditor.document editor in
      match Extension_instance.lsp_client instance with
      | None -> Promise.return (show_message `Warn "ocamllsp is not running.")
      | Some (client, ocaml_lsp) ->
        (* same as for instance.client; ignore the try if it's None *)
        if Ocaml_lsp.can_handle_switch_impl_intf ocaml_lsp then
          Switch_impl_intf.request_switch client document
        else
          (* if, however, ocamllsp doesn't have the capability, recommend
             updating ocamllsp*)
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

let remove_switch =
  let handler (_ : Extension_instance.t) ~args =
    let (_ : unit Promise.t) =
      let arg = List.hd_exn args in
      let tree_item = TreeItem.t_of_js arg in
      let dependency =
        tree_item |> TreeItem.id |> Stdlib.Option.get
        |> Treeview_switches.Dependency.of_string
      in
      match dependency with
      | Dependency _ ->
        Promise.return
        @@ show_message `Warn
             "Cannot delete a switch from a package dependency."
      | Switch switch -> (
        let open Promise.Syntax in
        let* opam_opt = Opam.make () in
        match opam_opt with
        | None ->
          Promise.return
          @@ show_message `Warn "Opam could not be found on your system."
        | Some opam -> (
          let+ result = Opam.remove_switch opam switch |> Cmd.output in
          match result with
          | Error err -> show_message `Error "%s" err
          | Ok _ ->
            let (_ : Ojs.t option Promise.t) =
              Vscode.Commands.executeCommand
                ~command:Extension_consts.Commands.refresh_switches ~args:[]
            in
            show_message `Info "The switch has been removed successfully." ) )
    in
    ()
  in
  command Extension_consts.Commands.remove_switch handler

let open_documentation =
  let handler (_ : Extension_instance.t) ~args =
    let (_ : unit Promise.t) =
      let arg = List.hd_exn args in
      let tree_item = TreeItem.t_of_js arg in
      let dependency =
        tree_item |> TreeItem.id |> Stdlib.Option.get
        |> Treeview_switches.Dependency.of_string
      in
      match dependency with
      | Switch _ ->
        Promise.return
        @@ show_message `Warn "Cannot open documentation of a switch."
      | Dependency (pkg, _) -> (
        let open Promise.Syntax in
        let doc = Opam.Package.documentation pkg in
        match doc with
        | None -> Promise.return ()
        | Some doc ->
          let+ _ =
            Vscode.Commands.executeCommand ~command:"vscode.open"
              ~args:[ Vscode.Uri.parse doc () |> Vscode.Uri.t_to_js ]
          in
          () )
    in
    ()
  in
  command Extension_consts.Commands.open_documentation handler

let register extension instance { id; handler } =
  let callback = handler instance in
  let disposable = Commands.registerCommand ~command:id ~callback in
  ExtensionContext.subscribe extension ~disposable

let register_all_commands extension instance =
  List.iter ~f:(register extension instance) !commands
