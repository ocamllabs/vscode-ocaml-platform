open Import

module Dependency = struct
  type t =
    | Package : Opam.Package.t -> t
    | Switch : Opam.t * Opam.Switch.t -> t

  let t_of_js : Ojs.t -> t = Obj.magic

  let t_to_js : t -> Ojs.t = Obj.magic

  let label = function
    | Switch (_, Named name) -> name
    | Switch (_, Local path) ->
      let name = Path.to_string path in
      name
    | Package dep -> Opam.Package.name dep

  let description = function
    | Switch (opam, switch) -> Opam.switch_compiler opam switch
    | Package dep -> Promise.return (Some (Opam.Package.version dep))

  let tooltip = function
    | Switch (_, Named _) -> None
    | Switch (_, Local _) -> None
    | Package dep -> Opam.Package.synopsis dep

  let context_value = function
    | Switch _ -> "opam-switch"
    | Package dep -> (
      match Opam.Package.documentation dep with
      | Some _ -> "package-with-doc"
      | None -> "package" )

  let icon = function
    | Switch _ ->
      TreeItem.LightDarkIcon.
        { light = `String (Path.asset "dependency-light.svg" |> Path.to_string)
        ; dark = `String (Path.asset "dependency-dark.svg" |> Path.to_string)
        }
    | Package _ ->
      TreeItem.LightDarkIcon.
        { light = `String (Path.asset "number-light.svg" |> Path.to_string)
        ; dark = `String (Path.asset "number-dark.svg" |> Path.to_string)
        }

  let collapsible_state = function
    | Switch _ -> Vscode.TreeItemCollapsibleState.Collapsed
    | Package dep ->
      if Opam.Package.has_dependencies dep then
        TreeItemCollapsibleState.Collapsed
      else
        TreeItemCollapsibleState.None

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

  let get_dependencies =
    let open Promise.Syntax in
    function
    | Switch (opam, switch) -> (
      let* packages = Opam.root_packages opam switch in
      match packages with
      | Ok packages ->
        let names = packages |> List.map ~f:(fun n -> Package n) in
        Promise.return (Some names)
      | Error err ->
        show_message `Info
          "An error occured while reading the switch dependencies: %s" err;
        Promise.return None )
    | Package pkg -> (
      let+ deps = Opam.Package.dependencies pkg in
      match deps with
      | Error _ -> None
      | Ok packages -> Some (List.map ~f:(fun x -> Package x) packages) )
end

module Command = struct
  let _remove_switch =
    let handler (_ : Extension_instance.t) ~args =
      let (_ : unit Promise.t) =
        let arg = List.hd_exn args in
        let dep = Dependency.t_of_js arg in
        match dep with
        | Package _ ->
          Promise.return
          @@ show_message `Warn "The selected item is not an opam switch."
        | Switch (opam, switch) -> (
          let message =
            Printf.sprintf "Are you sure you want to remove switch %s?"
              (Dependency.label dep)
          in
          with_confirmation message ~yes:"Remove switch" @@ fun () ->
          let open Promise.Syntax in
          Sandbox.focus_on_package_command ();
          let+ result = Opam.switch_remove opam switch |> Cmd.output in
          match result with
          | Error err -> show_message `Error "%s" err
          | Ok _ ->
            let (_ : Ojs.t option Promise.t) =
              Vscode.Commands.executeCommand
                ~command:Extension_consts.Commands.refresh_switches ~args:[]
            in
            let (_ : Ojs.t option Promise.t) =
              Vscode.Commands.executeCommand
                ~command:Extension_consts.Commands.refresh_sandbox ~args:[]
            in
            show_message `Info "The switch has been removed successfully." )
      in
      ()
    in
    Extension_commands.register ~id:Extension_consts.Commands.remove_switch
      handler

  let _open_documentation =
    let handler (_ : Extension_instance.t) ~args =
      let (_ : unit Promise.t) =
        let arg = List.hd_exn args in
        let dep = Dependency.t_of_js arg in
        match dep with
        | Switch _ ->
          Promise.return
          @@ show_message `Warn "Cannot open documentation of a switch."
        | Package pkg -> (
          let open Promise.Syntax in
          let doc = Opam.Package.documentation pkg in
          match doc with
          | None -> Promise.return ()
          | Some doc ->
            let+ _ =
              Vscode.Commands.executeCommand ~command:"vscode.open"
                ~args:[ Vscode.Uri.parse doc () |> Vscode.Uri.t_to_js ]
            in
            () )
      in
      ()
    in
    Extension_commands.register
      ~id:Extension_consts.Commands.open_switches_documentation handler
end

let getTreeItem ~element = `Promise (Dependency.to_treeitem element)

let getChildren ?opam ?element () =
  match (opam, element) with
  | None, _ -> `Value None
  | Some _, Some element -> `Promise (Dependency.get_dependencies element)
  | Some opam, None ->
    let open Promise.Syntax in
    let items =
      let+ switches = Opam.switch_list opam in
      let items =
        List.map ~f:(fun switch -> Dependency.Switch (opam, switch)) switches
      in
      Some items
    in
    `Promise items

let register extension =
  let (_ : unit Promise.t) =
    let open Promise.Syntax in
    let+ opam = Opam.make () in
    let getChildren = getChildren ?opam in
    let module EventEmitter =
      Vscode.EventEmitter.Make (Interop.Js.Or_undefined (Dependency)) in
    let event_emitter = EventEmitter.make () in
    let event = EventEmitter.event event_emitter in
    let module TreeDataProvider = Vscode.TreeDataProvider.Make (Dependency) in
    let treeDataProvider =
      TreeDataProvider.create ~getTreeItem ~getChildren
        ~onDidChangeTreeData:event ()
    in

    let disposable =
      Vscode.Window.registerTreeDataProvider
        (module Dependency)
        ~viewId:"ocaml-switches" ~treeDataProvider
    in
    ExtensionContext.subscribe extension ~disposable;

    let disposable =
      Commands.registerCommand
        ~command:Extension_consts.Commands.refresh_switches
        ~callback:(fun ~args:_ -> EventEmitter.fire event_emitter None)
    in
    ExtensionContext.subscribe extension ~disposable
  in
  ()
