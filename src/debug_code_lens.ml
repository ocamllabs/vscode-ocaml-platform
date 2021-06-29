open Import
open Interop

module DebugCodeLens = struct
  include Class.Extend (CodeLens) ()

  let name self = Ojs.get_prop_ascii (t_to_js self) "name" |> Ojs.string_of_js

  let setCommand self command =
    Ojs.set_prop_ascii (t_to_js self) "command" (Command.t_to_js command)

  let make ~name ~range =
    let codeLens = CodeLens.make ~range () |> CodeLens.t_to_js |> t_of_js in
    Ojs.set_prop_ascii (t_to_js codeLens) "_name" (Ojs.string_to_js name);
    codeLens
end

module CodeLensProvider = CodeLensProvider.Make (DebugCodeLens)

let iterExecutableNameSexps sexps f =
  let open Sexp_with_pos in
  let f range name =
    match name with
    | Atom (name, _) -> f (name, range)
    | _ -> ()
  in
  List.iter sexps ~f:(function
    | List (Atom ("executable", range) :: body, _) ->
      List.iter body ~f:(function
        | List ([ Atom ("name", _); name ], _) -> f range name
        | _ -> ())
    | List (Atom ("executables", range) :: body, _) ->
      List.iter body ~f:(function
        | List (Atom ("names", _) :: names, _) -> List.iter ~f:(f range) names
        | _ -> ())
    | _ -> ())

let sexpRangeToVscodeRange range =
  let open Parsexp.Positions in
  Range.makeCoordinates ~startLine:(range.start_pos.line - 1)
    ~startCharacter:(range.start_pos.col - 1) ~endLine:(range.end_pos.line - 1)
    ~endCharacter:(range.end_pos.col - 1)

let executableNameToCodeLens (name, range) =
  DebugCodeLens.make ~name ~range:(sexpRangeToVscodeRange range)

let getCodeLensProvider instance =
  ignore instance;
  let provideCodeLenses ~document ~token =
    ignore token;
    let document_text = TextDocument.getText document () in
    let sexps, positions =
      Parsexp.Many_and_positions.parse_string_exn document_text
    in
    let positions = Parsexp.Positions.to_list positions in
    let sexps, _ = Sexp_with_pos.annotate_many sexps positions in
    let codeLenses =
      iterExecutableNameSexps sexps
      |> Iter.map executableNameToCodeLens
      |> Iter.to_list
    in
    `Value (Some codeLenses)
  in
  let resolveCodeLens ~codeLens ~token =
    ignore token;
    (* let name = DebugCodeLens.name codeLens in *)
    let command =
      Command.create ~title:"Run"
        ~command:Extension_consts.Commands.debug_dune_executable ()
    in
    DebugCodeLens.setCommand codeLens command;
    `Value (Some codeLens)
  in
  CodeLensProvider.create ~onDidChangeCodeLenses:None ~provideCodeLenses
    ~resolveCodeLens

let register extension instance =
  let registerDuneFileDebugCodeLensProvider extension instance =
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
  registerDuneFileDebugCodeLensProvider extension instance
