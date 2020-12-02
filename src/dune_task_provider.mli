(** Basic TaskProvider for dune.

    This provider creates one task per dune, dune-project, dune-workspace, file
    that it can find in the workspace. It doesn't parse the dune files. *)

(** registers dune task provider within the vscode task providers; takes care of
    subscribing the disposable to the extension context *)
val register : Vscode.ExtensionContext.t -> Extension_instance.t -> unit
