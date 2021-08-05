open Import

(** This module is more of a "settings manager", which works with VS Code's
    [WorkspaceConfiguration] to retrieve and set settings. A setting is
    represented by ['value setting] type defined below. *)

(** ['value setting] represents a setting (word used as a singular of
    "settings"), which has a value of type ['value] *)
type 'value setting

(* TODO: improve the treatment of "section"

   All settings in the extension are defined using a dot-separated path, e.g.,
   [ocaml.dune.autoDetect]. In some places, we treat [key] as this whole path
   for the setting, [ocaml.dune.autoDetect], and in some places we use
   [autoDetect] as the key and [ocaml.dune] as the "section". VS Code allows
   this, but this non uniform treatment is bad. We should enforce a nicer
   API. *)

val get : ?section:string -> 'value setting -> 'value option

val set : ?section:string -> 'value setting -> 'value -> unit Promise.t

val create_setting :
     scope:ConfigurationTarget.t
  -> key:string
  -> of_json:(Jsonoo.t -> 'value)
  -> to_json:('value -> Jsonoo.t)
  -> 'value setting

(** replace ${workspaceFolder:folder_name} variables with workspace folder
    paths *)
val resolve_workspace_vars : string -> string

(** replace workspace folder paths with ${workspaceFolder:folder_name}
    variables *)
val substitute_workspace_vars : string -> string

val server_extraEnv : unit -> string Interop.Dict.t option

val repl_path : unit -> string option

val repl_args : unit -> string list option

module Repl_terminal : sig
  type t =
    | Always_existing_terminal
    | Always_create_new_terminal
    | Always_ask
end

val repl_terminal : unit -> Repl_terminal.t
