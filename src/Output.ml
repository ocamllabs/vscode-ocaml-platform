let languageServerOutputChannel =
  lazy (Vscode.Window.createOutputChannel "OCaml Language Server")

let extensionOutputChannel =
  lazy (Vscode.Window.createOutputChannel "OCaml Platform Extension")
