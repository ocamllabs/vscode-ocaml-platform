let tutorial_item ~extension_path =
  let icon =
    `LightDark
      Vscode.TreeItem.LightDarkIcon.
        { light = `String (extension_path ^ "/assets/book-open-light.svg")
        ; dark = `String (extension_path ^ "/assets/book-open-dark.svg")
        }
  in
  let label =
    Vscode.TreeItemLabel.create ~label:"Get Started with OCaml Tutorials" ()
  in
  let item = Vscode.TreeItem.make ~label () in
  let command =
    Vscode.Command.create ~title:"Open" ~command:"vscode.open"
      ~arguments:
        [ Vscode.Uri.parse "https://ocaml.org/learn/tutorials/" ()
          |> Vscode.Uri.t_to_js
        ]
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let discord_item ~extension_path =
  let icon =
    `LightDark
      Vscode.TreeItem.LightDarkIcon.
        { light = `String (extension_path ^ "/assets/discord-light.svg")
        ; dark = `String (extension_path ^ "/assets/discord-dark.svg")
        }
  in
  let label = Vscode.TreeItemLabel.create ~label:"Chat on Discord" () in
  let item = Vscode.TreeItem.make ~label () in
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
    Vscode.TreeItemLabel.create ~label:"Ask a question on Discuss" ()
  in
  let item = Vscode.TreeItem.make ~label () in
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
  let label = Vscode.TreeItemLabel.create ~label:"Open an issue on Github" () in
  let item = Vscode.TreeItem.make ~label () in
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
  [ tutorial_item ~extension_path
  ; discord_item ~extension_path
  ; discuss_item ~extension_path
  ; github_item ~extension_path
  ]

let getTreeItem ~extension_path:_ ~element = Promise.return element

let getChildren ~extension_path ~element =
  match element with
  | None -> `Promise (Promise.return (Some (items ~extension_path)))
  | Some _ -> `Promise (Promise.return (Some []))

let register extension =
  let extension_path = Vscode.ExtensionContext.extensionPath extension in
  let treeDataProvider =
    Vscode.TreeDataProvider.create
      ~getTreeItem:(getTreeItem ~extension_path)
      ~getChildren:(getChildren ~extension_path)
      ()
  in
  let _ =
    Vscode.Window.registerTreeDataProvider ~viewId:"ocaml-help"
      ~treeDataProvider
  in
  Promise.return ()
