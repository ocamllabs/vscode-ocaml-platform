(** Register the ocaml-sandbox tree view *)
val register
  :  Vscode.ExtensionContext.t
  -> Extension_instance.t
  -> assets:Extension_assets.t
  -> unit
