open Import

let uri ~extension ~name =
  Uri.joinPath (ExtensionContext.extensionUri extension) ~pathSegments:[ "assets"; name ]
;;

let light_dark_icon ~extension ~light ~dark =
  LightDarkIcon.
    { light = `Uri (uri ~extension ~name:light); dark = `Uri (uri ~extension ~name:dark) }
;;
