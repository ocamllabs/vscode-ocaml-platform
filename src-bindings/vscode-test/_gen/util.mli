[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - DownloadPlatform
  - Promise<T1>
  - https.RequestOptions
 *)
[@@@js.stop]
module type Missing = sig
  module DownloadPlatform : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Promise : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module https : sig
    module RequestOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
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
    module Promise : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module https : sig
      module RequestOptions : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
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
      type _IUpdateMetadata = [`IUpdateMetadata] intf
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
    val get_version: t -> any [@@js.get "version"]
    val set_version: t -> any -> unit [@@js.set "version"]
    val get_date: t -> any [@@js.get "date"]
    val set_date: t -> any -> unit [@@js.set "date"]
  end
  (* import * as https from 'https'; *)
  (* import { DownloadPlatform } from './download'; *)
  val systemDefaultPlatform: string [@@js.global "systemDefaultPlatform"]
  val getVSCodeDownloadUrl: version:string -> ?platform:DownloadPlatform.t_0 -> unit -> string [@@js.global "getVSCodeDownloadUrl"]
  val urlToOptions: url:string -> Https.RequestOptions.t_0 [@@js.global "urlToOptions"]
  val downloadDirToExecutablePath: dir:string -> string [@@js.global "downloadDirToExecutablePath"]
  val insidersDownloadDirToExecutablePath: dir:string -> string [@@js.global "insidersDownloadDirToExecutablePath"]
  val insidersDownloadDirMetadata: dir:string -> anonymous_interface_0 [@@js.global "insidersDownloadDirMetadata"]
  module[@js.scope "IUpdateMetadata"] IUpdateMetadata : sig
    type t = _IUpdateMetadata
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_url: t -> string [@@js.get "url"]
    val set_url: t -> string -> unit [@@js.set "url"]
    val get_name: t -> string [@@js.get "name"]
    val set_name: t -> string -> unit [@@js.set "name"]
    val get_version: t -> string [@@js.get "version"]
    val set_version: t -> string -> unit [@@js.set "version"]
    val get_productVersion: t -> string [@@js.get "productVersion"]
    val set_productVersion: t -> string -> unit [@@js.set "productVersion"]
    val get_hash: t -> string [@@js.get "hash"]
    val set_hash: t -> string -> unit [@@js.set "hash"]
    val get_timestamp: t -> float [@@js.get "timestamp"]
    val set_timestamp: t -> float -> unit [@@js.set "timestamp"]
    val get_sha256hash: t -> string [@@js.get "sha256hash"]
    val set_sha256hash: t -> string -> unit [@@js.set "sha256hash"]
    val get_supportsFastUpdate: t -> bool [@@js.get "supportsFastUpdate"]
    val set_supportsFastUpdate: t -> bool -> unit [@@js.set "supportsFastUpdate"]
  end
  val getLatestInsidersMetadata: platform:string -> _IUpdateMetadata Promise.t_1 [@@js.global "getLatestInsidersMetadata"]
  val resolveCliPathFromVSCodeExecutablePath: vscodeExecutablePath:string -> string [@@js.global "resolveCliPathFromVSCodeExecutablePath"]
end
