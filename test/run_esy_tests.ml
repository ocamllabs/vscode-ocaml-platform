open Node

let dirname = __dirname ()

let root = Path.dirname dirname

(* Will try to use the test/fixtures/sample-esy from the dune build directory
   which contains build artefacts that cause esy to fail hence the ".. .." *)
let sample_esy_src =
  Path.join [ root; ".."; ".."; "test"; "fixtures"; "sample-esy" ]

let project_path = Path.join [ Os.tmpdir (); "sample-esy" ]

let esy_sandbox_config root =
  let config =
    Ojs.obj
      [| ("root", Ojs.string_to_js root); ("kind", Ojs.string_to_js "esy") |]
  in
  let t = Ojs.obj [| ("ocaml.sandbox", config) |] in
  Jsonoo.(stringify @@ t_of_js t)

let main () =
  Fs_extra.copy_sync sample_esy_src project_path;
  print_endline ("Running in " ^ project_path);
  let options = ChildProcess.Options.create ~cwd:project_path () in
  let _stdout : string = ChildProcess.Sync.exec ~options "esy" () in
  Fs.Sync.writeFile
    (Path.join [ project_path; ".vscode"; "settings.json" ])
    (esy_sandbox_config project_path);
  let extension_development_path = Path.resolve [ dirname; "../" ] in
  let extension_tests_path = Path.resolve [ dirname; "./suite/esy" ] in
  let launch_args = [ "--disable-extensions" ] in
  let options =
    Vscode_test_electron.TestOptions.create
      ~extension_development_path
      ~extension_tests_path
      ~launch_args
      ()
  in
  let promise = Vscode_test_electron.run_tests options in
  Promise.catch promise ~rejected:(fun _ ->
      print_endline "Failed to run test";
      exit 1)

let () =
  let (_ : int Promise.t) = main () in
  ()
