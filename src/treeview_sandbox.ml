open Import

module Dependency = struct
  type t = Sandbox.Package.t

  let t_of_js : Ojs.t -> t = Stdlib.Obj.magic

  let t_to_js : t -> Ojs.t = Stdlib.Obj.magic

  let label t = Sandbox.Package.name t

  let description t = Promise.return (Some (Sandbox.Package.version t))

  let tooltip t = Sandbox.Package.synopsis t

  let context_value t =
    match Sandbox.Package.documentation t with
    | Some _ -> "package-with-doc"
    | None -> "package"

  let icon _ =
    TreeItem.LightDarkIcon.
      { light = `String (Path.asset "number-light.svg" |> Path.to_string)
      ; dark = `String (Path.asset "number-dark.svg" |> Path.to_string)
      }

  let collapsible_state t =
    if Sandbox.Package.has_dependencies t then
      TreeItemCollapsibleState.Collapsed
    else TreeItemCollapsibleState.None

  let to_treeitem dependency =
    let open Promise.Syntax in
    let icon = `LightDark (icon dependency) in
    let collapsibleState = collapsible_state dependency in
    let label =
      `TreeItemLabel (Vscode.TreeItemLabel.create ~label:(label dependency) ())
    in
    let item = Vscode.TreeItem.make_label ~label ~collapsibleState () in
    Vscode.TreeItem.set_iconPath item icon;
    TreeItem.set_contextValue item (context_value dependency);
    let+ _ =
      Promise.Option.iter
        (fun desc -> TreeItem.set_description item (`String desc))
        (description dependency)
    in
    Option.iter (tooltip dependency) ~f:(fun desc ->
        TreeItem.set_tooltip item (`String desc));
    item

  let get_dependencies t =
    let open Promise.Syntax in
    let+ deps = Sandbox.Package.dependencies t in
    match deps with
    | Error _ -> None
    | Ok packages -> Some packages
end

module Command = struct
  let _open_documentation =
    let handler (_ : Extension_instance.t) ~args =
      let (_ : unit Promise.t) =
        let arg = List.hd_exn args in
        let dep = Dependency.t_of_js arg in
        let open Promise.Syntax in
        let doc = Sandbox.Package.documentation dep in
        match doc with
        | None -> Promise.return ()
        | Some doc ->
          let+ _ =
            Vscode.Commands.executeCommand ~command:"vscode.open"
              ~args:[ Vscode.Uri.parse doc () |> Vscode.Uri.t_to_js ]
          in
          ()
      in
      ()
    in
    Extension_commands.register
      ~id:Extension_consts.Commands.open_sandbox_documentation handler

  let _generate_documentation =
    let handler (instance : Extension_instance.t) ~args =
      let _ =
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        let+ _ =
          match sandbox with
          | Sandbox.Esy (_, _)
          | Sandbox.Global
          | Sandbox.Custom _ ->
            let message =
              "\"OCaml: Generate Documentation\" command only works with OPAM \
               sandboxes."
            in
            let+ _ = Window.showErrorMessage ~message () in
            ()
          | Sandbox.Opam (opam, switch) -> (
            let* odig = Odig.of_opam (opam, switch) in
            match odig with
            | Error e ->
              let message =
                match e with
                | Odig.Odig_not_installed ->
                  "\"OCaml: Generate Documentation\": the package \"odig\" \
                   must be installed to generate documentation."
              in
              let+ _ = Window.showErrorMessage ~message () in
              ()
            | Ok odig -> (
              let is_live_preview_extension_installed =
                Extensions.is_extension_installed "ms-vscode.live-server"
              in
              if not is_live_preview_extension_installed then
                let+ choices =
                  Window.showErrorMessage
                    ~message:
                      "Live preview extension must be installed to show the \
                       documentation."
                    ~choices:[ ("Install", `Install) ]
                    ()
                in
                match choices with
                | None -> ()
                | Some `Install ->
                  let _ =
                    Vscode.Commands.executeCommand
                      ~command:"workbench.extensions.search"
                      ~args:[ Ojs.string_to_js "ms-vscode.live-server" ]
                  in
                  ()
              else
                let arg = List.hd_exn args in
                let dep = Dependency.t_of_js arg in
                let name = Sandbox.Package.name dep in
                let options =
                  ProgressOptions.create
                    ~location:(`ProgressLocation Notification)
                    ~title:
                      (Printf.sprintf "Generating documentation for %s" name)
                    ~cancellable:false ()
                in
                let task ~progress:_ ~token:_ = Odig.odoc_exec odig name in
                let* result =
                  Vscode.Window.withProgress
                    (module Interop.Js.Result
                              (Interop.Js.String)
                              (Interop.Js.String))
                    ~options ~task
                in
                match result with
                | Error _ ->
                  let+ _ =
                    Window.showErrorMessage
                      ~message:
                        (Printf.sprintf
                           "Error while generating documentation for %s" name)
                      ()
                  in
                  ()
                | Ok _ ->
                  let* html_dir = Odig.html_dir odig in
                  let+ () =
                    match sandbox with
                    | Sandbox.Opam (_, Opam.Switch.Named _) ->
                      let start =
                        Vscode.Workspace.workspaceFolders () |> List.length
                      in
                      let workspaceFoldersToAdd :
                          Vscode.Workspace.workspaceFolderToAdd =
                        { name = "odig_doc"
                        ; uri = Vscode.Uri.file (Path.to_string html_dir)
                        }
                      in
                      let _ =
                        Vscode.Workspace.updateWorkspaceFolders ~start
                          ~deleteCount:(Some 0)
                          ~workspaceFoldersToAdd:[ workspaceFoldersToAdd ]
                      in
                      Promise.resolve ()
                    | Sandbox.Opam (_, Opam.Switch.Local _)
                    | Sandbox.Esy (_, _)
                    | Sandbox.Global
                    | Sandbox.Custom _ ->
                      Promise.resolve ()
                  in
                  let htmlDocumentationPath = Path.(html_dir / name) in
                  let (_ : Ojs.t option Promise.t) =
                    Vscode.Commands.executeCommand
                      ~command:"livePreview.start.preview.atFile"
                      ~args:
                        [ Ojs.string_to_js
                            (Path.to_string htmlDocumentationPath)
                        ; Ojs.bool_to_js false (* Path is absolute *)
                        ]
                  in
                  ()))
        in
        ()
      in
      ()
    in
    Extension_commands.register
      ~id:Extension_consts.Commands.generate_sandbox_documentation handler

  let _uninstall =
    let handler (instance : Extension_instance.t) ~args =
      let (_ : unit Promise.t) =
        let arg = List.hd_exn args in
        let dep = Dependency.t_of_js arg in
        let message =
          Printf.sprintf "Are you sure you want to uninstall package %s?"
            (Dependency.label dep)
        in
        with_confirmation message ~yes:"Uninstall package" @@ fun () ->
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        Sandbox.focus_on_package_command ~sandbox ();
        let+ () = Sandbox.uninstall_packages sandbox [ dep ] in
        let (_ : Ojs.t option Promise.t) =
          Vscode.Commands.executeCommand
            ~command:Extension_consts.Commands.refresh_switches ~args:[]
        in
        let (_ : Ojs.t option Promise.t) =
          Vscode.Commands.executeCommand
            ~command:Extension_consts.Commands.refresh_sandbox ~args:[]
        in
        ()
      in
      ()
    in
    Extension_commands.register
      ~id:Extension_consts.Commands.uninstall_sandbox_package handler

  let _upgrade =
    let handler (instance : Extension_instance.t) ~args:_ =
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        Sandbox.focus_on_package_command ~sandbox ();
        let+ () = Sandbox.upgrade_packages sandbox in
        let (_ : Ojs.t option Promise.t) =
          Vscode.Commands.executeCommand
            ~command:Extension_consts.Commands.refresh_switches ~args:[]
        in
        let (_ : Ojs.t option Promise.t) =
          Vscode.Commands.executeCommand
            ~command:Extension_consts.Commands.refresh_sandbox ~args:[]
        in
        ()
      in
      ()
    in
    Extension_commands.register ~id:Extension_consts.Commands.upgrade_sandbox
      handler

  let ask_packages () =
    let options =
      InputBoxOptions.create ~prompt:"Install Packages"
        ~placeHolder:"Type the packages names, separated with a space" ()
    in
    Window.showInputBox ~options ()

  let _install =
    let handler (instance : Extension_instance.t) ~args:_ =
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let* package_str_opt = ask_packages () in
        match package_str_opt with
        | None -> Promise.return ()
        | Some package_str ->
          let sandbox = Extension_instance.sandbox instance in
          let packages = String.split package_str ~on:' ' in
          Sandbox.focus_on_package_command ~sandbox ();
          let+ () = Sandbox.install_packages sandbox packages in
          let (_ : Ojs.t option Promise.t) =
            Vscode.Commands.executeCommand
              ~command:Extension_consts.Commands.refresh_switches ~args:[]
          in
          let (_ : Ojs.t option Promise.t) =
            Vscode.Commands.executeCommand
              ~command:Extension_consts.Commands.refresh_sandbox ~args:[]
          in
          ()
      in
      ()
    in
    Extension_commands.register ~id:Extension_consts.Commands.install_sandbox
      handler
end

let getTreeItem ~element = `Promise (Dependency.to_treeitem element)

let getChildren ~instance ?element () =
  let sandbox = Extension_instance.sandbox instance in
  match element with
  | Some element -> `Promise (Dependency.get_dependencies element)
  | None ->
    let open Promise.Syntax in
    let items =
      let+ packages = Sandbox.root_packages sandbox in
      match packages with
      | Ok packages -> Some packages
      | Error _ -> None
    in
    `Promise items

let register extension instance =
  let getChildren = getChildren ~instance in
  let module EventEmitter =
    Vscode.EventEmitter.Make (Interop.Js.Or_undefined (Dependency)) in
  let event_emitter = EventEmitter.make () in
  let event = EventEmitter.event event_emitter in
  let module TreeDataProvider = Vscode.TreeDataProvider.Make (Dependency) in
  let treeDataProvider =
    TreeDataProvider.create ~getTreeItem ~getChildren ~onDidChangeTreeData:event
      ()
  in
  let disposable =
    Vscode.Window.registerTreeDataProvider
      (module Dependency)
      ~viewId:"ocaml-sandbox" ~treeDataProvider
  in
  ExtensionContext.subscribe extension ~disposable;

  let disposable =
    Commands.registerCommand ~command:Extension_consts.Commands.refresh_sandbox
      ~callback:(fun ~args:_ -> EventEmitter.fire event_emitter None)
  in
  ExtensionContext.subscribe extension ~disposable
