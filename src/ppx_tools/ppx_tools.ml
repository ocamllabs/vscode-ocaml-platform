open Base
module Dumpast = Dumpast
module Pp_path = Pp_path

let get_preprocessed_ast path = Ppxlib.Ast_io.read_binary path

let get_reparsed_code_from_pp_file ~document =
  match Pp_path.get_pp_path ~document with
  | None -> Error "Error : path to preprocessed document wasn't found"
  | Some pp_path ->
    get_preprocessed_ast pp_path
    |> Result.map ~f:(fun res ->
           match Ppxlib.Ast_io.get_ast res with
           | Impl structure ->
             Caml.Format.asprintf "%a" Pprintast.structure structure
           | Intf signature ->
             Caml.Format.asprintf "%a" Pprintast.signature signature)
