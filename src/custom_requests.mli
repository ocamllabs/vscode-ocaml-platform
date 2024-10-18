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

module Get_documentation : sig
  type params

  type response =
    { kind : string
    ; value : string
    }

  val make :
       uri:Uri.t
    -> position:Position.t
    -> ?identifier:string option
    -> ?contentFormat:[ `Plantext | `Markdown ] option
    -> unit
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

module Hover_extended : sig
  type content =
    { kind : string
    ; value : string
    }

  type hover_extended_results =
    { contents : content
    ; range : Range.t
    }

  type params

  type response = hover_extended_results list

  val make :
    uri:Uri.t -> position:Position.t -> ?verbosity:int option -> unit -> params

  val request : (params, response) custom_request
end

module Merlin_jump : sig
  type params

  type response =
    { uri : Uri.t
    ; position : Position.t
    }

  val make : uri:Uri.t -> position:Position.t -> target:string -> unit -> params

  val request : (params, response) custom_request
end

module Type_search : sig
  type tpye_search_results =
    { name : string
    ; typ : string
    ; loc : Range.t
    ; doc : string option
    ; cost : int
    ; constructible : string
    }

  type params

  type response = tpye_search_results list

  val make :
       uri:Uri.t
    -> position:Position.t
    -> limit:int
    -> query:string
    -> with_doc:bool
    -> unit
    -> params

  val request : (params, response) custom_request
end
