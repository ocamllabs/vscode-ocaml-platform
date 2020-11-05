open Import

let send_switch_impl_intf_request client document : string array Promise.t =
  let data =
    Uri.toString (TextDocument.uri document) ~skipEncoding:true ()
    |> Jsonoo.Encode.string
  in
  let open Promise.Syntax in
  let+ response =
    LanguageClient.sendRequest client ~meth:"ocamllsp/switchImplIntf" ~data ()
  in
  Jsonoo.Decode.(array string) response

(* given a file uri, opens the file if it exists;
     otherwise, creates the file but doesn't write it to disk *)
let show_file target_file_name =
  let open Promise.Syntax in
  let uri = Uri.parse target_file_name () in
  let* doc =
    Workspace.openTextDocument (`Uri uri)
    |> Promise.catch ~rejected:(fun _ ->
           (* if file does not exist *)
           let create_file_uri = Uri.with_ uri ~scheme:"untitled" () in
           Workspace.openTextDocument (`Uri create_file_uri))
  in
  let+ (_ : TextEditor.t) =
    Window.showTextDocument ~document:(`TextDocument doc) ()
  in
  ()

let request_switch client document =
  let open Promise.Syntax in
  let* arr = send_switch_impl_intf_request client document in
  match Array.to_list arr with
  | [] ->
    (* 'ocamllsp/switchImplIntf' command's response array cannot be empty *)
    assert false
  | [ filepath ] -> show_file filepath
  | first_candidate :: other_candidates as candidates -> (
    let first_candidate_item =
      QuickPickItem.create
        ~label:(Filename.basename first_candidate)
        ~picked:true ()
    in

    let rest_candidate_items =
      List.map
        ~f:(fun c -> QuickPickItem.create ~label:(Filename.basename c) ())
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
    | Some filepath -> show_file filepath)
