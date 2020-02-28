open Bindings
module E =
  struct
    type t =
      | DownloadFailure of string 
      | UnsupportedOS 
      | InvalidJSONType of string 
      | MissingField of string 
      | InvalidFirstArrayElement 
      | Failure of string 
    let toString =
      function
      | ((DownloadFailure (url))[@explicit_arity ]) ->
          {j| Could not download $url |j}
      | UnsupportedOS ->
          "We detected a platform for which we couldn't find cached builds"
      | ((InvalidJSONType (value))[@explicit_arity ]) ->
          {j|Field $value in Azure's response was undefined|j}
      | ((MissingField (k))[@explicit_arity ]) ->
          {j| Response from Azure did not contain build $k |j}
      | InvalidFirstArrayElement ->
          "Unexpected array value in Azure response"
      | ((Failure (url))[@explicit_arity ]) ->
          {j| Failed to download $url |j}
  end
module JSONResponse =
  struct
    module CamlArray = Array
    open Js
    let getBuildId responseText =
      try
        let json = Json.parseExn responseText in
        match Js.Json.classify json with
        | ((JSONObject (dict))[@explicit_arity ]) ->
            (match Dict.get dict "value" with
             | None ->
                 ((Error (((E.InvalidJSONType ("value"))[@explicit_arity ])))
                 [@explicit_arity ])
             | ((Some (json))[@explicit_arity ]) ->
                 (match Js.Json.classify json with
                  | ((JSONArray (builds))[@explicit_arity ]) ->
                      let o = CamlArray.get builds 0 in
                      (match Json.classify o with
                       | ((JSONObject (dict))[@explicit_arity ]) ->
                           (match Dict.get dict "id" with
                            | ((Some (id))[@explicit_arity ]) ->
                                (match Json.classify id with
                                 | ((JSONNumber (n))[@explicit_arity ]) ->
                                     ((Ok (n))[@explicit_arity ])
                                 | _ ->
                                     ((Error
                                         (((E.InvalidJSONType ("id"))
                                           [@explicit_arity ])))
                                     [@explicit_arity ]))
                            | None ->
                                ((Error
                                    (((E.InvalidJSONType ("id"))
                                      [@explicit_arity ])))
                                [@explicit_arity ]))
                       | _ -> ((Error (E.InvalidFirstArrayElement))
                           [@explicit_arity ]))
                  | _ ->
                      ((Error
                          (((E.MissingField ("value"))[@explicit_arity ])))
                      [@explicit_arity ])))
        | _ ->
            ((Error
                (((E.InvalidJSONType ("<Entire azure response>"))
                  [@explicit_arity ])))
            [@explicit_arity ])
      with
      | _ ->
          ((Error
              (((E.InvalidJSONType ("<Entire azure response>"))
                [@explicit_arity ])))
          [@explicit_arity ])
    let getDownloadURL responseText =
      try
        let json = Json.parseExn responseText in
        match Js.Json.classify json with
        | ((JSONObject (dict))[@explicit_arity ]) ->
            (match Dict.get dict "resource" with
             | None ->
                 ((Error (((E.MissingField ("resource"))[@explicit_arity ])))
                 [@explicit_arity ])
             | ((Some (json))[@explicit_arity ]) ->
                 (match Json.classify json with
                  | ((JSONObject (dict))[@explicit_arity ]) ->
                      (match Dict.get dict "downloadUrl" with
                       | ((Some (id))[@explicit_arity ]) ->
                           (match Json.classify id with
                            | ((JSONString (s))[@explicit_arity ]) ->
                                ((Ok (s))[@explicit_arity ])
                            | _ ->
                                ((Error
                                    (((E.InvalidJSONType ("downloadUrl"))
                                      [@explicit_arity ])))
                                [@explicit_arity ]))
                       | None ->
                           ((Error
                               (((E.MissingField ("downloadUrl"))
                                 [@explicit_arity ])))
                           [@explicit_arity ]))
                  | _ ->
                      ((Error
                          (((E.InvalidJSONType ("resource"))
                            [@explicit_arity ])))
                      [@explicit_arity ])))
        | _ ->
            ((Error
                (((E.InvalidJSONType ("<entire azure response>"))
                  [@explicit_arity ])))
            [@explicit_arity ])
      with
      | _ ->
          ((Error
              (((E.InvalidJSONType ("<entire azure response>"))
                [@explicit_arity ])))
          [@explicit_arity ])
  end
let restBase = "https://dev.azure.com/arrowresearch/"
let proj = "vscode-merlin"
let os =
  match Process.platform with
  | "darwin" -> ((Some ("Darwin"))[@explicit_arity ])
  | "linux" -> ((Some ("Linux"))[@explicit_arity ])
  | "win32" -> ((Some ("Windows"))[@explicit_arity ])
  | _ -> None
let artifactName =
  let open Option in os >>| (fun os -> {j|cache-$os-install|j})
let master = "branchName=refs%2Fheads%2Fmaster"
let filter =
  "deletedFilter=excludeDeleted&statusFilter=completed&resultFilter=succeeded"
let latest = "queryOrder=finishTimeDescending&$top=1"
open Utils
open Js.Promise
let getBuildID () =
  (Https.getCompleteResponse
     {j|$restBase/$proj/_apis/build/builds?$filter&$master&$latest&api-version=4.1|j})
    |>
    (then_
       (resolve <<
          (function
           | ((Ok (response))[@explicit_arity ]) ->
               JSONResponse.getBuildId response
           | ((Error (e))[@explicit_arity ]) ->
               (match e with
                | ((Https.E.Failure (url))[@explicit_arity ]) ->
                    ((Error (((E.DownloadFailure (url))[@explicit_arity ])))
                    [@explicit_arity ])))))
let getDownloadURL latestBuildID =
  let latestBuildID = Js.Float.toString latestBuildID in
  match artifactName with
  | ((Some (artifactName))[@explicit_arity ]) ->
      (Https.getCompleteResponse
         {j|$restBase/$proj/_apis/build/builds/$latestBuildID/artifacts?artifactname=$artifactName&api-version=4.1|j})
        |>
        (then_
           (resolve <<
              (function
               | ((Error
                   (((Https.E.Failure (url))[@explicit_arity ])))[@explicit_arity
                                                                   ])
                   -> ((Error (((E.Failure (url))[@explicit_arity ])))
                   [@explicit_arity ])
               | ((Ok (url))[@explicit_arity ]) ->
                   JSONResponse.getDownloadURL url)))
  | None -> resolve ((Error (E.UnsupportedOS))[@explicit_arity ])