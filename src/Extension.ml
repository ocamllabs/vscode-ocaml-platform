open Import

let selectSandboxCommandId = "ocaml.select-sandbox"

let restartCommandId = "ocaml.server.restart"

let openTerminalCommandId = "ocaml.open-terminal"

let openTerminalSelectCommandId = "ocaml.open-terminal-select"

module Client = struct
  let make () : Vscode.LanguageClient.clientOptions =
    let documentSelector : Vscode.LanguageClient.documentSelectorItem array =
      [| { scheme = "file"; language = "ocaml" }
       ; { scheme = "file"; language = "ocaml.interface" }
       ; { scheme = "file"; language = "ocaml.ocamllex" }
       ; { scheme = "file"; language = "ocaml.menhir" }
       ; { scheme = "file"; language = "reason" }
      |]
    in
    let (lazy outputChannel) = Output.languageServerOutputChannel in
    let revealOutputChannelOn =
      Vscode.LanguageClient.RevealOutputChannelOn.tToJs Never
    in
    Vscode.LanguageClient.clientOptions ~documentSelector ~outputChannel
      ~revealOutputChannelOn ()
end

module Server = struct
  let make (toolchain : Toolchain.resources) :
      Vscode.LanguageClient.serverOptions =
    let command = Toolchain.getLspCommand toolchain in
    Cmd.log command;
    let env = Process.env in
    match command with
    | Shell commandLine ->
      { command = commandLine; args = [||]; options = { env; shell = true } }
    | Spawn { bin; args } ->
      { command = Path.toString bin
      ; args = Array.of_list args
      ; options = { env; shell = false }
      }
end

module Instance = struct
  type t =
    { mutable toolchain : Toolchain.resources option
    ; mutable client : LanguageClient.t option
    ; mutable statusBarItem : StatusBarItem.t option
    ; duneFormatter : DuneFormatter.t
    ; duneTaskProvider : DuneTaskProvider.t
    }

  let create () =
    { toolchain = None
    ; client = None
    ; statusBarItem = None
    ; duneFormatter = DuneFormatter.create ()
    ; duneTaskProvider = DuneTaskProvider.create ()
    }

  let stop t =
    DuneFormatter.dispose t.duneFormatter;
    DuneTaskProvider.dispose t.duneTaskProvider;

    Option.iter t.statusBarItem ~f:(fun statusBarItem ->
        StatusBarItem.dispose statusBarItem;
        t.statusBarItem <- None);

    Option.iter t.client ~f:(fun client ->
        LanguageClient.stop client;
        t.client <- None);

    t.toolchain <- None

  let start t toolchain =
    t.toolchain <- Some toolchain;

    DuneFormatter.register t.duneFormatter toolchain;
    DuneTaskProvider.register t.duneTaskProvider toolchain;

    let statusBarItem =
      Window.createStatusBarItem ~alignment:StatusBarAlignment.(tToJs Left) ()
    in
    let packageManager = Toolchain.packageManager toolchain in
    let statusBarText =
      let packageIcon =
        "$(package)"
        (* see https://code.visualstudio.com/api/references/icons-in-labels *)
      in
      Printf.sprintf "%s %s" packageIcon
      @@ Toolchain.PackageManager.toPrettyString packageManager
    in
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

    let open Promise.O in
    LanguageClient.initializeResult client >>| fun initializeResult ->
    let ocamlLsp = OcamlLsp.ofInitializeResult initializeResult in
    if not (OcamlLsp.interfaceSpecificLangId ocamlLsp) then
      message `Warn
        "ocamllsp in this toolchain is out of date, functionality will not be \
         available in mli sources. Please update to a recent version and \
         restart the server.";
    Ok ()

  let openTerminal toolchain =
    let open Option in
    toolchain |> TerminalSandbox.create >>| TerminalSandbox.show
    |> iterNone ~f:(fun () ->
           message `Error
             "Could not open a terminal in the current sandbox. The toolchain \
              may not have loaded yet.")

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

let restartInstance (instance : Instance.t) () =
  let (_ : unit Promise.t) =
    let open Promise.O in
    Toolchain.ofSettings () >>= function
    | None ->
      selectSandbox instance ();
      Promise.return ()
    | Some toolchain ->
      Instance.stop instance;
      Instance.start instance (Toolchain.makeResources toolchain)
      |> Promise.Result.iterError ~f:Window.showErrorMessage
  in
  ()

let selectSandboxAndOpenTerminal () =
  let (_ : unit Promise.t) =
    Toolchain.select ()
    |> Promise.Option.iter (fun toolchain ->
           let toolchain = Toolchain.makeResources toolchain in
           Instance.openTerminal toolchain)
  in
  ()

let openTerminal (instance : Instance.t) () =
  match instance.toolchain with
  | None -> selectSandboxAndOpenTerminal ()
  | Some toolchain -> Instance.openTerminal toolchain

let suggestToSetupToolchain instance =
  let open Promise.O in
  Vscode.Window.showInformationMessage'
    "Extension is unable to find ocamllsp automatically. Please select package \
     manager you used to install ocamllsp for this project."
    [ ("Select package manager", ()) ]
  >>| function
  | None -> ()
  | Some () -> selectSandbox instance ()

let registerCommands extension =
  List.iter (function command, handler ->
      Vscode.ExtensionContext.subscribe extension
        (Vscode.Commands.register ~command ~handler))

let activate (extension : Vscode.ExtensionContext.t) =
  Js.Dict.set Process.env "OCAML_LSP_SERVER_LOG" "-";
  let instance = Instance.create () in
  registerCommands extension
    [ (selectSandboxCommandId, selectSandbox instance)
    ; (restartCommandId, restartInstance instance)
    ; (openTerminalCommandId, openTerminal instance)
    ; (openTerminalSelectCommandId, selectSandboxAndOpenTerminal)
    ];
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
