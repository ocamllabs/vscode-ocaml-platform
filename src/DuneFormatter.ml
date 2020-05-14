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

  Cmd.make ~cmd:(Path.ofString "dune") ()
  |> Promise.Result.bind (fun duneCmd ->
         Cmd.output duneCmd
           ~args:[| "format-dune-file"; document.fileName |]
           ~stdin:documentText)
  |> Promise.map (function
       | Ok stdout -> [| TextEdit.replace fullDocumentRange stdout |]
       | Error _ -> [||])

let formattingProvider : Languages.documentFormattingEditProvider =
  Languages.{ provideDocumentFormattingEdits = format }
