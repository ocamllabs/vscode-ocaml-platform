(** Parse the output of the command [dune describe]. *)

type 'a parser = Sexplib.Sexp.t -> 'a option

type executable =
  { name : string (** Dune executable name. *)
  ; mod_path : string (** Workspace relative module path. *)
  ; exec_path : string (** Workspace relative path to the executable. *)
  }

val parse_executables : executable list parser
val parse : 'a parser -> string -> 'a option

type context =
  | Dune
  | Unknown

(** [Unknown] when no [dune-project] file was found, [Dune] otherwise. *)
val context_of_dune_project_files : 'a list -> context

(** Every [.ml] file is runnable when the workspace is not a Dune project. *)
val executables_of_ml_files : string list -> executable list

(** Shell command used to run one selected file. *)
val command_line : context -> executable -> string list -> string
