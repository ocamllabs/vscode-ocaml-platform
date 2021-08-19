open Base
module Dumpast = Dumpast

let get_preprocessed_ast path =
  match Ppxlib.Ast_io.read_binary path with
  | exception Sys_error s -> Error s
  | Ok s -> Ok s
  | Error e -> Error e

let get_reparsed_code_from_pp_file ~path =
  get_preprocessed_ast path
  |> Result.map ~f:(fun source ->
         match Ppxlib.Ast_io.get_ast source with
         | Impl structure ->
           Caml.Format.asprintf "%a" Pprintast.structure structure
         | Intf signature ->
           Caml.Format.asprintf "%a" Pprintast.signature signature)
