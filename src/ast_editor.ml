open Import

let doc_string_uri ~document = Uri.toString (TextDocument.uri document) ()

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

let fetch_pp_code ~document =
  match Ppx_tools.get_reparsed_code_from_pp_file ~document with
  | Ok code -> code
  | Error err_msg ->
    show_message `Error "%s" err_msg;
    ""

let transform_to_ast ~(document : TextDocument.t) ~(webview : WebView.t) =
  let open Ppx_tools in
  let origin_json =
    Dumpast.transform
      (TextDocument.getText document ())
      (Pp_path.get_kind ~document)
  in
  let pp_value =
    (*FIXME: adapt according to ppxlibs issue resulution *)
    match Pp_path.get_pp_path ~document with
    | None ->
      show_message `Error "%s" "project root path wasn't found";
      Jsonoo.Encode.null
    | Some path -> (
      match get_preprocessed_ast path with
      | Error err_msg ->
        show_message `Error "%s" err_msg;
        Jsonoo.Encode.null
      | Ok res -> (
        let pp_code = fetch_pp_code ~document in
        let lex = Lexing.from_string pp_code in
        match Ppxlib.Ast_io.get_ast res with
        | Impl ppml_structure ->
          let reparsed_structure = Parse.implementation lex in
          Dumpast.reparse ppml_structure reparsed_structure
        | Intf signature ->
          let reparsed_signature = Parse.interface lex in
          Dumpast.reparse_signature signature reparsed_signature))
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

let onDidReceiveMessage_listener instance msg ~(document : TextDocument.t) =
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  if Ojs.has_property msg "selectedOutput" then
    Ast_editor_state.set_original_mode ast_editor_state
      (Int.of_string
         (Ojs.string_of_js (Ojs.get_prop_ascii msg "selectedOutput"))
      = 0)
  else if Ojs.has_property msg "begin" && Ojs.has_property msg "end" then
    let cbegin =
      Int.of_string (Ojs.string_of_js (Ojs.get_prop_ascii msg "begin"))
    in
    let cend =
      Int.of_string (Ojs.string_of_js (Ojs.get_prop_ascii msg "end"))
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
    Vscode.Window.visibleTextEditors ()
    |> List.iter ~f:(fun editor ->
           let visible_doc = TextEditor.document editor in
           if (* !original_mode && *) document_eq document visible_doc then
             apply_selection editor cbegin cend
           else if
             (* (not !original_mode) && *)
             (Ast_editor_state.entry_exists ast_editor_state
                ~origin_doc:(doc_string_uri ~document))
               ~pp_doc:(doc_string_uri ~document:visible_doc)
             && Ojs.has_property msg "r_begin"
             && Ojs.has_property msg "r_end"
             && not (Ast_editor_state.get_original_mode ast_editor_state)
           then
             let rcbegin =
               Int.of_string
                 (Ojs.string_of_js (Ojs.get_prop_ascii msg "r_begin"))
             in
             let rcend =
               Int.of_string (Ojs.string_of_js (Ojs.get_prop_ascii msg "r_end"))
             in
             apply_selection editor rcbegin rcend)

let on_hover custom_doc webview =
  let hover =
    Hover.make ~contents:(`MarkdownString (MarkdownString.make ~value:"" ()))
  in
  let provideHover ~(document : TextDocument.t) ~(position : Position.t)
      ~token:_ =
    let offset = TextDocument.offsetAt document ~position in
    if document_eq custom_doc document then
      send_msg "focus" (Ojs.int_to_js offset) ~webview;
    `Value (Some hover)
  in
  let provider = HoverProvider.create ~provideHover in
  Vscode.Languages.registerHoverProvider ~selector:(`String "ocaml") ~provider

let activate_hover_mode instance ~document =
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  match Ast_editor_state.find_webview_by_doc ast_editor_state ~document with
  | Some webview -> on_hover document webview
  | None -> failwith "Webview wasn't found while switching hover mode"

let resolveCustomTextEditor instance ~(document : TextDocument.t) ~webviewPanel
    ~token:_ : CustomTextEditorProvider.ResolvedEditor.t =
  let webview = WebviewPanel.webview webviewPanel in
  (*persist the webview*)
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  Ast_editor_state.set_webview_map ast_editor_state
    (Map.set
       (Ast_editor_state.get_webview_map ast_editor_state)
       ~key:(doc_string_uri ~document) ~data:webview);
  let onDidChangeTextDocument_disposable =
    Workspace.onDidChangeTextDocument
      ~listener:(onDidChangeTextDocument_listener ~webview ~document)
      ()
  in
  let onDidReceiveMessage_disposable =
    WebView.onDidReceiveMessage webview
      ~listener:(onDidReceiveMessage_listener instance ~document)
      ()
  in
  let (_ : Disposable.t) =
    WebviewPanel.onDidDispose webviewPanel
      ~listener:(fun () ->
        Ast_editor_state.set_original_mode ast_editor_state true;
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
  let (_ : bool Promise.t) = Workspace.applyEdit ~edit in
  ()

let open_pp_doc instance ~document =
  let open Promise.Syntax in
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  let pp_pp_str = fetch_pp_code ~document in
  let* doc =
    Workspace.openTextDocument
      (`Uri
        (Uri.parse ("post-ppx: " ^ TextDocument.fileName document ^ "?") ()))
  in
  Ast_editor_state.set_changes_tracking ast_editor_state document doc;
  replace_document_content ~content:pp_pp_str ~document:doc;
  let+ (_ : TextEditor.t) =
    Window.showTextDocument ~document:(`TextDocument doc)
      ~column:ViewColumn.Beside ()
  in
  0

let reload_pp_doc instance ~document =
  let open Promise.Syntax in
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  let visibleTextEditors = Window.visibleTextEditors () in
  let origin_uri =
    match
      Ast_editor_state.find_original_doc_by_pp_uri
        ~uri_string:(doc_string_uri ~document)
        (Ast_editor_state.get_origin_to_pp_doc_map ast_editor_state)
    with
    | Some x -> x
    | None -> failwith "Failed finding the original document URI."
  in
  let* original_document =
    Workspace.openTextDocument (`Uri (Uri.parse origin_uri ()))
  in
  match
    List.find visibleTextEditors ~f:(fun editor ->
        document_eq (TextEditor.document editor) document)
  with
  | None -> Promise.resolve 1
  | Some _ ->
    Ast_editor_state.set_origin_changed ast_editor_state
      ~key:(doc_string_uri ~document) ~data:false;
    replace_document_content
      ~content:(fetch_pp_code ~document:original_document)
      ~document;
    Promise.resolve 1

let manage_choice instance choice ~document : int Promise.t =
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  match Ppx_tools.Pp_path.project_root_path () with
  | None ->
    show_message `Error "%s" "Error : project root wasn't found";
    Promise.resolve 1
  | Some root -> (
    let build_cmd =
      let cwd = Path.of_string root in
      fun () -> Cmd.run ~cwd (Cmd.Shell "eval $(opam env); dune build")
    in
    let rec build_project () =
      let open Promise.Syntax in
      let* res = build_cmd () in
      if res.exitCode = 0 then
        if
          Map.existsi
            (Ast_editor_state.get_pp_doc_to_changed_origin_map ast_editor_state)
            ~f:(fun ~key ~data:_ -> String.equal key (doc_string_uri ~document))
        then
          reload_pp_doc instance ~document
        else
          open_pp_doc instance ~document
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
    | _ -> Promise.resolve 1)

let manage_open_failure err_msg instance ~document =
  let open Promise.Syntax in
  let* choice =
    Window.showInformationMessage ~message:err_msg
      ~choices:[ ("Run `dune build`", 0); ("Abandon", 1) ]
      ()
  in
  manage_choice instance choice ~document

let open_preprocessed_doc_to_the_side instance ~document =
  try open_pp_doc instance ~document with
  | Sys_error e -> manage_open_failure e instance ~document

let open_both_ppx_ast instance ~document =
  let open Promise.Syntax in
  let* pp_doc_open = open_preprocessed_doc_to_the_side instance ~document in
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
    let handler (instance : Extension_instance.t) ~textEditor ~edit:_ ~args:_ =
      let (_ : unit Promise.t) =
        let selection = Vscode.TextEditor.selection textEditor in
        let document = TextEditor.document textEditor in
        let position = Vscode.Selection.start selection in
        let ast_editor_state = Extension_instance.ast_editor_state instance in
        let webview_opt =
          Ast_editor_state.find_webview_by_doc ast_editor_state ~document
        in
        let offset = TextDocument.offsetAt document ~position in
        Promise.make (fun ~resolve:_ ~reject:_ ->
            match webview_opt with
            | Some webview -> send_msg "focus" (Ojs.int_to_js offset) ~webview
            | None ->
              show_message `Warn
                "Wrong output modee inside the AST explorer, please select the \
                 correct tab")
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.reveal_ast_node handler

  let _switch_hover_mode =
    let handler (instance : Extension_instance.t) ~textEditor ~edit:_ ~args:_ =
      let (_ : unit Promise.t) =
        Promise.make (fun ~resolve:_ ~reject:_ ->
            let ast_editor_state =
              Extension_instance.ast_editor_state instance
            in
            match Ast_editor_state.get_hover_disposable ast_editor_state with
            | Some d ->
              Disposable.dispose d;
              Ast_editor_state.set_hover_disposable ast_editor_state None
            | None ->
              Ast_editor_state.set_hover_disposable ast_editor_state
                (Some
                   (activate_hover_mode instance
                      ~document:(TextEditor.document textEditor))))
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.switch_hover_mode handler

  let _show_preprocessed_document =
    let handler (instance : Extension_instance.t) ~textEditor ~edit:_ ~args:_ =
      let document = TextEditor.document textEditor in
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let+ (_ : int) = open_preprocessed_doc_to_the_side instance ~document in
        ()
      in
      ()
    in
    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.show_preprocessed_document handler

  let _open_pp_editor_and_ast_explorer =
    let handler (instance : Extension_instance.t) ~textEditor ~edit:_ ~args:_ =
      let (_ : unit Promise.t) =
        let document = TextEditor.document textEditor in
        open_both_ppx_ast instance ~document
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
  TextDocumentContentProvider.create ~provideTextDocumentContent ~onDidChange ()

let manage_changed_origin instance ~document =
  let open Promise.Syntax in
  let* choice =
    Window.showInformationMessage
      ~message:
        "The original document have been changed, would you like to rebuild \
         the project?"
      ~choices:[ ("Run `dune build`", 0); ("Cancel", 1) ]
      ()
  in
  manage_choice instance choice ~document

let onDidSaveTextDocument_listener_pp instance document =
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  Ast_editor_state.on_origin_update_content ast_editor_state document

let onDidChangeActiveTextEditor_listener instance e =
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  if not (TextEditor.t_to_js e |> Ojs.is_null) then
    let document = TextEditor.document e in
    match
      Map.find
        (Ast_editor_state.get_pp_doc_to_changed_origin_map ast_editor_state)
        (doc_string_uri ~document)
    with
    | Some true ->
      let (_ : int Promise.t) = manage_changed_origin instance ~document in
      ()
    | _ -> ()

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
  in
  Window.visibleTextEditors () |> List.iter ~f

let onDidCloseTextDocument_listener instance (document : TextDocument.t) =
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  Ast_editor_state.remove_doc_entries ast_editor_state document;
  close_visible_editors_by_uri (Uri.toString (TextDocument.uri document) ())

let register extension _instance =
  let editorProvider =
    `CustomEditorProvider
      (CustomTextEditorProvider.create
         ~resolveCustomTextEditor:(resolveCustomTextEditor _instance))
  in
  let disposable =
    Window.onDidChangeActiveTextEditor ()
      ~listener:(onDidChangeActiveTextEditor_listener _instance)
      ()
  in
  Vscode.ExtensionContext.subscribe extension ~disposable;
  let disposable =
    Vscode.Window.registerCustomEditorProvider ~viewType:"ast-editor"
      ~provider:editorProvider
  in

  Vscode.ExtensionContext.subscribe extension ~disposable;
  let disposable =
    Workspace.onDidCloseTextDocument
      ~listener:(onDidCloseTextDocument_listener _instance)
      ()
  in
  Vscode.ExtensionContext.subscribe extension ~disposable;
  let disposable =
    Vscode.Workspace.registerTextDocumentContentProvider ~scheme:"post-ppx"
      ~provider:text_document_content_provider_ppx
  in
  Vscode.ExtensionContext.subscribe extension ~disposable;
  let disposable =
    Workspace.onDidSaveTextDocument
      ~listener:(onDidSaveTextDocument_listener_pp _instance)
      ()
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
