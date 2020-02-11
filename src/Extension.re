open Vscode;
open LSP;

let createClient = (~id, ~name, ~folder) =>
  Js.Promise.(
    Server.make(folder)
    |> then_(serverOptions => {
         switch (serverOptions) {
         | Ok(serverOptions) =>
           Ok(
             LanguageClient.make(
               ~id,
               ~name,
               ~serverOptions,
               ~clientOptions=Client.make(),
             ),
           )
           |> resolve
         | Error(e) => resolve(Error(e))
         }
       })
  );

let activate = _context => {
  Refmt.register();
  Ocamlformat.register();
  Js.Promise.(
    createClient(
      ~id="merlin-language-server",
      ~name="Merlin Language Server",
      ~folder=Workspace.rootPath,
    )
    |> then_(client =>
         switch (client) {
         | Ok((client: LanguageClient.t)) => client.start(.) |> resolve
         | Error(e) => Window.showErrorMessage(e)
         }
       )
    |> catch(e => {
         let message = Bindings.Error.ofPromiseError(e);
         Window.showErrorMessage({j|Error: $message|j});
       })
  );
};
