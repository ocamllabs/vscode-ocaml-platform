open Import

let handleError f =
  Promise.then_ (function
    | Ok () -> Promise.resolve ()
    | Error msg -> f msg)

module Client = struct
  let make () : Vscode.LanguageClient.clientOptions =
    { documentSelector =
        [| { scheme = "file"; language = "ocaml" }
         ; { scheme = "file"; language = "reason" }
        |]
    }
end

module Server = struct
  let make (toolchain : Toolchain.resources) :
      Vscode.LanguageClient.serverOptions =
    let command, args = Toolchain.getLspCommand toolchain in
    { command = Path.toString command; args; options = { env = Process.env } }
end

module Instance = struct
  type t = LanguageClient.t option ref

  let create () = ref None

  let stop t =
    match !t with
    | None -> ()
    | Some (client : LanguageClient.t) ->
      client.stop () [@bs];
      t := None

  let start t toolchain =
    let open Promise.Result.O in
    Toolchain.runSetup toolchain >>| fun () ->
    let serverOptions = Server.make toolchain in
    let client =
      LanguageClient.make ~id:"ocaml" ~name:"OCaml Language Server"
        ~serverOptions ~clientOptions:(Client.make ())
    in
    t := Some client;
    client.start () [@bs]
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
    "There is no toolchain attached to this project."
    [ ("select toolchain", ()) ]
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
    let resources =
      match pm with
      | None ->
        let (_ : unit Promise.t) = suggestToSetupToolchain instance in
        Toolchain.PackageManager.Global
      | Some toolchain -> toolchain
    in
    Toolchain.makeResources resources
  in
  toolchain >>= fun toolchain ->
  Instance.start instance toolchain
  |> handleError Window.showErrorMessage
  |> Promise.catch (fun e ->
         let message = Node.JsError.ofPromiseError e in
         Window.showErrorMessage {j|Error: $message|j})
