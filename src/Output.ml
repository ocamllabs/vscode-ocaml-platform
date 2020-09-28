let languageServerOutputChannel =
  lazy (Vscode.Window.create_output_channel ~name:"OCaml Language Server")

let extensionOutputChannel =
  lazy (Vscode.Window.create_output_channel ~name:"OCaml Platform Extension")
