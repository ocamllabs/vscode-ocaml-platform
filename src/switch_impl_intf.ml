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

let insert_inferred_intf source_uri client editor =
  let open Promise.Syntax in
  if String.is_suffix source_uri ~suffix:".ml" then
    (* If the source file was a .ml, infer the interface *)
    let+ inferred_intf = send_infer_intf_request client source_uri in
    let (_ : bool Promise.t) =
      TextEditor.edit editor
        ~callback:(fun ~editBuilder ->
          TextEditorEdit.insert editBuilder
            ~location:(Position.make ~line:1 ~character:1)
            ~value:inferred_intf)
        ()
    in
    ()
  else
    Promise.return ()

(* given a file uri, opens the file if it exists; otherwise, creates the file
   but doesn't write it to disk *)
let show_file target_uri =
  let open Promise.Syntax in
  let uri = Uri.parse target_uri () in
  let* doc, new_file =
    Workspace.openTextDocument (`Uri uri)
    |> Promise.then_
         ~fulfilled:(fun doc -> Promise.return (doc, false))
         ~rejected:(fun (_ : Promise.error) ->
           (* if file does not exist *)
           let create_file_uri = Uri.with_ uri ~scheme:"untitled" () in
           let+ doc = Workspace.openTextDocument (`Uri create_file_uri) in
           (doc, true))
  in
  let+ editor = Window.showTextDocument ~document:(`TextDocument doc) () in
  (editor, new_file)

let request_switch client document =
  let open Promise.Syntax in
  let source_uri =
    Uri.toString (TextDocument.uri document) ~skipEncoding:true ()
  in
  let* arr = send_switch_impl_intf_request client source_uri in
  match Array.to_list arr with
  | [] ->
    (* 'ocamllsp/switchImplIntf' command's response array cannot be empty *)
    assert false
  | [ filepath ] -> (
    let* result = show_file filepath in
    match result with
    | editor, true -> insert_inferred_intf source_uri client editor
    | _ -> Promise.return () )
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
    | Some filepath -> (
      let* result = show_file filepath in
      match result with
      | editor, true -> insert_inferred_intf source_uri client editor
      | _ -> Promise.return () ) )
