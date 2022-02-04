open Import

(** Controls whether to format dune files or not. *)
let format_setting =
  Settings.create_setting ~scope:Workspace ~key:"dune.format"
    ~of_json:Jsonoo.Decode.bool ~to_json:Jsonoo.Encode.bool

let get_formatter_unconditionally instance ~document =
  let endLine = TextDocument.lineCount document - 1 in
  let endCharacter =
    TextDocument.lineAt document ~line:endLine |> TextLine.text |> String.length
  in
  (* selects entire document range *)
  let range =
    Range.makeCoordinates ~startLine:0 ~startCharacter:0 ~endLine ~endCharacter
  in
  (* text of entire document *)
  let document_text = TextDocument.getText document ~range () in
  let command =
    let sandbox = Extension_instance.sandbox instance in
    Sandbox.get_command sandbox "dune" [ "format-dune-file" ]
  in
  let output =
    let open Promise.Result.Syntax in
    let* command = Cmd.check command in
    Cmd.output ~stdin:document_text command
  in
  let promise =
    let open Promise.Syntax in
    let+ output = output in
    match output with
    | Ok newText -> Some [ TextEdit.replace ~range ~newText ]
    | Error msg ->
      show_message `Error "Dune formatting failed: %s" msg;
      Some []
  in
  `Promise promise

let get_formatter instance ~document ~options:_ ~token:_ =
  let should_format =
    Option.value ~default:true (Settings.get ~section:"ocaml" format_setting)
  in
  if should_format then
    get_formatter_unconditionally instance ~document
  else
    `Promise (Promise.return None)

let register extension instance =
  [ "dune"; "dune-project"; "dune-workspace" ]
  |> List.map ~f:(fun language ->
         let selector =
           `Filter (DocumentFilter.create ~scheme:"file" ~language ())
         in
         let provider =
           DocumentFormattingEditProvider.create
             ~provideDocumentFormattingEdits:(get_formatter instance)
         in
         Languages.registerDocumentFormattingEditProvider ~selector ~provider)
  |> List.iter ~f:(fun disposable ->
         ExtensionContext.subscribe extension ~disposable)
