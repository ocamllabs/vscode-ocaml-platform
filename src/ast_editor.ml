open Import

exception User_error of string

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

module Pp_path : sig
  type kind =
    | Structure
    | Signature
    | Unknown

  val get_kind : document:TextDocument.t -> kind

  val get_pp_path : document:TextDocument.t -> (string, string) result
end = struct
  type kind =
    | Structure
    | Signature
    | Unknown

  let relative_document_path ~document =
    Workspace.asRelativePath ~pathOrUri:(`Uri (TextDocument.uri document)) ()

  let project_root_path () = Workspace.rootPath ()

  let get_kind ~document =
    let relative = relative_document_path ~document in
    match Caml.Filename.extension relative with
    | ".ml" -> Structure
    | ".mli" -> Signature
    | _ -> Unknown

  let get_pp_path ~(document : TextDocument.t) =
    let relative = relative_document_path ~document in
    match project_root_path () with
    | None -> Error "Project root wasn't found."
    | Some root -> (
      let build_root = "_build/default" in
      let fname_opt =
        match get_kind ~document with
        | Unknown -> None
        | Structure ->
          Some (String.chop_suffix_exn ~suffix:".ml" relative ^ ".pp.ml")
        | Signature ->
          Some (String.chop_suffix_exn ~suffix:".mli" relative ^ ".pp.mli")
      in
      match fname_opt with
      | Some fname ->
        let ( / ) = Caml.Filename.concat in
        Ok (root / build_root / fname)
      | None ->
        let uri = Uri.toString (TextDocument.uri document) () in
        Error (sprintf "File %s has unknown file extension" uri))
end

let fetch_pp_code ~document =
  match Pp_path.get_pp_path ~document with
  | Error err_msg -> Error (Ppx_tools.Io_error err_msg)
  | Ok path -> Ppx_tools.get_reparsed_code_from_pp_file ~path

let transform_to_ast instance ~(document : TextDocument.t)
    ~(webview : WebView.t) =
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  let module Dumpast = Ppx_tools.Dumpast in
  let make_value result =
    match result with
    | Ok ast -> ast
    | Error error_msg -> raise (User_error error_msg)
  in
  if Ast_editor_state.get_original_mode ast_editor_state then
    let origin_json =
      let text = TextDocument.getText document () in
      match Pp_path.get_kind ~document with
      | Structure -> make_value (Dumpast.transform text `Impl)
      | Signature -> make_value (Dumpast.transform text `Intf)
      | Unknown -> raise (User_error "Unknown file extension")
    in
    send_msg "ast" (Jsonoo.t_to_js origin_json) ~webview
  else
    let pp_value =
      match Pp_path.get_pp_path ~document with
      | Error err_msg -> raise (User_error err_msg)
      | Ok path -> (
        match Ppx_tools.get_preprocessed_ast path with
        | Error (Io_error err_msg)
        | Error (Read_error err_msg) ->
          raise (User_error err_msg)
        | Ok res -> (
          let pp_json_res =
            let pp_code =
              match fetch_pp_code ~document with
              | Ok s -> s
              | Error (Ppx_tools.Io_error err_msg) ->
                raise (User_error ("Io_error: " ^ err_msg))
              | Error (Ppx_tools.Read_error err_msg) ->
                raise (User_error ("Read_error: " ^ err_msg))
            in
            let lex = Lexing.from_string pp_code in
            match Ppxlib.Ast_io.get_ast res with
            | Impl ppml_structure ->
              let reparsed_structure = Parse.implementation lex in
              Dumpast.reparse ppml_structure reparsed_structure
            | Intf signature ->
              let reparsed_signature = Parse.interface lex in
              Dumpast.reparse_signature signature reparsed_signature
          in
          match pp_json_res with
          | Error err_msg -> raise (User_error err_msg)
          | Ok pp_json -> make_value (Ok pp_json)))
    in
    send_msg "pp_ast" (Jsonoo.t_to_js pp_value) ~webview

let onDidChangeTextDocument_listener instance event ~(document : TextDocument.t)
    ~(webview : WebView.t) =
  let changed_document = TextDocumentChangeEvent.document event in
  if document_eq document changed_document then
    try transform_to_ast instance ~document ~webview with
    | User_error err_msg ->
      send_msg "error" (Jsonoo.Encode.string err_msg |> Jsonoo.t_to_js) ~webview

let refresh_ast_explorer instance ~document ~webview_opt =
  match webview_opt with
  | None -> ()
  | Some webview -> (
    try transform_to_ast instance ~document ~webview with
    | User_error err_msg ->
      send_msg "error" (Jsonoo.Encode.string err_msg |> Jsonoo.t_to_js) ~webview
    )

let onDidReceiveMessage_listener instance msg ~(document : TextDocument.t) =
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  let int_prop name =
    if Ojs.has_property msg name then
      Some (Int.of_string (Ojs.string_of_js (Ojs.get_prop_ascii msg name)))
    else
      None
  in
  match int_prop "selectedOutput" with
  | Some i ->
    let webview_opt =
      let ast_editor_state = Extension_instance.ast_editor_state instance in
      Ast_editor_state.find_webview_by_doc ast_editor_state
        (TextDocument.uri document)
    in
    Ast_editor_state.set_original_mode ast_editor_state (i = 0);
    refresh_ast_explorer instance ~document ~webview_opt
  | None -> (
    match Option.both (int_prop "begin") (int_prop "end") with
    | None -> ()
    | Some (cbegin, cend) ->
      let apply_selection editor cbegin cend =
        let document = TextEditor.document editor in
        let anchor = Vscode.TextDocument.positionAt document ~offset:cbegin in
        let active = Vscode.TextDocument.positionAt document ~offset:cend in
        TextEditor.set_selection editor
          (Selection.makePositions ~anchor ~active);
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
                  ~origin_doc:(TextDocument.uri document))
                 ~pp_doc:(TextDocument.uri visible_doc)
               && not (Ast_editor_state.get_original_mode ast_editor_state)
             then
               match Option.both (int_prop "r_begin") (int_prop "r_end") with
               | None -> ()
               | Some (rcbegin, rcend) -> apply_selection editor rcbegin rcend))

let on_hover custom_doc webview =
  let provider =
    let provideHover ~(document : TextDocument.t) ~(position : Position.t)
        ~token:_ =
      let offset = TextDocument.offsetAt document ~position in
      if document_eq custom_doc document then
        send_msg "focus" (Ojs.int_to_js offset) ~webview;
      let hover =
        Hover.make
          ~contents:(`MarkdownString (MarkdownString.make ~value:"" ()))
      in
      `Value (Some hover)
    in
    HoverProvider.create ~provideHover
  in
  Vscode.Languages.registerHoverProvider ~selector:(`String "ocaml") ~provider

let activate_hover_mode instance ~document =
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  match
    Ast_editor_state.find_webview_by_doc ast_editor_state
      (TextDocument.uri document)
  with
  | Some webview -> Some (on_hover document webview)
  | None ->
    show_message `Error "No open AST editor was found.";
    None

let resolveCustomTextEditor instance ~(document : TextDocument.t) ~webviewPanel
    ~token:_ : CustomTextEditorProvider.ResolvedEditor.t =
  let webview = WebviewPanel.webview webviewPanel in
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  Ast_editor_state.set_webview ast_editor_state
    (TextDocument.uri document)
    webview;
  let (_ : Disposable.t) =
    let onDidReceiveMessage_disposable =
      WebView.onDidReceiveMessage webview
        ~listener:(onDidReceiveMessage_listener instance ~document)
        ()
    in
    let onDidChangeTextDocument_disposable =
      Workspace.onDidChangeTextDocument
        ~listener:(onDidChangeTextDocument_listener instance ~webview ~document)
        ()
    in
    WebviewPanel.onDidDispose webviewPanel
      ~listener:(fun () ->
        Ast_editor_state.set_original_mode ast_editor_state true;
        Ast_editor_state.remove_webview ast_editor_state
          (TextDocument.uri document);
        Disposable.dispose onDidReceiveMessage_disposable;
        Disposable.dispose onDidChangeTextDocument_disposable)
      ()
  in
  (try transform_to_ast instance ~document ~webview with
  | User_error err_msg ->
    send_msg "error" (Jsonoo.Encode.string err_msg |> Jsonoo.t_to_js) ~webview);
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
  match fetch_pp_code ~document with
  | Error e -> Promise.return (Error e)
  | Ok pp_pp_str ->
    let* doc =
      Workspace.openTextDocument
        (`Uri
          (Uri.parse ("post-ppx: " ^ TextDocument.fileName document ^ "?") ()))
    in
    Ast_editor_state.associate_origin_and_pp ast_editor_state
      ~origin_uri:(TextDocument.uri document)
      ~pp_doc_uri:(TextDocument.uri doc);
    replace_document_content ~content:pp_pp_str ~document:doc;
    let+ (_ : TextEditor.t) =
      Window.showTextDocument ~document:(`TextDocument doc)
        ~column:ViewColumn.Beside ()
    in
    Ok ()

let reload_pp_doc instance ~document =
  let open Promise.Syntax in
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  let visibleTextEditors = Window.visibleTextEditors () in
  let origin_uri_opt =
    Ast_editor_state.find_original_doc_by_pp_uri ast_editor_state
      (TextDocument.uri document)
  in
  match origin_uri_opt with
  | None -> Promise.return (Error "Failed finding the original document URI.")
  | Some origin_uri -> (
    let* original_document =
      Workspace.openTextDocument (`Uri (Uri.parse origin_uri ()))
    in
    match
      List.find visibleTextEditors ~f:(fun editor ->
          document_eq (TextEditor.document editor) document)
    with
    | None -> Promise.return (Error "Visible editor wasn't found")
    | Some _ -> (
      match fetch_pp_code ~document:original_document with
      | Error (Io_error err_msg)
      | Error (Read_error err_msg) ->
        Promise.return (Error err_msg)
      | Ok content ->
        replace_document_content ~content ~document;
        Promise.return (Ok ())))

let rec manage_choice instance choice ~document =
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  match choice with
  | Some `Update
  | Some `Retry ->
    let webview_opt =
      let ast_editor_state = Extension_instance.ast_editor_state instance in
      Ast_editor_state.find_webview_by_doc ast_editor_state
        (TextDocument.uri document)
    in
    let res =
      (match
         (Ast_editor_state.pp_status ast_editor_state)
           (TextDocument.uri document)
       with
      | `Original ->
        (Ast_editor_state.remove_dirty_original_doc ast_editor_state)
          ~pp_uri:(TextDocument.uri document);
        reload_pp_doc
      | `Absent_or_pped -> open_preprocessed_doc_to_the_side)
        instance ~document
    in
    (*Find and update the webview*)
    (match
       Ast_editor_state.find_original_doc_by_pp_uri ast_editor_state
         (TextDocument.uri document)
     with
    | Some uri ->
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let+ document = Workspace.openTextDocument (`Uri (Uri.parse uri ())) in
        refresh_ast_explorer instance ~document ~webview_opt
      in
      ()
    | None -> refresh_ast_explorer instance ~document ~webview_opt);
    res
  | Some `Abandon
  | None ->
    Promise.return (Error "Operation has been abandoned.")

and manage_open_failure err_msg instance ~document =
  let open Promise.Syntax in
  let* choice =
    Window.showInformationMessage
      ~message:(err_msg ^ " Please make sure your project is built and retry.")
      ~choices:[ ("Retry", `Retry); ("Abandon", `Abandon) ]
      ()
  in
  manage_choice instance choice ~document

and open_preprocessed_doc_to_the_side instance ~document =
  let open Promise.Syntax in
  let* result = open_pp_doc instance ~document in
  match result with
  | Ok () -> Promise.return (Ok ())
  | Error (Io_error err_msg)
  | Error (Read_error err_msg) ->
    manage_open_failure err_msg instance ~document

let open_both_ppx_ast instance ~document =
  let open Promise.Syntax in
  let* pp_doc_open = open_preprocessed_doc_to_the_side instance ~document in
  match pp_doc_open with
  | Ok _ -> open_ast_explorer ~uri:(TextDocument.uri document)
  | Error e ->
    show_message `Error "%s" e;
    Promise.return ()

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
      let document = TextEditor.document textEditor in
      let webview_opt =
        let ast_editor_state = Extension_instance.ast_editor_state instance in
        Ast_editor_state.find_webview_by_doc ast_editor_state
          (TextDocument.uri document)
      in
      let offset =
        let selection = Vscode.TextEditor.selection textEditor in
        let position = Vscode.Selection.start selection in
        TextDocument.offsetAt document ~position
      in

      match webview_opt with
      | Some webview -> send_msg "focus" (Ojs.int_to_js offset) ~webview
      | None ->
        show_message `Warn
          "Wrong output modee inside the AST explorer, please select the \
           correct tab"
    in

    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.reveal_ast_node handler

  let _switch_hover_mode =
    let handler (instance : Extension_instance.t) ~textEditor ~edit:_ ~args:_ =
      let ast_editor_state = Extension_instance.ast_editor_state instance in
      let hover_dispoable =
        match Ast_editor_state.get_hover_disposable ast_editor_state with
        | Some d ->
          Disposable.dispose d;
          None
        | None ->
          activate_hover_mode instance
            ~document:(TextEditor.document textEditor)
      in
      Ast_editor_state.set_hover_disposable ast_editor_state hover_dispoable
    in

    Extension_commands.register_text_editor
      ~id:Extension_consts.Commands.switch_hover_mode handler

  let _show_preprocessed_document =
    let handler (instance : Extension_instance.t) ~textEditor ~edit:_ ~args:_ =
      let document = TextEditor.document textEditor in
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let+ (_ : (unit, string) result) =
          open_preprocessed_doc_to_the_side instance ~document
        in
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
  let onDidChange =
    let event_emitter = EventEmitter.make () in
    EventEmitter.event event_emitter
  in
  let provideTextDocumentContent ~uri:_ ~token:_ : string ProviderResult.t =
    `Value (Some "")
  in
  TextDocumentContentProvider.create ~provideTextDocumentContent ~onDidChange ()

let manage_changed_origin instance ~document =
  let open Promise.Syntax in
  let* choice =
    Window.showInformationMessage
      ~message:
        "The original document has been changed, please rebuild the project \
         and update."
      ~choices:[ ("Update", `Update); ("Cancel", `Abandon) ]
      ()
  in
  manage_choice instance choice ~document

let onDidSaveTextDocument_listener_pp instance document =
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  Ast_editor_state.on_origin_update_content ast_editor_state
    (TextDocument.uri document)

let onDidChangeActiveTextEditor_listener instance e =
  let ast_editor_state = Extension_instance.ast_editor_state instance in
  if not (TextEditor.t_to_js e |> Ojs.is_null) then
    let document = TextEditor.document e in
    match
      Ast_editor_state.pp_status ast_editor_state (TextDocument.uri document)
    with
    | `Absent_or_pped -> ()
    | `Original ->
      let (_ : (unit, string) result Promise.t) =
        manage_changed_origin instance ~document
      in
      ()

let close_visible_editors_by_uri uri =
  let f e =
    let visibleDocument = TextEditor.document e in
    let open Promise.Syntax in
    if String.equal uri (Uri.toString (TextDocument.uri visibleDocument) ())
    then
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
  Ast_editor_state.remove_doc_entries ast_editor_state
    (TextDocument.uri document);
  close_visible_editors_by_uri (Uri.toString (TextDocument.uri document) ())

let register extension instance =
  let editorProvider =
    `CustomEditorProvider
      (CustomTextEditorProvider.create
         ~resolveCustomTextEditor:(resolveCustomTextEditor instance))
  in
  let disposable =
    Window.onDidChangeActiveTextEditor ()
      ~listener:(onDidChangeActiveTextEditor_listener instance)
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
      ~listener:(onDidCloseTextDocument_listener instance)
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
      ~listener:(onDidSaveTextDocument_listener_pp instance)
      ()
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
