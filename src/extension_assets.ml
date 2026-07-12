open Import

let uri ~extension ~name =
  Uri.joinPath (ExtensionContext.extensionUri extension) ~pathSegments:[ "assets"; name ]
;;

let light_dark_icon ~extension ~light ~dark =
  LightDarkIcon.
    { light = `Uri (uri ~extension ~name:light); dark = `Uri (uri ~extension ~name:dark) }
;;

let chat_icon ~extension =
  light_dark_icon ~extension ~light:"chat-light.svg" ~dark:"chat-dark.svg"
;;

let collection_icon ~extension =
  light_dark_icon ~extension ~light:"collection-light.svg" ~dark:"collection-dark.svg"
;;

let dependency_icon ~extension ~selected =
  let suffix = if selected then "-selected" else "" in
  light_dark_icon
    ~extension
    ~light:("dependency-light" ^ suffix ^ ".svg")
    ~dark:("dependency-dark" ^ suffix ^ ".svg")
;;

let discord_icon ~extension =
  light_dark_icon ~extension ~light:"discord-light.svg" ~dark:"discord-dark.svg"
;;

let github_icon ~extension =
  light_dark_icon ~extension ~light:"github-light.svg" ~dark:"github-dark.svg"
;;

let package_icon ~extension =
  light_dark_icon ~extension ~light:"number-light.svg" ~dark:"number-dark.svg"
;;

let terminal_icon ~extension =
  light_dark_icon ~extension ~light:"terminal-light.svg" ~dark:"terminal-dark.svg"
;;
