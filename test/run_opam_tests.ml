open Node

let main () =
  let dirname = __dirname () in
  let extension_development_path = Path.resolve [ dirname; "../" ] in
  (* The path to the extension test script Passed to --extensionTestsPath *)
  let extension_tests_path = Path.resolve [ dirname; "./suite/opam" ] in
  (* Download VS Code, unzip it and run the integration test *)
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
