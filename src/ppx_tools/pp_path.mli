open Vscode

type kind =
  | Structure
  | Signature
  | Unknown

val project_root_path : unit -> string option

val get_kind : document:TextDocument.t -> kind

val get_pp_path : document:TextDocument.t -> string option
