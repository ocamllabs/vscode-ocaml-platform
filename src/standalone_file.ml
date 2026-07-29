open Import

type executable =
  { name : string
  ; mod_path : string
  ; exec_path : string
  }

module Dune_descr_parser = struct
  module Conv = Sexplib.Conv
  open Option.Monad_infix
  open Stdlib.Option.Syntax

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
      let+ build_context =
        field_sexp "build_context" root_fields >>| Conv.string_of_sexp
      in
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
              let* mod_sexp =
                List.find
                  ~f:(fun mod_sexp ->
                    match mod_name mod_sexp with
                    | None -> false
                    | Some name ->
                      String.equal (String.lowercase name) (String.lowercase exe_name))
                  modules
              in
              let+ rel_path = mod_impl_path mod_sexp in
              let mod_path =
                String.chop_prefix_if_exists rel_path ~prefix:build_context
              in
              let exec_path = Stdlib.Filename.remove_extension mod_path ^ ".exe" in
              let exec_path =
                if String.is_prefix exec_path ~prefix:"/"
                then "." ^ exec_path
                else "./" ^ exec_path
              in
              { name = exe_name; mod_path; exec_path })
            names)
  ;;
end

type context =
  | Dune
  | Unknown

let project_context () =
  Workspace.findFiles
    ~includes:(`String "**/{dune-project}")
    ~excludes:(`String "{**/_*}" (* ignoring dune files from _build, _opam, _esy *))
    ()
  |> Promise.map (function
    | [] -> Unknown
    | _ -> Dune)
;;

let find_executables sandbox project_ctx =
  let open Promise.Syntax in
  match project_ctx with
  | Dune ->
    let dune_describe =
      Sandbox.get_command
        sandbox
        "dune"
        [ "describe"; "--format"; "sexp"; "--lang"; "0.1" ]
        `Command
    in
    let+ { ChildProcess.stdout; _ } =
      Cmd.run ?cwd:(Sandbox.workspace_root ()) dune_describe
    in
    Parsexp.Conv_single.parse_string stdout Dune_descr_parser.parse_executables
    |> Stdlib.Result.to_option
    |> Option.join
  | Unknown ->
    let+ ml_files = Workspace.findFiles ~includes:(`String "**/*.ml") () in
    let execs =
      List.map
        ~f:(fun uri ->
          let abs_path = Uri.path uri in
          let mod_path =
            match Workspace.rootPath () with
            | None -> abs_path
            | Some root ->
              (match String.chop_prefix ~prefix:root abs_path with
               | None -> abs_path
               | Some rel_path -> "." ^ rel_path)
          in
          { name = Stdlib.Filename.basename mod_path; mod_path; exec_path = mod_path })
        ml_files
    in
    Some execs
;;

let exec_cmd sandbox project_ctx exec args =
  let program, args =
    match project_ctx with
    | Dune -> "dune", [ "exec"; exec.exec_path; "--" ] @ args
    | Unknown -> "ocaml", [ "-I"; "+str"; "-I"; "+unix"; exec.mod_path ] @ args
  in
  Sandbox.get_command sandbox program args `Exec
;;

let executable_choice_menu execs =
  let choices =
    List.map
      ~f:(fun exec ->
        QuickPickItem.create ~label:exec.name ~detail:exec.exec_path (), exec)
      execs
  and options =
    QuickPickOptions.create
      ~canPickMany:false
      ~placeHolder:"Which executable do you want to execute?"
      ()
  in
  Window.showQuickPickItems ~choices ~options ()
;;

let active_text_doc () =
  Window.activeTextEditor ()
  |> Option.bind ~f:(fun text_editor ->
    let doc = TextEditor.document text_editor in
    if String.(TextDocument.languageId doc = "ocaml")
    then (
      let abs_path = TextDocument.uri doc |> Uri.path in
      match Workspace.rootPath () with
      | None -> Some (abs_path, doc)
      | Some root ->
        (match String.chop_prefix ~prefix:root abs_path with
         | None -> Some (abs_path, doc)
         | Some rel_path -> Some (rel_path, doc)))
    else None)
;;

let _run_standalone_file =
  let callback instance () =
    let open Promise.Syntax in
    let (_ : unit Promise.t) =
      let sandbox = Extension_instance.sandbox instance in
      OutputChannel.show ~preserveFocus:true (Lazy.force Output.run_output_channel) ();
      let* ctx = project_context () in
      let* result = find_executables sandbox ctx in
      match result with
      | None ->
        Promise.return (show_message `Error "Output parsing of dune describe failed")
      | Some executables ->
        let* selected = executable_choice_menu executables in
        (match selected with
         | None -> Promise.return ()
         | Some exec ->
           let* _ =
             match active_text_doc () with
             | Some (rel_path, doc) when String.(rel_path = exec.mod_path) ->
               TextDocument.save doc
             | _ -> Promise.return false
           in
           let cmd = exec_cmd sandbox ctx exec [] in
           let+ _ =
             Cmd.run
               ?cwd:(Sandbox.workspace_root ())
               ~output:Output.run_output_channel
               cmd
           in
           ())
    in
    ()
  in
  Extension_commands.register Command_api.Internal.run_standalone_file callback
;;

let register extension _instance =
  let disposable =
    Disposable.make ~dispose:(fun () ->
      Lazy.peek Output.run_output_channel |> Option.iter ~f:OutputChannel.dispose)
  in
  ExtensionContext.subscribe extension ~disposable
;;
