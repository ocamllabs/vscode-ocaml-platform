let select_sandbox_item ~extension_path =
  let icon =
    `LightDark
      Vscode.TreeItem.LightDarkIcon.
        { light = `String (extension_path ^ "/assets/collection-light.svg")
        ; dark = `String (extension_path ^ "/assets/collection-dark.svg")
        }
  in
  let label = Vscode.TreeItemLabel.create ~label:"Select a Sandbox" () in
  let item = Vscode.TreeItem.make ~label () in
  let command =
    Vscode.Command.create ~title:"Select a Sandbox"
      ~command:"ocaml.select-sandbox" ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let terminal_item ~extension_path =
  let icon =
    `LightDark
      Vscode.TreeItem.LightDarkIcon.
        { light = `String (extension_path ^ "/assets/terminal-light.svg")
        ; dark = `String (extension_path ^ "/assets/terminal-dark.svg")
        }
  in
  let label =
    Vscode.TreeItemLabel.create ~label:"Open a sandboxed terminal" ()
  in
  let item = Vscode.TreeItem.make ~label () in
  let command =
    Vscode.Command.create ~title:"Open a sandboxed terminal"
      ~command:"ocaml.open-terminal" ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let items ~extension_path =
  [ select_sandbox_item ~extension_path; terminal_item ~extension_path ]

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
    Vscode.Window.registerTreeDataProvider ~viewId:"ocaml-commands"
      ~treeDataProvider
  in
  Promise.return ()
