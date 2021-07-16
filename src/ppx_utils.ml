open Import

let project_root_path ~document =
  let relative =
    Workspace.asRelativePath ~pathOrUri:(`Uri (TextDocument.uri document))
  in
  match Workspace.rootPath () with
  | Some rootPath -> rootPath
  | None -> raise (Failure ("Couldnt find root path for " ^ relative))

let relative_document_path ~document =
  Workspace.asRelativePath ~pathOrUri:(`Uri (TextDocument.uri document))

let get_pp_path ~(document : TextDocument.t) =
  try
    let relative = relative_document_path ~document in
    project_root_path ~document
    ^ "/_build/default/"
    ^ String.sub ~pos:0 ~len:(String.length relative - 2) relative
    ^ "pp.ml"
  with
  | Failure errorMsg -> errorMsg

let get_preprocessed_structure path =
  let open Ppxlib in
  let input_source = Utils.Ast_io.File path in
  match Utils.Ast_io.read input_source ~input_kind:Necessarily_binary with
  | Ok { ast; _ } -> (
    match ast with
    | Impl i -> i
    | Intf _ -> failwith "The file contains a signature instead of a structure."
    )
  | Error _ -> failwith ("Some error occured on parsing the " ^ path)

let get_pp_pp_structure ~document =
  let str = get_preprocessed_structure (get_pp_path ~document) in
  Caml.Format.asprintf "%a" Pprintast.structure str
