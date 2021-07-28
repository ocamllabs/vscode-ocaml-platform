open Import

type kind =
  | Structure
  | Signature
  | Unknown

let relative_document_path ~document =
  Workspace.asRelativePath ~pathOrUri:(`Uri (TextDocument.uri document))

let project_root_path ~document =
  let relative = relative_document_path ~document in
  match Workspace.rootPath () with
  | Some rootPath -> rootPath
  | None -> raise (Failure ("Couldnt find root path for " ^ relative))

let get_kind ~document =
  let relative = relative_document_path ~document in
  match String.sub ~pos:(String.length relative - 3) ~len:3 relative with
  | ".ml" -> Structure
  | "mli" -> Signature
  | _ -> Unknown

let get_pp_path ~(document : TextDocument.t) =
  try
    let relative = relative_document_path ~document in
    let root = project_root_path ~document in
    match get_kind ~document with
    | Structure ->
      root ^ "/_build/default/"
      ^ String.sub ~pos:0 ~len:(String.length relative - 2) relative
      ^ "pp.ml"
    | Signature ->
      root ^ "/_build/default/"
      ^ String.sub ~pos:0 ~len:(String.length relative - 3) relative
      ^ "pp.mli"
    | Unknown -> failwith "Unknown file extension"
  with
  | Failure errorMsg -> errorMsg

let get_preprocessed_ast path =
  let open Ppxlib in
  match Ast_io.read path with
  | Ok { ast; _ } -> ast
  | Error _ -> failwith ("Some error occured on parsing the " ^ path)

let get_reparsed_code_from_pp_file ~document =
  match get_preprocessed_ast (get_pp_path ~document) with
  | Impl structure -> Caml.Format.asprintf "%a" Pprintast.structure structure
  | Intf signature -> Caml.Format.asprintf "%a" Pprintast.signature signature
