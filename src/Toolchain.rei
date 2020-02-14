type t;
type resources;
let init:
  (~env: Js.Dict.t(string), ~folder: string) =>
  Js.Promise.t(result(resources, string));
let setup: resources => Js.Promise.t(result(t, string));
let lsp: t => (string, array(string));
