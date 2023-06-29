open Import

module VariableGetClosureCodeLocation = struct
  let command = "variableGetClosureCodeLocation"

  module Args = struct
    type t = { handle : int } [@@js]
  end

  module Result = struct
    type position = int * int [@@js]

    let position_to_vscode (line, character) =
      Position.make ~line:(line - 1) ~character:(character - 1)

    type range =
      { source : string
      ; pos : position
      ; end_ : position [@js "end_"]
      }
    [@@js]

    let range_to_vscode { pos; end_; _ } =
      let start = position_to_vscode pos in
      let end_ = position_to_vscode end_ in
      Range.makePositions ~start ~end_

    type t = { location : range option } [@@js]
  end
end

let debugType = Extension_consts.Debuggers.earlybird

let createDebugAdapterDescriptor ~instance ~session:_ ~executable:_ =
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
