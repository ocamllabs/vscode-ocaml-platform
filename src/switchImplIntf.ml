open Import

let sendSwitchImplIntfRequest client document : string array Promise.t =
  LanguageClient.sendRequest client ~meth:"ocamllsp/switchImplIntf"
    ~data:(Uri.toString document.TextDocument.uri ~skipEncoding:true ())
    ()

(* given a file uri, opens the file if it exists;
     otherwise, creates the file but doesn't write it to disk *)
let showFile targetFileName =
  let open Promise.O in
  let uri = Uri.parse targetFileName in
  Vscode.Workspace.openTextDocument (`Uri uri)
  |> Js.Promise.catch (fun _ ->
         (* if file does not exist *)
         let createFileUri =
           Uri.with_ uri @@ Uri.make_change ~scheme:"untitled" ()
         in
         Vscode.Workspace.openTextDocument (`Uri createFileUri))
  >>= fun doc ->
  Vscode.Window.showTextDocument (`Document doc) >>| fun _ -> ()

let requestSwitch client document =
  let open Promise.O in
  sendSwitchImplIntfRequest client document >>= fun arr ->
  match Array.to_list arr with
  | [] ->
    (* 'ocamllsp/switchImplIntf' command's response array cannot be empty *)
    assert false
  | [ filepath ] -> showFile filepath
  | firstCandidate :: otherCandidates as candidates -> (
    let fstCandidateItem =
      Window.QuickPickItem.create
        ~label:(Filename.basename firstCandidate)
        ~picked:true ()
    in

    let restCandidateItems =
      List.map
        (fun c -> Window.QuickPickItem.create ~label:(Filename.basename c) ())
        otherCandidates
    in

    let candidateItemsWithNames =
      List.combine (fstCandidateItem :: restCandidateItems) candidates
    in

    let file_options =
      Window.QuickPickOptions.make ~canPickMany:false
        ~placeHolder:"Open a file..." ()
    in

    let open Promise.O in
    Window.showQuickPickItems candidateItemsWithNames file_options >>= function
    | None -> Promise.return ()
    | Some filepath -> showFile filepath )
