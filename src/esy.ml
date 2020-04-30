open Import

type t = Cmd.t

let binary = Path.ofString "esy"

let make () =
  Cmd.make ~cmd:binary ()
  |> Promise.map (function
       | Error _ -> None
       | Ok cmd -> Some cmd)

let env t ~manifest =
  Cmd.output t ~args:[| "command-env"; "--json"; "-P"; Path.toString manifest |]
  |> Promise.map
       (Result.bind ~f:(fun stdout ->
            match Json.parse stdout with
            | Some json -> Ok (Json.Decode.dict Json.Decode.string json)
            | None ->
              (* Make this a fatal error. There's no need to try very hard here *)
              assert false))

module Discover = struct
  let parseFile projectRoot = function
    | "esy.json" -> Some projectRoot |> Promise.resolve
    | "opam" ->
      Fs.stat Path.(projectRoot / "opam" |> toString)
      |> Promise.map (function
           | Error _ -> None
           | Ok stats -> (
             match Fs.Stat.isDirectory stats with
             | true ->
               (* Is this wrong? The opam file can exist in a directroy as well *)
               None
             | false -> Some projectRoot ))
    | "package.json" ->
      let manifestFile = Path.(projectRoot / "package.json") |> Path.toString in
      Fs.readFile manifestFile
      |> Promise.map (fun manifest ->
             match Json.parse manifest with
             | None -> None
             | Some json ->
               if
                 propertyExists json "dependencies"
                 || propertyExists json "devDependencies"
               then
                 Some projectRoot
               else
                 None)
    | file -> (
      let manifestFile = Path.(projectRoot / file) in
      match Node.Path.extname file with
      | ".json" ->
        Fs.readFile (Path.toString manifestFile)
        |> Promise.map (fun manifest ->
               match Json.parse manifest with
               | Some json ->
                 if
                   propertyExists json "dependencies"
                   || propertyExists json "devDependencies"
                 then
                   Some projectRoot
                 else
                   None
               | None ->
                 Js.Console.error3 "Invalid JSON file found. Ignoring..."
                   manifest manifestFile;
                 None)
      | ".opam" -> Promise.return (Some manifestFile)
      | _ -> None |> Promise.resolve )

  let foldResults results =
    Js.Array.reduce
      (fun acc x ->
        Js.Array.concat acc
          ( match x with
          | Some x -> Array.of_list [ x ]
          | None -> [||] ))
      [||] results
    |> Array.to_list

  let run ~dir : Path.t list Promise.t =
    let open Promise.O in
    (Path.toString dir |> Fs.readDir >>| function
     | Error _ ->
       message `Warn
         "Unable to read %s. No esy projects will be inferred from here"
         (Path.toString dir);
       [||]
     | Ok res -> res)
    >>= fun files ->
    files
    |> Js.Array.map (parseFile dir)
    |> Promise.all |> Promise.map foldResults
end

let discover = Discover.run

let exec t ~manifest ~args =
  (Cmd.binPath t, Array.append [| "-P"; Path.toString manifest |] args)

module State = struct
  type t =
    | Ready
    | Pending
end

let state t ~manifest =
  let rootStr = Path.toString manifest in
  Cmd.output t ~args:[| "status"; "-P"; rootStr |]
  |> Promise.map (function
       | Error _ -> Ok false
       | Ok esyOutput -> (
         match Json.parse esyOutput with
         | None -> Ok false
         | Some esyResponse ->
           esyResponse
           |> Json.Decode.field "isProjectReadyForDev" Json.Decode.bool
           |> Result.return ))
  |> Promise.Result.map (fun isProjectReadyForDev ->
         if isProjectReadyForDev then
           State.Ready
         else
           Pending)

let setupToolchain t ~manifest =
  let open Promise.Result.O in
  state t ~manifest >>| function
  | State.Ready -> ()
  | Pending ->
    let rootDir = Path.toString manifest in
    Window.showInformationMessage
      (Printf.sprintf "Esy dependencies are not installed. Run esy under %s"
         rootDir)
    |> ignore;
    ()
