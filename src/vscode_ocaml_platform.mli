(** Entry point *)

(* see {{:https://code.visualstudio.com/api/references/vscode-api#Extension}
   activate() *)
val activate : Vscode.ExtensionContext.t -> unit Promise.t
