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
  Option.iter selection ~f:(fun () ->
      Extension_commands.select_sandbox.handler instance ~args:[])

let activate (extension : ExtensionContext.t) =
  (* this env var update disables ocaml-lsp's logging to a file because we use
     vscode [output] pane for logs *)
  Process.Env.set "OCAML_LSP_SERVER_LOG" "-";
  let open Promise.Syntax in
  let instance = Extension_instance.make () in
  ExtensionContext.subscribe extension
    ~disposable:(Extension_instance.disposable instance);
  Extension_commands.register_all_commands extension instance;
  Dune_formatter.register extension instance;
  Dune_task_provider.register extension instance;
  let sandbox = Sandbox.of_settings_or_detect () in
  let* refresh =
    let+ disposable, command = Treeview_switches.register extension in
    ExtensionContext.subscribe extension ~disposable;
    command
  in
  let () =
    let handler (_ : Extension_instance.t) ~args:_ = refresh () in
    Extension_commands.make_command Extension_consts.Commands.refresh_switches
      handler
    |> Extension_commands.register extension instance
  in
  let (_ : unit Promise.t) =
    let+ disposable = Treeview_commands.register extension in
    ExtensionContext.subscribe extension ~disposable
  in
  let (_ : unit Promise.t) =
    let+ disposable = Treeview_help.register extension in
    ExtensionContext.subscribe extension ~disposable
  in
  let (_ : unit Promise.t) =
    let* sandbox = sandbox in
    let is_fallback = Option.is_empty sandbox in
    if
      is_fallback
      (* if the sandbox we just set up is a fallback sandbox, we create a pop-up
         message to offer the user to pick a sandbox they want; note: if the
         user picks another sandbox in the pop-up, we redo part of work we have
         just done; this is the case because we can't wait or rely on user to
         pick a sandbox: they may ignore the pop-up leaving the extension
         hanging, so we use fallback; w/ a proper detection mechanism, we would
         redo work in rare cases *)
    then
      suggest_to_pick_sandbox instance
    else
      Promise.return ()
  in
  let (_ : unit Promise.t) =
    let* sandbox = sandbox in
    let sandbox = Option.value sandbox ~default:Sandbox.Global in
    Extension_instance.set_sandbox instance sandbox;
    let+ () = Extension_instance.start_language_server instance in
    ()
  in
  Promise.return ()

(* see {{:https://code.visualstudio.com/api/references/vscode-api#Extension}
   activate() *)
let () =
  let open Js_of_ocaml.Js in
  export "activate" (wrap_callback activate)
