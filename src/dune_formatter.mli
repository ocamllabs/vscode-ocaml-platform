(** register formatters for dune, dune-project, and dune-workspace files *)
val register : Vscode.ExtensionContext.t -> Extension_instance.t -> unit
