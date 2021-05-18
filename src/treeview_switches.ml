open Import

module Dependency = struct
  type t =
    | Package : Opam.Package.t -> t
    | Switch : Opam.t * Opam.Switch.t -> t

  let t_of_js : Ojs.t -> t = Stdlib.Obj.magic

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
      | None -> "package")

  let icon = function
    | Switch _ ->
      Icon_path.
        { light = `String (asset "dependency-light.svg" |> Path.to_string)
        ; dark = `String (asset "dependency-dark.svg" |> Path.to_string)
        }
    | Package _ ->
      Icon_path.
        { light = `String (asset "number-light.svg" |> Path.to_string)
        ; dark = `String (asset "number-dark.svg" |> Path.to_string)
        }

  let collapsible_state = function
    | Switch _ -> `Collapsed
    | Package dep ->
      if Opam.Package.has_dependencies dep then
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
        Promise.return None)
    | Package pkg -> (
      let+ deps = Opam.Package.dependencies pkg in
      match deps with
      | Error _ -> None
      | Ok packages -> Some (List.map ~f:(fun x -> Package x) packages))
end

module Command = struct
  let _remove_switch =
    let handler (_ : Extension_instance.t) args =
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
              Commands.execute_command
                Extension_consts.Commands.refresh_switches []
            in
            let (_ : Ojs.t option Promise.t) =
              Commands.execute_command Extension_consts.Commands.refresh_sandbox
                []
            in
            show_message `Info "The switch has been removed successfully.")
      in
      ()
    in
    Extension_commands.register ~id:Extension_consts.Commands.remove_switch
      handler

  let _open_documentation =
    let handler (_ : Extension_instance.t) args =
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
              Commands.execute_command "vscode.open"
                [ Uri.parse doc () |> Uri.t_to_js ]
            in
            ())
      in
      ()
    in
    Extension_commands.register
      ~id:Extension_consts.Commands.open_switches_documentation handler
end

let get_tree_item element = `Promise (Dependency.to_treeitem element)

let get_children ?opam ?element () =
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
    let get_children = get_children ?opam in
    let (event_emitter : Dependency.t option Event_emitter.t) =
      Event_emitter.create ()
    in
    let event = Event_emitter.event event_emitter in
    let tree_data_provider =
      Tree_data_provider.create ~get_tree_item ~get_children
        ~on_did_change_tree_data:event ()
    in

    let disposable =
      Window.register_tree_data_provider "ocaml-switches" tree_data_provider
    in
    Extension_context.subscribe extension disposable;

    let disposable =
      Commands.register_command Extension_consts.Commands.refresh_switches
        (fun _args -> Event_emitter.fire event_emitter None)
    in
    Extension_context.subscribe extension disposable
  in
  ()
