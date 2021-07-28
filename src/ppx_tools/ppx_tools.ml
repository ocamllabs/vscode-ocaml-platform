module Traverse_ast = Traverse_ast
module Traverse_ast2 = Traverse_ast2
module Dumpast = Dumpast
module Pp_path = Pp_path

let get_preprocessed_ast path = Ppxlib.Ast_io.read_binary path

let get_reparsed_code_from_pp_file ~document =
  match get_preprocessed_ast (Pp_path.get_pp_path ~document) with
  | Ok ast -> (
    match ast with
    | Impl structure -> Caml.Format.asprintf "%a" Pprintast.structure structure
    | Intf signature -> Caml.Format.asprintf "%a" Pprintast.signature signature)
  | Error err_msg -> err_msg
