(** [language_server_output_channel] is the output channel that should be used
    by all ocamllsp LanguageClients *)
val language_server_output_channel : Vscode.OutputChannel.t Lazy.t

(** [extension_output_channel] is the output channel that should be used for
    logs by the extension *)
val extension_output_channel : Vscode.OutputChannel.t Lazy.t

(** [command_output_channel] is the output channel for user-friendly logs of
    shell commands *)
val command_output_channel : Vscode.OutputChannel.t Lazy.t
