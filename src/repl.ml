open Import

let name = "REPL"

let has_utop sandbox =
  let open Promise.Syntax in
  let cmd = Sandbox.get_command sandbox "utop" [ "-version" ] in
  let+ result = Cmd.output cmd in
  match result with
  | Error _ -> false
  | Ok _ -> true

let can_build sandbox =
  let open Promise.Syntax in
  let excludes =
    (* ignoring dune files from _build, _opam, _esy *)
    `String "{**/_*}"
  in
  let includes = `String "**/{dune-project}" in
  let* dunes = Workspace.findFiles ~includes ~excludes () in
  match dunes with
  | [] -> Promise.return false
  | _ :: _ :: _ ->
    (* If the workspace contains several dune-project, we don't know how to
       build it. *)
    Promise.return false
  | el :: _ -> (
    let cwd = Stdlib.Filename.dirname (Uri.fsPath el) |> Path.of_string in
    let cmd = Sandbox.get_command sandbox "dune" [ "build" ] in
    let+ result = Cmd.output ~cwd cmd in
    match result with
    | Error _ -> false
    | Ok _ -> true)

let default_repl sandbox =
  let open Promise.Syntax in
  let* has_utop = has_utop sandbox in
  let+ can_build = can_build sandbox in
  match (has_utop, can_build) with
  | true, true -> Sandbox.get_command sandbox "dune" [ "utop" ]
  | true, false -> Sandbox.get_command sandbox "utop" []
  | false, _ -> Sandbox.get_command sandbox "ocaml" []

(** If [ocaml.repl.path] isn't set, we offer user an input box to enter the
    command to launch REPL, e.g., [dune utop]. This function shows that input
    box to the user and returns its contents. *)
let repl_from_inputbox sandbox =
  let options =
    InputBoxOptions.create ~title:"Command to launch REPL"
      ~placeHolder:"example: utop" ()
      ~prompt:"If not provided, a default REPL will open."
  in
  let open Promise.Syntax in
  let+ (cmd : string option) = Window.showInputBox ~options () in
  let bin_and_args = Option.map cmd ~f:(String.split ~on:' ') in
  match bin_and_args with
  | None
  | Some [] ->
    None
  | Some (bin :: args) -> Some (Sandbox.get_command sandbox bin args)

let create_new_terminal ~name command sandbox =
  Terminal_sandbox.create ~name ~command sandbox

let open_repl_in_existing_terminal terminal command =
  let _launch_repl : unit =
    let { Cmd.bin; args } = command in
    let bin = Path.to_string bin in

    let repl_command = bin :: args in
    (* if user closes the REPL that is opened by sending the REPL command, the
       rest of expressions will be sent to terminal if we don't close it
       together with REPL; hence we chain an exit *)
    let open_repl_and_kill_terminal_on_repl_close =
      let exit =
        match Platform.t with
        | Platform.Win32 -> "Exit" (* TODO: works on windows? *)
        | Platform.Darwin
        | Platform.Linux
        | Platform.Other ->
          "exit"
      in
      repl_command @ [ ";"; exit ] |> String.concat ~sep:" "
    in
    Terminal_sandbox.send terminal open_repl_and_kill_terminal_on_repl_close
  in
  terminal

let user_picks_terminal ~include_create_new_terminal () =
  let choices =
    let existings_terminal_choices =
      let terminals = Window.terminals () |> Sequence.of_list in
      let qpick_terminals =
        Sequence.map terminals ~f:(fun terminal ->
            let name = Terminal.name terminal in
            QuickPickItem.create ~label:name
              ~detail:
                "Make sure the Terminal doesn't have another process running \
                 in the foreground. Note: Exiting the REPL will result in \
                 closing the terminal."
              ())
      in
      let terminals =
        Sequence.map terminals ~f:(fun t -> `Existing_terminal t)
      in
      Sequence.zip qpick_terminals terminals |> Sequence.to_list
    in
    if not include_create_new_terminal then
      match existings_terminal_choices with
      | _ :: _ -> existings_terminal_choices
      | [] ->
        ( QuickPickItem.create ~label:"Create New Terminal"
            ~description:"because there are no existing terminals" ()
        , `New_terminal )
        :: existings_terminal_choices
    else
      let create_new_terminal_choice =
        (QuickPickItem.create ~label:"Create New Terminal" (), `New_terminal)
      in
      create_new_terminal_choice :: existings_terminal_choices
  in
  let options =
    QuickPickOptions.create ~title:"Pick Terminal to Launch a REPL in" ()
  in
  Window.showQuickPickItems ~choices ~options ()

(* TODO: use [?command] *)
let err_msg_of_terminal_exit_status ?command exit_status =
  let default_err = "a terminal for REPL could not be open for some reason" in
  match Platform.t with
  | Platform.Win32
  | Other ->
    default_err
  | Darwin
  | Linux -> (
    match TerminalExitStatus.code exit_status with
    | None -> default_err
    | Some 0 -> default_err
    | Some code -> (
      let fmted_cmd =
        Option.value_map command ~default:"" ~f:(fun c ->
            Printf.sprintf "'%s' " c)
      in
      let fmted_msg msg = Printf.sprintf msg fmted_cmd in
      match code with
      | 126 -> fmted_msg "Command %scannot execute"
      | 127 -> fmted_msg "Command %snot found"
      | 130 -> fmted_msg "Command %sterminated by 'control+c'"
      | _ -> default_err))

(** opens a terminal containing the REPL either by creating a new terminal or
    showing the existing one *)
let open_terminal instance sandbox : Terminal.t Or_error.t Promise.t =
  match Extension_instance.repl instance with
  | Some term ->
    Terminal_sandbox.show ~preserveFocus:true term;
    Promise.return (Ok term)
  | None -> (
    let open Promise.Syntax in
    (* when [ocaml.repl.path] setting isn't set or is invalid, we offer an input
       box to the user to get the command to launch REPL; if that doesn't
       succeed, we launch default REPL. *)
    let repl_terminal_no_repl_path () =
      let* cmd_from_inputbox = repl_from_inputbox sandbox in
      match cmd_from_inputbox with
      | Some cmd -> Promise.return cmd
      | None -> default_repl sandbox
    in
    let* cmd =
      match Settings.repl_path () with
      | None -> repl_terminal_no_repl_path ()
      | Some "" ->
        show_message `Warn
          "REPL Path setting is set to an empty string, which is not a valid \
           path to a REPL executable. Consider fixing that if you want to \
           launch REPL from that setting next time.";
        repl_terminal_no_repl_path ()
      | Some bin ->
        let args = Option.value (Settings.repl_args ()) ~default:[] in
        Sandbox.get_command sandbox bin args |> Promise.return
    in
    let* result = Cmd.check cmd in
    match result with
    | Error err -> Promise.return (Error err)
    | Ok (Shell _) ->
      Promise.return
        (Error "Running a REPL from a Shell command is not supported")
    | Ok (Spawn command) -> (
      let* pick =
        match Settings.repl_terminal () with
        | Settings.Repl_terminal.Always_create_new_terminal ->
          Promise.return (Some `New_terminal)
        | Always_existing_terminal ->
          user_picks_terminal ~include_create_new_terminal:false ()
        | Always_ask -> user_picks_terminal ~include_create_new_terminal:true ()
      in
      let pick = Option.value pick ~default:`New_terminal in
      let terminal =
        match pick with
        | `New_terminal -> create_new_terminal ~name command sandbox
        | `Existing_terminal terminal ->
          open_repl_in_existing_terminal terminal command
      in
      Terminal_sandbox.show ~preserveFocus:true terminal;
      (* With the current vscode API we can't check if there's a process running
         in the foreground or whether the REPL is ready to evaluate code (eg
         it's setting up env), so we wait for the init to happen. So does python
         extension:
         https://github.com/microsoft/vscode-python/blob/main/src/client/terminals/codeExecution/terminalCodeExecution.ts#L54 *)
      let+ () = Node.setTimeoutPromise ~milliseconds:1500 in
      match Terminal.exit_status terminal with
      | `Not_exited_yet ->
        Extension_instance.set_repl instance (Some terminal);
        Ok terminal
      | `Exit_status s -> Error (err_msg_of_terminal_exit_status s)))

(** returns selected code; returns [None] if nothing is selected, i.e.,
    selection start and end are same *)
let get_selected_code text_editor =
  let selection = TextEditor.selection text_editor in
  let document = TextEditor.document text_editor in
  if Selection.isEmpty selection then
    None
  else
    let selected_text =
      TextDocument.getText document ~range:(selection :> Range.t) ()
    in
    Some selected_text

(** preformat code by trimming it, inserting newlines at both ends for nicer
    looking input to the repl, and append [;;] if wasn't present already in the
    trimmed code *)
let preformat_code code =
  let is_repl_ready s = String.is_suffix s ~suffix:";;" in
  let trimmed_code = String.strip code in
  if is_repl_ready code then
    (* newline is for nicer look in REPL *)
    "\n" ^ trimmed_code
  else
    Printf.sprintf "\n%s\n;;" trimmed_code

module Command = struct
  let _open_repl =
    let handler (instance : Extension_instance.t) ~args:_ =
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        let+ (result : (Terminal.t, string) result) =
          open_terminal instance sandbox
        in
        Result.iter_error result ~f:(fun err -> log "%s" err)
      in
      ()
    in
    Extension_commands.register ~id:Extension_consts.Commands.open_repl handler

  let _evaluate_expression =
    let handler (instance : Extension_instance.t) ~textEditor ~edit:_ ~args:_ =
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        let* term = open_terminal instance sandbox in
        match term with
        | Error err ->
          show_message `Error "Could not start the REPL: %s" err;
          Promise.return ()
        | Ok term -> (
          match get_selected_code textEditor with
          | Some code ->
            (if String.length code > 0 then
              let code = preformat_code code in
              Terminal_sandbox.send term code);
            Promise.return ()
          | None -> (
            let open Promise.Syntax in
            match Extension_instance.lsp_client instance with
            | None ->
              show_message `Warn "ocamllsp is not running.";
              Promise.return ()
            | Some (_, ocaml_lsp)
              when not (Ocaml_lsp.can_handle_wrapping_ast_node ocaml_lsp) ->
              (* we fall back to pre ocaml-lsp v1.8.0 behavior; we don't advise
                 to update ocaml-lsp because latest ocaml-lsp-s require 4.12.0
                 which the user may not have switched to *)
              let document = TextEditor.document textEditor in
              let selection = TextEditor.selection textEditor in
              let start = Selection.start selection in
              let code =
                TextDocument.lineAt document ~line:(Position.line start)
                |> TextLine.text
              in
              Terminal_sandbox.send term (preformat_code code);
              Promise.return ()
            | Some (client, _ocaml_lsp) -> (
              let doc = TextEditor.document textEditor in
              let uri = TextDocument.uri doc in
              let position =
                let selection = TextEditor.selection textEditor in
                Selection.start selection
              in
              let+ range =
                Custom_requests.Wrapping_ast_node.send_request client ~doc:uri
                  ~position
              in
              match range with
              | None -> ()
              | Some range ->
                let code = TextDocument.getText doc ~range () in
                Terminal_sandbox.send term (preformat_code code))))
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.evaluate_expression handler

  let open_terminal_send_text instance text err_msg =
    let open Promise.Syntax in
    let sandbox = Extension_instance.sandbox instance in
    let+ (result : (Terminal.t, string) result) =
      open_terminal instance sandbox
    in
    match result with
    | Error e -> show_message `Error "%s: %s" err_msg e
    | Ok terminal -> Terminal_sandbox.send terminal (text ())

  let evaluate_file ~repl_directive command_id err_msg =
    let handler (instance : Extension_instance.t) ~args:_ =
      let text_editor = Window.activeTextEditor () in
      let (_ : unit Promise.t) =
        match text_editor with
        | None -> Promise.return ()
        | Some text_editor ->
          let document = TextEditor.document text_editor in
          let uri = TextDocument.uri document in
          let path = Uri.path uri in
          open_terminal_send_text instance
            (fun () -> Printf.sprintf "%s \"%s\";;" repl_directive path)
            err_msg
      in
      ()
    in
    Extension_commands.register ~id:command_id handler

  let _evaluate_file =
    evaluate_file ~repl_directive:"#use" Extension_consts.Commands.evaluate_file
      "Error in 'Evaluate Current File in REPL'"

  let _evaluate_file_as_module =
    evaluate_file ~repl_directive:"#mod_use"
      Extension_consts.Commands.evaluate_file_as_module
      "Error in 'Evaluate Current File as a module in REPL'"
end

let register extension instance =
  let disposable =
    Vscode.Window.onDidCloseTerminal ()
      ~listener:(fun terminal ->
        match Extension_instance.repl instance with
        | Some t when phys_equal terminal t ->
          Extension_instance.set_repl instance None
        | Some _
        | None ->
          ())
      ()
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
