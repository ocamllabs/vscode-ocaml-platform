open Import

module Lsp : sig
  val switch : LanguageClient.t -> TextDocument.t -> string option Promise.t
end = struct
  let switch client document =
    let targetFileName : string option Promise.t =
      LanguageClient.sendRequest client ~meth:"ocamllsp/didSwitchImplIntf"
        ~data:(document.TextDocument.fileName : string)
        ()
    in
    targetFileName
end

module Fallback : sig
  val switch : string -> string option Promise.t
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

  let switch fileName =
    let ext = Filename.extension fileName in
    let withoutExt = Filename.remove_extension fileName in
    if List.mem ext intf then
      switchTo impl withoutExt
    else if List.mem ext impl then
      switchTo intf withoutExt
    else
      Promise.return None
end

let showSwitchError error =
  message `Error "Error when switching implementation/interface: %s" error

let requestSwitch ~client ~capabilities document =
  let targetFileName =
    match (client, capabilities) with
    | Some client, Some capabilities
      when OcamlLsp.handleSwitchImplIntf capabilities ->
      Lsp.switch client document
    | _ ->
      log "using fallback mechanism to switch implementation/interface";
      Fallback.switch document.TextDocument.fileName
  in

  let showFile = function
    | Some targetFileName ->
      let (_ : TextEditor.t Promise.t) =
        Window.showTextDocument (`Uri (Uri.file targetFileName))
      in
      ()
    | None -> showSwitchError "Could not find a suitable file to switch to"
  in

  let onPromiseError error =
    let errorMessage = Node.JsError.ofPromiseError error in
    showSwitchError errorMessage;
    Promise.return ()
  in

  let open Promise.O in
  targetFileName >>| showFile |> Promise.catch onPromiseError
