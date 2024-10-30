open Import

let decorationType =
  let options =
    let before =
      ThemableDecorationAttachmentRenderOptions.create
        ~backgroundColor:
          (`ThemeColor (ThemeColor.make ~id:"editorHoverWidget.background"))
        ~color:
          (`ThemeColor (ThemeColor.make ~id:"editorHoverWidget.foreground"))
        ~border:"1px solid"
        ~borderColor:
          (`ThemeColor (ThemeColor.make ~id:"editorHoverWidget.border"))
        ~textDecoration:
          "none;position:absolute;z-index:1;bottom:100%;padding:0.3em"
        ()
    in
    DecorationRenderOptions.create ~before ()
  in
  Window.createTextEditorDecorationType ~options

let extension_name = "Type Enclosing"

let ocaml_lsp_doesnt_support_type_enclosing instance ocaml_lsp =
  match
    Ocaml_lsp.is_version_up_to_date
      ocaml_lsp
      (Extension_instance.ocaml_version_exn instance)
  with
  | Ok () -> ()
  | Error (`Msg msg) ->
    show_message
      `Warn
      "The installed version of `ocamllsp` does not support type enclosings. %s"
      msg

let get_enclosings text_editor client ~index range =
  let doc = TextEditor.document text_editor in
  let uri = TextDocument.uri doc in
  Custom_requests.(
    send_request
      client
      Type_enclosing.request
      (Type_enclosing.make ~uri ~at:(`Range range) ~index ~verbosity:0))

type state =
  { next : Range.t option
  ; previous : Range.t list
  ; reset_disposable : Disposable.t
  }

let initial_state =
  { next = None; previous = []; reset_disposable = Disposable.from [] }

let state = ref initial_state

let enable_reset () =
  let onDidChangeTextEditorSelection_listener event =
    let text_editor = TextEditorSelectionChangeEvent.textEditor event in
    let selections = TextEditorSelectionChangeEvent.selections event in
    match (!state.previous, selections) with
    | other :: _, [ s ] when not (Range.isEqual ~other (Selection.to_range s))
      ->
      show_message `Info "HIDE";
      log_value "Previous" @@ Range.t_to_js other;
      log_value "New" @@ Range.t_to_js (Selection.to_range s);
      TextEditor.setDecorations
        text_editor
        ~decorationType
        ~rangesOrOptions:(`Options []);
      Disposable.dispose !state.reset_disposable;
      state := initial_state
    | _ -> ()
  in
  let reset_disposable =
    let listener event =
      let listener = onDidChangeTextEditorSelection_listener in
      Handlers.unpwrap (Handlers.w1 listener event)
    in
    Window.onDidChangeTextEditorSelection () ~listener ()
  in
  state := { !state with reset_disposable }

let set_decoration text_editor range type_ =
  let decorationOptions =
    let renderOptions =
      let before =
        ThemableDecorationAttachmentRenderOptions.create ~contentText:type_ ()
      in
      let options = ThemableDecorationInstanceRenderOptions.create ~before () in
      Some
        (DecorationInstanceRenderOptions.create ~light:options ~dark:options ())
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

let update_selection text_editor ~type_ state =
  let range = List.hd_exn (* todo *) state.previous in
  let new_selection =
    Selection.makePositions
      ~anchor:(Range.start range)
      ~active:(Range.end_ range)
  in
  set_decoration text_editor range type_;
  TextEditor.set_selection text_editor new_selection

let handler (instance : Extension_instance.t) ~args:_ =
  let type_enclosing () =
    match Window.activeTextEditor () with
    | None ->
      Extension_consts.Command_errors.text_editor_must_be_active
        extension_name
        ~expl:"The command use the "
      |> show_message `Error "%s" |> Promise.return
    | Some text_editor -> (
      match Extension_instance.lsp_client instance with
      | None -> show_message `Warn "ocamllsp is not running" |> Promise.return
      | Some (_, ocaml_lsp)
        when not (Ocaml_lsp.can_handle_type_enclosing ocaml_lsp) ->
        ocaml_lsp_doesnt_support_type_enclosing instance ocaml_lsp
        |> Promise.return
      | Some (client, _) -> (
        let open Promise.Syntax in
        let range =
          match !state.next with
          | Some range -> range
          | None -> TextEditor.selection text_editor |> Selection.to_range
        in
        let+ result = get_enclosings text_editor client ~index:0 range in
        match result.enclosings with
        | current :: _ ->
          let () = if List.is_empty !state.previous then enable_reset () in
          let next =
            List.find result.enclosings ~f:(fun other ->
                not (Range.isEqual current ~other))
          in
          state := { !state with next; previous = current :: !state.previous };
          update_selection text_editor ~type_:result.type_ !state;
          show_message `Info " Type: %s" result.type_
        | [] -> show_message `Warn "No results found for that selection."))
  in
  let (_ : unit Promise.t) = type_enclosing () in
  ()
