open Import
open Interop

module DebugCodeLens = struct
  include Class.Extend (CodeLens) ()

  let setCommand self command =
    Ojs.set_prop_ascii (t_to_js self) "command" (Command.t_to_js command)

  let make ~fileName ~range ~names =
    let command =
      Command.create ~title:"Debug"
        ~command:Extension_consts.Commands.debug_dune_executables
        ~arguments:
          [ Ojs.string_to_js fileName; Ojs.list_to_js Ojs.string_to_js names ]
        ()
    in
    let codeLens =
      CodeLens.make ~range ~command () |> CodeLens.t_to_js |> t_of_js
    in
    codeLens
end

module CodeLensProvider = CodeLensProvider.Make (DebugCodeLens)

let sexpRangeToVscodeRange range =
  let open Parsexp.Positions in
  Range.makeCoordinates ~startLine:(range.start_pos.line - 1)
    ~startCharacter:(range.start_pos.col - 1) ~endLine:(range.end_pos.line - 1)
    ~endCharacter:(range.end_pos.col - 1)

let getCodeLensProvider instance =
  ignore instance;
  let provideCodeLenses ~document ~token =
    ignore token;
    let codeLenses =
      Debugger.iterDebuggablesForTextDoc document
      |> Iter.map (fun (fileName, range, names) ->
             DebugCodeLens.make ~fileName
               ~range:(sexpRangeToVscodeRange range)
               ~names)
      |> Iter.to_list
    in
    `Value (Some codeLenses)
  in
  let resolveCodeLens ~codeLens ~token =
    ignore token;
    `Value (Some codeLens)
  in
  CodeLensProvider.create ~onDidChangeCodeLenses:None ~provideCodeLenses
    ~resolveCodeLens

let register extension instance =
  let registerDuneFileDebugCodeLensProvider () =
    let selector =
      `Filter (DocumentFilter.create ~scheme:"file" ~language:"dune" ())
    in
    let provider = getCodeLensProvider instance in
    let disposable =
      Languages.registerCodeLensProvider
        (module DebugCodeLens)
        ~selector ~provider
    in
    ExtensionContext.subscribe extension ~disposable
  in
  registerDuneFileDebugCodeLensProvider ()
