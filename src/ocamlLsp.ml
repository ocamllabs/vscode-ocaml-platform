open! Import

type t =
  { interfaceSpecificLangId : bool
  ; handleSwitchImplIntf : bool
  }

let default = { interfaceSpecificLangId = false; handleSwitchImplIntf = false }

let defaultField key decode default json =
  let open Jsonoo.Decode in
  try_default default (field key decode) json

let ofJson (json : Jsonoo.t) =
  let open Jsonoo.Decode in
  try
    let interfaceSpecificLangId =
      defaultField "interfaceSpecificLangId" bool
        default.interfaceSpecificLangId json
    in
    let handleSwitchImplIntf =
      defaultField "handleSwitchImplIntf" bool default.handleSwitchImplIntf json
    in
    { interfaceSpecificLangId; handleSwitchImplIntf }
  with Jsonoo.Decode_error _ ->
    message `Warn
      "unexpected experimental capabilities from lsp server. Some features \
       might be missing";
    default

let ofInitializeResult (t : Vscode.LanguageClient.InitializeResult.t) =
  match
    Vscode.LanguageClient.(
      InitializeResult.capabilities t |> ServerCapabilities.experimental)
  with
  | None -> default
  | Some json -> (
    match Jsonoo.Decode.field "ocamllsp" ofJson json with
    | s -> s
    | exception Jsonoo.Decode_error _ -> default )

let interfaceSpecificLangId t = t.interfaceSpecificLangId

let canHandleSwitchImplIntf t = t.handleSwitchImplIntf
