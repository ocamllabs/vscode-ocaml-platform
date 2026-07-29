(** Parse the output of the command [dune describe]. *)

type 'a parser = Sexplib.Sexp.t -> 'a option

type executable =
  { name : string (** Dune executable name. *)
  ; mod_path : string (** Workspace relative module path. *)
  ; exec_path : string (** Workspace relative path to the executable. *)
  }

val command : Sandbox.t -> Cmd.t
val parse_executables : executable list parser
val parse : 'a parser -> string -> 'a option
