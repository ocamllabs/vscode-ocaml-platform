open Import

type context =
  | Dune
  | Unknown

let project_context () =
  Workspace.findFiles
    ~includes:(`String "**/{dune-project}")
    ~excludes:(`String "{**/_*}" (* ignoring dune files from _build, _opam, _esy *))
    ()
  |> Promise.map (function
    | [] -> Unknown
    | _ -> Dune)
;;

let find_executables sandbox project_ctx =
  let open Promise.Syntax in
  match project_ctx with
  | Dune ->
    let+ { ChildProcess.stdout; _ } =
      Dune_describe.command sandbox |> Cmd.run ?cwd:(Sandbox.workspace_root ())
    in
    Parsexp.Conv_single.parse_string stdout Dune_describe.parse_executables
    |> Stdlib.Result.to_option
    |> Option.join
  | Unknown ->
    let+ ml_files =
      Workspace.findFiles
        ~includes:(`String "**/*.ml")
        ~excludes:(`String "{**/_*}" (* ignoring ml files from _build, _opam, _esy *))
        ()
    in
    let execs =
      List.map
        ~f:(fun uri ->
          (* FIXME: This is fragile. We probably need to use [Node.Path] bindings here. *)
          let abs_path = Uri.path uri in
          let mod_path =
            match Workspace.rootPath () with
            | None -> abs_path
            | Some root ->
              (match String.chop_prefix ~prefix:root abs_path with
               | None -> abs_path
               | Some rel_path -> "." ^ rel_path)
          in
          { Dune_describe.name = Stdlib.Filename.basename mod_path
          ; mod_path
          ; exec_path = mod_path
          })
        ml_files
    in
    Some execs
;;

let exec_cmd sandbox project_ctx (exec : Dune_describe.executable) args =
  let program, args =
    match project_ctx with
    | Dune -> "dune", [ "exec"; exec.exec_path; "--" ] @ args
    | Unknown -> "ocaml", [ "-I"; "+str"; "-I"; "+unix"; exec.mod_path ] @ args
  in
  Sandbox.get_command sandbox program args `Exec
;;

let executable_choice_menu (execs : Dune_describe.executable list) =
  let choices =
    List.map
      ~f:(fun exec ->
        QuickPickItem.create ~label:exec.name ~detail:exec.exec_path (), exec)
      execs
  and options =
    QuickPickOptions.create
      ~canPickMany:false
      ~placeHolder:"Which executable do you want to run?"
      ()
  in
  Window.showQuickPickItems ~choices ~options ()
;;

let active_text_doc () =
  Window.activeTextEditor ()
  |> Option.bind ~f:(fun text_editor ->
    let doc = TextEditor.document text_editor in
    if String.(TextDocument.languageId doc = "ocaml")
    then (
      (* FIXME: This is fragile. We probably need to use [Node.Path] bindings here. *)
      let abs_path = TextDocument.uri doc |> Uri.path in
      match Workspace.rootPath () with
      | None -> Some (abs_path, doc)
      | Some root ->
        (match String.chop_prefix ~prefix:root abs_path with
         | None -> Some (abs_path, doc)
         | Some rel_path -> Some (rel_path, doc)))
    else None)
;;

let _run_file =
  let callback instance () =
    let open Promise.Syntax in
    let (_ : unit Promise.t) =
      let sandbox = Extension_instance.sandbox instance in
      OutputChannel.show ~preserveFocus:true (Lazy.force Output.run_output_channel) ();
      let* ctx = project_context () in
      let* result = find_executables sandbox ctx in
      match result with
      | None ->
        Promise.return (show_message `Error "Output parsing of dune describe failed")
      | Some executables ->
        let* selected = executable_choice_menu executables in
        (match selected with
         | None -> Promise.return ()
         | Some exec ->
           let* _ =
             match active_text_doc () with
             | Some (rel_path, doc) when String.(rel_path = exec.mod_path) ->
               TextDocument.save doc
             | _ -> Promise.return false
           in
           let cmd = exec_cmd sandbox ctx exec [] in
           let+ _ =
             Cmd.run
               ?cwd:(Sandbox.workspace_root ())
               ~output:Output.run_output_channel
               cmd
           in
           ())
    in
    ()
  in
  Extension_commands.register Command_api.Internal.run_file callback
;;

let register extension _instance =
  let disposable =
    Disposable.make ~dispose:(fun () ->
      Lazy.peek Output.run_output_channel |> Option.iter ~f:OutputChannel.dispose)
  in
  ExtensionContext.subscribe extension ~disposable
;;
