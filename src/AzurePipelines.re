open Bindings;

module E = {
  type t =
    | DownloadFailure(string)
    | UnsupportedOS
    | InvalidJSONType(string)
    | MissingField(string)
    | InvalidFirstArrayElement /* Hacky. This wouldn't be needed if we properly parse the json */
    | Failure(string); /* Download failure */
  let toString =
    fun
    | DownloadFailure(url) => {j| Could not download $url |j}
    | UnsupportedOS => "We detected a platform for which we couldn't find cached builds"
    | InvalidJSONType(value) => {j|Field $value in Azure's response was undefined|j}
    | MissingField(k) => {j| Response from Azure did not contain build $k |j}
    | InvalidFirstArrayElement => "Unexpected array value in Azure response"
    | Failure(url) => {j| Failed to download $url |j};
};

module JSONResponse = {
  module CamlArray = Array;
  open Js;
  /* A module where hand written json parsing logic resides temporarily */
  let getBuildId = responseText =>
    try({
      let json = Json.parseExn(responseText);
      switch (Js.Json.classify(json)) {
      | JSONObject(dict) =>
        switch (Dict.get(dict, "value")) {
        | None => Error(E.InvalidJSONType("value"))
        | Some(json) =>
          switch (Js.Json.classify(json)) {
          | JSONArray(builds) =>
            let o = CamlArray.get(builds, 0);
            switch (Json.classify(o)) {
            | JSONObject(dict) =>
              switch (Dict.get(dict, "id")) {
              | Some(id) =>
                switch (Json.classify(id)) {
                | JSONNumber(n) => Ok(n)
                | _ => Error(E.InvalidJSONType("id"))
                }
              | None => Error(E.InvalidJSONType("id"))
              }
            | _ => Error(E.InvalidFirstArrayElement)
            };

          | _ => Error(E.MissingField("value"))
          }
        }
      | _ => Error(E.InvalidJSONType("<Entire azure response>"))
      };
    }) {
    | _ => Error(E.InvalidJSONType("<Entire azure response>"))
    };

  let getDownloadURL = responseText =>
    try({
      let json = Json.parseExn(responseText);
      switch (Js.Json.classify(json)) {
      | JSONObject(dict) =>
        switch (Dict.get(dict, "resource")) {
        | None => Error(E.MissingField("resource"))
        | Some(json) =>
          switch (Json.classify(json)) {
          | JSONObject(dict) =>
            switch (Dict.get(dict, "downloadUrl")) {
            | Some(id) =>
              switch (Json.classify(id)) {
              | JSONString(s) => Ok(s)
              | _ => Error(E.InvalidJSONType("downloadUrl"))
              }
            | None => Error(E.MissingField("downloadUrl"))
            }
          | _ => Error(E.InvalidJSONType("resource"))
          }
        }
      | _ => Error(E.InvalidJSONType("<entire azure response>"))
      };
    }) {
    | _ => Error(E.InvalidJSONType("<entire azure response>"))
    };
};

let restBase = "https://dev.azure.com/arrowresearch/";
let proj = "vscode-merlin";
let os =
  switch (Process.platform) {
  | "darwin" => Some("Darwin")
  | "linux" => Some("Linux")
  | "win32" => Some("Windows")
  | _ => None
  };
let artifactName = Option.(os >>| (os => {j|cache-$os-install|j}));
let master = "branchName=refs%2Fheads%2Fmaster";
let filter = "deletedFilter=excludeDeleted&statusFilter=completed&resultFilter=succeeded";
let latest = "queryOrder=finishTimeDescending&$top=1";

open Utils;
open Js.Promise;
let getBuildID = () => {
  Https.getCompleteResponse(
    {j|$restBase/$proj/_apis/build/builds?$filter&$master&$latest&api-version=4.1|j},
  )
  |> then_(
       resolve
       << (
         fun
         | Ok(response) => JSONResponse.getBuildId(response)
         | Error(e) =>
           switch (e) {
           | Https.E.Failure(url) => Error(E.DownloadFailure(url))
           }
       ),
     );
};

let getDownloadURL = latestBuildID => {
  let latestBuildID = Js.Float.toString(latestBuildID);
  switch (artifactName) {
  | Some(artifactName) =>
    Https.getCompleteResponse(
      {j|$restBase/$proj/_apis/build/builds/$latestBuildID/artifacts?artifactname=$artifactName&api-version=4.1|j},
    )
    |> then_(
         resolve
         << (
           fun
           | Error(Https.E.Failure(url)) => Error(E.Failure(url))
           | Ok(url) => JSONResponse.getDownloadURL(url)
         ),
       )
  | None => resolve(Error(E.UnsupportedOS))
  };
};
