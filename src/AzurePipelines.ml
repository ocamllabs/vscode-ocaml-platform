open Bindings

module E = struct
  type t =
    | InvalidJSONType of string
    | MissingField of string
    | InvalidFirstArrayElement

  let toString = function
    | InvalidJSONType value ->
      {j|Field $value in Azure's response was undefined|j}
    | MissingField k -> {j| Response from Azure did not contain build $k |j}
    | InvalidFirstArrayElement -> "Unexpected array value in Azure response"
end

module JSONResponse = struct
  module CamlArray = Array

  type buildIdObject = { id : int }

  let getBuildId responseText =
    let getBuildId' json =
      let open Json.Decode in
      let buildIdObject json = { id = field "id" int json } in
      let valueArray = field "value" (array buildIdObject) json in
      valueArray.(0).id
    in
    match Json.parse responseText with
    | Some json -> Ok (getBuildId' json)
    | None -> Error "getBuildId(): responseText could not be parsed"

  type downloadUrlObject = { downloadUrl : string }

  let getDownloadURL responseText =
    let open Json.Decode in
    try
      match Json.parse responseText with
      | Some json ->
        let downloadUrlObject json =
          { downloadUrl = field "downloadUrl" string json }
        in
        let resource = field "resource" downloadUrlObject json in
        Ok resource.downloadUrl
      | None -> Error "getDownloadURL(): could not parse responseText"
    with _ ->
      Error "getDownloadURL(): field() failed on 'resource' or 'downloadUrl'"
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
           | Ok response -> (
             try JSONResponse.getBuildId response
             with _ ->
               Error
                 {j|Could not get field 'id' from json response $response |j} )
           | Error e -> (
             match e with
             | Https.E.Failure url -> Error {j| Could not download $url |j} ) ))

let getDownloadURL latestBuildID =
  let latestBuildID = Js.Int.toString latestBuildID in
  match artifactName with
  | Some artifactName ->
    Https.getCompleteResponse
      {j|$restBase/$proj/_apis/build/builds/$latestBuildID/artifacts?artifactname=$artifactName&api-version=4.1|j}
    |> then_ (fun r ->
           resolve
             ( match r with
             | Error (Https.E.Failure url) ->
               Error {j| Failed to download $url |j}
             | Ok url -> JSONResponse.getDownloadURL url ))
  | None ->
    resolve
      (Error "We detected a platform for which we couldn't find cached builds")
