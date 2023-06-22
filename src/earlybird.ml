open Import

let debugType = Extension_consts.Debuggers.earlybird

let provideDebugConfigurations ~folder:_ ~token:_ =
  let promise =
    let configs =
      [ Ojs.obj
            [| ("name", Ojs.string_to_js "OCaml Debug")
              ; ("type", Ojs.string_to_js Extension_consts.Debuggers.earlybird)
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

let resolveDebugConfiguration ~folder:_ ~debugConfiguration ~token:_ =
  let promise =
    let debugConfiguration =
      if Ojs.has_property debugConfiguration "type" then
        debugConfiguration
      else (
        Ojs.obj
            [| ("name", Ojs.string_to_js "${fileBasename}")
              ; ("type", Ojs.string_to_js Extension_consts.Debuggers.earlybird)
              ; ("request", Ojs.string_to_js "launch")
              ; ("program", Ojs.string_to_js "${file}")
            |]
      )
    in
    Promise.return (Some debugConfiguration)
  in
  `Promise promise

let resolveDebugConfigurationWithSubstitutedVariables ~folder:_
    ~debugConfiguration ~token:_ =
  `Value (Some debugConfiguration)

let createDebugAdapterDescriptor ~instance ~session ~executable =
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

let register extension instance =
  let provider =
    DebugConfigurationProvider.create ~provideDebugConfigurations
      ~resolveDebugConfiguration
      ~resolveDebugConfigurationWithSubstitutedVariables
  in
  let disposable =
    Debug.registerDebugConfigurationProvider
      ~debugType ~provider
      ~triggerKind:DebugConfigurationProviderTriggerKind.Initial ()
  in
  ExtensionContext.subscribe extension ~disposable;

  let createDebugAdapterDescriptor = createDebugAdapterDescriptor ~instance in
  let factory =
    DebugAdapterDescriptorFactory.create ~createDebugAdapterDescriptor
  in
  let disposable =
    Debug.registerDebugAdapterDescriptorFactory ~debugType ~factory
  in
  ExtensionContext.subscribe extension ~disposable
