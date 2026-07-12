(** Resolve assets bundled with the extension as VS Code URIs. *)

val uri : extension:Vscode.ExtensionContext.t -> name:string -> Vscode.Uri.t

val light_dark_icon
  :  extension:Vscode.ExtensionContext.t
  -> light:string
  -> dark:string
  -> Vscode.LightDarkIcon.t
