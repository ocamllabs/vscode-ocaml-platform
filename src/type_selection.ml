open Import
module Request = Custom_requests.Type_selection

module Options = struct
  open Settings

  let outputChannelResults =
    create_setting
      ~scope:ConfigurationTarget.Workspace
      ~key:"ocaml.commands.typeSelection.outputChannelResults"
      ~of_json:Jsonoo.Decode.bool
      ~to_json:Jsonoo.Encode.bool
  ;;

  let alwaysClearOutputChannel =
    create_setting
      ~scope:ConfigurationTarget.Workspace
      ~key:"ocaml.commands.typeSelection.alwaysClearOutputChannel"
      ~of_json:Jsonoo.Decode.bool
      ~to_json:Jsonoo.Encode.bool
  ;;
end

let register_hover_provider ~type_ range () =
  let provider =
    let provideHover ~(document : TextDocument.t) ~(position : Position.t) ~token:_ =
      ignore (document, position);
      let hover =
        let contents =
          let markdown_string = MarkdownString.make ~value:"" () in
          `MarkdownString
            (MarkdownString.appendCodeblock
               markdown_string
               ~value:type_
               ~language:"ocaml"
               ())
        in
        Hover.make ~contents ~range ()
      in
      `Value (Some hover)
    in
    HoverProvider.create ~provideHover
  in
  Vscode.Languages.registerHoverProvider ~selector:(`String "ocaml") ~provider
;;

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
;;

type state =
  { initial_range : Range.t
  ; text_editor : TextEditor.t
  ; mutable last_result : Request.response option
  ; mutable current_verbosity : int
  ; mutable reset_disposable : Disposable.t
  }

let state : state option ref = ref None
let active_range (result : Request.response) = result.enclosings.(result.index)

let next_index state =
  match state.last_result with
  | None -> 0
  | Some result ->
    let number_or_enclosings = Array.length result.enclosings in
    min (result.index + 1) (number_or_enclosings - 1)
;;

let get_enclosings ?index text_editor client state =
  let doc = TextEditor.document text_editor in
  let uri = TextDocument.uri doc in
  let index = Option.value_lazy ~default:(fun () -> next_index state) index in
  let at = `Range state.initial_range in
  let verbosity = state.current_verbosity in
  Custom_requests.(
    send_request
      client
      Type_selection.request
      (Type_selection.make ~uri ~at ~index ~verbosity))
;;

let update_selection text_editor range =
  let new_selection =
    Selection.makePositions ~anchor:(Range.end_ range) ~active:(Range.start range)
  in
  TextEditor.set_selection text_editor new_selection
;;

let output_channel =
  Window.createOutputChannel ~name:"OCaml: Type of selection" ~languageId:"ocaml" ()
;;

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
  (match Settings.(get Options.alwaysClearOutputChannel) with
   | Some true -> OutputChannel.replace output_channel ~value:header
   | None | Some false -> OutputChannel.append output_channel ~value:header);
  OutputChannel.appendLine output_channel ~value:type_;
  OutputChannel.appendLine output_channel ~value:""
;;

(* To display customized information in the hover tooltip we need to register a
   custom hover provider. However this does not prevent the standard hover
   provider from showing which creates duplication and cluttering in the popup.

   Ideally we should be able to un-register the default hover provider easily on
   the client side, but that's actually not something that is possible to do
   with the official lsp client for vscode. The "builtin" feature is [registered here](
   https://github.com/microsoft/vscode-languageserver-node/blob/906f5fb306e1f6059cbdcb1efd962647222b5867/client/src/common/client.ts#L1970)
   and the handler is not accessible. It might be possible to use dynamic
   registration to activate / deactivate it, but that's an initiative of the
   server and it doesn't feel like the correct way around.

   The present solution is to use an ad-hoc server option that allows the client
   to mute the defaut hover responses (the server will answer with an empty
   response.). *)
let display_type instance text_editor ({ type_; _ } as result : Request.response) =
  let set_hover_active true_or_false =
    Extension_instance.set_configuration instance ~standard_hover:(Some true_or_false) ()
  in
  let range = active_range result in
  update_selection text_editor range;
  show_in_output_channel text_editor ~type_ range;
  let () = set_hover_active false in
  (* Mute the standard hover provider *)
  let hover_provider_disposable = register_hover_provider ~type_ range () in
  let open Promise.Syntax in
  let+ _ = Command_api.(execute Vscode.show_hover) [] in
  let () = set_hover_active true in
  (* Un-mute the standard hover provider *)
  Disposable.dispose hover_provider_disposable
;;

let with_checks ~extension_name ~instance f =
  match Window.activeTextEditor () with
  | None ->
    Command_api.Command_errors.text_editor_must_be_active
      extension_name
      ~expl:"The command relies on the current editor selection."
    |> show_message `Error "%s"
    |> Promise.return
  | Some text_editor ->
    (match Extension_instance.lsp_client instance with
     | None -> show_message `Warn "ocamllsp is not running" |> Promise.return
     | Some (_, ocaml_lsp) when not (Ocaml_lsp.can_handle_type_selection ocaml_lsp) ->
       ocaml_lsp_doesnt_support_type_selection instance ocaml_lsp |> Promise.return
     | Some (client, _) -> f text_editor client)
;;

let extension_name = "Type Selection"

(* We should reset the state if the selection change or the user switches
   editor *)
let enable_reset () =
  let onDidChangeTextEditorSelection_listener event =
    let selections = TextEditorSelectionChangeEvent.selections event in
    let not_last_range (result : Request.response) range =
      let other = result.enclosings.(result.index) in
      not (Range.isEqual ~other range)
    in
    Option.iter !state ~f:(fun last_state ->
      match last_state.last_result, selections with
      | Some last_result, [ s ] when not_last_range last_result (Selection.to_range s) ->
        Disposable.dispose last_state.reset_disposable;
        state := None
      | _ -> ())
  in
  let onDidChangeActiveTextEditor_listener _text_editor =
    match !state with
    | Some current_state ->
      Disposable.dispose current_state.reset_disposable;
      state := None
    | _ -> ()
  in
  [ (let listener = onDidChangeTextEditorSelection_listener in
     Window.onDidChangeTextEditorSelection () ~listener ())
  ; (let listener = onDidChangeActiveTextEditor_listener in
     Window.onDidChangeActiveTextEditor () ~listener ())
  ]
;;

(* There might be duplicates in the enclosing list which are complex to filter
   out on the server-side for performance reasons *)
let is_duplicate last_result result =
  match last_result with
  | None -> false
  | Some last_result ->
    let last_range = active_range last_result in
    let other = active_range result in
    Range.isEqual last_range ~other && String.equal last_result.type_ result.type_
;;

let last_index state =
  match state.last_result with
  | None -> -1
  | Some last_result -> last_result.index
;;

let rec type_selection ~instance ?(verbosity = 0) () =
  with_checks ~extension_name ~instance
  @@ fun text_editor client ->
  let open Promise.Syntax in
  let state =
    match !state with
    | Some state -> state
    | None ->
      let initial_range = TextEditor.selection text_editor |> Selection.to_range in
      let new_state =
        { initial_range
        ; text_editor
        ; current_verbosity = 0
        ; last_result = None
        ; reset_disposable = Disposable.from @@ enable_reset ()
        }
      in
      state := Some new_state;
      new_state
  in
  state.current_verbosity <- verbosity;
  let* result = get_enclosings text_editor client state in
  match result.enclosings with
  | [||] ->
    show_message `Warn "No results found for that selection.";
    Promise.return ()
  | _ ->
    let previous_result = state.last_result in
    let previous_index = last_index state in
    state.last_result <- Some result;
    if is_duplicate previous_result result && next_index state > previous_index
    then type_selection ~instance ()
    else display_type instance text_editor result
;;

let handler (instance : Extension_instance.t) ~args:_ =
  let (_ : unit Promise.t) = type_selection ~instance () in
  ()
;;

let extension_name = "Type Previous Selection"

let previous_handler (instance : Extension_instance.t) ~args:_ =
  let type_previous_selection () =
    with_checks ~extension_name ~instance
    @@ fun text_editor client ->
    let open Promise.Syntax in
    match !state with
    | None -> Promise.return @@ show_message `Warn "There is no previous selection"
    | Some state ->
      let index = max 0 (last_index state - 1) in
      let* result = get_enclosings text_editor client ~index state in
      state.last_result <- Some result;
      display_type instance text_editor result
  in
  let (_ : unit Promise.t) = type_previous_selection () in
  ()
;;

let extension_name = "Increase Selection Type Verbosity"

let verbosity_handler (instance : Extension_instance.t) ~args:_ =
  let bump_selection_type_verbosity () =
    with_checks ~extension_name ~instance
    @@ fun text_editor client ->
    let open Promise.Syntax in
    match !state with
    | None -> type_selection ~instance ~verbosity:1 ()
    | Some state ->
      let index =
        match state.last_result with
        | None -> 0
        | Some last_result -> last_result.index
      in
      state.current_verbosity <- state.current_verbosity + 1;
      let* result = get_enclosings text_editor client ~index state in
      display_type instance text_editor result
  in
  let (_ : unit Promise.t) = bump_selection_type_verbosity () in
  ()
;;
