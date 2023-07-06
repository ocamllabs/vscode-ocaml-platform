type t = Vscode.Terminal.t

val create : ?name:string -> ?command:Cmd.spawn -> Sandbox.t -> t

val dispose : t -> unit

val show : preserveFocus:bool -> t -> unit

val send : t -> string -> unit
