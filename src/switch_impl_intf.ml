open Import

let send_switch_impl_intf_request client uri : string array Promise.t =
  let data = Json.Encode.string uri in
  let open Promise.Syntax in
  let+ response =
    Language_client.send_request client ~meth:"ocamllsp/switchImplIntf" ~data ()
  in
  Json.Decode.(array string) response

let send_infer_intf_request client uri : string Promise.t =
  let data = Json.Encode.string uri in
  let open Promise.Syntax in
  let+ response =
    Language_client.send_request client ~meth:"ocamllsp/inferIntf" ~data ()
  in
  Json.Decode.string response

let insert_inferred_intf ~source_uri client text_editor =
  let open Promise.Syntax in
  (* XXX this seems sketchy. shouldn't it work for reason as well? *)
  match String.is_suffix source_uri ~suffix:".ml" with
  | false -> Promise.return ()
  | true ->
    (* If the source file was a .ml, infer the interface *)
    let* inferred_intf = send_infer_intf_request client source_uri in
    let+ edit_applied =
      Text_editor.edit text_editor
        (fun edit_builder ->
          Text_editor_edit.insert edit_builder
            ~location:(Position.make ~line:1 ~character:1)
            ~value:inferred_intf)
        ()
    in
    if not edit_applied then
      show_message `Error "Unable to insert inferred interface"

let request_switch client document =
  let open Promise.Syntax in
  let source_uri =
    Uri.to_string (Text_document.uri document) ~skip_encoding:true ()
  in
  let fill_intf_if_empty_untitled text_editor =
    let doc = Text_editor.document text_editor in
    let is_empty_doc doc = Text_document.get_text doc () |> String.is_empty in
    if Text_document.is_untitled doc && is_empty_doc doc then
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
      Quick_pick_item.create
        ~label:(Stdlib.Filename.basename first_candidate)
        ~picked:true ()
    in

    let rest_candidate_items =
      List.map
        ~f:(fun c ->
          Quick_pick_item.create ~label:(Stdlib.Filename.basename c) ())
        other_candidates
    in

    let candidate_items_with_names =
      List.zip_exn (first_candidate_item :: rest_candidate_items) candidates
    in

    let file_options =
      Quick_pick_options.create ~can_pick_many:false
        ~place_holder:"Open a file..." ()
    in

    let open Promise.Syntax in
    let* choice =
      show_quick_pick_items candidate_items_with_names ~options:file_options ()
    in
    match choice with
    | None -> Promise.return ()
    | Some file_uri ->
      let* text_editor = open_file_in_text_editor file_uri in
      fill_intf_if_empty_untitled text_editor)
