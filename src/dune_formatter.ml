open Import

let get_formatter instance ~document ~options:_ ~token:_ =
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
  match Extension_instance.toolchain instance with
  | None -> `Value None
  | Some toolchain ->
    let promise =
      let open Promise.Syntax in
      let* command =
        Toolchain.get_dune_command toolchain ~args:[ "format-dune-file" ]
      in
      let+ output =
        let open Promise.Result.Syntax in
        let* command = Cmd.check command in
        Cmd.output ~stdin:document_text command
      in
      match output with
      | Ok newText -> Some [ TextEdit.replace ~range ~newText ]
      | Error msg ->
        show_message `Error "Dune formatting failed: %s" msg;
        Some []
    in
    `Promise promise

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
