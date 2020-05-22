open! Import

type t = { interfaceSpecificLangId : bool }

let default = { interfaceSpecificLangId = false }

let ofJson (json : Js.Json.t) =
  let open Json.Decode in
  try
    let interfaceSpecificLangId = field "interfaceSpecificLangId" bool json in
    { interfaceSpecificLangId }
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
