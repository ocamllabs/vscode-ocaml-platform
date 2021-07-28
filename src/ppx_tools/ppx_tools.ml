module Traverse_ast = Traverse_ast
module Traverse_ast2 = Traverse_ast2
module Dumpast = Dumpast
module Pp_path = Pp_path

let get_preprocessed_ast path =
  let open Ppxlib in
  match Ast_io.read path with
  | Ok { ast; _ } -> ast
  | Error _ -> failwith ("Some error occured on parsing the " ^ path)

let get_reparsed_code_from_pp_file ~document =
  match get_preprocessed_ast (Pp_path.get_pp_path ~document) with
  | Impl structure -> Caml.Format.asprintf "%a" Pprintast.structure structure
  | Intf signature -> Caml.Format.asprintf "%a" Pprintast.signature signature