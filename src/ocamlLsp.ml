open! Import

type t = { interfaceSpecificLangId : bool }

let default = { interfaceSpecificLangId = false }

let ofInitializeResult (t : Vscode.LanguageClient.InitializeResult.t) =
  match Js.Nullable.toOption t.capabilities.experimental with
  | None -> default
  | Some json -> (
    match Js.Json.decodeObject json with
    | None -> default
    | Some o ->
      let interfaceSpecificLangId =
        match Js.Dict.get o "interfaceSpecificLangId" with
        | None -> false
        | Some json ->
          Belt.Option.getWithDefault (Js.Json.decodeBoolean json) false
      in
      { interfaceSpecificLangId } )

let interfaceSpecificLangId t = t.interfaceSpecificLangId
