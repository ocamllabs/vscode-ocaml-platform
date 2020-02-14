module Rimraf = {
  type t;

  [@bs.module]
  external run': (string, Js.Nullable.t(Error.t) => unit) => unit = "rimraf";

  let run = p =>
    Js.Promise.make((~resolve, ~reject as _) =>
      run'(p, err => {
        switch (Js.Nullable.toOption(err)) {
        | Some(e) => resolve(. Error())
        | None => resolve(. Ok())
        }
      })
    );
};
