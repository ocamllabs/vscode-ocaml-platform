let discord_item assets =
  let icon = `LightDark (Extension_assets.discord_icon assets) in
  let label = `TreeItemLabel (Vscode.TreeItemLabel.create ~label:"Chat on Discord" ()) in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create
      ~title:"Open"
      ~command:"vscode.open"
      ~arguments:
        [ [%js.of: Vscode.Uri.t] @@ Vscode.Uri.parse "https://discord.gg/cCYQbqN" () ]
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item
;;

let discuss_item assets =
  let icon = `LightDark (Extension_assets.chat_icon assets) in
  let label =
    `TreeItemLabel (Vscode.TreeItemLabel.create ~label:"Ask a question on Discuss" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create
      ~title:"Open"
      ~command:"vscode.open"
      ~arguments:
        [ [%js.of: Vscode.Uri.t] @@ Vscode.Uri.parse "https://discuss.ocaml.org/" () ]
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item
;;

let tutorials_item =
  let label =
    `TreeItemLabel
      (Vscode.TreeItemLabel.create ~label:"Explore OCaml exercises and tutorials" ())
  in
  let icon = `ThemeIcon (Vscode.ThemeIcon.make ~id:"book" ()) in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create
      ~title:"Open"
      ~command:"vscode.open"
      ~arguments:
        [ Vscode.Uri.parse "https://ocaml.org/exercises" () |> Vscode.Uri.t_to_js ]
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item
;;

let github_item assets =
  let icon = `LightDark (Extension_assets.github_icon assets) in
  let label =
    `TreeItemLabel (Vscode.TreeItemLabel.create ~label:"Open an issue on Github" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create
      ~title:"Open"
      ~command:"vscode.open"
      ~arguments:
        [ [%js.of: Vscode.Uri.t]
          @@ Vscode.Uri.parse "https://github.com/ocamllabs/vscode-ocaml-platform" ()
        ]
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item
;;

let items assets =
  [ discord_item assets; discuss_item assets; github_item assets; tutorials_item ]
;;

let getTreeItem ~element = `Value element

let getChildren items ?element () =
  match element with
  | None -> `Value (Some items)
  | Some _ -> `Value (Some [])
;;

let register extension ~assets =
  let items = items assets in
  let getChildren = getChildren items in
  let module TreeDataProvider = Vscode.TreeDataProvider.Make (Vscode.TreeItem) in
  let treeDataProvider = TreeDataProvider.create ~getTreeItem ~getChildren () in
  let disposable =
    Vscode.Window.registerTreeDataProvider
      (module Vscode.TreeItem)
      ~viewId:"ocaml-help"
      ~treeDataProvider
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
;;
