(*
   Find the root of a Dune project (kind of, see mli)
*)

open Import
open Promise.Syntax

let rec find_from_dir ~active_file real_dir =
  let* exists = Fs.exists Path.(to_string (real_dir / "dune-project")) in
  if exists then Promise.return (Ok real_dir)
  else
    match Path.parent real_dir with
    | Some parent when not (Path.equal parent real_dir) ->
        find_from_dir ~active_file parent
    | None | Some _ ->
        Promise.return (
          Error
            (sprintf "cannot find a Dune root folder for file '%s'"
               (Path.to_string active_file))
        )

let find_nearest_dune_project active_file =
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
      dir
      |> Path.realpath
      |> find_from_dir ~active_file
