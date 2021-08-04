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
  match (has_utop, can_build) with
  | true, true -> Sandbox.get_command sandbox "dune" [ "utop" ]
  | true, false -> Sandbox.get_command sandbox "utop" []
  | false, _ -> Sandbox.get_command sandbox "ocaml" []

(** opens a terminal containing the REPL either by creating a new terminal or
    showing the existing one *)
let open_terminal instance sandbox =
  match Extension_instance.repl instance with
  | Some term ->
    Terminal_sandbox.show ~preserveFocus:true term;
    Promise.return (Ok term)
  | None -> (
    let open Promise.Syntax in
    let* cmd =
      let get_cmd_from_inputbox () =
        let options =
          InputBoxOptions.create ~title:"Command to launch REPL"
            ~prompt:
              "dune utop my_library (* note: [dune utop my_executable] isn't \
               supported *)"
            ~placeHolder:"dune utop " ()
        in
        let+ (cmd : string option) = Window.showInputBox ~options () in
        Option.bind cmd ~f:(function
          | "" -> None
          | cmd -> (
            match String.split cmd ~on:' ' with
            | [] -> None
            | bin :: args -> Some (Cmd.Spawn { bin = Path.of_string bin; args })
            ))
      in
      match get_repl_path () with
      | Some bin ->
        let args = Option.value (get_repl_args ()) ~default:[] in
        Sandbox.get_command sandbox bin args |> Promise.return
      | None -> (
        let* cmd_from_inputbox = get_cmd_from_inputbox () in
        match cmd_from_inputbox with
        | Some cmd -> Promise.return cmd
        | None -> default_repl sandbox)
    in
    let* result = Cmd.check cmd in
    match result with
    | Error err -> Promise.return (Error err)
    | Ok (Shell _) ->
      Promise.return
        (Error "Running a REPL from a Shell command is not supported")
    | Ok (Spawn cmd) -> (
      let term = Terminal_sandbox.create ~name ~command:cmd sandbox in
      Terminal_sandbox.show term;
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

let prepare_code code =
  if String.is_suffix code ~suffix:";;" then
    code
  else
    code ^ ";;"

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

  let _evaluate_selection =
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
                let code = prepare_code code in
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
              Terminal_sandbox.send term (prepare_code code);
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
                Terminal_sandbox.send term (prepare_code code))))
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.evaluate_selection handler
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
