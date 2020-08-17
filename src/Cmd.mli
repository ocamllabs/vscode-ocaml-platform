(** Interface for running system commands *)

open Import

type shell = [ `Shell of string ]

type spawn = [ `Spawn of Path.t * string list ]

type t =
  [ shell
  | spawn
  ]

type stdout = string

type stderr = string

val append : spawn -> string list -> [> spawn ]

val check : ([< shell | spawn > `Spawn ] as 'a) -> 'a Or_error.t Promise.t

val toSpawn : t -> spawn

val log : ?cwd:string -> ?result:ChildProcess.return -> t -> unit

val output :
  ?cwd:Path.t -> ?stdin:string -> t -> (stdout, stderr) result Promise.t
