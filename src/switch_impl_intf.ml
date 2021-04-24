open Import

let send_switch_impl_intf_request client uri : string array Promise.t =
  let data = Jsonoo.Encode.string uri in
  let open Promise.Syntax in
  let+ response =
    LanguageClient.sendRequest client ~meth:"ocamllsp/switchImplIntf" ~data ()
  in
  Jsonoo.Decode.(array string) response

let send_infer_intf_request client uri : string Promise.t =
  let data = Jsonoo.Encode.string uri in
  let open Promise.Syntax in
  let+ response =
    LanguageClient.sendRequest client ~meth:"ocamllsp/inferIntf" ~data ()
  in
  Jsonoo.Decode.string response

let insert_inferred_intf ~source_uri client text_editor =
  let open Promise.Syntax in
  (* XXX this seems sketchy. shouldn't it work for reason as well? *)
  match String.is_suffix source_uri ~suffix:".ml" with
  | false -> Promise.return ()
  | true ->
    (* If the source file was a .ml, infer the interface *)
    let* inferred_intf = send_infer_intf_request client source_uri in
    let+ edit_applied =
      TextEditor.edit text_editor
        ~callback:(fun ~editBuilder ->
          TextEditorEdit.insert editBuilder
            ~location:(Position.make ~line:1 ~character:1)
            ~value:inferred_intf)
        ()
    in
    if not edit_applied then
      show_message `Error "Unable to insert inferred interface"

let request_switch client document =
  let open Promise.Syntax in
  let source_uri =
    Uri.toString (TextDocument.uri document) ~skipEncoding:true ()
  in
  let fill_intf_if_empty_untitled text_editor =
    let doc = TextEditor.document text_editor in
    let is_empty_doc doc = TextDocument.getText doc () |> String.is_empty in
    if TextDocument.isUntitled doc && is_empty_doc doc then
      insert_inferred_intf ~source_uri client text_editor
    else
      Promise.return ()
  in
  let* arr = send_switch_impl_intf_request client source_uri in
  match Array.to_list arr with
  | [] ->
    (* 'ocamllsp/switchImplIntf' command's response array cannot be empty *)
    assert false
  | [ file_uri ] ->
    let* text_editor = open_file_in_text_editor file_uri in
    fill_intf_if_empty_untitled text_editor
  | first_candidate :: other_candidates as candidates -> (
    let first_candidate_item =
      QuickPickItem.create
        ~label:(Stdlib.Filename.basename first_candidate)
        ~picked:true ()
    in

    let rest_candidate_items =
      List.map
        ~f:(fun c ->
          QuickPickItem.create ~label:(Stdlib.Filename.basename c) ())
        other_candidates
    in

    let candidate_items_with_names =
      List.zip_exn (first_candidate_item :: rest_candidate_items) candidates
    in

    let file_options =
      QuickPickOptions.create ~canPickMany:false ~placeHolder:"Open a file..."
        ()
    in

    let open Promise.Syntax in
    let* choice =
      Window.showQuickPickItems ~choices:candidate_items_with_names
        ~options:file_options ()
    in
    match choice with
    | None -> Promise.return ()
    | Some file_uri ->
      let* text_editor = open_file_in_text_editor file_uri in
      fill_intf_if_empty_untitled text_editor)
