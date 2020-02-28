open LSP
open Bindings

let then_ f =
  Js.Promise.then_ (function
    | Ok x -> f x
    | Error e -> Js.Promise.resolve (Error e))

let handleError =
  ( fun f ->
      Js.Promise.then_ (function
        | Ok () -> Js.Promise.resolve ()
        | Error msg -> f msg)
    :    (string -> unit Js.Promise.t)
      -> (unit, string) result Js.Promise.t
      -> unit Js.Promise.t )

let activate _context =
  Js.Dict.set Process.env "OCAMLRUNPARAM" "b";
  Js.Dict.set Process.env "OCAML_LSP_SERVER_LOG" "-";
  let folder = Workspace.rootPath in
  Toolchain.init ~env:Process.env ~folder
  |> then_ Toolchain.setup
  |> then_ (fun toolchain ->
         let serverOptions = Server.make toolchain in
         let client =
           LanguageClient.make ~id:"ocaml" ~name:"OCaml Language Server"
             ~serverOptions ~clientOptions:(Client.make ())
         in
         (client.start () [@bs]);
         Js.Promise.resolve (Ok ()))
  |> handleError Window.showErrorMessage
  |> Js.Promise.catch (fun e ->
         let message = Bindings.Error.ofPromiseError e in
         Window.showErrorMessage {j|Error: $message|j})
