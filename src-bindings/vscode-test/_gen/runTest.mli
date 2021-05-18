[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - DownloadPlatform
  - DownloadVersion
  - Promise<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module DownloadPlatform : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module DownloadVersion : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Promise : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module DownloadPlatform : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module DownloadVersion : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Promise : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
  end
]
module Make (M: Missing) : sig
  open M
  module Internal : sig
    module AnonymousInterfaces : sig
      type anonymous_interface_0 = [`anonymous_interface_0] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
    module Types : sig
      open AnonymousInterfaces
      type _TestOptions = [`TestOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module AnonymousInterface0 : sig
    type t = anonymous_interface_0
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get: t -> string -> string or_undefined [@@js.index_get]
    val set: t -> string -> string or_undefined -> unit [@@js.index_set]
  end
  (* import { DownloadVersion, DownloadPlatform } from './download'; *)
  module[@js.scope "TestOptions"] TestOptions : sig
    type t = _TestOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_vscodeExecutablePath: t -> string [@@js.get "vscodeExecutablePath"]
    val set_vscodeExecutablePath: t -> string -> unit [@@js.set "vscodeExecutablePath"]
    val get_version: t -> DownloadVersion.t_0 [@@js.get "version"]
    val set_version: t -> DownloadVersion.t_0 -> unit [@@js.set "version"]
    val get_platform: t -> DownloadPlatform.t_0 [@@js.get "platform"]
    val set_platform: t -> DownloadPlatform.t_0 -> unit [@@js.set "platform"]
    val get_extensionDevelopmentPath: t -> string [@@js.get "extensionDevelopmentPath"]
    val set_extensionDevelopmentPath: t -> string -> unit [@@js.set "extensionDevelopmentPath"]
    val get_extensionTestsPath: t -> string [@@js.get "extensionTestsPath"]
    val set_extensionTestsPath: t -> string -> unit [@@js.set "extensionTestsPath"]
    val get_extensionTestsEnv: t -> anonymous_interface_0 [@@js.get "extensionTestsEnv"]
    val set_extensionTestsEnv: t -> anonymous_interface_0 -> unit [@@js.set "extensionTestsEnv"]
    val get_launchArgs: t -> string list [@@js.get "launchArgs"]
    val set_launchArgs: t -> string list -> unit [@@js.set "launchArgs"]
  end
  val runTests: options:_TestOptions -> float Promise.t_1 [@@js.global "runTests"]
end
