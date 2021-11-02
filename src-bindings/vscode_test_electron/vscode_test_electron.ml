open Interop

module Download = struct
  module Platform = struct
    type t =
      | Insiders [@js "insiders"]
      | Stable [@js "stable"]
    [@@js.enum] [@@js]
  end

  module Version = struct
    type t =
      | Darwin [@js "darwin"]
      | Win32_archive [@js "win32-archive"]
      | Win32_x64_archive [@js "win32-x64-archive"]
      | Linux_x64 [@js "linux-x64"]
    [@@js.enum] [@@js]
  end
end

module TestOptions = struct
  include Interface.Make ()

  include
    [%js:
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
    [@@js.builder]]
end

include
  [%js:
  val run_tests : TestOptions.t -> int Promise.t
  [@@js.global "vscode_test_electron.runTests"]]
