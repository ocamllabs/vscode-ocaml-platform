(** Interface for running system commands *)

open Import

type shell = string

type spawn =
  { bin : Path.t
  ; args : string list
  }

type t =
  | Shell of shell
  | Spawn of spawn

type stdout = string

type stderr = string

(* surround a string with quotes if it has spaces *)
val quote : string -> string

val append : spawn -> string list -> spawn

val check_spawn : ?env:string Dict.t -> spawn -> spawn Or_error.t Promise.t

val check : ?env:string Dict.t -> t -> t Or_error.t Promise.t

val log : ?result:Child_process.return -> t -> unit

val output :
     ?cwd:Path.t
  -> ?env:string Dict.t
  -> ?stdin:string
  -> t
  -> (stdout, stderr) result Promise.t

val equal_spawn : spawn -> spawn -> bool

val run :
     ?cwd:Path.t
  -> ?env:string Dict.t
  -> ?stdin:stderr
  -> t
  -> Child_process.return Promise.t
