open Import

module Repl_path = struct
  type t = string option

  let of_json json =
    let open Jsonoo.Decode in
    nullable string json

  let to_json (t : t) =
    let open Jsonoo.Encode in
    nullable string t

  let key = "path"

  let t = Settings.create_setting ~scope:Global ~key ~of_json ~to_json
end

let ocaml_utop_setting =
  Settings.create_setting ~scope:Global ~key:"ocaml.repl.useUtop"
    ~of_json:Jsonoo.Decode.bool ~to_json:Jsonoo.Encode.bool

let use_utop () =
  match Settings.get ocaml_utop_setting with
  | Some x -> x
  | None -> true

module Repl_args = struct
  type t = string list option

  let of_json json =
    let open Jsonoo.Decode in
    nullable (list string) json

  let to_json (t : t) =
    let open Jsonoo.Encode in
    nullable (list string) t

  let key = "args"

  let t = Settings.create_setting ~scope:Global ~key ~of_json ~to_json
end

let get_repl_path () =
  Option.join (Settings.get ~section:"ocaml.repl" Repl_path.t)

let get_repl_args () =
  Option.join (Settings.get ~section:"ocaml.repl" Repl_args.t)

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
  match (has_utop, use_utop (), can_build) with
  | true, true, true -> Sandbox.get_command sandbox "dune" [ "utop" ]
  | true, true, false -> Sandbox.get_command sandbox "utop" []
  | _ -> Sandbox.get_command sandbox "ocaml" []

let create_terminal instance sandbox =
  match Extension_instance.repl instance with
  | Some term ->
    Terminal_sandbox.show ~preserveFocus:true term;
    Promise.return (Ok term)
  | None -> (
    let open Promise.Syntax in
    let* cmd =
      match (get_repl_path (), get_repl_args ()) with
      | Some bin, Some args ->
        Sandbox.get_command sandbox bin args |> Promise.return
      | Some bin, None -> Sandbox.get_command sandbox bin [] |> Promise.return
      | None, _ -> default_repl sandbox
    in
    let* result = Cmd.check cmd in
    match result with
    | Error err -> Promise.return (Error err)
    | Ok (Shell _) ->
      Promise.return
        (Error "Running a REPL from a Shell command is not supported")
    | Ok (Spawn cmd) -> (
      let term = Terminal_sandbox.create ~name ~command:cmd sandbox in
      Terminal_sandbox.show ~preserveFocus:true term;
      (* Wait for UTop or OCaml REPL to be initialized before sending text to
         the terminal.

         That's hacky, buy hey, if vscode-python does it, so can we...
         https://github.com/microsoft/vscode-python/blob/main/src/client/terminals/codeExecution/terminalCodeExecution.ts#L54 *)
      let+ () =
        Promise.make (fun ~resolve ~reject:_ ->
            let (_ : Node.Timeout.t) =
              Node.setTimeout (fun () -> resolve ()) 2500
            in
            ())
      in
      match Terminal.exitStatus term with
      | Some _ -> Error "The REPL terminal could not be open"
      | None ->
        Extension_instance.set_repl instance term;
        Ok term))

let get_selected_code text_editor =
  let selection = TextEditor.selection text_editor in
  let document = TextEditor.document text_editor in
  if Selection.isEmpty selection then None
  else
    let selected_text =
      TextDocument.getText document ~range:(selection :> Range.t) ()
    in
    Some selected_text

let get_uri text_editor =
  text_editor |> Vscode.TextEditor.document |> Vscode.TextDocument.uri
  |> Vscode.Uri.fsPath

let preformat_code code =
  let is_repl_ready s = String.is_suffix s ~suffix:";;" in
  let trimmed_code = String.strip code in
  if is_repl_ready trimmed_code then
    if String.mem trimmed_code '\n' then
      (* newline is for nicer look in REPL *)
      "\n" ^ trimmed_code
    else trimmed_code
  else if String.mem trimmed_code '\n' then
    Printf.sprintf "\n%s\n;;" trimmed_code
  else trimmed_code ^ " ;;"

module Command = struct
  let _open_repl =
    let handler (instance : Extension_instance.t) ~args:_ =
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        let+ (result : (Terminal.t, string) result) =
          create_terminal instance sandbox
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
      let (_ : unit Promise.t Promise.t) =
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        let+ term = create_terminal instance sandbox in
        match term with
        | Error err ->
          show_message `Error "Could not start the REPL: %s" err;
          Promise.return ()
        | Ok term -> (
          let code = get_selected_code textEditor in
          match code with
          | Some code ->
            let code = preformat_code code in
            Terminal_sandbox.send term code;
            Promise.return ()
          | None -> (
            let open Promise.Syntax in
            match Extension_instance.lsp_client instance with
            | None ->
              show_message `Warn "ocamllsp is not running.";
              Promise.return ()
            | Some (_, ocaml_lsp)
              when not (Ocaml_lsp.can_handle_wrapping_ast_node ocaml_lsp) ->
              Promise.return ()
            | Some (client, _) -> (
              let doc = TextEditor.document textEditor in
              let uri = TextDocument.uri doc in
              let position =
                let selection = TextEditor.selection textEditor in
                Selection.start selection
              in
              let line_of_position =
                TextDocument.lineAtPosition doc ~position
              in
              (* The lsp-server needs to have the good position to evaluate the
                 right expression here we go up until we find an expression or
                 stop at the top (on the line 0) *)
              let rec find_correct_position line =
                let line_text = TextLine.text line in
                let stripped_line_text = String.strip line_text in
                match stripped_line_text with
                | text when String.is_suffix text ~suffix:";;" ->
                  (* The cursor if after an expression *)
                  if
                    String.compare text ";;" = 0
                    && TextLine.lineNumber line <> 0
                  then
                    (* The expression should in the previous line so we go up *)
                    let previous_line =
                      TextDocument.lineAt doc
                        ~line:(TextLine.lineNumber line - 1)
                    in
                    find_correct_position previous_line
                  else line |> TextLine.range |> Range.start
                | text
                  when String.compare text "" = 0
                       || String.is_prefix text ~prefix:"(*" ->
                  (* We choose to go for the previous expression but we could
                     instead evaluate the whole file *)
                  if TextLine.lineNumber line <> 0 then
                    let previous_line =
                      TextDocument.lineAt doc
                        ~line:(TextLine.lineNumber line - 1)
                    in
                    find_correct_position previous_line
                  else line |> TextLine.range |> Range.start
                | _ ->
                  (* The cursor is on line of an expression *)
                  line |> TextLine.range |> Range.start
              in
              let correct_position = find_correct_position line_of_position in
              let text_correct_position =
                String.strip
                  (TextLine.text
                     (TextDocument.lineAtPosition doc ~position:correct_position))
              in
              if
                String.compare text_correct_position "" = 0
                || String.is_prefix text_correct_position ~prefix:";;"
                || String.is_prefix text_correct_position ~prefix:"(*"
              then Promise.return ()
              else
                let+ range =
                  Custom_requests.Wrapping_ast_node.send_request client ~doc:uri
                    ~position:correct_position
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

  let _evaluate_file =
    let handler (instance : Extension_instance.t) ~textEditor ~edit:_ ~args:_ =
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        let+ term = create_terminal instance sandbox in
        match term with
        | Error err -> show_message `Error "Could not start the REPL: %s" err
        | Ok term ->
          let uri = get_uri textEditor in
          let use = "#use {|" ^ uri ^ "|};;" in
          Terminal_sandbox.send term use
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.evaluate_file handler
end

let register extension instance =
  let disposable =
    Vscode.Window.onDidCloseTerminal ()
      ~listener:(fun terminal ->
        if String.equal (Vscode.Terminal.name terminal) name then
          Extension_instance.close_repl instance)
      ()
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
