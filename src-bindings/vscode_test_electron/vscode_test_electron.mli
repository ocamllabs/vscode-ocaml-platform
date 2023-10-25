open Interop

module Download : sig
  module Platform : sig
    type t =
      | Insiders
      | Stable
  end

  module Version : sig
    type t =
      | Darwin
      | Win32_archive
      | Win32_x64_archive
      | Linux_x64
  end
end

module TestOptions : sig
  include Js.T

  val create :
       ?vscode_executable_path:string
    -> ?version:Download.Version.t
    -> ?platform:Download.Platform.t
    -> ?extenion_test_env:string Interop.Dict.t
    -> ?launch_args:string list
    -> extension_development_path:string
    -> extension_tests_path:string
    -> unit
    -> t
end

(** [run_tests] launches the VS Code extension test and returns exit code as a
    promise. *)
val run_tests : TestOptions.t -> int Promise.t
