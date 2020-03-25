(* ?? Manifest *)

open Bindings
module P = Promise

let parseFile projectRoot = function
  | "esy.json" -> Some (`Esy projectRoot) |> P.resolve
  | "opam" ->
    Fs.stat Fpath.(projectRoot / "opam" |> toString)
    |> P.then_ (function
         | Error _ -> None |> P.resolve
         | Ok stats -> (
           match Fs.Stat.isDirectory stats with
           | true -> None |> P.resolve
           | false -> Some (`Opam projectRoot) |> P.resolve ))
  | "package.json" ->
    let manifestFile = Fpath.(projectRoot / "package.json") |> Fpath.show in
    Fs.readFile manifestFile
    |> P.then_ (fun manifest ->
           match Json.parse manifest with
           | None -> None |> P.resolve
           | Some json ->
             if
               Utils.propertyExists json "dependencies"
               || Utils.propertyExists json "devDependencies"
             then
               if Utils.propertyExists json "esy" then
                 Some (`Esy projectRoot) |> P.resolve
               else
                 Some (`Esy Fpath.(projectRoot / ".vscode" / "esy"))
                 |> P.resolve
             else
               None |> P.resolve)
  | file -> (
    let manifestFile = Fpath.(projectRoot / file) |> Fpath.show in
    match Path.extname file with
    | ".json" ->
      Fs.readFile manifestFile
      |> P.then_ (fun manifest ->
             match Json.parse manifest with
             | Some json ->
               if
                 Utils.propertyExists json "dependencies"
                 || Utils.propertyExists json "devDependencies"
               then
                 Some (`Esy projectRoot) |> P.resolve
               else
                 None |> P.resolve
             | None ->
               Js.Console.error3 "Invalid JSON file found. Ignoring..." manifest
                 manifestFile;
               None |> P.resolve)
    | ".opam" ->
      Fs.readFile manifestFile
      |> P.then_ (function
           | "" -> None |> P.resolve
           | _ -> Some (`Opam projectRoot) |> P.resolve)
    | _ -> None |> P.resolve )

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
  Fs.readDir (Fpath.toString projectRoot)
  |> P.then_ (function
       | Error msg -> Error msg |> P.resolve
       | Ok files ->
         files
         |> Js.Array.map (parseFile projectRoot)
         |> P.all
         |> P.then_ (fun l -> Ok (foldResults l) |> P.resolve))
