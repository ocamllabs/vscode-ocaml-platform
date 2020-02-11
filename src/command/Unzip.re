open Bindings;

let run = (~p=?, file) =>
  ChildProcess.exec(
    {j|unzip $file|j},
    switch (p) {
    | Some(root) => ChildProcess.Options.make(~cwd=root, ())
    | None => ChildProcess.Options.make()
    },
  );
