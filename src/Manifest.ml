(* ?? Manifest *)

open Bindings
module P = Promise

type lookup =
  | Esy of Fpath.t
  | Opam of Fpath.t

let parseFile projectRoot = function
  | "esy.json" -> Some (Esy projectRoot) |> P.resolve
  | "opam" ->
    Fs.stat Fpath.(projectRoot / "opam" |> toString)
    |> Promise.map (function
         | Error _ -> None
         | Ok stats -> (
           match Fs.Stat.isDirectory stats with
           | true -> None
           | false -> Some (Opam projectRoot) ))
  | "package.json" ->
    let manifestFile = Fpath.(projectRoot / "package.json") |> Fpath.show in
    Fs.readFile manifestFile
    |> Promise.map (fun manifest ->
           match Json.parse manifest with
           | None -> None
           | Some json ->
             if
               Utils.propertyExists json "dependencies"
               || Utils.propertyExists json "devDependencies"
             then
               if Utils.propertyExists json "esy" then
                 Some (Esy projectRoot)
               else
                 Some (Esy Fpath.(projectRoot / ".vscode" / "esy"))
             else
               None)
  | file -> (
    let manifestFile = Fpath.(projectRoot / file) |> Fpath.show in
    match Path.extname file with
    | ".json" ->
      Fs.readFile manifestFile
      |> Promise.map (fun manifest ->
             match Json.parse manifest with
             | Some json ->
               if
                 Utils.propertyExists json "dependencies"
                 || Utils.propertyExists json "devDependencies"
               then
                 Some (Esy projectRoot)
               else
                 None
             | None ->
               Js.Console.error3 "Invalid JSON file found. Ignoring..." manifest
                 manifestFile;
               None)
    | ".opam" ->
      Fs.readFile manifestFile
      |> Promise.map (function
           | "" -> None
           | _ -> Some (Opam projectRoot))
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
  |> Promise.Result.bind (fun files ->
         files
         |> Js.Array.map (parseFile projectRoot)
         |> P.all
         |> Promise.map (fun l -> Ok (foldResults l)))
