(** The paths selected by Dune for a workspace and build context. *)
type t

val root : t -> Path.t
val build_context : t -> Path.t

(** Resolve Dune's effective workspace paths in the selected sandbox.

    This gives [DUNE_BUILD_DIR], [DUNE_ROOT], [DUNE_WORKSPACE], and
    [DUNE_CROSS_TARGET] priority when the selected Dune supports them. It asks
    Dune for workspace-specific paths and uses Dune's Merlin protocol to select
    the editor context when needed. Other Dune variables, including its XDG and
    cache variables, do not change the location of preprocessed build artifacts.
    If Dune is busy, this falls back to the environment and Dune's default
    layout. *)
val discover : Sandbox.t -> cwd:Path.t -> source:Path.t -> t Promise.t

(** Clear the cached discovery results, for example before retrying after a
    rebuild or sandbox change. *)
val invalidate : unit -> unit
