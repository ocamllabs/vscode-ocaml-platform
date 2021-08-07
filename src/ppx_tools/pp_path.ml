open Vscode
open Base

type kind =
  | Structure
  | Signature
  | Unknown

let relative_document_path ~document =
  Workspace.asRelativePath ~pathOrUri:(`Uri (TextDocument.uri document)) ()

let project_root_path () = Workspace.rootPath ()

let get_kind ~document =
  let relative = relative_document_path ~document in
  match Caml.Filename.extension relative with
  | ".ml" -> Structure
  | ".mli" -> Signature
  | _ -> Unknown

let get_pp_path ~(document : TextDocument.t) =
  let relative = relative_document_path ~document in
  match project_root_path () with
  | None ->
    let (_ : _ Promise.t) = Window.showErrorMessage ~message:"NONE." () in
    None
  | Some root ->
    let build_root = "_build/default" in
    let fname =
      match get_kind ~document with
      | Unknown -> failwith "Unknown file extension"
      | Structure -> String.chop_suffix_exn ~suffix:".ml" relative ^ ".pp.ml"
      | Signature -> String.chop_suffix_exn ~suffix:".mli" relative ^ "pp.mli"
    in
    let ( / ) = Caml.Filename.concat in
    Some (root / build_root / fname)
