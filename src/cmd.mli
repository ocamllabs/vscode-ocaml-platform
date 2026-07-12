(** Interface for running system commands *)

open Import

type spawn =
  { bin : Path.t
  ; args : string list
  }

type t =
  | Shell of string
  | Spawn of spawn

type stdout = string
type stderr = string

(* surround a string with quotes if it has spaces *)
val quote : string -> string
val to_spawn : t -> spawn
val append : spawn -> string list -> spawn
val check_spawn : ?env:string Interop.Dict.t -> spawn -> spawn Or_error.t Promise.t
val check : ?env:string Interop.Dict.t -> t -> t Or_error.t Promise.t

(* [log_output] controls whether captured stdout and stderr are copied to the
   command and extension logs. Set it to [false] for machine-readable or
   potentially sensitive output; the returned output is unaffected. *)
val log : ?result:ChildProcess.return -> ?log_output:bool -> t -> unit

val output
  :  ?cwd:Path.t
  -> ?env:string Interop.Dict.t
  -> ?stdin:string
  -> ?log_output:bool
  -> t
  -> (stdout, stderr) result Promise.t

val equal_spawn : spawn -> spawn -> bool

val run
  :  ?cwd:Path.t
  -> ?env:string Interop.Dict.t
  -> ?stdin:stderr
  -> ?log_output:bool
  -> t
  -> ChildProcess.return Promise.t
