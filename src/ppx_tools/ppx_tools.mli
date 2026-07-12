module Dumpast : module type of Dumpast

val reparsed_code_of_ast : Ppxlib.Ast_io.t -> string
val get_reparsed_code_from_pp_file : path:string -> (string, string) result
val get_preprocessed_ast : string -> (Ppxlib.Ast_io.t, string) result
