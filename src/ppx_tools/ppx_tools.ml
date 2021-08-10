open Base
module Dumpast = Dumpast

let get_preprocessed_ast path = Ppxlib.Ast_io.read_binary path

let get_reparsed_code_from_pp_file ~path =
  get_preprocessed_ast path
  |> Result.map ~f:(fun res ->
         match Ppxlib.Ast_io.get_ast res with
         | Impl structure ->
           Caml.Format.asprintf "%a" Pprintast.structure structure
         | Intf signature ->
           Caml.Format.asprintf "%a" Pprintast.signature signature)
