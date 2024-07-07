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
          ~command:Extension_consts.Commands.select_sandbox
          ~args:[]
      in
      ())

let notify_configuration_changes instance =
  Workspace.onDidChangeConfiguration
    ~listener:(fun _event ->
      let codelens = Settings.(get server_codelens_setting) in
      let extended_hover = Settings.(get server_extendedHover_setting) in
      let dune_diagnostics = Settings.(get server_duneDiagnostics_setting) in
      let syntax_documentation =
        Settings.(get server_syntaxDocumentation_setting)
      in
      Extension_instance.set_configuration
        instance
        ~codelens
        ~extended_hover
        ~dune_diagnostics
        ~syntax_documentation)
    ()

let activate (extension : ExtensionContext.t) =
  let open Promise.Syntax in
  let instance = Extension_instance.make () in
  ExtensionContext.subscribe
    extension
    ~disposable:(Extension_instance.disposable instance);
  ExtensionContext.subscribe
    extension
    ~disposable:(notify_configuration_changes instance);
  Dune_formatter.register extension instance;
  Dune_task_provider.register extension instance;
  Extension_commands.register_all_commands extension instance;
  Treeview_switches.register extension instance;
  Treeview_sandbox.register extension instance;
  Treeview_commands.register extension;
  Treeview_help.register extension;
  Ast_editor.register extension instance;
  Cm_editor.register extension instance;
  Repl.register extension instance;
  Earlybird.register extension instance;

  let _hoverProviderDisposable =
    let selector = `List [ `String "ocaml"; `String "ocaml.interface" ] in
    let log fmt = log_chan ~section:"verbose-hover" `Info fmt in
    let provider =
      HoverProvider.create
        ~provideHover:(fun ~document ~position ~token:_ ~context ->
          match Extension_instance.language_client instance with
          | None -> failwith "ocaml-lsp is missing"
          | Some olsp ->
            let uri = TextDocument.uri document in
            let previous_hover =
              context
              |> Option.bind ~f:HoverContext.previousHover
              |> Option.bind ~f:Olsp_verbose_hover.from_hover
            in
            let verbosity_delta =
              let verbosity_delta =
                Option.bind ~f:HoverContext.verbosityDelta context
              in
              log
                "verbosity delta = %d"
                (Option.value verbosity_delta ~default:(-1));
              let verbosity_delta = Option.value ~default:0 verbosity_delta in
              verbosity_delta
            in
            let previous_verbosity =
              Option.value_map
                previous_hover
                ~f:Olsp_verbose_hover.verbosity
                ~default:0
            in
            let verbosity = previous_verbosity + verbosity_delta in
            let open Promise.Syntax in
            let r =
              let+ hover =
                Custom_requests.(
                  send_request
                    olsp
                    ExtendedHover.hoverExtended
                    { textDocument = { uri }
                    ; position
                    ; verbosity = Some verbosity
                    })
              in
              match hover with
              | None -> None
              | Some new_hover ->
                let has_hover_contents_changed =
                  match previous_hover with
                  | None -> true
                  | Some previous_hover -> (
                    match new_hover.contents with
                    | `MarkdownString new_contents ->
                      let previous_hover =
                        Olsp_verbose_hover.contents previous_hover
                      in
                      not
                        (List.equal
                           (fun a b ->
                             String.equal
                               (MarkdownString.value a)
                               (MarkdownString.value b))
                           previous_hover
                           [ new_contents ])
                    | _ -> true)
                in
                Some
                  (Olsp_verbose_hover.to_verboseHover
                     (Olsp_verbose_hover.make
                        ~contents:new_hover.contents
                          (* ~contents: (`MarkdownString (MarkdownString.make
                             ~value:"hello" ())) *)
                        ~verbosity:
                          (if has_hover_contents_changed then verbosity
                           else previous_verbosity)
                        ~range:None
                        ~canIncreaseVerbosity:(Some has_hover_contents_changed)
                        ~canDecreaseVerbosity:(Some (verbosity > 0))
                        ()))
            in
            `Promise r)
    in
    Languages.registerHoverProvider ~selector ~provider
  in

  ExtensionContext.subscribe extension ~disposable:_hoverProviderDisposable;

  let sandbox_opt = Sandbox.of_settings_or_detect () in
  let (_ : unit Promise.t) =
    let* sandbox_opt in
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
    let* sandbox_opt in
    let sandbox = Option.value sandbox_opt ~default:Sandbox.Global in
    Extension_instance.set_sandbox instance sandbox;
    let* () = Extension_instance.update_ocaml_info instance in
    let+ () = Extension_instance.start_language_server instance in
    ()
  in
  Promise.return ()

(* see {{:https://code.visualstudio.com/api/references/vscode-api#Extension}
   activate() *)
let () =
  let open Js_of_ocaml.Js in
  export "activate" (wrap_callback activate)
