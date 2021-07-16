open Import
open Ppx_utils

let webview_map = ref (Map.empty (module String))

let hover_disposable_ref = ref None

let doc_string_uri ~document = Uri.toString (TextDocument.uri document) ()

let pp_doc_to_changed_origin_map = ref (Map.empty (module String))

let origin_to_pp_doc_map = ref (Map.empty (module String))

let set_changes_tracking origin pp_doc =
  origin_to_pp_doc_map :=
    Map.set !origin_to_pp_doc_map
      ~key:(doc_string_uri ~document:origin)
      ~data:(doc_string_uri ~document:pp_doc);
  pp_doc_to_changed_origin_map :=
    Map.set
      !pp_doc_to_changed_origin_map
      ~key:(doc_string_uri ~document:pp_doc)
      ~data:false

let set_origin_changed ~data ~key =
  pp_doc_to_changed_origin_map :=
    Map.set !pp_doc_to_changed_origin_map ~key ~data

let on_origin_update_content changed_document =
  match
    Map.find !origin_to_pp_doc_map (doc_string_uri ~document:changed_document)
  with
  | Some key -> set_origin_changed ~key ~data:true
  | None -> ()

let read_html_file () =
  let filename = Node.__dirname () ^ "/../astexplorer/dist/index.html" in
  Fs.readFile filename

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
  let origin_json = TextDocument.getText document () |> Dumpast.transform in
  let _pp_path = get_pp_path ~document in
  let pp_value =
    try
      let pp_code = get_pp_pp_structure ~document in
      let reparsed_json = Dumpast.transform pp_code in
      reparsed_json
    with
    | _ -> null
  in
  let astpair = object_ [ ("ast", origin_json); ("pp_ast", pp_value) ] in
  send_msg "parse" (Jsonoo.t_to_js astpair) ~webview

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

let on_hover custom_doc webview =
  let hover =
    Hover.make ~contents:(`MarkdownString (MarkdownString.make ~value:"" ()))
  in
  let provideHover ~(document : TextDocument.t) ~(position : Position.t)
      ~token:_ =
    let offset = TextDocument.offsetAt document ~position in
    if document_eq custom_doc document then
      send_msg "focus" (Ojs.int_to_js offset) ~webview
    else
      ();
    `Value (Some [ hover ])
  in
  let provider = HoverProvider.create ~provideHover in
  Vscode.Languages.registerHoverProvider ~selector:(`String "ocaml") ~provider

let activate_hover_mode ~document =
  let webview =
    match Map.find !webview_map (doc_string_uri ~document) with
    | Some wv -> wv
    | None -> failwith "Webview wasn't found while desactivating hover mode"
  in
  on_hover document webview

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

let replace_document_content ~document ~content =
  let first_line = TextDocument.lineAt document ~line:0 in
  let last_line =
    TextDocument.lineAt document ~line:(TextDocument.lineCount document - 1)
  in
  let range =
    Range.makePositions
      ~start:(TextLine.range first_line |> Range.start)
      ~end_:(TextLine.range last_line |> Range.end_)
  in
  let edit = WorkspaceEdit.make () in
  WorkspaceEdit.replace edit
    ~uri:(TextDocument.uri document)
    ~range ~newText:content;
  Workspace.applyEdit ~edit

let open_pp_doc ~document =
  let open Promise.Syntax in
  let pp_pp_str = get_pp_pp_structure ~document in
  let* doc =
    Workspace.openTextDocument
      (`Uri
        (Uri.parse ("post-ppx: " ^ TextDocument.fileName document ^ "?") ()))
  in
  set_changes_tracking document doc;
  let _ =
    let+ _ = replace_document_content ~content:pp_pp_str ~document:doc in
    ()
  in
  let+ _ =
    Window.showTextDocument ~document:(`TextDocument doc)
      ~column:ViewColumn.Beside ()
  in
  0

let manage_choice choice ~document : int Promise.t =
  let path = Path.of_string (project_root_path ~document) in
  let buildCmd () =
    Cmd.run ~cwd:path (Cmd.Shell "eval $(opam env); dune build")
  in
  let rec build_project () =
    let open Promise.Syntax in
    let* res = buildCmd () in
    if res.exitCode = 0 then
      open_pp_doc ~document
    else
      let* perror =
        Window.showErrorMessage
          ~message:"Building project failed, fix project errors and retry."
          ~choices:[ ("Retry running `dune build`", 0); ("Abandon", 1) ]
          ()
      in
      match perror with
      | Some 0 -> build_project ()
      | _ -> Promise.resolve 1
  in
  match choice with
  | Some 0 -> build_project ()
  | _ -> Promise.resolve 1

let manage_open_failure ~document =
  let open Promise.Syntax in
  let* choice =
    Window.showInformationMessage
      ~message:
        ("Seems like the file '"
        ^ relative_document_path ~document
        ^ "' haven't been preprocessed yet.")
      ~choices:[ ("Run `dune build`", 0); ("Abandon", 1) ]
      ()
  in
  manage_choice choice ~document

let open_preprocessed_doc_to_the_side ~document =
  try open_pp_doc ~document with
  | _ -> manage_open_failure ~document

let open_both_ppx_ast ~document =
  let open Promise.Syntax in
  let+ pp_doc_open = open_preprocessed_doc_to_the_side ~document in
  if pp_doc_open = 0 then
    open_ast_explorer ~uri:(TextDocument.uri document)
  else
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
          | None -> failwith "Webview wasn't found"
        in
        let offset = TextDocument.offsetAt document ~position in
        Promise.make (fun ~resolve:_ ~reject:_ ->
            send_msg "focus" (Ojs.int_to_js offset) ~webview)
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.reveal_ast_node handler

  let _switch_hover_mode =
    let handler _ ~textEditor ~edit:_ ~args:_ =
      let (_ : unit Promise.t) =
        Promise.make (fun ~resolve:_ ~reject:_ ->
            match !hover_disposable_ref with
            | Some d ->
              Disposable.dispose d;
              hover_disposable_ref := None
            | None ->
              hover_disposable_ref :=
                Some
                  (activate_hover_mode
                     ~document:(TextEditor.document textEditor)))
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.switch_hover_mode handler

  let _show_preprocessed_document =
    let handler _ ~textEditor ~edit:_ ~args:_ =
      let document = TextEditor.document textEditor in
      let (_ : unit Promise.t) =
        Promise.make (fun ~resolve:_ ~reject:_ ->
            let _ =
              let open Promise.Syntax in
              let+ _ = open_preprocessed_doc_to_the_side ~document in
              ()
            in
            ())
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.show_preprocessed_document handler

  let _open_pp_editor_and_ast_explorer =
    let handler _ ~textEditor ~edit:_ ~args:_ =
      let (_ : unit Promise.t) =
        let document = TextEditor.document textEditor in
        Promise.make (fun ~resolve:_ ~reject:_ ->
            let _ = open_both_ppx_ast ~document in
            ())
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.open_pp_editor_and_ast_explorer handler
end

let text_document_content_provider_ppx =
  let module EventEmitter = EventEmitter.Make (Uri) in
  let event_emitter = EventEmitter.make () in
  let onDidChange = EventEmitter.event event_emitter in
  let provideTextDocumentContent ~uri:_ ~token:_ : string ProviderResult.t =
    `Value (Some "")
  in
  TextDocumentContentProvider.create ~provideTextDocumentContent ~onDidChange

let onDidSaveTextDocument_listener_pp document =
  on_origin_update_content document

let register extension =
  let editorProvider =
    `CustomEditorProvider
      (CustomTextEditorProvider.create ~resolveCustomTextEditor)
  in
  let disposable =
    Vscode.Window.registerCustomEditorProvider ~viewType:"ast-editor"
      ~provider:editorProvider
  in
  Vscode.ExtensionContext.subscribe extension ~disposable;
  let disposable =
    Vscode.Workspace.registerTextDocumentContentProvider ~scheme:"post-ppx"
      ~provider:text_document_content_provider_ppx
  in
  Vscode.ExtensionContext.subscribe extension ~disposable;
  let disposable =
    Workspace.onDidSaveTextDocument ~listener:onDidSaveTextDocument_listener_pp
      ()
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
