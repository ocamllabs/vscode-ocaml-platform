open Bindings
let run ?p  file =
  ChildProcess.exec {j|unzip $file|j}
    (match p with
     | ((Some (root))[@explicit_arity ]) ->
         ChildProcess.Options.make ~cwd:root ()
     | None -> ChildProcess.Options.make ())