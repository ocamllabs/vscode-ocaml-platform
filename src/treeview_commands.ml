open Import

let select_sandbox_item =
  let icon =
    `IconPath
      Icon_path.
        { light = `String (asset "collection-light.svg" |> Path.to_string)
        ; dark = `String (asset "collection-dark.svg" |> Path.to_string)
        }
  in
  let label =
    `TreeItemLabel (Tree_item_label.create ~label:"Select a Sandbox" ())
  in
  let item = Tree_item.create ~label () in
  let command =
    Command.create ~title:"Select a Sandbox" ~command:"ocaml.select-sandbox" ()
  in
  Tree_item.set_icon_path item icon;
  Tree_item.set_command item command;
  item

let terminal_item =
  let icon =
    `IconPath
      Icon_path.
        { light = `String (asset "terminal-light.svg" |> Path.to_string)
        ; dark = `String (asset "terminal-dark.svg" |> Path.to_string)
        }
  in
  let label =
    `TreeItemLabel
      (Tree_item_label.create ~label:"Open a sandboxed terminal" ())
  in
  let item = Tree_item.create ~label () in
  let command =
    Command.create ~title:"Open a sandboxed terminal"
      ~command:"ocaml.open-terminal" ()
  in
  Tree_item.set_icon_path item icon;
  Tree_item.set_command item command;
  item

let items = [ select_sandbox_item; terminal_item ]

let get_tree_item element = `Value element

let get_children ?element () =
  match element with
  | None -> `Value (Some items)
  | Some _ -> `Value (Some [])

let register extension =
  let tree_data_provider =
    Tree_data_provider.create ~get_tree_item ~get_children ()
  in
  let disposable =
    Window.register_tree_data_provider "ocaml-commands" tree_data_provider
  in
  Extension_context.subscribe extension disposable
