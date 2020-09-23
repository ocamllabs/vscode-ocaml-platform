(** Toolchain.ml exposes functions that let us

   1. Run initial checks in the environment looking for a reliable toolchain
   ([Toolchain.init])

   2. Run a setup that would setup the toolchain provided that basic
   requirements are met ([Toolchain.runSetup])

   3. Helper functions that extract the tools from the setup toolchain. This
   includes just [ocamllsp] right now, but in future could include others like
   debuggers, REPLs etc that could be shipped with [vscode-ocaml-platform] plugin
   itself

   The separation between init, runSetup and extraction helpers exist so that we
   can handle missing tools gracefully (ie provide degraded performance, direct
   user to install missing tools etc). Having a single [Toolchain.make()], for
   instance, would not make it this flexible. *)

module PackageManager : sig
  type t =
    | Opam of Opam.t * Opam.Switch.t
    | Esy of Esy.t * Path.t
    | Global
    | Custom of string

  val toString : t -> string

  val toPrettyString : t -> string
end

type resources

val ofSettings : unit -> PackageManager.t option Promise.t

val makeResources : PackageManager.t -> resources

val packageManager : resources -> PackageManager.t

(** [selectAndSave] requires the process environment the plugin is being run in
   (ie VSCode's process environment) and the project root and produces a promise
   of resources available that can later be passed on to runSetup that can be
   called to install the toolchain. *)
val selectAndSave : unit -> PackageManager.t option Promise.t

(** [select] is the same as [selectAndSave] but does not save the toolchain configuration *)
val select : unit -> PackageManager.t option Promise.t

(** [runSetup] is a effectful function that triggers setup instructions
   automatically for the user. At present, this functionality
   resides in the plugin itself for bucklescript users - to
   reliably use ocamllsp for bucklescript users, a sandboxed
   environment provides a reliable way to setup the OCaml
   toolchain. {{: https://github.com/prometheansacrifice/esy-mode#npm-and-bucklescript-build-system-managed-projects} More details }
   We use Esy to provide

   1. A scrubbed environment with just OCaml tools in it - this is
   necessary since OCaml tools are closely tied to compiler versions and
   look into the global environments to find plugins (Eg. Merlin and Reason)
   2. Relocatable assets so that users can
   download the toolchain artifacts and compile it from source in
   the same workflow.

   [runSetup] is capable of setting up the toolchain for bucklescript
   project using both Opam and Esy users. It provides and abstracted
   way to setup the toolchain, so that we (developers) have the
   flexibility to iterate and improve how the toolchain it provided.

   A hard requirement for runSetup is to not get in the way to
   existing setups. If users already have working toolchains installed
   via some other toolchain/package manager (Nix, system wide managers
   like yum/apt/brew or Duniverse), [runSetup] must co-operate and
   detect such installations.
 *)
val runSetup : resources -> (unit, string) result Promise.t

(* Helper utils *)

(** Extract command to run with the toolchain *)
val getCommand : resources -> string -> string list -> Cmd.t

(** Extract lsp command and arguments (Eg. "opam" and [| "exec";
   "ocamllsp" |] *)
val getLspCommand : ?args:string list -> resources -> Cmd.t

(** Extract a dune command *)
val getDuneCommand : resources -> string list -> Cmd.t
