open Import

let getFormatter toolchain ~document ~options:_ ~token:_ =
  let end_line = TextDocument.line_count document - 1 in
  let end_character =
    TextDocument.line_at document ~line:end_line
    |> TextLine.text |> String.length
  in
  (* selects entire document range *)
  let range =
    Range.make_coordinates ~start_line:0 ~start_character:0 ~end_line
      ~end_character
  in
  (* text of entire document *)
  let documentText = TextDocument.get_text document ~range () in
  let command = Toolchain.getDuneCommand toolchain [ "format-dune-file" ] in
  let output =
    let open Promise.Result.Syntax in
    Cmd.check command >>= fun command -> Cmd.output ~stdin:documentText command
  in
  let open Promise.Syntax in
  `Promise
    (output >>| function
     | Ok new_text -> Some [ TextEdit.replace ~range ~new_text ]
     | Error msg ->
       message `Error "Dune formatting failed: %s" msg;
       Some [])

type t = Disposable.t list ref

let create () = ref []

let register t toolchain =
  t :=
    [ "dune"; "dune-project"; "dune-workspace" ]
    |> List.map (fun language ->
           let selector =
             `Filter (DocumentFilter.create ~scheme:"file" ~language ())
           in
           let provider =
             DocumentFormattingEditProvider.create
               ~provide_document_formatting_edits:(getFormatter toolchain)
           in
           Languages.register_document_formatting_edit_provider ~selector
             ~provider)

let dispose t =
  List.iter Disposable.dispose !t;
  t := []
