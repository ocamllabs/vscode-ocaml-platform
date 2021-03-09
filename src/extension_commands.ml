open Import

type command =
  { id : string
  ; handler : Extension_instance.t -> args:Ojs.t list -> unit
        (* [handler] is intended to be used partially applied; [handler
           extension_instance] is passed as a callback to
           [Commands.registerCommand] *)
  }

type text_editor_command =
  { id : string
  ; handler :
         Extension_instance.t
      -> textEditor:TextEditor.t
      -> edit:TextEditorEdit.t
      -> args:Ojs.t list
      -> unit
        (* [handler] is intended to be used partially applied; [handler
           extension_instance] is passed as a callback to
           [Commands.registerCommand] *)
  }

type t =
  | Command of command
  | Text_editor_command of text_editor_command

let commands = ref []

(** creates a new command and stores in a mutable [commands] list *)
let command id handler =
  let command = Command { id; handler } in
  commands := command :: !commands;
  command

let text_editor_command id handler =
  let command = Text_editor_command { id; handler } in
  commands := command :: !commands;
  command

let _select_sandbox =
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

let _restart_language_server =
  let handler (instance : Extension_instance.t) ~args:_ =
    let (_ : unit Promise.t) =
      Extension_instance.start_language_server instance
    in
    ()
  in
  command Extension_consts.Commands.restart_language_server handler

let _select_sandbox_and_open_terminal =
  let handler _instance ~args:_ =
    let (_ : unit option Promise.t) =
      let open Promise.Option.Syntax in
      let+ sandbox = Sandbox.select_sandbox () in
      Extension_instance.open_terminal sandbox
    in
    ()
  in
  command Extension_consts.Commands.select_sandbox_and_open_terminal handler

let _open_terminal =
  let handler (instance : Extension_instance.t) ~args:_ =
    Extension_instance.sandbox instance |> Extension_instance.open_terminal
  in
  command Extension_consts.Commands.open_terminal handler

let _switch_impl_intf =
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

let _open_current_dune_file =
  let handler (_instance : Extension_instance.t) ~args:_ =
    match Vscode.Window.activeTextEditor () with
    | None ->
      (* this command is available (in the command palette) only when a file is
         open *)
      show_message `Error
        "The command \"OCaml: Open Dune File\" should be run only with a file \
         open in the editor, so the command can look for a dune file in the \
         same folder as the open file."
    | Some text_editor ->
      let doc = TextEditor.document text_editor in
      let uri = TextDocument.uri doc in
      let dune_file_uri =
        let path = Uri.fsPath uri |> Path.of_string in
        let uri = Path.relative path "../dune" |> Path.to_string |> Uri.file in
        Uri.toString uri ()
      in
      let (_ : TextEditor.t Promise.t) =
        open_file_in_text_editor dune_file_uri
      in
      ()
  in
  command Extension_consts.Commands.open_current_dune_file handler

let register extension instance = function
  | Command { id; handler } ->
    let callback = handler instance in
    let disposable = Commands.registerCommand ~command:id ~callback in
    ExtensionContext.subscribe extension ~disposable
  | Text_editor_command { id; handler } ->
    let callback = handler instance in
    let disposable = Commands.registerTextEditorCommand ~command:id ~callback in
    ExtensionContext.subscribe extension ~disposable

let register_all_commands extension instance =
  List.iter ~f:(register extension instance) !commands

let register ~id handler =
  let (_ : t) = command id handler in
  ()

let register_text_editor ~id handler =
  let (_ : t) = text_editor_command id handler in
  ()
