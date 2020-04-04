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
    { command; args; options = { env = Process.env } }
end

let activate _context =
  Js.Dict.set Process.env "OCAMLRUNPARAM" "b";
  Js.Dict.set Process.env "OCAML_LSP_SERVER_LOG" "-";
  let projectRoot = Fpath.ofString Workspace.rootPath in
  Toolchain.makeResources ~projectRoot Global
  |> Promise.Result.bind (fun toolchain ->
         Toolchain.runSetup toolchain
         |> Promise.Result.bind (fun () ->
                let serverOptions = Server.make toolchain in
                let client =
                  LanguageClient.make ~id:"ocaml" ~name:"OCaml Language Server"
                    ~serverOptions ~clientOptions:(Client.make ())
                in
                (client.start () [@bs]);
                Promise.resolve (Ok ())))
  |> handleError Window.showErrorMessage
  |> Promise.catch (fun e ->
         let message = Node.JsError.ofPromiseError e in
         Window.showErrorMessage {j|Error: $message|j})
