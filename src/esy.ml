open Import

type t = Cmd.spawn

let binary = Path.ofString "esy"

type discover =
  { file : Path.t
  ; status : (unit, string) result
  }

let make () =
  let open Promise.Syntax in
  Cmd.checkSpawn { bin = binary; args = [] } >>| function
  | Error _ -> None
  | Ok cmd -> Some cmd

module Discover = struct
  let valid file = Some { file; status = Ok () }

  let invalid_json file = Some { file; status = Error "unable to parse json" }

  let parseFile projectRoot = function
    | "esy.json"
    | "opam" ->
      Promise.return (valid projectRoot)
    | s when Filename.extension s = ".opam" ->
      Promise.return (valid projectRoot)
    | "package.json" as fname -> (
      let manifestFile = Path.(projectRoot / fname) |> Path.toString in
      let open Promise.Syntax in
      Fs.read_file manifestFile >>| fun manifest ->
      match Jsonoo.try_parse_opt manifest with
      | None -> invalid_json projectRoot
      | Some json ->
        if
          ( propertyExists json "dependencies"
          || propertyExists json "devDependencies" )
          && propertyExists json "esy"
        then
          valid projectRoot
        else
          None )
    | _ -> Promise.return None

  let parseDir dir =
    let open Promise.Syntax in
    Path.toString dir |> Fs.read_dir
    >>| (function
          | Ok res -> res
          | Error err ->
            let dir = Path.toString dir in
            log "unable to read dir %s. error %s" dir err;
            message `Warn
              "Unable to read %s. No esy projects will be inferred from here"
              dir;
            [])
    >>= Promise.List.filter_map (parseFile dir)

  let parseDirsUp dir =
    let rec loop parsedDirs dir =
      let parsedDirs = parseDir dir :: parsedDirs in
      match Path.parent dir with
      | None -> parsedDirs
      | Some dir -> loop parsedDirs dir
    in
    loop [] dir

  let run ~dir : discover list Promise.t =
    let open Promise.Syntax in
    dir |> parseDirsUp |> Promise.all_list >>| List.flatten
end

let discover = Discover.run

let exec t ~manifest ~args =
  Cmd.Spawn (Cmd.append t ("-P" :: Path.toString manifest :: args))

module State = struct
  type t =
    | Ready
    | Pending
end

let state t ~manifest =
  let rootStr = Path.toString manifest in
  let command = Cmd.append t [ "status"; "-P"; rootStr ] in
  let open Promise.Syntax in
  Cmd.output (Spawn command)
  >>| (function
        | Error _ -> Ok false
        | Ok esyOutput -> (
          match Jsonoo.try_parse_opt esyOutput with
          | None -> Ok false
          | Some esyResponse ->
            esyResponse
            |> Jsonoo.Decode.field "isProjectReadyForDev" Jsonoo.Decode.bool
            |> Core_kernel.Result.return ))
  |> Promise.Result.map (fun isProjectReadyForDev ->
         if isProjectReadyForDev then
           State.Ready
         else
           Pending)

let setupToolchain t ~manifest =
  let open Promise.Result.Syntax in
  state t ~manifest >>| function
  | State.Ready -> ()
  | Pending ->
    let rootDir = Path.toString manifest in
    message `Info "Esy dependencies are not installed. Run esy under %s" rootDir
