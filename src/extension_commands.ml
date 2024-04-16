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
        let* () = Sandbox.save_to_settings new_sandbox in
        let* () = Extension_instance.update_ocaml_info instance in
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

let _stop_documentation_server =
  let handler instance ~args:_ =
    Extension_instance.stop_documentation_server instance
  in
  command Extension_consts.Commands.stop_documentation_server handler

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
          @@ show_message
               `Warn
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

let ( _open_ocamllsp_output_pane
    , _open_ocaml_platform_ext_pane
    , _open_ocaml_commands_pane ) =
  let handler output (_instance : Extension_instance.t) ~args:_ =
    let show_output (lazy output) = OutputChannel.show output () in
    show_output output
  in
  ( command
      Extension_consts.Commands.open_ocamllsp_output
      (handler Output.language_server_output_channel)
  , command
      Extension_consts.Commands.open_ocaml_platform_ext_output
      (handler Output.extension_output_channel)
  , command
      Extension_consts.Commands.open_ocaml_commands_output
      (handler Output.command_output_channel) )

let _set_dune_context =
  let handler (instance : Extension_instance.t) ~args:_ =
    let open Promise.Syntax in
    let select_context (choices : string list) =
      let current_context =
        Option.value
          ~default:"default"
          (Settings.get Settings.server_duneContext_setting)
      in
      let choices =
        let to_quick_pick current_context context =
          let create = QuickPickItem.create in
          let description =
            if String.equal current_context context then
              Some "Currently selected Dune context"
            else None
          in
          create ~label:context ?description ()
        in
        List.map
          ~f:(fun (context : string) ->
            let quick_pick = to_quick_pick current_context context in
            (quick_pick, context))
          choices
      in
      let options =
        let placeHolder =
          "Which Dune context would you like to use in the editor?"
        in
        QuickPickOptions.create ~canPickMany:false ~placeHolder ()
      in
      Window.showQuickPickItems ~choices ~options ()
    in
    let select_dune_context client =
      let* candidates =
        Custom_requests.send_request client Custom_requests.getDuneContexts ()
      in
      let* context = select_context candidates in
      match context with
      | None (* context selection cancelled *) -> Promise.return ()
      | Some new_context ->
        let* () =
          Settings.set Settings.server_duneContext_setting new_context
        in
        Extension_instance.start_language_server instance
    in
    match Extension_instance.lsp_client instance with
    | None -> show_message `Warn "ocamllsp is not running."
    | Some (client, ocaml_lsp) ->
      if Ocaml_lsp.can_handle_dune_contexts ocaml_lsp then
        let (_ : unit Promise.t) = select_dune_context client in
        ()
      else
        (* if ocamllsp doesn't have the capability, recommend updating
           ocamllsp*)
        show_message
          `Warn
          "The installed version of ocamllsp does not support setting the Dune \
           context. Consider updating ocamllsp."
  in
  command Extension_consts.Commands.select_dune_context handler

module Holes_commands : sig
  val _jump_to_prev_hole : t

  val _jump_to_next_hole : t
end = struct
  let hole_not_found_msg = "No typed hole was found in this file"

  (** Shows appropriate message for when the [ocaml-lsp] in use by the extension
      doesn't support jumping to holes. *)
  let ocaml_lsp_doesn't_support_holes instance ocaml_lsp =
    match
      Ocaml_lsp.is_version_up_to_date
        ocaml_lsp
        (Extension_instance.ocaml_version_exn instance)
    with
    | Ok () -> ()
    | Error (`Msg msg) ->
      show_message
        `Warn
        "The installed version of `ocamllsp` does not support typed holes. %s"
        msg

  let current_cursor_pos text_editor =
    let selection = TextEditor.selection text_editor in
    Selection.active selection

  let select_hole_range text_editor hole =
    let new_selection =
      let anchor = Range.start hole in
      let active = Range.end_ hole in
      Selection.makePositions ~anchor ~active
    in
    TextEditor.set_selection text_editor new_selection;
    TextEditor.revealRange
      text_editor
      ~range:hole
      ~revealType:TextEditorRevealType.InCenterIfOutsideViewport
      ()

  let jump_to_hole jump (instance : Extension_instance.t) ~args =
    (* this command is available (in the command palette) only when a file is
       open *)
    match Window.activeTextEditor () with
    | None ->
      Extension_consts.Command_errors.text_editor_must_be_active
        "Jump to Previous/Next Typed Hole"
        ~expl:"The command looks for holes in an open file."
      |> show_message `Error "%s"
    | Some text_editor -> (
      let open Promise.Syntax in
      match Extension_instance.lsp_client instance with
      | None -> show_message `Warn "ocamllsp is not running."
      | Some (_, ocaml_lsp)
        when not (Ocaml_lsp.can_handle_typed_holes ocaml_lsp) ->
        ocaml_lsp_doesn't_support_holes instance ocaml_lsp
      | Some (client, _ocaml_lsp) ->
        let doc = TextEditor.document text_editor in
        let uri = TextDocument.uri doc in
        let (_ : unit Promise.t) =
          let+ holes =
            Custom_requests.send_request client Custom_requests.typedHoles uri
          in
          jump
            ~cmd_args:args
            text_editor
            ~sorted_holes:(List.sort holes ~compare:Range.compare)
        in
        ())

  module Prev_hole = struct
    (** iterate through all hole ranges and pick the one that has start position
        after the current cursor position *)
    let pick_prev_hole current_pos ~sorted_non_empty_holes_list:holes =
      match holes with
      | [] -> assert false
      | [ r ] -> r
      | fst_range :: rest ->
        let start = Range.start fst_range in
        if
          Ordering.is_less (Position.compare current_pos start)
          || Range.contains fst_range ~positionOrRange:(`Position current_pos)
        then
          (* [holes] is sorted from ranges in the beginning of the file to the
             end; if the current position comes before or inside the first
             range, then pick the last hole in file *)
          List.last_exn rest
        else
          let rec find_prev_hole prev_range = function
            | [] -> prev_range
            | range :: rest -> (
              if Range.contains range ~positionOrRange:(`Position current_pos)
              then prev_range
              else
                let start = Range.start range in
                match Position.compare current_pos start with
                | Ordering.Less -> prev_range
                | Greater -> find_prev_hole range rest
                | Equal ->
                  (* assert false because we check whether the current pos is in
                     this range in the if-expr above *)
                  assert false)
          in
          find_prev_hole fst_range rest

    let jump ~cmd_args:_ text_editor ~sorted_holes =
      match sorted_holes with
      | [] -> show_message `Info "%s" hole_not_found_msg
      | sorted_non_empty_holes_list ->
        let current_pos = current_cursor_pos text_editor in
        let hole = pick_prev_hole current_pos ~sorted_non_empty_holes_list in
        select_hole_range text_editor hole
  end

  (** [Next_hole] has a separate module because this command takes arguments,
      while [Prev_hole] doesn't. *)
  module Next_hole = struct
    let pick_next_hole current_pos ~sorted_non_empty_holes_list:holes =
      (* we want to find such a range that starts after the current position *)
      match holes with
      | [] -> assert false
      | [ r ] -> r
      | default :: _ ->
        let next_hole =
          List.find holes ~f:(fun range ->
              match Position.compare current_pos (Range.start range) with
              | Ordering.Less -> true
              | Greater -> false
              | Equal ->
                (* we don't want the same range that we're in now; we need the
                   next one *)
                not
                  (Range.contains
                     range
                     ~positionOrRange:(`Position current_pos)))
        in
        (* if the current position is larger than all other ranges, we cycle
           back to first hole in the file *)
        Option.value next_hole ~default

    (** We need to be able to specify the position from which we want to look
        for the next typed hole. If the [inRange] field of the argument object
        is not set, then we use the current position in the active text editor;
        otherwise, we look for a hole only within [inRange].

        We reuse "jump to hole" commands in other contexts (e.g., jump to next
        hole in the destructed code), so we add an argument where if there is no
        hole to jump to, user doesn't get notified because they didn't request
        this jump themselves.

        Note that we put all the configuration values in an object that is
        passed as the {i first} argument to the command because we want explicit
        names for those configurations, so object keys are useful here. *)
    type arguments =
      { in_range : Range.t option  (** [inRange]: <Range> (optional) *)
      ; should_notify_if_no_hole : bool
            (** [shouldNotifyIfNoHole]: <bool> (default = true) *)
      }

    let default_args = { in_range = None; should_notify_if_no_hole = true }

    let args_use_old_protocol json =
      Option.is_some
        (Jsonoo.Decode.(try_optional (field "position" Range.t_of_json)) json)
      || Option.is_some
           (Jsonoo.Decode.(try_optional (field "notify-if-no-hole" bool)) json)

    let parse_arguments args =
      match args with
      | [] -> Ok default_args
      | [ params_obj ] ->
        let json = Jsonoo.t_of_js params_obj in
        if args_use_old_protocol json then Error `Outdated_protocol
        else
          let in_range =
            Jsonoo.Decode.(try_optional (field "inRange" Range.t_of_json)) json
          in
          let should_notify_if_no_hole =
            Jsonoo.Decode.(try_default true (field "shouldNotifyIfNoHole" bool))
              json
          in
          Ok { in_range; should_notify_if_no_hole }
      | _ -> (* incorrect args passed *) assert false

    let jump ~cmd_args text_editor ~sorted_holes =
      match parse_arguments cmd_args with
      | Error `Outdated_protocol -> ()
      | Ok { in_range; should_notify_if_no_hole } -> (
        match sorted_holes with
        | [] ->
          if should_notify_if_no_hole then
            show_message `Info "%s" hole_not_found_msg
        | sorted_non_empty_holes_list -> (
          let start_pos =
            Option.map in_range ~f:Range.start
            |> Option.value_lazy ~default:(fun () ->
                   current_cursor_pos text_editor)
          in
          let hole = pick_next_hole start_pos ~sorted_non_empty_holes_list in
          match in_range with
          | None -> select_hole_range text_editor hole
          | Some in_range ->
            if Range.contains in_range ~positionOrRange:(`Range hole) then
              select_hole_range text_editor hole))
  end

  let _jump_to_next_hole =
    command Extension_consts.Commands.next_hole (jump_to_hole Next_hole.jump)

  let _jump_to_prev_hole =
    command Extension_consts.Commands.prev_hole (jump_to_hole Prev_hole.jump)
end

module Debug_commands : sig
  val _goto_closure_code_location : t

  val _start_debugging : t
end = struct
  let _start_debugging =
    let handler (_ : Extension_instance.t) ~args =
      let resourceUri =
        match args with
        | resourceUri :: _ -> Some (Uri.t_of_js resourceUri)
        | [] ->
          Option.map (Window.activeTextEditor ()) ~f:(fun textEditor ->
              TextDocument.uri (TextEditor.document textEditor))
      in
      match resourceUri with
      | Some uri ->
        let folder = Workspace.getWorkspaceFolder ~uri in
        let fsPath = Uri.fsPath uri in
        let name = Path.basename (Path.of_string fsPath) ^ " (experimental)" in
        let config =
          DebugConfiguration.create
            ~name
            ~type_:Extension_consts.Debuggers.earlybird
            ~request:"launch"
        in
        DebugConfiguration.set config "program" (Ojs.string_to_js fsPath);
        DebugConfiguration.set config "stopOnEntry" (Ojs.bool_to_js true);
        let (_ : bool Promise.t) =
          Debug.startDebugging
            ~folder
            ~nameOrConfiguration:(`Configuration config)
            ()
        in
        ()
      | None ->
        let _ = Window.showErrorMessage ~message:"No active resource" () in
        ()
    in
    command Extension_consts.Commands.start_debugging handler

  let _goto_closure_code_location =
    let handler (_ : Extension_instance.t) ~args =
      let open Promise.Syntax in
      match Debug.activeDebugSession () with
      | Some debugSession ->
        let context = List.hd_exn args in
        let variablesReference =
          Jsonoo.Decode.(
            at [ "variable"; "variablesReference" ] int (Jsonoo.t_of_js context))
        in
        let args =
          Earlybird.VariableGetClosureCodeLocation.Args.t_to_js
            { handle = variablesReference }
        in
        let (_ : unit Promise.t) =
          let* result =
            DebugSession.customRequest
              debugSession
              ~command:Earlybird.VariableGetClosureCodeLocation.command
              ~args
              ()
          in
          let result =
            Earlybird.VariableGetClosureCodeLocation.Result.t_of_js result
          in
          match result.location with
          | Some range ->
            let* text_document =
              Workspace.openTextDocument (`Filename range.source)
            in
            let selection =
              Earlybird.VariableGetClosureCodeLocation.Result.range_to_vscode
                range
            in
            let+ _ =
              Window.showTextDocument'
                ~document:(`TextDocument text_document)
                ~options:
                  (TextDocumentShowOptions.create ~preview:true ~selection ())
                ()
            in
            ()
          | None ->
            let+ _ =
              Window.showInformationMessage
                ~message:"No closure code location"
                ()
            in
            ()
        in
        ()
      | None ->
        let _ = Window.showErrorMessage ~message:"No active debug session" () in
        ()
    in
    command Extension_consts.Commands.goto_closure_code_location handler
end

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
