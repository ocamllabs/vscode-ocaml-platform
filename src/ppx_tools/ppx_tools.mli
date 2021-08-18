module Dumpast : module type of Dumpast

type error =
  | Io_error of string
  | Read_error of string

val get_reparsed_code_from_pp_file : path:string -> (string, error) result

val get_preprocessed_ast : string -> (Ppxlib.Ast_io.t, error) result
