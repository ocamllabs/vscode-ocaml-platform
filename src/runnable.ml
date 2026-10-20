open Import

type context = Describe_parser.context =
  | Dune
  | Unknown

let project_context () =
  Workspace.findFiles
    ~includes:(`String "**/{dune-project}")
    ~excludes:(`String "{**/_*}" (* ignoring dune files from _build, _opam, _esy *))
    ()
  |> Promise.map Describe_parser.context_of_dune_project_files
;;

let find_executables sandbox project_ctx =
  let open Promise.Syntax in
  match project_ctx with
  | Dune ->
    let cwd =
      Option.value_map
        (Sandbox.workspace_root ())
        ~default:(Process.cwd ())
        ~f:Path.to_string
    in
    let+ { ChildProcess.stdout; _ } =
      Dune_describe.command sandbox |> Cmd.run ~cwd:(Path.of_string cwd)
    in
    Parsexp.Conv_single.parse_string stdout Dune_describe.parse_executables
    |> Stdlib.Result.to_option
    |> Option.join
    |> Option.map
         ~f:
           (List.map ~f:(fun (exec : Dune_describe.executable) ->
              { exec with mod_path = Node.Path.join [ cwd; exec.mod_path ] }))
  | Unknown ->
    let+ ml_files =
      Workspace.findFiles
        ~includes:(`String "**/*.ml")
        ~excludes:(`String "{**/_*}" (* ignoring ml files from _build, _opam, _esy *))
        ()
    in
    Some
      (Describe_parser.executables_of_ml_files (List.map ml_files ~f:Uri.fsPath))
;;

let exec_cmd project_ctx exec args = Describe_parser.command_line project_ctx exec args
;;

let active_text_doc () =
  Window.activeTextEditor ()
  |> Option.bind ~f:(fun text_editor ->
    let doc = TextEditor.document text_editor in
    if String.(TextDocument.languageId doc = "ocaml")
    then Some (Uri.fsPath (TextDocument.uri doc), doc)
    else None)
;;

let executable_choice_menu (execs : Dune_describe.executable list) =
  let text_doc = active_text_doc () in
  let choices =
    List.map
      ~f:(fun exec ->
        let is_current_doc =
          match text_doc with
          | None -> false
          | Some (path, _) -> String.equal path exec.mod_path
        in
        ( QuickPickItem.create
            ~label:exec.name
            ~detail:exec.exec_path
            ~alwaysShow:is_current_doc
            ()
        , exec ))
      execs
  and options =
    QuickPickOptions.create
      ~placeHolder:"Which executable do you want to run?"
      ~canPickMany:false
      ~matchOnDetail:true
      ()
  in
  Window.showQuickPickItems ~choices ~options ()
;;

let terms_tbl : (string, Terminal_sandbox.t) Hashtbl.t = Hashtbl.create (module String)

let spawn_term sandbox exec =
  let term =
    Terminal_sandbox.create
      ~name:(sprintf {|Run "%s"|} exec.Dune_describe.mod_path)
      sandbox
  in
  let _ = Hashtbl.add terms_tbl ~key:exec.mod_path ~data:term in
  term
;;

let _run_file =
  let callback instance () =
    let open Promise.Syntax in
    let (_ : unit Promise.t) =
      let sandbox = Extension_instance.sandbox instance in
      let* ctx = project_context () in
      let* result = find_executables sandbox ctx in
      match result with
      | None ->
        Promise.return (show_message `Error "Output parsing of dune describe failed")
      | Some executables ->
        let+ selected = executable_choice_menu executables in
        (match selected with
         | None -> ()
         | Some exec ->
           let _ =
             match active_text_doc () with
             | Some (rel_path, doc) when String.(rel_path = exec.mod_path) ->
               TextDocument.save doc
             | _ -> Promise.return false
           in
           let term =
             match Hashtbl.find terms_tbl exec.mod_path with
             | None -> spawn_term sandbox exec
             | Some previous when Option.is_some (Terminal.exitStatus previous) ->
               spawn_term sandbox exec
             | Some term -> term
           in
           let command = exec_cmd ctx exec [] in
           Terminal_sandbox.show ~preserveFocus:true term;
           Terminal_sandbox.send term command)
    in
    ()
  in
  Extension_commands.register Command_api.Internal.run_file callback
;;

let register extension _instance =
  let disposable =
    Disposable.make ~dispose:(fun () ->
      Hashtbl.iter ~f:Terminal_sandbox.dispose terms_tbl)
  in
  ExtensionContext.subscribe extension ~disposable
;;
