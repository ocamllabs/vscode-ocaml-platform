type t

val make : extension_uri:Vscode.Uri.t -> t
val chat_icon : t -> Vscode.LightDarkIcon.t
val collection_icon : t -> Vscode.LightDarkIcon.t
val dependency_icon : t -> selected:bool -> Vscode.LightDarkIcon.t
val discord_icon : t -> Vscode.LightDarkIcon.t
val github_icon : t -> Vscode.LightDarkIcon.t
val package_icon : t -> Vscode.LightDarkIcon.t
val terminal_icon : t -> Vscode.LightDarkIcon.t
