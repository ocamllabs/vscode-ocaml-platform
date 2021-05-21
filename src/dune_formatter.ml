open Import

let get_formatter instance ~document ~options:_ ~token:_ =
  let end_line = Text_document.line_count document - 1 in
  let end_character =
    Text_document.line_at document end_line |> Text_line.text |> String.length
  in
  (* selects entire document range *)
  let range =
    Range.make_coordinates ~start_line:0 ~start_character:0 ~end_line
      ~end_character
  in
  (* text of entire document *)
  let document_text = Text_document.get_text document ~range () in
  let command =
    let sandbox = Extension_instance.sandbox instance in
    Sandbox.get_dune_command sandbox [ "format-dune-file" ]
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
    | Ok new_text -> Some [ Text_edit.replace ~range ~new_text ]
    | Error msg ->
      show_message `Error "Dune formatting failed: %s" msg;
      Some []
  in
  `Promise promise

let register extension instance =
  [ "dune"; "dune-project"; "dune-workspace" ]
  |> List.map ~f:(fun language ->
         let selector =
           `Filter (Document_filter.create ~scheme:"file" ~language ())
         in
         let provider =
           Document_formatting_edit_provider.create
             ~provide_document_formatting_edits:(get_formatter instance)
         in
         Languages.register_document_formatting_edit_provider ~selector
           ~provider)
  |> List.iter ~f:(fun disposable ->
         Extension_context.subscribe extension disposable)
