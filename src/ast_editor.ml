open Import

let read_html_file () =
  let filename = Node.__dirname () ^ "/../astexplorer/dist/index.html" in
  Fs.readFile filename

let resolveCustomTextEditor ~(document : TextDocument.t) ~webviewPanel ~token:_
    : CustomTextEditorProvider.ResolvedEditor.t =
  let _ = document in
  let webview = WebviewPanel.webview webviewPanel in
  let options = WebView.options webview in
  WebviewOptions.set_enableScripts options true;
  WebView.set_options webview options;
  let p =
    let open Promise.Syntax in
    let+ r = read_html_file () in
    WebView.set_html webview r
  in
  `Promise p

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
