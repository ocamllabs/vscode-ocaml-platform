open Import

let get_formatter toolchain ~document ~options:_ ~token:_ =
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
  let command = Toolchain.get_dune_command toolchain [ "format-dune-file" ] in
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

type t = Disposable.t list ref

let create () = ref []

let register t toolchain =
  t :=
    [ "dune"; "dune-project"; "dune-workspace" ]
    |> List.map ~f:(fun language ->
           let selector =
             `Filter (DocumentFilter.create ~scheme:"file" ~language ())
           in
           let provider =
             DocumentFormattingEditProvider.create
               ~provideDocumentFormattingEdits:(get_formatter toolchain)
           in
           Languages.registerDocumentFormattingEditProvider ~selector ~provider)

let dispose t =
  List.iter ~f:Disposable.dispose !t;
  t := []
