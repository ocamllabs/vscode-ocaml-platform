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

let decorationType =
  let options =
    DecorationRenderOptions.create ~backgroundColor:(`String "#e0234c") ()
  in
  Window.createTextEditorDecorationType ~options

let current_cursor_pos text_editor =
  let selection = TextEditor.selection text_editor in
  Selection.active selection

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
        let () =
          let _range =
            let cursor = current_cursor_pos text_editor in
            Range.makePositions ~start:cursor ~end_:cursor
          in
          let range = Selection.to_range s in
          let decorationOptions =
            let renderOptions =
              let before =
                ThemableDecorationAttachmentRenderOptions.create
                  ~backgroundColor:(`String "white")
                  ~border:"1px solid black"
                  ~contentText:results.type_
                  ~textDecoration:
                    "none;position:absolute;z-index:1;bottom:100%;padding:0.3em"
                  ()
              in
              let options =
                ThemableDecorationInstanceRenderOptions.create ~before ()
              in
              Some
                (DecorationInstanceRenderOptions.create
                   ~light:options
                   ~dark:options
                   ())
            in
            DecorationOptions.create
              ~range
              ~hoverMessage:
                (`MarkdownString (MarkdownString.make ~value:"POUET DBG" ()))
              ~renderOptions
              ()
          in
          let rangesOrOptions = `Options [ decorationOptions ] in
          TextEditor.setDecorations text_editor ~decorationType ~rangesOrOptions
        in
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
