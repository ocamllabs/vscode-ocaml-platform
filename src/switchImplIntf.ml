open Import

module Lsp : sig
  val switch : LanguageClient.t -> TextDocument.t -> string array Promise.t
end = struct
  let switch client document =
    let targetFileName : string array Promise.t =
      LanguageClient.sendRequest client ~meth:"ocamllsp/didSwitchImplIntf"
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

let requestSwitch ~client ~capabilities document =
  let showFile targetFileName =
    Window.showTextDocument (`Uri (Uri.file targetFileName)) |> ignore
  in

  let onPromiseError error =
    let errorMessage = Node.JsError.ofPromiseError error in
    let showSwitchError error =
      message `Error "Error when switching implementation/interface: %s" error
    in
    showSwitchError errorMessage;
    Promise.return ()
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
  filesToSwitchTo >>= fun arr -> match Array.to_list arr with
  | [] -> assert false
  | [ filepath ] -> Promise.return @@ showFile filepath
  | firstCandidate :: otherCandidates as candidates ->
    let firstCandidateItem =
      Window.QuickPickItem.create
        ~label:(Filename.basename firstCandidate)
        ~picked:true ()
    in

    let otherCandidateItems =
      List.map
        (fun c -> Window.QuickPickItem.create ~label:(Filename.basename c) ())
        otherCandidates
    in

    let options =
      Window.QuickPickOptions.make ~canPickMany:false
        ~placeHolder:"Create a file:" ()
    in

    let open Promise.O in
    Window.showQuickPickItems
      (List.combine (firstCandidateItem :: otherCandidateItems) candidates)
      options
    >>= function
    | None -> Promise.return ()
    | Some filepath ->
      Fs.writeFile filepath "" >>| fun () ->
      showFile filepath

