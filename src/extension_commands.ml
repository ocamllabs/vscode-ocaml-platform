open Import

type t =
  | Command :
      { handle : ('a, 'b) Command_api.handle
      ; callback : Extension_instance.t -> 'a -> 'b
      }
      -> t
  | Text_editor_command :
      { handle : ('a, unit) Command_api.handle
      ; callback :
          Extension_instance.t
          -> textEditor:TextEditor.t
          -> edit:TextEditorEdit.t
          -> 'a
          -> unit
      }
      -> t

let commands = ref []

(** creates a new command and stores in a mutable [commands] list *)
let command handle callback =
  let command = Command { handle; callback } in
  commands := command :: !commands;
  command
;;

let text_editor_command handle callback =
  let command = Text_editor_command { handle; callback } in
  commands := command :: !commands;
  command
;;

let _select_sandbox =
  let callback (instance : Extension_instance.t) () =
    let open Promise.Syntax in
    let (_ : unit Promise.t) =
      let* sandbox = Sandbox.select_sandbox (Extension_instance.sandbox instance) in
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
  command Command_api.Internal.select_sandbox callback
;;

let _install_ocaml_lsp_server =
  let callback (instance : Extension_instance.t) () =
    let open Promise.Syntax in
    let (_ : unit Promise.t) =
      let sandbox = Extension_instance.sandbox instance in
      let* ocamllsp_present = Extension_instance.check_ocaml_lsp_available sandbox in
      match ocamllsp_present with
      | Ok () ->
        show_message `Info "OCaml-LSP server is already installed." |> Promise.return
      | Error _ ->
        let* () = Extension_instance.install_ocaml_lsp_server sandbox in
        show_message `Info "Installation of OCaml-LSP server completed successfully.";
        Extension_instance.start_language_server instance
    in
    ()
  in
  command Command_api.Internal.install_ocaml_lsp_server callback
;;

let _upgrade_ocaml_lsp_server =
  let callback (instance : Extension_instance.t) () =
    let open Promise.Syntax in
    let (_ : unit Promise.t) =
      let sandbox = Extension_instance.sandbox instance in
      match
        Ocaml_lsp.is_version_up_to_date
          (Extension_instance.ocaml_lsp instance |> Option.value_exn)
          (Extension_instance.ocaml_version_exn instance)
      with
      | Ok () -> Promise.return ()
      | Error (`Msg _error) ->
        let* _ = Extension_instance.upgrade_ocaml_lsp_server sandbox in
        let+ _ = Extension_instance.start_language_server instance in
        show_message `Info "OCaml-LSP server upgraded successfully"
    in
    ()
  in
  command Command_api.Internal.upgrade_ocaml_lsp_server callback
;;

let _install_dune_lsp_server =
  let callback (instance : Extension_instance.t) () =
    let open Promise.Syntax in
    let _ =
      let sandbox = Extension_instance.sandbox instance in
      match sandbox with
      | Dune dune ->
        let* is_dune_locked = Dune.is_project_locked dune in
        if is_dune_locked
        then
          let* dune_lsp_present = Dune.is_ocamllsp_present dune in
          if dune_lsp_present
          then
            show_message `Info "OCaml-LSP server is already installed." |> Promise.return
          else (
            let options =
              ProgressOptions.create
                ~location:(`ProgressLocation Notification)
                ~title:"Installing ocaml-lsp server using \"dune tools install ocamllsp\""
                ~cancellable:false
                ()
            in
            let task ~progress:_ ~token:_ =
              let+ result =
                (* We first check the version so that the process can exit, otherwise the progress indicator runs forever.*)
                Sandbox.get_command sandbox "ocamllsp" [] `Install
                |> Cmd.output ~cwd:(Dune.root dune)
              in
              match result with
              | Ok _ -> Ojs.null
              | Error err ->
                show_message `Error "An error occured while installing ocamllsp : %s" err;
                Ojs.null
            in
            let* _ = Vscode.Window.withProgress (module Ojs) ~options ~task in
            let+ _ = Extension_instance.start_language_server instance in
            ())
        else Extension_instance.suggest_to_run_dune_pkg_lock () |> Promise.return
      | _ ->
        show_message
          `Warn
          "install_dune_lsp: This command can only be executed in a Dune Package \
           Management sandbox.";
        log
          "install_dune_lsp: This command can only be executed in a Dune Package \
           Management sandbox.";
        Promise.return ()
    in
    ()
  in
  command Command_api.Internal.install_dune_lsp callback
;;

let _run_dune_pkg_lock =
  let callback (instance : Extension_instance.t) () =
    let open Promise.Syntax in
    let _ =
      match Extension_instance.sandbox instance with
      | Dune dune ->
        let options =
          ProgressOptions.create
            ~location:(`ProgressLocation Notification)
            ~title:"Running \"dune pkg lock\""
            ~cancellable:false
            ()
        in
        let task ~progress:_ ~token:_ =
          let+ result =
            Dune.exec_pkg ~cmd:"lock" dune |> Cmd.output ~cwd:(Dune.root dune)
          in
          match result with
          | Ok _ -> Ojs.null
          | Error err ->
            show_message `Error "An error occurred while running dune pkg lock: %s" err;
            Ojs.null
        in
        let+ _ = Vscode.Window.withProgress (module Ojs) ~options ~task in
        let _ = Extension_instance.start_language_server instance in
        ()
      | _ ->
        show_message
          `Warn
          "dune_pkg_lock: This command can only be executed in a Dune Package Management \
           sandbox.";
        log
          "run_dune_pkg_lock: This command can only be executed in a Dune Package \
           Management sandbox.";
        Promise.return ()
    in
    ()
  in
  command Command_api.Internal.run_dune_pkg_lock callback
;;

let _restart_language_server =
  let callback (instance : Extension_instance.t) () =
    let (_ : unit Promise.t) = Extension_instance.start_language_server instance in
    ()
  in
  command Command_api.Internal.restart_language_server callback
;;

let _select_sandbox_and_open_terminal =
  let callback (instance : Extension_instance.t) () =
    let (_ : unit option Promise.t) =
      let open Promise.Option.Syntax in
      let+ sandbox = Sandbox.select_sandbox (Extension_instance.sandbox instance) in
      Extension_instance.open_terminal sandbox
    in
    ()
  in
  command Command_api.Internal.select_sandbox_and_open_terminal callback
;;

let _open_terminal =
  let callback (instance : Extension_instance.t) () =
    Extension_instance.sandbox instance |> Extension_instance.open_terminal
  in
  command Command_api.Internal.open_terminal callback
;;

let _stop_documentation_server =
  let callback (instance : Extension_instance.t) () =
    Extension_instance.stop_documentation_server instance
  in
  command Command_api.Internal.stop_documentation_server callback
;;

let _switch_impl_intf =
  let callback (instance : Extension_instance.t) () =
    let try_switching () =
      let open Option.O in
      let+ editor = Window.activeTextEditor () in
      let document = TextEditor.document editor in
      match Extension_instance.lsp_client instance with
      | None -> Promise.return (show_message `Warn "ocamllsp is not running.")
      | Some (client, ocaml_lsp) ->
        (* same as for instance.client; ignore the try if it's None *)
        if
          Ocaml_lsp.can_handle_switch_impl_intf ocaml_lsp
          && Ocaml_lsp.can_handle_infer_intf ocaml_lsp
        then Switch_impl_intf.request_switch client document
        else
          (* if, however, ocamllsp doesn't have the capability, recommend
             updating ocamllsp*)
          Promise.return
          @@ show_message
               `Warn
               "The installed version of ocamllsp does not support switching between \
                implementation and interface files. Consider updating ocamllsp."
    in
    let (_ : unit Promise.t option) = try_switching () in
    ()
  in
  command Command_api.Internal.switch_impl_intf callback
;;

let walkthrough_terminal_instance = ref None

let walkthrough_terminal instance =
  match !walkthrough_terminal_instance with
  | Some t -> t
  | None ->
    let t =
      Terminal_sandbox.create
        ~name:"OCaml Platform Walkthrough"
        (Extension_instance.sandbox instance)
    in
    walkthrough_terminal_instance := Some t;
    t
;;

let _install_opam =
  let outdated_opam = ref false in
  let callback (instance : Extension_instance.t) () =
    let process_installation () =
      let open Promise.Syntax in
      let* opam = Opam.make () in
      match opam, !outdated_opam with
      | None, true | Some _, true | None, false ->
        let options =
          ProgressOptions.create
            ~location:(`ProgressLocation Notification)
            ~title:"Installing opam package manager"
            ~cancellable:false
            ()
        in
        let task ~progress:_ ~token:_ =
          let+ result =
            match Platform.t with
            | Win32 ->
              let _ =
                let terminal =
                  Extension_instance.sandbox instance |> Terminal_sandbox.create
                in
                let _ = Terminal_sandbox.show ~preserveFocus:true terminal in
                Terminal_sandbox.send terminal "winget install Git.Git OCaml.opam"
              in
              Ok () |> Promise.return
            | Darwin | Linux | Other ->
              let open Promise.Result.Syntax in
              let+ _ =
                let _ =
                  let terminal = walkthrough_terminal instance in
                  let _ = Terminal_sandbox.show ~preserveFocus:true terminal in
                  Terminal_sandbox.send
                    terminal
                    "bash -c \"sh <(curl -fsSL https://opam.ocaml.org/install.sh)\""
                in
                Ok () |> Promise.return
              in
              ()
          in
          match result with
          | Ok () -> Ojs.null
          | Error err ->
            show_message `Error "An error occured while installing opam %s" err;
            Ojs.null
        in
        let+ _ = Vscode.Window.withProgress (module Ojs) ~options ~task in
        ()
      | Some opam, _ ->
        let* latest_version =
          Cmd.output
            ?cwd:(Sandbox.workspace_root ())
            (Cmd.Shell
               "curl -s -H \"Accept: application/vnd.github+json\" \
                https://api.github.com/repos/ocaml/opam/releases/latest | jq -r \
                '.tag_name'")
        in
        let cwd = Sandbox.workspace_root () in
        let+ installed_version = Cmd.output ?cwd (Opam.version opam) in
        let comb =
          Result.combine
            latest_version
            installed_version
            ~ok:(fun lv iv ->
              String.compare lv iv
              |> Int.is_positive
              |> fun is_outdated -> is_outdated, lv, iv)
            ~err:(fun e1 e2 -> e1 ^ ", " ^ e2)
        in
        (match comb with
         | Ok (false, _latest_version, installed_version) ->
           show_message
             `Info
             "opam is already installed and up to date (version %s)."
             installed_version
         | Ok (true, latest_version, installed_version) ->
           outdated_opam := true;
           let _ =
             let+ selection =
               Window.showInformationMessage
                 ~message:
                   (Printf.sprintf
                      "opam is already installed (version %s). A newer version (%s) is \
                       available."
                      installed_version
                      latest_version)
                 ~choices:[ "Update opam", () ]
                 ()
             in
             Option.iter selection ~f:(fun () ->
               let (_ : unit Promise.t) =
                 Command_api.(execute Internal.install_opam) ()
               in
               ())
           in
           ()
         | Error err -> show_message `Warn "Could not determine opam version: %s" err)
    in
    let (_ : unit Promise.t) = process_installation () in
    ()
  in
  command Command_api.Internal.install_opam callback
;;

let _init_opam =
  let callback (instance : Extension_instance.t) () =
    let options =
      ProgressOptions.create
        ~location:(`ProgressLocation Notification)
        ~title:"Initialising opam"
        ~cancellable:false
        ()
    in
    let task ~progress:_ ~token:_ =
      let open Promise.Syntax in
      let+ result =
        let open Promise.Result.Syntax in
        let+ _ =
          let _ =
            let terminal = walkthrough_terminal instance in
            let _ = Terminal_sandbox.show ~preserveFocus:true terminal in
            Terminal_sandbox.send terminal "opam init"
          in
          Ok () |> Promise.return
        in
        ()
      in
      match result with
      | Ok () -> Ojs.null
      | Error err ->
        show_message `Error "An error occured while initializing opam %s" err;
        Ojs.null
    in
    let _ = Vscode.Window.withProgress (module Ojs) ~options ~task in
    ()
  in
  command Command_api.Internal.init_opam callback
;;

let _install_ocaml_dev =
  let callback (instance : Extension_instance.t) () =
    let options =
      ProgressOptions.create
        ~location:(`ProgressLocation Notification)
        ~title:"Installing development packages"
        ~cancellable:false
        ()
    in
    let task ~progress:_ ~token:_ =
      let open Promise.Syntax in
      let+ result =
        let open Promise.Result.Syntax in
        let+ _ =
          let _ =
            let terminal = walkthrough_terminal instance in
            let _ = Terminal_sandbox.show ~preserveFocus:true terminal in
            Terminal_sandbox.send
              terminal
              "opam install ocaml-lsp-server odoc ocamlformat utop"
          in
          Ok () |> Promise.return
        in
        ()
      in
      match result with
      | Ok () -> Ojs.null
      | Error err ->
        show_message `Error "An error occured while installing packages %s" err;
        Ojs.null
    in
    let _ = Vscode.Window.withProgress (module Ojs) ~options ~task in
    ()
  in
  command Command_api.Internal.install_ocaml_dev callback
;;

let _open_utop =
  let callback (instance : Extension_instance.t) () =
    let options =
      ProgressOptions.create
        ~location:(`ProgressLocation Notification)
        ~title:"Launching utop"
        ~cancellable:false
        ()
    in
    let task ~progress:_ ~token:_ =
      let open Promise.Syntax in
      let+ result =
        let open Promise.Result.Syntax in
        let+ _ =
          let _ =
            let terminal = walkthrough_terminal instance in
            let _ = Terminal_sandbox.show ~preserveFocus:true terminal in
            Terminal_sandbox.send terminal "opam exec -- utop"
          in
          Ok () |> Promise.return
        in
        ()
      in
      match result with
      | Ok () -> Ojs.null
      | Error err ->
        show_message `Error "An error occured while opening utop %s" err;
        Ojs.null
    in
    let _ = Vscode.Window.withProgress (module Ojs) ~options ~task in
    ()
  in
  command Command_api.Internal.open_utop callback
;;

let _open_current_dune_file =
  let callback (_ : Extension_instance.t) () =
    match Vscode.Window.activeTextEditor () with
    | None ->
      (* this command is available (in the command palette) only when a file is
         open *)
      show_message `Error "%s"
      @@ Command_api.Command_errors.text_editor_must_be_active
           "Open Dune File"
           ~expl:
             "The command can look for a dune file in the same folder as the open file."
    | Some text_editor ->
      let doc = TextEditor.document text_editor in
      let uri = TextDocument.uri doc in
      let dune_file_uri =
        let path = Uri.fsPath uri |> Path.of_string in
        let uri = Path.relative path "../dune" |> Path.to_string |> Uri.file in
        Uri.toString uri ()
      in
      let (_ : TextEditor.t Promise.t) = open_file_in_text_editor dune_file_uri in
      ()
  in
  command Command_api.Internal.open_current_dune_file callback
;;

let _open_ocamllsp_output_pane, _open_ocaml_platform_ext_pane, _open_ocaml_commands_pane =
  let callback output (_ : Extension_instance.t) () =
    let show_output (lazy output) = OutputChannel.show output () in
    show_output output
  in
  ( command
      Command_api.Internal.open_ocamllsp_output
      (callback Output.language_server_output_channel)
  , command
      Command_api.Internal.open_ocaml_platform_ext_output
      (callback Output.extension_output_channel)
  , command
      Command_api.Internal.open_ocaml_commands_output
      (callback Output.command_output_channel) )
;;

let select_and_reveal selection text_editor =
  TextEditor.set_selection text_editor selection;
  TextEditor.revealRange
    text_editor
    ~range:(Selection.to_range selection)
    ~revealType:TextEditorRevealType.InCenterIfOutsideViewport
    ()
;;

module Decorations = struct
  let highlighting_decoration =
    let options =
      DecorationRenderOptions.create
        ~backgroundColor:
          (`ThemeColor (ThemeColor.make ~id:"editorHoverWidget.foreground"))
        ~color:(`ThemeColor (ThemeColor.make ~id:"editorHoverWidget.background"))
        ~border:"1px solid"
        ~borderColor:(`ThemeColor (ThemeColor.make ~id:"editorHoverWidget.border"))
        ~isWholeLine:false
        ()
    in
    Window.createTextEditorDecorationType ~options
  ;;

  let highlight_range text_editor range =
    let _decorationOptions =
      let renderOptions =
        let before = ThemableDecorationAttachmentRenderOptions.create () in
        let options = ThemableDecorationInstanceRenderOptions.create ~before () in
        Some (DecorationInstanceRenderOptions.create ~light:options ~dark:options ())
      in
      DecorationOptions.create ~range ~renderOptions ()
    in
    TextEditor.setDecorations
      text_editor
      ~decorationType:highlighting_decoration
      ~rangesOrOptions:(`Ranges [ range ])
  ;;

  let highlight_and_reveal_range text_editor range =
    highlight_range text_editor range;
    TextEditor.revealRange
      text_editor
      ~range
      ~revealType:TextEditorRevealType.InCenterIfOutsideViewport
      ()
  ;;

  let remove_all_highlights text_editor =
    let rangesOrOptions = `Ranges [] in
    TextEditor.setDecorations
      text_editor
      ~decorationType:highlighting_decoration
      ~rangesOrOptions
  ;;
end

let watch_selection_change event_fired =
  let onDidChangeTextEditorSelection_listener _event = event_fired := true in
  let listener = onDidChangeTextEditorSelection_listener in
  Window.onDidChangeTextEditorSelection () ~listener ()
;;

module Holes_commands : sig
  val _jump_to_prev_hole : t
  val _jump_to_next_hole : t

  val closest_hole
    :  Position.t
    -> TextEditor.t
    -> LanguageClient.t
    -> [< `Next | `Prev ]
    -> Range.t option Promise.t
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
        "The installed version of \"ocamllsp\" does not support typed holes. %s"
        msg
  ;;

  let current_cursor_pos text_editor =
    let selection = TextEditor.selection text_editor in
    Selection.active selection
  ;;

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
  ;;

  let send_request_to_lsp client text_editor =
    let doc = TextEditor.document text_editor in
    let uri = TextDocument.uri doc in
    Custom_requests.send_request client Custom_requests.typedHoles uri
  ;;

  let jump_to_hole jump (instance : Extension_instance.t) args =
    (* this command is available (in the command palette) only when a file is
       open *)
    match Window.activeTextEditor () with
    | None ->
      Command_api.Command_errors.text_editor_must_be_active
        "Jump to Previous/Next Typed Hole"
        ~expl:"The command looks for holes in an open file."
      |> show_message `Error "%s"
    | Some text_editor ->
      let open Promise.Syntax in
      (match Extension_instance.lsp_client instance with
       | None -> show_message `Warn "ocamllsp is not running."
       | Some (_, ocaml_lsp) when not (Ocaml_lsp.can_handle_typed_holes ocaml_lsp) ->
         ocaml_lsp_doesn't_support_holes instance ocaml_lsp
       | Some (client, _ocaml_lsp) ->
         let (_ : unit Promise.t) =
           let+ holes = send_request_to_lsp client text_editor in
           jump
             ~cmd_args:args
             text_editor
             ~sorted_holes:(List.sort holes ~compare:Range.compare)
         in
         ())
  ;;

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
        else (
          let rec find_prev_hole prev_range = function
            | [] -> prev_range
            | range :: rest ->
              if Range.contains range ~positionOrRange:(`Position current_pos)
              then prev_range
              else (
                let start = Range.start range in
                match Position.compare current_pos start with
                | Ordering.Less -> prev_range
                | Greater -> find_prev_hole range rest
                | Equal ->
                  (* assert false because we check whether the current pos is in
                     this range in the if-expr above *)
                  assert false)
          in
          find_prev_hole fst_range rest)
    ;;

    let jump ~cmd_args:() text_editor ~sorted_holes =
      match sorted_holes with
      | [] -> show_message `Info "%s" hole_not_found_msg
      | sorted_non_empty_holes_list ->
        let current_pos = current_cursor_pos text_editor in
        let hole = pick_prev_hole current_pos ~sorted_non_empty_holes_list in
        select_hole_range text_editor hole
    ;;
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
              not (Range.contains range ~positionOrRange:(`Position current_pos)))
        in
        (* if the current position is larger than all other ranges, we cycle
           back to first hole in the file *)
        Option.value next_hole ~default
    ;;

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
      { in_range : Range.t option (** [inRange]: <Range> (optional) *)
      ; should_notify_if_no_hole : bool
        (** [shouldNotifyIfNoHole]: <bool> (default = true) *)
      }

    let default_args = { in_range = None; should_notify_if_no_hole = true }

    let args_use_old_protocol json =
      Option.is_some
        (Jsonoo.Decode.(try_optional (field "position" Range.t_of_json)) json)
      || Option.is_some
           (Jsonoo.Decode.(try_optional (field "notify-if-no-hole" bool)) json)
    ;;

    let parse_arguments args =
      match args with
      | None -> Ok default_args
      | Some json ->
        if args_use_old_protocol json
        then Error `Outdated_protocol
        else (
          let in_range =
            Jsonoo.Decode.(try_optional (field "inRange" Range.t_of_json)) json
          in
          let should_notify_if_no_hole =
            Jsonoo.Decode.(try_default true (field "shouldNotifyIfNoHole" bool)) json
          in
          Ok { in_range; should_notify_if_no_hole })
    ;;

    let jump ~cmd_args text_editor ~sorted_holes =
      match parse_arguments cmd_args with
      | Error `Outdated_protocol -> ()
      | Ok { in_range; should_notify_if_no_hole } ->
        (match sorted_holes with
         | [] ->
           if should_notify_if_no_hole then show_message `Info "%s" hole_not_found_msg
         | sorted_non_empty_holes_list ->
           let start_pos =
             Option.map in_range ~f:Range.start
             |> Option.value_lazy ~default:(fun () -> current_cursor_pos text_editor)
           in
           let hole = pick_next_hole start_pos ~sorted_non_empty_holes_list in
           (match in_range with
            | None -> select_hole_range text_editor hole
            | Some in_range ->
              if Range.contains in_range ~positionOrRange:(`Range hole)
              then select_hole_range text_editor hole))
    ;;
  end

  let closest_hole position text_editor client direction =
    (* We aren't checking if there's the capability to handle typed holes *)
    let open Promise.Syntax in
    let+ holes = send_request_to_lsp client text_editor in
    let sorted_holes = List.sort holes ~compare:Range.compare in
    match sorted_holes with
    | [] -> None
    | holes ->
      Some
        (match direction with
         | `Prev -> Prev_hole.pick_prev_hole position ~sorted_non_empty_holes_list:holes
         | `Next -> Next_hole.pick_next_hole position ~sorted_non_empty_holes_list:holes)
  ;;

  let _jump_to_next_hole =
    command Command_api.Internal.next_hole (jump_to_hole Next_hole.jump)
  ;;

  let _jump_to_prev_hole =
    command Command_api.Internal.prev_hole (jump_to_hole Prev_hole.jump)
  ;;
end

module Copy_type_under_cursor = struct
  let extension_name = "Copy Type Under Cursor"

  let ocaml_lsp_doesnt_support_type_selection instance ocaml_lsp =
    match
      Ocaml_lsp.is_version_up_to_date
        ocaml_lsp
        (Extension_instance.ocaml_version_exn instance)
    with
    | Ok () -> ()
    | Error (`Msg msg) ->
      show_message
        `Warn
        "The installed version of \"ocamllsp\" does not support type enclosings. %s"
        msg
  ;;

  let get_enclosings text_editor client =
    let doc = TextEditor.document text_editor in
    let uri = TextDocument.uri doc in
    let selection = TextEditor.selection text_editor in
    Custom_requests.(
      send_request
        client
        Type_selection.request
        (Type_selection.make
           ~uri
           ~at:(`Range (Selection.to_range selection))
           ~index:0
           ~verbosity:0))
  ;;

  let _copy_type_under_cursor =
    let callback (instance : Extension_instance.t) () =
      let copy_type_under_cursor () =
        match Window.activeTextEditor () with
        | None ->
          Command_api.Command_errors.text_editor_must_be_active
            extension_name
            ~expl:"The command copy the type of the expression under cursor"
          |> show_message `Error "%s"
          |> Promise.return
        | Some text_editor ->
          (match Extension_instance.lsp_client instance with
           | None -> show_message `Warn "ocamllsp is not running" |> Promise.return
           | Some (_, ocaml_lsp) when not (Ocaml_lsp.can_handle_type_selection ocaml_lsp)
             ->
             ocaml_lsp_doesnt_support_type_selection instance ocaml_lsp |> Promise.return
           | Some (client, _) ->
             let clipboard = Env.clipboard () in
             let open Promise.Syntax in
             let* Custom_requests.Type_selection.{ type_; _ } =
               get_enclosings text_editor client
             in
             if String.equal type_ "<no information>"
             then show_message `Warn "No type information" |> Promise.return
             else
               let+ () = Clipboard.writeText clipboard type_ in
               show_message `Info "Type copied: %s" type_)
      in
      let (_ : unit Promise.t) = copy_type_under_cursor () in
      ()
    in
    command Command_api.Internal.copy_type_under_cursor callback
  ;;
end

module Construct = struct
  let extension_name = "Construct"

  let is_valid_text_doc textdoc =
    match TextDocument.languageId textdoc with
    | "ocaml" | "ocaml.interface" | "reason" | "ocaml.ocamllex" -> true
    | _ -> false
  ;;

  let ocaml_lsp_doesnt_support_construct ocaml_lsp =
    not (Ocaml_lsp.can_handle_construct ocaml_lsp)
  ;;

  let get_construct_results position text_editor client =
    let doc = TextEditor.document text_editor in
    let uri = TextDocument.uri doc in
    Custom_requests.(
      send_request
        client
        Construct.request
        (Construct.make ~uri ~position ~depth:None ~with_values:None ()))
  ;;

  let display_results (results : Custom_requests.Construct.response) =
    let quickPickItems =
      List.map results.result ~f:(fun res ->
        QuickPickItem.create ~label:res (), (res, results.position))
    in
    let quickPickOptions = QuickPickOptions.create ~title:"Construct results" () in
    Window.showQuickPickItems ~choices:quickPickItems ~options:quickPickOptions ()
  ;;

  let insert_to_document text_editor range value =
    TextEditor.edit
      text_editor
      ~callback:(fun ~editBuilder ->
        Vscode.TextEditorEdit.replace editBuilder ~location:(`Range range) ~value)
      ()
  ;;

  let rec process_construct position text_editor client instance =
    let open Promise.Syntax in
    let* res = get_construct_results position text_editor client in
    match res.result with
    | [] -> show_message `Info "No values to construct this typed hole." |> Promise.return
    | _result_list ->
      let* selected_result = display_results res in
      (match selected_result with
       | Some (value, range) ->
         let* value_inserted = insert_to_document text_editor range value in
         (match Settings.(get server_constructRecursiveCalls_setting) with
          | Some true | None ->
            (match value_inserted with
             | true ->
               let* new_range =
                 Holes_commands.closest_hole (Range.start range) text_editor client `Next
               in
               (match new_range with
                | Some range ->
                  process_construct (Range.end_ range) text_editor client instance
                | None -> Promise.return ())
             | false -> Promise.return ())
          | Some false -> Promise.return ())
       | None -> Promise.return ())
  ;;

  let _construct =
    let callback (instance : Extension_instance.t) () =
      let construct () =
        match Window.activeTextEditor () with
        | None ->
          Command_api.Command_errors.text_editor_must_be_active
            extension_name
            ~expl:
              "The cursor position is used to determine the correct environment and \
               insert the result."
          |> show_message `Error "%s"
        | Some text_editor when not (is_valid_text_doc (TextEditor.document text_editor))
          ->
          show_message
            `Error
            "Invalid file type. This command only works in ocaml files, ocaml interface \
             files, reason files or ocamllex files."
        | Some text_editor ->
          (match Extension_instance.lsp_client instance with
           | None -> show_message `Warn "ocamllsp is not running"
           | Some (_client, ocaml_lsp) when ocaml_lsp_doesnt_support_construct ocaml_lsp
             ->
             show_message
               `Warn
               "The installed version of `ocamllsp` does not support construct custom \
                requests"
           | Some (client, _) ->
             let position = TextEditor.selection text_editor |> Selection.active in
             let _ = process_construct position text_editor client instance in
             ())
      in
      let (_ : unit) = construct () in
      ()
    in
    command Command_api.Internal.construct callback
  ;;
end

module MerlinJump = struct
  let extension_name = "MerlinJump"

  let is_valid_text_doc textdoc =
    match TextDocument.languageId textdoc with
    | "ocaml" | "ocaml.interface" | "reason" | "ocaml.ocamllex" -> true
    | _ -> false
  ;;

  let ocaml_lsp_doesnt_support_merlin_jump ocaml_lsp =
    not (Ocaml_lsp.can_handle_merlin_jump ocaml_lsp)
  ;;

  let request_possible_targets position text_editor client =
    let doc = TextEditor.document text_editor in
    let uri = TextDocument.uri doc in
    Custom_requests.(
      send_request client Merlin_jump.request (Merlin_jump.make ~uri ~position))
  ;;

  module JumpQuickPickItem = struct
    type t =
      { item : QuickPickItem.t
      ; position : Position.t
      }

    let t_of_js js =
      let position = [%js.to: Position.t] (Ojs.get_prop_ascii js "position") in
      let item = [%js.to: QuickPickItem.t] js in
      { item; position }
    ;;

    let t_to_js t =
      let item = [%js.of: QuickPickItem.t] t.item in
      Ojs.set_prop_ascii item "position" @@ [%js.of: Position.t] t.position;
      item
    ;;
  end

  module QuickPick = Vscode.QuickPick.Make (JumpQuickPickItem)

  let display_results (results : Custom_requests.Merlin_jump.response) text_editor =
    let selected_item = ref false in
    let quickPickItems =
      List.map results ~f:(fun (target, position) ->
        let item = (QuickPickItem.create ~label:("Jump to nearest " ^ target)) () in
        { JumpQuickPickItem.item; position })
    in
    let quickPick =
      QuickPick.set
        (Window.createQuickPick (module JumpQuickPickItem) ())
        ~title:"Available Jump Targets"
        ~activeItems:[]
        ~busy:false
        ~enabled:true
        ~placeholder:"Use arrow keys to preview / Select to jump"
        ~selectedItems:[]
        ~ignoreFocusOut:false
        ~items:quickPickItems
        ~matchOnDescription:true
        ~buttons:[]
        ()
    in
    let _disposable =
      QuickPick.onDidChangeActive
        quickPick
        ~listener:(function
          | { position; _ } :: _ ->
            let range =
              Range.makePositions
                ~start:position
                ~end_:
                  (Position.make
                     ~character:(Position.character position + 1)
                     ~line:(Position.line position))
            in
            let text_document = TextEditor.document text_editor in
            let range =
              Option.value
                (TextDocument.getWordRangeAtPosition
                   text_document
                   ~regex:
                     (Js_of_ocaml.Regexp.regexp
                        "\\(?\\b(let|fun|match|module|module\\s*type|\\w+)(?=\\s*(?:->|\\s|\\)|$))")
                   ~position:(Range.start range)
                   ())
                ~default:range
            in
            (match
               String.is_prefix ~prefix:"(" (TextDocument.getText text_document ~range ())
             with
             | false -> Decorations.highlight_and_reveal_range text_editor range
             | true ->
               let start_position = Range.start range in
               let new_start_position =
                 Position.make
                   ~line:(Position.line start_position)
                   ~character:(Position.character start_position + 1)
               in
               let range =
                 Range.makePositions ~start:new_start_position ~end_:(Range.end_ range)
               in
               Decorations.highlight_and_reveal_range text_editor range)
          | _ -> ())
        ()
    in
    let _disposable =
      QuickPick.onDidAccept
        quickPick
        ~listener:(fun () ->
          match QuickPick.selectedItems quickPick with
          | Some (item :: _) ->
            ignore
              (let open Promise.Syntax in
               selected_item := true;
               let+ _ =
                 Window.showTextDocument
                   ~document:(TextEditor.document text_editor)
                   ~preserveFocus:true
                   ()
               in
               let selection =
                 Selection.makePositions ~anchor:item.position ~active:item.position
               in
               select_and_reveal selection text_editor)
          | _ -> ())
        ()
    in
    let _disposable =
      let initial_selection = TextEditor.selection text_editor in
      (* We watch selection change events so that we don't jump back to the
         original position if an external command or user action was performed. *)
      let selection_changed = ref false in
      let selection_listener_disposable = watch_selection_change selection_changed in
      QuickPick.onDidHide
        quickPick
        ~listener:(fun () ->
          if not (!selection_changed || !selected_item)
          then select_and_reveal initial_selection text_editor;
          Decorations.remove_all_highlights text_editor;
          Disposable.dispose selection_listener_disposable;
          QuickPick.dispose quickPick)
        ()
    in
    QuickPick.show quickPick
  ;;

  let process_jump position text_editor client =
    let open Promise.Syntax in
    let+ successful_targets = request_possible_targets position text_editor client in
    match successful_targets with
    | [] -> show_message `Info "No available targets to jump to"
    | results -> display_results results text_editor
  ;;

  let _jump =
    let callback (instance : Extension_instance.t) () =
      let jump () =
        match Window.activeTextEditor () with
        | None ->
          Command_api.Command_errors.text_editor_must_be_active
            extension_name
            ~expl:
              "The cursor position is used to determine the correct environment for the \
               jump."
          |> show_message `Error "%s"
        | Some text_editor when not (is_valid_text_doc (TextEditor.document text_editor))
          ->
          show_message
            `Error
            "Invalid file type. This command only works in ocaml files, ocaml interface \
             files or reason files."
        | Some text_editor ->
          (match Extension_instance.lsp_client instance with
           | None -> show_message `Warn "ocamllsp is not running"
           | Some (_client, ocaml_lsp) when ocaml_lsp_doesnt_support_merlin_jump ocaml_lsp
             ->
             show_message
               `Warn
               "The installed version of `ocamllsp` does not support Merlin jump custom \
                requests"
           | Some (client, _) ->
             let position = TextEditor.selection text_editor |> Selection.active in
             let _ = process_jump position text_editor client in
             ())
      in
      let (_ : unit) = jump () in
      ()
    in
    command Command_api.Internal.merlin_jump callback
  ;;
end

module Search_by_type = struct
  let extension_name = "Search By Type"

  let is_valid_text_doc textdoc =
    match TextDocument.languageId textdoc with
    | "ocaml" | "ocaml.interface" | "reason" | "ocaml.ocamllex" -> true
    | _ -> false
  ;;

  let ocaml_lsp_doesnt_support_search_by_type ocaml_lsp =
    not (Ocaml_lsp.can_handle_search_by_type ocaml_lsp)
  ;;

  let get_search_results ~query ~limit ~with_doc ~position text_editor client =
    let doc = TextEditor.document text_editor in
    let uri = TextDocument.uri doc in
    Custom_requests.(
      send_request
        client
        Type_search.request
        (Type_search.make ~uri ~position ~limit ~query ~with_doc ()))
    |> Promise.catch ~rejected:(fun _ -> Promise.return [])
  ;;

  let input_box =
    (* Re-using the same instance of the input box allows us to remember the
       last input. *)
    let box =
      InputBox.set
        (Window.createInputBox ())
        ~title:"Search By Type"
        ~ignoreFocusOut:false
        ~placeholder:"int -> string / -int +string"
        ~prompt:
          "Perform a search by type request by providing a type signature to look for"
        ()
    in
    let _disposable =
      InputBox.onDidChangeValue
        box
        ~listener:(fun _ -> InputBox.set_validationMessage box None)
        ()
    in
    box
  ;;

  let rec display_search_results query results text_editor position client =
    let format_doc (doc : MarkupContent.t option) =
      match doc with
      | Some doc -> doc.value
      | None -> ""
    in
    let quickPickItems =
      List.map results ~f:(fun (res : Custom_requests.Type_search.type_search_result) ->
        QuickPickItem.create
          ~label:res.name
          ~description:res.typ
          ~detail:(format_doc res.doc)
          ())
    in
    let module QuickPick = Vscode.QuickPick.Make (QuickPickItem) in
    let quickPick =
      QuickPick.set
        (Window.createQuickPick (module QuickPickItem) ())
        ~title:"Type/Polarity Search Results"
        ~activeItems:[]
        ~busy:false
        ~enabled:true
        ~placeholder:"Select an item to insert it to the editor"
        ~selectedItems:[]
        ~ignoreFocusOut:false
        ~items:quickPickItems
        ~buttons:[ Window.quickInputButtonBack ]
        ()
    in
    let _disposable =
      QuickPick.onDidTriggerButton
        quickPick
        ~listener:(fun _ -> show_query_input text_editor client)
        ()
    in
    let _disposable =
      QuickPick.onDidAccept
        quickPick
        ~listener:(fun () ->
          match QuickPick.selectedItems quickPick with
          | Some (item :: _) ->
            let value = QuickPickItem.label item in
            let _ =
              Vscode.TextEditor.edit
                text_editor
                ~callback:(fun ~editBuilder ->
                  Vscode.TextEditorEdit.insert editBuilder ~location:position ~value)
                ()
            in
            QuickPick.hide quickPick
          | _ -> display_search_results query results text_editor position client)
        ()
    in
    let _disposable =
      QuickPick.onDidHide quickPick ~listener:(fun () -> QuickPick.dispose quickPick) ()
    in
    QuickPick.show quickPick

  and show_query_input =
    let previous : Disposable.t option ref = ref None in
    fun ?(empty_result = false) text_editor client ->
      let open Promise.Syntax in
      let () =
        match !previous with
        | None -> ()
        | Some disposable -> Disposable.dispose disposable
      in
      let _update_input_box =
        let validationMessage =
          if empty_result
          then
            Some
              (InputBoxValidationMessage.create
                 ~message:"No result found. Check the syntax or use a more general query."
                 ~severity:Warning
                 ())
          else None
        in
        InputBox.set_validationMessage input_box validationMessage;
        InputBox.set_busy input_box false;
        InputBox.set_enabled input_box true
      in
      let onDidAccept_disposable =
        InputBox.onDidAccept
          input_box
          ~listener:(fun () ->
            match InputBox.value input_box with
            | Some query ->
              let () = InputBox.set_busy input_box true in
              let () = InputBox.set_enabled input_box false in
              let position = TextEditor.selection text_editor |> Selection.active in
              ignore
                (let+ query_results =
                   get_search_results
                     ~query
                     ~with_doc:true
                     ~limit:100
                     ~position
                     text_editor
                     client
                 in
                 match query_results with
                 | [] -> show_query_input ~empty_result:true text_editor client
                 | results ->
                   let results =
                     List.remove_consecutive_duplicates
                       ~which_to_keep:`First
                       ~equal:
                         (fun
                           (left : Custom_requests.Type_search.type_search_result)
                           right ->
                         String.equal left.name right.name && left.cost = right.cost)
                       results
                   in
                   display_search_results query results text_editor position client)
            | None -> ())
          ()
      in
      previous := Some onDidAccept_disposable;
      InputBox.show input_box
  ;;

  let _search_by_type =
    let callback (instance : Extension_instance.t) () =
      match Window.activeTextEditor () with
      | None ->
        Command_api.Command_errors.text_editor_must_be_active
          extension_name
          ~expl:
            "The cursor position is used to determine the correct environment and insert \
             the result."
        |> show_message `Error "%s"
      | Some text_editor when not (is_valid_text_doc (TextEditor.document text_editor)) ->
        show_message
          `Error
          "Invalid file type. This command only works in ocaml files, ocaml interface \
           files, reason files or ocamllex files."
      | Some text_editor ->
        (match Extension_instance.lsp_client instance with
         | None -> show_message `Warn "ocamllsp is not running"
         | Some (_client, ocaml_lsp)
           when ocaml_lsp_doesnt_support_search_by_type ocaml_lsp ->
           let _ =
             Ocaml_lsp.suggest_to_upgrade_ocaml_lsp_server
               ~message:
                 "The installed version of \"ocamllsp\" does not support type search."
               ()
           in
           ()
         | Some (client, _) -> show_query_input text_editor client)
    in
    command Command_api.Internal.search_by_type callback
  ;;
end

module Navigate_holes = struct
  let extension_name = "Navigate between Typed Holes"

  let ocaml_lsp_doesnt_support_typed_holes ocaml_lsp =
    not (Ocaml_lsp.can_handle_typed_holes ocaml_lsp)
  ;;

  let is_valid_text_doc textdoc =
    match TextDocument.languageId textdoc with
    | "ocaml" | "ocaml.interface" | "reason" -> true
    | _ -> false
  ;;

  let send_request_to_lsp client doc =
    let uri = TextDocument.uri doc in
    Custom_requests.send_request client Custom_requests.typedHoles uri
  ;;

  let jump_to_range range text_editor =
    let open Promise.Syntax in
    let+ _ =
      Window.showTextDocument
        ~document:(TextEditor.document text_editor)
        ~preserveFocus:true
        ()
    in
    let selection =
      let anchor = Range.start range in
      let active = Range.end_ range in
      Selection.makePositions ~anchor ~active
    in
    select_and_reveal selection text_editor
  ;;

  module QuickPickItemWithRange = struct
    type t =
      { item : QuickPickItem.t
      ; range : Range.t
      }

    let t_of_js js =
      let range = [%js.to: Range.t] (Ojs.get_prop_ascii js "pl_range") in
      let item = [%js.to: QuickPickItem.t] js in
      { item; range }
    ;;

    let t_to_js t =
      let item = [%js.of: QuickPickItem.t] t.item in
      Ojs.set_prop_ascii item "pl_range" @@ [%js.of: Range.t] t.range;
      item
    ;;
  end

  module QuickPick = Vscode.QuickPick.Make (QuickPickItemWithRange)

  let display_results (results : Range.t list) text_editor client instance =
    let open Promise.Syntax in
    let selected_item = ref false in
    let text_document = TextEditor.document text_editor in
    let quickPickItems =
      List.map results ~f:(fun range ->
        let line = Position.line @@ Range.end_ range in
        let item =
          QuickPickItem.create
            ~label:(Printf.sprintf "Line %d" line)
            ~description:(TextLine.text @@ TextDocument.lineAt ~line text_document)
            ()
        in
        { QuickPickItemWithRange.item; range })
    in
    let quickPick =
      QuickPick.set
        (Window.createQuickPick (module QuickPickItemWithRange) ())
        ~title:"Typed Holes"
        ~activeItems:[]
        ~busy:false
        ~enabled:true
        ~placeholder:"Use arrow keys to preview / Select to jump"
        ~selectedItems:[]
        ~ignoreFocusOut:false
        ~items:quickPickItems
        ~matchOnDescription:true
        ~buttons:[]
        ()
    in
    let _disposable =
      QuickPick.onDidChangeActive
        quickPick
        ~listener:(function
          | { range; _ } :: _ -> Decorations.highlight_and_reveal_range text_editor range
          | _ -> ())
        ()
    in
    let _disposable =
      QuickPick.onDidAccept
        quickPick
        ~listener:(fun () ->
          match QuickPick.selectedItems quickPick with
          | Some (item :: _) ->
            ignore
              (let range = item.range in
               let* () = jump_to_range range text_editor in
               selected_item := true;
               match Settings.(get server_typedHolesConstructAfterNavigate_setting) with
               | Some true ->
                 Construct.process_construct
                   (Range.end_ range)
                   text_editor
                   client
                   instance
               | Some false | None -> Promise.return ())
          | _ -> ())
        ()
    in
    let _disposable =
      let initial_selection = TextEditor.selection text_editor in
      (* We watch selection change events so that we don't jump back to the
         original position if an external command or user action was performed. *)
      let selection_changed = ref false in
      let selection_listener_disposable = watch_selection_change selection_changed in
      QuickPick.onDidHide
        quickPick
        ~listener:(fun () ->
          if not (!selection_changed || !selected_item)
          then select_and_reveal initial_selection text_editor;
          Decorations.remove_all_highlights text_editor;
          Disposable.dispose selection_listener_disposable;
          QuickPick.dispose quickPick)
        ()
    in
    QuickPick.show quickPick
  ;;

  let handle_hole_navigation text_editor client instance =
    let open Promise.Syntax in
    let doc = TextEditor.document text_editor in
    let+ hole_positions = send_request_to_lsp client doc in
    match hole_positions with
    | [] -> show_message `Info "No typed holes found in the file."
    | holes -> display_results holes text_editor client instance
  ;;

  let _holes =
    let callback (instance : Extension_instance.t) () =
      match Window.activeTextEditor () with
      | None ->
        Command_api.Command_errors.text_editor_must_be_active
          extension_name
          ~expl:
            "This command only works in an active editor because it's based on the \
             content of the editor"
        |> show_message `Error "%s"
      | Some text_editor when not (is_valid_text_doc (TextEditor.document text_editor)) ->
        show_message
          `Error
          "Invalid file type. This command only works in ocaml files, ocaml interface \
           files, reason files."
      | Some text_editor ->
        (match Extension_instance.lsp_client instance with
         | None -> show_message `Warn "ocamllsp is not running"
         | Some (_client, ocaml_lsp) when ocaml_lsp_doesnt_support_typed_holes ocaml_lsp
           ->
           let _ =
             Ocaml_lsp.suggest_to_upgrade_ocaml_lsp_server
               ~message:
                 "The installed version of `ocamllsp` does not support typed hole \
                  navigation."
               ()
           in
           ()
         | Some (client, _) ->
           let _ = handle_hole_navigation text_editor client instance in
           ())
    in
    command Command_api.Internal.navigate_typed_holes callback
  ;;
end

let _type_selection =
  let open Type_selection in
  command Command_api.Internal.type_selection callback |> ignore;
  command Command_api.Internal.type_previous_selection previous_callback |> ignore;
  command Command_api.Internal.augment_selection_type_verbosity verbosity_callback
  |> ignore
;;

let register extension instance = function
  | Command { handle; callback } ->
    let (module T) = handle.return_type in
    let callback ~args = [%js.of: T.t] (callback instance (handle.args_of_js args)) in
    let disposable = Commands.registerCommand ~command:handle.id ~callback in
    ExtensionContext.subscribe extension ~disposable
  | Text_editor_command { handle; callback } ->
    let callback ~textEditor ~edit ~args =
      callback instance ~textEditor ~edit (handle.args_of_js args)
    in
    let disposable = Commands.registerTextEditorCommand ~command:handle.id ~callback in
    ExtensionContext.subscribe extension ~disposable
;;

let register_all_commands extension instance =
  List.iter ~f:(register extension instance) !commands
;;

let register handle callback =
  let (_ : t) = command handle callback in
  ()
;;

let register_text_editor handle callback =
  let (_ : t) = text_editor_command handle callback in
  ()
;;
