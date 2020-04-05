open Import

type 'a t =
  { key : string
  ; to_string : 'a -> string
  ; of_string : string -> 'a Or_error.t
  ; scope : WorkspaceConfiguration.configurationTarget
  }

let section = Workspace.getConfiguration "ocaml"

let create ~scope ~key ~of_string ~to_string =
  { scope; key; to_string; of_string }

let get t =
  match WorkspaceConfiguration.get section t.key with
  | None -> None
  | Some v -> (
    match t.of_string v with
    | Ok s -> Some s
    | Error msg ->
      let (_ : unit Promise.t) =
        Window.showErrorMessage (sprintf "Setting %s is invalid: %s" t.key msg)
      in
      None )

let set t v =
  let scope = WorkspaceConfiguration.configurationTargetToJs t.scope in
  WorkspaceConfiguration.update section t.key (t.to_string v) scope

let string = create ~of_string:(fun x -> Ok x) ~to_string:(fun x -> x)
