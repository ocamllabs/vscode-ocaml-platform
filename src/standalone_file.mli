type executable =
  { name : string
  ; path : string
  }

module Dune_descr_parser : sig
  val parse_executables : Sexplib.Sexp.t -> executable list option
end

val register : Vscode.ExtensionContext.t -> Extension_instance.t -> unit
