(** Provide an interface to Dune pkg management.*)
open Import

type t =
  { root : Path.t
  ; bin : Cmd.spawn
  }

(** Check if a dune project has been locked.
    If not, user should be advised to run `dune pkg lock` *)
val is_project_locked : t -> bool Promise.t

(** Check if the dune project has ocamllsp server in its dev-tools.
    If not, user should be advised to run `dune tools exec ocamllsp` *)
val is_ocamllsp_present : t -> bool Promise.t

(** Generic function to execute dune commands *)
val exec : t -> args:string list -> Cmd.t

(** Run specific `dune pkg <foo> commands*)
val exec_pkg : t -> cmd:string -> ?args:string list -> unit -> Cmd.t

(** Execute any `dune tools exec` command*)
val exec_tool : t -> tool:string -> ?args:string list -> unit -> Cmd.t

(** Check if amy two instances of dune pkg management projects are the equal *)
val equal : t -> t -> bool

val make : root:Path.t -> unit -> t option Promise.t

(** Get the path of the project root directory *)
val root : t -> Path.t
