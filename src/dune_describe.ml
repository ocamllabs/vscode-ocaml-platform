open Import
open Sexplib
open Option.Monad_infix

type 'a parser = Sexp.t -> 'a option

type executable =
  { name : string
  ; mod_path : string
  ; exec_path : string
  }

let field_sexp tag fields =
  List.find_map
    ~f:(function
      | Sexp.List [ Atom t; v ] when String.equal t tag -> Some v
      | _ -> None)
    fields
;;

let fields_sexp tag fields =
  List.filter_map
    ~f:(function
      | Sexp.List [ Atom t; v ] when String.equal t tag -> Some v
      | _ -> None)
    fields
;;

let mod_impl_path mod_sexp =
  match mod_sexp with
  | Sexp.List mod_fields ->
    field_sexp "impl" mod_fields
    >>| Conv.list_of_sexp Conv.string_of_sexp
    >>= (function
     | [ path ] -> Some path
     | _ -> None)
  | Atom _ -> None
;;

let mod_name mod_sexp =
  match mod_sexp with
  | Sexp.List mod_fields -> field_sexp "name" mod_fields >>| Conv.string_of_sexp
  | Atom _ -> None
;;

let parse_executables = function
  | Sexp.Atom _ -> None
  | List root_fields ->
    field_sexp "build_context" root_fields
    >>| Conv.string_of_sexp
    >>| fun build_context ->
    fields_sexp "executables" root_fields
    |> List.concat_map ~f:(function
      | Sexp.Atom _ -> []
      | List exe_fields ->
        let names =
          match field_sexp "names" exe_fields with
          | Some names_sexp -> Conv.list_of_sexp Conv.string_of_sexp names_sexp
          | None -> []
        and modules =
          match field_sexp "modules" exe_fields with
          | Some (List mods) -> mods
          | _ -> []
        in
        List.filter_map
          ~f:(fun exe_name ->
            List.find
              ~f:(fun mod_sexp ->
                match mod_name mod_sexp with
                | None -> false
                | Some name ->
                  String.equal (String.lowercase name) (String.lowercase exe_name))
              modules
            >>= mod_impl_path
            >>| fun rel_path ->
            let mod_path = String.chop_prefix_if_exists rel_path ~prefix:build_context in
            let exec_path =
              (* No need to join here since [mod_path] is always absolute. *)
              Stdlib.Filename.(current_dir_name ^ remove_extension mod_path ^ ".exe")
            in
            let exec_path =
              if Stdlib.Filename.is_relative exec_path
              then exec_path
              else Stdlib.Filename.current_dir_name ^ exec_path
            in
            { name = exe_name; mod_path; exec_path })
          names)
;;

let parse parser s =
  match Parsexp.Conv_single.parse_string s parser with
  | Ok (Some _ as r) -> r
  | Ok None | Error _ -> None
;;

let command sandbox =
  Sandbox.get_command
    sandbox
    "dune"
    [ "describe"; "--format"; "sexp"; "--lang"; "0.1" ]
    `Command
;;
