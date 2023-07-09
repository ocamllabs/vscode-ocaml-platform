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
  let command = Sandbox.get_command sandbox "ocamlearlybird" [ "debug" ] in
  let { Cmd.bin; args } = Cmd.to_spawn command in
  let result =
    DebugAdapterExecutable.make ~command:(Path.to_string bin) ~args ()
  in
  `Value (Some (`Executable result))

let register extension instance =
  let createDebugAdapterDescriptor = createDebugAdapterDescriptor ~instance in
  let factory =
    DebugAdapterDescriptorFactory.create ~createDebugAdapterDescriptor
  in
  let disposable =
    Debug.registerDebugAdapterDescriptorFactory ~debugType ~factory
  in
  ExtensionContext.subscribe extension ~disposable;

  let callback ~args:_ =
    let open Promise.Syntax in
    let defaultUri =
      Option.map (Workspace.rootPath ()) ~f:(fun path -> Uri.parse path ())
    in
    let filters = Interop.Dict.singleton "OCaml Bytecode Executable" [ "bc" ] in
    let options =
      OpenDialogOptions.create
        ~canSelectFiles:true
        ~canSelectFolders:false
        ~canSelectMany:false
        ?defaultUri
        ~filters
        ~openLabel:"Debug"
        ~title:"OCaml earlybird (experimental)"
        ()
    in
    let result =
      let+ uri = Window.showOpenDialog ~options () in
      match uri with
      | Some [ uri ] -> Some (Uri.fsPath uri)
      | _ -> None
    in
    [%js.of: string option Promise.t] result
  in
  let disposable =
    Commands.registerCommandReturn
      ~command:Extension_consts.Commands.ask_debug_program
      ~callback
  in
  ExtensionContext.subscribe extension ~disposable
