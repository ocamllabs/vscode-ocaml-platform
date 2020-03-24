open Bindings

let handleError f =
  Js.Promise.then_ (function
    | Ok () -> Js.Promise.resolve ()
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
  let folder = Workspace.rootPath in
  Toolchain.init ~env:Process.env ~folder
  |> Js.Promise.then_ (function
       | Ok toolchain ->
         Toolchain.runSetup toolchain
         |> Js.Promise.then_ (function
              | Error msg -> Error msg |> Js.Promise.resolve
              | Ok () ->
                let serverOptions = Server.make toolchain in
                let client =
                  LanguageClient.make ~id:"ocaml" ~name:"OCaml Language Server"
                    ~serverOptions ~clientOptions:(Client.make ())
                in
                (client.start () [@bs]);
                Js.Promise.resolve (Ok ()))
       | Error msg -> Error msg |> Js.Promise.resolve)
  |> handleError Window.showErrorMessage
  |> Js.Promise.catch (fun e ->
         let message = Bindings.JsError.ofPromiseError e in
         Window.showErrorMessage {j|Error: $message|j})
