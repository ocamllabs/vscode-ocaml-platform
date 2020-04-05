open Import

type 'a t =
  { key : string
  ; to_string : 'a -> string
  ; of_string : string -> 'a
  ; scope : WorkspaceConfiguration.configurationTarget
  }

let section = Workspace.getConfiguration "ocaml"

let create ~scope ~key ~of_string ~to_string =
  { scope; key; to_string; of_string }

let get t =
  match WorkspaceConfiguration.get section t.key with
  | None -> None
  | Some v -> Some (t.of_string v)

let set t v =
  let scope = WorkspaceConfiguration.configurationTargetToJs t.scope in
  WorkspaceConfiguration.update section t.key (t.to_string v) scope

let string =
  let id x = x in
  create ~of_string:id ~to_string:id
