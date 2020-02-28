module Rimraf = {
  type t;

  [@bs.module]
  external run': (string, Js.Nullable.t('a) => unit) => unit = "rimraf";

  let run = p =>
    Js.Promise.make((~resolve, ~reject as _) =>
      run'(p, err => {
        switch (Js.Nullable.toOption(err)) {
        | Some(_) => resolve(. Error())
        | None => resolve(. Ok())
        }
      })
    );
};
