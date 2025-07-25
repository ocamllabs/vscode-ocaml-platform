open Import

module Dependency = struct
  type t = Sandbox.Package.t

  let t_of_js : Ojs.t -> t = Stdlib.Obj.magic
  let t_to_js : t -> Ojs.t = Stdlib.Obj.magic
  let label t = Sandbox.Package.name t
  let description t = Promise.return (Some (Sandbox.Package.version t))
  let tooltip t = Sandbox.Package.synopsis t

  let icon _ =
    LightDarkIcon.
      { light = `String (Path.asset "number-light.svg" |> Path.to_string)
      ; dark = `String (Path.asset "number-dark.svg" |> Path.to_string)
      }
  ;;

  let collapsible_state t =
    if Sandbox.Package.has_dependencies t
    then TreeItemCollapsibleState.Collapsed
    else TreeItemCollapsibleState.None
  ;;

  let to_treeitem dependency =
    let open Promise.Syntax in
    let icon = `LightDark (icon dependency) in
    let collapsibleState = collapsible_state dependency in
    let label =
      `TreeItemLabel (Vscode.TreeItemLabel.create ~label:(label dependency) ())
    in
    let item = Vscode.TreeItem.make_label ~label ~collapsibleState () in
    Vscode.TreeItem.set_iconPath item icon;
    TreeItem.set_contextValue item "opam-package";
    let+ _ =
      Promise.Option.iter
        (fun desc -> TreeItem.set_description item (`String desc))
        (description dependency)
    in
    Option.iter (tooltip dependency) ~f:(fun desc ->
      TreeItem.set_tooltip item (`String desc));
    item
  ;;

  let get_dependencies t =
    let open Promise.Syntax in
    let+ deps = Sandbox.Package.dependencies t in
    match deps with
    | Error _ -> None
    | Ok packages -> Some packages
  ;;
end

module Command = struct
  let _open_documentation =
    let callback (_ : Extension_instance.t) arg =
      let (_ : unit Promise.t) =
        let dep = [%js.to: Dependency.t] arg in
        let open Promise.Syntax in
        let doc = Sandbox.Package.documentation dep in
        let uri =
          match doc with
          | None ->
            let name = Sandbox.Package.name dep in
            let version = Sandbox.Package.version dep in
            Vscode.Uri.parse
              (Printf.sprintf "https://ocaml.org/p/%s/%s/doc/index.html" name version)
              ()
          | Some doc -> Vscode.Uri.parse doc ()
        in
        let+ _ = Command_api.(execute Vscode.open_) uri in
        ()
      in
      ()
    in
    Extension_commands.register Command_api.Internal.open_sandbox_documentation callback
  ;;

  let _generate_documentation =
    let callback (instance : Extension_instance.t) arg =
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        let* odig = Odig.of_sandbox sandbox in
        match odig with
        | Error error ->
          show_message `Error "%s" error;
          Promise.resolve ()
        | Ok odig ->
          let dep = [%js.to: Dependency.t] arg in
          let package_name = Sandbox.Package.name dep in
          let options =
            ProgressOptions.create
              ~location:(`ProgressLocation Notification)
              ~title:(Printf.sprintf "Generating documentation for %s" package_name)
              ~cancellable:false
              ()
          in
          let task ~progress:_ ~token:_ = Odig.odoc_exec odig ~sandbox ~package_name in
          let* result =
            Vscode.Window.withProgress
              (module Interop.Js.Result (Interop.Js.Unit) (Ojs.String))
              ~options
              ~task
          in
          (match result with
           | Error _ ->
             show_message
               `Error
               "Documentation could not be generated for %s. It might be because this \
                package has no documentation."
               package_name;
             Promise.resolve ()
           | Ok _ ->
             let+ server =
               let html_dir = Odig.html_dir odig in
               Extension_instance.start_documentation_server instance ~path:html_dir
             in
             (match server with
              | Error () -> ()
              | Ok server ->
                let (_ : unit Promise.t) =
                  let port = Documentation_server.port server in
                  let host = Documentation_server.host server in
                  Command_api.(execute Vscode.show_simple_browser)
                    (Printf.sprintf "http://%s:%i/%s/index.html" host port package_name)
                in
                ()))
      in
      ()
    in
    Extension_commands.register
      Command_api.Internal.generate_sandbox_documentation
      callback
  ;;

  let _uninstall =
    let callback (instance : Extension_instance.t) arg =
      let (_ : unit Promise.t) =
        let dep = [%js.to: Dependency.t] arg in
        let message =
          Printf.sprintf
            "Are you sure you want to uninstall package %s?"
            (Dependency.label dep)
        in
        with_confirmation message ~yes:"Uninstall package"
        @@ fun () ->
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        Sandbox.focus_on_package_command ~sandbox ();
        let+ () = Sandbox.uninstall_packages sandbox [ dep ] in
        let (_ : unit Promise.t) = Command_api.(execute Internal.refresh_switches) () in
        let (_ : unit Promise.t) = Command_api.(execute Internal.refresh_sandbox) () in
        ()
      in
      ()
    in
    Extension_commands.register Command_api.Internal.uninstall_sandbox_package callback
  ;;

  let _upgrade =
    let callback (instance : Extension_instance.t) () =
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        Sandbox.focus_on_package_command ~sandbox ();
        let+ () = Sandbox.upgrade_packages sandbox in
        let (_ : unit Promise.t) = Command_api.(execute Internal.refresh_switches) () in
        let (_ : unit Promise.t) = Command_api.(execute Internal.refresh_sandbox) () in
        ()
      in
      ()
    in
    Extension_commands.register Command_api.Internal.upgrade_sandbox callback
  ;;

  let ask_packages () =
    let options =
      InputBoxOptions.create
        ~prompt:"Install Packages"
        ~placeHolder:"Type the packages names, separated with a space"
        ()
    in
    Window.showInputBox ~options ()
  ;;

  let _install =
    let callback (instance : Extension_instance.t) () =
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
          let (_ : unit Promise.t) = Command_api.(execute Internal.refresh_switches) () in
          let (_ : unit Promise.t) = Command_api.(execute Internal.refresh_sandbox) () in
          ()
      in
      ()
    in
    Extension_commands.register Command_api.Internal.install_sandbox callback
  ;;
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
;;

let register extension instance =
  let getChildren = getChildren ~instance in
  let module EventEmitter = Vscode.EventEmitter.Make (Interop.Js.Or_undefined (Dependency))
  in
  let event_emitter = EventEmitter.make () in
  let event = EventEmitter.event event_emitter in
  let module TreeDataProvider = Vscode.TreeDataProvider.Make (Dependency) in
  let treeDataProvider =
    TreeDataProvider.create ~getTreeItem ~getChildren ~onDidChangeTreeData:event ()
  in
  let disposable =
    Vscode.Window.registerTreeDataProvider
      (module Dependency)
      ~viewId:"ocaml-sandbox"
      ~treeDataProvider
  in
  ExtensionContext.subscribe extension ~disposable;
  Extension_commands.register Command_api.Internal.refresh_sandbox
  @@ fun (_ : Extension_instance.t) () -> EventEmitter.fire event_emitter None
;;
