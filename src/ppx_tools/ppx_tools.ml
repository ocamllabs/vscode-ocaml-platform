module Dumpast = Dumpast
module Pp_path = Pp_path

let get_preprocessed_ast path = Ppxlib.Ast_io.read_binary path
