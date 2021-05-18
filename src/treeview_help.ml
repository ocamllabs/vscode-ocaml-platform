open Import

let discord_item =
  let icon =
    `IconPath
      Icon_path.
        { light = `String (asset "discord-light.svg" |> Path.to_string)
        ; dark = `String (asset "discord-dark.svg" |> Path.to_string)
        }
  in
  let label =
    `TreeItemLabel (Tree_item_label.create ~label:"Chat on Discord" ())
  in
  let item = Tree_item.create ~label () in
  let command =
    Command.create ~title:"Open" ~command:"vscode.open"
      ~arguments:[ Uri.parse "https://discord.gg/cCYQbqN" () |> Uri.t_to_js ]
      ()
  in
  Tree_item.set_icon_path item icon;
  Tree_item.set_command item command;
  item

let discuss_item =
  let icon =
    `IconPath
      Icon_path.
        { light = `String (asset "chat-light.svg" |> Path.to_string)
        ; dark = `String (asset "chat-dark.svg" |> Path.to_string)
        }
  in
  let label =
    `TreeItemLabel
      (Tree_item_label.create ~label:"Ask a question on Discuss" ())
  in
  let item = Tree_item.create ~label () in
  let command =
    Command.create ~title:"Open" ~command:"vscode.open"
      ~arguments:[ Uri.parse "https://discuss.ocaml.org/" () |> Uri.t_to_js ]
      ()
  in
  Tree_item.set_icon_path item icon;
  Tree_item.set_command item command;
  item

let github_item =
  let icon =
    `IconPath
      Icon_path.
        { light = `String (asset "github-light.svg" |> Path.to_string)
        ; dark = `String (asset "github-dark.svg" |> Path.to_string)
        }
  in
  let label =
    `TreeItemLabel (Tree_item_label.create ~label:"Open an issue on Github" ())
  in
  let item = Tree_item.create ~label () in
  let command =
    Command.create ~title:"Open" ~command:"vscode.open"
      ~arguments:
        [ Uri.parse "https://github.com/ocamllabs/vscode-ocaml-platform" ()
          |> Uri.t_to_js
        ]
      ()
  in
  Tree_item.set_icon_path item icon;
  Tree_item.set_command item command;
  item

let items = [ discord_item; discuss_item; github_item ]

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
    Window.register_tree_data_provider "ocaml-help" tree_data_provider
  in
  Extension_context.subscribe extension disposable
