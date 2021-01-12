let discord_item ~extension_path =
  let icon =
    `LightDark
      Vscode.TreeItem.LightDarkIcon.
        { light = `String (extension_path ^ "/assets/discord-light.svg")
        ; dark = `String (extension_path ^ "/assets/discord-dark.svg")
        }
  in
  let label =
    `TreeItemLabel (Vscode.TreeItemLabel.create ~label:"Chat on Discord" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create ~title:"Open" ~command:"vscode.open"
      ~arguments:
        [ Vscode.Uri.parse "https://discord.gg/cCYQbqN" () |> Vscode.Uri.t_to_js
        ]
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let discuss_item ~extension_path =
  let icon =
    `LightDark
      Vscode.TreeItem.LightDarkIcon.
        { light = `String (extension_path ^ "/assets/chat-light.svg")
        ; dark = `String (extension_path ^ "/assets/chat-dark.svg")
        }
  in
  let label =
    `TreeItemLabel
      (Vscode.TreeItemLabel.create ~label:"Ask a question on Discuss" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create ~title:"Open" ~command:"vscode.open"
      ~arguments:
        [ Vscode.Uri.parse "https://discuss.ocaml.org/" () |> Vscode.Uri.t_to_js
        ]
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let github_item ~extension_path =
  let icon =
    `LightDark
      Vscode.TreeItem.LightDarkIcon.
        { light = `String (extension_path ^ "/assets/github-light.svg")
        ; dark = `String (extension_path ^ "/assets/github-dark.svg")
        }
  in
  let label =
    `TreeItemLabel
      (Vscode.TreeItemLabel.create ~label:"Open an issue on Github" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create ~title:"Open" ~command:"vscode.open"
      ~arguments:
        [ Vscode.Uri.parse "https://github.com/ocamllabs/vscode-ocaml-platform"
            ()
          |> Vscode.Uri.t_to_js
        ]
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let items ~extension_path =
  [ discord_item ~extension_path
  ; discuss_item ~extension_path
  ; github_item ~extension_path
  ]

let getTreeItem ~extension_path:_ ~element = `Value element

let getChildren ~extension_path ?element () =
  match element with
  | None -> `Value (Some (items ~extension_path))
  | Some _ -> `Value (Some [])

let register extension =
  let extension_path = Vscode.ExtensionContext.extensionPath extension in
  let module TreeDataProvider = Vscode.TreeDataProvider.Make (Vscode.TreeItem) in
  let treeDataProvider =
    TreeDataProvider.create
      ~getTreeItem:(getTreeItem ~extension_path)
      ~getChildren:(getChildren ~extension_path)
      ()
  in
  let disposable =
    Vscode.Window.registerTreeDataProvider
      (module Vscode.TreeItem)
      ~viewId:"ocaml-help" ~treeDataProvider
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
