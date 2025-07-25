(** Module to manage commands[1] across the extension.

    Module does not have public API for command creation on purpose. One should
    only create new commands in [extension_commands.ml] using [command] function
    and expose them here if they want to.

    All commands are registered using [register_all_commands] in
    [Vscode_ocaml_platform.activate].

    [1] https://code.visualstudio.com/api/references/vscode-api#commands *)

(** Registers commands with vscode. Should be called in
    [Vscode_ocaml_platform.activate]. It subscribes the disposables to the
    extension context provided. *)
val register_all_commands : Vscode.ExtensionContext.t -> Extension_instance.t -> unit

val register : ('a, 'b) Command_api.handle -> (Extension_instance.t -> 'a -> 'b) -> unit

val register_text_editor
  :  (unit, unit) Command_api.handle
  -> (Extension_instance.t
      -> textEditor:Vscode.TextEditor.t
      -> edit:Vscode.TextEditorEdit.t
      -> unit
      -> unit)
  -> unit
