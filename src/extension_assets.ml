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

let make ~extension_uri =
  let uri name = Uri.joinPath extension_uri ~pathSegments:[ "assets"; name ] in
  let icon ?(variant = "") stem =
    LightDarkIcon.
      { light = `Uri (uri (stem ^ "-light" ^ variant ^ ".svg"))
      ; dark = `Uri (uri (stem ^ "-dark" ^ variant ^ ".svg"))
      }
  in
  { chat = icon "chat"
  ; collection = icon "collection"
  ; dependency = icon "dependency"
  ; dependency_selected = icon ~variant:"-selected" "dependency"
  ; discord = icon "discord"
  ; github = icon "github"
  ; package = icon "number"
  ; terminal = icon "terminal"
  }
;;

let chat_icon t = t.chat
let collection_icon t = t.collection
let dependency_icon t ~selected = if selected then t.dependency_selected else t.dependency
let discord_icon t = t.discord
let github_icon t = t.github
let package_icon t = t.package
let terminal_icon t = t.terminal
