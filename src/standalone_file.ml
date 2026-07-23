open Import

let active_document_uri () =
  match Window.activeTextEditor () with
  | None ->
    Error
      (Command_api.Command_errors.text_editor_must_be_active
         "Run standalone file"
         ~expl:"")
  | Some text_editor ->
    let doc = TextEditor.document text_editor in
    if String.(TextDocument.languageId doc = "ocaml")
    then (
      let abs_path = TextDocument.uri doc |> Uri.path in
      match Workspace.rootPath () with
      | None -> Ok (abs_path, doc)
      | Some root ->
        (match String.chop_prefix ~prefix:root abs_path with
         | None -> Ok (abs_path, doc)
         | Some rel_path -> Ok ("." ^ rel_path, doc)))
    else
      Error "The command \"OCaml: Run standalone file\" should be run only on OCaml file."
;;

let inside_dune_project () =
  Workspace.findFiles
    ~includes:(`String "**/{dune-project}")
    ~excludes:(`String "{**/_*}" (* ignoring dune files from _build, _opam, _esy *))
    ()
  |> Promise.map (function
    | [ _ ] -> true
    | _ -> false)
;;

let run_dune_exec_command sandbox =
  active_document_uri ()
  |> Result.map ~f:(fun (filename, _) ->
    let filename = Stdlib.Filename.remove_extension filename ^ ".exe" in
    Sandbox.get_command sandbox "dune" [ "exec"; filename ] `Exec)
;;

let run_program_command ~sandbox ?(args = []) program =
  Sandbox.get_command
    sandbox
    "ocaml"
    ([ "-I"; "+str"; "-I"; "+unix"; program ] @ args)
    `Exec
;;

let exec instance =
  match active_document_uri () with
  | Ok (program, doc) ->
    let open Promise.Syntax in
    let* _ : bool = TextDocument.save doc in
    let sandbox = Extension_instance.sandbox instance in
    OutputChannel.show ~preserveFocus:true (Lazy.force Output.run_output_channel) ();
    let* dune_context = inside_dune_project () in
    (match
       if dune_context
       then run_dune_exec_command sandbox
       else Ok (run_program_command ~sandbox program)
     with
     | Ok cmd ->
       let* command = Cmd.check cmd in
       (match command with
        | Ok cmd ->
          let+ _ =
            Cmd.run ?cwd:(Sandbox.workspace_root ()) ~output:Output.run_output_channel cmd
          in
          Ok ()
        | Error _ as err -> Promise.return err)
     | Error _ as err -> Promise.return err)
  | Error _ as err -> Promise.return err
;;

let _run_standalone_file =
  let callback (instance : Extension_instance.t) () =
    let open Promise.Syntax in
    let (_ : unit Promise.t) =
      let+ result = exec instance in
      Result.iter_error result ~f:(fun msg -> show_message `Error "%s" msg)
    in
    ()
  in
  Extension_commands.register Command_api.Internal.run_standalone_file callback
;;

let _ask_run_program =
  let callback (_ : Extension_instance.t) () =
    let open Promise.Syntax in
    let defaultUri =
      Workspace.rootPath () |> Option.map ~f:(fun path -> Uri.parse path ())
    in
    let options =
      OpenDialogOptions.create
        ~canSelectFiles:true
        ~canSelectFolders:false
        ~canSelectMany:false
        ?defaultUri
        ~filters:(Interop.Dict.singleton "OCaml file" [ "ml" ])
        ~openLabel:"Debug"
        ~title:"Run OCaml standalone file"
        ()
    in
    let+ uri = Window.showOpenDialog ~options () in
    match uri with
    | Some [ uri ] -> Some (Uri.fsPath uri)
    | _ -> None
  in
  Extension_commands.register Command_api.Internal.ask_run_program callback
;;

let debugType = "ocaml.run-standalone-file"

let register_provider () =
  let provider =
    DebugConfigurationProvider.create
      ~resolveDebugConfiguration:(fun ~folder:_ ~debugConfiguration ?token:_ () ->
        let config = DebugConfiguration.t_to_js debugConfiguration in
        if not (Ojs.has_property config "program")
        then (
          match active_document_uri () with
          | Ok (filename, _) ->
            DebugConfiguration.set debugConfiguration "program"
            @@ [%js.of: string] filename
          | Error msg -> show_message `Error "%s" msg);
        `Value (Some debugConfiguration))
      ()
  in
  Debug.registerDebugConfigurationProvider ~debugType ~provider ()
;;

let debug_executable_from_session ~instance ~session () =
  let config = DebugSession.configuration session |> DebugConfiguration.t_to_js in
  let program = [%js.to: string] (Ojs.get_prop_ascii config "program")
  and cwd = [%js.to: string] (Ojs.get_prop_ascii config "cwd")
  and args = [%js.to: string list] (Ojs.get_prop_ascii config "args") in
  let open Promise.Syntax in
  let sandbox = Extension_instance.sandbox instance in
  let+ command = run_program_command ~sandbox program ~args |> Cmd.check in
  match command with
  | Ok cmd ->
    let { Cmd.bin; args } = Cmd.to_spawn cmd in
    let options = DebugAdapterExecutableOptions.create ~cwd () in
    let adaptater =
      DebugAdapterExecutable.make ~command:(Path.to_string bin) ~args ~options ()
    in
    Some (`Executable adaptater)
  | Error _ -> None
;;

let register_debug_adapter_descr ~instance =
  let factory =
    DebugAdapterDescriptorFactory.create
      ~createDebugAdapterDescriptor:(fun ~session ~executable:_ ->
        `Promise (debug_executable_from_session ~instance ~session ()))
  in
  Debug.registerDebugAdapterDescriptorFactory ~debugType ~factory
;;

let register extension instance =
  let dispose_channel =
    Disposable.make ~dispose:(fun () ->
      Lazy.peek Output.run_output_channel |> Option.iter ~f:OutputChannel.dispose)
  and dispose_provider = register_provider ()
  and dispose_debug_adapter = register_debug_adapter_descr ~instance in
  ExtensionContext.subscribe
    extension
    ~disposable:
      (Disposable.from [ dispose_channel; dispose_debug_adapter; dispose_provider ])
;;
