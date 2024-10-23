open Import

let get_enclosings text_editor selection client =
  let doc = TextEditor.document text_editor in
  let uri = TextDocument.uri doc in
  Custom_requests.(
    send_request
      client
      Type_enclosing.request
      (Type_enclosing.make
         ~uri
         ~at:(`Range (Selection.to_range selection))
         ~index:0
         ~verbosity:0))

let onDidChangeTextEditorSelection_listener instance event =
  match Extension_instance.lsp_client instance with
  | None -> show_message `Info "NO SERVER"
  | Some (client, _) -> (
    let text_editor = TextEditorSelectionChangeEvent.textEditor event in
    let selection = TextEditorSelectionChangeEvent.selections event in
    let kind = TextEditorSelectionChangeEvent.kind event in
    match (kind, selection) with
    | Command, [ s ] when not (Selection.isEmpty s) ->
      let _show_type =
        let open Promise.Syntax in
        let+ results = get_enclosings text_editor s client in
        show_message `Info "Selection has type: %s" results.type_
      in
      ()
    | _ -> ())

let register extension instance =
  let disposable =
    let listener event =
      let listener = onDidChangeTextEditorSelection_listener instance in
      Handlers.unpwrap (Handlers.w1 listener event)
    in
    Window.onDidChangeTextEditorSelection () ~listener ()
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
