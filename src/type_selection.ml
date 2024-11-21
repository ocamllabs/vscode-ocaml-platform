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

let ocaml_lsp_doesnt_support_type_selection instance ocaml_lsp =
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
      Type_selection.request
      (Type_selection.make ~uri ~at:(`Range range) ~index ~verbosity:0))

type state =
  { initial_range : Range.t
  ; enclosings : Range.t array
  ; mutable current_index : int
  ; mutable reset_disposable : Disposable.t
  }

let state : state option ref = ref None

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
    DecorationOptions.create ~range ~renderOptions ()
  in
  let rangesOrOptions = `Options [ decorationOptions ] in
  TextEditor.setDecorations text_editor ~decorationType ~rangesOrOptions

let update_selection text_editor ~type_ range =
  let new_selection =
    Selection.makePositions
      ~anchor:(Range.start range)
      ~active:(Range.end_ range)
  in
  set_decoration text_editor range type_;
  TextEditor.set_selection text_editor new_selection

let with_checks ~extension_name ~instance f =
  match Window.activeTextEditor () with
  | None ->
    Extension_consts.Command_errors.text_editor_must_be_active
      extension_name
      ~expl:"The command relies on the current editor selection."
    |> show_message `Error "%s" |> Promise.return
  | Some text_editor -> (
    match Extension_instance.lsp_client instance with
    | None -> show_message `Warn "ocamllsp is not running" |> Promise.return
    | Some (_, ocaml_lsp)
      when not (Ocaml_lsp.can_handle_type_selection ocaml_lsp) ->
      ocaml_lsp_doesnt_support_type_selection instance ocaml_lsp
      |> Promise.return
    | Some (client, _) -> f text_editor client)

let extension_name = "Type Selection"

let next_index state =
  let number_or_results = Array.length state.enclosings in
  min (state.current_index + 1) (number_or_results - 1)

let enable_reset () =
  let onDidChangeTextEditorSelection_listener event =
    let text_editor = TextEditorSelectionChangeEvent.textEditor event in
    let selections = TextEditorSelectionChangeEvent.selections event in
    match (!state, selections) with
    | Some current_state, [ s ]
      when not
             (Range.isEqual
                ~other:current_state.enclosings.(current_state.current_index)
                (Selection.to_range s)) ->
      show_message `Info "HIDE";
      TextEditor.setDecorations
        text_editor
        ~decorationType
        ~rangesOrOptions:(`Options []);
      Disposable.dispose current_state.reset_disposable;
      state := None
    | _ -> ()
  in
  let listener event =
    let listener = onDidChangeTextEditorSelection_listener in
    Handlers.unpwrap (Handlers.w1 listener event)
  in
  Window.onDidChangeTextEditorSelection () ~listener ()

let update_or_init_state ~initial_range ~current_index enclosings =
  let enclosings = Array.of_list enclosings in
  match !state with
  | None ->
    let new_state =
      { initial_range
      ; enclosings
      ; current_index
      ; reset_disposable = enable_reset ()
      }
    in
    state := Some new_state;
    new_state
  | Some state ->
    state.current_index <- current_index;
    state

let handler (instance : Extension_instance.t) ~args:_ =
  let type_selection () =
    with_checks ~extension_name ~instance @@ fun text_editor client ->
    let open Promise.Syntax in
    let initial_range, index =
      match !state with
      | Some state -> (state.initial_range, next_index state)
      | None ->
        let initial_range =
          TextEditor.selection text_editor |> Selection.to_range
        in
        (initial_range, 0)
    in
    let+ result = get_enclosings text_editor client ~index initial_range in
    match result.enclosings with
    | [] -> show_message `Warn "No results found for that selection."
    | enclosings ->
      let state =
        update_or_init_state ~initial_range ~current_index:index enclosings
      in
      let result_range = state.enclosings.(state.current_index) in
      update_selection text_editor ~type_:result.type_ result_range
  in
  let (_ : unit Promise.t) = type_selection () in
  ()

let extension_name = "Type Previous Selection"

let previous_handler (instance : Extension_instance.t) ~args:_ =
  let type_previous_selection () =
    with_checks ~extension_name ~instance @@ fun text_editor client ->
    let open Promise.Syntax in
    match !state with
    | None ->
      Promise.return @@ show_message `Warn "There is no previous selection"
    | Some state ->
      let index = max 0 (state.current_index - 1) in
      let+ result =
        get_enclosings text_editor client ~index state.initial_range
      in
      state.current_index <- index;
      let result_range = state.enclosings.(state.current_index) in
      update_selection text_editor ~type_:result.type_ result_range
  in
  let (_ : unit Promise.t) = type_previous_selection () in
  ()
