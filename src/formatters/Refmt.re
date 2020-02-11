module P = Js.Promise;

let register = () => {
  let config = Vscode.Workspace.getConfiguration("merlin");
  let refmtWidthArg =
    switch (Js.Nullable.toOption(config##refmt##width)) {
    | None => ""
    | Some(formatWidth) => "-w " ++ string_of_int(formatWidth)
    };

  Vscode.Languages.registerDocumentFormattingEditProvider(
    {scheme: "file", language: "reason"},
    {
      "provideDocumentFormattingEdits": (document: Vscode.Window.document) => {
        let fileName = Node.Path.basename(document.fileName);
        let cwd = Node.Path.dirname(document.fileName);
        switch (Vscode.Window.activeTextEditor) {
        | None => Js.Promise.resolve([||])
        | Some(textEditor) =>
          let id = Uuid.v4();
          let tempFileName =
            Node.Path.join([|
              Node.Os.tmpdir(),
              {j|vscode-merlin-refmt-$id-$fileName|j},
            |]);
          Js.log(tempFileName);
          Node.Fs.writeFile(tempFileName, textEditor.document.getText())
          |> P.then_(_ => {FormatterUtils.getFormatterPath("refmt")})
          |> P.then_(
               fun
               | Error(e) => {
                   P.reject(Failure("Could not setup refmt: " ++ e));
                 }
               | Ok(formatterPath) => {
                   Node.ChildProcess.exec(
                     {j|$formatterPath $tempFileName $refmtWidthArg|j},
                     Node.ChildProcess.Options.make(~cwd, ()),
                   );
                 },
             )
          |> P.then_(
               fun
               | Error(e) => {
                   P.reject(
                     Failure(
                       "Could not run refmt: "
                       ++ Node.ChildProcess.E.toString(e),
                     ),
                   );
                 }
               | Ok((_, formattedText, _)) => {
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
