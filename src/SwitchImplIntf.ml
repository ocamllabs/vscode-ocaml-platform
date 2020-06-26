open Import

module Lsp : sig
  val switch : LanguageClient.t -> TextDocument.t -> string option Promise.t
end = struct
  let switch client document =
    let targetFileName : string option Promise.t =
      LanguageClient.sendRequest client "ocaml/didSwitchImplIntf"
        (document : TextDocument.t)
        ()
    in
    targetFileName |> Promise.catch (fun _ -> Promise.return None)
end

module Fallback : sig
  val switch : string -> string option
end = struct
  let impl = [ ".ml"; ".mll"; ".mly"; ".re" ]

  let intf = [ ".mli"; ".rei" ]

  let switchTo exts withoutExt =
    List.find_map exts ~f:(fun ext ->
        let targetFileName = withoutExt ^ ext in
        if Fs.existsSync targetFileName then
          Some targetFileName
        else
          None)

  let switch fileName =
    let ext = Filename.extension fileName in
    let withoutExt = Filename.remove_extension fileName in
    if List.mem ext intf then
      switchTo impl withoutExt
    else if List.mem ext impl then
      switchTo intf withoutExt
    else
      None
end

let requestSwitch client document =
  let tryLsp = function
    | Some client -> Lsp.switch client document
    | None -> Promise.return None
  in
  let tryFallback = function
    | None ->
      log "using fallback mechanism to switch implementation/interface";
      Fallback.switch document.TextDocument.fileName
    | Some _ as s -> s
  in
  let open Promise.O in
  tryLsp client >>| tryFallback >>| function
  | None -> message `Error "Could not find a suitable file to switch to."
  | Some targetFileName ->
    let (_ : TextEditor.t Promise.t) =
      Window.showTextDocument (`Uri (Uri.file targetFileName))
    in
    ()
