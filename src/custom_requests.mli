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
