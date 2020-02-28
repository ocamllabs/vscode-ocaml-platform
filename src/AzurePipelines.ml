open Bindings

module E = struct
  type t =
    | DownloadFailure of string
    | UnsupportedOS
    | InvalidJSONType of string
    | MissingField of string
    | InvalidFirstArrayElement
    | Failure of string

  let toString = function
    | DownloadFailure url -> {j| Could not download $url |j}
    | UnsupportedOS ->
      "We detected a platform for which we couldn't find cached builds"
    | InvalidJSONType value ->
      {j|Field $value in Azure's response was undefined|j}
    | MissingField k -> {j| Response from Azure did not contain build $k |j}
    | InvalidFirstArrayElement -> "Unexpected array value in Azure response"
    | Failure url -> {j| Failed to download $url |j}
end

module JSONResponse = struct
  module CamlArray = Array
  open Js

  let getBuildId responseText =
    try
      let json = Json.parseExn responseText in
      match Js.Json.classify json with
      | JSONObject dict -> (
        match Dict.get dict "value" with
        | None -> Error (E.InvalidJSONType "value")
        | Some json -> (
          match Js.Json.classify json with
          | JSONArray builds -> (
            let o = CamlArray.get builds 0 in
            match Json.classify o with
            | JSONObject dict -> (
              match Dict.get dict "id" with
              | Some id -> (
                match Json.classify id with
                | JSONNumber n -> Ok n
                | _ -> Error (E.InvalidJSONType "id") )
              | None -> Error (E.InvalidJSONType "id") )
            | _ -> Error E.InvalidFirstArrayElement )
          | _ -> Error (E.MissingField "value") ) )
      | _ -> Error (E.InvalidJSONType "<Entire azure response>")
    with _ -> Error (E.InvalidJSONType "<Entire azure response>")

  let getDownloadURL responseText =
    try
      let json = Json.parseExn responseText in
      match Js.Json.classify json with
      | JSONObject dict -> (
        match Dict.get dict "resource" with
        | None -> Error (E.MissingField "resource")
        | Some json -> (
          match Json.classify json with
          | JSONObject dict -> (
            match Dict.get dict "downloadUrl" with
            | Some id -> (
              match Json.classify id with
              | JSONString s -> Ok s
              | _ -> Error (E.InvalidJSONType "downloadUrl") )
            | None -> Error (E.MissingField "downloadUrl") )
          | _ -> Error (E.InvalidJSONType "resource") ) )
      | _ -> Error (E.InvalidJSONType "<entire azure response>")
    with _ -> Error (E.InvalidJSONType "<entire azure response>")
end

let restBase = "https://dev.azure.com/arrowresearch/"

let proj = "vscode-merlin"

let os =
  match Process.platform with
  | "darwin" -> Some "Darwin"
  | "linux" -> Some "Linux"
  | "win32" -> Some "Windows"
  | _ -> None

let artifactName =
  let open Option in
  os >>| fun os -> {j|cache-$os-install|j}

let master = "branchName=refs%2Fheads%2Fmaster"

let filter =
  "deletedFilter=excludeDeleted&statusFilter=completed&resultFilter=succeeded"

let latest = "queryOrder=finishTimeDescending&$top=1"

open Js.Promise

let getBuildID () =
  Https.getCompleteResponse
    {j|$restBase/$proj/_apis/build/builds?$filter&$master&$latest&api-version=4.1|j}
  |> then_ (fun r ->
         resolve
           ( match r with
           | Ok response -> JSONResponse.getBuildId response
           | Error e -> (
             match e with
             | Https.E.Failure url -> Error (E.DownloadFailure url) ) ))

let getDownloadURL latestBuildID =
  let latestBuildID = Js.Float.toString latestBuildID in
  match artifactName with
  | Some artifactName ->
    Https.getCompleteResponse
      {j|$restBase/$proj/_apis/build/builds/$latestBuildID/artifacts?artifactname=$artifactName&api-version=4.1|j}
    |> then_ (fun r ->
           resolve
             ( match r with
             | Error (Https.E.Failure url) -> Error (E.Failure url)
             | Ok url -> JSONResponse.getDownloadURL url ))
  | None -> resolve (Error E.UnsupportedOS)
