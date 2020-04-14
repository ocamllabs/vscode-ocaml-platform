open Import

type 'a t =
  { key : string
  ; toJson : 'a -> Js.Json.t
  ; ofJson : Js.Json.t -> 'a
  ; scope : WorkspaceConfiguration.configurationTarget
  }

let section = Workspace.getConfiguration "ocaml"

let create ~scope ~key ~ofJson ~toJson = { scope; key; toJson; ofJson }

let get t =
  match WorkspaceConfiguration.get section t.key with
  | None -> None
  | Some v -> (
    match t.ofJson v with
    | s -> Some s
    | exception Json.Decode.DecodeError msg ->
      let (_ : unit Promise.t) =
        Window.showErrorMessage (sprintf "Setting %s is invalid: %s" t.key msg)
      in
      None )

let set t v =
  let scope = WorkspaceConfiguration.configurationTargetToJs t.scope in
  (* TODO this will raise if a workspace isn't open *)
  WorkspaceConfiguration.update section t.key (t.toJson v) scope

let string =
  let toJson = Js.Json.string in
  let ofJson (y : Js.Json.t) = Json.Decode.string y in
  create ~ofJson ~toJson
