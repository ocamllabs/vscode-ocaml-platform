open Import

let handleError f =
  Promise.then_ (function
    | Ok () -> Promise.resolve ()
    | Error msg -> f msg)

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
    ; duneFormatter : DuneFormatter.t
    }

  let create () = { client = None; duneFormatter = DuneFormatter.create () }

  let stop t =
    DuneFormatter.dispose t.duneFormatter;
    match t.client with
    | None -> ()
    | Some (client : LanguageClient.t) ->
      client.stop () [@bs];
      t.client <- None

  let start t toolchain =
    DuneFormatter.register t.duneFormatter toolchain;
    let open Promise.Result.O in
    Toolchain.runSetup toolchain >>= fun () ->
    let serverOptions = Server.make toolchain in
    let client =
      LanguageClient.make ~id:"ocaml" ~name:"OCaml Language Server"
        ~serverOptions ~clientOptions:(Client.make ())
    in
    t.client <- Some client;
    client.start () [@bs];

    let open Promise.O in
    LanguageClient.onReady client >>| fun _ ->
    client.initializeResult.capabilities.experimental.ocamlInterface
    |> Js.Nullable.toOption
    |> function
    | Some true -> Ok ()
    | _ -> Error "ocamllsp is out of date. Please update to the latest version."
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
  let (_ : unit Promise.t) = handleError Window.showErrorMessage setToolchain in
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

let activate _context =
  Js.Dict.set Process.env "OCAML_LSP_SERVER_LOG" "-";
  let instance = Instance.create () in
  Vscode.Commands.register ~command:"ocaml.select-sandbox"
    ~handler:(selectSandbox instance);
  let open Promise.O in
  let toolchain =
    Toolchain.ofSettings () >>| fun pm ->
    let resources, isFallback =
      match pm with
      | None ->
        let (_ : unit Promise.t) = suggestToSetupToolchain instance in
        (Toolchain.PackageManager.Global, true)
      | Some toolchain -> (toolchain, false)
    in
    (Toolchain.makeResources resources, isFallback)
  in
  toolchain >>= fun (toolchain, isFallback) ->
  Instance.start instance toolchain
  |> handleError (fun e ->
         if isFallback then
           Promise.resolve ()
         else
           Window.showErrorMessage e)
  |> Promise.catch (fun e ->
         let message = Node.JsError.ofPromiseError e in
         Window.showErrorMessage {j|Error: $message|j})
