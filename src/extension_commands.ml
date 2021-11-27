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

let ( _open_ocamllsp_output_pane
    , _open_ocaml_platform_ext_pane
    , _open_ocaml_commands_pane ) =
  let handler output (_instance : Extension_instance.t) ~args:_ =
    let show_output (lazy output) = OutputChannel.show output () in
    show_output output
  in
  ( command Extension_consts.Commands.open_ocamllsp_output
      (handler Output.language_server_output_channel)
  , command Extension_consts.Commands.open_ocaml_platform_ext_output
      (handler Output.extension_output_channel)
  , command Extension_consts.Commands.open_ocaml_commands_output
      (handler Output.command_output_channel) )

module Holes_commands : sig
  val _jump_to_prev_hole : t

  val _jump_to_next_hole : t
end = struct
  let hole_not_found_msg = "No typed hole was found in this file"

  let ocaml_lsp_doesn't_support_holes instance ocaml_lsp =
    let suggestion =
      match
        Ocaml_lsp.is_version_up_to_date ocaml_lsp
          (Extension_instance.ocaml_version_exn instance)
      with
      | Ok is_up_to_date ->
        if is_up_to_date then
          (* ocamllsp is "up-to-date", so user needs newer ocaml to get newer
             ocamllsp, which supports typed holes *)
          "The extension requires a newer version of `ocamllsp`, which needs a \
           new version of OCaml. Please, consider upgrading the OCaml version \
           used in this sandbox."
        else
          "Consider upgrading the package `ocaml-lsp-server`."
      | Error (`Msg m) ->
        sprintf "There is something wrong with your `ocamllsp`. Error: %s" m
    in
    show_message `Warn
      "The installed version of `ocamllsp` does not support typed holes. %s"
      suggestion

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
    TextEditor.revealRange text_editor ~range:hole
      ~revealType:TextEditorRevealType.InCenterIfOutsideViewport ()

  module Prev_hole = struct
    let pick_prev_hole current_pos ~sorted_non_empty_holes_list:holes =
      (* iterate through all hole ranges and pick the one that has start
         position after the current cursor position *)
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
              then
                prev_range
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

    let jump_to_hole (instance : Extension_instance.t) ~args:_ =
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
              Custom_requests.Typed_holes.send_request client ~for_doc:uri
            in
            match holes with
            | [] -> show_message `Info "%s" hole_not_found_msg
            | holes ->
              let current_pos = current_cursor_pos text_editor in
              let sorted_non_empty_holes_list =
                List.sort holes ~compare:Range.compare
              in
              let hole =
                pick_prev_hole current_pos ~sorted_non_empty_holes_list
              in
              select_hole_range text_editor hole
          in
          ())
  end

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
                  (Range.contains range ~positionOrRange:(`Position current_pos)))
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
      { in_range : Range.t option  (** [inRange]: <Range> *)
      ; should_notify_if_no_hole : bool
            (** [shouldNotifyIfNoHole]: <bool> (default = true) *)
      }

    let parse_arguments args =
      match args with
      | [] -> { in_range = None; should_notify_if_no_hole = true }
      | [ params_obj ] ->
        let json = Jsonoo.t_of_js params_obj in
        let in_range =
          Jsonoo.Decode.(try_optional (field "inRange" Range.t_of_json)) json
        in
        let should_notify_if_no_hole =
          Jsonoo.Decode.(try_default true (field "shouldNotifyIfNoHole" bool))
            json
        in
        { in_range; should_notify_if_no_hole }
      | _ ->
        failwith
          "Jump to Previous/Next Hole: incorrect params passed to the command"

    let jump_to_hole (instance : Extension_instance.t) ~args =
      (* this command is available (in the command palette) only when a file is
         open *)
      let hole_not_found_msg = "No typed hole was found in this file" in
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
              Custom_requests.Typed_holes.send_request client ~for_doc:uri
            in
            let { in_range; should_notify_if_no_hole } = parse_arguments args in
            match holes with
            | [] ->
              if should_notify_if_no_hole then
                show_message `Info "%s" hole_not_found_msg
            | holes -> (
              let start_pos =
                Option.map in_range ~f:Range.start
                |> Option.value_lazy ~default:(fun () ->
                       current_cursor_pos text_editor)
              in
              let sorted_non_empty_holes_list =
                List.sort holes ~compare:Range.compare
              in
              let hole =
                pick_next_hole start_pos ~sorted_non_empty_holes_list
              in
              match in_range with
              | None -> select_hole_range text_editor hole
              | Some in_range ->
                if Range.contains in_range ~positionOrRange:(`Range hole) then
                  select_hole_range text_editor hole)
          in
          ())
  end

  let _jump_to_next_hole =
    command Extension_consts.Commands.next_hole Next_hole.jump_to_hole

  let _jump_to_prev_hole =
    command Extension_consts.Commands.prev_hole Prev_hole.jump_to_hole
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
