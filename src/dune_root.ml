(*
   Find the root of a Dune project

   Reference implementation:
   https://github.com/ocaml/dune/blob/b0563f11e90ab5e4afdee6569e6a29d757f31dcc/bin/workspace_root.ml

   At the time of writing, I'm not aware of a fast or simple way to query
   Dune to give us this info. 'dune describe workspace' gives us the root
   but does a lot more and we need still to parse its output.
*)

open Import
open Promise.Syntax

type root =
  | Dune_workspace of Path.t
  | Dune_project of Path.t

(* Unlike the rest of the Path module, this is not a pure syntactic operation
   so I'm not sure if there's a better place to expose this function.

   It resolves symlinks and returns the canonical absolute path.
   Raises a JS exception if the path does not exist.
*)
let realpath x =
  let+ str = Node.Fs.realpath (Path.to_string x) in
  Path.of_string str

let check_dir best_candidate real_dir =
  (* always check for a dune-workspace file *)
  let* exists = Fs.exists Path.(to_string (real_dir / "dune-workspace")) in
  if exists then
    Promise.return (Some (Dune_workspace real_dir))
  else
    (* only check for a dune-project file if we haven't encountered
       a dune-workspace file before *)
    match best_candidate with
    | Some (Dune_workspace _) -> Promise.return best_candidate
    | None
    | Some (Dune_project _) ->
        let+ exists = Fs.exists Path.(to_string (real_dir / "dune-project")) in
        if exists then
          Some (Dune_project real_dir)
        else
          best_candidate

let rec find_from_dir ~active_file best_candidate real_dir =
  let* best_candidate = check_dir best_candidate real_dir in
  match Path.parent real_dir with
  | Some parent when not (Path.equal parent real_dir) ->
      find_from_dir ~active_file best_candidate parent
  | None | Some _ ->
      (* we're reached the filesystem root *)
      (match best_candidate with
       | Some (Dune_workspace root_dir | Dune_project root_dir) ->
           Ok root_dir
       | None ->
           Error
             (sprintf "cannot find a Dune root folder for file '%s'"
                (Path.to_string active_file)
             )
      ) |> Promise.return

(*
   A project may not contain workspaces but a workspace may contain
   projects or other workspaces.

   Algorithm:

   - Start from the real (physical) path of the folder containing the active
     file passed as argument (typically an ml or mli file).
   - Walk up the ancestor folders until reaching the filesystem root.
     * Along the way, any folder containing a "dune-workspace" replaces
       the best candidate for a workspace root.
     * If a folder contains a "dune-project" file and no "dune-workspace"
       root has been found so far, it is remembered as the best candidate.

   i.e. we stop considering "dune-project" files once we've found a
   "dune-workspace" file while walking up toward the filesystem root.
*)
let find active_file =
  match Path.parent active_file with
  | None ->
      (* FS root *)
      Promise.return (
        Error
          (sprintf "cannot find a Dune root folder for file '%s'"
             (Path.to_string active_file))
      )
  | Some dir ->
      (* determine the absolute parent path that doesn't contain symlinks
         (as if we did 'cd DIR; cd ..; pwd' with a naive shell) *)
      let* real_dir = realpath dir in
      find_from_dir ~active_file None real_dir
