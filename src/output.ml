let language_server_output_channel =
  lazy (Vscode.Window.create_output_channel ~name:"OCaml Language Server")

let extension_output_channel =
  lazy (Vscode.Window.create_output_channel ~name:"OCaml Platform Extension")

let command_output_channel =
  lazy (Vscode.Window.create_output_channel ~name:"OCaml Commands")
