open Import

let iterDebuggablesForTextDoc textDoc =
  let iterExecutableSexps sexps f =
    let open Sexp_with_pos in
    let hasByteMode body =
      let isByteMode = function
        | Atom ("byte", _) -> true
        | _ -> false
      in
      let checkModes = function
        | List (Atom ("modes", _) :: modes, _) ->
          List.exists modes ~f:isByteMode
        | _ -> false
      in
      List.exists body ~f:checkModes
    in
    let iterNameString f name =
      match name with
      | Atom (name, _) -> f name
      | _ -> ()
    in
    List.iter sexps ~f:(function
      | List (Atom ("executable", range) :: body, _) when hasByteMode body ->
        let iterNameSexp body f =
          List.iter body ~f:(function
            | List ([ Atom ("name", _); name ], _) -> iterNameString f name
            | _ -> ())
        in
        f (range, iterNameSexp body |> Iter.to_list)
      | List (Atom ("executables", range) :: body, _) when hasByteMode body ->
        let iterNameSexp body f =
          List.iter body ~f:(function
            | List (Atom ("names", _) :: names, _) ->
              List.iter names ~f:(iterNameString f)
            | _ -> ())
        in
        f (range, iterNameSexp body |> Iter.to_list)
      | _ -> ())
  in
  let document_text = TextDocument.getText textDoc () in
  let fileName = TextDocument.fileName textDoc in
  let sexps, positions =
    Parsexp.Many_and_positions.parse_string_exn document_text
  in
  let positions = Parsexp.Positions.to_list positions in
  let sexps, _ = Sexp_with_pos.annotate_many sexps positions in
  iterExecutableSexps sexps
  |> Iter.map (fun (range, names) -> (fileName, range, names))

let findDebuggablesForWorkspace token =
  let open Promise.Syntax in
  let excludes =
    (* ignoring dune files from _build, _opam, _esy *)
    `String "{**/_*}"
  in
  let includes = `String "**/dune" in
  let* dunes = Workspace.findFiles ~includes ~excludes ~token () in
  let debuggables = ref [] in
  let* () =
    List.fold dunes
      ~f:(fun promise dune ->
        let* () = promise in
        let* doc = Workspace.openTextDocument (`Uri dune) in
        iterDebuggablesForTextDoc doc
        |> Iter.iter (fun (fileName, _range, names) ->
               List.iter names ~f:(fun name ->
                   debuggables := (fileName, name) :: !debuggables));
        Promise.return ())
      ~init:(Promise.return ())
  in
  Promise.return !debuggables

let askInstallEarlybird instance =
  let sandbox = Extension_instance.sandbox instance in
  let open Promise.Syntax in
  with_confirmation
    "Earlybird is required to debug bytecode. Would you like to install it to \
     continue debugging?"
    ~yes:"Install" (fun () ->
      let* _ = Sandbox.install_packages sandbox [ "earlybird" ] in
      Promise.return ())

let checkInstallEarlybird instance =
  let open Promise.Syntax in
  let sandbox = Extension_instance.sandbox instance in
  let* packages = Sandbox.packages sandbox in
  let packages = packages |> Result.ok |> Option.value ~default:[] in
  let isEarlybird pkg = String.equal (Sandbox.Package.name pkg) "earlybird" in
  if List.is_empty packages || List.exists packages ~f:isEarlybird then
    Promise.return ()
  else
    askInstallEarlybird instance

let startDebuggingDuneExecutable instance duneFile executable =
  ignore instance;
  let open Promise.Syntax in
  let folder = Workspace.getWorkspaceFolder ~uri:(Uri.file duneFile) in
  let config =
    Ojs.obj
      [| ("type", Ojs.string_to_js "ocaml.dune-executable")
       ; ("request", Ojs.string_to_js "launch")
       ; ("name", Ojs.string_to_js executable)
       ; ("duneFile", Ojs.string_to_js duneFile)
       ; ("executable", Ojs.string_to_js executable)
      |]
  in
  let* _ = Vscode.Debug.startDebugging ~folder ~nameOrConfiguration:config () in
  Promise.return ()

let register extension instance =
  let registerDebugDuneExecutableConfigurationProvider () =
    let provideDebugConfigurations ~folder:_ ~token =
      let promise =
        let open Promise.Syntax in
        let* debuggables = findDebuggablesForWorkspace token in
        let configs =
          List.map debuggables ~f:(fun (fileName, name) ->
              Ojs.obj
                [| ("type", Ojs.string_to_js "ocaml.dune-executable")
                 ; ("request", Ojs.string_to_js "launch")
                 ; ("name", Ojs.string_to_js name)
                 ; ("duneFile", Ojs.string_to_js fileName)
                 ; ("executable", Ojs.string_to_js name)
                |])
        in
        Promise.return (Some configs)
      in
      `Promise promise
    in
    let resolveDebugConfiguration ~folder:_ ~debugConfiguration ~token:_ =
      let promise =
        let open Promise.Syntax in
        let* () = checkInstallEarlybird instance in
        if not (Ojs.has_property debugConfiguration "workspaceDir") then
          Ojs.set_prop_ascii debugConfiguration "workspaceDir"
            (Ojs.string_to_js "${workspaceFolder}");
        if not (Ojs.has_property debugConfiguration "buildDir") then
          Ojs.set_prop_ascii debugConfiguration "buildDir"
            (Ojs.string_to_js "_build");
        if not (Ojs.has_property debugConfiguration "context") then
          Ojs.set_prop_ascii debugConfiguration "context"
            (Ojs.string_to_js "default");
        Promise.return (Some debugConfiguration)
      in
      `Promise promise
    in
    let resolveDebugConfigurationWithSubstitutedVariables ~folder:_
        ~debugConfiguration ~token:_ =
      let workspaceDir =
        Ojs.get_prop_ascii debugConfiguration "workspaceDir" |> Ojs.string_of_js
      in
      let buildDir =
        Ojs.get_prop_ascii debugConfiguration "buildDir" |> Ojs.string_of_js
      in
      let context =
        Ojs.get_prop_ascii debugConfiguration "context" |> Ojs.string_of_js
      in
      let duneFile =
        Ojs.get_prop_ascii debugConfiguration "duneFile" |> Ojs.string_of_js
      in
      let executable =
        Ojs.get_prop_ascii debugConfiguration "executable" |> Ojs.string_of_js
      in
      let bytecodeFile =
        Path.(
          of_string workspaceDir / buildDir / context
          / (Node.Path.relative ~from:workspaceDir ~to_:duneFile
            |> Node.Path.dirname)
          / (executable ^ ".bc")
          |> to_string)
      in
      let config =
        Ojs.iter_properties debugConfiguration
        |> Iter.filter (fun prop ->
               not
                 (List.mem
                    [ "type"
                    ; "workspaceDir"
                    ; "buildDir"
                    ; "context"
                    ; "duneFile"
                    ; "executable"
                    ]
                    prop ~equal:String.equal))
        |> Iter.map (fun prop ->
               (prop, Ojs.get_prop_ascii debugConfiguration prop))
        |> Iter.to_array |> Ojs.obj
      in
      Ojs.set_prop_ascii config "type" (Ojs.string_to_js "ocaml");
      Ojs.set_prop_ascii config "program" (Ojs.string_to_js bytecodeFile);
      `Value (Some config)
    in
    let provider =
      DebugConfigurationProvider.create ~provideDebugConfigurations
        ~resolveDebugConfiguration
        ~resolveDebugConfigurationWithSubstitutedVariables
    in
    let disposable =
      Vscode.Debug.registerDebugConfigurationProvider
        ~debugType:"ocaml.dune-executable" ~provider
        ~triggerKind:DebugConfigurationProviderTriggerKind.Dynamic ()
    in
    ExtensionContext.subscribe extension ~disposable
  in
  let registerDebugAdapterDescriptorFactory ~debugType =
    let createDebugAdapterDescriptor ~session ~executable =
      ignore session;
      ignore executable;
      let sandbox = Extension_instance.sandbox instance in
      let cmd = Sandbox.get_command sandbox "ocamlearlybird" [ "debug" ] in
      let bin, args =
        match cmd with
        | Cmd.Spawn { bin; args } -> (Path.to_string bin, args)
        | _ -> assert false
        (* Custom sandbox is not supported *)
      in
      let result = DebugAdapterExecutable.make ~command:bin ~args () in
      `Value
        (Some
           (DebugAdapterExecutable.t_to_js result
           |> DebugAdapterDescriptor.t_of_js))
    in
    let factory =
      DebugAdapterDescriptorFactory.create ~createDebugAdapterDescriptor
    in
    let disposable =
      Debug.registerDebugAdapterDescriptorFactory ~debugType ~factory
    in
    ExtensionContext.subscribe extension ~disposable
  in
  registerDebugAdapterDescriptorFactory ~debugType:"ocaml";
  registerDebugDuneExecutableConfigurationProvider ()
