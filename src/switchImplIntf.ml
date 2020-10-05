open Import

let sendSwitchImplIntfRequest client document : string array Promise.t =
  let data =
    Uri.toString (TextDocument.uri document) ~skipEncoding:true ()
    |> Jsonoo.Encode.string
  in
  let open Promise.Syntax in
  LanguageClient.sendRequest client ~meth:"ocamllsp/switchImplIntf" ~data ()
  >>| Jsonoo.Decode.(array string)

(* given a file uri, opens the file if it exists;
     otherwise, creates the file but doesn't write it to disk *)
let showFile targetFileName =
  let open Promise.Syntax in
  let uri = Uri.parse targetFileName () in
  Workspace.openTextDocument (`Uri uri)
  |> Promise.catch ~rejected:(fun _ ->
         (* if file does not exist *)
         let createFileUri = Uri.with_ uri ~scheme:"untitled" () in
         Workspace.openTextDocument (`Uri createFileUri))
  >>= fun doc ->
  Window.showTextDocument ~document:(`TextDocument doc) () >>| fun _ -> ()

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
      QuickPickOptions.create ~canPickMany:false ~placeHolder:"Open a file..."
        ()
    in

    let open Promise.Syntax in
    Window.showQuickPickItems ~choices:candidateItemsWithNames
      ~options:file_options ()
    >>= function
    | None -> Promise.return ()
    | Some filepath -> showFile filepath )
