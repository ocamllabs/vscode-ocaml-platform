open Import

module Repl_path = struct
  type t = string option

  let of_json json =
    let open Json.Decode in
    nullable string json

  let to_json (t : t) =
    let open Json.Encode in
    nullable string t

  let key = "path"

  let t = Settings.create ~scope:`Global ~key ~of_json ~to_json
end

module Repl_args = struct
  type t = string list option

  let of_json json =
    let open Json.Decode in
    nullable (list string) json

  let to_json (t : t) =
    let open Json.Encode in
    nullable (list string) t

  let key = "args"

  let t = Settings.create ~scope:`Global ~key ~of_json ~to_json
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
  let exclude =
    (* ignoring dune files from _build, _opam, _esy *)
    `String "{**/_*}"
  in
  let includes = `String "**/{dune-project}" in
  let* dunes = Workspace.find_files includes ~exclude () in
  match dunes with
  | [] -> Promise.return false
  | _ :: _ :: _ ->
    (* If the workspace contains several dune-project, we don't know how to
       build it. *)
    Promise.return false
  | el :: _ -> (
    let cwd = Stdlib.Filename.dirname (Uri.fs_path el) |> Path.of_string in
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

let create_terminal instance sandbox =
  match Extension_instance.repl instance with
  | Some term ->
    Terminal_sandbox.show term;
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
      Terminal_sandbox.show term;
      (* Wait for UTop or OCaml REPL to be initialized before sending text to
         the terminal.

         That's hacky, buy hey, if vscode-python does it, so can we..
         https://github.com/microsoft/vscode-python/blob/main/src/client/terminals/codeExecution/terminal_code_execution.ts#L54 *)
      let+ _ =
        Promise.make (fun ~resolve ~reject:_ ->
            let (_ : Node.Timeout.t) =
              Node.set_timeout (fun _ -> resolve true) ~ms:2500 ()
            in
            ())
      in
      match Terminal.exit_status term with
      | Some _ -> Error "The REPL terminal could not be open"
      | None ->
        Extension_instance.set_repl instance term;
        Ok term))

let get_code text_editor =
  let selection = Text_editor.selection text_editor in
  let start_line = Selection.start selection |> Position.line in
  let end_line = Selection.end_ selection |> Position.line in
  let start_char = Selection.start selection |> Position.character in
  let end_char = Selection.end_ selection |> Position.character in
  let document = Text_editor.document text_editor in
  if start_line = end_line && start_char = end_char then
    let line = Text_document.line_at document start_line in
    Text_line.text line
  else
    Text_document.get_text document ~range:(selection :> Range.t) ()

let prepare_code code =
  if String.is_suffix code ~suffix:";;" then
    code
  else
    code ^ ";;"

module Command = struct
  let _open_repl =
    let handler (instance : Extension_instance.t) _args =
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

  let _evaluate_selection =
    let handler (instance : Extension_instance.t) ~text_editor ~edit:_ ~args:_ =
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        let+ term = create_terminal instance sandbox in
        match term with
        | Error err -> show_message `Error "Could not start the REPL: %s" err
        | Ok term ->
          let code = get_code text_editor in
          if String.length code > 0 then
            let code = prepare_code code in
            Terminal_sandbox.send term code
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.evaluate_selection handler
end

let register extension instance =
  let disposable =
    Window.on_did_close_terminal ()
      (fun terminal ->
        if String.equal (Terminal.name terminal) name then
          Extension_instance.close_repl instance)
      ()
  in
  Extension_context.subscribe extension disposable
