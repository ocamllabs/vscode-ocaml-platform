module Dumpast : module type of Dumpast

module Pp_path : module type of Pp_path

val get_preprocessed_ast : string -> (Ppxlib.Ast_io.t, string) result
