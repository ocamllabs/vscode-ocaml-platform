open Import

(** Module to include custom requests to the language server, i.e., requests
    that are not originally in LSP but are customly added by a specific language
    server.

    If you want to add support for a custom request, add [custom_request] for
    the custom request to the implementation of this module. *)

type ('params, 'response) custom_request

val send_request :
     LanguageClient.t
  -> ('params, 'resp) custom_request
  -> 'params
  -> 'resp Promise.t

val switchImplIntf : (string, string array) custom_request

val inferIntf : (string, string) custom_request

val typedHoles : (Uri.t, Range.t list) custom_request

module Type_enclosing : sig
  type params

  type response =
    { index : int
    ; type_ : string
    ; enclosings : Range.t list
    }

  val make :
       uri:Uri.t
    -> at:[ `Position of Position.t | `Range of Range.t ]
    -> index:int
    -> verbosity:int
    -> params

  val request : (params, response) custom_request
end

module Construct : sig
  type params

  type response =
    { position : Range.t
    ; result : string list
    }

  val make :
       uri:Uri.t
    -> position:Position.t
    -> ?depth:int option
    -> ?with_values:[ `None | `Local ] option
    -> unit
    -> params

  val request : (params, response) custom_request
end

module Merlin_jump : sig
  type params

  type response = (string * Position.t) list

  val make : uri:Uri.t -> position:Position.t -> params

  val request : (params, response) custom_request
end
