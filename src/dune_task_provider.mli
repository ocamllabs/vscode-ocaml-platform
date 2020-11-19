(** Basic TaskProvider for dune.

    This provider creates one task per dune, dune-project, dune-workspace,
    file that it can find in the workspace. It doesn't parse the dune files.
*)

val register : Extension_instance.t -> Vscode.Disposable.t
