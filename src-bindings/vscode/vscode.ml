open Interop

include [%js: val version : string [@@js.global "vscode.version"]]

module Disposable = struct
  include Class.Make ()

  include
    [%js:
    val from : (t list[@js.variadic]) -> t
      [@@js.global "vscode.Disposable.from"]

    val make : dispose:(unit -> unit) -> t [@@js.new "vscode.Disposable"]

    val dispose : t -> unit [@@js.call]]
end

module Command = struct
  include Interface.Make ()

  include
    [%js:
    val title : t -> string [@@js.get]

    val command : t -> string [@@js.get]

    val tooltip : t -> string or_undefined [@@js.get]

    val arguments : t -> Js.Any.t maybe_list [@@js.get]

    val create :
         title:string
      -> command:string
      -> ?tooltip:string
      -> ?arguments:Js.Any.t list
      -> unit
      -> t
      [@@js.builder]]
end

module Position = struct
  include Class.Make ()

  include
    [%js:
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

    val with_ : t -> ?line:int -> ?character:int -> unit -> t [@@js.call]]
end

module Range = struct
  include Class.Make ()

  include
    [%js:
    val start : t -> Position.t [@@js.get]

    val end_ : t -> Position.t [@@js.get]

    val makePositions : start:Position.t -> end_:Position.t -> t
      [@@js.new "vscode.Range"]

    val makeCoordinates :
         startLine:int
      -> startCharacter:int
      -> endLine:int
      -> endCharacter:int
      -> t
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
      [@@js.call]]
end

module TextLine = struct
  include Interface.Make ()

  include
    [%js:
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
      [@@js.builder]]
end

module EndOfLine = struct
  type t =
    | CRLF [@js 2]
    | LF [@js 1]
  [@@js.enum] [@@js]
end

module TextEdit = struct
  include Class.Make ()

  include
    [%js:
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

    val make : range:Range.t -> newText:string -> t [@@js.new "vscode.TextEdit"]]
end

module Uri = struct
  include Class.Make ()

  module Scheme = struct
    type t =
      [ `File
      | `Untitled
        (** URI scheme used by vscode for new draft (not-saved) files *)
      ]

    let to_string = function
      | `File -> "file"
      | `Untitled -> "untitled"
  end

  include
    [%js:
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

    val toString : t -> ?skipEncoding:bool -> unit -> string [@@js.call]

    val toJson : t -> Jsonoo.t [@@js.call]]

  let with_ this ?scheme ?authority ?path ?query ?fragment () =
    let change = Ojs.obj [||] in
    iter_set
      change
      "scheme"
      [%js.of: string]
      (Option.map Scheme.to_string scheme);
    iter_set change "authority" [%js.of: string] authority;
    iter_set change "path" [%js.of: string] path;
    iter_set change "query" [%js.of: string] query;
    iter_set change "fragment" [%js.of: string] fragment;
    with_ this change

  let equal a b = String.equal (toString a ()) (toString b ())
end

module TextDocument = struct
  include Interface.Make ()

  include
    [%js:
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
         t
      -> position:Position.t
      -> ?regex:Regexp.t
      -> unit
      -> Range.t or_undefined
      [@@js.call]

    val validateRange : t -> range:Range.t -> Range.t [@@js.call]

    val validatePosition : t -> position:Position.t -> Position.t [@@js.call]]
end

module WorkspaceFolder = struct
  include Interface.Make ()

  include
    [%js:
    val uri : t -> Uri.t [@@js.get]

    val name : t -> string [@@js.get]

    val index : t -> int [@@js.get]

    val create : uri:Uri.t -> name:string -> index:int -> t [@@js.builder]]
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
  include Class.Extend (Range) ()

  include Range

  include
    [%js:
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

    val isReversed : t -> bool [@@js.get]]
end

module TextEditorEdit = struct
  include Interface.Make ()

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
    else `Selection ([%js.to: Selection.t] js_val)

  type deleteLocation =
    ([ `Range of Range.t
     | `Selection of Selection.t
     ]
    [@js.union])
  [@@js]

  let deleteLocation_of_js js_val =
    if Ojs.has_property js_val "anchor" then
      `Selection ([%js.to: Selection.t] js_val)
    else `Range ([%js.to: Range.t] js_val)

  include
    [%js:
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
      [@@js.builder]]
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
  include Interface.Make ()

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

  include
    [%js:
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
      [@@js.builder]]
end

module TextEditorDecorationType = struct
  include Interface.Make ()

  include
    [%js:
    val key : t -> string [@@js.get]

    val dispose : t -> unit [@@js.call]

    val create : key:string -> dispose:(unit -> unit) -> t [@@js.builder]]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)
end

module MarkdownString = struct
  include Class.Make ()

  include
    [%js:
    val value : t -> string [@@js.get]

    val isTrusted : t -> bool or_undefined [@@js.get]

    val supportThemeIcons : t -> bool or_undefined [@@js.get]

    val make : ?value:string -> ?supportThemeIcons:bool -> unit -> t
      [@@js.new "vscode.MarkdownString"]

    val appendText : t -> value:string -> t [@@js.call]

    val appendMarkdown : t -> value:string -> t [@@js.call]

    val appendCodeblock : t -> value:string -> ?language:string -> unit -> t
      [@@js.call]]
end

module ThemeColor = struct
  include Class.Make ()

  include [%js: val make : id:string -> t [@@js.new "vscode.ThemeColor"]]
end

module ThemableDecorationAttachmentRenderOptions = struct
  include Interface.Make ()

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

  include
    [%js:
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
      [@@js.builder]]
end

module ThemableDecorationInstanceRenderOptions = struct
  include Interface.Make ()

  include
    [%js:
    val before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
      [@@js.get]

    val after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
      [@@js.get]

    val create :
         ?before:ThemableDecorationAttachmentRenderOptions.t
      -> ?after:ThemableDecorationAttachmentRenderOptions.t
      -> unit
      -> t
      [@@js.builder]]
end

module DecorationInstanceRenderOptions = struct
  include Interface.Make ()

  include
    [%js:
    val light : t -> ThemableDecorationInstanceRenderOptions.t or_undefined
      [@@js.get]

    val dark : t -> ThemableDecorationInstanceRenderOptions.t or_undefined
      [@@js.get]

    val create :
         ?light:ThemableDecorationInstanceRenderOptions.t
      -> ?dark:ThemableDecorationInstanceRenderOptions.t
      -> unit
      -> t
      [@@js.builder]]
end

module DecorationOptions = struct
  include Interface.Make ()

  type hoverMessage =
    ([ `MarkdownString of MarkdownString.t
     | `MarkdownStrings of MarkdownString.t list
     ]
    [@js.union])
  [@@js]

  let hoverMessage_of_js js_val =
    if Ojs.has_property js_val "value" then
      `MarkdownString ([%js.to: MarkdownString.t] js_val)
    else `MarkdownStrings ([%js.to: MarkdownString.t list] js_val)

  include
    [%js:
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
      [@@js.builder]]
end

module SnippetString = struct
  include Class.Make ()

  include
    [%js:
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
      -> defaultValue:
           ([ `String of string | `Function of t -> unit ][@js.union])
      -> t
      [@@js.call]]
end

module TextEditor = struct
  include Interface.Make ()

  type insertSnippetLocation =
    ([ `Position of Position.t
     | `Range of Range.t
     | `Positions of Position.t list
     | `Ranges of Range.t list
     ]
    [@js.union])
  [@@js]

  include
    [%js:
    val document : t -> TextDocument.t [@@js.get]

    val selection : t -> Selection.t [@@js.get]

    val set_selection : t -> Selection.t -> unit [@@js.set "selection"]

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

    val insertSnippet :
         t
      -> snippet:SnippetString.t
      -> ?location:insertSnippetLocation
      -> Ojs.t
      -> bool Promise.t
      [@@js.call]

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
      [@@js.call]]

  let edit this ~callback ?undoStopBefore ?undoStopAfter () =
    let options = Ojs.obj [||] in
    iter_set options "undoStopBefore" [%js.of: bool] undoStopBefore;
    iter_set options "undoStopAfter" [%js.of: bool] undoStopAfter;
    edit this ~callback options ()

  let insertSnippet this ~snippet ?location ?undoStopBefore ?undoStopAfter () =
    let options = Ojs.obj [||] in
    iter_set options "undoStopBefore" [%js.of: bool] undoStopBefore;
    iter_set options "undoStopAfter" [%js.of: bool] undoStopAfter;
    insertSnippet this ~snippet ?location options
end

module ConfigurationTarget = struct
  type t =
    | Global [@js 1]
    | Workspace [@js 2]
    | WorkspaceFolder [@js 3]
  [@@js.enum] [@@js]
end

module WorkspaceConfiguration = struct
  include Interface.Make ()

  type 'a inspectResult =
    { key : string
    ; defaultValue : 'a or_undefined
    ; globalValue : 'a or_undefined
    ; workspaceValue : 'a or_undefined
    ; workspaceFolderValue : 'a or_undefined
    ; defaultLanguageValue : 'a or_undefined
    ; globalLanguageValue : 'a or_undefined
    ; workspaceLanguageValue : 'a or_undefined
    ; workspaceFolderLanguageValue : 'a or_undefined
    ; languageIds : string list or_undefined
    }

  let inspectResult_of_js (type t) t_of_js js_val : t inspectResult =
    let field = Ojs.get_prop_ascii js_val in
    { key = [%js.to: string] (field "key")
    ; defaultValue = [%js.to: t or_undefined] (field "defaultValue")
    ; globalValue = [%js.to: t or_undefined] (field "globalValue")
    ; workspaceValue = [%js.to: t or_undefined] (field "workspaceValue")
    ; workspaceFolderValue =
        [%js.to: t or_undefined] (field "workspaceFolderValue")
    ; defaultLanguageValue =
        [%js.to: t or_undefined] (field "defaultLanguageValue")
    ; globalLanguageValue =
        [%js.to: t or_undefined] (field "globalLanguageValue")
    ; workspaceLanguageValue =
        [%js.to: t or_undefined] (field "workspaceLanguageValue")
    ; workspaceFolderLanguageValue =
        [%js.to: t or_undefined] (field "workspaceFolderLanguageValue")
    ; languageIds = [%js.to: string list or_undefined] (field "languageIds")
    }

  include
    [%js:
    val get : t -> section:string -> Js.Any.t or_undefined [@@js.call]

    val get_default : t -> section:string -> defaultValue:Ojs.t -> Ojs.t
      [@@js.call]

    val has : t -> section:string -> bool [@@js.call]

    val inspect : t -> section:string -> Ojs.t [@@js.call]

    val update :
         t
      -> section:string
      -> value:Js.Any.t
      -> ?configurationTarget:
           ([ `ConfigurationTarget of ConfigurationTarget.t | `Bool of bool ]
           [@js.union])
      -> ?overrideInLanguage:bool
      -> unit
      -> Promise.void
      [@@js.call]]

  let inspect (type a) (module T : Js.T with type t = a) this ~section :
      a inspectResult or_undefined =
    [%js.to: T.t inspectResult or_undefined] (inspect this ~section)

  let get_default (type a) (module T : Js.T with type t = a) this ~section
      ~(defaultValue : a) : a =
    let defaultValue = [%js.of: T.t] defaultValue in
    [%js.to: T.t] (get_default this ~section ~defaultValue)
end

module WorkspaceEdit = struct
  include Class.Make ()

  include
    [%js:
    val size : t -> int [@@js.get]

    val replace :
         t
      -> uri:Uri.t
      -> range:Range.t
      -> newText:string (*TODO ->?metadata:WorkspaceEditEntryMetadata.t*)
      -> unit
      [@@js.call]

    val make : unit -> t [@@js.new "vscode.WorkspaceEdit"]]
end

module StatusBarAlignment = struct
  type t =
    | Left [@js 1]
    | Right [@js 2]
  [@@js.enum] [@@js]
end

module AccessibilityInformation = struct
  include Interface.Make ()

  include
    [%js:
    val label : t -> string [@@js.get]

    val role : t -> string or_undefined [@@js.get]

    val create : label:string -> ?role:string -> unit -> t [@@js.builder]]
end

module StatusBarItem = struct
  include Interface.Make ()

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

  include
    [%js:
    val alignment : t -> StatusBarAlignment.t [@@js.get]

    val priority : t -> int or_undefined [@@js.get]

    val text : t -> string [@@js.get]

    val tooltip : t -> string or_undefined [@@js.get]

    val color : t -> color or_undefined [@@js.get]

    val backgroundColor : t -> ThemeColor.t or_undefined [@@js.get]

    val command : t -> command or_undefined [@@js.get]

    val accessibilityInformation : t -> AccessibilityInformation.t or_undefined
      [@@js.get]

    val set_alignment : t -> StatusBarAlignment.t -> unit [@@js.set "alignment"]

    val set_priority : t -> int -> unit [@@js.set]

    val set_text : t -> string -> unit [@@js.set]

    val set_tooltip : t -> string -> unit [@@js.set]

    val set_color : t -> color -> unit [@@js.set]

    val set_backgroundColor : t -> ThemeColor.t -> unit [@@js.set]

    val set_command : t -> command -> unit [@@js.set]

    val set_accessibilityInformation : t -> AccessibilityInformation.t -> unit
      [@@js.set]

    val show : t -> unit [@@js.call]

    val hide : t -> unit [@@js.call]

    val dispose : t -> unit [@@js.call]]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)
end

module WorkspaceFoldersChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
    val added : t -> WorkspaceFolder.t list [@@js.get]

    val removed : t -> WorkspaceFolder.t list [@@js.get]

    val create :
      added:WorkspaceFolder.t list -> removed:WorkspaceFolder.t list -> t
      [@@js.builder]]
end

module FormattingOptions = struct
  include Interface.Make ()

  include
    [%js:
    val tabSize : t -> int [@@js.get]

    val insertSpaces : t -> bool [@@js.get]

    val create : tabSize:int -> insertSpaces:bool -> t [@@js.builder]]
end

module Event = struct
  type 'a t =
       listener:('a -> unit)
    -> ?thisArgs:Js.Any.t
    -> ?disposables:Disposable.t list
    -> unit
    -> Disposable.t

  module Make (T : Js.T) = struct
    type t =
         listener:(T.t -> unit)
      -> ?thisArgs:Js.Any.t
      -> ?disposables:Disposable.t list
      -> unit
      -> Disposable.t
    [@@js]
  end
end

module EventEmitter = struct
  include Class.Generic (Ojs) ()

  module Make (T : Js.T) = struct
    type t = T.t generic [@@js]

    module Event = Event.Make (T)

    include
      [%js:
      val make : unit -> t [@@js.new "vscode.EventEmitter"]

      val event : t -> Event.t [@@js.get]

      val fire : t -> T.t -> unit [@@js.call]

      val dispose : t -> unit -> unit [@@js.call]]
  end
end

module CancellationToken = struct
  include Interface.Make ()

  module OnCancellationRequested = Event.Make (Js.Any)

  include
    [%js:
    val isCancellationRequested : t -> bool [@@js.get]

    val onCancellationRequested : t -> OnCancellationRequested.t [@@js.get]

    val create :
         isCancellationRequested:bool
      -> onCancellationRequested:OnCancellationRequested.t
      -> t
      [@@js.builder]]
end

module QuickPickItem = struct
  include Interface.Make ()

  include
    [%js:
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
      [@@js.builder]]
end

module QuickPickOptions = struct
  include Interface.Make ()

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

  include
    [%js:
    val title : t -> string or_undefined [@@js.get]

    val matchOnDescription : t -> bool or_undefined [@@js.get]

    val matchOnDetail : t -> bool or_undefined [@@js.get]

    val placeHolder : t -> string or_undefined [@@js.get]

    val ignoreFocusOut : t -> bool or_undefined [@@js.get]

    val canPickMany : t -> bool or_undefined [@@js.get]

    val onDidSelectItem : t -> (onDidSelectItemArgs -> unit) or_undefined
      [@@js.get]

    val create :
         ?title:string
      -> ?matchOnDescription:bool
      -> ?matchOnDetail:bool
      -> ?placeHolder:string
      -> ?ignoreFocusOut:bool
      -> ?canPickMany:bool
      -> ?onDidSelectItem:(item:onDidSelectItemArgs -> unit)
      -> unit
      -> t
      [@@js.builder]]
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
    else `Value (or_undefined_of_js ml_of_js js_val)
end

module InputBoxOptions = struct
  include Interface.Make ()

  include
    [%js:
    val title : t -> string or_undefined [@@js.get]

    val value : t -> string or_undefined [@@js.get]

    val valueSelection : t -> (int * int) or_undefined [@@js.get]

    val prompt : t -> string or_undefined [@@js.get]

    val placeHolder : t -> string or_undefined [@@js.get]

    val password : t -> bool or_undefined [@@js.get]

    val ignoreFocusOut : t -> bool or_undefined [@@js.get]

    val validateInput : t -> (string -> string ProviderResult.t) or_undefined
      [@@js.get]

    val create :
         ?title:string
      -> ?value:string
      -> ?valueSelection:int * int
      -> ?prompt:string
      -> ?placeHolder:string
      -> ?password:bool
      -> ?ignoreFocusOut:bool
      -> ?validateInput:(value:string -> string option Promise.t)
      -> unit
      -> t
      [@@js.builder]]
end

module MessageItem = struct
  include Interface.Make ()

  include
    [%js:
    val title : t -> string [@@js.get]

    val isCloseAffordance : t -> bool or_undefined [@@js.get]

    val create : title:string -> ?isCloseAffordance:bool -> unit -> t
      [@@js.builder]]
end

module Location = struct
  include Class.Make ()

  include
    [%js:
    val uri : t -> Uri.t [@@js.get]

    val range : t -> Range.t [@@js.get]

    val make :
         uri:Uri.t
      -> rangeOrPosition:
           ([ `Range of Range.t | `Position of Position.t ][@js.union])
      -> t
      [@@js.new "vscode.Location"]]
end

module ProgressLocation = struct
  type t =
    | SourceControl [@js 1]
    | Window [@js 10]
    | Notification [@js 15]
  [@@js.enum] [@@js]
end

module ProgressOptions = struct
  include Interface.Make ()

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

  include
    [%js:
    val location : t -> location [@@js.get]

    val title : t -> string or_undefined [@@js.get]

    val cancellable : t -> bool or_undefined [@@js.get]

    val create :
      location:location -> ?title:string -> ?cancellable:bool -> unit -> t
      [@@js.builder]]
end

module DiagnosticSeverity = struct
  type t =
    | Error [@js 0]
    | Hint [@js 1]
    | Information [@js 2]
    | Warning [@js 3]
  [@@js.enum] [@@js]
end

module DiagnosticRelatedInformation = struct
  include Class.Make ()

  include
    [%js:
    val location : t -> Location.t [@@js.get]

    val message : t -> string [@@js.get]

    val make : location:Location.t -> message:string -> t
      [@@js.new "vscode.DiagnosticRelatedInformation"]]
end

module DiagnosticTag = struct
  type t =
    | Unnecessary [@js 1]
    | Deprecated [@js 2]
  [@@js.enum] [@@js]
end

module Diagnostic = struct
  include Class.Make ()

  type string_or_int =
    ([ `String of string
     | `Int of int
     ]
    [@js.union])
  [@@js]

  let string_or_int_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String ([%js.to: string] js_val)
    | "number" -> `Int ([%js.to: int] js_val)
    | _ -> assert false

  type code_target =
    { value : string_or_int
    ; target : Uri.t
    }
  [@@js]

  type code =
    ([ `String of string
     | `Int of int
     | `Targeted of code_target
     ]
    [@js.union])
  [@@js]

  let code_of_js js_val =
    match Ojs.type_of js_val with
    | "object" -> `Targeted ([%js.to: code_target] js_val)
    | _ -> string_or_int_of_js js_val

  include
    [%js:
    val message : t -> string [@@js.get]

    val range : t -> Range.t [@@js.get]

    val severity : t -> DiagnosticSeverity.t [@@js.get]

    val source : t -> string or_undefined [@@js.get]

    val code : t -> code or_undefined [@@js.get]

    val relatedInformation :
      t -> DiagnosticRelatedInformation.t list or_undefined
      [@@js.get]

    val tags : t -> DiagnosticTag.t list or_undefined [@@js.get]

    val make :
         range:Range.t
      -> message:string
      -> ?severity:DiagnosticSeverity.t
      -> unit
      -> t
      [@@js.new "vscode.Diagnostic"]]

  let make ?severity ~message range = make ~range ~message ?severity ()
end

module TextDocumentShowOptions = struct
  include Interface.Make ()

  include
    [%js:
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
      [@@js.builder]]
end

module TerminalOptions = struct
  include Interface.Make ()

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

  include
    [%js:
    val name : t -> string or_undefined [@@js.get]

    val shellPath : t -> string or_undefined [@@js.get]

    val shellArgs : t -> shellArgs or_undefined [@@js.get]

    val cwd : t -> cwd or_undefined [@@js.get]

    val env : t -> string or_undefined Dict.t or_undefined [@@js.get]

    val strictEnv : t -> bool [@@js.get]

    val hideFromUser : t -> bool [@@js.get]]
end

module TerminalDimensions = struct
  include Interface.Make ()

  include
    [%js:
    val columns : t -> int [@@js.get]

    val rows : t -> int [@@js.get]

    val create : columns:int -> rows:int -> t [@@js.builder]]
end

module Pseudoterminal = struct
  include Interface.Make ()

  module OnDidWrite = Event.Make (Js.String)
  module OnDidOverrideDimensions =
    Event.Make (Js.Or_undefined (TerminalDimensions))
  module OnDidClose = Event.Make (Js.Or_undefined (Js.Int))

  include
    [%js:
    val onDidWrite : t -> OnDidWrite.t [@@js.get]

    val onDidOverrideDimensions : t -> OnDidOverrideDimensions.t or_undefined
      [@@js.get]

    val onDidClose : t -> OnDidClose.t or_undefined [@@js.get]

    val open_ : t -> ?initialDimensions:TerminalDimensions.t -> unit -> unit
      [@@js.call]

    val close : t -> unit [@@js.call]

    val handleInput : t -> (data:string -> unit) or_undefined [@@js.get]

    val setDimensions :
      t -> (dimensions:TerminalDimensions.t -> unit) or_undefined
      [@@js.get]

    val create :
         onDidWrite:OnDidWrite.t
      -> ?onDidOverrideDimensions:OnDidOverrideDimensions.t
      -> ?onDidClose:OnDidClose.t
      -> open_:(?initialDimensions:TerminalDimensions.t -> unit -> unit)
      -> close:(unit -> unit)
      -> ?handleInput:(data:string -> unit)
      -> ?setDimensions:(dimensions:TerminalDimensions.t -> unit)
      -> unit
      -> t
      [@@js.builder]]
end

module ExtensionTerminalOptions = struct
  include Interface.Make ()

  include
    [%js:
    val name : t -> string [@@js.get]

    val pty : t -> Pseudoterminal.t [@@js.get]

    val create : name:string -> pty:Pseudoterminal.t -> t [@@js.builder]]
end

module Extension = struct
  include Interface.Make ()
end

module Extensions = struct
  include
    [%js:
    val getExtension : string -> Extension.t or_undefined
      [@@js.global "vscode.extensions.getExtension"]]
end

module TerminalExitStatus = struct
  include Interface.Make ()

  include
    [%js:
    val code : t -> int [@@js.get]

    val create : code:int -> t [@@js.builder]]
end

module Terminal = struct
  include Interface.Make ()

  type creationOptions =
    ([ `TerminalOptions of TerminalOptions.t
     | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
     ]
    [@js.union])
  [@@js]

  let creationOptions_of_js js_val =
    if Ojs.has_property js_val "pty" then
      `ExtensionTerminalOptions ([%js.to: ExtensionTerminalOptions.t] js_val)
    else `TerminalOptions ([%js.to: TerminalOptions.t] js_val)

  include
    [%js:
    val name : t -> string [@@js.get]

    val processId : t -> int or_undefined Promise.t [@@js.get]

    val creationOptions : t -> creationOptions [@@js.get]

    val exitStatus : t -> TerminalExitStatus.t or_undefined [@@js.get]

    val sendText : t -> text:string -> ?addNewLine:bool -> unit -> unit
      [@@js.call]

    val show : t -> ?preserveFocus:bool -> unit -> unit [@@js.call]

    val hide : t -> unit [@@js.call]

    val dispose : t -> unit [@@js.call]]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)
end

module OutputChannel = struct
  include Interface.Make ()

  include
    [%js:
    val name : t -> string [@@js.get]

    val append : t -> value:string -> unit [@@js.call]

    val appendLine : t -> value:string -> unit [@@js.call]

    val clear : t -> unit [@@js.call]

    val show : t -> ?preserveFocus:bool -> unit -> unit [@@js.call]

    val hide : t -> unit [@@js.call]

    val dispose : t -> unit [@@js.call]]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)
end

module Memento = struct
  include Interface.Make ()

  include
    [%js:
    val get : t -> key:string -> Js.Any.t or_undefined [@@js.call]

    val get_default : t -> key:string -> defaultValue:Ojs.t -> Ojs.t [@@js.call]

    val update : t -> key:string -> value:Js.Any.t -> Promise.void [@@js.call]]

  let get_default (type a) (module T : Js.T with type t = a) this ~key
      ~(defaultValue : a) : a =
    let defaultValue = [%js.of: T.t] defaultValue in
    [%js.to: T.t] (get_default this ~key ~defaultValue)
end

module EnvironmentVariableMutatorType = struct
  type t =
    | Replace [@js 1]
    | Append [@js 2]
    | Prepend [@js 3]
  [@@js.enum] [@@js]
end

module EnvironmentVariableMutator = struct
  include Interface.Make ()

  include
    [%js:
    val type_ : t -> EnvironmentVariableMutatorType.t [@@js.get "type"]

    val value : t -> string [@@js.get]]
end

module EnvironmentVariableCollection = struct
  include Interface.Make ()

  include
    [%js:
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

    val clear : t -> unit [@@js.call]]
end

module ExtensionMode = struct
  type t =
    | Production [@js 1]
    | Development [@js 2]
    | Test [@js 3]
  [@@js.enum] [@@js]
end

module SecretStorageChangeEvent = struct
  include Interface.Make ()

  include [%js: val key : t -> string [@@js.get]]
end

module SecretStorage = struct
  include Interface.Make ()

  module OnDidChange = Event.Make (SecretStorageChangeEvent)

  include
    [%js:
    val get : t -> key:string -> string or_undefined Promise.t [@@js.call]

    val store : t -> key:string -> value:string -> Promise.void [@@js.call]

    val delete : t -> key:string -> Promise.void [@@js.call]

    val onDidChange : t -> OnDidChange.t [@@js.get]]
end

module ExtensionContext = struct
  include Interface.Make ()

  include
    [%js:
    val subscriptions : t -> Disposable.t list [@@js.get]

    val workspaceState : t -> Memento.t [@@js.get]

    val globalState : t -> Memento.t [@@js.get]

    val secrets : t -> SecretStorage.t [@@js.get]

    val extensionUri : t -> Uri.t [@@js.get]

    val extensionPath : t -> string [@@js.get]

    val environmentVariableCollection : t -> EnvironmentVariableCollection.t
      [@@js.get]

    val asAbsolutePath : t -> relativePath:string -> string [@@js.call]

    val storageUri : t -> Uri.t or_undefined [@@js.get]

    val globalStorageUri : t -> Uri.t [@@js.get]

    val logUri : t -> Uri.t [@@js.get]

    val extensionMode : t -> ExtensionMode.t [@@js.get]]

  let subscribe this ~disposable =
    let subscriptions = Ojs.get_prop_ascii ([%js.of: t] this) "subscriptions" in
    let (_ : Ojs.t) =
      Ojs.call subscriptions "push" [| [%js.of: Disposable.t] disposable |]
    in
    ()
end

module ShellQuotingOptions = struct
  include Interface.Make ()

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

  include
    [%js:
    val escape : t -> escape or_undefined [@@js.get]

    val strong : t -> string or_undefined [@@js.get]

    val weak : t -> string or_undefined [@@js.get]

    val create : ?escape:escape -> ?strong:string -> ?weak:string -> unit -> t
      [@@js.builder]]
end

module ShellExecutionOptions = struct
  include Interface.Make ()

  include
    [%js:
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
      [@@js.builder]]
end

module ShellQuoting = struct
  type t =
    | Escape [@js 1]
    | Strong [@js 2]
    | Weak [@js 3]
  [@@js.enum] [@@js]
end

module ShellQuotedString = struct
  include Interface.Make ()

  include
    [%js:
    val value : t -> string [@@js.get]

    val quoting : t -> ShellQuoting.t [@@js.get]

    val create : value:string -> quoting:ShellQuoting.t -> t [@@js.builder]]
end

module ShellExecution = struct
  include Class.Make ()

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

  include
    [%js:
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

    val options : t -> ShellExecutionOptions.t or_undefined [@@js.get]]
end

module ProcessExecutionOptions = struct
  include Interface.Make ()

  include
    [%js:
    val cwd : t -> string or_undefined [@@js.get]

    val env : t -> string Dict.t or_undefined [@@js.get]

    val create : ?cwd:string -> ?env:string Dict.t -> unit -> t [@@js.builder]]
end

module ProcessExecution = struct
  include Class.Make ()

  include
    [%js:
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

    val options : t -> ProcessExecutionOptions.t or_undefined [@@js.get]]
end

module TaskDefinition = struct
  include Interface.Make ()

  include [%js: val type_ : t -> string [@@js.get]]

  let get_attribute t = Ojs.get_prop_ascii ([%js.of: t] t)

  let set_attribute t = Ojs.set_prop_ascii ([%js.of: t] t)

  let create ~type_ ?(attributes = []) () =
    let obj = Ojs.obj [| ("type", [%js.of: string] type_) |] in
    let set (key, value) = Ojs.set_prop_ascii obj key value in
    List.iter set attributes;
    [%js.to: t] obj
end

module CustomExecution = struct
  include Class.Make ()

  include
    [%js:
    val make :
         callback:
           (resolvedDefinition:TaskDefinition.t -> Pseudoterminal.t Promise.t)
      -> t
      [@@js.new "vscode.CustomExecution"]]
end

module RelativePattern = struct
  include Class.Make ()

  include
    [%js:
    val base : t -> string [@@js.get]

    val pattern : t -> string [@@js.get]

    val make :
         base:
           ([ `WorkspaceFolder of WorkspaceFolder.t
            | `Uri of Uri.t
            | `String of string
            ]
           [@js.union])
      -> pattern:string
      -> t
      [@@js.new "vscode.RelativePattern"]]
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
  include Interface.Make ()

  include
    [%js:
    val language : t -> string or_undefined [@@js.get]

    val scheme : t -> string or_undefined [@@js.get]

    val pattern : t -> GlobPattern.t or_undefined [@@js.get]

    val create :
      ?language:string -> ?scheme:string -> ?pattern:GlobPattern.t -> unit -> t
      [@@js.builder]]
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
    if Ojs.type_of js_val = "string" then `String ([%js.to: string] js_val)
    else if Ojs.has_property js_val "length" then
      `List ([%js.to: selector list] js_val)
    else `Filter ([%js.to: DocumentFilter.t] js_val)
end

module DocumentFormattingEditProvider = struct
  include Interface.Make ()

  include
    [%js:
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
      [@@js.builder]]
end

module Hover = struct
  include Interface.Make ()

  include
    [%js:
    val contents : t -> MarkdownString.t [@@js.get]

    val range : t -> Range.t or_undefined [@@js.get]

    val make :
         contents:
           ([ `MarkdownString of MarkdownString.t
            | `MarkdownStringArray of MarkdownString.t list
            ]
           [@js.union])
      -> t
      [@@js.new "vscode.Hover"]]
end

module HoverProvider = struct
  include Interface.Make ()

  include
    [%js:
    val provideHover :
         t
      -> document:TextDocument.t
      -> position:Position.t
      -> token:CancellationToken.t
      -> Hover.t ProviderResult.t
      [@@js.call]

    val create :
         provideHover:
           (   document:TextDocument.t
            -> position:Position.t
            -> token:CancellationToken.t
            -> Hover.t ProviderResult.t)
      -> t
      [@@js.builder]]
end

module TaskGroup = struct
  include Class.Make ()

  include
    [%js:
    val clean : t [@@js.global "vscode.TaskGroup.Clean"]

    val build : t [@@js.global "vscode.TaskGroup.Build"]

    val rebuild : t [@@js.global "vscode.TaskGroup.Rebuild"]

    val test : t [@@js.global "vscode.TaskGroup.Test"]]
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
  include Interface.Make ()

  include
    [%js:
    val reevaluateOnRerun : t -> bool or_undefined [@@js.get]

    val create : ?reevaluateOnRerun:bool -> unit -> t [@@js.builder]]
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
  include Interface.Make ()

  include
    [%js:
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
      [@@js.builder]]
end

module Task = struct
  include Class.Make ()

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
    else `CustomExecution ([%js.to: CustomExecution.t] js_val)

  include
    [%js:
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

    val set_group : t -> TaskGroup.t -> unit [@@js.set]]
end

module TaskProvider = struct
  include Interface.Generic (Ojs) ()

  module Make (T : Js.T) = struct
    type t = T.t generic [@@js]

    include
      [%js:
      val provideTasks :
        t -> token:CancellationToken.t -> T.t list ProviderResult.t
        [@@js.call]

      val resolveTask :
        t -> task:T.t -> token:CancellationToken.t -> T.t ProviderResult.t
        [@@js.call]

      val create :
           provideTasks:(token:CancellationToken.t -> T.t list ProviderResult.t)
        -> resolveTask:
             (task:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
        -> t
        [@@js.builder]]
  end

  module Default = Make (Task)
end

module ConfigurationScope = struct
  type t =
    ([ `Uri of Uri.t
     | `TextDocument of TextDocument.t
     | `WorkspaceFolder of WorkspaceFolder.t
     ]
    [@js.union])
  [@@js]

  let t_of_js js_val =
    if Ojs.has_property js_val "path" then `Uri ([%js.to: Uri.t] js_val)
    else if Ojs.has_property js_val "index" then
      `WorkspaceFolder ([%js.to: WorkspaceFolder.t] js_val)
    else `TextDocument ([%js.to: TextDocument.t] js_val)
end

module MessageOptions = struct
  include Interface.Make ()

  include
    [%js:
    val modal : t -> bool or_undefined [@@js.get]

    val create : ?modal:bool -> unit -> t [@@js.builder]]
end

module Progress = struct
  include Interface.Make ()

  type value =
    { message : string or_undefined
    ; increment : int or_undefined
    }
  [@@js]

  include [%js: val report : t -> value:value -> unit [@@js.call]]
end

module TextDocumentContentChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
    val range : t -> Range.t [@@js.get]

    val rangeLength : t -> int [@@js.get]

    val rangeOffset : t -> int [@@js.get]

    val text : t -> string [@@js.get]]
end

module TextDocumentChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
    val contentChanges : t -> TextDocumentContentChangeEvent.t list [@@js.get]

    val document : t -> TextDocument.t [@@js.get]]
end

module TextDocumentContentProvider = struct
  include Interface.Make ()

  module OnDidChange = Event.Make (Uri)

  include
    [%js:
    val onDidChange : t -> OnDidChange.t or_undefined [@@js.get]

    val provideTextDocumentContent :
      t -> uri:Uri.t -> token:CancellationToken.t -> string ProviderResult.t
      [@@js.call]

    val create :
         ?onDidChange:OnDidChange.t
      -> provideTextDocumentContent:
           (uri:Uri.t -> token:CancellationToken.t -> string ProviderResult.t)
      -> unit
      -> t
      [@@js.builder]]
end

module FileSystemWatcher = struct
  include Interface.Make ()

  module OnDidChange = Event.Make (Uri)

  include [%js: val onDidChange : t -> OnDidChange.t [@@js.get]]
end

module Workspace = struct
  module OnDidChangeWorkspaceFolders = Event.Make (WorkspaceFolder)
  module OnDidOpenTextDocument = Event.Make (TextDocument)
  module OnDidCloseTextDocument = Event.Make (TextDocument)
  module OnDidSaveTextDocument = Event.Make (TextDocument)
  module OnDidChangeTextDocument = Event.Make (TextDocumentChangeEvent)

  type textDocumentOptions =
    { language : string
    ; content : string
    }
  [@@js]

  type workspaceFolderToAdd =
    { name : string
    ; uri : Uri.t
    }
  [@@js]

  include
    [%js:
    val workspaceFolders : unit -> WorkspaceFolder.t maybe_list
      [@@js.get "vscode.workspace.workspaceFolders"]

    val name : unit -> string or_undefined [@@js.get "vscode.workspace.name"]

    val createFileSystemWatcher :
         GlobPattern.t
      -> ?ignoreCreateEvents:(bool[@js.default false])
      -> ?ignoreChangeEvents:(bool[@js.default false])
      -> ?ignoreDeleteEvents:(bool[@js.default false])
      -> unit
      -> FileSystemWatcher.t
      [@@js.global "vscode.workspace.createFileSystemWatcher"]

    val workspaceFile : unit -> Uri.t or_undefined
      [@@js.get "vscode.workspace.workspaceFile"]

    val rootPath : unit -> string or_undefined
      [@@js.get "vscode.workspace.rootPath"]

    val textDocuments : unit -> TextDocument.t list
      [@@js.get "vscode.workspace.textDocuments"]

    val onDidChangeWorkspaceFolders : OnDidChangeWorkspaceFolders.t
      [@@js.global "vscode.workspace.onDidChangeWorkspaceFolders"]

    val getWorkspaceFolder : uri:Uri.t -> WorkspaceFolder.t or_undefined
      [@@js.global "vscode.workspace.getWorkspaceFolder"]

    val onDidOpenTextDocument : OnDidOpenTextDocument.t
      [@@js.global "vscode.workspace.onDidOpenTextDocument"]

    val onDidSaveTextDocument : OnDidSaveTextDocument.t
      [@@js.global "vscode.workspace.onDidSaveTextDocument"]

    val onDidCloseTextDocument : OnDidCloseTextDocument.t
      [@@js.global "vscode.workspace.onDidCloseTextDocument"]

    val onDidChangeTextDocument : OnDidChangeTextDocument.t
      [@@js.global "vscode.workspace.onDidChangeTextDocument"]

    val applyEdit : edit:WorkspaceEdit.t -> bool Promise.t
      [@@js.global "vscode.workspace.applyEdit"]

    val registerTextDocumentContentProvider :
      scheme:string -> provider:TextDocumentContentProvider.t -> Disposable.t
      [@@js.global "vscode.workspace.registerTextDocumentContentProvider"]

    val asRelativePath :
         pathOrUri:([ `String of string | `Uri of Uri.t ][@js.union])
      -> ?includeWorkspaceFolder:bool
      -> unit
      -> string
      [@@js.global "vscode.workspace.asRelativePath"]

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

    val openTextDocument :
         ([ `Uri of Uri.t
          | `Filename of string
          | `Interactive of textDocumentOptions or_undefined
          ]
         [@js.union])
      -> TextDocument.t Promise.t
      [@@js.global "vscode.workspace.openTextDocument"]

    val updateWorkspaceFolders :
         start:int
      -> deleteCount:int or_undefined
      -> workspaceFoldersToAdd:(workspaceFolderToAdd list[@js.variadic])
      -> bool
      [@@js.global "vscode.workspace.updateWorkspaceFolders"]]
end

module TreeItemCollapsibleState = struct
  type t =
    | None [@js 0]
    | Collapsed [@js 1]
    | Expanded [@js 2]
  [@@js.enum] [@@js]
end

module CustomDocument = struct
  module type T = sig
    include Js.T

    val uri : t -> Uri.t

    val dispose : t -> unit
  end

  include Interface.Make ()

  include
    [%js:
    val uri : t -> Uri.t [@@js.get]

    val dispose : t -> unit [@@js.call]

    val create : uri:Uri.t -> dispose:(unit -> unit) -> t [@@js.builder]]
end

module TreeItemLabel = struct
  include Interface.Make ()

  include
    [%js:
    val label : t -> string [@@js.get]

    val highlights : t -> (int * int) list or_undefined [@@js.get]

    val create : label:string -> ?highlights:(int * int) list -> unit -> t
      [@@js.builder]]
end

module ThemeIcon = struct
  include Class.Make ()

  include
    [%js:
    val make : id:string -> ?color:ThemeColor.t -> unit -> t
      [@@js.new "vscode.ThemeIcon"]

    val file : t [@@js.global "vscode.ThemeIcon.File"]

    val folder : t [@@js.global "vscode.ThemeIcon.Folder"]

    val id : t -> string [@@js.get]

    val color : t -> ThemeColor.t or_undefined [@@js.get]]
end

module TreeItem = struct
  include Class.Make ()

  type label =
    ([ `String of string
     | `TreeItemLabel of TreeItemLabel.t
     ]
    [@js.union])
  [@@js]

  let label_of_js js_val =
    if Ojs.type_of js_val = "string" then `String ([%js.to: string] js_val)
    else if Ojs.has_property js_val "label" then
      `TreeItemLabel ([%js.to: TreeItemLabel.t] js_val)
    else assert false

  module LightDarkIcon = struct
    type t =
      { light : ([ `String of string | `Uri of Uri.t ][@js.union])
      ; dark : ([ `String of string | `Uri of Uri.t ][@js.union])
      }
    [@@js]

    let t_of_js js_val =
      let light_js = Ojs.get_prop_ascii js_val "light" in
      let dark_js = Ojs.get_prop_ascii js_val "dark" in
      let light =
        if Ojs.has_property light_js "parse" then
          `Uri ([%js.to: Uri.t] light_js)
        else `String ([%js.to: string] light_js)
      in
      let dark =
        if Ojs.has_property dark_js "parse" then `Uri ([%js.to: Uri.t] dark_js)
        else `String ([%js.to: string] dark_js)
      in
      { light; dark }
  end

  type iconPath =
    ([ `String of string
     | `Uri of Uri.t
     | `LightDark of LightDarkIcon.t
     | `ThemeIcon of ThemeIcon.t
     ]
    [@js.union])
  [@@js]

  let iconPath_of_js js_val =
    if Ojs.has_property js_val "path" then `Uri ([%js.to: Uri.t] js_val)
    else if Ojs.has_property js_val "id" then
      `ThemeIcon ([%js.to: ThemeIcon.t] js_val)
    else if Ojs.type_of js_val = "string" then `String ([%js.to: string] js_val)
    else if Ojs.has_property js_val "light" then
      `LightDark ([%js.to: LightDarkIcon.t] js_val)
    else assert false

  type description =
    ([ `String of string
     | `Bool of bool
     ]
    [@js.union])
  [@@js]

  let description_of_js js_val =
    match Ojs.type_of js_val with
    | "boolean" -> `Bool ([%js.to: bool] js_val)
    | "string" -> `String ([%js.to: string] js_val)
    | _ -> assert false

  type tooltip =
    ([ `String of string
     | `MarkdownString of MarkdownString.t
     | `Undefined
     ]
    [@js.union])
  [@@js]

  let tooltip_of_js js_val =
    if Ojs.type_of js_val = "string" then `String ([%js.to: string] js_val)
    else if Ojs.type_of js_val = "undefined" then `Undefined
    else if Ojs.has_property js_val "value" then
      `MarkdownString ([%js.to: MarkdownString.t] js_val)
    else assert false

  include
    [%js:
    val make_label :
      label:label -> ?collapsibleState:TreeItemCollapsibleState.t -> unit -> t
      [@@js.new "vscode.TreeItem"]

    val make_resource :
         resourceUri:Uri.t
      -> ?collapsibleState:TreeItemCollapsibleState.t
      -> unit
      -> t
      [@@js.new "vscode.TreeItem"]

    val label : t -> label or_undefined [@@js.get]

    val set_label : t -> label -> unit [@@js.set]

    val id : t -> string or_undefined [@@js.get]

    val set_id : t -> string -> unit [@@js.set]

    val iconPath : t -> iconPath or_undefined [@@js.get]

    val set_iconPath : t -> iconPath -> unit [@@js.set]

    val description : t -> description or_undefined [@@js.get]

    val set_description : t -> description -> unit [@@js.set]

    val resourceUri : t -> Uri.t or_undefined [@@js.get]

    val set_resourceUri : t -> Uri.t -> unit [@@js.set]

    val tooltip : t -> tooltip or_undefined [@@js.get]

    val set_tooltip : t -> tooltip -> unit [@@js.set]

    val collapsibleState : t -> TreeItemCollapsibleState.t or_undefined
      [@@js.get]

    val set_collapsibleState : t -> TreeItemCollapsibleState.t -> unit
      [@@js.set]

    val command : t -> Command.t or_undefined [@@js.get]

    val set_command : t -> Command.t -> unit [@@js.set]

    val contextValue : t -> string or_undefined [@@js.get]

    val set_contextValue : t -> string -> unit [@@js.set]

    val accessibilityInformation : t -> AccessibilityInformation.t or_undefined
      [@@js.get]

    val set_accessibilityInformation : t -> AccessibilityInformation.t -> unit
      [@@js.set]]
end

module TreeDataProvider = struct
  include Interface.Generic (Ojs) ()

  module Make (T : Js.T) = struct
    type t = T.t generic [@@js]

    module OnDidChangeTreeData = Event.Make (struct
      type t = T.t or_undefined [@@js]
    end)

    type getTreeItemResult =
      ([ `Value of TreeItem.t
       | `Promise of TreeItem.t Promise.t
       ]
      [@js.union])
    [@@js]

    let getTreeItemResult_of_js js_val =
      if Ojs.has_property js_val "then" then
        `Promise ([%js.to: TreeItem.t Promise.t] js_val)
      else `Value ([%js.to: TreeItem.t] js_val)

    include
      [%js:
      val onDidChangeTreeData : t -> OnDidChangeTreeData.t or_undefined
        [@@js.get]

      val getTreeItem : t -> element:T.t -> getTreeItemResult [@@js.call]

      val getChildren : t -> ?element:T.t -> unit -> T.t list ProviderResult.t
        [@@js.call]

      val getParent : t -> (element:T.t -> T.t ProviderResult.t) or_undefined
        [@@js.call]

      val resolveTreeItem :
           t
        -> (   item:TreeItem.t
            -> element:T.t
            -> token:CancellationToken.t
            -> TreeItem.t ProviderResult.t)
           or_undefined
        [@@js.call]

      val create :
           ?onDidChangeTreeData:OnDidChangeTreeData.t
        -> getTreeItem:(element:T.t -> getTreeItemResult)
        -> getChildren:(?element:T.t -> unit -> T.t list ProviderResult.t)
        -> ?getParent:(element:T.t -> T.t ProviderResult.t)
        -> ?resolveTreeItem:
             (   item:TreeItem.t
              -> element:T.t
              -> token:CancellationToken.t
              -> TreeItem.t ProviderResult.t)
        -> unit
        -> t
        [@@js.builder]]
  end
end

module TreeViewOptions = struct
  include Class.Generic (Ojs) ()

  module Make (T : Js.T) = struct
    type t = T.t generic [@@js]

    module TreeDataProvider = TreeDataProvider.Make (T)

    include
      [%js:
      val treeDataProvider : t -> TreeDataProvider.t [@@js.get]

      val showCollapseAll : t -> bool or_undefined [@@js.get]

      val canSelectMany : t -> bool or_undefined [@@js.get]]
  end
end

module TreeViewExpansionEvent = struct
  include Interface.Generic (Ojs) ()

  module Make (T : Js.T) = struct
    type t = T.t generic [@@js]

    include
      [%js:
      val element : t -> T.t [@@js.get]

      val create : element:T.t -> t [@@js.builder]]
  end
end

module TreeViewSelectionChangeEvent = struct
  include Interface.Generic (Ojs) ()

  module Make (T : Js.T) = struct
    type t = T.t generic [@@js]

    include
      [%js:
      val selection : t -> T.t list [@@js.get]

      val create : selection:T.t list -> t [@@js.builder]]
  end
end

module TreeViewVisibilityChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
    val visible : t -> bool [@@js.get]

    val create : visible:bool -> t [@@js.builder]]
end

module TreeView = struct
  include Class.Generic (Disposable) ()

  module Make (T : Js.T) = struct
    type t = T.t generic [@@js]

    module OnDidExpandElement = Event.Make (TreeViewExpansionEvent.Make (T))
    module OnDidCollapseElement = Event.Make (TreeViewExpansionEvent.Make (T))
    module OnDidChangeSelection =
      Event.Make (TreeViewSelectionChangeEvent.Make (T))
    module OnDidChangeVisibility = Event.Make (TreeViewVisibilityChangeEvent)

    include
      [%js:
      val onDidExpandElement : t -> OnDidExpandElement.t [@@js.get]

      val onDidCollapseElement : t -> OnDidCollapseElement.t [@@js.get]

      val selection : t -> T.t list [@@js.get]

      val onDidChangeSelection : t -> OnDidChangeSelection.t [@@js.get]

      val visible : t -> bool [@@js.get]

      val onDidChangeVisibility : t -> OnDidChangeVisibility.t [@@js.get]

      val message : t -> string or_undefined [@@js.get]

      val title : t -> string or_undefined [@@js.get]

      val description : t -> string or_undefined [@@js.get]

      val reveal : t -> element:T.t -> Ojs.t -> Promise.void [@@js.call]]

    let reveal this ~element ?select ?focus ?expand () =
      let options = Ojs.obj [||] in
      iter_set options "select" [%js.of: bool] select;
      iter_set options "focus" [%js.of: bool] focus;
      iter_set
        options
        "expand"
        [%js.of: ([ `Bool of bool | `Int of int ][@js.union])]
        expand;
      reveal this ~element options
  end
end

module WebviewPanelOptions = struct
  include Interface.Make ()

  include
    [%js:
    val enableFindWidget : t -> bool or_undefined [@@js.get]

    val retainContextWhenHidden : t -> bool or_undefined [@@js.get]]
end

module WebviewPortMapping = struct
  include Interface.Make ()

  include
    [%js:
    val extensionHostPort : t -> int [@@js.get]

    val webviewPort : t -> int [@@js.get]]
end

module WebviewOptions = struct
  include Interface.Make ()

  include
    [%js:
    val enableCommandUris : t -> bool option [@@js.get]

    val enableScripts : t -> bool option [@@js.get]

    val localResourceRoots : t -> Uri.t list option [@@js.get]

    val portMapping : t -> WebviewPortMapping.t list option [@@js.get]

    val create :
         ?enableCommandUris:bool
      -> ?enableScripts:bool
      -> ?localResourceRoots:Uri.t list
      -> ?portMapping:WebviewPortMapping.t list
      -> unit
      -> t
      [@@js.builder]]
end

module WebView = struct
  include Interface.Make ()

  module OnDidReceiveMessage = Event.Make (Js.Any)

  include
    [%js:
    val onDidReceiveMessage : t -> OnDidReceiveMessage.t [@@js.get]

    val cspSource : t -> string [@@js.get]

    val html : t -> string [@@js.get]

    val set_html : t -> string -> unit [@@js.set]

    val options : t -> WebviewOptions.t [@@js.get]

    val set_options : t -> WebviewOptions.t -> unit [@@js.set]

    val asWebviewUri : t -> localResource:Uri.t -> Uri.t [@@js.call]

    val postMessage : t -> Js.Any.t -> bool Promise.t [@@js.call]

    val create :
         onDidReceiveMessage:OnDidReceiveMessage.t
      -> cspSource:string
      -> html:string
      -> options:WebviewOptions.t
      -> close:(unit -> unit)
      -> asWebviewUri:(Uri.t -> Uri.t)
      -> postMessage:(Js.Any.t -> bool Promise.t)
      -> t
      [@@js.builder]]
end

module WebviewPanel = struct
  include Interface.Make ()

  module WebviewPanelOnDidChangeViewStateEvent = struct
    type webviewPanel = t [@@js]

    include Interface.Make ()

    include [%js: val webviewPanel : t -> webviewPanel [@@js.get]]
  end

  module LightDarkIcon = struct
    type t =
      { light : Uri.t
      ; dark : Uri.t
      }
    [@@js]
  end

  type iconPath =
    ([ `Uri of Uri.t
     | `LightDark of LightDarkIcon.t
     ]
    [@js.union])
  [@@js]

  module OnDidChangeViewState =
    Event.Make (WebviewPanelOnDidChangeViewStateEvent)
  module OnDidDispose = Event.Make (Js.Unit)

  include
    [%js:
    val onDidChangeViewState : t -> OnDidChangeViewState.t [@@js.get]

    val onDidDispose : t -> OnDidDispose.t [@@js.get]

    val active : t -> bool [@@js.get]

    val options : t -> WebviewPanelOptions.t [@@js.get]

    val title : t -> string [@@js.get]

    val viewColumn : t -> ViewColumn.t or_undefined [@@js.get]

    val viewType : t -> string [@@js.get]

    val visible : t -> bool [@@js.get]

    val webview : t -> WebView.t [@@js.get]

    val set_webview : t -> WebView.t -> unit [@@js.set]

    val dispose : t -> Js.Any.t [@@js.call]

    val reveal :
      t -> ?preserveFocus:bool -> ?viewColumn:ViewColumn.t -> unit -> unit
      [@@js.call]

    val create :
         onDidChangeViewState:OnDidChangeViewState.t
      -> onDidDispose:OnDidDispose.t
      -> active:bool
      -> options:WebviewPanelOptions.t
      -> title:string
      -> viewColumn:ViewColumn.t
      -> viewType:string
      -> visible:bool
      -> webview:WebView.t
      -> dispose:Js.Any.t
      -> reveal:
           (?preserveFocus:bool -> ?viewColumn:ViewColumn.t -> unit -> unit)
      -> t
      [@@js.builder]]
end

module CustomTextEditorProvider = struct
  include Interface.Make ()

  module ResolvedEditor = struct
    type t =
      ([ `Promise of Promise.void
       | `Unit of Js.Unit.t
       ]
      [@js.union])
    [@@js]

    let t_of_js js_val =
      if Ojs.is_null js_val then `Unit ([%js.to: Js.Unit.t] js_val)
      else `Promise ([%js.to: Promise.void] js_val)

    let t_to_js = function
      | `Unit v -> Js.Unit.t_to_js v
      | `Promise p -> Promise.void_to_js p
  end

  include
    [%js:
    val resolveCustomTextEditor :
         t
      -> document:TextDocument.t
      -> webviewPanel:WebviewPanel.t
      -> token:CancellationToken.t
      -> ResolvedEditor.t
      [@@js.call]

    val create :
         resolveCustomTextEditor:
           (   document:TextDocument.t
            -> webviewPanel:WebviewPanel.t
            -> token:CancellationToken.t
            -> ResolvedEditor.t)
      -> t
      [@@js.builder]]
end

module CustomDocumentOpenContext = struct
  include Interface.Make ()

  include [%js: val backupId : t -> string or_undefined [@@js.get]]
end

module CustomReadonlyEditorProvider = struct
  include Interface.Generic (Ojs) ()

  module Make (T : CustomDocument.T) = struct
    type t = T.t generic [@@js]

    include
      [%js:
      val openCustomDocument :
           t
        -> uri:Uri.t
        -> openContext:CustomDocumentOpenContext.t
        -> token:CancellationToken.t
        -> T.t Promise.t
        [@@js.call]

      val resolveCustomEditor :
           t
        -> document:T.t
        -> webviewPanel:WebviewPanel.t
        -> token:CancellationToken.t
        -> unit Promise.t
        [@@js.call]

      val create :
           resolveCustomEditor:
             (   document:T.t
              -> webviewPanel:WebviewPanel.t
              -> token:CancellationToken.t
              -> unit Promise.t)
        -> openCustomDocument:
             (   uri:Uri.t
              -> openContext:CustomDocumentOpenContext.t
              -> token:CancellationToken.t
              -> T.t Promise.t)
        -> t
        [@@js.builder]]
  end
end

module RegisterCustomEditorProviderOptions = struct
  include Interface.Make ()

  include
    [%js:
    val supportsMultipleEditorsPerDocument : t -> bool or_undefined [@@js.get]

    val create : ?supportsMultipleEditorsPerDocument:bool -> unit -> t
      [@@js.builder]]
end

module Window = struct
  module OnDidChangeActiveTextEditor = Event.Make (TextEditor)
  module OnDidChangeVisibleTextEditors = Event.Make (Js.List (TextEditor))
  module OnDidChangeActiveTerminal = Event.Make (Js.Or_undefined (Terminal))
  module OnDidOpenTerminal = Event.Make (Terminal)
  module OnDidCloseTerminal = Event.Make (Terminal)

  include
    [%js:
    val activeTextEditor : unit -> TextEditor.t or_undefined
      [@@js.get "vscode.window.activeTextEditor"]

    val visibleTextEditors : unit -> TextEditor.t list
      [@@js.get "vscode.window.visibleTextEditors"]

    val onDidChangeActiveTextEditor : unit -> OnDidChangeActiveTextEditor.t
      [@@js.get "vscode.window.onDidChangeActiveTextEditor"]

    val onDidChangeVisibleTextEditors : unit -> OnDidChangeVisibleTextEditors.t
      [@@js.get "vscode.window.onDidChangeVisibleTextEditors"]

    val terminals : unit -> Terminal.t list [@@js.get "vscode.window.terminals"]

    val activeTerminal : unit -> Terminal.t or_undefined
      [@@js.get "vscode.window.activeTerminal"]

    val onDidChangeActiveTerminal : unit -> OnDidChangeActiveTerminal.t
      [@@js.get "vscode.window.onDidChangeActiveTerminal"]

    val onDidOpenTerminal : unit -> OnDidOpenTerminal.t
      [@@js.get "vscode.window.onDidOpenTerminal"]

    val onDidCloseTerminal : unit -> OnDidCloseTerminal.t
      [@@js.get "vscode.window.onDidCloseTerminal"]

    val showTextDocument :
         document:
           ([ `TextDocument of TextDocument.t | `Uri of Uri.t ][@js.union])
      -> ?column:ViewColumn.t
      -> ?preserveFocus:bool
      -> unit
      -> TextEditor.t Promise.t
      [@@js.global "vscode.window.showTextDocument"]

    val showInformationMessage :
         message:string
      -> ?options:MessageOptions.t
      -> items:(MessageItem.t list[@js.variadic])
      -> unit
      -> MessageItem.t or_undefined Promise.t
      [@@js.global "vscode.window.showInformationMessage"]

    val showWarningMessage :
         message:string
      -> ?options:MessageOptions.t
      -> items:(MessageItem.t list[@js.variadic])
      -> unit
      -> MessageItem.t or_undefined Promise.t
      [@@js.global "vscode.window.showWarningMessage"]

    val showErrorMessage :
         message:string
      -> ?options:MessageOptions.t
      -> items:(MessageItem.t list[@js.variadic])
      -> unit
      -> MessageItem.t or_undefined Promise.t
      [@@js.global "vscode.window.showErrorMessage"]

    val showQuickPickItems :
         choices:QuickPickItem.t list
      -> ?options:QuickPickOptions.t
      -> ?token:CancellationToken.t
      -> unit
      -> QuickPickItem.t or_undefined Promise.t
      [@@js.global "vscode.window.showQuickPick"]

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

    val createOutputChannel : name:string -> OutputChannel.t
      [@@js.global "vscode.window.createOutputChannel"]

    val setStatusBarMessage :
         text:string
      -> ?hide:([ `AfterTimeout of int ][@js.union])
      -> unit
      -> Disposable.t
      [@@js.global "vscode.window.setStatusBarMessage"]

    val withProgress : options:ProgressOptions.t -> task:Ojs.t -> Ojs.t
      [@@js.global "vscode.window.withProgress"]

    val createStatusBarItem :
         ?alignment:StatusBarAlignment.t
      -> ?priority:int
      -> unit
      -> StatusBarItem.t
      [@@js.global "vscode.window.createStatusBarItem"]

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
            ]
           [@js.union])
      -> Terminal.t
      [@@js.global "vscode.window.createTerminal"]

    val registerTreeDataProvider :
      viewId:string -> treeDataProvider:Ojs.t -> Disposable.t
      [@@js.global "vscode.window.registerTreeDataProvider"]

    val createTreeView : viewId:string -> options:Ojs.t -> Ojs.t
      [@@js.global "vscode.window.createTreeView"]

    val createWebviewPanel :
         viewType:string
      -> title:string
      -> showOptions:ViewColumn.t
      -> WebviewPanel.t
      [@@js.global "vscode.window.createWebviewPanel"]

    val registerCustomTextEditorProvider :
         viewType:string
      -> provider:CustomTextEditorProvider.t
      -> ?options:RegisterCustomEditorProviderOptions.t
      -> unit
      -> Disposable.t
      [@@js.global "vscode.window.registerCustomEditorProvider"]

    val registerCustomReadonlyEditorProvider :
         viewType:string
      -> provider:Ojs.t
      -> ?options:RegisterCustomEditorProviderOptions.t
      -> unit
      -> Disposable.t
      [@@js.global "vscode.window.registerCustomEditorProvider"]]

  let getChoices choices =
    choices
    |> List.map (fun (title, choice) -> (MessageItem.create ~title (), choice))

  let showInformationMessage ~message ?options ?(choices = []) () =
    let choices = getChoices choices in
    let open Promise.Option.Syntax in
    let+ item =
      showInformationMessage ~message ?options ~items:(List.map fst choices) ()
    in
    List.assoc item choices

  let showWarningMessage ~message ?options ?(choices = []) () =
    let choices = getChoices choices in
    let open Promise.Option.Syntax in
    let+ item =
      showWarningMessage ~message ?options ~items:(List.map fst choices) ()
    in
    List.assoc item choices

  let showErrorMessage ~message ?options ?(choices = []) () =
    let choices = getChoices choices in
    let open Promise.Option.Syntax in
    let+ item =
      showErrorMessage ~message ?options ~items:(List.map fst choices) ()
    in
    List.assoc item choices

  let showQuickPickItems ~choices ?options ?token () =
    let open Promise.Option.Syntax in
    let+ item =
      showQuickPickItems ~choices:(List.map fst choices) ?options ?token ()
    in
    List.assoc item choices

  let withProgress (type a) (module T : Js.T with type t = a) ~options ~task :
      a Promise.t =
    let task =
      [%js.of:
        progress:Progress.t -> token:CancellationToken.t -> T.t Promise.t]
        task
    in
    [%js.to: T.t Promise.t] (withProgress ~options ~task)

  let registerTreeDataProvider (type a) (module T : Js.T with type t = a)
      ~(viewId : string) ~(treeDataProvider : a TreeDataProvider.t) :
      Disposable.t =
    let module TreeDataProvider = TreeDataProvider.Make (T) in
    let treeDataProvider = [%js.of: TreeDataProvider.t] treeDataProvider in
    registerTreeDataProvider ~viewId ~treeDataProvider

  let createTreeView (type a) (module T : Js.T with type t = a)
      ~(viewId : string) ~(options : a TreeViewOptions.t) : a TreeView.t =
    let module TreeViewOptions = TreeViewOptions.Make (T) in
    let module TreeView = TreeView.Make (T) in
    let options = [%js.of: TreeViewOptions.t] options in
    [%js.to: TreeView.t] (createTreeView ~viewId ~options)

  let registerCustomReadonlyEditorProvider (type a)
      (module T : CustomDocument.T with type t = a) ~(viewType : string)
      ~(provider : a CustomReadonlyEditorProvider.t)
      ?(options : RegisterCustomEditorProviderOptions.t or_undefined) () :
      Disposable.t =
    let module CustomReadonlyEditorProvider =
      CustomReadonlyEditorProvider.Make (T) in
    let provider = [%js.of: CustomReadonlyEditorProvider.t] provider in
    registerCustomReadonlyEditorProvider ~viewType ~provider ?options ()
end

module Commands = struct
  include
    [%js:
    val registerCommand :
         command:string
      -> callback:(args:(Js.Any.t list[@js.variadic]) -> unit)
      -> Disposable.t
      [@@js.global "vscode.commands.registerCommand"]

    val registerTextEditorCommand :
         command:string
      -> callback:
           (   textEditor:TextEditor.t
            -> edit:TextEditorEdit.t
            -> args:(Js.Any.t list[@js.variadic])
            -> unit)
      -> Disposable.t
      [@@js.global "vscode.commands.registerTextEditorCommand"]

    val executeCommand :
         command:string
      -> args:(Js.Any.t list[@js.variadic])
      -> Js.Any.t or_undefined Promise.t
      [@@js.global "vscode.commands.executeCommand"]

    val getCommands : ?filterInternal:bool -> unit -> string list Promise.t
      [@@js.global "vscode.commands.getCommands"]]
end

module Languages = struct
  include
    [%js:
    val registerDocumentFormattingEditProvider :
         selector:DocumentSelector.t
      -> provider:DocumentFormattingEditProvider.t
      -> Disposable.t
      [@@js.global "vscode.languages.registerDocumentFormattingEditProvider"]

    val registerHoverProvider :
      selector:DocumentSelector.t -> provider:HoverProvider.t -> Disposable.t
      [@@js.global "vscode.languages.registerHoverProvider"]

    val getDiagnostics : Uri.t -> Diagnostic.t list
      [@@js.global "vscode.languages.getDiagnostics"]

    val getDiagnostics_all : unit -> (Uri.t * Diagnostic.t list) list
      [@@js.global "vscode.languages.getDiagnostics"]]
end

module Tasks = struct
  include
    [%js:
    val registerTaskProvider :
      type_:string -> provider:TaskProvider.Default.t -> Disposable.t
      [@@js.global "vscode.tasks.registerTaskProvider"]]
end

module Env = struct
  include [%js: val shell : unit -> string [@@js.get "vscode.env.shell"]]
end
