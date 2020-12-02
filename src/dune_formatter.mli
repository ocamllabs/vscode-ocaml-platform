(** register formatters for dune, dune-project, and dune-workspace files; takes
    care of subscribing of the disposable to the execution context *)
val register : Vscode.ExtensionContext.t -> Extension_instance.t -> unit
