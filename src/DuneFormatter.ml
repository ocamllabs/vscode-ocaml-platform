open Import

let format (document : TextDocument.t) options token =
  let lastLine = document.lineCount - 1 in
  let lastCharacter =
    String.length (TextDocument.lineAt document lastLine).text
  in
  (* selects entire document range *)
  let fullDocumentRange =
    Range.make ~startLine:0 ~startCharacter:0 ~endLine:lastLine
      ~endCharacter:lastCharacter
  in
  (* text of entire document *)
  let documentText = TextDocument.getText document fullDocumentRange in

  ChildProcess.exec "dune format-dune-file" ~stdin:documentText
    (ChildProcess.Options.make ())
  |> Promise.map (function
       | Ok { ChildProcess.exitCode = 0; stdout; stderr } ->
         [| TextEdit.replace fullDocumentRange stdout |]
       | _ -> [||])

let formattingProvider : Languages.documentFormattingEditProvider =
  Languages.{ provideDocumentFormattingEdits = format }
