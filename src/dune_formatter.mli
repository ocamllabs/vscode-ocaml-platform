(** register formatters for dune, dune-project, and dune-workspace files *)
val register : Extension_instance.t -> Vscode.Disposable.t list
