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
    Some
      (match get_kind ~document with
      | Structure ->
        root ^ "/_build/default/"
        ^ String.sub ~pos:0 ~len:(String.length relative - 2) relative
        ^ "pp.ml"
      | Signature ->
        root ^ "/_build/default/"
        ^ String.sub ~pos:0 ~len:(String.length relative - 3) relative
        ^ "pp.mli"
      | Unknown -> failwith "Unknown file extension")
