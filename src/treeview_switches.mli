(** Register the ocaml-switches tree view *)
val register
  :  Vscode.ExtensionContext.t
  -> Extension_instance.t
  -> assets:Extension_assets.t
  -> unit
