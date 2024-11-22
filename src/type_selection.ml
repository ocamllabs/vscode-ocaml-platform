open Import

module Options = struct
  open Settings

  let outputChannelResults =
    create_setting
      ~scope:ConfigurationTarget.Workspace
      ~key:"ocaml.server.typeSelection.outputChannelResults"
      ~of_json:Jsonoo.Decode.bool
      ~to_json:Jsonoo.Encode.bool

  let alwaysClearOutputChannel =
    create_setting
      ~scope:ConfigurationTarget.Workspace
      ~key:"ocaml.server.typeSelection.alwaysClearOutputChannel"
      ~of_json:Jsonoo.Decode.bool
      ~to_json:Jsonoo.Encode.bool
end

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

let get_enclosings text_editor client ~index ~verbosity range =
  let doc = TextEditor.document text_editor in
  let uri = TextDocument.uri doc in
  Custom_requests.(
    send_request
      client
      Type_selection.request
      (Type_selection.make ~uri ~at:(`Range range) ~index ~verbosity))

type state =
  { initial_range : Range.t
  ; enclosings : Range.t array
  ; text_editor : TextEditor.t
  ; mutable current_index : int
  ; mutable current_verbosity : int
  ; mutable reset_disposable : Disposable.t
  }

let state : state option ref = ref None

let set_decoration text_editor range type_ =
  let decorationOptions =
    let contentText = String.split_lines type_ |> String.concat ~sep:" " in
    let renderOptions =
      let before =
        ThemableDecorationAttachmentRenderOptions.create ~contentText ()
      in
      let options = ThemableDecorationInstanceRenderOptions.create ~before () in
      Some
        (DecorationInstanceRenderOptions.create ~light:options ~dark:options ())
    in
    DecorationOptions.create ~range ~renderOptions ()
  in
  let rangesOrOptions = `Options [ decorationOptions ] in
  TextEditor.setDecorations text_editor ~decorationType ~rangesOrOptions

let update_selection text_editor range =
  let new_selection =
    Selection.makePositions
      ~anchor:(Range.start range)
      ~active:(Range.end_ range)
  in
  TextEditor.set_selection text_editor new_selection

let output_channel =
  Window.createOutputChannel
    ~name:"OCaml: Type of selection"
    ~languageId:"ocaml"
    ()

let show_in_output_channel text_editor ~type_ range =
  let doc =
    let uri = TextEditor.document text_editor |> TextDocument.uri in
    Uri.path uri
  in
  let line =
    let pos = Range.start range in
    Position.line pos
  in
  let header = Printf.sprintf "(* Line %i, file://%s *)\n" line doc in
  (match Settings.(get Options.outputChannelResults) with
  | None | Some true -> OutputChannel.show output_channel ~preserveFocus:true ()
  | Some false -> ());
  (match Settings.(get Options.outputChannelResults) with
  | Some true -> OutputChannel.replace output_channel ~value:header
  | None | Some false -> OutputChannel.append output_channel ~value:header);
  OutputChannel.appendLine output_channel ~value:type_;
  OutputChannel.appendLine output_channel ~value:""

let display_type text_editor ~type_ range =
  update_selection text_editor range;
  show_in_output_channel text_editor ~type_ range;
  set_decoration text_editor range type_

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

(* We should reset the state if the selection change or the user switches
   editor *)
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
      TextEditor.setDecorations
        text_editor
        ~decorationType
        ~rangesOrOptions:(`Options []);
      Disposable.dispose current_state.reset_disposable;
      state := None
    | _ -> ()
  in
  let onDidChangeActiveTextEditor_listener _text_editor =
    match !state with
    | Some current_state ->
      TextEditor.setDecorations
        current_state.text_editor
        ~decorationType
        ~rangesOrOptions:(`Options []);
      Disposable.dispose current_state.reset_disposable;
      state := None
    | _ -> ()
  in
  [ (let listener event =
       let listener = onDidChangeTextEditorSelection_listener in
       Handlers.unpwrap (Handlers.w1 listener event)
     in
     Window.onDidChangeTextEditorSelection () ~listener ())
  ; (let listener event =
       let listener = onDidChangeActiveTextEditor_listener in
       Handlers.unpwrap (Handlers.w1 listener event)
     in
     Window.onDidChangeActiveTextEditor () ~listener ())
  ]

let update_or_init_state ~initial_range ~current_index ~current_verbosity
    text_editor enclosings =
  let enclosings = Array.of_list enclosings in
  match !state with
  | None ->
    let new_state =
      { initial_range
      ; enclosings
      ; current_index
      ; text_editor
      ; current_verbosity
      ; reset_disposable = Disposable.from @@ enable_reset ()
      }
    in
    state := Some new_state;
    new_state
  | Some state ->
    state.current_index <- current_index;
    state.current_verbosity <- current_verbosity;
    state

let handler (instance : Extension_instance.t) ~args:_ =
  let type_selection () =
    with_checks ~extension_name ~instance @@ fun text_editor client ->
    let open Promise.Syntax in
    let initial_range, index, verbosity =
      match !state with
      | Some state ->
        (state.initial_range, next_index state, state.current_verbosity)
      | None ->
        let initial_range =
          TextEditor.selection text_editor |> Selection.to_range
        in
        (initial_range, 0, 0)
    in
    let+ result =
      get_enclosings text_editor client ~index ~verbosity initial_range
    in
    match result.enclosings with
    | [] -> show_message `Warn "No results found for that selection."
    | enclosings ->
      let state =
        update_or_init_state
          ~initial_range
          ~current_index:index
          ~current_verbosity:0
          text_editor
          enclosings
      in
      let result_range = state.enclosings.(state.current_index) in
      display_type text_editor ~type_:result.type_ result_range
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
      let verbosity = 0 in
      let+ result =
        get_enclosings text_editor client ~index ~verbosity state.initial_range
      in
      state.current_index <- index;
      state.current_verbosity <- verbosity;
      let result_range = state.enclosings.(state.current_index) in
      display_type text_editor ~type_:result.type_ result_range
  in
  let (_ : unit Promise.t) = type_previous_selection () in
  ()

let extension_name = "Increase Selection Type Verbosity"

let verbosity_handler (instance : Extension_instance.t) ~args:_ =
  let bump_selection_type_verbosity () =
    with_checks ~extension_name ~instance @@ fun text_editor client ->
    let open Promise.Syntax in
    match !state with
    | None ->
      Promise.return @@ show_message `Warn "There is no previous selection"
    | Some state ->
      let index = state.current_index in
      let verbosity = state.current_verbosity + 1 in
      let+ result =
        get_enclosings text_editor client ~index ~verbosity state.initial_range
      in
      state.current_index <- index;
      state.current_verbosity <- verbosity;
      let result_range = state.enclosings.(state.current_index) in
      display_type text_editor ~type_:result.type_ result_range
  in
  let (_ : unit Promise.t) = bump_selection_type_verbosity () in
  ()
