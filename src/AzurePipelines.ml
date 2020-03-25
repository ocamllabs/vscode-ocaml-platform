open Bindings
module P = Promise

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

module RESTResponse = struct
  type buildIdObject = { id : int }

  let guard jsonParser str =
    try jsonParser str
    with e ->
      let msg = Printexc.to_string e
      and stack = Printexc.get_backtrace () in
      Error {|Failed to parse Azure response
$msg
$stack
|}

  let getBuildId' json =
    let open Json.Decode in
    let buildIdObject json = { id = field "id" int json } in
    let valueArray = field "value" (array buildIdObject) json in
    valueArray.(0).id

  let getBuildId =
    guard (fun responseText ->
        match Json.parse responseText with
        | Some json -> Ok (getBuildId' json)
        | None -> Error "getBuildId(): responseText could not be parsed")

  type downloadUrlObject = { downloadUrl : string }

  let getDownloadURL' json =
    let open Json.Decode in
    let downloadUrlObject json =
      { downloadUrl = field "downloadUrl" string json }
    in
    match field "resource" (optional downloadUrlObject) json with
    | Some resource -> Ok resource.downloadUrl
    | None ->
      Error
        {|getDownloadURL(): responseObject.resource as not of the form { downloadURL: "..." }. Instead got
$responseText |}

  let getDownloadURL =
    guard (fun responseText ->
        match Json.parse responseText with
        | Some json -> getDownloadURL' json
        | None -> Error "getDownloadURL(): could not parse responseText")
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
  match os with
  | Some os -> Some {j|cache-$os-install|j}
  | None -> None

let master = "branchName=refs%2Fheads%2Fmaster"

let filter =
  "deletedFilter=excludeDeleted&statusFilter=completed&resultFilter=succeeded"

let latest = "queryOrder=finishTimeDescending&$top=1"

let getBuildID () =
  Https.getCompleteResponse
    {j|$restBase/$proj/_apis/build/builds?$filter&$master&$latest&api-version=4.1|j}
  |> P.then_ (fun r ->
         P.resolve
           ( match r with
           | Ok response -> RESTResponse.getBuildId response
           | Error e -> (
             match e with
             | Https.E.Failure url -> Error {j| Could not download $url |j} ) ))

let getDownloadURL latestBuildID =
  let latestBuildID = Js.Int.toString latestBuildID in
  match artifactName with
  | Some artifactName ->
    Https.getCompleteResponse
      {j|$restBase/$proj/_apis/build/builds/$latestBuildID/artifacts?artifactname=$artifactName&api-version=4.1|j}
    |> P.then_ (function
         | Error (Https.E.Failure url) ->
           Error {j| Failed to download $url |j} |> P.resolve
         | Ok responseText ->
           responseText |> RESTResponse.getDownloadURL |> P.resolve)
  | None ->
    Error "We detected a platform for which we couldn't find cached builds"
    |> P.resolve
