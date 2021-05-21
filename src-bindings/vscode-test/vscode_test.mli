[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es5

include module type of struct
  let download_and_unzip_vscode =
    Vscode_test_download.download_and_unzip_vs_code

  let run_tests = Vscode_test_run_test.run_tests

  let resolve_cli_path_from_vs_code_executable_path =
    Vscode_test_util.resolve_cli_path_from_vs_code_executable_path
end
