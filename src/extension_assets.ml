open Import

type t =
  { chat : LightDarkIcon.t
  ; collection : LightDarkIcon.t
  ; dependency : LightDarkIcon.t
  ; dependency_selected : LightDarkIcon.t
  ; discord : LightDarkIcon.t
  ; github : LightDarkIcon.t
  ; package : LightDarkIcon.t
  ; terminal : LightDarkIcon.t
  }

let uri ~extension_uri ~name = Uri.joinPath extension_uri ~pathSegments:[ "assets"; name ]

let light_dark_icon ~extension_uri ~light ~dark =
  LightDarkIcon.
    { light = `Uri (uri ~extension_uri ~name:light)
    ; dark = `Uri (uri ~extension_uri ~name:dark)
    }
;;

let make_dependency_icon ~extension_uri ~selected =
  let suffix = if selected then "-selected" else "" in
  light_dark_icon
    ~extension_uri
    ~light:("dependency-light" ^ suffix ^ ".svg")
    ~dark:("dependency-dark" ^ suffix ^ ".svg")
;;

let make ~extension_uri =
  { chat = light_dark_icon ~extension_uri ~light:"chat-light.svg" ~dark:"chat-dark.svg"
  ; collection =
      light_dark_icon
        ~extension_uri
        ~light:"collection-light.svg"
        ~dark:"collection-dark.svg"
  ; dependency = make_dependency_icon ~extension_uri ~selected:false
  ; dependency_selected = make_dependency_icon ~extension_uri ~selected:true
  ; discord =
      light_dark_icon ~extension_uri ~light:"discord-light.svg" ~dark:"discord-dark.svg"
  ; github =
      light_dark_icon ~extension_uri ~light:"github-light.svg" ~dark:"github-dark.svg"
  ; package =
      light_dark_icon ~extension_uri ~light:"number-light.svg" ~dark:"number-dark.svg"
  ; terminal =
      light_dark_icon ~extension_uri ~light:"terminal-light.svg" ~dark:"terminal-dark.svg"
  }
;;

let chat_icon t = t.chat
let collection_icon t = t.collection
let dependency_icon t ~selected = if selected then t.dependency_selected else t.dependency
let discord_icon t = t.discord
let github_icon t = t.github
let package_icon t = t.package
let terminal_icon t = t.terminal
