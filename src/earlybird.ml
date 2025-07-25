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
    ;;

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
    ;;

    type t = { location : range option } [@@js]
  end
end

let debugType = "ocaml.earlybird"

let check_earlybird_available sandbox =
  let earlybird_help =
    (* earlybird <= 1.1.0 doesn't have --version *)
    Sandbox.get_command sandbox "ocamlearlybird" [ "--help" ]
  in
  Cmd.output earlybird_help
  |> Promise.Result.fold
       ~ok:(fun (_ : string) -> ())
       ~error:(fun (_ : string) ->
         "Debugging failed: `earlybird` is not installed in the current sandbox.\n\n\
          Hint: $ opam install earlybird")
;;

let createDebugAdapterDescriptor ~instance ~session:_ ~executable:_ =
  let sandbox = Extension_instance.sandbox instance in
  let promise =
    let open Promise.Syntax in
    let* res = check_earlybird_available sandbox in
    match res with
    | Ok () ->
      let command = Sandbox.get_command sandbox "ocamlearlybird" [ "debug" ] in
      let { Cmd.bin; args } = Cmd.to_spawn command in
      let result = DebugAdapterExecutable.make ~command:(Path.to_string bin) ~args () in
      Promise.return (Some (`Executable result))
    | Error s -> Promise.reject @@ [%js.of: string] s
  in
  `Promise promise
;;

module Command = struct
  let _ask_debug_program =
    let callback (_ : Extension_instance.t) () =
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
      result
    in
    Extension_commands.register Command_api.Internal.ask_debug_program callback
  ;;

  let _start_debugging =
    let callback (_ : Extension_instance.t) resourceUri =
      let resourceUri =
        match resourceUri with
        | Some resourceUri -> Some resourceUri
        | None ->
          Option.map (Window.activeTextEditor ()) ~f:(fun textEditor ->
            TextDocument.uri (TextEditor.document textEditor))
      in
      match resourceUri with
      | Some uri ->
        let folder = Workspace.getWorkspaceFolder ~uri in
        let fsPath = Uri.fsPath uri in
        let name = Path.basename (Path.of_string fsPath) ^ " (experimental)" in
        let config = DebugConfiguration.create ~name ~type_:debugType ~request:"launch" in
        DebugConfiguration.set config "program" @@ [%js.of: string] fsPath;
        DebugConfiguration.set config "stopOnEntry" @@ [%js.of: bool] true;
        let (_ : bool Promise.t) =
          Debug.startDebugging ~folder ~nameOrConfiguration:(`Configuration config) ()
        in
        ()
      | None ->
        let _ = Window.showErrorMessage ~message:"No active resource" () in
        ()
    in
    Extension_commands.register Command_api.Internal.start_debugging callback
  ;;

  let _goto_closure_code_location =
    let callback (_ : Extension_instance.t) context =
      let open Promise.Syntax in
      match Debug.activeDebugSession () with
      | Some debugSession ->
        let variablesReference =
          Jsonoo.Decode.(at [ "variable"; "variablesReference" ] int context)
        in
        let args =
          [%js.of: VariableGetClosureCodeLocation.Args.t] { handle = variablesReference }
        in
        let (_ : unit Promise.t) =
          let* result =
            DebugSession.customRequest
              debugSession
              ~command:VariableGetClosureCodeLocation.command
              ~args
              ()
          in
          let result = [%js.to: VariableGetClosureCodeLocation.Result.t] result in
          match result.location with
          | Some range ->
            let* text_document = Workspace.openTextDocument (`Filename range.source) in
            let selection = VariableGetClosureCodeLocation.Result.range_to_vscode range in
            let+ _ =
              Window.showTextDocument'
                ~document:(`TextDocument text_document)
                ~options:(TextDocumentShowOptions.create ~preview:true ~selection ())
                ()
            in
            ()
          | None ->
            let+ _ =
              Window.showInformationMessage ~message:"No closure code location" ()
            in
            ()
        in
        ()
      | None ->
        let _ = Window.showErrorMessage ~message:"No active debug session" () in
        ()
    in
    Extension_commands.register Command_api.Internal.goto_closure_code_location callback
  ;;
end

let register extension instance =
  let createDebugAdapterDescriptor = createDebugAdapterDescriptor ~instance in
  let factory = DebugAdapterDescriptorFactory.create ~createDebugAdapterDescriptor in
  let disposable = Debug.registerDebugAdapterDescriptorFactory ~debugType ~factory in
  ExtensionContext.subscribe extension ~disposable
;;
