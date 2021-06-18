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
      show_message `Error "%s"
      @@ Extension_consts.Command_errors.text_editor_must_be_active
           "Open Dune File"
           ~expl:
             "The command can look for a dune file in the same folder as the \
              open file."
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

let _jump_to_next_hole =
  let pick_next_hole current_pos srtd_hole_diags =
    (* we want to find such a range that starts after the current position *)
    List.find srtd_hole_diags ~f:(fun diag ->
        let range = Diagnostic.range diag in
        match Position.compare current_pos (Range.start range) with
        | Ordering.Less -> true
        | Greater -> false
        | Equal ->
          (* we don't want the same range that we're in now; we need the next
             one *)
          not (Range.contains range ~positionOrRange:(`Position current_pos)))
    |> (function
         (* if the current position is larger than all other ranges, we cycle
            back to first hole in the file *)
         | None -> List.hd srtd_hole_diags
         | Some _ as o -> o)
    |> Option.map ~f:Diagnostic.range
  in

  let jump_to_hole
      (pick_hole : Position.t -> Diagnostic.t list -> Range.t option)
      (_instance : Extension_instance.t) ~args:_ =
    (* this command is available (in the command palette) only when a file is
       open *)
    let hole_not_found_msg = "No typed hole was found in this file" in
    match Window.activeTextEditor () with
    | None ->
      Extension_consts.Command_errors.text_editor_must_be_active "Next Hole"
        ~expl:"The command looks for holes in an open file."
      |> show_message `Error "%s"
    | Some text_editor -> (
      let doc = TextEditor.document text_editor in
      let uri = TextDocument.uri doc in
      let all_diagnostics = Languages.getDiagnostics uri in
      let hole_diagnostics =
        List.filter all_diagnostics ~f:(fun diag ->
            match Diagnostic.code diag with
            | Some (`String s) -> String.equal s "hole"
            | Some (`Int _)
            | None ->
              false)
      in

      let hole_diagnostics_sorted =
        List.sort hole_diagnostics ~compare:(fun diag1 diag2 ->
            let range1 = Diagnostic.range diag1 in
            let range2 = Diagnostic.range diag2 in
            Range.compare range1 range2 |> Ordering.to_int)
      in

      let current_pos =
        let selection = TextEditor.selection text_editor in
        Selection.active selection
      in

      match pick_hole current_pos hole_diagnostics_sorted with
      | None -> show_message `Info "%s" hole_not_found_msg
      | Some range ->
        let new_selection =
          let anchor = Range.start range in
          let active = Range.end_ range in
          Selection.makePositions ~anchor ~active
        in
        TextEditor.set_selection text_editor new_selection;
        TextEditor.revealRange text_editor ~range
          ~revealType:TextEditorRevealType.InCenterIfOutsideViewport ())
  in

  let jump_to_next_hole =
    command Extension_consts.Commands.next_hole (jump_to_hole pick_next_hole)
  in

  jump_to_next_hole

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
