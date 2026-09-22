include Describe_parser

let command sandbox =
  Sandbox.get_command
    sandbox
    "dune"
    [ "describe"; "--format"; "sexp"; "--lang"; "0.1" ]
    `Command
;;
