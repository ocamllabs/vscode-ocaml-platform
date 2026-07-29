type executable =
  { name : string (** Dune name. *)
  ; mod_path : string (** Workspace relative module path. *)
  ; exec_path : string (** Workspace relative path to the executable. *)
  }

module Dune_descr_parser : sig
  val parse_executables : Sexplib.Sexp.t -> executable list option
end

val register : Vscode.ExtensionContext.t -> Extension_instance.t -> unit
