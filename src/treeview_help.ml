let discord_item extension =
  let icon =
    `LightDark
      (Extension_assets.light_dark_icon
         ~extension
         ~light:"discord-light.svg"
         ~dark:"discord-dark.svg")
  in
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

let discuss_item extension =
  let icon =
    `LightDark
      (Extension_assets.light_dark_icon
         ~extension
         ~light:"chat-light.svg"
         ~dark:"chat-dark.svg")
  in
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

let tutorials_item () =
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

let github_item extension =
  let icon =
    `LightDark
      (Extension_assets.light_dark_icon
         ~extension
         ~light:"github-light.svg"
         ~dark:"github-dark.svg")
  in
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

let items extension =
  [ discord_item extension
  ; discuss_item extension
  ; github_item extension
  ; tutorials_item ()
  ]
;;

let getTreeItem ~element = `Value element

let getChildren items ?element () =
  match element with
  | None -> `Value (Some items)
  | Some _ -> `Value (Some [])
;;

let register extension =
  let items = items extension in
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
