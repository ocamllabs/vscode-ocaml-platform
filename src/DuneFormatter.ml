open Import

let getFormatter toolchain =
 fun [@bs] (document : TextDocument.t) _options _token ->
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
  let command = Toolchain.getDuneCommand toolchain [ "format-dune-file" ] in
  let output =
    let open Promise.Result.O in
    Cmd.check command >>= fun command -> Cmd.output ~stdin:documentText command
  in
  let open Promise.O in
  output >>| function
  | Ok stdout -> [| TextEdit.replace fullDocumentRange stdout |]
  | Error msg ->
    message `Error "Dune formatting failed: %s" msg;
    [||]

type t = Disposable.t list ref

let create () = ref []

let register t toolchain =
  t :=
    [ "dune"; "dune-project"; "dune-workspace" ]
    |> List.map (fun language ->
           let open Vscode.Languages in
           registerDocumentFormattingEditProvider
             { language; scheme = "file" }
             { provideDocumentFormattingEdits = getFormatter toolchain })

let dispose t =
  List.iter Disposable.dispose !t;
  t := []
