let discord_item =
  let icon =
    `LightDark
      Vscode.LightDarkIcon.
        { light = `String (Path.asset "discord-light.svg" |> Path.to_string)
        ; dark = `String (Path.asset "discord-dark.svg" |> Path.to_string)
        }
  in
  let label =
    `TreeItemLabel (Vscode.TreeItemLabel.create ~label:"Chat on Discord" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create
      ~title:"Open"
      ~command:"vscode.open"
      ~arguments:
        [ Vscode.Uri.parse "https://discord.gg/cCYQbqN" () |> Vscode.Uri.t_to_js
        ]
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let discuss_item =
  let icon =
    `LightDark
      Vscode.LightDarkIcon.
        { light = `String (Path.asset "chat-light.svg" |> Path.to_string)
        ; dark = `String (Path.asset "chat-dark.svg" |> Path.to_string)
        }
  in
  let label =
    `TreeItemLabel
      (Vscode.TreeItemLabel.create ~label:"Ask a question on Discuss" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create
      ~title:"Open"
      ~command:"vscode.open"
      ~arguments:
        [ Vscode.Uri.parse "https://discuss.ocaml.org/" () |> Vscode.Uri.t_to_js
        ]
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let github_item =
  let icon =
    `LightDark
      Vscode.LightDarkIcon.
        { light = `String (Path.asset "github-light.svg" |> Path.to_string)
        ; dark = `String (Path.asset "github-dark.svg" |> Path.to_string)
        }
  in
  let label =
    `TreeItemLabel
      (Vscode.TreeItemLabel.create ~label:"Open an issue on Github" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create
      ~title:"Open"
      ~command:"vscode.open"
      ~arguments:
        [ Vscode.Uri.parse
            "https://github.com/ocamllabs/vscode-ocaml-platform"
            ()
          |> Vscode.Uri.t_to_js
        ]
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let items = [ discord_item; discuss_item; github_item ]

let getTreeItem ~element = `Value element

let getChildren ?element () =
  match element with
  | None -> `Value (Some items)
  | Some _ -> `Value (Some [])

let register extension =
  let module TreeDataProvider = Vscode.TreeDataProvider.Make (Vscode.TreeItem) in
  let treeDataProvider = TreeDataProvider.create ~getTreeItem ~getChildren () in
  let disposable =
    Vscode.Window.registerTreeDataProvider
      (module Vscode.TreeItem)
      ~viewId:"ocaml-help"
      ~treeDataProvider
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
