open Import

type 'a t

val get : ?section:string -> 'a t -> 'a option

val set : ?section:string -> 'a t -> 'a -> unit Promise.t

val create :
     scope:Configuration_target.t
  -> key:string
  -> of_json:(Json.t -> 'a)
  -> to_json:('a -> Json.t)
  -> 'a t

val string : scope:Configuration_target.t -> key:string -> string t

(** replace ${workspaceFolder:folder_name} variables with workspace folder paths *)
val resolve_workspace_vars : string -> string

(** replace workspace folder paths with ${workspaceFolder:folder_name} variables *)
val substitute_workspace_vars : string -> string
