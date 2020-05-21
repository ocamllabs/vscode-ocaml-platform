open Import

type t = Cmd.t

let binary = Path.ofString "esy"

type discover =
  { file : Path.t
  ; status : (unit, string) result
  }

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
  let valid file = Some { file; status = Ok () }

  let invalid_json file = Some { file; status = Error "unable to parse json" }

  let parseFile projectRoot = function
    | "esy.json"
    | "opam" ->
      Promise.return (valid projectRoot)
    | s when Filename.extension s = ".opam" ->
      Promise.return (valid projectRoot)
    | "package.json" as fname ->
      let manifestFile = Path.(projectRoot / fname) |> Path.toString in
      Fs.readFile manifestFile
      |> Promise.map (fun manifest ->
             match Json.parse manifest with
             | None -> invalid_json projectRoot
             | Some json ->
               if
                 ( propertyExists json "dependencies"
                 || propertyExists json "devDependencies" )
                 && propertyExists json "esy"
               then
                 valid projectRoot
               else
                 None)
    | _ -> None |> Promise.resolve

  let parseDir dir =
    let open Promise.O in
    (Path.toString dir |> Fs.readDir >>| function
     | Ok res -> res
     | Error _ ->
       message `Warn
         "Unable to read %s. No esy projects will be inferred from here"
         (Path.toString dir);
       [||])
    >>= fun files -> files |> Promise.Array.filterMap (parseFile dir)

  let parseDirsUp dir =
    let rec loop parsedDirs dir =
      let parsedDirs = parseDir dir :: parsedDirs in
      match Path.parent dir with
      | None -> parsedDirs
      | Some dir -> loop parsedDirs dir
    in
    loop [] dir

  let run ~dir : discover list Promise.t =
    dir |> parseDirsUp |> Array.of_list |> Promise.all
    |> Promise.map (fun x -> Array.to_list (Js.Array.concatMany x [||]))
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

let setupWithProgressIndicator fn =
  Window.withProgress
    [%bs.obj
      { location = Window.locationToJs Window.Notification
      ; title = "Setting up toolchain..."
      }]
    fn

let _setupBsb t ~manifest ~envWithUnzip:esyEnv =
  setupWithProgressIndicator (fun progress ->
      let succeeded = ref (Ok ()) in
      let eventEmitter = Setup.Bsb.make () in
      Setup.Bsb.onProgress eventEmitter (fun percent ->
          Js.Console.info2 "Percentage:" percent;
          progress.report
            [%bs.obj { increment = int_of_float (percent *. 100.) }] [@bs]);
      Setup.Bsb.onEnd eventEmitter (fun () ->
          (progress.report [%bs.obj { increment = 100 }] [@bs]));
      Setup.Bsb.onError eventEmitter (fun errorMsg ->
          succeeded := Error errorMsg);
      Setup.Bsb.run t esyEnv eventEmitter manifest
      |> Promise.map (fun () -> !succeeded))

(* This doesn't really belong this module, it should be the caller's job to summon UI elements *)
let _promptSetup fn =
  Window.showQuickPick [| "yes"; "no" |]
    (Window.QuickPickOptions.make ~canPickMany:false
       ~placeHolder:{j|Setup this project's toolchain with 'esy'?|j} ())
  |> Promise.then_ (function
       | Some choice when choice = "yes" -> fn ()
       | Some _
       | None ->
         Error "Please setup the toolchain" |> Promise.resolve)

let _setupEsy t ~manifest =
  setupWithProgressIndicator (fun progress ->
      progress.report [%bs.obj { increment = int_of_float 1. }] [@bs];
      Cmd.output t ~cwd:manifest ~args:[||]
      |> Promise.map (fun _ ->
             progress.report [%bs.obj { increment = int_of_float 100. }] [@bs];
             Ok ()))

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
