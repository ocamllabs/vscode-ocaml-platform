open Import

let suggest_to_pick_sandbox instance =
  let open Promise.Syntax in
  let select_pm_button_text = "Select package manager and sandbox" in
  let+ selection =
    Window.showInformationMessage
      ~message:
        "OCaml Platform is using the package manager and sandbox available in \
         the environment. Pick a particular package manager and sandbox by \
         clicking the button below"
      ~choices:[ (select_pm_button_text, ()) ]
      ()
  in
  Option.iter selection ~f:(Extension_commands.select_sandbox.handler instance)

let activate (extension : ExtensionContext.t) =
  (* this env var update disables ocaml-lsp's logging to a file
     because we use vscode [output] pane for logs *)
  Process.Env.set "OCAML_LSP_SERVER_LOG" "-";
  let open Promise.Syntax in
  let* toolchain =
    Toolchain.of_settings ()
    (* TODO: implement [Toolchain.from_settings_or_detect] that would
       either get the sandbox from the settings or detect in a smart way (not simply Global) *)
  in
  let is_fallback = Option.is_empty toolchain in
  let toolchain = Option.value toolchain ~default:Toolchain.Global in
  Extension_instance.make toolchain
  |> Promise.Result.iter
       ~ok:(fun instance ->
         (* register things with vscode, making sure to register their disposables *)
         ExtensionContext.subscribe extension
           ~disposable:(Extension_instance.disposable instance);
         Extension_commands.register_all_commands extension instance;
         Dune_formatter.register extension instance;
         Dune_task_provider.register extension instance;
         if
           is_fallback
           (* if the toolchain we just set up is a fallback sandbox,
              we create a pop-up message to offer the user to pick a sandbox they want;
              note: if the user picks another sandbox in the pop-up,
                we redo part of work we have just done;
                this is the case because we can't wait or rely on user to pick a sandbox:
                they may ignore the pop-up leaving the extension hanging, so we use fallback;
                w/ a proper detection mechanism, we would redo work in rare cases *)
         then
           let (_ : unit Promise.t) = suggest_to_pick_sandbox instance in
           ())
       ~error:(fun e -> show_message `Error "%s" e)
  |> Promise.catch ~rejected:(fun e ->
         let error_message = Node.JsError.message e in
         show_message `Error "Error: %s" error_message;
         Promise.return ())

let () =
  let open Js_of_ocaml.Js in
  export "activate" (wrap_callback activate)
