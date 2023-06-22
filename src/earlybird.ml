open Import

let debugType = Extension_consts.Debuggers.earlybird

let createDebugAdapterDescriptor ~instance ~session ~executable =
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
       (DebugAdapterExecutable.t_to_js result |> DebugAdapterDescriptor.t_of_js))

let register extension instance =
  let createDebugAdapterDescriptor = createDebugAdapterDescriptor ~instance in
  let factory =
    DebugAdapterDescriptorFactory.create ~createDebugAdapterDescriptor
  in
  let disposable =
    Debug.registerDebugAdapterDescriptorFactory ~debugType ~factory
  in
  ExtensionContext.subscribe extension ~disposable
