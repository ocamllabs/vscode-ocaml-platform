open Import

type lookup =
  | Esy of Path.t
  | Opam of Path.t

let parseFile projectRoot = function
  | "esy.json" -> Some (Esy projectRoot) |> Promise.resolve
  | "opam" ->
    Fs.stat Path.(projectRoot / "opam" |> toString)
    |> Promise.map (function
         | Error _ -> None
         | Ok stats -> (
           match Fs.Stat.isDirectory stats with
           | true -> None
           | false -> Some (Opam projectRoot) ))
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
               if propertyExists json "esy" then
                 Some (Esy projectRoot)
               else
                 Some (Esy (hiddenEsyDir projectRoot))
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
                 Some (Esy projectRoot)
               else
                 None
             | None ->
               Js.Console.error3 "Invalid JSON file found. Ignoring..." manifest
                 manifestFile;
               None)
    | ".opam" ->
      Fs.readFile (Path.toString manifestFile)
      |> Promise.map (function
           (* TODO this is wrong. we shouldn't be assuming anything based on the
              contents of the opam file *)
           | "" -> None
           | _ -> Some (Opam projectRoot))
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

let lookup projectRoot =
  Fs.readDir (Path.toString projectRoot)
  |> Promise.Result.bind (fun files ->
         files
         |> Js.Array.map (parseFile projectRoot)
         |> Promise.all
         |> Promise.map (fun l -> Ok (foldResults l)))
