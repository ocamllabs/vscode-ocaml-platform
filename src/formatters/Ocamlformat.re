module P = Js.Promise;

let register = () => {
  Vscode.Languages.registerDocumentFormattingEditProvider(
    {scheme: "file", language: "ocaml"},
    {
      "provideDocumentFormattingEdits": (document: Vscode.Window.document) => {
        let filePath = document.fileName;
        let fileName = Node.Path.basename(document.fileName);
        let cwd = Node.Path.dirname(document.fileName);
        switch (Vscode.Window.activeTextEditor) {
        | None => Js.Promise.resolve([||])
        | Some(textEditor) =>
          let id = Uuid.v4();
          let tempFileName =
            Node.Path.join([|
              Node.Os.tmpdir(),
              {j|vscode-merlin-ocamlformat-$id-$fileName|j},
            |]);

          Node.Fs.writeFile(tempFileName, textEditor.document.getText())
          |> P.then_(_ => {FormatterUtils.getFormatterPath("ocamlformat")})
          |> P.then_(
               fun
               | Error(reason) =>
                 P.reject(Failure("Could not setup ocamlformat: " ++ reason))
               | Ok(formatterPath) => {
                   Node.ChildProcess.exec(
                     {j|$formatterPath --enable-outside-detected-project --name=$filePath $tempFileName|j},
                     Node.ChildProcess.Options.make(~cwd, ()),
                   );
                 },
             )
          |> P.then_(
               fun
               | Error(e) =>
                 P.reject(
                   Failure(
                     "Could not run ocamlfmt: "
                     ++ Node.ChildProcess.E.toString(e),
                   ),
                 )
               | Ok((_, formattedText, _error)) => {
                   let textRange =
                     FormatterUtils.getFullTextRange(textEditor.document);
                   Node.Fs.unlink(tempFileName) |> ignore;
                   [|Vscode.TextEdit.replace(textRange, formattedText)|]
                   |> P.resolve;
                 },
             )
          |> P.catch(e => {
               Node.Fs.unlink(tempFileName) |> ignore;
               let message = Bindings.Error.ofPromiseError(e);
               Vscode.Window.showErrorMessage({j|Error: $message|j});
             });
        };
      },
    },
  );
};
