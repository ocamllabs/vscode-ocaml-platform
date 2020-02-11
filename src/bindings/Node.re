[@bs.module "./fs-stub.js"]
external thisProjectsEsyJson: string = "thisProjectsEsyJson";

module CamlArray = Array;
open Js;

[@bs.val] external __dirname: string = "__dirname";

[@bs.val] [@bs.scope "process"]
external processEnv: Js.Dict.t(string) = "env";

[@bs.val] [@bs.scope "process"] external processPlatform: string = "platform";
module Process = {
  type t;
  [@bs.val] external v: t = "process";
  [@bs.val] [@bs.scope "process"] external cwd: unit => string = "cwd";
  [@bs.val] [@bs.scope "process"] external platform: string = "platform";
  /* TODO [@bs.val] [@bs.scope "process"] external env: Js.Dict.t(string) = "env"; */
  module Stdout = {
    type t;
    [@bs.val] external v: t = "process.stdout";
    [@bs.send] external write: (t, string) => unit = "write";
  };
};

module Error = {
  type t = {. "message": string};
  [@bs.new] external make: string => t = "Error";
  let ofPromiseError = [%raw
    error => "return error.message || 'Unknown error'"
  ];
};

module Buffer = {
  type t = {. "byteLength": int};
  [@bs.send] external toString: t => string = "toString";
  [@bs.val] [@bs.scope "Buffer"] external from: string => t = "from";
  let ofString = from;
};

/* Did not work. Was instead pointed to https://gist.github.com/mrmurphy/f0a499d4510a358927b8179071145ff9 */
/* [@bs.module "util"] */
/* external promisify: */
/*   (('a, (. Js.Nullable.t(Error.t), 'b) => unit) => unit, 'a) => */
/*   Js.Promise.t('b) = */
/*   "promisify"; */
/* [@bs.module "util"] */
/* external promisify2: */
/*   (('a, 'b, (. Js.Nullable.t(Error.t), 'c) => unit) => unit, 'a, 'b) => */
/*   Js.Promise.t('c) = */
/*   "promisify"; */

module type STREAM = {
  type t;
  let on: (t, string, Buffer.t => unit) => unit;
};

module StreamFunctor = (S: {type t;}) => {
  type t = S.t;
  [@bs.send] external on: (t, string, Buffer.t => unit) => unit = "on";
};

module Stream =
  StreamFunctor({
    type t;
  });

module Fs = {
  /* [@bs.module "fs"] */
  /* external writeFile: */
  /*   (string, string, (. Js.Nullable.t(Error.t), unit) => unit) => unit = */
  /*   "writeFile"; */
  /* let writeFile = promisify2(writeFile); */

  /* [@bs.module "fs"] */
  /* external readFile: */
  /*   (string, (. Js.Nullable.t(Error.t), string) => unit) => unit = */
  /*   "readFile"; */
  /* let readFile = promisify(readFile); */

  module E = {
    type t =
      | PathNotFound;
    let toString =
      fun
      | PathNotFound => "mkdir(~p=true) received home path and it was not found";
  };

  type fd;
  [@bs.module "fs"] external writeSync: (. fd, Buffer.t) => unit = "writeSync";

  [@bs.module "./fs-stub.js"]
  external writeFile: (string, string) => Js.Promise.t(unit) = "writeFile";

  [@bs.module "./fs-stub.js"]
  external readFile: string => Js.Promise.t(string) = "readFile";

  [@bs.module "./fs-stub.js"]
  external mkdir': string => Js.Promise.t(result(unit, 'b)) = "mkdir";

  [@bs.module "./fs-stub.js"]
  external exists: string => Js.Promise.t(result(bool, 'b)) = "exists";

  [@bs.module "./fs-stub.js"]
  external open_: (string, string) => Js.Promise.t(fd) = "open";

  [@bs.module "./fs-stub.js"]
  external write: (fd, Buffer.t) => Js.Promise.t(unit) = "write";

  [@bs.module "./fs-stub.js"]
  external close: (fd, Buffer.t) => Js.Promise.t(unit) = "close";

  [@bs.module "fs"]
  external createWriteStream: string => Stream.t = "createWriteStream";

  [@bs.module "./fs-stub.js"]
  external unlink: string => Js.Promise.t(bool) = "unlink";

  let rec mkdir = (~p=?, path) => {
    let forceCreate =
      switch (p) {
      | Some(x) => x
      | None => false
      };
    Js.Promise.(
      if (forceCreate) {
        exists(path)
        |> then_(doesExist => {
             switch (doesExist) {
             | Ok(doesExist) =>
               if (doesExist) {
                 resolve(Ok());
               } else {
                 let homePath = Sys.getenv(Sys.unix ? "HOME" : "USERPROFILE");
                 if (path == homePath) {
                   resolve(Error(E.PathNotFound));
                 } else {
                   mkdir(~p=true, Filename.dirname(path))
                   |> then_(
                        fun
                        | Ok () => mkdir'(path)
                        | Error(e) => Error(e) |> resolve,
                      );
                 };
               }
             | Error(e) => resolve(Error(e))
             }
           });
      } else {
        mkdir'(path);
      }
    );
  };
};

module ChildProcess = {
  type t = {. "exitCode": int};
  module E = {
    type t =
      | ExecFailure;
    let toString =
      fun
      | ExecFailure => "Error during exec";
  };

  module Options = {
    type t;
    [@bs.obj]
    external make: (~cwd: string=?, ~env: Js.Dict.t(string)=?, unit) => t =
      "";
  };

  [@bs.val] [@bs.module "child_process"]
  external exec:
    (string, Options.t, (Js.Nullable.t(Error.t), string, string) => unit) => t =
    "exec";

  let exec = (cmd, options) => {
    Js.Promise.(
      make((~resolve, ~reject as _) => {
        let cp = ref({"exitCode": 0});
        cp :=
          exec(cmd, options, (err, stdout, stderr) =>
            if (Js.Nullable.isNullable(err)) {
              resolve(. Ok(((cp^)##exitCode, stdout, stderr)));
            } else {
              resolve(. Error(E.ExecFailure));
            }
          );
        ();
      })
    );
  };
};

module Path = {
  [@bs.module "path"] [@bs.variadic]
  external join: array(string) => string = "join";

  [@bs.module "path"] external basename: string => string = "basename";

  [@bs.module "path"] external dirname: string => string = "dirname";
};

module Response = {
  type t = {
    .
    "statusCode": int,
    "headers": Js.Dict.t(string),
  };
  [@bs.send] external setEncoding: (t, string) => unit = "setEncoding";
  [@bs.send] external on: (t, string, Buffer.t => unit) => unit = "on";
};

module Request = {
  [@bs.module] external request: string => Stream.t = "request";
};

module RequestProgress = {
  type t;
  type state = {
    .
    "percent": float,
    "speed": int,
    "size": {
      .
      "total": int,
      "transferred": int,
    },
    "time": {
      .
      "elapsed": float,
      "remaining": float,
    },
  };
  [@bs.module] external requestProgress: Stream.t => t = "request-progress";
  [@bs.send] external onData': (t, string, Buffer.t => unit) => unit = "on";
  let onData = (t, cb) => onData'(t, "data", cb);
  [@bs.send] external onProgress': (t, string, state => unit) => unit = "on";
  let onProgress = (t, cb) => {
    onProgress'(t, "progress", cb);
  };
  [@bs.send] external onError': (t, string, Error.t => unit) => unit = "on";
  let onError = (t, cb) => {
    onError'(t, "error", cb);
  };
  [@bs.send] external onEnd': (t, string, unit => unit) => unit = "on";
  let onEnd = (t, cb) => {
    onEnd'(t, "end", cb);
  };
  [@bs.send] external pipe: (t, Stream.t) => unit = "pipe";
};

module Https = {
  module E = {
    type t =
      | Failure(string);
    let toString =
      fun
      | Failure(url) => {j|Failed to place request to $url|j};
  };

  [@bs.module "https"]
  external get: (string, Response.t => unit) => unit = "get";
  let getCompleteResponse = url =>
    Promise.make((~resolve, ~reject as _) => {
      get(
        url,
        response => {
          let _statusCode = response##statusCode;
          let responseText = ref("");
          Response.on(response, "data", c => {
            responseText := responseText^ ++ Buffer.toString(c)
          });
          Response.on(response, "end", _ => {resolve(. Ok(responseText^))});
          Response.on(response, "error", _err => {
            resolve(.
              Error(
                E.Failure({j|Error occurred while placing request to $url|j}),
              ),
            )
          });
        },
      )
    });
};

module Os = {
  [@bs.module "os"] external tmpdir: unit => string = "tmpdir";
};
