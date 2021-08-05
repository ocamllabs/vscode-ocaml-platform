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
      ~placeHolder:"example: dune utop" ()
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

(** opens a terminal containing the REPL either by creating a new terminal or
    showing the existing one *)
let open_terminal instance sandbox =
  match Extension_instance.repl instance with
  | Some term ->
    Terminal_sandbox.show ~preserveFocus:true term;
    Promise.return (Ok term)
  | None -> (
    let open Promise.Syntax in
    (* when [ocaml.repl.path] setting isn't set or is invalid, we offer an input
       box to the user to get the command to launch REPL; if that doesn't
       succeed we launch default REPL. *)
    let repl_when_invalid_repl_settings () =
      let* cmd_from_inputbox = repl_from_inputbox sandbox in
      match cmd_from_inputbox with
      | Some cmd -> Promise.return cmd
      | None -> default_repl sandbox
    in
    let* cmd =
      match Settings.repl_path () with
      | None -> repl_when_invalid_repl_settings ()
      | Some bin when not (String.is_empty bin) ->
        let args = Option.value (Settings.repl_args ()) ~default:[] in
        Sandbox.get_command sandbox bin args |> Promise.return
      | Some _ ->
        show_message `Warn
          "REPL Path setting is set to an empty string, which is not a valid \
           path to a REPL executable. Consider fixing that if you want to \
           launch REPL from that setting.";
        repl_when_invalid_repl_settings ()
    in
    let* result = Cmd.check cmd in
    match result with
    | Error err -> Promise.return (Error err)
    | Ok (Shell _) ->
      Promise.return
        (Error "Running a REPL from a Shell command is not supported")
    | Ok (Spawn command) -> (
      let term = Terminal_sandbox.create ~name ~command sandbox in
      Terminal_sandbox.show term;
      (* Wait for UTop or OCaml REPL to be initialized before sending text to
         the terminal.

         That's hacky, buy hey, if vscode-python does it, so can we...
         https://github.com/microsoft/vscode-python/blob/main/src/client/terminals/codeExecution/terminalCodeExecution.ts#L54 *)
      let+ () = Node.set_timeout 2500 in
      match Terminal.exitStatus term with
      | Some _ -> Error "The REPL terminal could not be open"
      | None ->
        Extension_instance.set_repl instance (Some term);
        Ok term))

(** returns selected code; returns [None] if nothing is selected, i.e.,
    selection start and end are same *)
let get_selected_code text_editor =
  let selection = TextEditor.selection text_editor in
  let document = TextEditor.document text_editor in
  if
    Position.isEqual
      (Selection.start selection)
      ~other:(Selection.end_ selection)
  then
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
        let (_ : (Terminal.t, unit) result) =
          Result.map_error result ~f:(fun err -> log "%s" err)
        in
        ()
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
            Promise.return
              (if String.length code > 0 then
                let code = preformat_code code in
                Terminal_sandbox.send term code)
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
