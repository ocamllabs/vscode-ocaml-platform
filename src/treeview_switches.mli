module Dependency : sig
  type t =
    | Switch of Opam.Switch.t
    | Dependency of (Opam.Package.t * t option)

  val sexp_of_t : t -> Sexplib0.Sexp.t

  val t_of_sexp : Sexplib0.Sexp.t -> t

  val to_string : t -> string

  val of_string : string -> t

  val label : t -> string

  val description : opam:Opam.t -> t -> string option Promise.t

  val tooltip : t -> string option

  val context_value : t -> string

  val icon : extension_path:string -> t -> Vscode.TreeItem.LightDarkIcon.t

  val collapsible_state : t -> Vscode.TreeItemCollapsibleState.t
end

(** Register the ocaml-switches tree view and returns the provider as a
    disposable, with a callback to refresh the view. *)
val register :
  Vscode.ExtensionContext.t -> (Vscode.Disposable.t * (unit -> unit)) Promise.t
