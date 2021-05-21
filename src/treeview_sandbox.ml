open Import

module Dependency = struct
  type t = Sandbox.Package.t

  let t_of_js : Ojs.t -> t = Stdlib.Obj.magic

  let label t = Sandbox.Package.name t

  let description t = Promise.return (Some (Sandbox.Package.version t))

  let tooltip t = Sandbox.Package.synopsis t

  let context_value t =
    match Sandbox.Package.documentation t with
    | Some _ -> "package-with-doc"
    | None -> "package"

  let icon _ =
    Icon_path.
      { light = `String (asset "number-light.svg" |> Path.to_string)
      ; dark = `String (asset "number-dark.svg" |> Path.to_string)
      }

  let collapsible_state t =
    if Sandbox.Package.has_dependencies t then
      `Collapsed
    else
      `None

  let to_treeitem dependency =
    let open Promise.Syntax in
    let icon = `IconPath (icon dependency) in
    let collapsible_state = collapsible_state dependency in
    let label =
      `TreeItemLabel (Tree_item_label.create ~label:(label dependency) ())
    in
    let item = Tree_item.create ~label ~collapsible_state () in
    Tree_item.set_icon_path item icon;
    Tree_item.set_context_value item (context_value dependency);
    let+ _ =
      Promise.Option.iter
        (fun desc -> Tree_item.set_description item (`String desc))
        (description dependency)
    in
    Option.iter (tooltip dependency) ~f:(fun desc ->
        Tree_item.set_tooltip item (`String desc));
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
    let handler (_ : Extension_instance.t) args =
      let (_ : unit Promise.t) =
        let arg = List.hd_exn args in
        let dep = Dependency.t_of_js arg in
        let open Promise.Syntax in
        let doc = Sandbox.Package.documentation dep in
        match doc with
        | None -> Promise.return ()
        | Some doc ->
          let+ _ =
            Commands.execute_command "vscode.open"
              [ Uri.parse doc () |> Uri.t_to_js ]
          in
          ()
      in
      ()
    in
    Extension_commands.register
      ~id:Extension_consts.Commands.open_sandbox_documentation handler

  let _uninstall =
    let handler (instance : Extension_instance.t) args =
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
          Commands.execute_command Extension_consts.Commands.refresh_switches []
        in
        let (_ : Ojs.t option Promise.t) =
          Commands.execute_command Extension_consts.Commands.refresh_sandbox []
        in
        ()
      in
      ()
    in
    Extension_commands.register
      ~id:Extension_consts.Commands.uninstall_sandbox_package handler

  let _upgrade =
    let handler (instance : Extension_instance.t) _args =
      let (_ : unit Promise.t) =
        let open Promise.Syntax in
        let sandbox = Extension_instance.sandbox instance in
        Sandbox.focus_on_package_command ~sandbox ();
        let+ () = Sandbox.upgrade_packages sandbox in
        let (_ : Ojs.t option Promise.t) =
          Commands.execute_command Extension_consts.Commands.refresh_switches []
        in
        let (_ : Ojs.t option Promise.t) =
          Commands.execute_command Extension_consts.Commands.refresh_sandbox []
        in
        ()
      in
      ()
    in
    Extension_commands.register ~id:Extension_consts.Commands.upgrade_sandbox
      handler

  let ask_packages () =
    let options =
      Input_box_options.create ~prompt:"Install Packages"
        ~place_holder:"Type the packages names, separated with a space" ()
    in
    Window.show_input_box ~options ()

  let _install =
    let handler (instance : Extension_instance.t) _args =
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
            Commands.execute_command Extension_consts.Commands.refresh_switches
              []
          in
          let (_ : Ojs.t option Promise.t) =
            Commands.execute_command Extension_consts.Commands.refresh_sandbox
              []
          in
          ()
      in
      ()
    in
    Extension_commands.register ~id:Extension_consts.Commands.install_sandbox
      handler
end

let get_tree_item element = `Promise (Dependency.to_treeitem element)

let get_children ~instance ?element () =
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
  let get_children = get_children ~instance in
  let (event_emitter : Dependency.t option Event_emitter.t) =
    Event_emitter.create ()
  in
  let event = Event_emitter.event event_emitter in
  let tree_data_provider =
    Tree_data_provider.create ~get_tree_item ~get_children
      ~on_did_change_tree_data:event ()
  in
  let disposable =
    Window.register_tree_data_provider "ocaml-sandbox" tree_data_provider
  in
  Extension_context.subscribe extension disposable;

  let disposable =
    Commands.register_command Extension_consts.Commands.refresh_sandbox
      (fun _ -> Event_emitter.fire event_emitter None)
  in
  Extension_context.subscribe extension disposable
