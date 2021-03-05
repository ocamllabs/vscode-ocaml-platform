let language_server_output_channel =
  lazy (Vscode.Window.createOutputChannel ~name:"OCaml Language Server")

let extension_output_channel =
  lazy (Vscode.Window.createOutputChannel ~name:"OCaml Platform Extension")

let command_output_channel =
  lazy (Vscode.Window.createOutputChannel ~name:"OCaml Commands")
