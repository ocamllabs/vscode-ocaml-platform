(** [requestSwitch] will attempt to switch between the implementation and
	interface for a given file. If a valid language client is provided, the
	function will send a `ocaml/didSwitchImplIntf` message to the language
	server. If a valid language client is not provided or the language server
	message fails, a less accurate fallback mechanism will be used. *)
val requestSwitch :
  Vscode.LanguageClient.t option -> Vscode.TextDocument.t -> unit Promise.t
