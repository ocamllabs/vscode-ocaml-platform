open Import

module Lsp : sig
  val switch : LanguageClient.t -> TextDocument.t -> string array Promise.t
end = struct
  let switch client document =
    let targetFileName : string array Promise.t =
      LanguageClient.sendRequest client ~meth:"ocamllsp/switchImplIntf"
        ~data:(document.TextDocument.fileName : string)
        ()
    in
    targetFileName
end

module Fallback : sig
  val switch : string -> string array Promise.t
end = struct
  let impl = [ ".ml"; ".mll"; ".mly"; ".re" ]

  let intf = [ ".mli"; ".rei" ]

  let switchTo exts withoutExt =
    Promise.List.find_map exts ~f:(fun ext ->
        let targetFileName = withoutExt ^ ext in
        let open Promise.O in
        Fs.exists targetFileName >>| function
        | true -> Some targetFileName
        | false -> None)

  (* let switch fileName =
     let ext = Filename.extension fileName in
     let withoutExt = Filename.remove_extension fileName in
     if List.mem ext intf then
       switchTo impl withoutExt
     else if List.mem ext impl then
       switchTo intf withoutExt
     else
       Promise.return None *)

  let switch _ = failwith "not implemented" (* FIXME *)
end

(** switches from the given document to an opposing document, e.g., from ml to mli file,
    if that file exists; otherwise, creates that opposing file *)
let requestSwitch ~client ~capabilities document =
  (* given a file uri, opens the file if it exists;
     otherwise, creates the file but doesn't write it to disk *)
  let showFile targetFileName =
    let open Promise.O in
    Vscode.Workspace.openTextDocument (`Uri (Uri.file targetFileName))
    |> Js.Promise.catch (fun _ ->
           (* if file does not exist *)
           let untitledSchemeUri = "untitled:" ^ targetFileName in
           let createFileUri = Uri.parse untitledSchemeUri in
           Vscode.Workspace.openTextDocument (`Uri createFileUri))
    >>= fun doc ->
    Vscode.Window.showTextDocument (`Document doc) >>| fun _ -> ()
  in

  let filesToSwitchTo =
    match (client, capabilities) with
    | Some client, Some capabilities
      when OcamlLsp.handleSwitchImplIntf capabilities ->
      Lsp.switch client document
    | _ ->
      log "using fallback mechanism to switch implementation/interface";
      Fallback.switch document.TextDocument.fileName
  in

  let open Promise.O in
  filesToSwitchTo >>= fun arr ->
  match Array.to_list arr with
  | [] ->
    failwith
      "all files must be mapped (can be switched to) to at least one file"
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
