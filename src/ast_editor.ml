open Import

let webview_map = ref (Map.empty (module String))

let original_mode = ref true

let hover_disposable_ref = ref None

let doc_string_uri ~document = Uri.toString (TextDocument.uri document) ()

let pp_doc_to_changed_origin_map = ref (Map.empty (module String))

let origin_to_pp_doc_map = ref (Map.empty (module String))

let entry_exists k d =
  Map.existsi !origin_to_pp_doc_map ~f:(fun ~key ~data ->
      String.equal d data && String.equal k key)

let put_keys_into_a_list data_serached map =
  Map.filteri ~f:(fun ~key:_ ~data -> String.equal data_serached data) map
  |> Map.to_alist |> List.unzip |> fst

let find_webview_by_doc ~document =
  match Map.find !webview_map (doc_string_uri ~document) with
  | wv_opt when !original_mode -> wv_opt
  | None -> (
    match
      put_keys_into_a_list (doc_string_uri ~document) !origin_to_pp_doc_map
    with
    | [ k ] -> (
      match Map.find !webview_map k with
      | wv_opt when not !original_mode -> wv_opt
      | _ -> None)
    | _ -> None)
  | _ -> None

let remove_keys_by_data map d =
  map := Map.filteri ~f:(fun ~key:_ ~data -> not (String.equal data d)) !map

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

let document_eq a b = Uri.equal (TextDocument.uri a) (TextDocument.uri b)

let send_msg t value ~(webview : WebView.t) =
  let msg = Ojs.empty_obj () in
  Ojs.set_prop_ascii msg "type" (Ojs.string_to_js t);
  Ojs.set_prop_ascii msg "value" value;
  let (_ : bool Promise.t) = WebView.postMessage webview msg in
  ()

let transform_to_ast ~(document : TextDocument.t) ~(webview : WebView.t) =
  let open Ppx_tools in
  let origin_json =
    Dumpast.transform
      (TextDocument.getText document ())
      (Pp_path.get_kind ~document)
  in
  let pp_value =
    (*FIXME: adapt according to ppxlibs issue resulution *)
    match get_preprocessed_ast (Pp_path.get_pp_path ~document) with
    | Ok ast -> (
      match ast with
      | Impl ppml_structure ->
        let pp_code = get_reparsed_code_from_pp_file ~document in
        let reparsed_structure =
          pp_code |> Lexing.from_string |> Parse.implementation
        in
        let reparsed_json = Dumpast.reparse ppml_structure reparsed_structure in
        reparsed_json
      | Intf signature ->
        let pp_code = get_reparsed_code_from_pp_file ~document in
        let reparsed_signature =
          pp_code |> Lexing.from_string |> Parse.interface
        in
        let reparsed_json =
          Dumpast.reparse_signature signature reparsed_signature
        in
        reparsed_json)
    | Error err_msg ->
      show_message `Error "%s" err_msg;
      Jsonoo.Encode.null
  in

  let astpair =
    Jsonoo.Encode.object_ [ ("ast", origin_json); ("pp_ast", pp_value) ]
  in
  send_msg "parse" (Jsonoo.t_to_js astpair) ~webview

let onDidChangeTextDocument_listener event ~(document : TextDocument.t)
    ~(webview : WebView.t) =
  let changed_document = TextDocumentChangeEvent.document event in
  if document_eq document changed_document then
    transform_to_ast ~document ~webview

let onDidReceiveMessage_listener msg ~(document : TextDocument.t) =
  if Ojs.has_property msg "selectedOutput" then
    original_mode := not !original_mode
  else if Ojs.has_property msg "begin" && Ojs.has_property msg "end" then
    let cbegin =
      Int.of_string (Ojs.string_of_js (Ojs.get_prop_ascii msg "begin"))
    in
    let cend =
      Int.of_string (Ojs.string_of_js (Ojs.get_prop_ascii msg "end"))
    in
    let maybe_pair_editors =
      List.map (Vscode.Window.visibleTextEditors ()) ~f:(fun editor ->
          let visible_doc = TextEditor.document editor in
          if (* !original_mode && *) document_eq document visible_doc then
            (Some editor, None)
          else if
            (* (not !original_mode) && *)
            (entry_exists (doc_string_uri ~document))
              (doc_string_uri ~document:visible_doc)
          then
            (None, Some editor)
          else
            (None, None))
      |> List.filter ~f:(function
           | None, None -> false
           | _ -> true)
    in
    let apply_selection editor cbegin cend =
      let document = TextEditor.document editor in
      let anchor = Vscode.TextDocument.positionAt document ~offset:cbegin in
      let active = Vscode.TextDocument.positionAt document ~offset:cend in
      TextEditor.set_selection editor (Selection.makePositions ~anchor ~active);
      TextEditor.revealRange editor
        ~range:(Range.makePositions ~start:anchor ~end_:active)
        ()
    in
    List.iter
      ~f:(fun e ->
        match e with
        | Some editor, None -> apply_selection editor cbegin cend
        | None, Some editor
          when Ojs.has_property msg "r_begin"
               && Ojs.has_property msg "r_end"
               && not !original_mode ->
          let rcbegin =
            Int.of_string (Ojs.string_of_js (Ojs.get_prop_ascii msg "r_begin"))
          in
          let rcend =
            Int.of_string (Ojs.string_of_js (Ojs.get_prop_ascii msg "r_end"))
          in
          apply_selection editor rcbegin rcend
        | _ -> ())
      maybe_pair_editors
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
  match find_webview_by_doc ~document with
  | Some webview -> on_hover document webview
  | None -> failwith "Webview wasn't found while switching hover mode"

let resolveCustomTextEditor ~(document : TextDocument.t) ~webviewPanel ~token:_
    : CustomTextEditorProvider.ResolvedEditor.t =
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
  let (_ : Disposable.t) =
    WebviewPanel.onDidDispose webviewPanel
      ~listener:(fun () ->
        original_mode := true;
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
  let open Promise.Syntax in
  let+ _ =
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
  let pp_pp_str = Ppx_tools.get_reparsed_code_from_pp_file ~document in
  let* doc =
    Workspace.openTextDocument
      (`Uri
        (Uri.parse ("post-ppx: " ^ TextDocument.fileName document ^ "?") ()))
  in
  set_changes_tracking document doc;
  let* (_ : bool) = replace_document_content ~content:pp_pp_str ~document:doc in
  let+ (_ : TextEditor.t) =
    Window.showTextDocument ~document:(`TextDocument doc)
      ~column:ViewColumn.Beside ()
  in
  0

let reload_pp_doc ~document =
  let open Promise.Syntax in
  let visibleTextEditors = Window.visibleTextEditors () in
  let origin_uri =
    match
      put_keys_into_a_list (doc_string_uri ~document) !origin_to_pp_doc_map
    with
    | x :: _ -> x
    | _ -> failwith "Failed finding the original document URI."
  in
  let* original_document =
    Workspace.openTextDocument (`Uri (Uri.parse origin_uri ()))
  in
  match
    List.find
      ~f:(fun editor -> document_eq (TextEditor.document editor) document)
      visibleTextEditors
  with
  | Some _ ->
    let+ (_ : bool) =
      set_origin_changed ~key:(doc_string_uri ~document) ~data:false;
      replace_document_content
        ~content:
          (Ppx_tools.get_reparsed_code_from_pp_file ~document:original_document)
        ~document
    in
    0
  | None -> Promise.resolve 1

let manage_choice choice ~document : int Promise.t =
  let path = Path.of_string (Ppx_tools.Pp_path.project_root_path ~document) in
  let buildCmd () =
    Cmd.run ~cwd:path (Cmd.Shell "eval $(opam env); dune build")
  in
  let rec build_project () =
    let open Promise.Syntax in
    let* res = buildCmd () in
    if res.exitCode = 0 then
      if
        Map.existsi !pp_doc_to_changed_origin_map ~f:(fun ~key ~data:_ ->
            String.equal key (doc_string_uri ~document))
      then
        reload_pp_doc ~document
      else
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
        ^ Ppx_tools.Pp_path.relative_document_path ~document
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
  let* pp_doc_open = open_preprocessed_doc_to_the_side ~document in
  if pp_doc_open = 0 then
    open_ast_explorer ~uri:(TextDocument.uri document)
  else
    Promise.make (fun ~resolve:_ ~reject:_ ->
        show_message `Warn "Failed to open Preprocessed Document")

module Command = struct
  let _open_ast_explorer_to_the_side =
    let handler _ ~textEditor ~edit:_ ~args:_ =
      let (_ : unit Promise.t) =
        let uri = TextEditor.document textEditor |> TextDocument.uri in
        open_ast_explorer ~uri
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
        let webview_opt = find_webview_by_doc ~document in
        let offset = TextDocument.offsetAt document ~position in
        Promise.make (fun ~resolve:_ ~reject:_ ->
            match webview_opt with
            | Some webview -> send_msg "focus" (Ojs.int_to_js offset) ~webview
            | None ->
              show_message `Warn
                "Wrong output mode inside the AST explorer, please select the \
                 correct tab")
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
        let open Promise.Syntax in
        let+ (_ : int) = open_preprocessed_doc_to_the_side ~document in
        ()
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.show_preprocessed_document handler

  let _open_pp_editor_and_ast_explorer =
    let handler _ ~textEditor ~edit:_ ~args:_ =
      let (_ : unit Promise.t) =
        let document = TextEditor.document textEditor in
        open_both_ppx_ast ~document
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

let manage_changed_origin ~document =
  let open Promise.Syntax in
  let* choice =
    Window.showInformationMessage
      ~message:
        "The original document have been changed, would you like to rebuild \
         the project?"
      ~choices:[ ("Run `dune build`", 0); ("Cancel", 1) ]
      ()
  in
  manage_choice choice ~document

let onDidSaveTextDocument_listener_pp document =
  on_origin_update_content document

let onDidChangeActiveTextEditor_listener e =
  if not (TextEditor.t_to_js e |> Ojs.is_null) then
    let document = TextEditor.document e in
    match Map.find !pp_doc_to_changed_origin_map (doc_string_uri ~document) with
    | Some true ->
      let (_ : int Promise.t) = manage_changed_origin ~document in
      ()
    | _ -> ()
  else
    ()

let close_visible_editors_by_uri uri =
  let f e =
    let visibleDocument = TextEditor.document e in
    let open Promise.Syntax in
    if String.equal uri (doc_string_uri ~document:visibleDocument) then
      let (_ : Ojs.t option Promise.t) =
        let* (_ : TextEditor.t) =
          Window.showTextDocument ~document:(`TextDocument visibleDocument) ()
        in
        Vscode.Commands.executeCommand
          ~command:"workbench.action.closeActiveEditor" ~args:[]
      in
      ()
    else
      ()
  in
  Window.visibleTextEditors () |> List.iter ~f

let onDidCloseTextDocument_listener (document : TextDocument.t) =
  let origin_uri = doc_string_uri ~document in
  match Map.find !origin_to_pp_doc_map origin_uri with
  | Some uri ->
    pp_doc_to_changed_origin_map := Map.remove !pp_doc_to_changed_origin_map uri;
    origin_to_pp_doc_map := Map.remove !origin_to_pp_doc_map origin_uri;
    (* close corresponding pp buffers to avoid confusion *)
    close_visible_editors_by_uri uri
  | None ->
    remove_keys_by_data origin_to_pp_doc_map origin_uri;
    pp_doc_to_changed_origin_map :=
      Map.remove !pp_doc_to_changed_origin_map origin_uri

let register extension =
  let editorProvider =
    `CustomEditorProvider
      (CustomTextEditorProvider.create ~resolveCustomTextEditor)
  in
  let disposable =
    Window.onDidChangeActiveTextEditor ()
      ~listener:onDidChangeActiveTextEditor_listener ()
  in
  Vscode.ExtensionContext.subscribe extension ~disposable;
  let disposable =
    Vscode.Window.registerCustomEditorProvider ~viewType:"ast-editor"
      ~provider:editorProvider
  in

  Vscode.ExtensionContext.subscribe extension ~disposable;
  let disposable =
    Workspace.onDidCloseTextDocument ~listener:onDidCloseTextDocument_listener
      ()
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
