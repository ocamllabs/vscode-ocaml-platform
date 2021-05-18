[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Promise<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module Promise : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
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
      type _DownloadPlatform = (([`L_s0_darwin[@js "darwin"] | `L_s2_linux_x64[@js "linux-x64"] | `L_s4_win32_archive[@js "win32-archive"] | `L_s5_win32_x64_archive[@js "win32-x64-archive"]] [@js.enum]), string) _StringLiteralUnion
      and _DownloadVersion = (([`L_s1_insiders[@js "insiders"] | `L_s3_stable[@js "stable"]] [@js.enum]), string) _StringLiteralUnion
      and ('T, 'U) _StringLiteralUnion = 'T
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
  end
  module StringLiteralUnion : sig
    type ('T, 'U) t = ('T, 'U) _StringLiteralUnion
    val t_to_js: ('T -> Ojs.t) -> ('U -> Ojs.t) -> ('T, 'U) t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'U) -> Ojs.t -> ('T, 'U) t
    type ('T, 'U) t_2 = ('T, 'U) t
    val t_2_to_js: ('T -> Ojs.t) -> ('U -> Ojs.t) -> ('T, 'U) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'U) -> Ojs.t -> ('T, 'U) t_2
  end
  module DownloadVersion : sig
    type t = _DownloadVersion
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module DownloadPlatform : sig
    type t = _DownloadPlatform
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  val downloadAndUnzipVSCode: ?version:_DownloadVersion -> ?platform:_DownloadPlatform -> unit -> string Promise.t_1 [@@js.global "downloadAndUnzipVSCode"]
  
end
