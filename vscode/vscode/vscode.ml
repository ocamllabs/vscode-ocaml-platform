open Interop

module Disposable = struct
  type t = private (* class *) Ojs.t [@@js]

  val from : (t list[@js.variadic]) -> t [@@js.global "vscode.Disposable.from"]

  val make : dispose:(unit -> unit) -> t [@@js.new "vscode.Disposable"]

  val dispose : t -> unit [@@js.call]
end

module Command = struct
  type t = private (* interface *) Ojs.t [@@js]

  val title : t -> string [@@js.get]

  val command : t -> string [@@js.get]

  val tooltip : t -> string or_undefined [@@js.get]

  val arguments : t -> Ojs.t maybe_list [@@js.get]

  val create :
       title:string
    -> command:string
    -> ?tooltip:string
    -> ?arguments:Ojs.t list
    -> unit
    -> t
    [@@js.builder]
end

module Position = struct
  type t = private (* class *) Ojs.t [@@js]

  val line : t -> int [@@js.get]

  val character : t -> int [@@js.get]

  val make : line:int -> character:int -> t [@@js.new "vscode.Position"]

  val isBefore : t -> other:t -> bool [@@js.call]

  val isBeforeOrEqual : t -> other:t -> bool [@@js.call]

  val isAfter : t -> other:t -> bool [@@js.call]

  val isAfterOrEqual : t -> other:t -> bool [@@js.call]

  val isEqual : t -> other:t -> bool [@@js.call]

  val compareTo : t -> other:t -> int [@@js.call]

  val translate : t -> ?lineDelta:int -> ?characterDelta:int -> unit -> t
    [@@js.call]

  val with_ : t -> ?line:int -> ?character:int -> unit -> t [@@js.call]
end

module Range = struct
  type t = private (* class *) Ojs.t [@@js]

  val start : t -> Position.t [@@js.get]

  val end_ : t -> Position.t [@@js.get]

  val makePositions : start:Position.t -> end_:Position.t -> t
    [@@js.new "vscode.Range"]

  val makeCoordinates :
    startLine:int -> startCharacter:int -> endLine:int -> endCharacter:int -> t
    [@@js.new "vscode.Range"]

  val isEmpty : t -> bool [@@js.get]

  val isSingleLine : t -> bool [@@js.get]

  val contains :
       t
    -> positionOrRange:([ `Position of Position.t | `Range of t ][@js.union])
    -> bool
    [@@js.call]

  val isEqual : t -> other:t -> bool [@@js.call]

  val intersection : t -> range:t -> t or_undefined [@@js.call]

  val union : t -> other:t -> t [@@js.call]

  val with_ : t -> ?start:Position.t -> ?end_:Position.t -> unit -> t
    [@@js.call]
end

module TextLine = struct
  type t = private (* interface *) Ojs.t [@@js]

  val lineNumber : t -> int [@@js.get]

  val text : t -> string [@@js.get]

  val range : t -> Range.t [@@js.get]

  val rangeIncludingLineBreak : t -> Range.t [@@js.get]

  val firstNonWhitespaceCharacterIndex : t -> int [@@js.get]

  val isEmptyOrWhitespace : t -> bool [@@js.get]

  val create :
       lineNumber:int
    -> text:string
    -> range:Range.t
    -> rangeIncludingLineBreak:Range.t
    -> firstNonWhitespaceCharacterIndex:int
    -> isEmptyOrWhitespace:bool
    -> t
    [@@js.builder]
end

module EndOfLine = struct
  type t =
    | CRLF [@js 2]
    | LF [@js 1]
  [@@js.enum] [@@js]
end

module TextEdit = struct
  type t = private (* class *) Ojs.t [@@js]

  val replace : range:Range.t -> newText:string -> t
    [@@js.global "vscode.TextEdit.replace"]

  val insert : position:Position.t -> newText:string -> t
    [@@js.global "vscode.TextEdit.insert"]

  val delete : Range.t -> t [@@js.global "vscode.TextEdit.delete"]

  val setEndOfLine : EndOfLine.t -> t
    [@@js.global "vscode.TextEdit.setEndOfLine"]

  val range : t -> Range.t [@@js.get]

  val newText : t -> string [@@js.get]

  val newEol : t -> EndOfLine.t or_undefined [@@js.get]

  val make : range:Range.t -> newText:string -> t [@@js.new "vscode.TextEdit"]
end

module Uri = struct
  type t = private (* class *) Ojs.t [@@js]

  val parse : string -> ?strict:bool -> unit -> t
    [@@js.global "vscode.Uri.parse"]

  val file : string -> t [@@js.global "vscode.Uri.file"]

  val joinPath : t -> pathSegments:(string list[@js.variadic]) -> t
    [@@js.global "vscode.Uri.joinPath"]

  val scheme : t -> string [@@js.get]

  val authority : t -> string [@@js.get]

  val path : t -> string [@@js.get]

  val query : t -> string [@@js.get]

  val fragment : t -> string [@@js.get]

  val fsPath : t -> string [@@js.get]

  val with_ : t -> Ojs.t -> t [@@js.call]

  let with_ this ?scheme ?authority ?path ?query ?fragment () =
    let change = Ojs.obj [||] in
    iter_set change "scheme" [%js.of: string] scheme;
    iter_set change "authority" [%js.of: string] authority;
    iter_set change "path" [%js.of: string] path;
    iter_set change "query" [%js.of: string] query;
    iter_set change "fragment" [%js.of: string] fragment;
    with_ this change

  val toString : t -> ?skipEncoding:bool -> unit -> string [@@js.call]

  val toJson : t -> Jsonoo.t [@@js.call]
end

module TextDocument = struct
  type t = private (* interface *) Ojs.t [@@js]

  val uri : t -> Uri.t [@@js.get]

  val fileName : t -> string [@@js.get]

  val isUntitled : t -> bool [@@js.get]

  val languageId : t -> string [@@js.get]

  val version : t -> int [@@js.get]

  val isDirty : t -> bool [@@js.get]

  val isClosed : t -> bool [@@js.get]

  val save : t -> bool Promise.t [@@js.call]

  val eol : t -> EndOfLine.t [@@js.get]

  val lineCount : t -> int [@@js.get]

  val lineAt : t -> line:int -> TextLine.t [@@js.call]

  val lineAtPosition : t -> position:Position.t -> TextLine.t
    [@@js.call "lineAt"]

  val offsetAt : t -> position:Position.t -> int [@@js.call]

  val positionAt : t -> offset:int -> Position.t [@@js.call]

  val getText : t -> ?range:Range.t -> unit -> string [@@js.call]

  val getWordRangeAtPosition :
    t -> position:Position.t -> ?regex:Regexp.t -> unit -> Range.t or_undefined
    [@@js.call]

  val validateRange : t -> range:Range.t -> Range.t [@@js.call]

  val validatePosition : t -> position:Position.t -> Position.t [@@js.call]
end

module WorkspaceFolder = struct
  type t = private (* interface *) Ojs.t [@@js]

  val uri : t -> Uri.t [@@js.get]

  val name : t -> string [@@js.get]

  val index : t -> int [@@js.get]

  val create : uri:Uri.t -> name:string -> index:int -> t [@@js.builder]
end

module ViewColumn = struct
  type t =
    | Active [@js -1]
    | Beside [@js -2]
    | One [@js 1]
    | Two [@js 2]
    | Three [@js 3]
    | Four [@js 4]
    | Five [@js 5]
    | Six [@js 6]
    | Seven [@js 7]
    | Eight [@js 8]
    | Nine [@js 9]
  [@@js.enum] [@@js]
end

module Selection = struct
  type t = private (* class extends *) Range.t [@@js]

  val anchor : t -> Position.t [@@js.get]

  val active : t -> Position.t [@@js.get]

  val makePositions : anchor:Position.t -> active:Position.t -> t
    [@@js.new "vscode.Selection"]

  val makeCoordinates :
       anchorLine:int
    -> anchorCharacter:int
    -> activeLine:int
    -> activeCharacter:int
    -> t
    [@@js.new "vscode.Selection"]

  val isReversed : t -> bool [@@js.get]
end

module TextEditorEdit = struct
  type t = private (* interface *) Ojs.t [@@js]

  type replaceLocation =
    ([ `Position of Position.t
     | `Range of Range.t
     | `Selection of Selection.t
     ]
    [@js.union])
  [@@js]

  let replaceLocation_of_js js_val =
    if Ojs.has_property js_val "anchor" then
      `Position ([%js.to: Position.t] js_val)
    else if Ojs.has_property js_val "start" then
      `Range ([%js.to: Range.t] js_val)
    else
      `Selection ([%js.to: Selection.t] js_val)

  type deleteLocation =
    ([ `Range of Range.t
     | `Selection of Selection.t
     ]
    [@js.union])
  [@@js]

  let deleteLocation_of_js js_val =
    if Ojs.has_property js_val "anchor" then
      `Selection ([%js.to: Selection.t] js_val)
    else
      `Range ([%js.to: Range.t] js_val)

  val replace : t -> location:replaceLocation -> value:string -> unit
    [@@js.call]

  val insert : t -> location:Position.t -> value:string -> unit [@@js.call]

  val delete : t -> location:deleteLocation -> unit [@@js.call]

  val setEndOfLine : t -> endOfLine:EndOfLine.t -> t [@@js.call]

  val create :
       replace:(location:replaceLocation -> value:string -> unit)
    -> insert:(location:Position.t -> value:string -> unit)
    -> delete:(location:deleteLocation -> unit)
    -> setEndOfLine:(endOfLine:EndOfLine.t -> t)
    -> t
    [@@js.builder]
end

module TextEditorCursorStyle = struct
  type t =
    | Line [@js 1]
    | Block [@js 2]
    | Underline [@js 3]
    | LineThin [@js 4]
    | BlockOutline [@js 5]
    | UnderlineThin [@js 6]
  [@@js.enum] [@@js]
end

module TextEditorLineNumbersStyle = struct
  type t =
    | Off [@js 0]
    | On [@js 1]
    | Relative [@js 2]
  [@@js.enum] [@@js]
end

module TextEditorRevealType = struct
  type t =
    | Default [@js 0]
    | InCenter [@js 1]
    | InCenterIfOutsideViewport [@js 2]
    | AtTop [@js 3]
  [@@js.enum] [@@js]
end

module TextEditorOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type tabSize =
    ([ `Int of int
     | `String of string
     ]
    [@js.union])
  [@@js]

  let tabSize_of_js js_val =
    match Ojs.type_of js_val with
    | "number" -> `Int ([%js.to: int] js_val)
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> assert false

  type insertSpaces =
    ([ `Bool of bool
     | `String of string
     ]
    [@js.union])
  [@@js]

  let insertSpaces_of_js js_val =
    match Ojs.type_of js_val with
    | "boolean" -> `Bool ([%js.to: bool] js_val)
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> assert false

  val tabSize : t -> tabSize or_undefined [@@js.get]

  val insertSpaces : t -> insertSpaces or_undefined [@@js.get]

  val cursorStyle : t -> TextEditorCursorStyle.t or_undefined [@@js.get]

  val lineNumbers : t -> TextEditorLineNumbersStyle.t or_undefined [@@js.get]

  val create :
       ?tabSize:tabSize
    -> ?insertSpaces:insertSpaces
    -> ?cursorStyle:TextEditorCursorStyle.t
    -> ?lineNumbers:TextEditorLineNumbersStyle.t
    -> unit
    -> t
    [@@js.builder]
end

module TextEditorDecorationType = struct
  type t = private (* interface *) Ojs.t [@@js]

  val key : t -> string [@@js.get]

  val dispose : t -> unit [@@js.call]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)

  val create : key:string -> dispose:(unit -> unit) -> t [@@js.builder]
end

module MarkdownString = struct
  type t = private (* class *) Ojs.t [@@js]

  val value : t -> string [@@js.get]

  val isTrusted : t -> bool or_undefined [@@js.get]

  val supportThemeIcons : t -> bool or_undefined [@@js.get]

  val make : ?value:string -> ?supportThemeIcons:bool -> unit -> t
    [@@js.new "vscode.MarkdownString"]

  val appendText : t -> value:string -> t [@@js.call]

  val appendMarkdown : t -> value:string -> t [@@js.call]

  val appendCodeblock : t -> value:string -> ?language:string -> unit -> t
    [@@js.call]
end

module ThemeColor = struct
  type t = private (* class *) Ojs.t [@@js]

  val make : id:string -> t [@@js.new "vscode.ThemeColor"]
end

module ThemableDecorationAttachmentRenderOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type contentIconPath =
    ([ `String of string
     | `Uri of Uri.t
     ]
    [@js.union])
  [@@js]

  let contentIconPath_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> `Uri ([%js.to: Uri.t] js_val)

  type color =
    ([ `String of string
     | `ThemeColor of ThemeColor.t
     ]
    [@js.union])
  [@@js]

  let color_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> `ThemeColor ([%js.to: ThemeColor.t] js_val)

  val contentText : t -> string or_undefined [@@js.get]

  val contentIconPath : t -> contentIconPath or_undefined [@@js.get]

  val border : t -> string or_undefined [@@js.get]

  val borderColor : t -> color or_undefined [@@js.get]

  val fontStyle : t -> string or_undefined [@@js.get]

  val fontWeight : t -> string or_undefined [@@js.get]

  val textDecoration : t -> string or_undefined [@@js.get]

  val color : t -> color or_undefined [@@js.get]

  val backgroundColor : t -> color or_undefined [@@js.get]

  val margin : t -> string or_undefined [@@js.get]

  val width : t -> string or_undefined [@@js.get]

  val height : t -> string or_undefined [@@js.get]

  val create :
       ?contentText:string
    -> ?contentIconPath:contentIconPath
    -> ?border:string
    -> ?borderColor:color
    -> ?fontStyle:string
    -> ?fontWeight:string
    -> ?textDecoration:string
    -> ?color:color
    -> ?backgroundColor:color
    -> ?margin:string
    -> ?width:string
    -> ?height:string
    -> unit
    -> t
    [@@js.builder]
end

module ThemableDecorationInstanceRenderOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
    [@@js.get]

  val after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
    [@@js.get]

  val create :
       ?before:ThemableDecorationAttachmentRenderOptions.t
    -> ?after:ThemableDecorationAttachmentRenderOptions.t
    -> unit
    -> t
    [@@js.builder]
end

module DecorationInstanceRenderOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val light : t -> ThemableDecorationInstanceRenderOptions.t or_undefined
    [@@js.get]

  val dark : t -> ThemableDecorationInstanceRenderOptions.t or_undefined
    [@@js.get]

  val create :
       ?light:ThemableDecorationInstanceRenderOptions.t
    -> ?dark:ThemableDecorationInstanceRenderOptions.t
    -> unit
    -> t
    [@@js.builder]
end

module DecorationOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type hoverMessage =
    ([ `MarkdownString of MarkdownString.t
     | `MarkdownStrings of MarkdownString.t list
     ]
    [@js.union])
  [@@js]

  let hoverMessage_of_js js_val =
    if Ojs.has_property js_val "value" then
      `MarkdownString ([%js.to: MarkdownString.t] js_val)
    else
      `MarkdownStrings ([%js.to: MarkdownString.t list] js_val)

  val range : t -> Range.t [@@js.get]

  val hoverMessage : t -> hoverMessage or_undefined [@@js.get]

  val renderOptions : t -> DecorationInstanceRenderOptions.t or_undefined
    [@@js.get]

  val create :
       range:Range.t
    -> ?hoverMessage:hoverMessage
    -> ?renderOptions:DecorationInstanceRenderOptions.t or_undefined
    -> unit
    -> t
    [@@js.builder]
end

module SnippetString = struct
  type t = private (* class *) Ojs.t [@@js]

  val value : t -> string [@@js.get]

  val make : ?value:string -> unit -> t [@@js.new "vscode.SnippetString"]

  val appendText : t -> string:string -> t [@@js.call]

  val appendTabStop : t -> number:int -> t [@@js.call]

  val appendPlaceHolder :
       t
    -> value:([ `String of string | `Function of t -> unit ][@js.union])
    -> ?number:int
    -> unit
    -> t
    [@@js.call]

  val appendChoice : t -> values:string list -> ?number:int -> unit -> t
    [@@js.call]

  val appendVariable :
       t
    -> name:string
    -> defaultValue:([ `String of string | `Function of t -> unit ][@js.union])
    -> t
    [@@js.call]
end

module TextEditor = struct
  type t = private (* interface*) Ojs.t [@@js]

  type insertSnippetLocation =
    ([ `Position of Position.t
     | `Range of Range.t
     | `Positions of Position.t list
     | `Ranges of Range.t list
     ]
    [@js.union])
  [@@js]

  val document : t -> TextDocument.t [@@js.get]

  val selection : t -> Selection.t [@@js.get]

  val selections : t -> Selection.t list [@@js.get]

  val visibleRanges : t -> Range.t list [@@js.get]

  val options : t -> TextEditorOptions.t [@@js.get]

  val viewColumn : t -> ViewColumn.t or_undefined [@@js.get]

  val edit :
       t
    -> callback:(editBuilder:TextEditorEdit.t -> unit)
    -> Ojs.t
    -> unit
    -> bool Promise.t
    [@@js.call]

  let edit this ~callback ?undoStopBefore ?undoStopAfter () =
    let options = Ojs.obj [||] in
    iter_set options "undoStopBefore" [%js.of: bool] undoStopBefore;
    iter_set options "undoStopAfter" [%js.of: bool] undoStopAfter;
    edit this ~callback options ()

  val insertSnippet :
       t
    -> snippet:SnippetString.t
    -> ?location:insertSnippetLocation
    -> Ojs.t
    -> bool Promise.t
    [@@js.call]

  let insertSnippet this ~snippet ?location ?undoStopBefore ?undoStopAfter () =
    let options = Ojs.obj [||] in
    iter_set options "undoStopBefore" [%js.of: bool] undoStopBefore;
    iter_set options "undoStopAfter" [%js.of: bool] undoStopAfter;
    insertSnippet this ~snippet ?location options

  val setDecorations :
       t
    -> decorationType:TextEditorDecorationType.t
    -> rangesOrOptions:
         ([ `Ranges of Range.t list | `Options of DecorationOptions.t list ]
         [@js.union])
    -> unit
    [@@js.call]

  val revealRange :
    t -> range:Range.t -> ?revealType:TextEditorRevealType.t -> unit -> unit
    [@@js.call]
end

module ConfigurationTarget = struct
  type t =
    | Global [@js 1]
    | Workspace [@js 2]
    | WorkspaceFolder [@js 3]
  [@@js.enum] [@@js]
end

module WorkspaceConfiguration = struct
  type t = private (* interface *) Ojs.t [@@js]

  type configurationTarget =
    ([ `ConfigurationTarget of ConfigurationTarget.t
     | `Bool of bool
     ]
    [@js.union])
  [@@js]

  type inspectResult =
    { key : string
    ; defaultValue : Jsonoo.t or_undefined
    ; globalValue : Jsonoo.t or_undefined
    ; workspaceValue : Jsonoo.t or_undefined
    ; workspaceFolderValue : Jsonoo.t or_undefined
    ; defaultLanguageValue : Jsonoo.t or_undefined
    ; globalLanguageValue : Jsonoo.t or_undefined
    ; workspaceLanguageValue : Jsonoo.t or_undefined
    ; workspaceFolderLanguageValue : Jsonoo.t or_undefined
    ; languageIds : string or_undefined
    }
  [@@js]

  val get : t -> section:string -> unit -> Jsonoo.t or_undefined [@@js.call]

  val has : t -> section:string -> bool [@@js.call]

  val inspect : t -> section:string -> inspectResult [@@js.call]

  val update :
       t
    -> section:string
    -> value:Jsonoo.t
    -> ?configurationTarget:configurationTarget
    -> ?overrideInLanguage:bool
    -> unit
    -> Promise.void
    [@@js.call]
end

module StatusBarAlignment = struct
  type t =
    | Left [@js 1]
    | Right [@js 2]
  [@@js.enum] [@@js]
end

module AccessibilityInformation = struct
  type t = private (* interface*) Ojs.t [@@js]

  val label : t -> string [@@js.get]

  val role : t -> string or_undefined [@@js.get]

  val create : label:string -> ?role:string -> unit -> t [@@js.builder]
end

module StatusBarItem = struct
  type t = private (* interface *) Ojs.t [@@js]

  type color =
    ([ `String of string
     | `ThemeColor of ThemeColor.t
     ]
    [@js.union])
  [@@js]

  let color_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> `ThemeColor ([%js.to: ThemeColor.t] js_val)

  type command =
    ([ `String of string
     | `Command of Command.t
     ]
    [@js.union])
  [@@js]

  let command_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> `Command ([%js.to: Command.t] js_val)

  val alignment : t -> StatusBarAlignment.t [@@js.get]

  val priority : t -> int or_undefined [@@js.get]

  val text : t -> string [@@js.get]

  val tooltip : t -> string or_undefined [@@js.get]

  val color : t -> color or_undefined [@@js.get]

  val command : t -> command or_undefined [@@js.get]

  val accessibilityInformation : t -> AccessibilityInformation.t or_undefined
    [@@js.get]

  val set_alignment : t -> StatusBarAlignment.t -> unit [@@js.set "alignment"]

  val set_priority : t -> int -> unit [@@js.set]

  val set_text : t -> string -> unit [@@js.set]

  val set_tooltip : t -> string -> unit [@@js.set]

  val set_color : t -> color -> unit [@@js.set]

  val set_command : t -> command -> unit [@@js.set]

  val set_accessibilityInformation : t -> AccessibilityInformation.t -> unit
    [@@js.set]

  val show : t -> unit [@@js.call]

  val hide : t -> unit [@@js.call]

  val dispose : t -> unit [@@js.call]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)
end

module WorkspaceFoldersChangeEvent = struct
  type t = private (* interface *) Ojs.t [@@js]

  val added : t -> WorkspaceFolder.t list [@@js.get]

  val removed : t -> WorkspaceFolder.t list [@@js.get]

  val create :
    added:WorkspaceFolder.t list -> removed:WorkspaceFolder.t list -> t
    [@@js.builder]
end

module FormattingOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val tabSize : t -> int [@@js.get]

  val insertSpaces : t -> bool [@@js.get]

  val create : tabSize:int -> insertSpaces:bool -> t [@@js.builder]
end

module Event = struct
  type 'a t = listener:('a -> unit) -> Disposable.t

  let t_of_js (ml_of_js : Ojs.t -> 'a) (js_fun : Ojs.t) : 'a t =
   fun ~listener:ml_listener ->
    let js_listener =
      Ojs.fun_to_js 1 @@ fun js_arg -> ml_listener (ml_of_js js_arg)
    in
    let (disposable : Ojs.t) =
      Ojs.call js_fun "call" [| Ojs.null; js_listener |]
    in
    [%js.to: Disposable.t] disposable

  let t_to_js (ml_to_js : 'a -> Ojs.t) (ml_fun : 'a t) : Ojs.t =
    Ojs.fun_to_js 1 @@ fun js_listener ->
    let ml_listener ml_arg =
      ignore @@ Ojs.call js_listener "call" [| Ojs.null; ml_to_js ml_arg |]
    in
    let (disposable : Disposable.t) = ml_fun ~listener:ml_listener in
    [%js.of: Disposable.t] disposable
end

module CancellationToken = struct
  type t = private (* interface *) Ojs.t [@@js]

  val isCancellationRequested : t -> bool [@@js.get]

  val onCancellationRequested : t -> Ojs.t Event.t [@@js.get]

  val create :
    isCancellationRequested:bool -> onCancellationRequested:Ojs.t Event.t -> t
    [@@js.builder]
end

module QuickPickItem = struct
  type t = private (* interface *) Ojs.t [@@js]

  val label : t -> string [@@js.get]

  val description : t -> string or_undefined [@@js.get]

  val detail : t -> string or_undefined [@@js.get]

  val picked : t -> bool or_undefined [@@js.get]

  val alwaysShow : t -> bool or_undefined [@@js.get]

  val create :
       label:string
    -> ?description:string
    -> ?detail:string
    -> ?picked:bool
    -> ?alwaysShow:bool
    -> unit
    -> t
    [@@js.builder]
end

module QuickPickOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type onDidSelectItemArgs =
    ([ `QuickPickItem of QuickPickItem.t
     | `String of string
     ]
    [@js.union])
  [@@js]

  let onDidSelectItemArgs_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> `QuickPickItem ([%js.to: QuickPickItem.t] js_val)

  val matchOnDescription : t -> bool or_undefined [@@js.get]

  val matchOnDetail : t -> bool or_undefined [@@js.get]

  val placeHolder : t -> string or_undefined [@@js.get]

  val ignoreFocusOut : t -> bool or_undefined [@@js.get]

  val canPickMany : t -> bool or_undefined [@@js.get]

  val onDidSelectItem : t -> (onDidSelectItemArgs -> unit) or_undefined
    [@@js.get]

  val create :
       ?matchOnDescription:bool
    -> ?matchOnDetail:bool
    -> ?placeHolder:string
    -> ?ignoreFocusOut:bool
    -> ?canPickMany:bool
    -> ?onDidSelectItem:(item:onDidSelectItemArgs -> unit)
    -> unit
    -> t
    [@@js.builder]
end

module ProviderResult = struct
  type 'a t =
    [ `Value of 'a or_undefined
    | `Promise of 'a or_undefined Promise.t
    ]

  let t_to_js ml_to_js = function
    | `Value v -> or_undefined_to_js ml_to_js v
    | `Promise p -> Promise.t_to_js (or_undefined_to_js ml_to_js) p

  let t_of_js ml_of_js js_val =
    if Ojs.has_property js_val "then" then
      `Promise (Promise.t_of_js (or_undefined_of_js ml_of_js) js_val)
    else
      `Value (or_undefined_of_js ml_of_js js_val)
end

module InputBoxOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val value : t -> string or_undefined [@@js.get]

  val valueSelection : t -> (int * int) or_undefined [@@js.get]

  val prompt : t -> string or_undefined [@@js.get]

  val placeHolder : t -> string or_undefined [@@js.get]

  val password : t -> bool or_undefined [@@js.get]

  val ignoreFocusOut : t -> bool or_undefined [@@js.get]

  val validateInput : t -> (string -> string ProviderResult.t) or_undefined
    [@@js.get]

  val create :
       ?value:string
    -> ?valueSelection:int * int
    -> ?prompt:string
    -> ?placeHolder:string
    -> ?password:bool
    -> ?ignoreFocusOut:bool
    -> ?validateInput:(value:string -> string option Promise.t)
    -> unit
    -> t
    [@@js.builder]
end

module MessageItem = struct
  type t = private (* interface *) Ojs.t [@@js]

  val title : t -> string [@@js.get]

  val isCloseAffordance : t -> bool or_undefined [@@js.get]

  val create : title:string -> ?isCloseAffordance:bool -> unit -> t
    [@@js.builder]
end

module Location = struct
  type t = private (* class *) Ojs.t [@@js]

  val uri : t -> Uri.t [@@js.get]

  val range : t -> Range.t [@@js.get]

  val make :
       uri:Uri.t
    -> rangeOrPosition:([ `Range of Range.t | `Position of Position.t ]
         [@js.union])
    -> t
    [@@js.new "vscode.Location"]
end

module ProgressLocation = struct
  type t =
    | SourceControl [@js 1]
    | Window [@js 10]
    | Notification [@js 25]
  [@@js.enum] [@@js]
end

module ProgressOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type viewIdLocation = { viewId : string } [@@js]

  type location =
    ([ `ProgressLocation of ProgressLocation.t
     | `ViewIdLocation of viewIdLocation
     ]
    [@js.union])
  [@@js]

  let location_of_js js_val =
    match Ojs.type_of js_val with
    | "number" -> `ProgressLocation ([%js.to: ProgressLocation.t] js_val)
    | _ -> `ViewIdLocation ([%js.to: viewIdLocation] js_val)

  val location : t -> location [@@js.get]

  val title : t -> string or_undefined [@@js.get]

  val cancellable : t -> bool or_undefined [@@js.get]

  val create :
    location:location -> ?title:string -> ?cancellable:bool -> unit -> t
    [@@js.builder]
end

module TextDocumentShowOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val viewColumn : t -> ViewColumn.t or_undefined [@@js.get]

  val preserveFocus : t -> bool or_undefined [@@js.get]

  val preview : t -> bool or_undefined [@@js.get]

  val selection : t -> Range.t or_undefined [@@js.get]

  val create :
       viewColumn:ViewColumn.t
    -> ?preserveFocus:bool
    -> ?preview:bool
    -> ?selection:Range.t
    -> unit
    -> t
    [@@js.builder]
end

module TerminalOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type shellArgs =
    ([ `Arg of string
     | `Args of string list
     ]
    [@js.union])
  [@@js]

  let shellArgs_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `Arg ([%js.to: string] js_val)
    | _ -> `Args ([%js.to: string list] js_val)

  type cwd =
    ([ `String of string
     | `Uri of Uri.t
     ]
    [@js.union])
  [@@js]

  let cwd_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> `Uri ([%js.to: Uri.t] js_val)

  val name : t -> string or_undefined [@@js.get]

  val shellPath : t -> string or_undefined [@@js.get]

  val shellArgs : t -> shellArgs or_undefined [@@js.get]

  val cwd : t -> cwd or_undefined [@@js.get]

  val env : t -> string or_undefined Dict.t or_undefined [@@js.get]

  val strictEnv : t -> bool [@@js.get]

  val hideFromUser : t -> bool [@@js.get]
end

module TerminalDimensions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val columns : t -> int [@@js.get]

  val rows : t -> int [@@js.get]

  val create : columns:int -> rows:int -> t [@@js.builder]
end

module Pseudoterminal = struct
  type t = private (* interface *) Ojs.t [@@js]

  val onDidWrite : t -> string Event.t [@@js.get]

  val onDidOverrideDimensions :
    t -> TerminalDimensions.t or_undefined Event.t or_undefined
    [@@js.get]

  val onDidClose : t -> int or_undefined Event.t or_undefined [@@js.get]

  val open_ : t -> ?initialDimensions:TerminalDimensions.t -> unit -> unit
    [@@js.call]

  val close : t -> unit [@@js.call]

  val handleInput : t -> (data:string -> unit) or_undefined [@@js.get]

  val setDimensions :
    t -> (dimensions:TerminalDimensions.t -> unit) or_undefined
    [@@js.get]

  val create :
       onDidWrite:string Event.t
    -> ?onDidOverrideDimensions:TerminalDimensions.t or_undefined Event.t
    -> ?onDidClose:int or_undefined Event.t
    -> open_:(?initialDimensions:TerminalDimensions.t -> unit -> unit)
    -> close:(unit -> unit)
    -> ?handleInput:(data:string -> unit)
    -> ?setDimensions:(dimensions:TerminalDimensions.t -> unit)
    -> unit
    -> t
    [@@js.builder]
end

module ExtensionTerminalOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val name : t -> string [@@js.get]

  val pty : t -> Pseudoterminal.t [@@js.get]

  val create : name:string -> pty:Pseudoterminal.t -> t [@@js.builder]
end

module TerminalExitStatus = struct
  type t = private (* interface *) Ojs.t [@@js]

  val code : t -> int [@@js.get]

  val create : code:int -> t [@@js.builder]
end

module Terminal = struct
  type t = private (* interface *) Ojs.t [@@js]

  type creationOptions =
    ([ `TerminalOptions of TerminalOptions.t
     | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
     ]
    [@js.union])
  [@@js]

  let creationOptions_of_js js_val =
    if Ojs.has_property js_val "pty" then
      `ExtensionTerminalOptions ([%js.to: ExtensionTerminalOptions.t] js_val)
    else
      `TerminalOptions ([%js.to: TerminalOptions.t] js_val)

  val name : t -> string [@@js.get]

  val processId : t -> int or_undefined Promise.t [@@js.get]

  val creationOptions : t -> creationOptions [@@js.get]

  val exitStatus : t -> TerminalExitStatus.t or_undefined [@@js.get]

  val sendText : t -> text:string -> ?addNewLine:bool -> unit -> unit
    [@@js.call]

  val show : t -> ?preserveFocus:bool -> unit -> unit [@@js.call]

  val hide : t -> unit [@@js.call]

  val dispose : t -> unit [@@js.call]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)
end

module OutputChannel = struct
  type t = private (* interface *) Ojs.t [@@js]

  val name : t -> string [@@js.get]

  val append : t -> value:string -> unit [@@js.call]

  val appendLine : t -> value:string -> unit [@@js.call]

  val clear : t -> unit [@@js.call]

  val show : t -> ?preserveFocus:bool -> unit -> unit [@@js.call]

  val hide : t -> unit [@@js.call]

  val dispose : t -> unit [@@js.call]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)
end

module Memento = struct
  type t = private (* interface *) Ojs.t [@@js]

  val get : t -> key:string -> Jsonoo.t or_undefined [@@js.call]

  val update : t -> key:string -> value:Jsonoo.t -> Promise.void [@@js.call]
end

module EnvironmentVariableMutatorType = struct
  type t =
    | Replace [@js 1]
    | Append [@js 2]
    | Prepend [@js 3]
  [@@js.enum] [@@js]
end

module EnvironmentVariableMutator = struct
  type t = private (* interface *) Ojs.t [@@js]

  val type_ : t -> EnvironmentVariableMutatorType.t [@@js.get "type"]

  val value : t -> string [@@js.get]
end

module EnvironmentVariableCollection = struct
  type t = private (* interface *) Ojs.t [@@js]

  val persistent : t -> bool [@@js.get]

  val replace : t -> variable:string -> value:string -> unit [@@js.call]

  val append : t -> variable:string -> value:string -> unit [@@js.call]

  val prepend : t -> variable:string -> value:string -> unit [@@js.call]

  val get : t -> variable:string -> EnvironmentVariableMutator.t or_undefined
    [@@js.call]

  val forEach :
       t
    -> callback:
         (   variable:string
          -> mutator:EnvironmentVariableMutator.t
          -> collection:t
          -> unit)
    -> unit
    [@@js.call]

  val delete : t -> variable:string -> unit [@@js.call]

  val clear : t -> unit [@@js.call]
end

module ExtensionMode = struct
  type t =
    | Production [@js 1]
    | Development [@js 2]
    | Test [@js 3]
  [@@js.enum] [@@js]
end

module ExtensionContext = struct
  type t = private (* interface *) Ojs.t [@@js]

  val subscriptions : t -> Disposable.t list [@@js.get]

  val workspaceState : t -> Memento.t [@@js.get]

  val globalState : t -> Memento.t [@@js.get]

  val extensionUri : t -> Uri.t [@@js.get]

  val extensionPath : t -> string [@@js.get]

  val environmentVariableCollection : t -> EnvironmentVariableCollection.t
    [@@js.get]

  val asAbsolutePath : t -> relativePath:string -> string [@@js.call]

  val storageUri : t -> Uri.t or_undefined [@@js.get]

  val globalStorageUri : t -> Uri.t [@@js.get]

  val logUri : t -> Uri.t [@@js.get]

  val extensionMode : t -> ExtensionMode.t [@@js.get]

  let subscribe this ~disposable =
    let subscriptions = Ojs.get this "subscriptions" in
    let (_ : Ojs.t) = Ojs.call subscriptions "push" [| disposable |] in
    ()
end

module ShellQuotingOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type escapeLiteral =
    { escapeChar : string
    ; charsToEscape : string
    }
  [@@js]

  type escape =
    ([ `String of string
     | `Literal of escapeLiteral
     ]
    [@js.union])
  [@@js]

  let escape_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> `Literal ([%js.to: escapeLiteral] js_val)

  val escape : t -> escape or_undefined [@@js.get]

  val strong : t -> string or_undefined [@@js.get]

  val weak : t -> string or_undefined [@@js.get]

  val create : ?escape:escape -> ?strong:string -> ?weak:string -> unit -> t
    [@@js.builder]
end

module ShellExecutionOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val executable : t -> string or_undefined [@@js.get]

  val shellArgs : t -> string maybe_list [@@js.get]

  val shellQuoting : t -> ShellQuotingOptions.t or_undefined [@@js.get]

  val cwd : t -> string or_undefined [@@js.get]

  val env : t -> string Dict.t or_undefined [@@js.get]

  val create :
       ?executable:string
    -> ?shellArgs:string list
    -> ?shellQuoting:ShellQuotingOptions.t
    -> ?cwd:string
    -> ?env:string Dict.t
    -> unit
    -> t
    [@@js.builder]
end

module ShellQuoting = struct
  type t =
    | Escape [@js 1]
    | Strong [@js 2]
    | Weak [@js 3]
  [@@js.enum] [@@js]
end

module ShellQuotedString = struct
  type t = private (* interface *) Ojs.t [@@js]

  val value : t -> string [@@js.get]

  val quoting : t -> ShellQuoting.t [@@js.get]

  val create : value:string -> quoting:ShellQuoting.t -> t [@@js.builder]
end

module ShellExecution = struct
  type t = private (* class *) Ojs.t [@@js]

  type shellString =
    ([ `String of string
     | `ShellQuotedString of ShellQuotedString.t
     ]
    [@js.union])
  [@@js]

  let shellString_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> `ShellQuotedString ([%js.to: ShellQuotedString.t] js_val)

  val makeCommandLine :
    commandLine:string -> ?options:ShellExecutionOptions.t -> unit -> t
    [@@js.new "vscode.ShellExecution"]

  val makeCommandArgs :
       command:shellString
    -> args:shellString list
    -> ?options:ShellExecutionOptions.t
    -> unit
    -> t
    [@@js.new "vscode.ShellExecution"]

  val commandLine : t -> string or_undefined [@@js.get]

  val command : t -> shellString [@@js.get]

  val args : t -> shellString list [@@js.get]

  val options : t -> ShellExecutionOptions.t or_undefined [@@js.get]
end

module ProcessExecutionOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val cwd : t -> string or_undefined [@@js.get]

  val env : t -> string Dict.t or_undefined [@@js.get]

  val create : ?cwd:string -> ?env:string Dict.t -> unit -> t [@@js.builder]
end

module ProcessExecution = struct
  type t = private (* class *) Ojs.t [@@js]

  val makeProcess :
    process:string -> ?options:ProcessExecutionOptions.t -> unit -> t
    [@@js.new "vscode.ProcessExecution"]

  val makeProcessArgs :
       process:string
    -> args:string list
    -> ?options:ProcessExecutionOptions.t
    -> unit
    -> t
    [@@js.new "vscode.ProcessExecution"]

  val process : t -> string [@@js.get]

  val args : t -> string list [@@js.get]

  val options : t -> ProcessExecutionOptions.t or_undefined [@@js.get]
end

module TaskDefinition = struct
  type t = private (* interface *) Ojs.t [@@js]

  val type_ : t -> string [@@js.get]

  let get_attribute = Ojs.get

  let set_attribute = Ojs.set

  let create ~type_ ?(attributes = []) () =
    let obj = Ojs.obj [| ("type", [%js.of: string] type_) |] in
    let set (key, value) = Ojs.set obj key value in
    List.iter set attributes;
    obj
end

module CustomExecution = struct
  type t = private (* class *) Ojs.t [@@js]

  val make :
       callback:
         (resolvedDefinition:TaskDefinition.t -> Pseudoterminal.t Promise.t)
    -> t
    [@@js.new "vscode.CustomExecution"]
end

module RelativePattern = struct
  type t = private (* class *) Ojs.t [@@js]

  val base : t -> string [@@js.get]

  val pattern : t -> string [@@js.get]

  val make :
       base:([ `WorkspaceFolder of WorkspaceFolder.t | `String of string ]
         [@js.union])
    -> pattern:string
    -> t
    [@@js.new "vscode.RelativePattern"]
end

module GlobPattern = struct
  type t =
    ([ `String of string
     | `RelativePattern of RelativePattern.t
     ]
    [@js.union])
  [@@js]

  let t_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> `RelativePattern ([%js.to: RelativePattern.t] js_val)
end

module DocumentFilter = struct
  type t = private (* interface *) Ojs.t [@@js]

  val language : t -> string or_undefined [@@js.get]

  val scheme : t -> string or_undefined [@@js.get]

  val pattern : t -> GlobPattern.t or_undefined [@@js.get]

  val create :
    ?language:string -> ?scheme:string -> ?pattern:GlobPattern.t -> unit -> t
    [@@js.builder]
end

module DocumentSelector = struct
  type selector =
    ([ `Filter of DocumentFilter.t
     | `String of string
     ]
    [@js.union])
  [@@js]

  let selector_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> `Filter ([%js.to: DocumentFilter.t] js_val)

  type t =
    ([ `Filter of DocumentFilter.t
     | `String of string
     | `List of selector list
     ]
    [@js.union])
  [@@js]

  let t_of_js js_val =
    if Ojs.type_of js_val = "string" then
      `String ([%js.to: string] js_val)
    else if Ojs.has_property js_val "length" then
      `List ([%js.to: selector list] js_val)
    else
      `Filter ([%js.to: DocumentFilter.t] js_val)
end

module DocumentFormattingEditProvider = struct
  type t = private (* interface *) Ojs.t [@@js]

  val provideDocumentFormattingEdits :
       t
    -> document:TextDocument.t
    -> options:FormattingOptions.t
    -> token:CancellationToken.t
    -> TextEdit.t list ProviderResult.t
    [@@js.call]

  val create :
       provideDocumentFormattingEdits:
         (   document:TextDocument.t
          -> options:FormattingOptions.t
          -> token:CancellationToken.t
          -> TextEdit.t list ProviderResult.t)
    -> t
    [@@js.builder]
end

module TaskGroup = struct
  type t = private (* class *) Ojs.t [@@js]

  val clean : t [@@js.global "vscode.TaskGroup.Clean"]

  val build : t [@@js.global "vscode.TaskGroup.Build"]

  val rebuild : t [@@js.global "vscode.TaskGroup.Rebuild"]

  val test : t [@@js.global "vscode.TaskGroup.Test"]
end

module TaskScope = struct
  type t =
    | Folder of WorkspaceFolder.t
    | Global
    | Workspace

  let t_to_js = function
    | Folder f -> [%js.of: WorkspaceFolder.t] f
    | Global -> [%js.of: int] 1
    | Workspace -> [%js.of: int] 2

  let t_of_js js_val =
    match Ojs.type_of js_val with
    | "number" when [%js.to: int] js_val = 1 -> Global
    | "number" when [%js.to: int] js_val = 2 -> Workspace
    | _ -> Folder ([%js.to: WorkspaceFolder.t] js_val)
end

module RunOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val reevaluateOnRerun : t -> bool or_undefined [@@js.get]

  val create : ?reevaluateOnRerun:bool -> unit -> t [@@js.builder]
end

module TaskRevealKind = struct
  type t =
    | Always [@js 1]
    | Silent [@js 2]
    | Never [@js 3]
  [@@js.enum] [@@js]
end

module TaskPanelKind = struct
  type t =
    | Shared [@js 1]
    | Dedicated [@js 2]
    | New [@js 3]
  [@@js.enum] [@@js]
end

module TaskPresentationOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val reveal : t -> TaskRevealKind.t or_undefined [@@js.get]

  val echo : t -> bool or_undefined [@@js.get]

  val focus : t -> bool or_undefined [@@js.get]

  val panel : t -> TaskPanelKind.t or_undefined [@@js.get]

  val showReuseMessage : t -> bool or_undefined [@@js.get]

  val clear : t -> bool or_undefined [@@js.get]

  val create :
       ?reveal:TaskRevealKind.t
    -> ?echo:bool
    -> ?focus:bool
    -> ?panel:TaskPanelKind.t
    -> ?showReuseMessage:bool
    -> ?clear:bool
    -> unit
    -> t
    [@@js.builder]
end

module Task = struct
  type t = private (* class *) Ojs.t [@@js]

  type execution =
    ([ `ProcessExecution of ProcessExecution.t
     | `ShellExecution of ShellExecution.t
     | `CustomExecution of CustomExecution.t
     ]
    [@js.union])
  [@@js]

  let execution_of_js js_val =
    if Ojs.has_property js_val "process" then
      `ProcessExecution ([%js.to: ProcessExecution.t] js_val)
    else if Ojs.has_property js_val "command" then
      `ShellExecution ([%js.to: ShellExecution.t] js_val)
    else
      `CustomExecution ([%js.to: CustomExecution.t] js_val)

  val make :
       definition:TaskDefinition.t
    -> scope:TaskScope.t
    -> name:string
    -> source:string
    -> ?execution:execution
    -> ?problemMatchers:string list
    -> unit
    -> t
    [@@js.new "vscode.Task"]

  val definition : t -> TaskDefinition.t [@@js.get]

  val scope : t -> TaskScope.t or_undefined [@@js.get]

  val name : t -> string [@@js.get]

  val detail : t -> string or_undefined [@@js.get]

  val execution : t -> execution or_undefined [@@js.get]

  val isBackground : t -> bool [@@js.get]

  val source : t -> string [@@js.get]

  val group : t -> TaskGroup.t or_undefined [@@js.get]

  val presentationOptions : t -> TaskPresentationOptions.t [@@js.get]

  val runOptions : t -> RunOptions.t [@@js.get]

  val set_group : t -> TaskGroup.t -> unit [@@js.set]
end

module TaskProvider = struct
  type t = private (* interface *) Ojs.t [@@js]

  val provideTasks :
    t -> token:CancellationToken.t -> Task.t list ProviderResult.t
    [@@js.call]

  val resolveTasks :
    t -> task:Task.t -> token:CancellationToken.t -> Task.t ProviderResult.t
    [@@js.call]

  val create :
       provideTasks:(token:CancellationToken.t -> Task.t list ProviderResult.t)
    -> resolveTasks:
         (task:Task.t -> token:CancellationToken.t -> Task.t ProviderResult.t)
    -> t
    [@@js.builder]
end

module ConfigurationScope = struct
  type t =
    ([ `Uri of Uri.t
     | `TextDocument of TextDocument.t
     | `WorkspaceFolder of WorkspaceFolder.t
     ]
    [@js.union])
  [@@js]
end

module MessageOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val modal : t -> bool or_undefined [@@js.get]

  val create : ?modal:bool -> unit -> t [@@js.builder]
end

module Progress = struct
  type value =
    { message : string or_undefined
    ; increment : int or_undefined
    }
  [@@js]

  type t = private Ojs.t [@@js]

  val report : t -> value:value -> unit [@@js.call]
end

module Workspace = struct
  val workspaceFolders : unit -> WorkspaceFolder.t maybe_list
    [@@js.get "vscode.workspace.workspaceFolders"]

  val name : unit -> string or_undefined [@@js.get "vscode.workspace.name"]

  val workspaceFile : unit -> Uri.t or_undefined
    [@@js.get "vscode.workspace.workspaceFile"]

  val textDocuments : unit -> TextDocument.t list
    [@@js.get "vscode.workspace.textDocuments"]

  val onDidChangeWorkspaceFolders : WorkspaceFolder.t Event.t
    [@@js.global "vscode.workspace.onDidChangeWorkspaceFolders"]

  val getWorkspaceFolder : uri:Uri.t -> WorkspaceFolder.t or_undefined
    [@@js.global "vscode.workspace.getWorkspaceFolder"]

  val onDidOpenTextDocument : TextDocument.t Event.t
    [@@js.global "vscode.workspace.onDidOpenTextDocument"]

  val onDidCloseTextDocument : TextDocument.t Event.t
    [@@js.global "vscode.workspace.onDidCloseTextDocument"]

  val getConfiguration :
       ?section:string
    -> ?scope:ConfigurationScope.t
    -> unit
    -> WorkspaceConfiguration.t
    [@@js.global "vscode.workspace.getConfiguration"]

  val findFiles :
       includes:GlobPattern.t
    -> ?excludes:GlobPattern.t
    -> ?maxResults:int
    -> ?token:CancellationToken.t
    -> unit
    -> Uri.t list Promise.t
    [@@js.global "vscode.workspace.findFiles"]

  type textDocumentOptions =
    { language : string
    ; content : string
    }
  [@@js]

  val openTextDocument :
       ([ `Uri of Uri.t
        | `Filename of string
        | `Interactive of textDocumentOptions or_undefined
        ]
       [@js.union])
    -> TextDocument.t Promise.t
    [@@js.global "vscode.workspace.openTextDocument"]
end

module Window = struct
  val activeTextEditor : unit -> TextEditor.t or_undefined
    [@@js.get "vscode.window.activeTextEditor"]

  val showQuickPick :
       choices:QuickPickItem.t list
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> QuickPickItem.t or_undefined Promise.t
    [@@js.global "vscode.window.showQuickPick"]

  let showQuickPickItems ~choices ?options ?token () =
    let open Promise.Option.Syntax in
    let+ item =
      showQuickPick ~choices:(List.map fst choices) ?options ?token ()
    in
    List.assoc item choices

  val showQuickPick :
       items:string list
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string or_undefined Promise.t
    [@@js.global "vscode.window.showQuickPick"]

  val showInputBox :
       ?options:InputBoxOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string or_undefined Promise.t
    [@@js.global "vscode.window.showInputBox"]

  let getChoices choices =
    choices
    |> List.map (fun (title, choice) -> (MessageItem.create ~title (), choice))

  val showInformationMessage :
       message:string
    -> ?options:MessageOptions.t
    -> items:(MessageItem.t list[@js.variadic])
    -> unit
    -> MessageItem.t or_undefined Promise.t
    [@@js.global "vscode.window.showInformationMessage"]

  let showInformationMessage ~message ?options ?(choices = []) () =
    let choices = getChoices choices in
    let open Promise.Option.Syntax in
    let+ item =
      showInformationMessage ~message ?options ~items:(List.map fst choices) ()
    in
    List.assoc item choices

  val showWarningMessage :
       message:string
    -> ?options:MessageOptions.t
    -> items:(MessageItem.t list[@js.variadic])
    -> unit
    -> MessageItem.t or_undefined Promise.t
    [@@js.global "vscode.window.showWarningMessage"]

  let showWarningMessage ~message ?options ?(choices = []) () =
    let choices = getChoices choices in
    let open Promise.Option.Syntax in
    let+ item =
      showWarningMessage ~message ?options ~items:(List.map fst choices) ()
    in
    List.assoc item choices

  val showErrorMessage :
       message:string
    -> ?options:MessageOptions.t
    -> items:(MessageItem.t list[@js.variadic])
    -> unit
    -> MessageItem.t or_undefined Promise.t
    [@@js.global "vscode.window.showErrorMessage"]

  let showErrorMessage ~message ?options ?(choices = []) () =
    let choices = getChoices choices in
    let open Promise.Option.Syntax in
    let+ item =
      showErrorMessage ~message ?options ~items:(List.map fst choices) ()
    in
    List.assoc item choices

  val withProgress :
       options:ProgressOptions.t
    -> task:
         (progress:Progress.t -> token:CancellationToken.t -> Ojs.t Promise.t)
    -> Ojs.t Promise.t
    [@@js.global "vscode.window.withProgress"]

  let withProgress ~options ~task =
    let task ~progress ~token = Obj.magic (task ~progress ~token) in
    Obj.magic (withProgress ~options ~task)

  val createStatusBarItem :
    ?alignment:StatusBarAlignment.t -> ?priority:int -> unit -> StatusBarItem.t
    [@@js.global "vscode.window.createStatusBarItem"]

  val showTextDocument :
       document:([ `TextDocument of TextDocument.t | `Uri of Uri.t ][@js.union])
    -> ?column:ViewColumn.t
    -> ?preserveFocus:bool
    -> unit
    -> TextEditor.t Promise.t
    [@@js.global "vscode.window.showTextDocument"]

  val createTerminal :
       ?name:string
    -> ?shellPath:string
    -> ?shellArgs:([ `String of string | `Strings of string list ][@js.union])
    -> unit
    -> Terminal.t
    [@@js.global "vscode.window.createTerminal"]

  val createTerminalFromOptions :
       options:
         ([ `TerminalOptions of TerminalOptions.t
          | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
          ][@js.union])
    -> Terminal.t
    [@@js.global "vscode.window.createTerminal"]

  val createOutputChannel : name:string -> OutputChannel.t
    [@@js.global "vscode.window.createOutputChannel"]
end

module Commands = struct
  val registerCommand :
       command:string
    -> callback:(args:(Ojs.t list[@js.variadic]) -> unit)
    -> Disposable.t
    [@@js.global "vscode.commands.registerCommand"]

  val registerTextEditorCommand :
       command:string
    -> callback:
         (   textEditor:TextEditor.t
          -> edit:TextEditorEdit.t
          -> args:(Ojs.t list[@js.variadic])
          -> unit)
    -> Disposable.t
    [@@js.global "vscode.commands.registerTextEditorCommand"]

  val executeCommand :
       command:string
    -> args:(Ojs.t list[@js.variadic])
    -> Ojs.t or_undefined Promise.t
    [@@js.global "vscode.commands.executeCommand"]

  val getCommands : ?filterInternal:bool -> unit -> string list Promise.t
    [@@js.global "vscode.commands.getCommands"]
end

module Languages = struct
  val registerDocumentFormattingEditProvider :
       selector:DocumentSelector.t
    -> provider:DocumentFormattingEditProvider.t
    -> Disposable.t
    [@@js.global "vscode.languages.registerDocumentFormattingEditProvider"]
end

module Tasks = struct
  val registerTaskProvider :
    type_:string -> provider:TaskProvider.t -> Disposable.t
    [@@js.global "vscode.tasks.registerTaskProvider"]
end

module Env = struct
  val shell : unit -> string [@@js.get "vscode.env.shell"]
end

(* see https://code.visualstudio.com/api/references/icons-in-labels *)
module LabelIcons = struct
  let package = "$(package)"
end
