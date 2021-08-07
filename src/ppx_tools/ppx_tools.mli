open Vscode

module Traverse_ast : module type of Traverse_ast

module Traverse_ast2 : module type of Traverse_ast2

module Dumpast : module type of Dumpast

module Pp_path : module type of Pp_path

val get_reparsed_code_from_pp_file :
  document:TextDocument.t -> (string, string) result

val get_preprocessed_ast : string -> (Ppxlib.Ast_io.t, string) result
