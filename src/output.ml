let language_server_output_channel_options = Vscode.OutputChannelOptions.create ()

let language_server_output_channel =
  lazy
    (Vscode.Window.createOutputChannelWithOptions
       ~name:"OCaml Language Server"
       ~options:language_server_output_channel_options
     |> Vscode.LogOutputChannel.to_output_channel)
;;

let extension_output_channel =
  lazy (Vscode.Window.createOutputChannel ~name:"OCaml Platform Extension" ())
;;

let command_output_channel =
  lazy (Vscode.Window.createOutputChannel ~name:"OCaml Commands" ())
;;
