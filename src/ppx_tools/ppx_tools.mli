module Dumpast : module type of Dumpast

val get_reparsed_code_from_pp_file : path:string -> (string, string) result
val get_preprocessed_ast : string -> (Ppxlib.Ast_io.t, string) result
