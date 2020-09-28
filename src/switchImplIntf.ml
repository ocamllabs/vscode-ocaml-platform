open Import

let sendSwitchImplIntfRequest client document : string array Promise.t =
  let data =
    Uri.to_string (TextDocument.uri document) ~skip_encoding:true ()
    |> Jsonoo.Encode.string
  in
  let open Promise.Syntax in
  LanguageClient.send_request client ~meth:"ocamllsp/switchImplIntf" ~data ()
  >>| Jsonoo.Decode.(array string)

(* given a file uri, opens the file if it exists;
     otherwise, creates the file but doesn't write it to disk *)
let showFile targetFileName =
  let open Promise.Syntax in
  let uri = Uri.parse targetFileName () in
  Workspace.open_text_document (`Uri uri)
  |> Promise.catch ~rejected:(fun _ ->
         (* if file does not exist *)
         let createFileUri = Uri.with_ uri ~scheme:"untitled" () in
         Workspace.open_text_document (`Uri createFileUri))
  >>= fun doc ->
  Window.show_text_document ~document:(`TextDocument doc) () >>| fun _ -> ()

let requestSwitch client document =
  let open Promise.Syntax in
  sendSwitchImplIntfRequest client document >>= fun arr ->
  match Array.to_list arr with
  | [] ->
    (* 'ocamllsp/switchImplIntf' command's response array cannot be empty *)
    assert false
  | [ filepath ] -> showFile filepath
  | firstCandidate :: otherCandidates as candidates -> (
    let fstCandidateItem =
      QuickPickItem.create
        ~label:(Filename.basename firstCandidate)
        ~picked:true ()
    in

    let restCandidateItems =
      List.map
        (fun c -> QuickPickItem.create ~label:(Filename.basename c) ())
        otherCandidates
    in

    let candidateItemsWithNames =
      List.combine (fstCandidateItem :: restCandidateItems) candidates
    in

    let file_options =
      QuickPickOptions.create ~can_pick_many:false
        ~place_holder:"Open a file..." ()
    in

    let open Promise.Syntax in
    Window.show_quick_pick_items ~choices:candidateItemsWithNames
      ~options:file_options ()
    >>= function
    | None -> Promise.return ()
    | Some filepath -> showFile filepath )
