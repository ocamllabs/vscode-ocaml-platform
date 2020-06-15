open Import

let selectSandboxCommandId = "ocaml.select-sandbox"

let openTerminalCommandId = "ocaml.open-terminal"

module Client = struct
  let make () : Vscode.LanguageClient.clientOptions =
    let documentSelector : Vscode.LanguageClient.documentSelectorItem array =
      [| { scheme = "file"; language = "ocaml" }
       ; { scheme = "file"; language = "ocaml.interface" }
       ; { scheme = "file"; language = "reason" }
      |]
    in
    let revealOutputChannelOn =
      Vscode.LanguageClient.RevealOutputChannelOn.tToJs Never
    in
    Vscode.LanguageClient.clientOptions ~documentSelector ~revealOutputChannelOn
      ()
end

module Server = struct
  let make (toolchain : Toolchain.resources) :
      Vscode.LanguageClient.serverOptions =
    let command, args = Toolchain.getLspCommand toolchain in
    { command = Path.toString command; args; options = { env = Process.env } }
end

module Instance = struct
  type t =
    { mutable client : LanguageClient.t option
    ; mutable statusBarItem : StatusBarItem.t option
    ; mutable terminalSandbox : TerminalSandbox.t option
    ; duneFormatter : DuneFormatter.t
    ; duneTaskProvider : DuneTaskProvider.t
    }

  let create () =
    { client = None
    ; statusBarItem = None
    ; terminalSandbox = None
    ; duneFormatter = DuneFormatter.create ()
    ; duneTaskProvider = DuneTaskProvider.create ()
    }

  let stop t =
    DuneFormatter.dispose t.duneFormatter;
    DuneTaskProvider.dispose t.duneTaskProvider;

    ( match t.terminalSandbox with
    | None -> ()
    | Some (terminalSandbox : TerminalSandbox.t) ->
      TerminalSandbox.dispose terminalSandbox;
      t.terminalSandbox <- None );

    ( match t.statusBarItem with
    | None -> ()
    | Some (statusBarItem : StatusBarItem.t) ->
      StatusBarItem.dispose statusBarItem;
      t.statusBarItem <- None );

    match t.client with
    | None -> ()
    | Some (client : LanguageClient.t) ->
      LanguageClient.stop client;
      t.client <- None

  let start t toolchain =
    DuneFormatter.register t.duneFormatter toolchain;

    let statusBarItem =
      Window.createStatusBarItem ~alignment:StatusBarAlignment.(tToJs Left) ()
    in
    let statusBarText = Toolchain.toString toolchain in
    statusBarItem##text#=statusBarText;
    statusBarItem##command#=selectSandboxCommandId;
    StatusBarItem.show statusBarItem;
    t.statusBarItem <- Some statusBarItem;

    let open Promise.Result.O in
    Toolchain.runSetup toolchain >>= fun () ->
    let serverOptions = Server.make toolchain in
    let client =
      LanguageClient.make ~id:"ocaml" ~name:"OCaml Language Server"
        ~serverOptions ~clientOptions:(Client.make ())
    in
    t.client <- Some client;
    LanguageClient.start client;

    t.terminalSandbox <- Some (TerminalSandbox.create toolchain);

    let open Promise.O in
    LanguageClient.initializeResult client >>| fun initializeResult ->
    let ocamlLsp = OcamlLsp.ofInitializeResult initializeResult in
    if not (OcamlLsp.interfaceSpecificLangId ocamlLsp) then
      message `Warn
        "ocamllsp in this toolchain is out of date, functionality will not be \
         available in mli sources. Please update to a recent version and \
         restart the server.";
    Ok ()

  let openTerminal t () =
    match Option.(t.terminalSandbox >>= TerminalSandbox.openTerminal) with
    | Some _ -> ()
    | None ->
      message `Error
        "Could not open a terminal in the current sandbox. The toolchain may \
         not have loaded yet."

  let disposable t = Disposable.create ~dispose:(fun () -> stop t)
end

let selectSandbox (instance : Instance.t) () =
  let setToolchain =
    let open Promise.O in
    Toolchain.selectAndSave () >>= function
    | None -> Promise.Result.return ()
    | Some t ->
      Instance.stop instance;
      let t = Toolchain.makeResources t in
      Instance.start instance t
  in
  let (_ : unit Promise.t) =
    Promise.Result.iterError setToolchain ~f:Window.showErrorMessage
  in
  ()

let suggestToSetupToolchain instance =
  let open Promise.O in
  Vscode.Window.showInformationMessage'
    "Extension is unable to find ocamllsp automatically. Please select package \
     manager you used to install ocamllsp for this project."
    [ ("Select package manager", ()) ]
  >>| function
  | None -> ()
  | Some () -> selectSandbox instance ()

let activate (extension : Vscode.ExtensionContext.t) =
  Js.Dict.set Process.env "OCAML_LSP_SERVER_LOG" "-";
  let instance = Instance.create () in
  Vscode.ExtensionContext.subscribe extension
    (Vscode.Commands.register ~command:selectSandboxCommandId
       ~handler:(selectSandbox instance));
  Vscode.ExtensionContext.subscribe extension
    (Vscode.Commands.register ~command:openTerminalCommandId
       ~handler:(Instance.openTerminal instance));
  Vscode.ExtensionContext.subscribe extension (Instance.disposable instance);
  let open Promise.O in
  let toolchain =
    Toolchain.ofSettings () >>| fun pm ->
    let resources, isFallback =
      match pm with
      | Some toolchain -> (toolchain, false)
      | None ->
        let (_ : unit Promise.t) = suggestToSetupToolchain instance in
        (Toolchain.PackageManager.Global, true)
    in
    (Toolchain.makeResources resources, isFallback)
  in
  toolchain >>= fun (toolchain, isFallback) ->
  Instance.start instance toolchain
  |> Promise.Result.iterError ~f:(fun e ->
         if isFallback then
           Promise.resolve ()
         else
           Window.showErrorMessage e)
  |> Promise.catch (fun e ->
         let message = Node.JsError.ofPromiseError e in
         message `Error "Error: %s" message)
