open Import

type 'a t =
  { key : string
  ; toJson : 'a -> Jsonoo.t
  ; ofJson : Jsonoo.t -> 'a
  ; scope : Vscode.ConfigurationTarget.t
  }

let create ~scope ~key ~ofJson ~toJson = { scope; key; toJson; ofJson }

let get ?section t =
  let section = Vscode.Workspace.get_configuration ?section () in
  match Vscode.WorkspaceConfiguration.get section ~section:t.key () with
  | None -> None
  | Some v -> (
    match t.ofJson v with
    | s -> Some s
    | exception Jsonoo.Decode_error msg ->
      message `Error "Setting %s is invalid: %s" t.key msg;
      None )

let set ?section t v =
  let section = Vscode.Workspace.get_configuration ?section () in
  match Vscode.Workspace.name () with
  | None -> Promise.return ()
  | Some _ ->
    Vscode.WorkspaceConfiguration.update section ~section:t.key
      ~value:(t.toJson v) ~configuration_target:(`ConfigurationTarget t.scope)
      ()

let string =
  let toJson = Jsonoo.Encode.string in
  let ofJson = Jsonoo.Decode.string in
  create ~ofJson ~toJson
