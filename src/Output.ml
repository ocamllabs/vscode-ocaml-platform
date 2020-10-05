let languageServerOutputChannel =
  lazy (Vscode.Window.createOutputChannel ~name:"OCaml Language Server")

let extensionOutputChannel =
  lazy (Vscode.Window.createOutputChannel ~name:"OCaml Platform Extension")
