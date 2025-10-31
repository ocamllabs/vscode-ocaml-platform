open Import

let suggest_to_pick_sandbox () =
  let open Promise.Syntax in
  let select_pm_button_text = "Select package manager and sandbox" in
  let+ selection =
    Window.showInformationMessage
      ~message:
        "OCaml Platform is using the package manager and sandbox available in the \
         environment. Pick a particular package manager and sandbox by clicking the \
         button below"
      ~choices:[ select_pm_button_text, () ]
      ()
  in
  Option.iter selection ~f:(fun () ->
    let (_ : unit Promise.t) = Command_api.(execute Internal.select_sandbox) () in
    ())
;;

let notify_configuration_changes instance =
  Workspace.onDidChangeConfiguration
    ~listener:(fun _event ->
      let codelens = Settings.(get server_codelens_setting) in
      let codelens_for_nested_bindings =
        Settings.(get server_codelens_for_nested_bindings_setting)
      in
      let extended_hover = Settings.(get server_extendedHover_setting) in
      let dune_diagnostics = Settings.(get server_duneDiagnostics_setting) in
      let syntax_documentation = Settings.(get server_syntaxDocumentation_setting) in
      Extension_instance.set_configuration
        instance
        ~codelens
        ?codelens_for_nested_bindings
        ~extended_hover
        ~dune_diagnostics
        ~syntax_documentation
        ())
    ()
;;

let activate (extension : ExtensionContext.t) =
  let open Promise.Syntax in
  let instance = Extension_instance.make () in
  ExtensionContext.subscribe
    extension
    ~disposable:(Extension_instance.disposable instance);
  ExtensionContext.subscribe extension ~disposable:(notify_configuration_changes instance);
  Dune_formatter.register extension instance;
  Dune_task_provider.register extension instance;
  Treeview_switches.register extension instance;
  Treeview_sandbox.register extension instance;
  Treeview_commands.register extension;
  Treeview_help.register extension;
  Ast_editor.register extension instance;
  Cm_editor.register extension instance;
  Repl.register extension instance;
  Earlybird.register extension instance;
  (* Extension_commands.register_all_commands registers all commands that were
     added in the register functions above. It must be called last. *)
  Extension_commands.register_all_commands extension instance;
  let sandbox_opt = Sandbox.of_settings_or_detect () in
  let (_ : unit Promise.t) =
    let* sandbox_opt = sandbox_opt in
    let is_fallback = Option.is_none sandbox_opt in
    if
      is_fallback
      (* if the sandbox we just set up is a fallback sandbox, we create a pop-up
         message to offer the user to pick a sandbox they want; note: if the
         user picks another sandbox in the pop-up, we redo part of work we have
         just done; this is the case because we can't wait or rely on user to
         pick a sandbox: they may ignore the pop-up leaving the extension
         hanging, so we use fallback; w/ a proper detection mechanism, we would
         redo work in rare cases *)
    then suggest_to_pick_sandbox ()
    else Promise.return ()
  in
  let (_ : unit Promise.t) =
    let* sandbox_opt = sandbox_opt in
    let sandbox = Option.value sandbox_opt ~default:Sandbox.Global in
    Extension_instance.set_sandbox instance sandbox;
    let* () = Extension_instance.update_ocaml_info instance in
    let+ () = Extension_instance.start_language_server instance in
    ()
  in
  Promise.return ()
;;

(* see {{:https://code.visualstudio.com/api/references/vscode-api#Extension}
   activate() *)
let () =
  let open Js_of_ocaml.Js in
  export "activate" (wrap_callback activate)
;;
