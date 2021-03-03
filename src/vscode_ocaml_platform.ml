open Import

let suggest_to_pick_sandbox () =
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
      let (_ : Ojs.t option Promise.t) =
        Vscode.Commands.executeCommand
          ~command:Extension_consts.Commands.select_sandbox ~args:[]
      in
      ())

let activate (extension : ExtensionContext.t) =
  (* this env var update disables ocaml-lsp's logging to a file because we use
     vscode [output] pane for logs *)
  Process.Env.set "OCAML_LSP_SERVER_LOG" "-";
  let open Promise.Syntax in
  let instance = Extension_instance.make () in
  ExtensionContext.subscribe extension
    ~disposable:(Extension_instance.disposable instance);
  Dune_formatter.register extension instance;
  Dune_task_provider.register extension instance;
  Extension_commands.register_all_commands extension instance;
  Treeview_switches.register extension;
  Treeview_sandbox.register extension instance;
  Treeview_commands.register extension;
  Treeview_help.register extension;
  Repl.register extension instance;
  let sandbox_opt = Sandbox.of_settings_or_detect () in
  let toolchain =
    let* sandbox = sandbox_opt in
    Toolchain.setup ?project_sandbox:sandbox ()
  in
  let (_ : unit Promise.t) =
    let* sandbox_opt = sandbox_opt in
    let is_fallback = Option.is_empty sandbox_opt in
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
      suggest_to_pick_sandbox ()
    else
      Promise.return ()
  in
  let (_ : unit Promise.t) =
    let* sandbox_opt = sandbox_opt in
    (* Very important to run this after the sandbox. If there is no toolchain
       available yet, we want to check if the tools are in the user switch so we
       don't force them to wait for 10min before they can use the extension. *)
    let* toolchain = toolchain in
    let sandbox = Option.value sandbox_opt ~default:Sandbox.Global in
    Extension_instance.set_sandbox instance sandbox;
    match toolchain with
    | Ok toolchain ->
      Extension_instance.set_toolchain instance toolchain;
      let+ () = Extension_instance.start_language_server instance in
      let (_ : (unit, string) result Promise.t) = Toolchain.upgrade toolchain in
      ()
    | Error _ ->
      (* User is notified of errors when setting up the toolchain already. *)
      let+ () = Extension_instance.start_language_server instance in
      ()
  in
  Promise.return ()

(* see {{:https://code.visualstudio.com/api/references/vscode-api#Extension}
   activate() *)
let () =
  let open Js_of_ocaml.Js in
  export "activate" (wrap_callback activate)
