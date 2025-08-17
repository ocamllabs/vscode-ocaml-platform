(** Provide an interface to Dune pkg management.*)
open Import

type t =
  { root : Path.t
  ; bin : Cmd.spawn
  }

(** Check if a dune project has been locked.
    If not, user should be advised to run `dune pkg lock` *)
val is_project_locked : t -> bool Promise.t

(** Generic function to execute dune commands *)
val command : t -> args:string list -> Cmd.t

(** Generic function to execute dune exec commands *)
val exec : target:string -> ?args:string list -> t -> Cmd.t

(** Run specific `dune pkg <foo> commands*)
val exec_pkg : cmd:string -> ?args:string list -> t -> Cmd.t

(** Run `dune tools <exec/which>` *)
val tools
  :  tool:string
  -> ?args:string list
  -> t
  -> [< `Exec_ | `Which | `Install ]
  -> Cmd.t

(** Check if the dune project has ocamllsp server as a dev-tool. *)
val is_ocamllsp_present : t -> bool Promise.t

(** Check if amy two instances of dune pkg management projects are equal *)
val equal : t -> t -> bool

val make : Path.t option -> unit -> t option Promise.t

(** Get the path of the project root directory *)
val root : t -> Path.t
