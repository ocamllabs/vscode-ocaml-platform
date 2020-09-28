open Import

let selectSandboxCommandId = "ocaml.select-sandbox"

let restartCommandId = "ocaml.server.restart"

let openTerminalCommandId = "ocaml.open-terminal"

let openTerminalSelectCommandId = "ocaml.open-terminal-select"

let switchImplIntfCommandId = "ocaml.switch-impl-intf"

module Client = struct
  let make () : Vscode.LanguageClient.ClientOptions.t =
    let document_selector =
      LanguageClient.DocumentSelector.
        [| language "ocaml"
         ; language "ocaml.interface"
         ; language "ocaml.ocamllex"
         ; language "ocaml.menhir"
         ; language "reason"
        |]
    in
    let (lazy output_channel) = Output.languageServerOutputChannel in
    let reveal_output_channel_on =
      Vscode.LanguageClient.RevealOutputChannelOn.Never
    in
    Vscode.LanguageClient.ClientOptions.create ~document_selector
      ~output_channel ~reveal_output_channel_on ()
end

module Server = struct
  let make (toolchain : Toolchain.resources) : LanguageClient.ServerOptions.t =
    let command = Toolchain.getLspCommand toolchain in
    Cmd.log command;
    let env = Process.env () in
    match command with
    | Shell command ->
      let options =
        LanguageClient.ExecutableOptions.create ~env ~shell:true ()
      in
      LanguageClient.Executable.create ~command ~options ()
    | Spawn { bin; args } ->
      let command = Path.toString bin in
      let options =
        LanguageClient.ExecutableOptions.create ~env ~shell:false ()
      in
      LanguageClient.Executable.create ~command ~args ~options ()
end

module Instance = struct
  type t =
    { mutable toolchain : Toolchain.resources option
    ; mutable client : LanguageClient.t option
    ; mutable ocamlLspCapabilities : OcamlLsp.t option
    ; mutable statusBarItem : StatusBarItem.t option
    ; duneFormatter : DuneFormatter.t
    ; duneTaskProvider : DuneTaskProvider.t
    }

  let create () =
    { toolchain = None
    ; client = None
    ; ocamlLspCapabilities = None
    ; statusBarItem = None
    ; duneFormatter = DuneFormatter.create ()
    ; duneTaskProvider = DuneTaskProvider.create ()
    }

  let stop t =
    DuneFormatter.dispose t.duneFormatter;
    DuneTaskProvider.dispose t.duneTaskProvider;

    Core_kernel.Option.iter t.statusBarItem ~f:(fun statusBarItem ->
        StatusBarItem.dispose statusBarItem;
        t.statusBarItem <- None);

    Core_kernel.Option.iter t.client ~f:(fun client ->
        LanguageClient.stop client;
        t.client <- None);

    t.ocamlLspCapabilities <- None;
    t.toolchain <- None

  let start t toolchain =
    t.toolchain <- Some toolchain;

    DuneFormatter.register t.duneFormatter toolchain;
    DuneTaskProvider.register t.duneTaskProvider toolchain;

    let statusBarItem =
      Window.create_status_bar_item ~alignment:StatusBarAlignment.Left ()
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
    StatusBarItem.set_text statusBarItem statusBarText;
    StatusBarItem.set_command statusBarItem (`String selectSandboxCommandId);
    StatusBarItem.show statusBarItem;
    t.statusBarItem <- Some statusBarItem;

    let open Promise.Result.Syntax in
    Toolchain.runSetup toolchain >>= fun () ->
    let server_options = Server.make toolchain in
    let client_options = Client.make () in
    let client =
      LanguageClient.make ~id:"ocaml" ~name:"OCaml Language Server"
        ~server_options ~client_options ()
    in
    t.client <- Some client;
    LanguageClient.start client;

    let open Promise.Syntax in
    LanguageClient.ready_initialize_result client >>| fun initializeResult ->
    let ocamlLsp = OcamlLsp.ofInitializeResult initializeResult in
    t.ocamlLspCapabilities <- Some ocamlLsp;
    if
      (not (OcamlLsp.interfaceSpecificLangId ocamlLsp))
      || not (OcamlLsp.canHandleSwitchImplIntf ocamlLsp)
    then
      message `Warn
        "The installed version of ocamllsp is out of date. Some features may \
         be unavailable or degraded in functionality: switching between \
         implementation and interface files, functionality in mli sources. \
         Consider updating ocamllsp.";
    Ok ()

  let openTerminal toolchain =
    let open Core_kernel.Option.Monad_infix in
    match toolchain |> TerminalSandbox.create >>| TerminalSandbox.show with
    | Some _ -> ()
    | None ->
      message `Error
        "Could not open a terminal in the current sandbox. The toolchain may \
         not have loaded yet."

  let disposable t = Disposable.make ~dispose:(fun () -> stop t)
end

let selectSandbox (instance : Instance.t) () =
  let setToolchain =
    let open Promise.Syntax in
    Toolchain.selectAndSave () >>= function
    | None -> Promise.Result.return ()
    | Some t ->
      Instance.stop instance;
      let t = Toolchain.makeResources t in
      Instance.start instance t
  in
  let (_ : unit Promise.t) =
    Promise.Result.iter setToolchain ~error:(message `Error "%s")
  in
  ()

let restartInstance (instance : Instance.t) () =
  let (_ : unit Promise.t) =
    let open Promise.Syntax in
    Toolchain.ofSettings () >>= function
    | None ->
      selectSandbox instance ();
      Promise.return ()
    | Some toolchain ->
      Instance.stop instance;
      Instance.start instance (Toolchain.makeResources toolchain)
      |> Promise.Result.iter ~error:(message `Error "%s")
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

let switchImplIntf (instance : Instance.t) () =
  let trySwitching () =
    let open Core_kernel.Option.Monad_infix in
    Window.active_text_editor () >>| TextEditor.document >>= fun document ->
    instance.client >>= fun client ->
    (* extension needs to be activated; otherwise, just ignore the switch try *)
    instance.ocamlLspCapabilities >>| fun ocamlLsp ->
    (* same as for instance.client; ignore the try if it's None *)
    if OcamlLsp.canHandleSwitchImplIntf ocamlLsp then
      SwitchImplIntf.requestSwitch client document
    else
      (* if, however, ocamllsp doesn't have the capability, recommend updating ocamllsp*)
      Promise.return
      @@ message `Warn
           "The installed version of ocamllsp does not support switching \
            between implementation and interface files. Consider updating \
            ocamllsp."
  in
  ignore @@ trySwitching ()

let suggestToSetupToolchain instance =
  let open Promise.Syntax in
  Vscode.Window.show_information_message
    ~message:
      "Extension is unable to find ocamllsp automatically. Please select \
       package manager you used to install ocamllsp for this project."
    ~choices:[ ("Select package manager", ()) ]
    ()
  >>| function
  | None -> ()
  | Some () -> selectSandbox instance ()

let registerCommands extension =
  List.iter (function command, callback ->
      let callback ~args:_ = callback () in
      Vscode.ExtensionContext.subscribe extension
        ~disposable:(Vscode.Commands.register_command ~command ~callback))

let activate (extension : Vscode.ExtensionContext.t) =
  Process.set_env "OCAML_LSP_SERVER_LOG" "-";
  let instance = Instance.create () in
  registerCommands extension
    [ (selectSandboxCommandId, selectSandbox instance)
    ; (restartCommandId, restartInstance instance)
    ; (openTerminalCommandId, openTerminal instance)
    ; (openTerminalSelectCommandId, selectSandboxAndOpenTerminal)
    ; (switchImplIntfCommandId, switchImplIntf instance)
    ];
  Vscode.ExtensionContext.subscribe extension
    ~disposable:(Instance.disposable instance);
  let open Promise.Syntax in
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
  |> Promise.Result.iter ~error:(fun e ->
         if not isFallback then message `Error "%s" e)
  |> Promise.catch ~rejected:(fun e ->
         let error_message = Node.JsError.ofPromiseError e in
         message `Error "Error: %s" error_message;
         Promise.return ())

let _ =
  Js_of_ocaml.Js.export_all
    (object%js
       method activate extension = activate extension
    end)
