module Rimraf: {
  /** Bindinds for https://www.npmjs.com/package/rimraf. rimraf
     is a cross-platform utility library to delete a directory
     and all its contens */
  type t;
  let run: string => Js.Promise.t(result(unit, unit));
} = {
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
