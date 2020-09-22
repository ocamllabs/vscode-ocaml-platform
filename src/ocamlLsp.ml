open! Import

type t =
  { interfaceSpecificLangId : bool
  ; handleSwitchImplIntf : bool
  }

let default = { interfaceSpecificLangId = false; handleSwitchImplIntf = false }

let defaultField key decode default json =
  let open Json.Decode in
  withDefault default (field key decode) json

let ofJson (json : Js.Json.t) =
  let open Json.Decode in
  try
    let interfaceSpecificLangId =
      defaultField "interfaceSpecificLangId" bool
        default.interfaceSpecificLangId json
    in
    let handleSwitchImplIntf =
      defaultField "handleSwitchImplIntf" bool default.handleSwitchImplIntf json
    in
    { interfaceSpecificLangId; handleSwitchImplIntf }
  with DecodeError _ ->
    message `Warn
      "unexpected experimental capabilities from lsp server. Some features \
       might be missing";
    default

let ofInitializeResult (t : Vscode.LanguageClient.InitializeResult.t) =
  match Js.Nullable.toOption t.capabilities.experimental with
  | None -> default
  | Some json -> (
    match Json.Decode.field "ocamllsp" ofJson json with
    | s -> s
    | exception Json.Decode.DecodeError _ -> default )

let interfaceSpecificLangId t = t.interfaceSpecificLangId

let canHandleSwitchImplIntf t = t.handleSwitchImplIntf
