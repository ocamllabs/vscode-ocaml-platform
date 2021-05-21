[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es5
open Node
open Vscode_test_download

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_version : t -> any [@@js.get "version"]

  val set_version : t -> any -> unit [@@js.set "version"]

  val get_date : t -> any [@@js.get "date"]

  val set_date : t -> any -> unit [@@js.set "date"]
end

(* import * as https from 'https'; *)
(* import { DownloadPlatform } from './download'; *)
val system_default_platform : string [@@js.global "systemDefaultPlatform"]

val get_vs_code_download_url :
  version:string -> ?platform:Download_platform.t -> unit -> string
  [@@js.global "getVSCodeDownloadUrl"]

val url_to_options : url:string -> Https.Request_options.t
  [@@js.global "urlToOptions"]

val download_dir_to_executable_path : dir:string -> string
  [@@js.global "downloadDirToExecutablePath"]

val insiders_download_dir_to_executable_path : dir:string -> string
  [@@js.global "insidersDownloadDirToExecutablePath"]

val insiders_download_dir_metadata : dir:string -> Anonymous_interface0.t
  [@@js.global "insidersDownloadDirMetadata"]

module Iupdate_metadata : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_url : t -> string [@@js.get "url"]

  val set_url : t -> string -> unit [@@js.set "url"]

  val get_name : t -> string [@@js.get "name"]

  val set_name : t -> string -> unit [@@js.set "name"]

  val get_version : t -> string [@@js.get "version"]

  val set_version : t -> string -> unit [@@js.set "version"]

  val get_product_version : t -> string [@@js.get "productVersion"]

  val set_product_version : t -> string -> unit [@@js.set "productVersion"]

  val get_hash : t -> string [@@js.get "hash"]

  val set_hash : t -> string -> unit [@@js.set "hash"]

  val get_timestamp : t -> int [@@js.get "timestamp"]

  val set_timestamp : t -> int -> unit [@@js.set "timestamp"]

  val get_sha256hash : t -> string [@@js.get "sha256hash"]

  val set_sha256hash : t -> string -> unit [@@js.set "sha256hash"]

  val get_supports_fast_update : t -> bool [@@js.get "supportsFastUpdate"]

  val set_supports_fast_update : t -> bool -> unit
    [@@js.set "supportsFastUpdate"]
end
[@@js.scope "IUpdateMetadata"]

val get_latest_insiders_metadata :
  platform:string -> Iupdate_metadata.t Promise.t
  [@@js.global "getLatestInsidersMetadata"]

val resolve_cli_path_from_vs_code_executable_path :
  vscode_executable_path:string -> string
  [@@js.global "resolveCliPathFromVSCodeExecutablePath"]
