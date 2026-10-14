(** Tests for discovering and running a standalone OCaml file. *)

open Describe_parser

let fail message =
  Stdlib.prerr_endline message;
  Stdlib.exit 1
;;

let check what got expected =
  if not (String.equal got expected)
  then fail (Printf.sprintf "%s: got %S, expected %S" what got expected)
;;

let normalize path =
  String.split_on_char '\\' path |> String.concat "/"
;;

let ends_with suffix path = String.ends_with ~suffix (normalize path)

let rec project_root dir =
  let marker = Filename.concat dir "tests/fixtures/run-standalone/dune-project" in
  if Sys.file_exists marker
  then dir
  else (
    let parent = Filename.dirname dir in
    if String.equal parent dir
    then fail ("cannot find the run-standalone fixture from " ^ dir)
    else project_root parent)
;;

let fixture name =
  Filename.concat (Filename.concat (project_root (Sys.getcwd ())) "tests/fixtures") name
;;

let rec collect dir ~keep acc =
  let entries = Sys.readdir dir in
  Array.fold_left
    (fun acc name ->
      if String.length name > 0 && Char.equal name.[0] '_'
      then acc
      else (
        let path = Filename.concat dir name in
        if Sys.is_directory path then collect path ~keep acc else keep path name acc))
    acc
    entries
;;

let context_of_tree root =
  let dune_projects =
    collect root ~keep:(fun path name acc ->
      if String.equal name "dune-project" then path :: acc else acc) []
  in
  context_of_dune_project_files dune_projects
;;

let ml_files root =
  collect root ~keep:(fun path name acc ->
    if Filename.check_suffix name ".ml" then path :: acc else acc) []
  |> List.map normalize
  |> List.sort String.compare
;;

let sample =
  {|((build_context _build/default)
 (executables
  ((names (main))
   (modules (((name Main) (impl (_build/default/bin/main.ml)))))))
 (executables
  ((names (app))
   (modules
    (((name App) (impl (_build/default/lib/deep/nested/app.ml))))))))|}
;;

let library_only =
  {|((build_context _build/default)
 (library
  ((names (helper))
   (modules (((name Helper) (impl (_build/default/lib/helper/helper.ml))))))))|}
;;

let test_parse_executables () =
  (match parse parse_executables sample with
   | None -> fail "parser returned nothing"
   | Some [ main; app ] ->
     check "main.name" main.name "main";
     check "main.mod_path" main.mod_path "/bin/main.ml";
     check "main.exec_path" main.exec_path "./bin/main.exe";
     check "app.name" app.name "app";
     check "app.mod_path" app.mod_path "/lib/deep/nested/app.ml";
     check "app.exec_path" app.exec_path "./lib/deep/nested/app.exe"
   | Some execs ->
     fail (Printf.sprintf "expected 2 executables, got %d" (List.length execs)));
  match parse parse_executables library_only with
  | Some [] -> ()
  | Some _ -> fail "a library stanza was reported as an executable"
  | None -> fail "library-only describe output failed to parse"
;;

let check_context what expected files =
  match context_of_dune_project_files files, expected with
  | Dune, Dune | Unknown, Unknown -> ()
  | _, Dune -> fail (what ^ ": expected Dune")
  | _, Unknown -> fail (what ^ ": expected Unknown")
;;

let test_project_detection () =
  check_context "no dune-project" Unknown [];
  check_context "dune-project at the workspace root" Dune [ "dune-project" ];
  check_context "dune-project in a subfolder" Dune [ "pkg/dune-project" ];
  check_context "several dune-project files" Dune [ "dune-project"; "pkg/dune-project" ];
  (match context_of_tree (fixture "run-standalone") with
   | Dune -> ()
   | Unknown -> fail "fixture with a root dune-project was not detected as Dune");
  (match context_of_tree (fixture "run-standalone-nested") with
   | Dune -> ()
   | Unknown -> fail "fixture with only a nested dune-project was not detected as Dune");
  match context_of_tree (fixture "run-standalone-plain") with
  | Unknown -> ()
  | Dune -> fail "fixture without dune-project was detected as Dune"
;;

let test_ml_file_list () =
  let files = ml_files (fixture "run-standalone-plain") in
  let execs = executables_of_ml_files files in
  let names = List.map (fun exec -> exec.name) execs |> List.sort String.compare in
  if
    List.exists
      (fun name -> String.equal name "noise.ml" || String.equal name "_hidden.ml")
      names
  then fail "generated or hidden .ml files were listed";
  match names with
  | [ "app.ml"; "main.ml" ] ->
    let app = List.find (fun exec -> String.equal exec.name "app.ml") execs in
    let main = List.find (fun exec -> String.equal exec.name "main.ml") execs in
    if not (ends_with "lib/deep/nested/app.ml" app.mod_path)
    then fail "nested .ml file was not discovered";
    check "app.exec_path" app.exec_path app.mod_path;
    if not (ends_with "main.ml" main.mod_path) then fail "main.ml was not discovered"
  | _ ->
    fail
      (Printf.sprintf
         "expected app.ml and main.ml, got %s"
         (String.concat ", " names))
;;

let test_commands () =
  let dune_exec =
    { name = "main"; mod_path = "/bin/main.ml"; exec_path = "./bin/main.exe" }
  in
  let nested =
    { name = "app.ml"
    ; mod_path = "lib/deep/nested/app.ml"
    ; exec_path = "lib/deep/nested/app.ml"
    }
  in
  let spaced =
    { name = "my app.ml"; mod_path = "lib/my app.ml"; exec_path = "lib/my app.ml" }
  in
  check "dune command" (command_line Dune dune_exec []) "dune exec ./bin/main.exe --";
  check
    "dune command with args"
    (command_line Dune dune_exec [ "--help" ])
    "dune exec ./bin/main.exe -- --help";
  check
    "ocaml command"
    (command_line Unknown nested [])
    "ocaml -I +str -I +unix lib/deep/nested/app.ml";
  check
    "ocaml command quotes spaces"
    (command_line Unknown spaced [])
    "ocaml -I +str -I +unix \"lib/my app.ml\""
;;

let capture_dune_describe root =
  let out_file = Filename.temp_file "dune-describe" ".sexp" in
  let command =
    Printf.sprintf
      "dune describe --root %s --format sexp --lang 0.1 > %s"
      (Filename.quote root)
      (Filename.quote out_file)
  in
  if Sys.command command <> 0 then fail "dune describe failed";
  let contents = In_channel.with_open_text out_file In_channel.input_all in
  Sys.remove out_file;
  contents
;;

let find_named name execs =
  match List.find_opt (fun exec -> String.equal exec.name name) execs with
  | Some exec -> exec
  | None -> fail ("missing executable " ^ name)
;;

let test_dune_describe () =
  let stdout = capture_dune_describe (fixture "run-standalone") in
  match parse parse_executables stdout with
  | None -> fail "parsing dune describe output failed"
  | Some execs ->
    let names = List.map (fun exec -> exec.name) execs |> List.sort String.compare in
    (match names with
     | [ "app"; "main" ] -> ()
     | _ ->
       fail
         (Printf.sprintf
            "expected executables app and main, got %s"
            (String.concat ", " names)));
    if List.exists (fun exec -> String.equal exec.name "helper") execs
    then fail "library module helper was listed as an executable";
    let main = find_named "main" execs in
    let app = find_named "app" execs in
    if not (ends_with "bin/main.ml" main.mod_path)
    then fail ("main module path: " ^ main.mod_path);
    if not (ends_with "bin/main.exe" main.exec_path)
    then fail ("main executable path: " ^ main.exec_path);
    if not (ends_with "lib/deep/nested/app.ml" app.mod_path)
    then fail ("nested module path: " ^ app.mod_path);
    if not (ends_with "lib/deep/nested/app.exe" app.exec_path)
    then fail ("nested executable path: " ^ app.exec_path);
    check
      "described main command"
      (command_line Dune main [])
      ("dune exec " ^ main.exec_path ^ " --");
    check
      "described app command"
      (command_line Dune app [])
      ("dune exec " ^ app.exec_path ^ " --")
;;

let () =
  test_parse_executables ();
  test_project_detection ();
  test_ml_file_list ();
  test_commands ();
  test_dune_describe ()
;;
