open Import

let format (document : TextDocument.t) (options : Workspace.formattingOptions)
    (token : Workspace.cancellationToken) =
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

  let newline =
    if document.eol = EndOfLine.crlf then
      "\r\n"
    else
      "\n"
  in

  (* return the indentation string for a given depth *)
  let indent depth =
    if depth <= 0 then
      ""
    else if options.insertSpaces then
      String.make (depth * options.tabSize) ' '
    else
      String.make depth '\t'
  in

  (* depth of parentheses *)
  let depth = ref 0 in

  (* update the depth offset based on the type of parenthesis *)
  let updateDepth = function
    | '(' -> incr depth
    | ')' -> decr depth
    | _ -> ()
  in

  (* format each line by
     inserting the correct amount of indentation and
     trimming excess whitespace *)
  let rec formatLines acc = function
    | [] -> List.rev acc
    | line :: lines when String.trim line = "" -> formatLines ("" :: acc) lines
    | line :: lines ->
      let formatted = indent !depth ^ String.trim line in
      String.iter updateDepth line;
      formatLines (formatted :: acc) lines
  in

  let formatted =
    documentText |> String.split_on_char '\n' |> formatLines []
    |> String.concat newline
  in
  Promise.resolve [| TextEdit.replace fullDocumentRange formatted |]

let formattingProvider : Languages.documentFormattingEditProvider =
  Languages.{ provideDocumentFormattingEdits = format }
