open Import

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
    let provideDebugConfigurations ~folder:_ ~token:_ =
      let promise =
        let configs =
          [ Ojs.obj
                [| ("name", Ojs.string_to_js "OCaml Debug")
                 ; ("type", Ojs.string_to_js "ocamlearlybird")
                 ; ("request", Ojs.string_to_js "launch")
                 ; ("program", Ojs.string_to_js "${workspaceFolder}/a.out")
                 ; ("stopOnEntry", Ojs.bool_to_js false)
                 ; ("yieldSteps", Ojs.int_to_js 4096)
                 ; ("onlyDebugGlob", Ojs.string_to_js "<${workspaceFolder}/**/*>")
                |]
          ]
        in
        Promise.return (Some configs)
      in
      `Promise promise
    in
    let resolveDebugConfiguration ~folder:_ ~debugConfiguration ~token:_ =
      let promise =
        let debugConfiguration =
          if Ojs.has_property debugConfiguration "type" then
            debugConfiguration
          else (
            Ojs.obj
                [| ("name", Ojs.string_to_js "${fileBasename}")
                 ; ("type", Ojs.string_to_js "ocamlearlybird")
                 ; ("request", Ojs.string_to_js "launch")
                 ; ("program", Ojs.string_to_js "${file}")
                |]
          )
        in
        Promise.return (Some debugConfiguration)
      in
      `Promise promise
    in
    let resolveDebugConfigurationWithSubstitutedVariables ~folder:_
        ~debugConfiguration ~token:_ =
      `Value (Some debugConfiguration)
    in
    let provider =
      DebugConfigurationProvider.create ~provideDebugConfigurations
        ~resolveDebugConfiguration
        ~resolveDebugConfigurationWithSubstitutedVariables
    in
    let disposable =
      Vscode.Debug.registerDebugConfigurationProvider
        ~debugType:"ocamlearlybird" ~provider
        ~triggerKind:DebugConfigurationProviderTriggerKind.Initial ()
    in
    ExtensionContext.subscribe extension ~disposable
  in
  let registerDebugAdapterDescriptorFactory ~debugType =
    let createDebugAdapterDescriptor ~session ~executable =
      ignore session;
      ignore executable;
      (* TODO: connectToLocalDebugAdapterServer *)
      let sandbox = Extension_instance.sandbox instance in
      (* TODO: ocamlearlybirdPath *)
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
  registerDebugAdapterDescriptorFactory ~debugType:"ocamlearlybird";
  registerDebugDuneExecutableConfigurationProvider ()
