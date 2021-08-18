open Base
module Dumpast = Dumpast

type error =
  | Io_error of string
  | Read_error of string

let get_preprocessed_ast path =
  match Ppxlib.Ast_io.read_binary path with
  | exception Sys_error s -> Error (Io_error s)
  | Ok s -> Ok s
  | Error e -> Error (Read_error e)

let get_reparsed_code_from_pp_file ~path =
  get_preprocessed_ast path
  |> Result.map ~f:(fun source ->
         match Ppxlib.Ast_io.get_ast source with
         | Impl structure ->
           Caml.Format.asprintf "%a" Pprintast.structure structure
         | Intf signature ->
           Caml.Format.asprintf "%a" Pprintast.signature signature)
