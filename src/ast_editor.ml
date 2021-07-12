open Import

let webview_map = ref (Map.empty (module String))

let read_html_file () =
  let filename = Node.__dirname () ^ "/../astexplorer/dist/index.html" in
  Fs.readFile filename

let doc_string_uri ~document = Uri.toString (TextDocument.uri document) ()

let document_eq a b =
  String.equal
    (Uri.toString (TextDocument.uri a) ())
    (Uri.toString (TextDocument.uri b) ())

let send_msg t value ~(webview : WebView.t) =
  let msg = Ojs.empty_obj () in
  Ojs.set_prop_ascii msg "type" (Ojs.string_to_js t);
  Ojs.set_prop_ascii msg "value" value;
  let _ = WebView.postMessage webview msg in
  ()

let transform_to_ast ~(document : TextDocument.t) ~(webview : WebView.t) =
  let open Jsonoo.Encode in
  let ast_js =
    object_ [ ("ast", TextDocument.getText document () |> Dumpast.transform) ]
  in
  send_msg "parse" (Jsonoo.t_to_js ast_js) ~webview

let onDidChangeTextDocument_listener event ~(document : TextDocument.t)
    ~(webview : WebView.t) =
  let changed_document = TextDocumentChangeEvent.document event in
  if document_eq document changed_document then
    transform_to_ast ~document ~webview
  else
    ()

let onDidReceiveMessage_listener msg ~(document : TextDocument.t) =
  if Ojs.has_property msg "begin" && Ojs.has_property msg "end" then
    let cbegin =
      Int.of_string (Ojs.string_of_js (Ojs.get_prop_ascii msg "begin"))
    in
    let cend =
      Int.of_string (Ojs.string_of_js (Ojs.get_prop_ascii msg "end"))
    in
    let visible_editors =
      List.filter (Vscode.Window.visibleTextEditors ()) ~f:(fun editor ->
          let visible_doc = TextEditor.document editor in
          document_eq document visible_doc)
    in
    let apply_selection editor cbegin cend =
      let document = TextEditor.document editor in
      let anchor = Vscode.TextDocument.positionAt document ~offset:cbegin in
      let active = Vscode.TextDocument.positionAt document ~offset:cend in
      TextEditor.set_selection editor (Selection.makePositions ~anchor ~active);
      TextEditor.revealRange editor
        ~range:(Range.makePositions ~start:anchor ~end_:active)
        ();
      (*FIXME: not accessing editor after the combination of revealRange and
        set_selection (separately) results in a exception being thrown*)
      let _ = TextEditor.selections editor in
      ()
    in
    List.iter ~f:(fun e -> apply_selection e cbegin cend) visible_editors
  else
    ()

let resolveCustomTextEditor ~(document : TextDocument.t) ~webviewPanel ~token:_
    : CustomTextEditorProvider.ResolvedEditor.t =
  let _ = document in
  let webview = WebviewPanel.webview webviewPanel in
  (*persist the webview*)
  webview_map :=
    Map.set !webview_map ~key:(doc_string_uri ~document) ~data:webview;
  let onDidChangeTextDocument_disposable =
    Workspace.onDidChangeTextDocument
      ~listener:(onDidChangeTextDocument_listener ~webview ~document)
      ()
  in
  let onDidReceiveMessage_disposable =
    WebView.onDidReceiveMessage webview
      ~listener:(onDidReceiveMessage_listener ~document)
      ()
  in
  let _ =
    WebviewPanel.onDidDispose webviewPanel
      ~listener:(fun () ->
        Disposable.dispose onDidReceiveMessage_disposable;
        Disposable.dispose onDidChangeTextDocument_disposable)
      ()
  in
  transform_to_ast ~document ~webview;
  let options = WebView.options webview in
  WebviewOptions.set_enableScripts options true;
  WebView.set_options webview options;
  let p =
    let open Promise.Syntax in
    let+ r = read_html_file () in
    WebView.set_html webview r
  in
  `Promise p

let open_ast_explorer ~uri =
  let _ =
    Vscode.Commands.executeCommand ~command:"vscode.openWith"
      ~args:
        [ Uri.t_to_js uri
        ; Ojs.string_to_js "ast-editor"
        ; ViewColumn.t_to_js ViewColumn.Beside
        ]
  in
  ()

module Command = struct
  let _open_ast_explorer_to_the_side =
    let handler _ ~textEditor ~edit:_ ~args:_ =
      let (_ : unit Promise.t) =
        let uri = TextEditor.document textEditor |> TextDocument.uri in
        Promise.make (fun ~resolve:_ ~reject:_ -> open_ast_explorer ~uri)
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.open_ast_explorer_to_the_side handler

  let _reveal_ast_node =
    let handler _ ~textEditor ~edit:_ ~args:_ =
      let (_ : unit Promise.t) =
        let selection = Vscode.TextEditor.selection textEditor in
        let document = TextEditor.document textEditor in
        let position = Vscode.Selection.start selection in
        let webview =
          match Map.find !webview_map (doc_string_uri ~document) with
          | Some wv -> wv
          | None -> failwith "Webview wasnt found"
        in
        let offset = TextDocument.offsetAt document ~position in
        Promise.make (fun ~resolve:_ ~reject:_ ->
            send_msg "focus" (Ojs.int_to_js offset) ~webview)
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.reveal_ast_node handler
end

let register extension =
  let editorProvider =
    `CustomEditorProvider
      (CustomTextEditorProvider.create ~resolveCustomTextEditor)
  in
  let disposable =
    Vscode.Window.registerCustomEditorProvider ~viewType:"ast-editor"
      ~provider:editorProvider
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
