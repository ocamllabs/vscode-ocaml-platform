open Interop

val version : string

module Disposable : sig
  include Ojs.T

  val from : t list -> t
  val make : dispose:(unit -> unit) -> t
  val dispose : t -> unit
end

module Command : sig
  include Ojs.T

  val title : t -> string
  val command : t -> string
  val tooltip : t -> string or_undefined
  val arguments : t -> Ojs.t list or_undefined
  val set_title : t -> string -> unit
  val set_command : t -> string -> unit
  val set_tooltip : t -> string or_undefined -> unit
  val set_arguments : t -> Ojs.t list or_undefined -> unit

  val create
    :  title:string
    -> command:string
    -> ?tooltip:string
    -> ?arguments:Ojs.t list
    -> unit
    -> t
end

module Position : sig
  include Ojs.T

  type translate_with_change =
    { lineDelta : int or_undefined
    ; characterDelta : int or_undefined
    }

  val translate_with_change_to_js : translate_with_change -> Ojs.t
  val translate_with_change_of_js : Ojs.t -> translate_with_change

  type with_change =
    { line : int or_undefined
    ; character : int or_undefined
    }

  val with_change_to_js : with_change -> Ojs.t
  val with_change_of_js : Ojs.t -> with_change
  val make : line:int -> character:int -> t
  val line : t -> int
  val character : t -> int
  val isBefore : t -> other:t -> bool
  val isBeforeOrEqual : t -> other:t -> bool
  val isAfter : t -> other:t -> bool
  val isAfterOrEqual : t -> other:t -> bool
  val isEqual : t -> other:t -> bool
  val compareTo : t -> other:t -> int
  val translate : t -> ?lineDelta:int -> ?characterDelta:int -> unit -> t
  val with_ : t -> ?line:int -> ?character:int -> unit -> t
  val translateWithChange : t -> change:translate_with_change -> t
  val withChange : t -> change:with_change -> t
end

module Range : sig
  include Ojs.T

  type with_change =
    { start : Position.t or_undefined
    ; end_ : Position.t or_undefined
    }

  val with_change_to_js : with_change -> Ojs.t
  val with_change_of_js : Ojs.t -> with_change
  val start : t -> Position.t
  val end_ : t -> Position.t
  val makePositions : start:Position.t -> end_:Position.t -> t

  val makeCoordinates
    :  startLine:int
    -> startCharacter:int
    -> endLine:int
    -> endCharacter:int
    -> t

  val isEmpty : t -> bool
  val isSingleLine : t -> bool
  val contains : t -> positionOrRange:[ `Position of Position.t | `Range of t ] -> bool
  val isEqual : t -> other:t -> bool
  val intersection : t -> range:t -> t option
  val union : t -> other:t -> t
  val with_ : t -> ?start:Position.t -> ?end_:Position.t -> unit -> t
  val set_isEmpty : t -> bool -> unit
  val set_isSingleLine : t -> bool -> unit
  val withChange : t -> change:with_change -> t
end

module TextLine : sig
  include Ojs.T

  val lineNumber : t -> int
  val text : t -> string
  val range : t -> Range.t
  val rangeIncludingLineBreak : t -> Range.t
  val firstNonWhitespaceCharacterIndex : t -> int
  val isEmptyOrWhitespace : t -> bool

  val create
    :  lineNumber:int
    -> text:string
    -> range:Range.t
    -> rangeIncludingLineBreak:Range.t
    -> firstNonWhitespaceCharacterIndex:int
    -> isEmptyOrWhitespace:bool
    -> unit
    -> t
end

module EndOfLine : sig
  type t =
    | LF
    | CRLF

  include Ojs.T with type t := t
end

module TextEdit : sig
  include Ojs.T

  val replace : range:Range.t -> newText:string -> t
  val insert : position:Position.t -> newText:string -> t
  val delete : Range.t -> t
  val setEndOfLine : EndOfLine.t -> t
  val range : t -> Range.t
  val newText : t -> string
  val newEol : t -> EndOfLine.t or_undefined
  val make : range:Range.t -> newText:string -> t
  val set_range : t -> Range.t -> unit
  val set_newText : t -> string -> unit
  val set_newEol : t -> EndOfLine.t or_undefined -> unit
end

module Uri : sig
  include Ojs.T

  type from_components =
    { scheme : string
    ; authority : string or_undefined
    ; path : string or_undefined
    ; query : string or_undefined
    ; fragment : string or_undefined
    }

  val from_components_to_js : from_components -> Ojs.t
  val from_components_of_js : Ojs.t -> from_components

  type with_components_change =
    { scheme : string or_undefined
    ; authority : string or_undefined
    ; path : string or_undefined
    ; query : string or_undefined
    ; fragment : string or_undefined
    }

  val with_components_change_to_js : with_components_change -> Ojs.t
  val with_components_change_of_js : Ojs.t -> with_components_change

  module Scheme : sig
    type t =
      [ `File
      | `Untitled (** URI scheme used by vscode for new draft (not-saved) files *)
      ]

    val to_string : t -> string
  end

  val parse : string -> ?strict:bool -> unit -> t
  val file : string -> t
  val joinPath : t -> pathSegments:string list -> t
  val scheme : t -> string
  val authority : t -> string
  val path : t -> string
  val query : t -> string
  val fragment : t -> string
  val fsPath : t -> string

  val with_
    :  t
    -> ?scheme:Scheme.t
    -> ?authority:string
    -> ?path:string
    -> ?query:string
    -> ?fragment:string
    -> unit
    -> t

  val toString : t -> ?skipEncoding:bool -> unit -> string
  val toJson : t -> Jsonoo.t
  val equal : t -> t -> bool
  val from : components:from_components -> t
  val withComponents : t -> change:with_components_change -> t
end

module LightDarkIcon : sig
  type t =
    { light : Uri.t
    ; dark : Uri.t
    }

  include Ojs.T with type t := t
end

module ThemeColor : sig
  include Ojs.T

  val id : t -> string
  val make : id:string -> t
end

module ThemeIcon : sig
  include Ojs.T

  val make : id:string -> ?color:ThemeColor.t -> unit -> t
  val file : t
  val folder : t
  val id : t -> string
  val color : t -> ThemeColor.t or_undefined
end

module IconPath : sig
  type t =
    [ `Uri of Uri.t
    | `LightDark of LightDarkIcon.t
    | `ThemeIcon of ThemeIcon.t
    ]

  include Ojs.T with type t := t
end

module TextDocument : sig
  include Ojs.T

  val uri : t -> Uri.t
  val fileName : t -> string
  val isUntitled : t -> bool
  val languageId : t -> string
  val encoding : t -> string
  val version : t -> int
  val isDirty : t -> bool
  val isClosed : t -> bool
  val save : t -> bool Promise.t
  val eol : t -> EndOfLine.t
  val lineCount : t -> int
  val lineAt : t -> line:int -> TextLine.t
  val lineAtPosition : t -> position:Position.t -> TextLine.t
  val offsetAt : t -> position:Position.t -> int
  val positionAt : t -> offset:int -> Position.t
  val getText : t -> ?range:Range.t -> unit -> string

  val getWordRangeAtPosition
    :  t
    -> position:Position.t
    -> ?regex:Js_of_ocaml.Regexp.regexp
    -> unit
    -> Range.t option

  val validateRange : t -> range:Range.t -> Range.t
  val validatePosition : t -> position:Position.t -> Position.t
end

module WorkspaceFolder : sig
  include Ojs.T

  val uri : t -> Uri.t
  val name : t -> string
  val index : t -> int
  val create : uri:Uri.t -> name:string -> index:int -> unit -> t
end

module ViewColumn : sig
  type t =
    | Active
    | Beside
    | One
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine

  include Ojs.T with type t := t
end

module Selection : sig
  include Ojs.T with type t = private Range.t

  type with_change = Range.with_change

  val with_change_to_js : with_change -> Ojs.t
  val with_change_of_js : Ojs.t -> with_change
  val start : t -> Position.t
  val end_ : t -> Position.t
  val isEmpty : t -> bool
  val isSingleLine : t -> bool

  val contains
    :  t
    -> positionOrRange:[ `Position of Position.t | `Range of Range.t ]
    -> bool

  val isEqual : t -> other:Range.t -> bool
  val intersection : t -> range:Range.t -> Range.t or_undefined
  val union : t -> other:Range.t -> Range.t
  val with_ : t -> ?start:Position.t -> ?end_:Position.t -> unit -> Range.t
  val withChange : t -> change:with_change -> Range.t
  val set_isEmpty : t -> bool -> unit
  val set_isSingleLine : t -> bool -> unit
  val anchor : t -> Position.t
  val active : t -> Position.t
  val makePositions : anchor:Position.t -> active:Position.t -> t

  val makeCoordinates
    :  anchorLine:int
    -> anchorCharacter:int
    -> activeLine:int
    -> activeCharacter:int
    -> t

  val isReversed : t -> bool
  val to_range : t -> Range.t
end

module Clipboard : sig
  include Ojs.T

  val readText : t -> string Promise.t
  val writeText : t -> string -> unit Promise.t

  val create
    :  readText:(unit -> string Promise.t)
    -> writeText:(value:string -> unit Promise.t)
    -> unit
    -> t
end

module TextEditorEdit : sig
  include Ojs.T

  type create_replace_arg0 =
    [ `Position of Position.t
    | `Range of Range.t
    | `Selection of Selection.t
    ]

  val create_replace_arg0_to_js : create_replace_arg0 -> Ojs.t
  val create_replace_arg0_of_js : Ojs.t -> create_replace_arg0

  type create_delete_arg0 =
    [ `Range of Range.t
    | `Selection of Selection.t
    ]

  val create_delete_arg0_to_js : create_delete_arg0 -> Ojs.t
  val create_delete_arg0_of_js : Ojs.t -> create_delete_arg0

  type replaceLocation =
    [ `Position of Position.t
    | `Range of Range.t
    | `Selection of Selection.t
    ]

  type deleteLocation =
    [ `Range of Range.t
    | `Selection of Selection.t
    ]

  val replace : t -> location:replaceLocation -> value:string -> unit
  val insert : t -> location:Position.t -> value:string -> unit
  val delete : t -> location:deleteLocation -> unit
  val setEndOfLine : t -> endOfLine:EndOfLine.t -> unit

  val create
    :  replace:(location:create_replace_arg0 -> value:string -> unit)
    -> insert:(location:Position.t -> value:string -> unit)
    -> delete:(location:create_delete_arg0 -> unit)
    -> setEndOfLine:(endOfLine:EndOfLine.t -> unit)
    -> unit
    -> t
end

module TextEditorCursorStyle : sig
  type t =
    | Line
    | Block
    | Underline
    | LineThin
    | BlockOutline
    | UnderlineThin

  include Ojs.T with type t := t
end

module TextEditorLineNumbersStyle : sig
  type t =
    | Off
    | On
    | Relative
    | Interval

  include Ojs.T with type t := t
end

module TextEditorRevealType : sig
  type t =
    | Default
    | InCenter
    | InCenterIfOutsideViewport
    | AtTop

  include Ojs.T with type t := t
end

module TextEditorOptions : sig
  include Ojs.T

  type tab_size =
    [ `Int of int
    | `String of string
    ]

  val tab_size_to_js : tab_size -> Ojs.t
  val tab_size_of_js : Ojs.t -> tab_size

  type insert_spaces =
    [ `Bool of bool
    | `String of string
    ]

  val insert_spaces_to_js : insert_spaces -> Ojs.t
  val insert_spaces_of_js : Ojs.t -> insert_spaces

  type tabSize =
    [ `Int of int
    | `String of string
    ]

  type insertSpaces =
    [ `Bool of bool
    | `String of string
    ]

  val tabSize : t -> tab_size or_undefined
  val indentSize : t -> tab_size or_undefined
  val insertSpaces : t -> insert_spaces or_undefined
  val cursorStyle : t -> TextEditorCursorStyle.t or_undefined
  val lineNumbers : t -> TextEditorLineNumbersStyle.t or_undefined
  val set_tabSize : t -> tab_size or_undefined -> unit
  val set_indentSize : t -> tab_size or_undefined -> unit
  val set_insertSpaces : t -> insert_spaces or_undefined -> unit
  val set_cursorStyle : t -> TextEditorCursorStyle.t or_undefined -> unit
  val set_lineNumbers : t -> TextEditorLineNumbersStyle.t or_undefined -> unit

  val create
    :  ?tabSize:tab_size
    -> ?indentSize:tab_size
    -> ?insertSpaces:insert_spaces
    -> ?cursorStyle:TextEditorCursorStyle.t
    -> ?lineNumbers:TextEditorLineNumbersStyle.t
    -> unit
    -> t
end

module TextEditorDecorationType : sig
  include Ojs.T

  val key : t -> string
  val dispose : t -> unit
  val disposable : t -> Disposable.t
  val create : key:string -> dispose:(unit -> unit) -> unit -> t
end

module MarkdownString : sig
  include Ojs.T

  type is_trusted_item = { enabledCommands : string list }

  val is_trusted_item_to_js : is_trusted_item -> Ojs.t
  val is_trusted_item_of_js : Ojs.t -> is_trusted_item

  type is_trusted =
    [ `Bool of bool
    | `Options of is_trusted_item
    ]

  val is_trusted_to_js : is_trusted -> Ojs.t
  val is_trusted_of_js : Ojs.t -> is_trusted
  val value : t -> string
  val isTrusted : t -> is_trusted or_undefined
  val supportThemeIcons : t -> bool or_undefined
  val make : ?value:string -> ?supportThemeIcons:bool -> unit -> t
  val appendText : t -> value:string -> t
  val appendMarkdown : t -> value:string -> t
  val appendCodeblock : t -> value:string -> ?language:string -> unit -> t
  val set_value : t -> string -> unit
  val set_isTrusted : t -> is_trusted or_undefined -> unit
  val set_supportThemeIcons : t -> bool or_undefined -> unit
  val supportHtml : t -> bool or_undefined
  val set_supportHtml : t -> bool or_undefined -> unit
  val baseUri : t -> Uri.t or_undefined
  val set_baseUri : t -> Uri.t or_undefined -> unit
end

module ThemableDecorationAttachmentRenderOptions : sig
  include Ojs.T

  type content_icon_path =
    [ `String of string
    | `Uri of Uri.t
    ]

  val content_icon_path_to_js : content_icon_path -> Ojs.t
  val content_icon_path_of_js : Ojs.t -> content_icon_path

  type border_color =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  val border_color_to_js : border_color -> Ojs.t
  val border_color_of_js : Ojs.t -> border_color

  type contentIconPath =
    [ `String of string
    | `Uri of Uri.t
    ]

  type color =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  val contentText : t -> string or_undefined
  val contentIconPath : t -> content_icon_path or_undefined
  val border : t -> string or_undefined
  val borderColor : t -> border_color or_undefined
  val fontStyle : t -> string or_undefined
  val fontWeight : t -> string or_undefined
  val textDecoration : t -> string or_undefined
  val color : t -> border_color or_undefined
  val backgroundColor : t -> border_color or_undefined
  val margin : t -> string or_undefined
  val width : t -> string or_undefined
  val height : t -> string or_undefined
  val set_contentText : t -> string or_undefined -> unit
  val set_contentIconPath : t -> content_icon_path or_undefined -> unit
  val set_border : t -> string or_undefined -> unit
  val set_borderColor : t -> border_color or_undefined -> unit
  val set_fontStyle : t -> string or_undefined -> unit
  val set_fontWeight : t -> string or_undefined -> unit
  val set_textDecoration : t -> string or_undefined -> unit
  val set_color : t -> border_color or_undefined -> unit
  val set_backgroundColor : t -> border_color or_undefined -> unit
  val set_margin : t -> string or_undefined -> unit
  val set_width : t -> string or_undefined -> unit
  val set_height : t -> string or_undefined -> unit

  val create
    :  ?contentText:string
    -> ?contentIconPath:content_icon_path
    -> ?border:string
    -> ?borderColor:border_color
    -> ?fontStyle:string
    -> ?fontWeight:string
    -> ?textDecoration:string
    -> ?color:border_color
    -> ?backgroundColor:border_color
    -> ?margin:string
    -> ?width:string
    -> ?height:string
    -> unit
    -> t
end

module ThemableDecorationRenderOptions : sig
  include Ojs.T

  type background_color =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  val background_color_to_js : background_color -> Ojs.t
  val background_color_of_js : Ojs.t -> background_color

  type gutter_icon_path =
    [ `String of string
    | `Uri of Uri.t
    ]

  val gutter_icon_path_to_js : gutter_icon_path -> Ojs.t
  val gutter_icon_path_of_js : Ojs.t -> gutter_icon_path
  val backgroundColor : t -> background_color or_undefined
  val set_backgroundColor : t -> background_color or_undefined -> unit
  val outline : t -> string or_undefined
  val set_outline : t -> string or_undefined -> unit
  val outlineColor : t -> background_color or_undefined
  val set_outlineColor : t -> background_color or_undefined -> unit
  val outlineStyle : t -> string or_undefined
  val set_outlineStyle : t -> string or_undefined -> unit
  val outlineWidth : t -> string or_undefined
  val set_outlineWidth : t -> string or_undefined -> unit
  val border : t -> string or_undefined
  val set_border : t -> string or_undefined -> unit
  val borderColor : t -> background_color or_undefined
  val set_borderColor : t -> background_color or_undefined -> unit
  val borderRadius : t -> string or_undefined
  val set_borderRadius : t -> string or_undefined -> unit
  val borderSpacing : t -> string or_undefined
  val set_borderSpacing : t -> string or_undefined -> unit
  val borderStyle : t -> string or_undefined
  val set_borderStyle : t -> string or_undefined -> unit
  val borderWidth : t -> string or_undefined
  val set_borderWidth : t -> string or_undefined -> unit
  val fontStyle : t -> string or_undefined
  val set_fontStyle : t -> string or_undefined -> unit
  val fontWeight : t -> string or_undefined
  val set_fontWeight : t -> string or_undefined -> unit
  val textDecoration : t -> string or_undefined
  val set_textDecoration : t -> string or_undefined -> unit
  val cursor : t -> string or_undefined
  val set_cursor : t -> string or_undefined -> unit
  val color : t -> background_color or_undefined
  val set_color : t -> background_color or_undefined -> unit
  val opacity : t -> string or_undefined
  val set_opacity : t -> string or_undefined -> unit
  val letterSpacing : t -> string or_undefined
  val set_letterSpacing : t -> string or_undefined -> unit
  val gutterIconPath : t -> gutter_icon_path or_undefined
  val set_gutterIconPath : t -> gutter_icon_path or_undefined -> unit
  val gutterIconSize : t -> string or_undefined
  val set_gutterIconSize : t -> string or_undefined -> unit
  val overviewRulerColor : t -> background_color or_undefined
  val set_overviewRulerColor : t -> background_color or_undefined -> unit
  val before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
  val set_before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined -> unit
  val after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
  val set_after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined -> unit

  val create
    :  ?backgroundColor:background_color
    -> ?outline:string
    -> ?outlineColor:background_color
    -> ?outlineStyle:string
    -> ?outlineWidth:string
    -> ?border:string
    -> ?borderColor:background_color
    -> ?borderRadius:string
    -> ?borderSpacing:string
    -> ?borderStyle:string
    -> ?borderWidth:string
    -> ?fontStyle:string
    -> ?fontWeight:string
    -> ?textDecoration:string
    -> ?cursor:string
    -> ?color:background_color
    -> ?opacity:string
    -> ?letterSpacing:string
    -> ?gutterIconPath:gutter_icon_path
    -> ?gutterIconSize:string
    -> ?overviewRulerColor:background_color
    -> ?before:ThemableDecorationAttachmentRenderOptions.t
    -> ?after:ThemableDecorationAttachmentRenderOptions.t
    -> unit
    -> t
end

module DecorationRangeBehavior : sig
  type t =
    | OpenOpen
    | ClosedClosed
    | OpenClosed
    | ClosedOpen

  include Ojs.T with type t := t
end

module OverviewRulerLane : sig
  (** Bit flags. [combine] preserves combinations returned by VS Code. *)
  type t = private int

  include Ojs.T with type t := t

  val left : t
  val center : t
  val right : t
  val full : t
  val combine : t list -> t
  val mem : t -> flag:t -> bool
end

module DecorationRenderOptions : sig
  include Ojs.T with type t = private ThemableDecorationRenderOptions.t

  type background_color =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  val background_color_to_js : background_color -> Ojs.t
  val background_color_of_js : Ojs.t -> background_color

  type gutter_icon_path =
    [ `String of string
    | `Uri of Uri.t
    ]

  val gutter_icon_path_to_js : gutter_icon_path -> Ojs.t
  val gutter_icon_path_of_js : Ojs.t -> gutter_icon_path

  type color = ThemableDecorationAttachmentRenderOptions.color

  val to_themable_decoration_render_options : t -> ThemableDecorationRenderOptions.t
  val backgroundColor : t -> background_color or_undefined
  val set_backgroundColor : t -> background_color or_undefined -> unit
  val outline : t -> string or_undefined
  val set_outline : t -> string or_undefined -> unit
  val outlineColor : t -> background_color or_undefined
  val set_outlineColor : t -> background_color or_undefined -> unit
  val outlineStyle : t -> string or_undefined
  val set_outlineStyle : t -> string or_undefined -> unit
  val outlineWidth : t -> string or_undefined
  val set_outlineWidth : t -> string or_undefined -> unit
  val border : t -> string or_undefined
  val set_border : t -> string or_undefined -> unit
  val borderColor : t -> background_color or_undefined
  val set_borderColor : t -> background_color or_undefined -> unit
  val borderRadius : t -> string or_undefined
  val set_borderRadius : t -> string or_undefined -> unit
  val borderSpacing : t -> string or_undefined
  val set_borderSpacing : t -> string or_undefined -> unit
  val borderStyle : t -> string or_undefined
  val set_borderStyle : t -> string or_undefined -> unit
  val borderWidth : t -> string or_undefined
  val set_borderWidth : t -> string or_undefined -> unit
  val fontStyle : t -> string or_undefined
  val set_fontStyle : t -> string or_undefined -> unit
  val fontWeight : t -> string or_undefined
  val set_fontWeight : t -> string or_undefined -> unit
  val textDecoration : t -> string or_undefined
  val set_textDecoration : t -> string or_undefined -> unit
  val cursor : t -> string or_undefined
  val set_cursor : t -> string or_undefined -> unit
  val color : t -> background_color or_undefined
  val set_color : t -> background_color or_undefined -> unit
  val opacity : t -> string or_undefined
  val set_opacity : t -> string or_undefined -> unit
  val letterSpacing : t -> string or_undefined
  val set_letterSpacing : t -> string or_undefined -> unit
  val gutterIconPath : t -> gutter_icon_path or_undefined
  val set_gutterIconPath : t -> gutter_icon_path or_undefined -> unit
  val gutterIconSize : t -> string or_undefined
  val set_gutterIconSize : t -> string or_undefined -> unit
  val overviewRulerColor : t -> background_color or_undefined
  val set_overviewRulerColor : t -> background_color or_undefined -> unit
  val before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
  val set_before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined -> unit
  val after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
  val set_after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined -> unit
  val isWholeLine : t -> bool or_undefined
  val set_isWholeLine : t -> bool or_undefined -> unit
  val rangeBehavior : t -> DecorationRangeBehavior.t or_undefined
  val set_rangeBehavior : t -> DecorationRangeBehavior.t or_undefined -> unit
  val overviewRulerLane : t -> OverviewRulerLane.t or_undefined
  val set_overviewRulerLane : t -> OverviewRulerLane.t or_undefined -> unit
  val light : t -> ThemableDecorationRenderOptions.t or_undefined
  val set_light : t -> ThemableDecorationRenderOptions.t or_undefined -> unit
  val dark : t -> ThemableDecorationRenderOptions.t or_undefined
  val set_dark : t -> ThemableDecorationRenderOptions.t or_undefined -> unit

  val create
    :  ?backgroundColor:background_color
    -> ?outline:string
    -> ?outlineColor:background_color
    -> ?outlineStyle:string
    -> ?outlineWidth:string
    -> ?border:string
    -> ?borderColor:background_color
    -> ?borderRadius:string
    -> ?borderSpacing:string
    -> ?borderStyle:string
    -> ?borderWidth:string
    -> ?fontStyle:string
    -> ?fontWeight:string
    -> ?textDecoration:string
    -> ?cursor:string
    -> ?color:background_color
    -> ?opacity:string
    -> ?letterSpacing:string
    -> ?gutterIconPath:gutter_icon_path
    -> ?gutterIconSize:string
    -> ?overviewRulerColor:background_color
    -> ?before:ThemableDecorationAttachmentRenderOptions.t
    -> ?after:ThemableDecorationAttachmentRenderOptions.t
    -> ?isWholeLine:bool
    -> ?rangeBehavior:DecorationRangeBehavior.t
    -> ?overviewRulerLane:OverviewRulerLane.t
    -> ?light:ThemableDecorationRenderOptions.t
    -> ?dark:ThemableDecorationRenderOptions.t
    -> unit
    -> t
end

module ThemableDecorationInstanceRenderOptions : sig
  include Ojs.T

  val before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
  val after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
  val set_before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined -> unit
  val set_after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined -> unit

  val create
    :  ?before:ThemableDecorationAttachmentRenderOptions.t
    -> ?after:ThemableDecorationAttachmentRenderOptions.t
    -> unit
    -> t
end

module DecorationInstanceRenderOptions : sig
  include Ojs.T with type t = private ThemableDecorationInstanceRenderOptions.t

  val light : t -> ThemableDecorationInstanceRenderOptions.t or_undefined
  val dark : t -> ThemableDecorationInstanceRenderOptions.t or_undefined

  val to_themable_decoration_instance_render_options
    :  t
    -> ThemableDecorationInstanceRenderOptions.t

  val before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
  val set_before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined -> unit
  val after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
  val set_after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined -> unit
  val set_light : t -> ThemableDecorationInstanceRenderOptions.t or_undefined -> unit
  val set_dark : t -> ThemableDecorationInstanceRenderOptions.t or_undefined -> unit

  val create
    :  ?before:ThemableDecorationAttachmentRenderOptions.t
    -> ?after:ThemableDecorationAttachmentRenderOptions.t
    -> ?light:ThemableDecorationInstanceRenderOptions.t
    -> ?dark:ThemableDecorationInstanceRenderOptions.t
    -> unit
    -> t
end

(** @deprecated This type is deprecated, please use MarkdownString instead. *)
module MarkedString : sig
  type value_item =
    { language : string (** @deprecated please use MarkdownString instead *)
    ; value : string (** @deprecated please use MarkdownString instead *)
    }

  val value_item_to_js : value_item -> Ojs.t
  val value_item_of_js : Ojs.t -> value_item

  type value =
    [ `String of string
    | `Options of value_item
    ]

  val value_to_js : value -> Ojs.t
  val value_of_js : Ojs.t -> value

  type t = value

  include Ojs.T with type t := t
end

module DecorationOptions : sig
  include Ojs.T

  type hover_message_item =
    [ `MarkdownString of MarkdownString.t
    | `MarkedString of MarkedString.t
    ]

  val hover_message_item_to_js : hover_message_item -> Ojs.t
  val hover_message_item_of_js : Ojs.t -> hover_message_item

  type hover_message =
    [ `MarkdownString of MarkdownString.t
    | `MarkedString of MarkedString.t
    | `Array of hover_message_item list
    ]

  val hover_message_to_js : hover_message -> Ojs.t
  val hover_message_of_js : Ojs.t -> hover_message

  type hoverMessage =
    [ `MarkdownString of MarkdownString.t
    | `MarkdownStrings of MarkdownString.t list
    ]

  val range : t -> Range.t
  val hoverMessage : t -> hover_message or_undefined
  val renderOptions : t -> DecorationInstanceRenderOptions.t or_undefined
  val set_range : t -> Range.t -> unit
  val set_hoverMessage : t -> hover_message or_undefined -> unit
  val set_renderOptions : t -> DecorationInstanceRenderOptions.t or_undefined -> unit

  val create
    :  range:Range.t
    -> ?hoverMessage:hover_message
    -> ?renderOptions:DecorationInstanceRenderOptions.t
    -> unit
    -> t
end

module SnippetString : sig
  include Ojs.T

  type append_variable_default_value =
    [ `String of string
    | `Options of snippet:t -> Ojs.t
    ]

  val append_variable_default_value_to_js : append_variable_default_value -> Ojs.t
  val append_variable_default_value_of_js : Ojs.t -> append_variable_default_value
  val value : t -> string
  val make : ?value:string -> unit -> t
  val appendText : t -> string:string -> t

  val appendPlaceholder
    :  t
    -> value:[ `String of string | `Function of t -> unit ]
    -> ?number:int
    -> unit
    -> t

  val appendChoice : t -> values:string list -> ?number:int -> unit -> t
  val set_value : t -> string -> unit
  val appendTabstop : t -> ?number:int -> unit -> t
  val appendVariable : t -> name:string -> defaultValue:append_variable_default_value -> t
end

module TextEditor : sig
  include Ojs.T

  type insertSnippetLocation =
    [ `Position of Position.t
    | `Range of Range.t
    | `Positions of Position.t list
    | `Ranges of Range.t list
    ]

  val document : t -> TextDocument.t
  val selection : t -> Selection.t
  val set_selection : t -> Selection.t -> unit
  val selections : t -> Selection.t list
  val visibleRanges : t -> Range.t list
  val options : t -> TextEditorOptions.t
  val viewColumn : t -> ViewColumn.t or_undefined

  val edit
    :  t
    -> callback:(editBuilder:TextEditorEdit.t -> unit)
    -> ?undoStopBefore:bool
    -> ?undoStopAfter:bool
    -> unit
    -> bool Promise.t

  val insertSnippet
    :  t
    -> snippet:SnippetString.t
    -> ?location:insertSnippetLocation
    -> ?undoStopBefore:bool
    -> ?undoStopAfter:bool
    -> ?keepWhitespace:bool
    -> unit
    -> bool Promise.t

  val setDecorations
    :  t
    -> decorationType:TextEditorDecorationType.t
    -> rangesOrOptions:[ `Ranges of Range.t list | `Options of DecorationOptions.t list ]
    -> unit

  val revealRange
    :  t
    -> range:Range.t
    -> ?revealType:TextEditorRevealType.t
    -> unit
    -> unit

  val set_selections : t -> Selection.t list -> unit
  val set_options : t -> TextEditorOptions.t -> unit

  (** @deprecated Use window.showTextDocument instead. *)
  val show : t -> ?column:ViewColumn.t -> unit -> unit

  (** @deprecated
        Use the command [workbench.action.closeActiveEditor] instead. This method shows unexpected behavior and will be removed in the next major update.
  *)
  val hide : t -> unit
end

module TextEditorSelectionChangeKind : sig
  type t =
    | Keyboard
    | Mouse
    | Command

  include Ojs.T with type t := t
end

module TextEditorSelectionChangeEvent : sig
  include Ojs.T

  val textEditor : t -> TextEditor.t
  val selections : t -> Selection.t list
  val kind : t -> TextEditorSelectionChangeKind.t or_undefined

  val create
    :  textEditor:TextEditor.t
    -> selections:Selection.t list
    -> kind:TextEditorSelectionChangeKind.t or_undefined
    -> unit
    -> t
end

module ConfigurationTarget : sig
  type t =
    | Global
    | Workspace
    | WorkspaceFolder

  include Ojs.T with type t := t
end

module WorkspaceConfiguration : sig
  include Ojs.T

  type update_with_target_configuration_target =
    [ `ConfigurationTarget of ConfigurationTarget.t
    | `Bool of bool
    | `Null
    ]

  val update_with_target_configuration_target_to_js
    :  update_with_target_configuration_target
    -> Ojs.t

  val update_with_target_configuration_target_of_js
    :  Ojs.t
    -> update_with_target_configuration_target

  type 'a inspectResult =
    { key : string
    ; defaultValue : 'a option
    ; globalValue : 'a option
    ; workspaceValue : 'a option
    ; workspaceFolderValue : 'a option
    ; defaultLanguageValue : 'a option
    ; globalLanguageValue : 'a option
    ; workspaceLanguageValue : 'a option
    ; workspaceFolderLanguageValue : 'a option
    ; languageIds : string list option
    }

  val get : t -> section:string -> Ojs.t option
  val get_default : 'a Js.t -> t -> section:string -> defaultValue:'a -> 'a
  val has : t -> section:string -> bool
  val inspect : 'a Js.t -> t -> section:string -> 'a inspectResult option

  val update
    :  t
    -> section:string
    -> value:Ojs.t
    -> ?configurationTarget:
         [ `ConfigurationTarget of ConfigurationTarget.t | `Bool of bool ]
    -> ?overrideInLanguage:bool
    -> unit
    -> unit Promise.t

  val getTyped : 'p_t Js.t -> t -> section:string -> 'p_t or_undefined

  val updateWithTarget
    :  t
    -> section:string
    -> value:Ojs.t
    -> ?configurationTarget:update_with_target_configuration_target
    -> ?overrideInLanguage:bool
    -> unit
    -> unit Promise.t

  val getProperty : t -> key:string -> Ojs.t or_undefined
end

module SnippetTextEdit : sig
  include Ojs.T

  val replace : range:Range.t -> snippet:SnippetString.t -> t
  val insert : position:Position.t -> snippet:SnippetString.t -> t
  val range : t -> Range.t
  val set_range : t -> Range.t -> unit
  val snippet : t -> SnippetString.t
  val set_snippet : t -> SnippetString.t -> unit
  val keepWhitespace : t -> bool or_undefined
  val set_keepWhitespace : t -> bool or_undefined -> unit
  val make : range:Range.t -> snippet:SnippetString.t -> t
end

module Uint8Array : sig
  include Ojs.T

  val of_array : int array -> t
  val to_array : t -> int array
end

module DataTransferFile : sig
  include Ojs.T

  val name : t -> string
  val uri : t -> Uri.t or_undefined
  val data : t -> Uint8Array.t Promise.t

  val create
    :  name:string
    -> ?uri:Uri.t
    -> data:(unit -> Uint8Array.t Promise.t)
    -> unit
    -> t
end

module WorkspaceEditEntryMetadata : sig
  include Ojs.T

  val needsConfirmation : t -> bool
  val set_needsConfirmation : t -> bool -> unit
  val label : t -> string
  val set_label : t -> string -> unit
  val description : t -> string or_undefined
  val set_description : t -> string or_undefined -> unit
  val iconPath : t -> IconPath.t or_undefined
  val set_iconPath : t -> IconPath.t or_undefined -> unit

  val create
    :  needsConfirmation:bool
    -> label:string
    -> ?description:string
    -> ?iconPath:IconPath.t
    -> unit
    -> t
end

module NotebookRange : sig
  include Ojs.T

  type with__change =
    { start : int or_undefined
    ; end_ : int or_undefined
    }

  val with__change_to_js : with__change -> Ojs.t
  val with__change_of_js : Ojs.t -> with__change
  val start : t -> int
  val end_ : t -> int
  val isEmpty : t -> bool
  val make : start:int -> end_:int -> t
  val with_ : t -> change:with__change -> t
end

module NotebookCellKind : sig
  type t =
    | Markup
    | Code

  include Ojs.T with type t := t
end

module JsError : sig
  include Ojs.T

  val make : ?message:string -> unit -> t
  val name : t -> string
  val message : t -> string
  val stack : t -> string option
  val cause : t -> Ojs.t option
end

module NotebookCellOutputItem : sig
  include Ojs.T

  val text : value:string -> ?mime:string -> unit -> t
  val json : value:Ojs.t -> ?mime:string -> unit -> t
  val stdout : value:string -> t
  val stderr : value:string -> t
  val error : value:JsError.t -> t
  val mime : t -> string
  val set_mime : t -> string -> unit
  val data : t -> Uint8Array.t
  val set_data : t -> Uint8Array.t -> unit
  val make : data:Uint8Array.t -> mime:string -> t
end

module NotebookCellOutput : sig
  include Ojs.T

  val items : t -> NotebookCellOutputItem.t list
  val set_items : t -> NotebookCellOutputItem.t list -> unit
  val metadata : t -> Ojs.t Dict.t or_undefined
  val set_metadata : t -> Ojs.t Dict.t or_undefined -> unit
  val make : items:NotebookCellOutputItem.t list -> ?metadata:Ojs.t Dict.t -> unit -> t
end

module NotebookCellExecutionSummary : sig
  include Ojs.T

  type timing =
    { startTime : float
    ; endTime : float
    }

  val timing_to_js : timing -> Ojs.t
  val timing_of_js : Ojs.t -> timing
  val executionOrder : t -> int or_undefined
  val success : t -> bool or_undefined
  val timing : t -> timing or_undefined
  val create : ?executionOrder:int -> ?success:bool -> ?timing:timing -> unit -> t
end

module NotebookCellData : sig
  include Ojs.T

  val kind : t -> NotebookCellKind.t
  val set_kind : t -> NotebookCellKind.t -> unit
  val value : t -> string
  val set_value : t -> string -> unit
  val languageId : t -> string
  val set_languageId : t -> string -> unit
  val outputs : t -> NotebookCellOutput.t list or_undefined
  val set_outputs : t -> NotebookCellOutput.t list or_undefined -> unit
  val metadata : t -> Ojs.t Dict.t or_undefined
  val set_metadata : t -> Ojs.t Dict.t or_undefined -> unit
  val executionSummary : t -> NotebookCellExecutionSummary.t or_undefined
  val set_executionSummary : t -> NotebookCellExecutionSummary.t or_undefined -> unit
  val make : kind:NotebookCellKind.t -> value:string -> languageId:string -> t
end

module NotebookEdit : sig
  include Ojs.T

  val replaceCells : range:NotebookRange.t -> newCells:NotebookCellData.t list -> t
  val insertCells : index:int -> newCells:NotebookCellData.t list -> t
  val deleteCells : range:NotebookRange.t -> t
  val updateCellMetadata : index:int -> newCellMetadata:Ojs.t Dict.t -> t
  val updateNotebookMetadata : newNotebookMetadata:Ojs.t Dict.t -> t
  val range : t -> NotebookRange.t
  val set_range : t -> NotebookRange.t -> unit
  val newCells : t -> NotebookCellData.t list
  val set_newCells : t -> NotebookCellData.t list -> unit
  val newCellMetadata : t -> Ojs.t Dict.t or_undefined
  val set_newCellMetadata : t -> Ojs.t Dict.t or_undefined -> unit
  val newNotebookMetadata : t -> Ojs.t Dict.t or_undefined
  val set_newNotebookMetadata : t -> Ojs.t Dict.t or_undefined -> unit
  val make : range:NotebookRange.t -> newCells:NotebookCellData.t list -> t
end

module WorkspaceEdit : sig
  include Ojs.T

  type set_edits_item =
    [ `TextEdit of TextEdit.t
    | `SnippetTextEdit of SnippetTextEdit.t
    ]

  val set_edits_item_to_js : set_edits_item -> Ojs.t
  val set_edits_item_of_js : Ojs.t -> set_edits_item

  type create_file_options_contents =
    [ `Uint8Array of Uint8Array.t
    | `DataTransferFile of DataTransferFile.t
    ]

  val create_file_options_contents_to_js : create_file_options_contents -> Ojs.t
  val create_file_options_contents_of_js : Ojs.t -> create_file_options_contents

  type create_file_options =
    { overwrite : bool or_undefined
    ; ignoreIfExists : bool or_undefined
    ; contents : create_file_options_contents or_undefined
    }

  val create_file_options_to_js : create_file_options -> Ojs.t
  val create_file_options_of_js : Ojs.t -> create_file_options

  type delete_file_options =
    { recursive : bool or_undefined
    ; ignoreIfNotExists : bool or_undefined
    }

  val delete_file_options_to_js : delete_file_options -> Ojs.t
  val delete_file_options_of_js : Ojs.t -> delete_file_options

  type rename_file_options =
    { overwrite : bool or_undefined
    ; ignoreIfExists : bool or_undefined
    }

  val rename_file_options_to_js : rename_file_options -> Ojs.t
  val rename_file_options_of_js : Ojs.t -> rename_file_options
  val size : t -> int
  val replace : t -> uri:Uri.t -> range:Range.t -> newText:string -> unit
  val make : unit -> t

  val replaceWithMetadata
    :  t
    -> uri:Uri.t
    -> range:Range.t
    -> newText:string
    -> ?metadata:WorkspaceEditEntryMetadata.t
    -> unit
    -> unit

  val insert
    :  t
    -> uri:Uri.t
    -> position:Position.t
    -> newText:string
    -> ?metadata:WorkspaceEditEntryMetadata.t
    -> unit
    -> unit

  val delete
    :  t
    -> uri:Uri.t
    -> range:Range.t
    -> ?metadata:WorkspaceEditEntryMetadata.t
    -> unit
    -> unit

  val has : t -> uri:Uri.t -> bool
  val set : t -> uri:Uri.t -> edits:set_edits_item list -> unit

  val setWithMetadata
    :  t
    -> uri:Uri.t
    -> edits:(set_edits_item * WorkspaceEditEntryMetadata.t or_undefined) list
    -> unit

  val setNotebookEdits : t -> uri:Uri.t -> edits:NotebookEdit.t list -> unit

  val setNotebookEditsWithMetadata
    :  t
    -> uri:Uri.t
    -> edits:(NotebookEdit.t * WorkspaceEditEntryMetadata.t or_undefined) list
    -> unit

  val get : t -> uri:Uri.t -> TextEdit.t list

  val createFile
    :  t
    -> uri:Uri.t
    -> ?options:create_file_options
    -> ?metadata:WorkspaceEditEntryMetadata.t
    -> unit
    -> unit

  val deleteFile
    :  t
    -> uri:Uri.t
    -> ?options:delete_file_options
    -> ?metadata:WorkspaceEditEntryMetadata.t
    -> unit
    -> unit

  val renameFile
    :  t
    -> oldUri:Uri.t
    -> newUri:Uri.t
    -> ?options:rename_file_options
    -> ?metadata:WorkspaceEditEntryMetadata.t
    -> unit
    -> unit

  val entries : t -> (Uri.t * TextEdit.t list) list
end

module StatusBarAlignment : sig
  type t =
    | Left
    | Right

  include Ojs.T with type t := t
end

module AccessibilityInformation : sig
  include Ojs.T

  val label : t -> string
  val role : t -> string or_undefined
  val create : label:string -> ?role:string -> unit -> t
end

module StatusBarItem : sig
  include Ojs.T

  type tooltip =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val tooltip_to_js : tooltip -> Ojs.t
  val tooltip_of_js : Ojs.t -> tooltip

  type color_value =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  val color_value_to_js : color_value -> Ojs.t
  val color_value_of_js : Ojs.t -> color_value

  type command_value =
    [ `String of string
    | `Command of Command.t
    ]

  val command_value_to_js : command_value -> Ojs.t
  val command_value_of_js : Ojs.t -> command_value

  type color =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  type command =
    [ `String of string
    | `Command of Command.t
    ]

  val alignment : t -> StatusBarAlignment.t
  val priority : t -> float or_undefined
  val text : t -> string
  val tooltip : t -> tooltip or_undefined
  val color : t -> color_value or_undefined
  val backgroundColor : t -> ThemeColor.t or_undefined
  val command : t -> command_value or_undefined
  val accessibilityInformation : t -> AccessibilityInformation.t or_undefined
  val set_text : t -> string -> unit
  val set_tooltip : t -> tooltip or_undefined -> unit
  val set_color : t -> color_value or_undefined -> unit
  val set_backgroundColor : t -> ThemeColor.t or_undefined -> unit
  val set_command : t -> command_value or_undefined -> unit
  val set_accessibilityInformation : t -> AccessibilityInformation.t or_undefined -> unit
  val show : t -> unit
  val hide : t -> unit
  val dispose : t -> unit
  val disposable : t -> Disposable.t
  val id : t -> string
  val name : t -> string or_undefined
  val set_name : t -> string or_undefined -> unit
end

module WorkspaceFoldersChangeEvent : sig
  include Ojs.T

  val added : t -> WorkspaceFolder.t list
  val removed : t -> WorkspaceFolder.t list
  val create : added:WorkspaceFolder.t list -> removed:WorkspaceFolder.t list -> unit -> t
end

module FormattingOptions : sig
  include Ojs.T

  type property =
    [ `Bool of bool
    | `Int of int
    | `String of string
    ]

  val property_to_js : property -> Ojs.t
  val property_of_js : Ojs.t -> property
  val tabSize : t -> int
  val insertSpaces : t -> bool
  val create : tabSize:int -> insertSpaces:bool -> t
  val set_tabSize : t -> int -> unit
  val set_insertSpaces : t -> bool -> unit
  val getProperty : t -> key:string -> property or_undefined
  val setProperty : t -> key:string -> value:property -> unit
end

module Event : sig
  type 'a t =
    listener:('a -> unit)
    -> ?thisArgs:Ojs.t
    -> ?disposables:Disposable.t list
    -> unit
    -> Disposable.t

  include Js.Generic with type 'a t := 'a t
  module Make (T : Ojs.T) : Ojs.T with type t = T.t t

  val map : 'a t -> f:('a -> 'b) -> 'b t
end

module EventEmitter : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val make : unit -> t
    val event : t -> T.t Event.t
    val fire : t -> T.t -> unit
    val dispose : t -> unit -> unit
    val set_event : t -> T.t Event.t -> unit
  end
end

module CancellationToken : sig
  include Ojs.T

  val isCancellationRequested : t -> bool
  val onCancellationRequested : t -> Ojs.t Event.t
  val set_isCancellationRequested : t -> bool -> unit

  val create
    :  isCancellationRequested:bool
    -> onCancellationRequested:Ojs.t Event.t
    -> unit
    -> t
end

module QuickInputButtonLocation : sig
  type t =
    | Title
    | Inline
    | Input

  include Ojs.T with type t := t
end

module QuickInputButtonToggle : sig
  include Ojs.T

  val checked : t -> bool
  val set_checked : t -> bool -> unit
  val create : checked:bool -> t
end

module QuickInputButton : sig
  include Ojs.T

  type toggle = { checked : bool }

  val toggle_to_js : toggle -> Ojs.t
  val toggle_of_js : Ojs.t -> toggle

  type iconPath = IconPath.t

  val iconPath : t -> IconPath.t
  val tooltip : t -> string or_undefined
  val location : t -> QuickInputButtonLocation.t or_undefined
  val toggle : t -> toggle or_undefined
  val set_location : t -> QuickInputButtonLocation.t or_undefined -> unit

  val create
    :  iconPath:IconPath.t
    -> ?tooltip:string
    -> ?location:QuickInputButtonLocation.t
    -> ?toggle:toggle
    -> unit
    -> t
end

module QuickPickItemKind : sig
  type t =
    | Separator
    | Default

  include Ojs.T with type t := t
end

module QuickPickItem : sig
  include Ojs.T

  val label : t -> string
  val description : t -> string or_undefined
  val detail : t -> string or_undefined
  val picked : t -> bool or_undefined
  val alwaysShow : t -> bool or_undefined
  val kind : t -> QuickPickItemKind.t or_undefined
  val buttons : t -> QuickInputButton.t list or_undefined
  val resourceUri : t -> Uri.t or_undefined
  val iconPath : t -> IconPath.t or_undefined
  val set_label : t -> string -> unit
  val set_kind : t -> QuickPickItemKind.t or_undefined -> unit
  val set_iconPath : t -> IconPath.t or_undefined -> unit
  val set_description : t -> string or_undefined -> unit
  val set_detail : t -> string or_undefined -> unit
  val set_resourceUri : t -> Uri.t or_undefined -> unit
  val set_picked : t -> bool or_undefined -> unit
  val set_alwaysShow : t -> bool or_undefined -> unit
  val set_buttons : t -> QuickInputButton.t list or_undefined -> unit

  val create
    :  label:string
    -> ?kind:QuickPickItemKind.t
    -> ?iconPath:IconPath.t
    -> ?description:string
    -> ?detail:string
    -> ?resourceUri:Uri.t
    -> ?picked:bool
    -> ?alwaysShow:bool
    -> ?buttons:QuickInputButton.t list
    -> unit
    -> t
end

module QuickPickOptions : sig
  include Ojs.T

  type on_did_select_item_arg0 =
    [ `QuickPickItem of QuickPickItem.t
    | `String of string
    ]

  val on_did_select_item_arg0_to_js : on_did_select_item_arg0 -> Ojs.t
  val on_did_select_item_arg0_of_js : Ojs.t -> on_did_select_item_arg0

  type onDidSelectItemArgs =
    [ `QuickPickItem of QuickPickItem.t
    | `String of string
    ]

  val title : t -> string or_undefined
  val matchOnDescription : t -> bool or_undefined
  val matchOnDetail : t -> bool or_undefined
  val placeHolder : t -> string or_undefined
  val prompt : t -> string or_undefined
  val ignoreFocusOut : t -> bool or_undefined
  val canPickMany : t -> bool or_undefined
  val set_title : t -> string or_undefined -> unit
  val set_matchOnDescription : t -> bool or_undefined -> unit
  val set_matchOnDetail : t -> bool or_undefined -> unit
  val set_placeHolder : t -> string or_undefined -> unit
  val set_prompt : t -> string or_undefined -> unit
  val set_ignoreFocusOut : t -> bool or_undefined -> unit
  val set_canPickMany : t -> bool or_undefined -> unit
  val onDidSelectItem : t -> (item:on_did_select_item_arg0 -> Ojs.t) or_undefined

  val create
    :  ?title:string
    -> ?matchOnDescription:bool
    -> ?matchOnDetail:bool
    -> ?placeHolder:string
    -> ?prompt:string
    -> ?ignoreFocusOut:bool
    -> ?canPickMany:bool
    -> ?onDidSelectItem:(item:on_did_select_item_arg0 -> Ojs.t)
    -> unit
    -> t
end

module QuickPickItemButtonEvent : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val button : t -> QuickInputButton.t
    val item : t -> T.t
    val create : button:QuickInputButton.t -> item:T.t -> unit -> t
  end
end

module QuickInput : sig
  include Ojs.T

  val title : t -> string or_undefined
  val set_title : t -> string or_undefined -> unit
  val step : t -> int or_undefined
  val set_step : t -> int or_undefined -> unit
  val totalSteps : t -> int or_undefined
  val set_totalSteps : t -> int or_undefined -> unit
  val enabled : t -> bool
  val set_enabled : t -> bool -> unit
  val busy : t -> bool
  val set_busy : t -> bool -> unit
  val ignoreFocusOut : t -> bool
  val set_ignoreFocusOut : t -> bool -> unit
  val show : t -> unit
  val hide : t -> unit
  val onDidHide : t -> unit Event.t
  val dispose : t -> unit
end

module QuickPick : sig
  include Js.Generic with type 'a t = private QuickInput.t

  module Make (T : Ojs.T) : sig
    type nonrec t = T.t t

    val onDidAccept : t -> unit Event.t
    val onDidChangeActive : t -> T.t list Event.t
    val onDidChangeSelection : t -> T.t list Event.t
    val onDidChangeValue : t -> string Event.t
    val onDidHide : t -> unit Event.t
    val onDidTriggerButton : t -> QuickInputButton.t Event.t
    val activeItems : t -> T.t list
    val set_activeItems : t -> T.t list -> unit
    val busy : t -> bool
    val set_busy : t -> bool -> unit
    val buttons : t -> QuickInputButton.t list
    val set_buttons : t -> QuickInputButton.t list -> unit
    val canSelectMany : t -> bool
    val set_canSelectMany : t -> bool -> unit
    val enabled : t -> bool
    val set_enabled : t -> bool -> unit
    val ignoreFocusOut : t -> bool
    val set_ignoreFocusOut : t -> bool -> unit
    val items : t -> T.t list
    val set_items : t -> T.t list -> unit
    val keepScrollPosition : t -> bool or_undefined
    val set_keepScrollPosition : t -> bool or_undefined -> unit
    val matchOnDescription : t -> bool
    val set_matchOnDescription : t -> bool -> unit
    val matchOnDetail : t -> bool
    val set_matchOnDetail : t -> bool -> unit
    val placeholder : t -> string or_undefined
    val prompt : t -> string or_undefined
    val set_prompt : t -> string or_undefined -> unit
    val set_placeholder : t -> string or_undefined -> unit
    val selectedItems : t -> T.t list
    val set_selectedItems : t -> T.t list -> unit
    val step : t -> int or_undefined
    val set_step : t -> int or_undefined -> unit
    val title : t -> string or_undefined
    val set_title : t -> string or_undefined -> unit
    val totalSteps : t -> int or_undefined
    val set_totalSteps : t -> int or_undefined -> unit
    val value : t -> string
    val set_value : t -> string -> unit
    val dispose : t -> unit
    val hide : t -> unit
    val show : t -> unit

    val set
      :  t
      -> ?activeItems:T.t list
      -> ?busy:bool
      -> ?buttons:QuickInputButton.t list
      -> ?canSelectMany:bool
      -> ?enabled:bool
      -> ?ignoreFocusOut:bool
      -> ?items:T.t list
      -> ?keepScrollPosition:bool
      -> ?matchOnDescription:bool
      -> ?matchOnDetail:bool
      -> ?placeholder:string
      -> ?prompt:string
      -> ?selectedItems:T.t list
      -> ?step:int
      -> ?title:string
      -> ?totalSteps:int
      -> ?value:string
      -> unit
      -> t

    val onDidTriggerItemButton : t -> T.t QuickPickItemButtonEvent.t Event.t
  end

  val to_quick_input : 'a t -> QuickInput.t
end

module ProviderResult : sig
  type 'a t =
    [ `Value of 'a option
    | `Promise of 'a option Promise.t
    ]

  include Js.Generic with type 'a t := 'a t
end

module InputBoxValidationSeverity : sig
  type t =
    | Info
    | Warning
    | Error

  include Ojs.T with type t := t
end

module InputBoxValidationMessage : sig
  include Ojs.T

  val message : t -> string
  val severity : t -> InputBoxValidationSeverity.t
  val create : message:string -> severity:InputBoxValidationSeverity.t -> unit -> t
end

module InputBoxOptions : sig
  include Ojs.T

  type validate_input_result_value =
    [ `String of string
    | `InputBoxValidationMessage of InputBoxValidationMessage.t
    ]

  val validate_input_result_value_to_js : validate_input_result_value -> Ojs.t
  val validate_input_result_value_of_js : Ojs.t -> validate_input_result_value
  val title : t -> string or_undefined
  val value : t -> string or_undefined
  val valueSelection : t -> (int * int) or_undefined
  val prompt : t -> string or_undefined
  val placeHolder : t -> string or_undefined
  val password : t -> bool or_undefined
  val ignoreFocusOut : t -> bool or_undefined
  val set_title : t -> string or_undefined -> unit
  val set_value : t -> string or_undefined -> unit
  val set_valueSelection : t -> (int * int) or_undefined -> unit
  val set_prompt : t -> string or_undefined -> unit
  val set_placeHolder : t -> string or_undefined -> unit
  val set_password : t -> bool or_undefined -> unit
  val set_ignoreFocusOut : t -> bool or_undefined -> unit

  val validateInput
    :  t
    -> (value:string -> validate_input_result_value ProviderResult.t) or_undefined

  val create
    :  ?title:string
    -> ?value:string
    -> ?valueSelection:int * int
    -> ?prompt:string
    -> ?placeHolder:string
    -> ?password:bool
    -> ?ignoreFocusOut:bool
    -> ?validateInput:(value:string -> validate_input_result_value ProviderResult.t)
    -> unit
    -> t
end

module InputBox : sig
  include Ojs.T with type t = private QuickInput.t

  type validation_message =
    [ `String of string
    | `InputBoxValidationMessage of InputBoxValidationMessage.t
    ]

  val validation_message_to_js : validation_message -> Ojs.t
  val validation_message_of_js : Ojs.t -> validation_message
  val title : t -> string or_undefined
  val set_title : t -> string or_undefined -> unit
  val enabled : t -> bool
  val set_enabled : t -> bool -> unit
  val busy : t -> bool
  val set_busy : t -> bool -> unit
  val ignoreFocusOut : t -> bool
  val set_ignoreFocusOut : t -> bool -> unit
  val onDidHide : t -> unit Event.t
  val value : t -> string
  val set_value : t -> string -> unit
  val valueSelection : t -> (int * int) or_undefined
  val set_valueSelection : t -> (int * int) or_undefined -> unit
  val placeholder : t -> string or_undefined
  val set_placeholder : t -> string or_undefined -> unit
  val password : t -> bool
  val set_password : t -> bool -> unit
  val onDidChangeValue : t -> string Event.t
  val onDidAccept : t -> unit Event.t
  val prompt : t -> string or_undefined
  val set_prompt : t -> string or_undefined -> unit
  val validationMessage : t -> validation_message or_undefined
  val set_validationMessage : t -> validation_message or_undefined -> unit
  val show : t -> unit

  val set
    :  t
    -> ?title:string
    -> ?ignoreFocusOut:bool
    -> ?value:string
    -> ?valueSelection:int * int
    -> ?placeholder:string
    -> ?password:bool
    -> ?prompt:string
    -> ?validationMessage:validation_message
    -> unit
    -> t

  val to_quick_input : t -> QuickInput.t
  val step : t -> int or_undefined
  val set_step : t -> int or_undefined -> unit
  val totalSteps : t -> int or_undefined
  val set_totalSteps : t -> int or_undefined -> unit
  val hide : t -> unit
  val dispose : t -> unit
  val buttons : t -> QuickInputButton.t list
  val set_buttons : t -> QuickInputButton.t list -> unit
  val onDidTriggerButton : t -> QuickInputButton.t Event.t
end

module OpenDialogOptions : sig
  include Ojs.T

  val defaultUri : t -> Uri.t or_undefined
  val set_defaultUri : t -> Uri.t or_undefined -> unit
  val openLabel : t -> string or_undefined
  val set_openLabel : t -> string or_undefined -> unit
  val canSelectFiles : t -> bool or_undefined
  val set_canSelectFiles : t -> bool or_undefined -> unit
  val canSelectFolders : t -> bool or_undefined
  val set_canSelectFolders : t -> bool or_undefined -> unit
  val canSelectMany : t -> bool or_undefined
  val set_canSelectMany : t -> bool or_undefined -> unit
  val filters : t -> string list Dict.t or_undefined
  val set_filters : t -> string list Dict.t or_undefined -> unit
  val title : t -> string or_undefined
  val set_title : t -> string or_undefined -> unit

  val create
    :  ?defaultUri:Uri.t
    -> ?openLabel:string
    -> ?canSelectFiles:bool
    -> ?canSelectFolders:bool
    -> ?canSelectMany:bool
    -> ?filters:string list Dict.t
    -> ?title:string
    -> unit
    -> t
end

module MessageItem : sig
  include Ojs.T

  val title : t -> string
  val isCloseAffordance : t -> bool or_undefined
  val set_title : t -> string -> unit
  val set_isCloseAffordance : t -> bool or_undefined -> unit
  val create : title:string -> ?isCloseAffordance:bool -> unit -> t
end

module Location : sig
  include Ojs.T

  val uri : t -> Uri.t
  val range : t -> Range.t

  val make
    :  uri:Uri.t
    -> rangeOrPosition:[ `Range of Range.t | `Position of Position.t ]
    -> t

  val set_uri : t -> Uri.t -> unit
  val set_range : t -> Range.t -> unit
end

module ProgressLocation : sig
  type t =
    | SourceControl
    | Window
    | Notification

  include Ojs.T with type t := t
end

module ProgressOptions : sig
  include Ojs.T

  type location_item = { viewId : string }

  val location_item_to_js : location_item -> Ojs.t
  val location_item_of_js : Ojs.t -> location_item

  type location_value =
    [ `ProgressLocation of ProgressLocation.t
    | `Options of location_item
    ]

  val location_value_to_js : location_value -> Ojs.t
  val location_value_of_js : Ojs.t -> location_value

  type location =
    [ `ProgressLocation of ProgressLocation.t
    | `ViewIdLocation of viewIdLocation
    ]

  and viewIdLocation = { viewId : string }

  val location : t -> location_value
  val title : t -> string or_undefined
  val cancellable : t -> bool or_undefined
  val set_location : t -> location_value -> unit
  val set_title : t -> string or_undefined -> unit
  val set_cancellable : t -> bool or_undefined -> unit
  val create : location:location_value -> ?title:string -> ?cancellable:bool -> unit -> t
end

module DiagnosticSeverity : sig
  type t =
    | Error
    | Warning
    | Information
    | Hint

  include Ojs.T with type t := t
end

module DiagnosticRelatedInformation : sig
  include Ojs.T

  val location : t -> Location.t
  val message : t -> string
  val make : location:Location.t -> message:string -> t
  val set_location : t -> Location.t -> unit
  val set_message : t -> string -> unit
end

module DiagnosticTag : sig
  type t =
    | Unnecessary
    | Deprecated

  include Ojs.T with type t := t
end

module Diagnostic : sig
  include Ojs.T

  type code_item_value =
    [ `String of string
    | `Int of int
    ]

  val code_item_value_to_js : code_item_value -> Ojs.t
  val code_item_value_of_js : Ojs.t -> code_item_value

  type code_item =
    { value : code_item_value
    ; target : Uri.t
    }

  val code_item_to_js : code_item -> Ojs.t
  val code_item_of_js : Ojs.t -> code_item

  type code_value =
    [ `String of string
    | `Int of int
    | `Options of code_item
    ]

  val code_value_to_js : code_value -> Ojs.t
  val code_value_of_js : Ojs.t -> code_value

  type code_target =
    { value : [ `String of string | `Int of int ]
    ; target : Uri.t
    }

  type code =
    [ `String of string
    | `Int of int
    | `Targeted of code_target
    ]

  val message : t -> string
  val range : t -> Range.t
  val severity : t -> DiagnosticSeverity.t
  val source : t -> string or_undefined
  val code : t -> code_value or_undefined
  val relatedInformation : t -> DiagnosticRelatedInformation.t list or_undefined
  val tags : t -> DiagnosticTag.t list or_undefined
  val make : ?severity:DiagnosticSeverity.t -> message:string -> Range.t -> t
  val set_range : t -> Range.t -> unit
  val set_message : t -> string -> unit
  val set_severity : t -> DiagnosticSeverity.t -> unit
  val set_source : t -> string or_undefined -> unit
  val set_code : t -> code_value or_undefined -> unit

  val set_relatedInformation
    :  t
    -> DiagnosticRelatedInformation.t list or_undefined
    -> unit

  val set_tags : t -> DiagnosticTag.t list or_undefined -> unit
end

module TextDocumentShowOptions : sig
  include Ojs.T

  val viewColumn : t -> ViewColumn.t or_undefined
  val preserveFocus : t -> bool or_undefined
  val preview : t -> bool or_undefined
  val selection : t -> Range.t or_undefined
  val set_viewColumn : t -> ViewColumn.t or_undefined -> unit
  val set_preserveFocus : t -> bool or_undefined -> unit
  val set_preview : t -> bool or_undefined -> unit
  val set_selection : t -> Range.t or_undefined -> unit

  val create
    :  ?viewColumn:ViewColumn.t
    -> ?preserveFocus:bool
    -> ?preview:bool
    -> ?selection:Range.t
    -> unit
    -> t
end

module TerminalLocation : sig
  type t =
    | Panel
    | Editor

  include Ojs.T with type t := t
end

module TerminalEditorLocationOptions : sig
  include Ojs.T

  val viewColumn : t -> ViewColumn.t
  val set_viewColumn : t -> ViewColumn.t -> unit
  val preserveFocus : t -> bool or_undefined
  val set_preserveFocus : t -> bool or_undefined -> unit
  val create : viewColumn:ViewColumn.t -> ?preserveFocus:bool -> unit -> t
end

module TerminalDimensions : sig
  include Ojs.T

  val columns : t -> int
  val rows : t -> int
  val create : columns:int -> rows:int -> unit -> t
end

module Pseudoterminal : sig
  include Ojs.T

  type on_did_close_t =
    [ `Unit of unit
    | `Int of int
    ]

  val on_did_close_t_to_js : on_did_close_t -> Ojs.t
  val on_did_close_t_of_js : Ojs.t -> on_did_close_t
  val onDidWrite : t -> string Event.t

  val onDidOverrideDimensions
    :  t
    -> TerminalDimensions.t or_undefined Event.t or_undefined

  val onDidClose : t -> on_did_close_t Event.t or_undefined
  val close : t -> unit
  val set_onDidWrite : t -> string Event.t -> unit

  val set_onDidOverrideDimensions
    :  t
    -> TerminalDimensions.t or_undefined Event.t or_undefined
    -> unit

  val set_onDidClose : t -> on_did_close_t Event.t or_undefined -> unit
  val onDidChangeName : t -> string Event.t or_undefined
  val set_onDidChangeName : t -> string Event.t or_undefined -> unit
  val open_ : t -> initialDimensions:TerminalDimensions.t or_undefined -> unit
  val handleInput : t -> (data:string -> unit) or_undefined
  val setDimensions : t -> (dimensions:TerminalDimensions.t -> unit) or_undefined

  val create
    :  onDidWrite:string Event.t
    -> ?onDidOverrideDimensions:TerminalDimensions.t or_undefined Event.t
    -> ?onDidClose:on_did_close_t Event.t
    -> ?onDidChangeName:string Event.t
    -> open_:(initialDimensions:TerminalDimensions.t or_undefined -> unit)
    -> close:(unit -> unit)
    -> ?handleInput:(data:string -> unit)
    -> ?setDimensions:(dimensions:TerminalDimensions.t -> unit)
    -> unit
    -> t
end

module TerminalExitReason : sig
  type t =
    | Unknown
    | Shutdown
    | Process
    | User
    | Extension

  include Ojs.T with type t := t
end

module TerminalExitStatus : sig
  include Ojs.T

  val code : t -> int or_undefined
  val reason : t -> TerminalExitReason.t
  val create : code:int or_undefined -> reason:TerminalExitReason.t -> unit -> t
end

module TerminalState : sig
  include Ojs.T

  val isInteractedWith : t -> bool
  val shell : t -> string or_undefined
  val create : isInteractedWith:bool -> shell:string or_undefined -> unit -> t
end

module TerminalShellExecutionCommandLineConfidence : sig
  type t =
    | Low
    | Medium
    | High

  include Ojs.T with type t := t
end

module TerminalShellExecutionCommandLine : sig
  include Ojs.T

  val value : t -> string
  val isTrusted : t -> bool
  val confidence : t -> TerminalShellExecutionCommandLineConfidence.t

  val create
    :  value:string
    -> isTrusted:bool
    -> confidence:TerminalShellExecutionCommandLineConfidence.t
    -> unit
    -> t
end

module IteratorResult : sig
  type 'a t =
    | Done
    | Value of 'a

  include Js.Generic with type 'a t := 'a t
end

module AsyncIterator : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val next : t -> T.t IteratorResult.t Promise.t
    val return : t -> (unit -> T.t IteratorResult.t Promise.t) option

    val create
      :  next:(unit -> T.t IteratorResult.t Promise.t)
      -> ?return:(unit -> T.t IteratorResult.t Promise.t)
      -> unit
      -> t
  end
end

module AsyncIterable : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val iterator : t -> T.t AsyncIterator.t
    val create : iterator:(unit -> T.t AsyncIterator.t) -> t
  end
end

module TerminalShellExecution : sig
  include Ojs.T

  val commandLine : t -> TerminalShellExecutionCommandLine.t
  val cwd : t -> Uri.t or_undefined
  val read : t -> string AsyncIterable.t

  val create
    :  commandLine:TerminalShellExecutionCommandLine.t
    -> cwd:Uri.t or_undefined
    -> read:(unit -> string AsyncIterable.t)
    -> unit
    -> t
end

module TerminalShellIntegration : sig
  include Ojs.T

  val cwd : t -> Uri.t or_undefined
  val executeCommand : t -> commandLine:string -> TerminalShellExecution.t

  val executeCommandArgs
    :  t
    -> executable:string
    -> args:string list
    -> TerminalShellExecution.t
end

module rec TerminalOptions : sig
  include Ojs.T

  type shell_args =
    [ `Items of string list
    | `String of string
    ]

  val shell_args_to_js : shell_args -> Ojs.t
  val shell_args_of_js : Ojs.t -> shell_args

  type cwd_value =
    [ `String of string
    | `Uri of Uri.t
    ]

  val cwd_value_to_js : cwd_value -> Ojs.t
  val cwd_value_of_js : Ojs.t -> cwd_value

  type env_value =
    [ `String of string
    | `Null
    ]

  val env_value_to_js : env_value -> Ojs.t
  val env_value_of_js : Ojs.t -> env_value

  type location =
    [ `TerminalLocation of TerminalLocation.t
    | `TerminalEditorLocationOptions of TerminalEditorLocationOptions.t
    | `TerminalSplitLocationOptions of TerminalSplitLocationOptions.t
    ]

  val location_to_js : location -> Ojs.t
  val location_of_js : Ojs.t -> location

  type shellArgs =
    [ `Arg of string
    | `Args of string list
    ]

  type cwd =
    [ `String of string
    | `Uri of Uri.t
    ]

  val name : t -> string or_undefined
  val shellPath : t -> string or_undefined
  val shellArgs : t -> shell_args or_undefined
  val cwd : t -> cwd_value or_undefined
  val env : t -> env_value or_undefined Dict.t or_undefined
  val strictEnv : t -> bool or_undefined
  val hideFromUser : t -> bool or_undefined
  val shellIntegrationNonce : t -> string or_undefined
  val set_name : t -> string or_undefined -> unit
  val set_shellPath : t -> string or_undefined -> unit
  val set_shellArgs : t -> shell_args or_undefined -> unit
  val set_cwd : t -> cwd_value or_undefined -> unit
  val set_env : t -> env_value or_undefined Dict.t or_undefined -> unit
  val set_strictEnv : t -> bool or_undefined -> unit
  val set_hideFromUser : t -> bool or_undefined -> unit
  val message : t -> string or_undefined
  val set_message : t -> string or_undefined -> unit
  val iconPath : t -> IconPath.t or_undefined
  val set_iconPath : t -> IconPath.t or_undefined -> unit
  val color : t -> ThemeColor.t or_undefined
  val set_color : t -> ThemeColor.t or_undefined -> unit
  val location : t -> location or_undefined
  val set_location : t -> location or_undefined -> unit
  val isTransient : t -> bool or_undefined
  val set_isTransient : t -> bool or_undefined -> unit
  val set_shellIntegrationNonce : t -> string or_undefined -> unit

  val create
    :  ?name:string
    -> ?shellPath:string
    -> ?shellArgs:shell_args
    -> ?cwd:cwd_value
    -> ?env:env_value or_undefined Dict.t
    -> ?strictEnv:bool
    -> ?hideFromUser:bool
    -> ?message:string
    -> ?iconPath:IconPath.t
    -> ?color:ThemeColor.t
    -> ?location:location
    -> ?isTransient:bool
    -> ?shellIntegrationNonce:string
    -> unit
    -> t
end

and TerminalSplitLocationOptions : sig
  include Ojs.T

  val parentTerminal : t -> Terminal.t
  val set_parentTerminal : t -> Terminal.t -> unit
  val create : parentTerminal:Terminal.t -> unit -> t
end

and Terminal : sig
  include Ojs.T

  type creation_options =
    [ `TerminalOptions of TerminalOptions.t
    | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
    ]

  val creation_options_to_js : creation_options -> Ojs.t
  val creation_options_of_js : Ojs.t -> creation_options

  type creationOptions =
    [ `TerminalOptions of TerminalOptions.t
    | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
    ]

  val name : t -> string
  val processId : t -> int or_undefined Promise.t
  val creationOptions : t -> creation_options
  val exitStatus : t -> TerminalExitStatus.t or_undefined
  val state : t -> TerminalState.t
  val shellIntegration : t -> TerminalShellIntegration.t or_undefined
  val sendText : t -> text:string -> ?shouldExecute:bool -> unit -> unit
  val show : t -> ?preserveFocus:bool -> unit -> unit
  val hide : t -> unit
  val dispose : t -> unit
  val disposable : t -> Disposable.t
end

and ExtensionTerminalOptions : sig
  include Ojs.T

  type location =
    [ `TerminalLocation of TerminalLocation.t
    | `TerminalEditorLocationOptions of TerminalEditorLocationOptions.t
    | `TerminalSplitLocationOptions of TerminalSplitLocationOptions.t
    ]

  val location_to_js : location -> Ojs.t
  val location_of_js : Ojs.t -> location
  val name : t -> string
  val pty : t -> Pseudoterminal.t
  val shellIntegrationNonce : t -> string or_undefined
  val set_name : t -> string -> unit
  val set_pty : t -> Pseudoterminal.t -> unit
  val iconPath : t -> IconPath.t or_undefined
  val set_iconPath : t -> IconPath.t or_undefined -> unit
  val color : t -> ThemeColor.t or_undefined
  val set_color : t -> ThemeColor.t or_undefined -> unit
  val location : t -> location or_undefined
  val set_location : t -> location or_undefined -> unit
  val isTransient : t -> bool or_undefined
  val set_isTransient : t -> bool or_undefined -> unit
  val set_shellIntegrationNonce : t -> string or_undefined -> unit

  val create
    :  name:string
    -> pty:Pseudoterminal.t
    -> ?iconPath:IconPath.t
    -> ?color:ThemeColor.t
    -> ?location:location
    -> ?isTransient:bool
    -> ?shellIntegrationNonce:string
    -> unit
    -> t
end

module ExtensionKind : sig
  type t =
    | UI
    | Workspace

  include Ojs.T with type t := t
end

module Extension : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val id : t -> string
    val extensionUri : t -> Uri.t
    val extensionPath : t -> string
    val isActive : t -> bool
    val packageJSON : t -> Ojs.t
    val extensionKind : t -> ExtensionKind.t
    val set_extensionKind : t -> ExtensionKind.t -> unit
    val exports : t -> T.t
    val activate : t -> T.t Promise.t
  end
end

module Extensions : sig
  val getExtension : string -> Ojs.t Extension.t or_undefined
  val getExtensionTyped : 'p_t Js.t -> extensionId:string -> 'p_t Extension.t or_undefined
  val all : unit -> Ojs.t Extension.t list
  val onDidChange : unit -> unit Event.t
end

module TerminalShellIntegrationChangeEvent : sig
  include Ojs.T

  val terminal : t -> Terminal.t
  val shellIntegration : t -> TerminalShellIntegration.t

  val create
    :  terminal:Terminal.t
    -> shellIntegration:TerminalShellIntegration.t
    -> unit
    -> t
end

module TerminalShellExecutionStartEvent : sig
  include Ojs.T

  val terminal : t -> Terminal.t
  val shellIntegration : t -> TerminalShellIntegration.t
  val execution : t -> TerminalShellExecution.t

  val create
    :  terminal:Terminal.t
    -> shellIntegration:TerminalShellIntegration.t
    -> execution:TerminalShellExecution.t
    -> unit
    -> t
end

module TerminalShellExecutionEndEvent : sig
  include Ojs.T

  val terminal : t -> Terminal.t
  val shellIntegration : t -> TerminalShellIntegration.t
  val execution : t -> TerminalShellExecution.t
  val exitCode : t -> int or_undefined

  val create
    :  terminal:Terminal.t
    -> shellIntegration:TerminalShellIntegration.t
    -> execution:TerminalShellExecution.t
    -> exitCode:int or_undefined
    -> unit
    -> t
end

module OutputChannel : sig
  include Ojs.T

  val name : t -> string
  val append : t -> value:string -> unit
  val appendLine : t -> value:string -> unit
  val replace : t -> value:string -> unit
  val clear : t -> unit
  val show : t -> ?preserveFocus:bool -> unit -> unit
  val hide : t -> unit
  val dispose : t -> unit
  val disposable : t -> Disposable.t

  (** @deprecated
        Use the overload with just one parameter ([show(preserveFocus?: boolean): void]).
  *)
  val showInColumn : t -> ?column:ViewColumn.t -> ?preserveFocus:bool -> unit -> unit
end

module OutputChannelOptions : sig
  include Ojs.T

  val log : t -> bool
  val create : unit -> t
end

module Memento : sig
  include Ojs.T

  val get : t -> key:string -> Ojs.t option
  val get_default : 'a Js.t -> t -> key:string -> defaultValue:'a -> 'a
  val update : t -> key:string -> value:Ojs.t -> unit Promise.t
  val keys : t -> string list
  val getTyped : 'p_t Js.t -> t -> key:string -> 'p_t or_undefined
end

module EnvironmentVariableMutatorType : sig
  type t =
    | Replace
    | Append
    | Prepend

  include Ojs.T with type t := t
end

module EnvironmentVariableMutatorOptions : sig
  include Ojs.T

  val applyAtProcessCreation : t -> bool or_undefined
  val set_applyAtProcessCreation : t -> bool or_undefined -> unit
  val applyAtShellIntegration : t -> bool or_undefined
  val set_applyAtShellIntegration : t -> bool or_undefined -> unit
  val create : ?applyAtProcessCreation:bool -> ?applyAtShellIntegration:bool -> unit -> t
end

module EnvironmentVariableMutator : sig
  include Ojs.T

  val type_ : t -> EnvironmentVariableMutatorType.t
  val value : t -> string
  val options : t -> EnvironmentVariableMutatorOptions.t

  val create
    :  type_:EnvironmentVariableMutatorType.t
    -> value:string
    -> options:EnvironmentVariableMutatorOptions.t
    -> unit
    -> t
end

module IterableIterator : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val next : t -> T.t IteratorResult.t
    val return : t -> (unit -> T.t IteratorResult.t) option

    val create
      :  next:(unit -> T.t IteratorResult.t)
      -> ?return:(unit -> T.t IteratorResult.t)
      -> unit
      -> t
  end
end

module EnvironmentVariableCollection : sig
  include Ojs.T

  type description =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val description_to_js : description -> Ojs.t
  val description_of_js : Ojs.t -> description
  val persistent : t -> bool
  val get : t -> variable:string -> EnvironmentVariableMutator.t option
  val delete : t -> variable:string -> unit
  val clear : t -> unit
  val set_persistent : t -> bool -> unit
  val description : t -> description or_undefined
  val set_description : t -> description or_undefined -> unit

  val replace
    :  t
    -> variable:string
    -> value:string
    -> ?options:EnvironmentVariableMutatorOptions.t
    -> unit
    -> unit

  val append
    :  t
    -> variable:string
    -> value:string
    -> ?options:EnvironmentVariableMutatorOptions.t
    -> unit
    -> unit

  val prepend
    :  t
    -> variable:string
    -> value:string
    -> ?options:EnvironmentVariableMutatorOptions.t
    -> unit
    -> unit

  val forEach
    :  t
    -> callback:
         (variable:string
          -> mutator:EnvironmentVariableMutator.t
          -> collection:t
          -> Ojs.t)
    -> ?thisArg:Ojs.t
    -> unit
    -> unit

  val iterator : t -> (string * EnvironmentVariableMutator.t) IterableIterator.t

  val create
    :  persistent:bool
    -> description:description or_undefined
    -> replace:
         (variable:string
          -> value:string
          -> ?options:EnvironmentVariableMutatorOptions.t
          -> unit
          -> unit)
    -> append:
         (variable:string
          -> value:string
          -> ?options:EnvironmentVariableMutatorOptions.t
          -> unit
          -> unit)
    -> prepend:
         (variable:string
          -> value:string
          -> ?options:EnvironmentVariableMutatorOptions.t
          -> unit
          -> unit)
    -> get:(variable:string -> EnvironmentVariableMutator.t or_undefined)
    -> forEach:
         (callback:
            (variable:string
             -> mutator:EnvironmentVariableMutator.t
             -> collection:t
             -> Ojs.t)
          -> ?thisArg:Ojs.t
          -> unit
          -> unit)
    -> delete:(variable:string -> unit)
    -> clear:(unit -> unit)
    -> unit
    -> t
end

module ExtensionMode : sig
  type t =
    | Production
    | Development
    | Test

  include Ojs.T with type t := t
end

module SecretStorageChangeEvent : sig
  include Ojs.T

  val key : t -> string
  val create : key:string -> unit -> t
end

module SecretStorage : sig
  include Ojs.T

  val keys : t -> string list Promise.t
  val get : t -> key:string -> string option Promise.t
  val store : t -> key:string -> value:string -> unit Promise.t
  val delete : t -> key:string -> unit Promise.t
  val onDidChange : t -> SecretStorageChangeEvent.t Event.t

  val create
    :  keys:(unit -> string list Promise.t)
    -> get:(key:string -> string or_undefined Promise.t)
    -> store:(key:string -> value:string -> unit Promise.t)
    -> delete:(key:string -> unit Promise.t)
    -> onDidChange:SecretStorageChangeEvent.t Event.t
    -> unit
    -> t
end

module LanguageModelTextPart : sig
  include Ojs.T

  val value : t -> string
  val set_value : t -> string -> unit
  val make : value:string -> t
end

module LanguageModelToolResultPart : sig
  include Ojs.T

  val callId : t -> string
  val set_callId : t -> string -> unit
  val content : t -> Ojs.t list
  val set_content : t -> Ojs.t list -> unit
  val make : callId:string -> content:Ojs.t list -> t
end

module LanguageModelDataPart : sig
  include Ojs.T

  val image : data:Uint8Array.t -> mime:string -> t
  val json : value:Ojs.t -> ?mime:string -> unit -> t
  val text : value:string -> ?mime:string -> unit -> t
  val mimeType : t -> string
  val set_mimeType : t -> string -> unit
  val data : t -> Uint8Array.t
  val set_data : t -> Uint8Array.t -> unit
  val make : data:Uint8Array.t -> mimeType:string -> t
end

module LanguageModelToolCallPart : sig
  include Ojs.T

  val callId : t -> string
  val set_callId : t -> string -> unit
  val name : t -> string
  val set_name : t -> string -> unit
  val input : t -> Ojs.t
  val set_input : t -> Ojs.t -> unit
  val make : callId:string -> name:string -> input:Ojs.t -> t
end

module LanguageModelInputPart : sig
  type value =
    [ `LanguageModelTextPart of LanguageModelTextPart.t
    | `LanguageModelToolResultPart of LanguageModelToolResultPart.t
    | `LanguageModelToolCallPart of LanguageModelToolCallPart.t
    | `LanguageModelDataPart of LanguageModelDataPart.t
    ]

  val value_to_js : value -> Ojs.t
  val value_of_js : Ojs.t -> value

  type t = value

  include Ojs.T with type t := t
end

module LanguageModelChatMessageRole : sig
  type t =
    | User
    | Assistant

  include Ojs.T with type t := t
end

module LanguageModelChatMessage : sig
  include Ojs.T

  type user_content_item =
    [ `LanguageModelTextPart of LanguageModelTextPart.t
    | `LanguageModelToolResultPart of LanguageModelToolResultPart.t
    | `LanguageModelDataPart of LanguageModelDataPart.t
    ]

  val user_content_item_to_js : user_content_item -> Ojs.t
  val user_content_item_of_js : Ojs.t -> user_content_item

  type user_content =
    [ `String of string
    | `Array of user_content_item list
    ]

  val user_content_to_js : user_content -> Ojs.t
  val user_content_of_js : Ojs.t -> user_content

  type assistant_content_item =
    [ `LanguageModelTextPart of LanguageModelTextPart.t
    | `LanguageModelToolCallPart of LanguageModelToolCallPart.t
    | `LanguageModelDataPart of LanguageModelDataPart.t
    ]

  val assistant_content_item_to_js : assistant_content_item -> Ojs.t
  val assistant_content_item_of_js : Ojs.t -> assistant_content_item

  type assistant_content =
    [ `String of string
    | `Array of assistant_content_item list
    ]

  val assistant_content_to_js : assistant_content -> Ojs.t
  val assistant_content_of_js : Ojs.t -> assistant_content

  type make_content =
    [ `String of string
    | `Array of LanguageModelInputPart.t list
    ]

  val make_content_to_js : make_content -> Ojs.t
  val make_content_of_js : Ojs.t -> make_content
  val user : content:user_content -> ?name:string -> unit -> t
  val assistant : content:assistant_content -> ?name:string -> unit -> t
  val role : t -> LanguageModelChatMessageRole.t
  val set_role : t -> LanguageModelChatMessageRole.t -> unit
  val content : t -> LanguageModelInputPart.t list
  val set_content : t -> LanguageModelInputPart.t list -> unit
  val name : t -> string or_undefined
  val set_name : t -> string or_undefined -> unit

  val make
    :  role:LanguageModelChatMessageRole.t
    -> content:make_content
    -> ?name:string
    -> unit
    -> t
end

module LanguageModelChatResponse : sig
  include Ojs.T

  val stream : t -> Ojs.t AsyncIterable.t
  val set_stream : t -> Ojs.t AsyncIterable.t -> unit
  val text : t -> string AsyncIterable.t
  val set_text : t -> string AsyncIterable.t -> unit
  val create : stream:Ojs.t AsyncIterable.t -> text:string AsyncIterable.t -> unit -> t
end

module LanguageModelChatTool : sig
  include Ojs.T

  val name : t -> string
  val set_name : t -> string -> unit
  val description : t -> string
  val set_description : t -> string -> unit
  val inputSchema : t -> Ojs.t or_undefined
  val set_inputSchema : t -> Ojs.t or_undefined -> unit
  val create : name:string -> description:string -> ?inputSchema:Ojs.t -> unit -> t
end

module LanguageModelChatToolMode : sig
  type t =
    | Auto
    | Required

  include Ojs.T with type t := t
end

module LanguageModelChatRequestOptions : sig
  include Ojs.T

  val justification : t -> string or_undefined
  val set_justification : t -> string or_undefined -> unit
  val modelOptions : t -> Ojs.t Dict.t or_undefined
  val set_modelOptions : t -> Ojs.t Dict.t or_undefined -> unit
  val tools : t -> LanguageModelChatTool.t list or_undefined
  val set_tools : t -> LanguageModelChatTool.t list or_undefined -> unit
  val toolMode : t -> LanguageModelChatToolMode.t or_undefined
  val set_toolMode : t -> LanguageModelChatToolMode.t or_undefined -> unit

  val create
    :  ?justification:string
    -> ?modelOptions:Ojs.t Dict.t
    -> ?tools:LanguageModelChatTool.t list
    -> ?toolMode:LanguageModelChatToolMode.t
    -> unit
    -> t
end

module LanguageModelChat : sig
  include Ojs.T

  type count_tokens_text =
    [ `String of string
    | `LanguageModelChatMessage of LanguageModelChatMessage.t
    ]

  val count_tokens_text_to_js : count_tokens_text -> Ojs.t
  val count_tokens_text_of_js : Ojs.t -> count_tokens_text
  val id : t -> string
  val name : t -> string
  val vendor : t -> string
  val family : t -> string
  val version : t -> string
  val maxInputTokens : t -> int

  val sendRequest
    :  t
    -> messages:LanguageModelChatMessage.t list
    -> ?options:LanguageModelChatRequestOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> LanguageModelChatResponse.t Promise.t

  val countTokens
    :  t
    -> text:count_tokens_text
    -> ?token:CancellationToken.t
    -> unit
    -> int Promise.t

  val create
    :  name:string
    -> id:string
    -> vendor:string
    -> family:string
    -> version:string
    -> maxInputTokens:int
    -> sendRequest:
         (messages:LanguageModelChatMessage.t list
          -> ?options:LanguageModelChatRequestOptions.t
          -> ?token:CancellationToken.t
          -> unit
          -> LanguageModelChatResponse.t Promise.t)
    -> countTokens:
         (text:count_tokens_text -> ?token:CancellationToken.t -> unit -> int Promise.t)
    -> unit
    -> t
end

module LanguageModelAccessInformation : sig
  include Ojs.T

  val onDidChange : t -> unit Event.t
  val canSendRequest : t -> chat:LanguageModelChat.t -> bool option

  val create
    :  onDidChange:unit Event.t
    -> canSendRequest:(chat:LanguageModelChat.t -> bool or_undefined)
    -> unit
    -> t
end

module GlobalMemento : sig
  include module type of Memento with type t = Memento.t

  val setKeysForSync : t -> keys:string list -> unit
end

module EnvironmentVariableScope : sig
  include Ojs.T

  val workspaceFolder : t -> WorkspaceFolder.t or_undefined
  val set_workspaceFolder : t -> WorkspaceFolder.t or_undefined -> unit
  val create : ?workspaceFolder:WorkspaceFolder.t -> unit -> t
end

module GlobalEnvironmentVariableCollection : sig
  include Ojs.T with type t = private EnvironmentVariableCollection.t

  type description =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val description_to_js : description -> Ojs.t
  val description_of_js : Ojs.t -> description
  val to_environment_variable_collection : t -> EnvironmentVariableCollection.t
  val persistent : t -> bool
  val set_persistent : t -> bool -> unit
  val description : t -> description or_undefined
  val set_description : t -> description or_undefined -> unit

  val replace
    :  t
    -> variable:string
    -> value:string
    -> ?options:EnvironmentVariableMutatorOptions.t
    -> unit
    -> unit

  val append
    :  t
    -> variable:string
    -> value:string
    -> ?options:EnvironmentVariableMutatorOptions.t
    -> unit
    -> unit

  val prepend
    :  t
    -> variable:string
    -> value:string
    -> ?options:EnvironmentVariableMutatorOptions.t
    -> unit
    -> unit

  val get : t -> variable:string -> EnvironmentVariableMutator.t or_undefined

  val forEach
    :  t
    -> callback:
         (variable:string
          -> mutator:EnvironmentVariableMutator.t
          -> collection:EnvironmentVariableCollection.t
          -> Ojs.t)
    -> ?thisArg:Ojs.t
    -> unit
    -> unit

  val delete : t -> variable:string -> unit
  val clear : t -> unit
  val getScoped : t -> scope:EnvironmentVariableScope.t -> EnvironmentVariableCollection.t

  val create
    :  persistent:bool
    -> description:description or_undefined
    -> replace:
         (variable:string
          -> value:string
          -> ?options:EnvironmentVariableMutatorOptions.t
          -> unit
          -> unit)
    -> append:
         (variable:string
          -> value:string
          -> ?options:EnvironmentVariableMutatorOptions.t
          -> unit
          -> unit)
    -> prepend:
         (variable:string
          -> value:string
          -> ?options:EnvironmentVariableMutatorOptions.t
          -> unit
          -> unit)
    -> get:(variable:string -> EnvironmentVariableMutator.t or_undefined)
    -> forEach:
         (callback:
            (variable:string
             -> mutator:EnvironmentVariableMutator.t
             -> collection:EnvironmentVariableCollection.t
             -> Ojs.t)
          -> ?thisArg:Ojs.t
          -> unit
          -> unit)
    -> delete:(variable:string -> unit)
    -> clear:(unit -> unit)
    -> getScoped:(scope:EnvironmentVariableScope.t -> EnvironmentVariableCollection.t)
    -> unit
    -> t
end

module ExtensionContext : sig
  include Ojs.T

  type subscriptions_item = { dispose : unit -> Ojs.t }

  val subscriptions_item_to_js : subscriptions_item -> Ojs.t
  val subscriptions_item_of_js : Ojs.t -> subscriptions_item
  val subscriptions : t -> subscriptions_item list
  val workspaceState : t -> Memento.t
  val globalState : t -> GlobalMemento.t
  val secrets : t -> SecretStorage.t
  val extensionUri : t -> Uri.t
  val extensionPath : t -> string
  val environmentVariableCollection : t -> GlobalEnvironmentVariableCollection.t
  val asAbsolutePath : t -> relativePath:string -> string
  val storageUri : t -> Uri.t or_undefined
  val globalStorageUri : t -> Uri.t
  val logUri : t -> Uri.t
  val extensionMode : t -> ExtensionMode.t
  val languageModelAccessInformation : t -> LanguageModelAccessInformation.t
  val subscribe : t -> disposable:Disposable.t -> unit

  (** @deprecated Use storageUri instead. *)
  val storagePath : t -> string or_undefined

  (** @deprecated Use globalStorageUri instead. *)
  val globalStoragePath : t -> string

  (** @deprecated Use logUri instead. *)
  val logPath : t -> string

  val extension : t -> Ojs.t Extension.t

  val create
    :  subscriptions:subscriptions_item list
    -> workspaceState:Memento.t
    -> globalState:GlobalMemento.t
    -> secrets:SecretStorage.t
    -> extensionUri:Uri.t
    -> extensionPath:string
    -> environmentVariableCollection:GlobalEnvironmentVariableCollection.t
    -> asAbsolutePath:(relativePath:string -> string)
    -> storageUri:Uri.t or_undefined
    -> storagePath:string or_undefined
    -> globalStorageUri:Uri.t
    -> globalStoragePath:string
    -> logUri:Uri.t
    -> logPath:string
    -> extensionMode:ExtensionMode.t
    -> extension:Ojs.t Extension.t
    -> languageModelAccessInformation:LanguageModelAccessInformation.t
    -> unit
    -> t
end

module ShellQuotingOptions : sig
  include Ojs.T

  type escape_item =
    { escapeChar : string
    ; charsToEscape : string
    }

  val escape_item_to_js : escape_item -> Ojs.t
  val escape_item_of_js : Ojs.t -> escape_item

  type escape_value =
    [ `String of string
    | `Options of escape_item
    ]

  val escape_value_to_js : escape_value -> Ojs.t
  val escape_value_of_js : Ojs.t -> escape_value

  type escapeLiteral =
    { escapeChar : string
    ; charsToEscape : string
    }

  type escape =
    [ `String of string
    | `Literal of escapeLiteral
    ]

  val escape : t -> escape_value or_undefined
  val strong : t -> string or_undefined
  val weak : t -> string or_undefined
  val set_escape : t -> escape_value or_undefined -> unit
  val set_strong : t -> string or_undefined -> unit
  val set_weak : t -> string or_undefined -> unit
  val create : ?escape:escape_value -> ?strong:string -> ?weak:string -> unit -> t
end

module ShellExecutionOptions : sig
  include Ojs.T

  val executable : t -> string or_undefined
  val shellArgs : t -> string list or_undefined
  val shellQuoting : t -> ShellQuotingOptions.t or_undefined
  val cwd : t -> string or_undefined
  val env : t -> string Dict.t or_undefined
  val set_executable : t -> string or_undefined -> unit
  val set_shellArgs : t -> string list or_undefined -> unit
  val set_shellQuoting : t -> ShellQuotingOptions.t or_undefined -> unit
  val set_cwd : t -> string or_undefined -> unit
  val set_env : t -> string Dict.t or_undefined -> unit

  val create
    :  ?executable:string
    -> ?shellArgs:string list
    -> ?shellQuoting:ShellQuotingOptions.t
    -> ?cwd:string
    -> ?env:string Dict.t
    -> unit
    -> t
end

module ShellQuoting : sig
  type t =
    | Escape
    | Strong
    | Weak

  include Ojs.T with type t := t
end

module ShellQuotedString : sig
  include Ojs.T

  val value : t -> string
  val quoting : t -> ShellQuoting.t
  val set_value : t -> string -> unit
  val set_quoting : t -> ShellQuoting.t -> unit
  val create : value:string -> quoting:ShellQuoting.t -> unit -> t
end

module ShellExecution : sig
  include Ojs.T

  type command =
    [ `String of string
    | `ShellQuotedString of ShellQuotedString.t
    ]

  val command_to_js : command -> Ojs.t
  val command_of_js : Ojs.t -> command

  type args_item =
    [ `String of string
    | `ShellQuotedString of ShellQuotedString.t
    ]

  val args_item_to_js : args_item -> Ojs.t
  val args_item_of_js : Ojs.t -> args_item

  type shellString =
    [ `String of string
    | `ShellQuotedString of ShellQuotedString.t
    ]

  val makeCommandLine
    :  commandLine:string
    -> ?options:ShellExecutionOptions.t
    -> unit
    -> t

  val makeCommandArgs
    :  command:shellString
    -> args:shellString list
    -> ?options:ShellExecutionOptions.t
    -> unit
    -> t

  val commandLine : t -> string or_undefined
  val command : t -> command or_undefined
  val args : t -> args_item list or_undefined
  val options : t -> ShellExecutionOptions.t or_undefined
  val set_commandLine : t -> string or_undefined -> unit
  val set_command : t -> command or_undefined -> unit
  val set_args : t -> args_item list or_undefined -> unit
  val set_options : t -> ShellExecutionOptions.t or_undefined -> unit
end

module ProcessExecutionOptions : sig
  include Ojs.T

  val cwd : t -> string or_undefined
  val env : t -> string Dict.t or_undefined
  val set_cwd : t -> string or_undefined -> unit
  val set_env : t -> string Dict.t or_undefined -> unit
  val create : ?cwd:string -> ?env:string Dict.t -> unit -> t
end

module ProcessExecution : sig
  include Ojs.T

  val makeProcess : process:string -> ?options:ProcessExecutionOptions.t -> unit -> t

  val makeProcessArgs
    :  process:string
    -> args:string list
    -> ?options:ProcessExecutionOptions.t
    -> unit
    -> t

  val process : t -> string
  val args : t -> string list
  val options : t -> ProcessExecutionOptions.t or_undefined
  val set_process : t -> string -> unit
  val set_args : t -> string list -> unit
  val set_options : t -> ProcessExecutionOptions.t or_undefined -> unit
end

module TaskDefinition : sig
  include Ojs.T

  val type_ : t -> string
  val get_attribute : t -> string -> Ojs.t
  val set_attribute : t -> string -> Ojs.t -> unit
  val create : type_:string -> ?attributes:(string * Ojs.t) list -> unit -> t
  val getProperty : t -> key:string -> Ojs.t or_undefined
  val setProperty : t -> key:string -> value:Ojs.t -> unit
end

module CustomExecution : sig
  include Ojs.T

  val make
    :  callback:(resolvedDefinition:TaskDefinition.t -> Pseudoterminal.t Promise.t)
    -> t
end

module RelativePattern : sig
  include Ojs.T

  (** @deprecated This property is deprecated, please use RelativePattern.baseUri instead.
  *)
  val base : t -> string

  val pattern : t -> string

  val make
    :  base:[ `String of string | `Uri of Uri.t | `WorkspaceFolder of WorkspaceFolder.t ]
    -> pattern:string
    -> t

  val baseUri : t -> Uri.t
  val set_baseUri : t -> Uri.t -> unit

  (** @deprecated This property is deprecated, please use RelativePattern.baseUri instead.
  *)
  val set_base : t -> string -> unit

  val set_pattern : t -> string -> unit
end

module GlobPattern : sig
  type t =
    [ `String of string
    | `RelativePattern of RelativePattern.t
    ]

  include Ojs.T with type t := t
end

module DocumentFilter : sig
  include Ojs.T

  val language : t -> string or_undefined
  val scheme : t -> string or_undefined
  val pattern : t -> GlobPattern.t or_undefined
  val notebookType : t -> string or_undefined

  val create
    :  ?language:string
    -> ?notebookType:string
    -> ?scheme:string
    -> ?pattern:GlobPattern.t
    -> unit
    -> t
end

module DocumentSelector : sig
  type selector =
    [ `Filter of DocumentFilter.t
    | `String of string
    ]

  type t =
    [ selector
    | `List of selector list
    ]

  include Ojs.T with type t := t
end

module DocumentFormattingEditProvider : sig
  include Ojs.T

  val provideDocumentFormattingEdits
    :  t
    -> document:TextDocument.t
    -> options:FormattingOptions.t
    -> token:CancellationToken.t
    -> TextEdit.t list ProviderResult.t

  val create
    :  provideDocumentFormattingEdits:
         (document:TextDocument.t
          -> options:FormattingOptions.t
          -> token:CancellationToken.t
          -> TextEdit.t list ProviderResult.t)
    -> unit
    -> t
end

module Hover : sig
  include Ojs.T

  type contents_item =
    [ `MarkdownString of MarkdownString.t
    | `MarkedString of MarkedString.t
    ]

  val contents_item_to_js : contents_item -> Ojs.t
  val contents_item_of_js : Ojs.t -> contents_item

  type make_with_contents =
    [ `MarkdownString of MarkdownString.t
    | `MarkedString of MarkedString.t
    | `Array of contents_item list
    ]

  val make_with_contents_to_js : make_with_contents -> Ojs.t
  val make_with_contents_of_js : Ojs.t -> make_with_contents
  val contents : t -> contents_item list
  val range : t -> Range.t or_undefined

  val make
    :  contents:
         [ `MarkdownString of MarkdownString.t
         | `MarkdownStringArray of MarkdownString.t list
         ]
    -> ?range:Range.t
    -> unit
    -> t

  val set_contents : t -> contents_item list -> unit
  val set_range : t -> Range.t or_undefined -> unit
  val makeWithContents : contents:make_with_contents -> ?range:Range.t -> unit -> t
end

module HoverProvider : sig
  include Ojs.T

  val provideHover
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> token:CancellationToken.t
    -> Hover.t ProviderResult.t

  val create
    :  provideHover:
         (document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> Hover.t ProviderResult.t)
    -> unit
    -> t
end

module TaskGroup : sig
  include Ojs.T

  val clean : t
  val build : t
  val rebuild : t
  val test : t
  val set_clean : t -> unit
  val set_build : t -> unit
  val set_rebuild : t -> unit
  val set_test : t -> unit
  val isDefault : t -> bool or_undefined
  val id : t -> string
end

module TaskScope : sig
  type t =
    | Global
    | Workspace

  include Ojs.T with type t := t
end

module RunOptions : sig
  include Ojs.T

  val reevaluateOnRerun : t -> bool or_undefined
  val set_reevaluateOnRerun : t -> bool or_undefined -> unit
  val create : ?reevaluateOnRerun:bool -> unit -> t
end

module TaskRevealKind : sig
  type t =
    | Always
    | Silent
    | Never

  include Ojs.T with type t := t
end

module TaskPanelKind : sig
  type t =
    | Shared
    | Dedicated
    | New

  include Ojs.T with type t := t
end

module TaskPresentationOptions : sig
  include Ojs.T

  val reveal : t -> TaskRevealKind.t or_undefined
  val echo : t -> bool or_undefined
  val focus : t -> bool or_undefined
  val panel : t -> TaskPanelKind.t or_undefined
  val showReuseMessage : t -> bool or_undefined
  val clear : t -> bool or_undefined
  val set_reveal : t -> TaskRevealKind.t or_undefined -> unit
  val set_echo : t -> bool or_undefined -> unit
  val set_focus : t -> bool or_undefined -> unit
  val set_panel : t -> TaskPanelKind.t or_undefined -> unit
  val set_showReuseMessage : t -> bool or_undefined -> unit
  val set_clear : t -> bool or_undefined -> unit
  val close : t -> bool or_undefined
  val set_close : t -> bool or_undefined -> unit

  val create
    :  ?reveal:TaskRevealKind.t
    -> ?echo:bool
    -> ?focus:bool
    -> ?panel:TaskPanelKind.t
    -> ?showReuseMessage:bool
    -> ?clear:bool
    -> ?close:bool
    -> unit
    -> t
end

module Task : sig
  include Ojs.T

  type make_with_scope =
    [ `WorkspaceFolder of WorkspaceFolder.t
    | `TaskScope of TaskScope.t
    ]

  val make_with_scope_to_js : make_with_scope -> Ojs.t
  val make_with_scope_of_js : Ojs.t -> make_with_scope

  type make_with_scope_execution =
    [ `ProcessExecution of ProcessExecution.t
    | `ShellExecution of ShellExecution.t
    | `CustomExecution of CustomExecution.t
    ]

  val make_with_scope_execution_to_js : make_with_scope_execution -> Ojs.t
  val make_with_scope_execution_of_js : Ojs.t -> make_with_scope_execution

  type make_with_scope_problem_matchers =
    [ `String of string
    | `Items of string list
    ]

  val make_with_scope_problem_matchers_to_js : make_with_scope_problem_matchers -> Ojs.t
  val make_with_scope_problem_matchers_of_js : Ojs.t -> make_with_scope_problem_matchers

  type make_without_scope_execution =
    [ `ProcessExecution of ProcessExecution.t
    | `ShellExecution of ShellExecution.t
    ]

  val make_without_scope_execution_to_js : make_without_scope_execution -> Ojs.t
  val make_without_scope_execution_of_js : Ojs.t -> make_without_scope_execution

  type scope =
    [ `TaskScope of TaskScope.t
    | `WorkspaceFolder of WorkspaceFolder.t
    ]

  val scope_to_js : scope -> Ojs.t
  val scope_of_js : Ojs.t -> scope

  type execution =
    [ `ProcessExecution of ProcessExecution.t
    | `ShellExecution of ShellExecution.t
    | `CustomExecution of CustomExecution.t
    ]

  val make
    :  definition:TaskDefinition.t
    -> scope:TaskScope.t
    -> name:string
    -> source:string
    -> ?execution:execution
    -> ?problemMatchers:string list
    -> unit
    -> t

  val definition : t -> TaskDefinition.t
  val scope : t -> scope or_undefined
  val name : t -> string
  val detail : t -> string or_undefined
  val execution : t -> make_with_scope_execution or_undefined
  val isBackground : t -> bool
  val source : t -> string
  val group : t -> TaskGroup.t or_undefined
  val presentationOptions : t -> TaskPresentationOptions.t
  val runOptions : t -> RunOptions.t
  val set_group : t -> TaskGroup.t or_undefined -> unit

  val makeWithScope
    :  taskDefinition:TaskDefinition.t
    -> scope:make_with_scope
    -> name:string
    -> source:string
    -> ?execution:make_with_scope_execution
    -> ?problemMatchers:make_with_scope_problem_matchers
    -> unit
    -> t

  (** @deprecated Use the new constructors that allow specifying a scope for the task. *)
  val makeWithoutScope
    :  taskDefinition:TaskDefinition.t
    -> name:string
    -> source:string
    -> ?execution:make_without_scope_execution
    -> ?problemMatchers:make_with_scope_problem_matchers
    -> unit
    -> t

  val set_definition : t -> TaskDefinition.t -> unit
  val set_name : t -> string -> unit
  val set_detail : t -> string or_undefined -> unit
  val set_execution : t -> make_with_scope_execution or_undefined -> unit
  val set_isBackground : t -> bool -> unit
  val set_source : t -> string -> unit
  val set_presentationOptions : t -> TaskPresentationOptions.t -> unit
  val problemMatchers : t -> string list
  val set_problemMatchers : t -> string list -> unit
  val set_runOptions : t -> RunOptions.t -> unit
end

module TaskProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    type nonrec t = T.t t

    val provideTasks : t -> token:CancellationToken.t -> T.t list ProviderResult.t
    val resolveTask : t -> task:T.t -> token:CancellationToken.t -> T.t ProviderResult.t

    val create
      :  provideTasks:(token:CancellationToken.t -> T.t list ProviderResult.t)
      -> resolveTask:(task:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
      -> unit
      -> t
  end

  module Default : module type of Make (Task)
end

module ConfigurationScope : sig
  type language =
    { uri : Uri.t or_undefined
    ; languageId : string
    }

  type t =
    [ `Uri of Uri.t
    | `TextDocument of TextDocument.t
    | `WorkspaceFolder of WorkspaceFolder.t
    | `Language of language
    ]

  include Ojs.T with type t := t
end

module MessageOptions : sig
  include Ojs.T

  val modal : t -> bool or_undefined
  val set_modal : t -> bool or_undefined -> unit
  val detail : t -> string or_undefined
  val set_detail : t -> string or_undefined -> unit
  val create : ?modal:bool -> ?detail:string -> unit -> t
end

module Progress : sig
  include Js.Generic

  type value =
    { message : string option
    ; increment : float option
    }

  val value_to_js : value -> Ojs.t
  val value_of_js : Ojs.t -> value

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val report : t -> value:T.t -> unit
  end
end

module TextDocumentContentChangeEvent : sig
  include Ojs.T

  val range : t -> Range.t
  val rangeLength : t -> int
  val rangeOffset : t -> int
  val text : t -> string

  val create
    :  range:Range.t
    -> rangeOffset:int
    -> rangeLength:int
    -> text:string
    -> unit
    -> t
end

module TextDocumentChangeReason : sig
  type t =
    | Undo
    | Redo

  include Ojs.T with type t := t
end

module TextDocumentChangeEvent : sig
  include Ojs.T

  val contentChanges : t -> TextDocumentContentChangeEvent.t list
  val document : t -> TextDocument.t
  val reason : t -> TextDocumentChangeReason.t or_undefined

  val create
    :  document:TextDocument.t
    -> contentChanges:TextDocumentContentChangeEvent.t list
    -> reason:TextDocumentChangeReason.t or_undefined
    -> unit
    -> t
end

module TextDocumentContentProvider : sig
  include Ojs.T

  val onDidChange : t -> Uri.t Event.t or_undefined

  val provideTextDocumentContent
    :  t
    -> uri:Uri.t
    -> token:CancellationToken.t
    -> string ProviderResult.t

  val set_onDidChange : t -> Uri.t Event.t or_undefined -> unit

  val create
    :  ?onDidChange:Uri.t Event.t
    -> provideTextDocumentContent:
         (uri:Uri.t -> token:CancellationToken.t -> string ProviderResult.t)
    -> unit
    -> t
end

module FileSystemWatcher : sig
  include Ojs.T with type t = private Disposable.t

  type from_disposable_likes_item = { dispose : unit -> Ojs.t }

  val from_disposable_likes_item_to_js : from_disposable_likes_item -> Ojs.t
  val from_disposable_likes_item_of_js : Ojs.t -> from_disposable_likes_item
  val onDidChange : t -> Uri.t Event.t
  val to_disposable : t -> Disposable.t
  val from : disposableLikes:from_disposable_likes_item list -> Disposable.t
  val dispose : t -> Ojs.t
  val ignoreCreateEvents : t -> bool
  val ignoreChangeEvents : t -> bool
  val ignoreDeleteEvents : t -> bool
  val onDidCreate : t -> Uri.t Event.t
  val onDidDelete : t -> Uri.t Event.t
end

module ConfigurationChangeEvent : sig
  include Ojs.T

  val affectsConfiguration
    :  t
    -> section:string
    -> ?scope:ConfigurationScope.t
    -> unit
    -> bool

  val create
    :  affectsConfiguration:(section:string -> ?scope:ConfigurationScope.t -> unit -> bool)
    -> unit
    -> t
end

module TextEncodingOptions : sig
  include Ojs.T

  val encoding : t -> string option
  val uri : t -> Uri.t option
  val of_encoding : encoding:string -> t
  val of_uri : uri:Uri.t -> t
end

module TextDocumentEncodingOptions : sig
  include Ojs.T

  val encoding : t -> string option
  val create : ?encoding:string -> unit -> t
end

module TextDocumentOpenOptions : sig
  include Ojs.T

  val encoding : t -> string option
  val language : t -> string option
  val content : t -> string option
  val create : ?encoding:string -> ?language:string -> ?content:string -> unit -> t
end

module FileType : sig
  (** Bit flags. [combine] preserves combinations returned by VS Code. *)
  type t = private int

  include Ojs.T with type t := t

  val unknown : t
  val file : t
  val directory : t
  val symbolicLink : t
  val combine : t list -> t
  val mem : t -> flag:t -> bool
end

module FilePermission : sig
  type t = Readonly

  include Ojs.T with type t := t
end

module FileStat : sig
  include Ojs.T

  val type_ : t -> FileType.t
  val set_type_ : t -> FileType.t -> unit
  val ctime : t -> float
  val set_ctime : t -> float -> unit
  val mtime : t -> float
  val set_mtime : t -> float -> unit
  val size : t -> float
  val set_size : t -> float -> unit
  val permissions : t -> FilePermission.t or_undefined
  val set_permissions : t -> FilePermission.t or_undefined -> unit

  val create
    :  type_:FileType.t
    -> ctime:float
    -> mtime:float
    -> size:float
    -> ?permissions:FilePermission.t
    -> unit
    -> t
end

module FileSystem : sig
  include Ojs.T

  type delete_options =
    { recursive : bool or_undefined
    ; useTrash : bool or_undefined
    }

  val delete_options_to_js : delete_options -> Ojs.t
  val delete_options_of_js : Ojs.t -> delete_options

  type rename_options = { overwrite : bool or_undefined }

  val rename_options_to_js : rename_options -> Ojs.t
  val rename_options_of_js : Ojs.t -> rename_options
  val stat : t -> uri:Uri.t -> FileStat.t Promise.t
  val readDirectory : t -> uri:Uri.t -> (string * FileType.t) list Promise.t
  val createDirectory : t -> uri:Uri.t -> unit Promise.t
  val readFile : t -> uri:Uri.t -> Uint8Array.t Promise.t
  val writeFile : t -> uri:Uri.t -> content:Uint8Array.t -> unit Promise.t
  val delete : t -> uri:Uri.t -> ?options:delete_options -> unit -> unit Promise.t

  val rename
    :  t
    -> source:Uri.t
    -> target:Uri.t
    -> ?options:rename_options
    -> unit
    -> unit Promise.t

  val copy
    :  t
    -> source:Uri.t
    -> target:Uri.t
    -> ?options:rename_options
    -> unit
    -> unit Promise.t

  val isWritableFileSystem : t -> scheme:string -> bool or_undefined

  val create
    :  stat:(uri:Uri.t -> FileStat.t Promise.t)
    -> readDirectory:(uri:Uri.t -> (string * FileType.t) list Promise.t)
    -> createDirectory:(uri:Uri.t -> unit Promise.t)
    -> readFile:(uri:Uri.t -> Uint8Array.t Promise.t)
    -> writeFile:(uri:Uri.t -> content:Uint8Array.t -> unit Promise.t)
    -> delete:(uri:Uri.t -> ?options:delete_options -> unit -> unit Promise.t)
    -> rename:
         (source:Uri.t
          -> target:Uri.t
          -> ?options:rename_options
          -> unit
          -> unit Promise.t)
    -> copy:
         (source:Uri.t
          -> target:Uri.t
          -> ?options:rename_options
          -> unit
          -> unit Promise.t)
    -> isWritableFileSystem:(scheme:string -> bool or_undefined)
    -> unit
    -> t
end

module WorkspaceEditMetadata : sig
  include Ojs.T

  val isRefactoring : t -> bool or_undefined
  val set_isRefactoring : t -> bool or_undefined -> unit
  val create : ?isRefactoring:bool -> unit -> t
end

module TextDocumentSaveReason : sig
  type t =
    | Manual
    | AfterDelay
    | FocusOut

  include Ojs.T with type t := t
end

module TextDocumentWillSaveEvent : sig
  include Ojs.T

  val document : t -> TextDocument.t
  val reason : t -> TextDocumentSaveReason.t
  val waitUntil : t -> thenable:TextEdit.t list Promise.t -> unit
  val waitUntilDone : t -> thenable:Ojs.t Promise.t -> unit
end

module rec NotebookDocument : sig
  include Ojs.T

  val uri : t -> Uri.t
  val notebookType : t -> string
  val version : t -> int
  val isDirty : t -> bool
  val isUntitled : t -> bool
  val isClosed : t -> bool
  val metadata : t -> Ojs.t Dict.t
  val cellCount : t -> int
  val cellAt : t -> index:int -> NotebookCell.t
  val getCells : t -> ?range:NotebookRange.t -> unit -> NotebookCell.t list
  val save : t -> bool Promise.t
end

and NotebookCell : sig
  include Ojs.T

  val index : t -> int
  val notebook : t -> NotebookDocument.t
  val kind : t -> NotebookCellKind.t
  val document : t -> TextDocument.t
  val metadata : t -> Ojs.t Dict.t
  val outputs : t -> NotebookCellOutput.t list
  val executionSummary : t -> NotebookCellExecutionSummary.t or_undefined
end

module NotebookData : sig
  include Ojs.T

  val cells : t -> NotebookCellData.t list
  val set_cells : t -> NotebookCellData.t list -> unit
  val metadata : t -> Ojs.t Dict.t or_undefined
  val set_metadata : t -> Ojs.t Dict.t or_undefined -> unit
  val make : cells:NotebookCellData.t list -> t
end

module NotebookDocumentContentChange : sig
  include Ojs.T

  val range : t -> NotebookRange.t
  val addedCells : t -> NotebookCell.t list
  val removedCells : t -> NotebookCell.t list

  val create
    :  range:NotebookRange.t
    -> addedCells:NotebookCell.t list
    -> removedCells:NotebookCell.t list
    -> unit
    -> t
end

module NotebookDocumentCellChange : sig
  include Ojs.T

  val cell : t -> NotebookCell.t
  val document : t -> TextDocument.t or_undefined
  val metadata : t -> Ojs.t Dict.t or_undefined
  val outputs : t -> NotebookCellOutput.t list or_undefined
  val executionSummary : t -> NotebookCellExecutionSummary.t or_undefined

  val create
    :  cell:NotebookCell.t
    -> document:TextDocument.t or_undefined
    -> metadata:Ojs.t Dict.t or_undefined
    -> outputs:NotebookCellOutput.t list or_undefined
    -> executionSummary:NotebookCellExecutionSummary.t or_undefined
    -> unit
    -> t
end

module NotebookDocumentChangeEvent : sig
  include Ojs.T

  val notebook : t -> NotebookDocument.t
  val metadata : t -> Ojs.t Dict.t or_undefined
  val contentChanges : t -> NotebookDocumentContentChange.t list
  val cellChanges : t -> NotebookDocumentCellChange.t list

  val create
    :  notebook:NotebookDocument.t
    -> metadata:Ojs.t Dict.t or_undefined
    -> contentChanges:NotebookDocumentContentChange.t list
    -> cellChanges:NotebookDocumentCellChange.t list
    -> unit
    -> t
end

module NotebookDocumentWillSaveEvent : sig
  include Ojs.T

  val token : t -> CancellationToken.t
  val notebook : t -> NotebookDocument.t
  val reason : t -> TextDocumentSaveReason.t
  val waitUntil : t -> thenable:WorkspaceEdit.t Promise.t -> unit
  val waitUntilDone : t -> thenable:Ojs.t Promise.t -> unit
end

module NotebookSerializer : sig
  include Ojs.T

  type deserialize_notebook_result =
    [ `Value of NotebookData.t
    | `Promise of NotebookData.t Promise.t
    ]

  val deserialize_notebook_result_to_js : deserialize_notebook_result -> Ojs.t
  val deserialize_notebook_result_of_js : Ojs.t -> deserialize_notebook_result

  type serialize_notebook_result =
    [ `Value of Uint8Array.t
    | `Promise of Uint8Array.t Promise.t
    ]

  val serialize_notebook_result_to_js : serialize_notebook_result -> Ojs.t
  val serialize_notebook_result_of_js : Ojs.t -> serialize_notebook_result

  val deserializeNotebook
    :  t
    -> content:Uint8Array.t
    -> token:CancellationToken.t
    -> deserialize_notebook_result

  val serializeNotebook
    :  t
    -> data:NotebookData.t
    -> token:CancellationToken.t
    -> serialize_notebook_result

  val create
    :  deserializeNotebook:
         (content:Uint8Array.t
          -> token:CancellationToken.t
          -> deserialize_notebook_result)
    -> serializeNotebook:
         (data:NotebookData.t -> token:CancellationToken.t -> serialize_notebook_result)
    -> unit
    -> t
end

module NotebookDocumentContentOptions : sig
  include Ojs.T

  val transientOutputs : t -> bool or_undefined
  val set_transientOutputs : t -> bool or_undefined -> unit
  val transientCellMetadata : t -> bool or_undefined Dict.t or_undefined
  val set_transientCellMetadata : t -> bool or_undefined Dict.t or_undefined -> unit
  val transientDocumentMetadata : t -> bool or_undefined Dict.t or_undefined
  val set_transientDocumentMetadata : t -> bool or_undefined Dict.t or_undefined -> unit

  val create
    :  ?transientOutputs:bool
    -> ?transientCellMetadata:bool or_undefined Dict.t
    -> ?transientDocumentMetadata:bool or_undefined Dict.t
    -> unit
    -> t
end

module FileWillCreateEvent : sig
  include Ojs.T

  val token : t -> CancellationToken.t
  val files : t -> Uri.t list
  val waitUntil : t -> thenable:WorkspaceEdit.t Promise.t -> unit
  val waitUntilDone : t -> thenable:Ojs.t Promise.t -> unit
end

module FileCreateEvent : sig
  include Ojs.T

  val files : t -> Uri.t list
  val create : files:Uri.t list -> unit -> t
end

module FileWillDeleteEvent : sig
  include Ojs.T

  val token : t -> CancellationToken.t
  val files : t -> Uri.t list
  val waitUntil : t -> thenable:WorkspaceEdit.t Promise.t -> unit
  val waitUntilDone : t -> thenable:Ojs.t Promise.t -> unit
end

module FileDeleteEvent : sig
  include Ojs.T

  val files : t -> Uri.t list
  val create : files:Uri.t list -> unit -> t
end

module FileWillRenameEvent : sig
  include Ojs.T

  type files_item =
    { oldUri : Uri.t
    ; newUri : Uri.t
    }

  val files_item_to_js : files_item -> Ojs.t
  val files_item_of_js : Ojs.t -> files_item
  val token : t -> CancellationToken.t
  val files : t -> files_item list
  val waitUntil : t -> thenable:WorkspaceEdit.t Promise.t -> unit
  val waitUntilDone : t -> thenable:Ojs.t Promise.t -> unit
end

module FileRenameEvent : sig
  include Ojs.T

  type files_item =
    { oldUri : Uri.t
    ; newUri : Uri.t
    }

  val files_item_to_js : files_item -> Ojs.t
  val files_item_of_js : Ojs.t -> files_item
  val files : t -> files_item list
  val create : files:files_item list -> unit -> t
end

module FileChangeType : sig
  type t =
    | Changed
    | Created
    | Deleted

  include Ojs.T with type t := t
end

module FileChangeEvent : sig
  include Ojs.T

  val type_ : t -> FileChangeType.t
  val uri : t -> Uri.t
  val create : type_:FileChangeType.t -> uri:Uri.t -> unit -> t
end

module FileSystemProvider : sig
  include Ojs.T

  type watch_options =
    { recursive : bool
    ; excludes : string list
    }

  val watch_options_to_js : watch_options -> Ojs.t
  val watch_options_of_js : Ojs.t -> watch_options

  type stat_result =
    [ `Value of FileStat.t
    | `Promise of FileStat.t Promise.t
    ]

  val stat_result_to_js : stat_result -> Ojs.t
  val stat_result_of_js : Ojs.t -> stat_result

  type read_directory_result =
    [ `Value of (string * FileType.t) list
    | `Promise of (string * FileType.t) list Promise.t
    ]

  val read_directory_result_to_js : read_directory_result -> Ojs.t
  val read_directory_result_of_js : Ojs.t -> read_directory_result

  type create_directory_result =
    [ `Unit of unit
    | `Promise of unit Promise.t
    ]

  val create_directory_result_to_js : create_directory_result -> Ojs.t
  val create_directory_result_of_js : Ojs.t -> create_directory_result

  type read_file_result =
    [ `Value of Uint8Array.t
    | `Promise of Uint8Array.t Promise.t
    ]

  val read_file_result_to_js : read_file_result -> Ojs.t
  val read_file_result_of_js : Ojs.t -> read_file_result

  type write_file_options =
    { create : bool
    ; overwrite : bool
    }

  val write_file_options_to_js : write_file_options -> Ojs.t
  val write_file_options_of_js : Ojs.t -> write_file_options

  type delete_options = { recursive : bool }

  val delete_options_to_js : delete_options -> Ojs.t
  val delete_options_of_js : Ojs.t -> delete_options

  type rename_options = { overwrite : bool }

  val rename_options_to_js : rename_options -> Ojs.t
  val rename_options_of_js : Ojs.t -> rename_options
  val onDidChangeFile : t -> FileChangeEvent.t list Event.t
  val watch : t -> uri:Uri.t -> options:watch_options -> Disposable.t
  val stat : t -> uri:Uri.t -> stat_result
  val readDirectory : t -> uri:Uri.t -> read_directory_result
  val createDirectory : t -> uri:Uri.t -> create_directory_result
  val readFile : t -> uri:Uri.t -> read_file_result

  val writeFile
    :  t
    -> uri:Uri.t
    -> content:Uint8Array.t
    -> options:write_file_options
    -> create_directory_result

  val delete : t -> uri:Uri.t -> options:delete_options -> create_directory_result

  val rename
    :  t
    -> oldUri:Uri.t
    -> newUri:Uri.t
    -> options:rename_options
    -> create_directory_result

  val copy
    :  t
    -> (source:Uri.t
        -> destination:Uri.t
        -> options:rename_options
        -> create_directory_result)
         or_undefined

  val create
    :  onDidChangeFile:FileChangeEvent.t list Event.t
    -> watch:(uri:Uri.t -> options:watch_options -> Disposable.t)
    -> stat:(uri:Uri.t -> stat_result)
    -> readDirectory:(uri:Uri.t -> read_directory_result)
    -> createDirectory:(uri:Uri.t -> create_directory_result)
    -> readFile:(uri:Uri.t -> read_file_result)
    -> writeFile:
         (uri:Uri.t
          -> content:Uint8Array.t
          -> options:write_file_options
          -> create_directory_result)
    -> delete:(uri:Uri.t -> options:delete_options -> create_directory_result)
    -> rename:
         (oldUri:Uri.t
          -> newUri:Uri.t
          -> options:rename_options
          -> create_directory_result)
    -> ?copy:
         (source:Uri.t
          -> destination:Uri.t
          -> options:rename_options
          -> create_directory_result)
    -> unit
    -> t
end

module Workspace : sig
  type find_files_with_exclusion_exclude =
    [ `GlobPattern of GlobPattern.t
    | `Null
    ]

  val find_files_with_exclusion_exclude_to_js : find_files_with_exclusion_exclude -> Ojs.t
  val find_files_with_exclusion_exclude_of_js : Ojs.t -> find_files_with_exclusion_exclude

  type get_configuration_with_scope =
    [ `ConfigurationScope of ConfigurationScope.t
    | `Null
    ]

  val get_configuration_with_scope_to_js : get_configuration_with_scope -> Ojs.t
  val get_configuration_with_scope_of_js : Ojs.t -> get_configuration_with_scope

  type register_file_system_provider_options_is_readonly =
    [ `Bool of bool
    | `MarkdownString of MarkdownString.t
    ]

  val register_file_system_provider_options_is_readonly_to_js
    :  register_file_system_provider_options_is_readonly
    -> Ojs.t

  val register_file_system_provider_options_is_readonly_of_js
    :  Ojs.t
    -> register_file_system_provider_options_is_readonly

  type register_file_system_provider_options =
    { isCaseSensitive : bool or_undefined
    ; isReadonly : register_file_system_provider_options_is_readonly or_undefined
    }

  val register_file_system_provider_options_to_js
    :  register_file_system_provider_options
    -> Ojs.t

  val register_file_system_provider_options_of_js
    :  Ojs.t
    -> register_file_system_provider_options

  val workspaceFolders : unit -> WorkspaceFolder.t list or_undefined
  val name : unit -> string or_undefined

  val createFileSystemWatcher
    :  GlobPattern.t
    -> ?ignoreCreateEvents:bool
    -> ?ignoreChangeEvents:bool
    -> ?ignoreDeleteEvents:bool
    -> unit
    -> FileSystemWatcher.t

  val workspaceFile : unit -> Uri.t or_undefined

  (** @deprecated Use workspaceFolders instead. *)
  val rootPath : unit -> string or_undefined

  val onDidChangeWorkspaceFolders : WorkspaceFoldersChangeEvent.t Event.t
  val onDidChangeTextDocument : TextDocumentChangeEvent.t Event.t
  val onDidChangeConfiguration : ConfigurationChangeEvent.t Event.t

  val asRelativePath
    :  pathOrUri:([ `String of string | `Uri of Uri.t ][@js.union])
    -> ?includeWorkspaceFolder:bool
    -> unit
    -> string

  val getWorkspaceFolder : uri:Uri.t -> WorkspaceFolder.t option

  val findFiles
    :  includes:GlobPattern.t
    -> ?excludes:GlobPattern.t
    -> ?maxResults:int
    -> ?token:CancellationToken.t
    -> unit
    -> Uri.t list Promise.t

  val textDocuments : unit -> TextDocument.t list

  type textDocumentOptions =
    { language : string
    ; content : string
    }

  val decode
    :  content:Uint8Array.t
    -> ?options:TextEncodingOptions.t
    -> unit
    -> string Promise.t

  val encode
    :  content:string
    -> ?options:TextEncodingOptions.t
    -> unit
    -> Uint8Array.t Promise.t

  val openTextDocumentWithEncoding
    :  [ `Uri of Uri.t | `Filename of string ]
    -> options:TextDocumentEncodingOptions.t
    -> TextDocument.t Promise.t

  val openTextDocument
    :  [ `Uri of Uri.t
       | `Filename of string
       | `Options of TextDocumentOpenOptions.t
       | `Interactive of textDocumentOptions option
       ]
    -> TextDocument.t Promise.t

  val onDidOpenTextDocument : TextDocument.t Event.t
  val onDidCloseTextDocument : TextDocument.t Event.t
  val onDidSaveTextDocument : TextDocument.t Event.t
  val applyEdit : edit:WorkspaceEdit.t -> bool Promise.t

  val getConfiguration
    :  ?section:string
    -> ?scope:ConfigurationScope.t
    -> unit
    -> WorkspaceConfiguration.t

  val registerTextDocumentContentProvider
    :  scheme:string
    -> provider:TextDocumentContentProvider.t
    -> Disposable.t

  type delete_count =
    [ `Int of int
    | `Null
    ]

  val delete_count_to_js : delete_count -> Ojs.t
  val delete_count_of_js : Ojs.t -> delete_count

  type workspaceFolderToAdd =
    { name : string or_undefined
    ; uri : Uri.t
    }

  val updateWorkspaceFolders
    :  start:int
    -> deleteCount:delete_count or_undefined
    -> workspaceFoldersToAdd:(workspaceFolderToAdd list[@js.variadic])
    -> bool

  val fs : unit -> FileSystem.t

  val findFilesWithExclusion
    :  include_:GlobPattern.t
    -> ?exclude:find_files_with_exclusion_exclude
    -> ?maxResults:int
    -> ?token:CancellationToken.t
    -> unit
    -> Uri.t list Promise.t

  val save : uri:Uri.t -> Uri.t or_undefined Promise.t
  val saveAs : uri:Uri.t -> Uri.t or_undefined Promise.t
  val saveAll : ?includeUntitled:bool -> unit -> bool Promise.t

  val applyEditWithMetadata
    :  edit:WorkspaceEdit.t
    -> ?metadata:WorkspaceEditMetadata.t
    -> unit
    -> bool Promise.t

  val onWillSaveTextDocument : unit -> TextDocumentWillSaveEvent.t Event.t
  val notebookDocuments : unit -> NotebookDocument.t list
  val openNotebookDocument : uri:Uri.t -> NotebookDocument.t Promise.t

  val createNotebookDocument
    :  notebookType:string
    -> ?content:NotebookData.t
    -> unit
    -> NotebookDocument.t Promise.t

  val onDidChangeNotebookDocument : unit -> NotebookDocumentChangeEvent.t Event.t
  val onWillSaveNotebookDocument : unit -> NotebookDocumentWillSaveEvent.t Event.t
  val onDidSaveNotebookDocument : unit -> NotebookDocument.t Event.t

  val registerNotebookSerializer
    :  notebookType:string
    -> serializer:NotebookSerializer.t
    -> ?options:NotebookDocumentContentOptions.t
    -> unit
    -> Disposable.t

  val onDidOpenNotebookDocument : unit -> NotebookDocument.t Event.t
  val onDidCloseNotebookDocument : unit -> NotebookDocument.t Event.t
  val onWillCreateFiles : unit -> FileWillCreateEvent.t Event.t
  val onDidCreateFiles : unit -> FileCreateEvent.t Event.t
  val onWillDeleteFiles : unit -> FileWillDeleteEvent.t Event.t
  val onDidDeleteFiles : unit -> FileDeleteEvent.t Event.t
  val onWillRenameFiles : unit -> FileWillRenameEvent.t Event.t
  val onDidRenameFiles : unit -> FileRenameEvent.t Event.t

  val getConfigurationWithScope
    :  ?section:string
    -> ?scope:get_configuration_with_scope
    -> unit
    -> WorkspaceConfiguration.t

  (** @deprecated Use the corresponding function on the [tasks] namespace instead *)
  val registerTaskProvider
    :  type_:string
    -> provider:Task.t TaskProvider.t
    -> Disposable.t

  val registerFileSystemProvider
    :  scheme:string
    -> provider:FileSystemProvider.t
    -> ?options:register_file_system_provider_options
    -> unit
    -> Disposable.t

  val isTrusted : unit -> bool
  val onDidGrantWorkspaceTrust : unit -> unit Event.t
end

module TreeItemCollapsibleState : sig
  type t =
    | None
    | Collapsed
    | Expanded

  include Ojs.T with type t := t
end

module CustomDocument : sig
  module type T = sig
    include Ojs.T

    val uri : t -> Uri.t
    val dispose : t -> unit
  end

  include T

  val create : uri:Uri.t -> dispose:(unit -> unit) -> unit -> t
end

module TreeItemLabel : sig
  include Ojs.T

  val label : t -> string
  val highlights : t -> (int * int) list or_undefined
  val set_label : t -> string -> unit
  val set_highlights : t -> (int * int) list or_undefined -> unit
  val create : label:string -> ?highlights:(int * int) list -> unit -> t
end

module TreeItemCheckboxState : sig
  type t =
    | Unchecked
    | Checked

  include Ojs.T with type t := t
end

module TreeItem : sig
  include Ojs.T

  type label_value =
    [ `String of string
    | `TreeItemLabel of TreeItemLabel.t
    ]

  val label_value_to_js : label_value -> Ojs.t
  val label_value_of_js : Ojs.t -> label_value

  type description_value =
    [ `String of string
    | `Bool of bool
    ]

  val description_value_to_js : description_value -> Ojs.t
  val description_value_of_js : Ojs.t -> description_value

  type tooltip_value =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val tooltip_value_to_js : tooltip_value -> Ojs.t
  val tooltip_value_of_js : Ojs.t -> tooltip_value

  type checkbox_state_item =
    { state : TreeItemCheckboxState.t
    ; tooltip : string or_undefined
    ; accessibilityInformation : AccessibilityInformation.t or_undefined
    }

  val checkbox_state_item_to_js : checkbox_state_item -> Ojs.t
  val checkbox_state_item_of_js : Ojs.t -> checkbox_state_item

  type checkbox_state =
    [ `TreeItemCheckboxState of TreeItemCheckboxState.t
    | `Options of checkbox_state_item
    ]

  val checkbox_state_to_js : checkbox_state -> Ojs.t
  val checkbox_state_of_js : Ojs.t -> checkbox_state

  type label =
    [ `String of string
    | `TreeItemLabel of TreeItemLabel.t
    ]

  type iconPath =
    [ `String of string
    | `Uri of Uri.t
    | `LightDark of LightDarkIcon.t
    | `ThemeIcon of ThemeIcon.t
    ]

  type description =
    [ `String of string
    | `Bool of bool
    ]

  type tooltip =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    | `Undefined
    ]

  val make_label
    :  label:label
    -> ?collapsibleState:TreeItemCollapsibleState.t
    -> unit
    -> t

  val make_resource
    :  resourceUri:Uri.t
    -> ?collapsibleState:TreeItemCollapsibleState.t
    -> unit
    -> t

  val label : t -> label_value or_undefined
  val set_label : t -> label_value or_undefined -> unit
  val id : t -> string or_undefined
  val set_id : t -> string or_undefined -> unit
  val iconPath : t -> iconPath or_undefined
  val set_iconPath : t -> iconPath or_undefined -> unit
  val description : t -> description_value or_undefined
  val set_description : t -> description_value or_undefined -> unit
  val resourceUri : t -> Uri.t or_undefined
  val set_resourceUri : t -> Uri.t or_undefined -> unit
  val tooltip : t -> tooltip_value or_undefined
  val set_tooltip : t -> tooltip_value or_undefined -> unit
  val collapsibleState : t -> TreeItemCollapsibleState.t or_undefined
  val set_collapsibleState : t -> TreeItemCollapsibleState.t or_undefined -> unit
  val command : t -> Command.t or_undefined
  val set_command : t -> Command.t or_undefined -> unit
  val contextValue : t -> string or_undefined
  val set_contextValue : t -> string or_undefined -> unit
  val accessibilityInformation : t -> AccessibilityInformation.t or_undefined
  val set_accessibilityInformation : t -> AccessibilityInformation.t or_undefined -> unit
  val checkboxState : t -> checkbox_state or_undefined
  val set_checkboxState : t -> checkbox_state or_undefined -> unit
end

module TreeDataProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    type nonrec t = T.t t

    type change =
      [ `Element of T.t
      | `Elements of T.t list
      ]

    val change_to_js : change -> Ojs.t
    val change_of_js : Ojs.t -> change

    type get_tree_item_result =
      [ `Value of TreeItem.t
      | `Promise of TreeItem.t Promise.t
      ]

    val get_tree_item_result_to_js : get_tree_item_result -> Ojs.t
    val get_tree_item_result_of_js : Ojs.t -> get_tree_item_result
    val onDidChangeTreeData : t -> change or_undefined Event.t or_undefined
    val getChildren : t -> ?element:T.t -> unit -> T.t list ProviderResult.t
    val set_onDidChangeTreeData : t -> change or_undefined Event.t or_undefined -> unit
    val getTreeItem : t -> element:T.t -> get_tree_item_result
    val getParent : t -> (element:T.t -> T.t ProviderResult.t) or_undefined

    val resolveTreeItem
      :  t
      -> (item:TreeItem.t
          -> element:T.t
          -> token:CancellationToken.t
          -> TreeItem.t ProviderResult.t)
           or_undefined

    val create
      :  ?onDidChangeTreeData:change or_undefined Event.t
      -> getTreeItem:(element:T.t -> get_tree_item_result)
      -> getChildren:(?element:T.t -> unit -> T.t list ProviderResult.t)
      -> ?getParent:(element:T.t -> T.t ProviderResult.t)
      -> ?resolveTreeItem:
           (item:TreeItem.t
            -> element:T.t
            -> token:CancellationToken.t
            -> TreeItem.t ProviderResult.t)
      -> unit
      -> t
  end
end

module DataTransferItem : sig
  include Ojs.T

  val asString : t -> string Promise.t
  val asFile : t -> DataTransferFile.t or_undefined
  val value : t -> Ojs.t
  val make : value:Ojs.t -> t
end

module DataTransfer : sig
  include Ojs.T

  val get : t -> mimeType:string -> DataTransferItem.t or_undefined
  val set : t -> mimeType:string -> value:DataTransferItem.t -> unit

  val forEach
    :  t
    -> callbackfn:(item:DataTransferItem.t -> mimeType:string -> dataTransfer:t -> unit)
    -> ?thisArg:Ojs.t
    -> unit
    -> unit

  val make : unit -> t
  val iterator : t -> (string * DataTransferItem.t) IterableIterator.t
end

module TreeDragAndDropController : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    type handle_drag_result =
      [ `Promise of unit Promise.t
      | `Unit of unit
      ]

    val handle_drag_result_to_js : handle_drag_result -> Ojs.t
    val handle_drag_result_of_js : Ojs.t -> handle_drag_result
    val dropMimeTypes : t -> string list
    val dragMimeTypes : t -> string list

    val handleDrag
      :  t
      -> (source:T.t list
          -> dataTransfer:DataTransfer.t
          -> token:CancellationToken.t
          -> handle_drag_result)
           or_undefined

    val handleDrop
      :  t
      -> (target:T.t or_undefined
          -> dataTransfer:DataTransfer.t
          -> token:CancellationToken.t
          -> handle_drag_result)
           or_undefined

    val create
      :  dropMimeTypes:string list
      -> dragMimeTypes:string list
      -> ?handleDrag:
           (source:T.t list
            -> dataTransfer:DataTransfer.t
            -> token:CancellationToken.t
            -> handle_drag_result)
      -> ?handleDrop:
           (target:T.t or_undefined
            -> dataTransfer:DataTransfer.t
            -> token:CancellationToken.t
            -> handle_drag_result)
      -> unit
      -> t
  end
end

module TreeViewOptions : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    type nonrec t = T.t t

    val treeDataProvider : t -> T.t TreeDataProvider.t
    val showCollapseAll : t -> bool or_undefined
    val canSelectMany : t -> bool or_undefined
    val set_treeDataProvider : t -> T.t TreeDataProvider.t -> unit
    val set_showCollapseAll : t -> bool or_undefined -> unit
    val set_canSelectMany : t -> bool or_undefined -> unit
    val dragAndDropController : t -> T.t TreeDragAndDropController.t or_undefined

    val set_dragAndDropController
      :  t
      -> T.t TreeDragAndDropController.t or_undefined
      -> unit

    val manageCheckboxStateManually : t -> bool or_undefined
    val set_manageCheckboxStateManually : t -> bool or_undefined -> unit

    val create
      :  treeDataProvider:T.t TreeDataProvider.t
      -> ?showCollapseAll:bool
      -> ?canSelectMany:bool
      -> ?dragAndDropController:T.t TreeDragAndDropController.t
      -> ?manageCheckboxStateManually:bool
      -> unit
      -> t
  end
end

module TreeViewExpansionEvent : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    type nonrec t = T.t t

    val element : t -> T.t
    val create : element:T.t -> unit -> t
  end
end

module TreeViewSelectionChangeEvent : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    type nonrec t = T.t t

    val selection : t -> T.t list
    val create : selection:T.t list -> unit -> t
  end
end

module TreeViewVisibilityChangeEvent : sig
  include Ojs.T

  val visible : t -> bool
  val create : visible:bool -> unit -> t
end

module TreeCheckboxChangeEvent : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val items : t -> (T.t * TreeItemCheckboxState.t) list
    val create : items:(T.t * TreeItemCheckboxState.t) list -> unit -> t
  end
end

module ViewBadge : sig
  include Ojs.T

  val tooltip : t -> string
  val value : t -> int
  val create : tooltip:string -> value:int -> unit -> t
end

module TreeView : sig
  include Js.Generic with type 'a t = private Disposable.t

  module Make (T : Ojs.T) : sig
    type nonrec t = T.t t
    type from_disposable_likes_item = { dispose : unit -> Ojs.t }

    val from_disposable_likes_item_to_js : from_disposable_likes_item -> Ojs.t
    val from_disposable_likes_item_of_js : Ojs.t -> from_disposable_likes_item
    val onDidExpandElement : t -> T.t TreeViewExpansionEvent.t Event.t
    val onDidCollapseElement : t -> T.t TreeViewExpansionEvent.t Event.t
    val selection : t -> T.t list
    val onDidChangeSelection : t -> T.t TreeViewSelectionChangeEvent.t Event.t
    val visible : t -> bool
    val onDidChangeVisibility : t -> TreeViewVisibilityChangeEvent.t Event.t
    val message : t -> string or_undefined
    val title : t -> string or_undefined
    val description : t -> string or_undefined

    val reveal
      :  t
      -> element:T.t
      -> ?select:bool
      -> ?focus:bool
      -> ?expand:[ `Bool of bool | `Int of int ]
      -> unit
      -> unit Promise.t

    val from : disposableLikes:from_disposable_likes_item list -> Disposable.t
    val dispose : t -> Ojs.t
    val onDidChangeCheckboxState : t -> T.t TreeCheckboxChangeEvent.t Event.t
    val set_message : t -> string or_undefined -> unit
    val set_title : t -> string or_undefined -> unit
    val set_description : t -> string or_undefined -> unit
    val badge : t -> ViewBadge.t or_undefined
    val set_badge : t -> ViewBadge.t or_undefined -> unit
  end

  val to_disposable : 'a t -> Disposable.t
end

module WebviewPanelOptions : sig
  include Ojs.T

  val enableFindWidget : t -> bool or_undefined
  val retainContextWhenHidden : t -> bool or_undefined
  val create : ?enableFindWidget:bool -> ?retainContextWhenHidden:bool -> unit -> t
end

module WebviewPortMapping : sig
  include Ojs.T

  val extensionHostPort : t -> int
  val webviewPort : t -> int
  val create : webviewPort:int -> extensionHostPort:int -> unit -> t
end

module WebviewOptions : sig
  include Ojs.T

  type enable_command_uris =
    [ `Bool of bool
    | `Items of string list
    ]

  val enable_command_uris_to_js : enable_command_uris -> Ojs.t
  val enable_command_uris_of_js : Ojs.t -> enable_command_uris
  val enableCommandUris : t -> enable_command_uris or_undefined
  val enableScripts : t -> bool or_undefined
  val localResourceRoots : t -> Uri.t list or_undefined
  val portMapping : t -> WebviewPortMapping.t list or_undefined
  val enableForms : t -> bool or_undefined

  val create
    :  ?enableScripts:bool
    -> ?enableForms:bool
    -> ?enableCommandUris:enable_command_uris
    -> ?localResourceRoots:Uri.t list
    -> ?portMapping:WebviewPortMapping.t list
    -> unit
    -> t
end

module WebView : sig
  include Ojs.T

  val onDidReceiveMessage : t -> Ojs.t Event.t
  val cspSource : t -> string
  val html : t -> string
  val set_html : t -> string -> unit
  val options : t -> WebviewOptions.t
  val set_options : t -> WebviewOptions.t -> unit
  val asWebviewUri : t -> localResource:Uri.t -> Uri.t
  val postMessage : t -> Ojs.t -> bool Promise.t

  val create
    :  options:WebviewOptions.t
    -> html:string
    -> onDidReceiveMessage:Ojs.t Event.t
    -> postMessage:(message:Ojs.t -> bool Promise.t)
    -> asWebviewUri:(localResource:Uri.t -> Uri.t)
    -> cspSource:string
    -> unit
    -> t
end

module rec WebviewPanel : sig
  include Ojs.T
  module LightDarkIcon = LightDarkIcon

  val onDidChangeViewState : t -> WebviewPanelOnDidChangeViewStateEvent.t Event.t
  val onDidDispose : t -> unit Event.t
  val active : t -> bool

  type iconPath = IconPath.t

  val options : t -> WebviewPanelOptions.t
  val title : t -> string
  val iconPath : t -> IconPath.t or_undefined
  val set_iconPath : t -> IconPath.t or_undefined -> unit
  val viewColumn : t -> ViewColumn.t or_undefined
  val viewType : t -> string
  val visible : t -> bool
  val webview : t -> WebView.t
  val dispose : t -> unit
  val reveal : t -> ?viewColumn:ViewColumn.t -> ?preserveFocus:bool -> unit -> unit
  val set_title : t -> string -> unit

  val create
    :  viewType:string
    -> title:string
    -> ?iconPath:IconPath.t
    -> webview:WebView.t
    -> options:WebviewPanelOptions.t
    -> viewColumn:ViewColumn.t or_undefined
    -> active:bool
    -> visible:bool
    -> onDidChangeViewState:WebviewPanelOnDidChangeViewStateEvent.t Event.t
    -> onDidDispose:unit Event.t
    -> reveal:(?viewColumn:ViewColumn.t -> ?preserveFocus:bool -> unit -> unit)
    -> dispose:(unit -> Ojs.t)
    -> unit
    -> t
end

and WebviewPanelOnDidChangeViewStateEvent : sig
  include Ojs.T

  val webviewPanel : t -> WebviewPanel.t
  val create : webviewPanel:WebviewPanel.t -> unit -> t
end

module CustomTextEditorProvider : sig
  include Ojs.T

  type create_resolve_custom_text_editor_result =
    [ `Promise of unit Promise.t
    | `Unit of unit
    ]

  val create_resolve_custom_text_editor_result_to_js
    :  create_resolve_custom_text_editor_result
    -> Ojs.t

  val create_resolve_custom_text_editor_result_of_js
    :  Ojs.t
    -> create_resolve_custom_text_editor_result

  module ResolvedEditor : sig
    type t =
      [ `Promise of unit Promise.t
      | `Unit of unit
      ]

    val t_to_js : t -> Ojs.t
    val t_of_js : Ojs.t -> t
  end

  val resolveCustomTextEditor
    :  t
    -> document:TextDocument.t
    -> webviewPanel:WebviewPanel.t
    -> token:CancellationToken.t
    -> ResolvedEditor.t

  val create
    :  resolveCustomTextEditor:
         (document:TextDocument.t
          -> webviewPanel:WebviewPanel.t
          -> token:CancellationToken.t
          -> create_resolve_custom_text_editor_result)
    -> unit
    -> t
end

module CustomDocumentOpenContext : sig
  include Ojs.T

  val backupId : t -> string or_undefined
  val untitledDocumentData : t -> Uint8Array.t or_undefined

  val create
    :  backupId:string or_undefined
    -> untitledDocumentData:Uint8Array.t or_undefined
    -> unit
    -> t
end

module CustomReadonlyEditorProvider : sig
  include Js.Generic

  module Make (T : CustomDocument.T) : sig
    type nonrec t = T.t t

    type open_custom_document_result =
      [ `Promise of T.t Promise.t
      | `Value of T.t
      ]

    val open_custom_document_result_to_js : open_custom_document_result -> Ojs.t
    val open_custom_document_result_of_js : Ojs.t -> open_custom_document_result

    type resolve_custom_editor_result =
      [ `Promise of unit Promise.t
      | `Unit of unit
      ]

    val resolve_custom_editor_result_to_js : resolve_custom_editor_result -> Ojs.t
    val resolve_custom_editor_result_of_js : Ojs.t -> resolve_custom_editor_result

    val openCustomDocument
      :  t
      -> uri:Uri.t
      -> openContext:CustomDocumentOpenContext.t
      -> token:CancellationToken.t
      -> open_custom_document_result

    val resolveCustomEditor
      :  t
      -> document:T.t
      -> webviewPanel:WebviewPanel.t
      -> token:CancellationToken.t
      -> resolve_custom_editor_result

    val create
      :  openCustomDocument:
           (uri:Uri.t
            -> openContext:CustomDocumentOpenContext.t
            -> token:CancellationToken.t
            -> open_custom_document_result)
      -> resolveCustomEditor:
           (document:T.t
            -> webviewPanel:WebviewPanel.t
            -> token:CancellationToken.t
            -> resolve_custom_editor_result)
      -> unit
      -> t
  end
end

module RegisterCustomEditorProviderOptions : sig
  include Ojs.T

  val supportsMultipleEditorsPerDocument : t -> bool or_undefined
  val webviewOptions : t -> WebviewPanelOptions.t or_undefined

  val create
    :  ?supportsMultipleEditorsPerDocument:bool
    -> ?webviewOptions:WebviewPanelOptions.t
    -> unit
    -> t
end

module CustomDocumentEditEvent : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    type undo_result =
      [ `Promise of unit Promise.t
      | `Unit of unit
      ]

    val undo_result_to_js : undo_result -> Ojs.t
    val undo_result_of_js : Ojs.t -> undo_result
    val document : t -> T.t
    val undo : t -> undo_result
    val redo : t -> undo_result
    val label : t -> string or_undefined

    val create
      :  document:T.t
      -> undo:(unit -> undo_result)
      -> redo:(unit -> undo_result)
      -> ?label:string
      -> unit
      -> t
  end
end

module CustomDocumentContentChangeEvent : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val document : t -> T.t
    val create : document:T.t -> unit -> t
  end
end

module CustomDocumentBackupContext : sig
  include Ojs.T

  val destination : t -> Uri.t
  val create : destination:Uri.t -> unit -> t
end

module CustomDocumentBackup : sig
  include Ojs.T

  val id : t -> string
  val delete : t -> unit
  val create : id:string -> delete:(unit -> unit) -> unit -> t
end

module CustomEditorProvider : sig
  include Js.Generic with type 'a t = private 'a CustomReadonlyEditorProvider.t

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    type open_custom_document_result =
      [ `Promise of T.t Promise.t
      | `Value of T.t
      ]

    val open_custom_document_result_to_js : open_custom_document_result -> Ojs.t
    val open_custom_document_result_of_js : Ojs.t -> open_custom_document_result

    type resolve_custom_editor_result =
      [ `Promise of unit Promise.t
      | `Unit of unit
      ]

    val resolve_custom_editor_result_to_js : resolve_custom_editor_result -> Ojs.t
    val resolve_custom_editor_result_of_js : Ojs.t -> resolve_custom_editor_result

    type on_did_change_custom_document =
      [ `Event of T.t CustomDocumentEditEvent.t Event.t
      | `EventValue of T.t CustomDocumentContentChangeEvent.t Event.t
      ]

    val on_did_change_custom_document_to_js : on_did_change_custom_document -> Ojs.t
    val on_did_change_custom_document_of_js : Ojs.t -> on_did_change_custom_document

    val openCustomDocument
      :  t
      -> uri:Uri.t
      -> openContext:CustomDocumentOpenContext.t
      -> token:CancellationToken.t
      -> open_custom_document_result

    val resolveCustomEditor
      :  t
      -> document:T.t
      -> webviewPanel:WebviewPanel.t
      -> token:CancellationToken.t
      -> resolve_custom_editor_result

    val onDidChangeCustomDocument : t -> on_did_change_custom_document

    val saveCustomDocument
      :  t
      -> document:T.t
      -> cancellation:CancellationToken.t
      -> unit Promise.t

    val saveCustomDocumentAs
      :  t
      -> document:T.t
      -> destination:Uri.t
      -> cancellation:CancellationToken.t
      -> unit Promise.t

    val revertCustomDocument
      :  t
      -> document:T.t
      -> cancellation:CancellationToken.t
      -> unit Promise.t

    val backupCustomDocument
      :  t
      -> document:T.t
      -> context:CustomDocumentBackupContext.t
      -> cancellation:CancellationToken.t
      -> CustomDocumentBackup.t Promise.t

    val create
      :  openCustomDocument:
           (uri:Uri.t
            -> openContext:CustomDocumentOpenContext.t
            -> token:CancellationToken.t
            -> open_custom_document_result)
      -> resolveCustomEditor:
           (document:T.t
            -> webviewPanel:WebviewPanel.t
            -> token:CancellationToken.t
            -> resolve_custom_editor_result)
      -> onDidChangeCustomDocument:on_did_change_custom_document
      -> saveCustomDocument:
           (document:T.t -> cancellation:CancellationToken.t -> unit Promise.t)
      -> saveCustomDocumentAs:
           (document:T.t
            -> destination:Uri.t
            -> cancellation:CancellationToken.t
            -> unit Promise.t)
      -> revertCustomDocument:
           (document:T.t -> cancellation:CancellationToken.t -> unit Promise.t)
      -> backupCustomDocument:
           (document:T.t
            -> context:CustomDocumentBackupContext.t
            -> cancellation:CancellationToken.t
            -> CustomDocumentBackup.t Promise.t)
      -> unit
      -> t
  end

  val to_custom_readonly_editor_provider : 'a t -> 'a CustomReadonlyEditorProvider.t
end

module QuickInputButtons : sig
  include Ojs.T

  val back : unit -> QuickInputButton.t
end

module LogLevel : sig
  type t =
    | Off
    | Trace
    | Debug
    | Info
    | Warning
    | Error

  include Ojs.T with type t := t
end

module LogOutputChannel : sig
  include Ojs.T with type t = private OutputChannel.t

  type error =
    [ `String of string
    | `Error of JsError.t
    ]

  val error_to_js : error -> Ojs.t
  val error_of_js : Ojs.t -> error
  val to_output_channel : t -> OutputChannel.t
  val name : t -> string
  val append : t -> value:string -> unit
  val appendLine : t -> value:string -> unit
  val replace : t -> value:string -> unit
  val clear : t -> unit
  val show : t -> ?preserveFocus:bool -> unit -> unit

  (** @deprecated
        Use the overload with just one parameter ([show(preserveFocus?: boolean): void]).
  *)
  val showInColumn : t -> ?column:ViewColumn.t -> ?preserveFocus:bool -> unit -> unit

  val hide : t -> unit
  val dispose : t -> unit
  val logLevel : t -> LogLevel.t
  val onDidChangeLogLevel : t -> LogLevel.t Event.t
  val trace : t -> message:string -> args:Ojs.t list -> unit
  val debug : t -> message:string -> args:Ojs.t list -> unit
  val info : t -> message:string -> args:Ojs.t list -> unit
  val warn : t -> message:string -> args:Ojs.t list -> unit
  val error : t -> error:error -> args:Ojs.t list -> unit
end

module rec Tab : sig
  include Ojs.T

  val label : t -> string
  val group : t -> TabGroup.t
  val input : t -> Ojs.t
  val isActive : t -> bool
  val isDirty : t -> bool
  val isPinned : t -> bool
  val isPreview : t -> bool

  val create
    :  label:string
    -> group:TabGroup.t
    -> input:Ojs.t
    -> isActive:bool
    -> isDirty:bool
    -> isPinned:bool
    -> isPreview:bool
    -> unit
    -> t
end

and TabGroup : sig
  include Ojs.T

  val isActive : t -> bool
  val viewColumn : t -> ViewColumn.t
  val activeTab : t -> Tab.t or_undefined
  val tabs : t -> Tab.t list

  val create
    :  isActive:bool
    -> viewColumn:ViewColumn.t
    -> activeTab:Tab.t or_undefined
    -> tabs:Tab.t list
    -> unit
    -> t
end

module TabGroupChangeEvent : sig
  include Ojs.T

  val opened : t -> TabGroup.t list
  val closed : t -> TabGroup.t list
  val changed : t -> TabGroup.t list

  val create
    :  opened:TabGroup.t list
    -> closed:TabGroup.t list
    -> changed:TabGroup.t list
    -> unit
    -> t
end

module TabChangeEvent : sig
  include Ojs.T

  val opened : t -> Tab.t list
  val closed : t -> Tab.t list
  val changed : t -> Tab.t list
  val create : opened:Tab.t list -> closed:Tab.t list -> changed:Tab.t list -> unit -> t
end

module TabGroups : sig
  include Ojs.T

  type close_tab =
    [ `Tab of Tab.t
    | `Items of Tab.t list
    ]

  val close_tab_to_js : close_tab -> Ojs.t
  val close_tab_of_js : Ojs.t -> close_tab

  type close_groups_tab_group =
    [ `TabGroup of TabGroup.t
    | `Items of TabGroup.t list
    ]

  val close_groups_tab_group_to_js : close_groups_tab_group -> Ojs.t
  val close_groups_tab_group_of_js : Ojs.t -> close_groups_tab_group
  val all : t -> TabGroup.t list
  val activeTabGroup : t -> TabGroup.t
  val onDidChangeTabGroups : t -> TabGroupChangeEvent.t Event.t
  val onDidChangeTabs : t -> TabChangeEvent.t Event.t
  val close : t -> tab:close_tab -> ?preserveFocus:bool -> unit -> bool Promise.t

  val closeGroups
    :  t
    -> tabGroup:close_groups_tab_group
    -> ?preserveFocus:bool
    -> unit
    -> bool Promise.t
end

module TextEditorVisibleRangesChangeEvent : sig
  include Ojs.T

  val textEditor : t -> TextEditor.t
  val visibleRanges : t -> Range.t list
  val create : textEditor:TextEditor.t -> visibleRanges:Range.t list -> unit -> t
end

module TextEditorOptionsChangeEvent : sig
  include Ojs.T

  val textEditor : t -> TextEditor.t
  val options : t -> TextEditorOptions.t
  val create : textEditor:TextEditor.t -> options:TextEditorOptions.t -> unit -> t
end

module TextEditorViewColumnChangeEvent : sig
  include Ojs.T

  val textEditor : t -> TextEditor.t
  val viewColumn : t -> ViewColumn.t
  val create : textEditor:TextEditor.t -> viewColumn:ViewColumn.t -> unit -> t
end

module NotebookEditorRevealType : sig
  type t =
    | Default
    | InCenter
    | InCenterIfOutsideViewport
    | AtTop

  include Ojs.T with type t := t
end

module NotebookEditor : sig
  include Ojs.T

  val notebook : t -> NotebookDocument.t
  val selection : t -> NotebookRange.t
  val set_selection : t -> NotebookRange.t -> unit
  val selections : t -> NotebookRange.t list
  val set_selections : t -> NotebookRange.t list -> unit
  val visibleRanges : t -> NotebookRange.t list
  val viewColumn : t -> ViewColumn.t or_undefined

  val revealRange
    :  t
    -> range:NotebookRange.t
    -> ?revealType:NotebookEditorRevealType.t
    -> unit
    -> unit
end

module NotebookEditorSelectionChangeEvent : sig
  include Ojs.T

  val notebookEditor : t -> NotebookEditor.t
  val selections : t -> NotebookRange.t list

  val create
    :  notebookEditor:NotebookEditor.t
    -> selections:NotebookRange.t list
    -> unit
    -> t
end

module NotebookEditorVisibleRangesChangeEvent : sig
  include Ojs.T

  val notebookEditor : t -> NotebookEditor.t
  val visibleRanges : t -> NotebookRange.t list

  val create
    :  notebookEditor:NotebookEditor.t
    -> visibleRanges:NotebookRange.t list
    -> unit
    -> t
end

module WindowState : sig
  include Ojs.T

  val focused : t -> bool
  val active : t -> bool
  val create : focused:bool -> active:bool -> unit -> t
end

module NotebookDocumentShowOptions : sig
  include Ojs.T

  val viewColumn : t -> ViewColumn.t or_undefined
  val preserveFocus : t -> bool or_undefined
  val preview : t -> bool or_undefined
  val selections : t -> NotebookRange.t list or_undefined

  val create
    :  ?viewColumn:ViewColumn.t
    -> ?preserveFocus:bool
    -> ?preview:bool
    -> ?selections:NotebookRange.t list
    -> unit
    -> t
end

module WorkspaceFolderPickOptions : sig
  include Ojs.T

  val placeHolder : t -> string or_undefined
  val set_placeHolder : t -> string or_undefined -> unit
  val ignoreFocusOut : t -> bool or_undefined
  val set_ignoreFocusOut : t -> bool or_undefined -> unit
  val create : ?placeHolder:string -> ?ignoreFocusOut:bool -> unit -> t
end

module SaveDialogOptions : sig
  include Ojs.T

  val defaultUri : t -> Uri.t or_undefined
  val set_defaultUri : t -> Uri.t or_undefined -> unit
  val saveLabel : t -> string or_undefined
  val set_saveLabel : t -> string or_undefined -> unit
  val filters : t -> string list Dict.t or_undefined
  val set_filters : t -> string list Dict.t or_undefined -> unit
  val title : t -> string or_undefined
  val set_title : t -> string or_undefined -> unit

  val create
    :  ?defaultUri:Uri.t
    -> ?saveLabel:string
    -> ?filters:string list Dict.t
    -> ?title:string
    -> unit
    -> t
end

module UriHandler : sig
  include Ojs.T

  val handleUri : t -> uri:Uri.t -> unit ProviderResult.t
  val create : handleUri:(uri:Uri.t -> unit ProviderResult.t) -> unit -> t
end

module WebviewPanelSerializer : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val deserializeWebviewPanel
      :  t
      -> webviewPanel:WebviewPanel.t
      -> state:T.t
      -> unit Promise.t

    val create
      :  deserializeWebviewPanel:
           (webviewPanel:WebviewPanel.t -> state:T.t -> unit Promise.t)
      -> unit
      -> t
  end
end

module WebviewView : sig
  include Ojs.T

  val viewType : t -> string
  val webview : t -> WebView.t
  val title : t -> string or_undefined
  val set_title : t -> string or_undefined -> unit
  val description : t -> string or_undefined
  val set_description : t -> string or_undefined -> unit
  val badge : t -> ViewBadge.t or_undefined
  val set_badge : t -> ViewBadge.t or_undefined -> unit
  val onDidDispose : t -> unit Event.t
  val visible : t -> bool
  val onDidChangeVisibility : t -> unit Event.t
  val show : t -> ?preserveFocus:bool -> unit -> unit
end

module WebviewViewResolveContext : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val state : t -> T.t or_undefined
    val create : state:T.t or_undefined -> unit -> t
  end
end

module WebviewViewProvider : sig
  include Ojs.T

  type resolve_webview_view_result =
    [ `Promise of unit Promise.t
    | `Unit of unit
    ]

  val resolve_webview_view_result_to_js : resolve_webview_view_result -> Ojs.t
  val resolve_webview_view_result_of_js : Ojs.t -> resolve_webview_view_result

  val resolveWebviewView
    :  t
    -> webviewView:WebviewView.t
    -> context:Ojs.t WebviewViewResolveContext.t
    -> token:CancellationToken.t
    -> resolve_webview_view_result

  val create
    :  resolveWebviewView:
         (webviewView:WebviewView.t
          -> context:Ojs.t WebviewViewResolveContext.t
          -> token:CancellationToken.t
          -> resolve_webview_view_result)
    -> unit
    -> t
end

module TerminalLink : sig
  include Ojs.T

  val startIndex : t -> int
  val set_startIndex : t -> int -> unit
  val length : t -> int
  val set_length : t -> int -> unit
  val tooltip : t -> string or_undefined
  val set_tooltip : t -> string or_undefined -> unit
  val make : startIndex:int -> length:int -> ?tooltip:string -> unit -> t
end

module TerminalLinkContext : sig
  include Ojs.T

  val line : t -> string
  val set_line : t -> string -> unit
  val terminal : t -> Terminal.t
  val set_terminal : t -> Terminal.t -> unit
  val create : line:string -> terminal:Terminal.t -> unit -> t
end

module TerminalLinkProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val provideTerminalLinks
      :  t
      -> context:TerminalLinkContext.t
      -> token:CancellationToken.t
      -> T.t list ProviderResult.t

    val handleTerminalLink : t -> link:T.t -> unit ProviderResult.t

    val create
      :  provideTerminalLinks:
           (context:TerminalLinkContext.t
            -> token:CancellationToken.t
            -> T.t list ProviderResult.t)
      -> handleTerminalLink:(link:T.t -> unit ProviderResult.t)
      -> unit
      -> t
  end
end

module TerminalProfile : sig
  include Ojs.T

  type options =
    [ `TerminalOptions of TerminalOptions.t
    | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
    ]

  val options_to_js : options -> Ojs.t
  val options_of_js : Ojs.t -> options
  val options : t -> options
  val set_options : t -> options -> unit
  val make : options:options -> t
end

module TerminalProfileProvider : sig
  include Ojs.T

  val provideTerminalProfile
    :  t
    -> token:CancellationToken.t
    -> TerminalProfile.t ProviderResult.t

  val create
    :  provideTerminalProfile:
         (token:CancellationToken.t -> TerminalProfile.t ProviderResult.t)
    -> unit
    -> t
end

module FileDecoration : sig
  include Ojs.T

  val badge : t -> string or_undefined
  val set_badge : t -> string or_undefined -> unit
  val tooltip : t -> string or_undefined
  val set_tooltip : t -> string or_undefined -> unit
  val color : t -> ThemeColor.t or_undefined
  val set_color : t -> ThemeColor.t or_undefined -> unit
  val propagate : t -> bool or_undefined
  val set_propagate : t -> bool or_undefined -> unit
  val make : ?badge:string -> ?tooltip:string -> ?color:ThemeColor.t -> unit -> t
end

module FileDecorationProvider : sig
  include Ojs.T

  type on_did_change_file_decorations_t =
    [ `Uri of Uri.t
    | `Items of Uri.t list
    ]

  val on_did_change_file_decorations_t_to_js : on_did_change_file_decorations_t -> Ojs.t
  val on_did_change_file_decorations_t_of_js : Ojs.t -> on_did_change_file_decorations_t

  val onDidChangeFileDecorations
    :  t
    -> on_did_change_file_decorations_t or_undefined Event.t or_undefined

  val set_onDidChangeFileDecorations
    :  t
    -> on_did_change_file_decorations_t or_undefined Event.t or_undefined
    -> unit

  val provideFileDecoration
    :  t
    -> uri:Uri.t
    -> token:CancellationToken.t
    -> FileDecoration.t ProviderResult.t

  val create
    :  ?onDidChangeFileDecorations:on_did_change_file_decorations_t or_undefined Event.t
    -> provideFileDecoration:
         (uri:Uri.t -> token:CancellationToken.t -> FileDecoration.t ProviderResult.t)
    -> unit
    -> t
end

module ColorThemeKind : sig
  type t =
    | Light
    | Dark
    | HighContrast
    | HighContrastLight

  include Ojs.T with type t := t
end

module ColorTheme : sig
  include Ojs.T

  val kind : t -> ColorThemeKind.t
  val create : kind:ColorThemeKind.t -> unit -> t
end

module Window : sig
  type show_quick_pick_many_items =
    [ `Value of string list
    | `Promise of string list Promise.t
    ]

  val show_quick_pick_many_items_to_js : show_quick_pick_many_items -> Ojs.t
  val show_quick_pick_many_items_of_js : Ojs.t -> show_quick_pick_many_items

  type show_quick_pick_many_options_can_pick_many = [ `True ]

  val show_quick_pick_many_options_can_pick_many_to_js
    :  show_quick_pick_many_options_can_pick_many
    -> Ojs.t

  val show_quick_pick_many_options_can_pick_many_of_js
    :  Ojs.t
    -> show_quick_pick_many_options_can_pick_many

  type show_quick_pick_many_options_on_did_select_item_arg0 =
    [ `QuickPickItem of QuickPickItem.t
    | `String of string
    ]

  val show_quick_pick_many_options_on_did_select_item_arg0_to_js
    :  show_quick_pick_many_options_on_did_select_item_arg0
    -> Ojs.t

  val show_quick_pick_many_options_on_did_select_item_arg0_of_js
    :  Ojs.t
    -> show_quick_pick_many_options_on_did_select_item_arg0

  type show_quick_pick_many_options =
    { title : string or_undefined
    ; matchOnDescription : bool or_undefined
    ; matchOnDetail : bool or_undefined
    ; placeHolder : string or_undefined
    ; prompt : string or_undefined
    ; ignoreFocusOut : bool or_undefined
    ; canPickMany : show_quick_pick_many_options_can_pick_many
    ; onDidSelectItem :
        (item:show_quick_pick_many_options_on_did_select_item_arg0 -> Ojs.t) or_undefined
    }

  val show_quick_pick_many_options_to_js : show_quick_pick_many_options -> Ojs.t
  val show_quick_pick_many_options_of_js : Ojs.t -> show_quick_pick_many_options

  type 'p_t show_quick_pick_items_many_items =
    [ `Value of 'p_t list
    | `Promise of 'p_t list Promise.t
    ]

  val show_quick_pick_items_many_items_to_js
    :  ('p_t -> Ojs.t)
    -> 'p_t show_quick_pick_items_many_items
    -> Ojs.t

  val show_quick_pick_items_many_items_of_js
    :  (Ojs.t -> 'p_t)
    -> Ojs.t
    -> 'p_t show_quick_pick_items_many_items

  type show_quick_pick_items_many_options_can_pick_many = [ `True ]

  val show_quick_pick_items_many_options_can_pick_many_to_js
    :  show_quick_pick_items_many_options_can_pick_many
    -> Ojs.t

  val show_quick_pick_items_many_options_can_pick_many_of_js
    :  Ojs.t
    -> show_quick_pick_items_many_options_can_pick_many

  type show_quick_pick_items_many_options_on_did_select_item_arg0 =
    [ `QuickPickItem of QuickPickItem.t
    | `String of string
    ]

  val show_quick_pick_items_many_options_on_did_select_item_arg0_to_js
    :  show_quick_pick_items_many_options_on_did_select_item_arg0
    -> Ojs.t

  val show_quick_pick_items_many_options_on_did_select_item_arg0_of_js
    :  Ojs.t
    -> show_quick_pick_items_many_options_on_did_select_item_arg0

  type show_quick_pick_items_many_options =
    { title : string or_undefined
    ; matchOnDescription : bool or_undefined
    ; matchOnDetail : bool or_undefined
    ; placeHolder : string or_undefined
    ; prompt : string or_undefined
    ; ignoreFocusOut : bool or_undefined
    ; canPickMany : show_quick_pick_items_many_options_can_pick_many
    ; onDidSelectItem :
        (item:show_quick_pick_items_many_options_on_did_select_item_arg0 -> Ojs.t)
          or_undefined
    }

  val show_quick_pick_items_many_options_to_js
    :  show_quick_pick_items_many_options
    -> Ojs.t

  val show_quick_pick_items_many_options_of_js
    :  Ojs.t
    -> show_quick_pick_items_many_options

  type create_webview_panel_with_options_show_options_item =
    { viewColumn : ViewColumn.t
    ; preserveFocus : bool or_undefined
    }

  val create_webview_panel_with_options_show_options_item_to_js
    :  create_webview_panel_with_options_show_options_item
    -> Ojs.t

  val create_webview_panel_with_options_show_options_item_of_js
    :  Ojs.t
    -> create_webview_panel_with_options_show_options_item

  type create_webview_panel_with_options_show_options =
    [ `ViewColumn of ViewColumn.t
    | `Options of create_webview_panel_with_options_show_options_item
    ]

  val create_webview_panel_with_options_show_options_to_js
    :  create_webview_panel_with_options_show_options
    -> Ojs.t

  val create_webview_panel_with_options_show_options_of_js
    :  Ojs.t
    -> create_webview_panel_with_options_show_options

  type create_webview_panel_with_options_enable_command_uris =
    [ `Bool of bool
    | `Items of string list
    ]

  val create_webview_panel_with_options_enable_command_uris_to_js
    :  create_webview_panel_with_options_enable_command_uris
    -> Ojs.t

  val create_webview_panel_with_options_enable_command_uris_of_js
    :  Ojs.t
    -> create_webview_panel_with_options_enable_command_uris

  type create_webview_panel_with_options =
    { enableFindWidget : bool or_undefined
    ; retainContextWhenHidden : bool or_undefined
    ; enableScripts : bool or_undefined
    ; enableForms : bool or_undefined
    ; enableCommandUris :
        create_webview_panel_with_options_enable_command_uris or_undefined
    ; localResourceRoots : Uri.t list or_undefined
    ; portMapping : WebviewPortMapping.t list or_undefined
    }

  val create_webview_panel_with_options_to_js : create_webview_panel_with_options -> Ojs.t
  val create_webview_panel_with_options_of_js : Ojs.t -> create_webview_panel_with_options

  type register_webview_view_provider_options_webview_options =
    { retainContextWhenHidden : bool or_undefined }

  val register_webview_view_provider_options_webview_options_to_js
    :  register_webview_view_provider_options_webview_options
    -> Ojs.t

  val register_webview_view_provider_options_webview_options_of_js
    :  Ojs.t
    -> register_webview_view_provider_options_webview_options

  type register_webview_view_provider_options =
    { webviewOptions : register_webview_view_provider_options_webview_options or_undefined
    }

  val register_webview_view_provider_options_to_js
    :  register_webview_view_provider_options
    -> Ojs.t

  val register_webview_view_provider_options_of_js
    :  Ojs.t
    -> register_webview_view_provider_options

  type register_custom_editor_provider =
    [ `CustomTextEditorProvider of CustomTextEditorProvider.t
    | `CustomReadonlyEditorProvider of CustomDocument.t CustomReadonlyEditorProvider.t
    | `CustomEditorProvider of CustomDocument.t CustomEditorProvider.t
    ]

  val register_custom_editor_provider_to_js : register_custom_editor_provider -> Ojs.t
  val register_custom_editor_provider_of_js : Ojs.t -> register_custom_editor_provider

  type register_custom_editor_provider_options =
    { webviewOptions : WebviewPanelOptions.t or_undefined
    ; supportsMultipleEditorsPerDocument : bool or_undefined
    }

  val register_custom_editor_provider_options_to_js
    :  register_custom_editor_provider_options
    -> Ojs.t

  val register_custom_editor_provider_options_of_js
    :  Ojs.t
    -> register_custom_editor_provider_options

  val activeTextEditor : unit -> TextEditor.t or_undefined
  val visibleTextEditors : unit -> TextEditor.t list
  val onDidChangeActiveTextEditor : unit -> TextEditor.t or_undefined Event.t
  val onDidChangeVisibleTextEditors : unit -> TextEditor.t list Event.t
  val onDidChangeTextEditorSelection : unit -> TextEditorSelectionChangeEvent.t Event.t
  val onDidChangeTerminalState : unit -> Terminal.t Event.t

  val onDidChangeTerminalShellIntegration
    :  unit
    -> TerminalShellIntegrationChangeEvent.t Event.t

  val onDidStartTerminalShellExecution
    :  unit
    -> TerminalShellExecutionStartEvent.t Event.t

  val onDidEndTerminalShellExecution : unit -> TerminalShellExecutionEndEvent.t Event.t
  val terminals : unit -> Terminal.t list
  val activeTerminal : unit -> Terminal.t or_undefined
  val onDidChangeActiveTerminal : unit -> Terminal.t or_undefined Event.t
  val onDidOpenTerminal : unit -> Terminal.t Event.t
  val onDidCloseTerminal : unit -> Terminal.t Event.t

  val showTextDocument
    :  document:TextDocument.t
    -> ?column:ViewColumn.t
    -> ?preserveFocus:bool
    -> unit
    -> TextEditor.t Promise.t

  val showTextDocument'
    :  document:[ `TextDocument of TextDocument.t | `Uri of Uri.t ]
    -> ?options:TextDocumentShowOptions.t
    -> unit
    -> TextEditor.t Promise.t

  val createTextEditorDecorationType
    :  options:DecorationRenderOptions.t
    -> TextEditorDecorationType.t

  val informationMessage
    :  message:string
    -> ?options:MessageOptions.t
    -> items:MessageItem.t maybe_list
    -> unit
    -> MessageItem.t or_undefined Promise.t

  val showInformationMessage
    :  message:string
    -> ?options:MessageOptions.t
    -> ?choices:(string * 'a) list
    -> unit
    -> 'a option Promise.t

  val showWarningMessage
    :  message:string
    -> ?options:MessageOptions.t
    -> ?choices:(string * 'a) list
    -> unit
    -> 'a option Promise.t

  val showErrorMessage
    :  message:string
    -> ?options:MessageOptions.t
    -> ?choices:(string * 'a) list
    -> unit
    -> 'a option Promise.t

  val showQuickPickItems
    :  choices:(QuickPickItem.t * 'a) list
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> 'a option Promise.t

  val createQuickPick : 'a Js.t -> unit -> 'a QuickPick.t
  val quickInputButtonBack : QuickInputButton.t

  val showQuickPick
    :  items:string list
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string option Promise.t

  val showInputBox
    :  ?options:InputBoxOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string option Promise.t

  val createInputBox : unit -> InputBox.t
  val showOpenDialog : ?options:OpenDialogOptions.t -> unit -> Uri.t list option Promise.t
  val createOutputChannel : name:string -> ?languageId:string -> unit -> OutputChannel.t

  val createOutputChannelWithOptions
    :  name:string
    -> options:OutputChannelOptions.t
    -> LogOutputChannel.t

  val setStatusBarMessage
    :  text:string
    -> ?hide:[ `AfterTimeout of int ]
    -> unit
    -> Disposable.t

  val withProgress
    :  'a Js.t
    -> options:ProgressOptions.t
    -> task:
         (progress:Progress.value Progress.t -> token:CancellationToken.t -> 'a Promise.t)
    -> 'a Promise.t

  val createStatusBarItem
    :  ?alignment:StatusBarAlignment.t
    -> ?priority:float
    -> unit
    -> StatusBarItem.t

  val createTerminal
    :  ?name:string
    -> ?shellPath:string
    -> ?shellArgs:[ `String of string | `Strings of string list ]
    -> unit
    -> Terminal.t

  val createTerminalFromOptions
    :  options:
         [ `TerminalOptions of TerminalOptions.t
         | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
         ]
    -> Terminal.t

  val registerTreeDataProvider
    :  'a Js.t
    -> viewId:string
    -> treeDataProvider:'a TreeDataProvider.t
    -> Disposable.t

  val createTreeView
    :  'a Js.t
    -> viewId:string
    -> options:'a TreeViewOptions.t
    -> 'a TreeView.t

  val createWebviewPanel
    :  viewType:string
    -> title:string
    -> showOptions:ViewColumn.t
    -> WebviewPanel.t

  val registerCustomTextEditorProvider
    :  viewType:string
    -> provider:CustomTextEditorProvider.t
    -> ?options:RegisterCustomEditorProviderOptions.t
    -> unit
    -> Disposable.t

  val registerCustomReadonlyEditorProvider
    :  (module CustomDocument.T with type t = 'a)
    -> viewType:string
    -> provider:'a CustomReadonlyEditorProvider.t
    -> ?options:RegisterCustomEditorProviderOptions.t
    -> unit
    -> Disposable.t

  val tabGroups : unit -> TabGroups.t

  val onDidChangeTextEditorVisibleRanges
    :  unit
    -> TextEditorVisibleRangesChangeEvent.t Event.t

  val onDidChangeTextEditorOptions : unit -> TextEditorOptionsChangeEvent.t Event.t
  val onDidChangeTextEditorViewColumn : unit -> TextEditorViewColumnChangeEvent.t Event.t
  val visibleNotebookEditors : unit -> NotebookEditor.t list
  val onDidChangeVisibleNotebookEditors : unit -> NotebookEditor.t list Event.t
  val activeNotebookEditor : unit -> NotebookEditor.t or_undefined
  val onDidChangeActiveNotebookEditor : unit -> NotebookEditor.t or_undefined Event.t

  val onDidChangeNotebookEditorSelection
    :  unit
    -> NotebookEditorSelectionChangeEvent.t Event.t

  val onDidChangeNotebookEditorVisibleRanges
    :  unit
    -> NotebookEditorVisibleRangesChangeEvent.t Event.t

  val state : unit -> WindowState.t
  val onDidChangeWindowState : unit -> WindowState.t Event.t

  val showNotebookDocument
    :  document:NotebookDocument.t
    -> ?options:NotebookDocumentShowOptions.t
    -> unit
    -> NotebookEditor.t Promise.t

  val showInformationMessageStrings
    :  message:string
    -> items:string list
    -> string or_undefined Promise.t

  val showInformationMessageStringsWithOptions
    :  message:string
    -> options:MessageOptions.t
    -> items:string list
    -> string or_undefined Promise.t

  val showInformationMessageItems
    :  'p_t Js.t
    -> message:string
    -> items:'p_t list
    -> 'p_t or_undefined Promise.t

  val showInformationMessageItemsWithOptions
    :  'p_t Js.t
    -> message:string
    -> options:MessageOptions.t
    -> items:'p_t list
    -> 'p_t or_undefined Promise.t

  val showWarningMessageStrings
    :  message:string
    -> items:string list
    -> string or_undefined Promise.t

  val showWarningMessageStringsWithOptions
    :  message:string
    -> options:MessageOptions.t
    -> items:string list
    -> string or_undefined Promise.t

  val showWarningMessageItems
    :  'p_t Js.t
    -> message:string
    -> items:'p_t list
    -> 'p_t or_undefined Promise.t

  val showWarningMessageItemsWithOptions
    :  'p_t Js.t
    -> message:string
    -> options:MessageOptions.t
    -> items:'p_t list
    -> 'p_t or_undefined Promise.t

  val showErrorMessageStrings
    :  message:string
    -> items:string list
    -> string or_undefined Promise.t

  val showErrorMessageStringsWithOptions
    :  message:string
    -> options:MessageOptions.t
    -> items:string list
    -> string or_undefined Promise.t

  val showErrorMessageItems
    :  'p_t Js.t
    -> message:string
    -> items:'p_t list
    -> 'p_t or_undefined Promise.t

  val showErrorMessageItemsWithOptions
    :  'p_t Js.t
    -> message:string
    -> options:MessageOptions.t
    -> items:'p_t list
    -> 'p_t or_undefined Promise.t

  val showQuickPickMany
    :  items:show_quick_pick_many_items
    -> options:show_quick_pick_many_options
    -> ?token:CancellationToken.t
    -> unit
    -> string list or_undefined Promise.t

  val showQuickPickStrings
    :  items:show_quick_pick_many_items
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string or_undefined Promise.t

  val showQuickPickItemsMany
    :  'p_t Js.t
    -> items:'p_t show_quick_pick_items_many_items
    -> options:show_quick_pick_items_many_options
    -> ?token:CancellationToken.t
    -> unit
    -> 'p_t list or_undefined Promise.t

  val showQuickPickItemsSingle
    :  'p_t Js.t
    -> items:'p_t show_quick_pick_items_many_items
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> 'p_t or_undefined Promise.t

  val showWorkspaceFolderPick
    :  ?options:WorkspaceFolderPickOptions.t
    -> unit
    -> WorkspaceFolder.t or_undefined Promise.t

  val showSaveDialog
    :  ?options:SaveDialogOptions.t
    -> unit
    -> Uri.t or_undefined Promise.t

  val createWebviewPanelWithOptions
    :  viewType:string
    -> title:string
    -> showOptions:create_webview_panel_with_options_show_options
    -> ?options:create_webview_panel_with_options
    -> unit
    -> WebviewPanel.t

  val setStatusBarMessageUntil
    :  text:string
    -> hideWhenDone:Ojs.t Promise.t
    -> Disposable.t

  (** @deprecated Use [withProgress] instead. *)
  val withScmProgress
    :  'p_r Js.t
    -> task:(progress:int Progress.t -> 'p_r Promise.t)
    -> 'p_r Promise.t

  val createStatusBarItemWithId
    :  id:string
    -> ?alignment:StatusBarAlignment.t
    -> ?priority:float
    -> unit
    -> StatusBarItem.t

  val registerUriHandler : handler:UriHandler.t -> Disposable.t

  val registerWebviewPanelSerializer
    :  viewType:string
    -> serializer:Ojs.t WebviewPanelSerializer.t
    -> Disposable.t

  val registerWebviewViewProvider
    :  viewId:string
    -> provider:WebviewViewProvider.t
    -> ?options:register_webview_view_provider_options
    -> unit
    -> Disposable.t

  val registerCustomEditorProvider
    :  viewType:string
    -> provider:register_custom_editor_provider
    -> ?options:register_custom_editor_provider_options
    -> unit
    -> Disposable.t

  val registerTerminalLinkProvider
    :  provider:TerminalLink.t TerminalLinkProvider.t
    -> Disposable.t

  val registerTerminalProfileProvider
    :  id:string
    -> provider:TerminalProfileProvider.t
    -> Disposable.t

  val registerFileDecorationProvider : provider:FileDecorationProvider.t -> Disposable.t
  val activeColorTheme : unit -> ColorTheme.t
  val onDidChangeActiveColorTheme : unit -> ColorTheme.t Event.t
end

module Commands : sig
  val registerCommand
    :  command:string
    -> callback:(args:Ojs.t list -> Ojs.t)
    -> Disposable.t

  val registerTextEditorCommand
    :  command:string
    -> callback:
         (textEditor:TextEditor.t -> edit:TextEditorEdit.t -> args:Ojs.t list -> unit)
    -> Disposable.t

  val executeCommand : command:string -> args:Ojs.t list -> Ojs.t Promise.t
  val getCommands : ?filterInternal:bool -> unit -> string list Promise.t

  val registerCommandWithThisArgs
    :  command:string
    -> callback:(args:Ojs.t list -> Ojs.t)
    -> ?thisArg:Ojs.t
    -> unit
    -> Disposable.t

  val registerTextEditorCommandWithThisArgs
    :  command:string
    -> callback:
         (textEditor:TextEditor.t -> edit:TextEditorEdit.t -> args:Ojs.t list -> unit)
    -> ?thisArg:Ojs.t
    -> unit
    -> Disposable.t

  val executeCommandTyped
    :  'p_t Js.t
    -> command:string
    -> rest:Ojs.t list
    -> 'p_t Promise.t
end

module DiagnosticChangeEvent : sig
  include Ojs.T

  val uris : t -> Uri.t list
  val create : uris:Uri.t list -> unit -> t
end

module DiagnosticCollection : sig
  include Ojs.T

  val name : t -> string
  val set : t -> uri:Uri.t -> diagnostics:Diagnostic.t list or_undefined -> unit
  val setEntries : t -> entries:(Uri.t * Diagnostic.t list or_undefined) list -> unit
  val delete : t -> uri:Uri.t -> unit
  val clear : t -> unit

  val forEach
    :  t
    -> callback:(uri:Uri.t -> diagnostics:Diagnostic.t list -> collection:t -> Ojs.t)
    -> ?thisArg:Ojs.t
    -> unit
    -> unit

  val get : t -> uri:Uri.t -> Diagnostic.t list or_undefined
  val has : t -> uri:Uri.t -> bool
  val dispose : t -> unit
  val iterator : t -> (Uri.t * Diagnostic.t list) IterableIterator.t
end

module LanguageStatusSeverity : sig
  type t =
    | Information
    | Warning
    | Error

  include Ojs.T with type t := t
end

module LanguageStatusItem : sig
  include Ojs.T

  val id : t -> string
  val name : t -> string or_undefined
  val set_name : t -> string or_undefined -> unit
  val selector : t -> DocumentSelector.t
  val set_selector : t -> DocumentSelector.t -> unit
  val severity : t -> LanguageStatusSeverity.t
  val set_severity : t -> LanguageStatusSeverity.t -> unit
  val text : t -> string
  val set_text : t -> string -> unit
  val detail : t -> string or_undefined
  val set_detail : t -> string or_undefined -> unit
  val busy : t -> bool
  val set_busy : t -> bool -> unit
  val command : t -> Command.t or_undefined
  val set_command : t -> Command.t or_undefined -> unit
  val accessibilityInformation : t -> AccessibilityInformation.t or_undefined
  val set_accessibilityInformation : t -> AccessibilityInformation.t or_undefined -> unit
  val dispose : t -> unit

  val create
    :  id:string
    -> name:string or_undefined
    -> selector:DocumentSelector.t
    -> severity:LanguageStatusSeverity.t
    -> text:string
    -> ?detail:string
    -> busy:bool
    -> command:Command.t or_undefined
    -> ?accessibilityInformation:AccessibilityInformation.t
    -> dispose:(unit -> unit)
    -> unit
    -> t
end

module CompletionItemLabel : sig
  include Ojs.T

  val label : t -> string
  val set_label : t -> string -> unit
  val detail : t -> string or_undefined
  val set_detail : t -> string or_undefined -> unit
  val description : t -> string or_undefined
  val set_description : t -> string or_undefined -> unit
  val create : label:string -> ?detail:string -> ?description:string -> unit -> t
end

module CompletionItemKind : sig
  type t =
    | Text
    | Method
    | Function
    | Constructor
    | Field
    | Variable
    | Class
    | Interface
    | Module
    | Property
    | Unit
    | Value
    | Enum
    | Keyword
    | Snippet
    | Color
    | File
    | Reference
    | Folder
    | EnumMember
    | Constant
    | Struct
    | Event
    | Operator
    | TypeParameter
    | User
    | Issue

  include Ojs.T with type t := t
end

module CompletionItemTag : sig
  type t = Deprecated

  include Ojs.T with type t := t
end

module CompletionItem : sig
  include Ojs.T

  type label =
    [ `String of string
    | `CompletionItemLabel of CompletionItemLabel.t
    ]

  val label_to_js : label -> Ojs.t
  val label_of_js : Ojs.t -> label

  type documentation =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val documentation_to_js : documentation -> Ojs.t
  val documentation_of_js : Ojs.t -> documentation

  type insert_text =
    [ `String of string
    | `SnippetString of SnippetString.t
    ]

  val insert_text_to_js : insert_text -> Ojs.t
  val insert_text_of_js : Ojs.t -> insert_text

  type range_item =
    { inserting : Range.t
    ; replacing : Range.t
    }

  val range_item_to_js : range_item -> Ojs.t
  val range_item_of_js : Ojs.t -> range_item

  type range =
    [ `Range of Range.t
    | `Options of range_item
    ]

  val range_to_js : range -> Ojs.t
  val range_of_js : Ojs.t -> range
  val label : t -> label
  val set_label : t -> label -> unit
  val kind : t -> CompletionItemKind.t or_undefined
  val set_kind : t -> CompletionItemKind.t or_undefined -> unit
  val tags : t -> CompletionItemTag.t list or_undefined
  val set_tags : t -> CompletionItemTag.t list or_undefined -> unit
  val detail : t -> string or_undefined
  val set_detail : t -> string or_undefined -> unit
  val documentation : t -> documentation or_undefined
  val set_documentation : t -> documentation or_undefined -> unit
  val sortText : t -> string or_undefined
  val set_sortText : t -> string or_undefined -> unit
  val filterText : t -> string or_undefined
  val set_filterText : t -> string or_undefined -> unit
  val preselect : t -> bool or_undefined
  val set_preselect : t -> bool or_undefined -> unit
  val insertText : t -> insert_text or_undefined
  val set_insertText : t -> insert_text or_undefined -> unit
  val range : t -> range or_undefined
  val set_range : t -> range or_undefined -> unit
  val commitCharacters : t -> string list or_undefined
  val set_commitCharacters : t -> string list or_undefined -> unit
  val keepWhitespace : t -> bool or_undefined
  val set_keepWhitespace : t -> bool or_undefined -> unit

  (** @deprecated
        Use [CompletionItem.insertText] and [CompletionItem.range] instead. An edit which is applied to a document when selecting this completion. When an edit is provided the value of insertText is ignored. The Range of the edit must be single-line and on the same line completions were requested at.
  *)
  val textEdit : t -> TextEdit.t or_undefined

  (** @deprecated
        Use [CompletionItem.insertText] and [CompletionItem.range] instead. An edit which is applied to a document when selecting this completion. When an edit is provided the value of insertText is ignored. The Range of the edit must be single-line and on the same line completions were requested at.
  *)
  val set_textEdit : t -> TextEdit.t or_undefined -> unit

  val additionalTextEdits : t -> TextEdit.t list or_undefined
  val set_additionalTextEdits : t -> TextEdit.t list or_undefined -> unit
  val command : t -> Command.t or_undefined
  val set_command : t -> Command.t or_undefined -> unit
  val make : label:label -> ?kind:CompletionItemKind.t -> unit -> t
end

module CompletionList : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val isIncomplete : t -> bool or_undefined
    val set_isIncomplete : t -> bool or_undefined -> unit
    val items : t -> T.t list
    val set_items : t -> T.t list -> unit
    val make : ?items:T.t list -> ?isIncomplete:bool -> unit -> t
  end
end

module CompletionTriggerKind : sig
  type t =
    | Invoke
    | TriggerCharacter
    | TriggerForIncompleteCompletions

  include Ojs.T with type t := t
end

module CompletionContext : sig
  include Ojs.T

  val triggerKind : t -> CompletionTriggerKind.t
  val triggerCharacter : t -> string or_undefined

  val create
    :  triggerKind:CompletionTriggerKind.t
    -> triggerCharacter:string or_undefined
    -> unit
    -> t
end

module CompletionItemProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    type provide_completion_items_result_t =
      [ `Items of T.t list
      | `CompletionList of T.t CompletionList.t
      ]

    val provide_completion_items_result_t_to_js
      :  provide_completion_items_result_t
      -> Ojs.t

    val provide_completion_items_result_t_of_js
      :  Ojs.t
      -> provide_completion_items_result_t

    val provideCompletionItems
      :  t
      -> document:TextDocument.t
      -> position:Position.t
      -> token:CancellationToken.t
      -> context:CompletionContext.t
      -> provide_completion_items_result_t ProviderResult.t

    val resolveCompletionItem
      :  t
      -> (item:T.t -> token:CancellationToken.t -> T.t ProviderResult.t) or_undefined

    val create
      :  provideCompletionItems:
           (document:TextDocument.t
            -> position:Position.t
            -> token:CancellationToken.t
            -> context:CompletionContext.t
            -> provide_completion_items_result_t ProviderResult.t)
      -> ?resolveCompletionItem:
           (item:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
      -> unit
      -> t
  end
end

module InlineCompletionItem : sig
  include Ojs.T

  type insert_text =
    [ `String of string
    | `SnippetString of SnippetString.t
    ]

  val insert_text_to_js : insert_text -> Ojs.t
  val insert_text_of_js : Ojs.t -> insert_text
  val insertText : t -> insert_text
  val set_insertText : t -> insert_text -> unit
  val filterText : t -> string or_undefined
  val set_filterText : t -> string or_undefined -> unit
  val range : t -> Range.t or_undefined
  val set_range : t -> Range.t or_undefined -> unit
  val command : t -> Command.t or_undefined
  val set_command : t -> Command.t or_undefined -> unit
  val make : insertText:insert_text -> ?range:Range.t -> ?command:Command.t -> unit -> t
end

module InlineCompletionList : sig
  include Ojs.T

  val items : t -> InlineCompletionItem.t list
  val set_items : t -> InlineCompletionItem.t list -> unit
  val make : items:InlineCompletionItem.t list -> t
end

module InlineCompletionTriggerKind : sig
  type t =
    | Invoke
    | Automatic

  include Ojs.T with type t := t
end

module SelectedCompletionInfo : sig
  include Ojs.T

  val range : t -> Range.t
  val text : t -> string
  val create : range:Range.t -> text:string -> unit -> t
end

module InlineCompletionContext : sig
  include Ojs.T

  val triggerKind : t -> InlineCompletionTriggerKind.t
  val selectedCompletionInfo : t -> SelectedCompletionInfo.t or_undefined

  val create
    :  triggerKind:InlineCompletionTriggerKind.t
    -> selectedCompletionInfo:SelectedCompletionInfo.t or_undefined
    -> unit
    -> t
end

module InlineCompletionItemProvider : sig
  include Ojs.T

  type provide_inline_completion_items_result_t =
    [ `Items of InlineCompletionItem.t list
    | `InlineCompletionList of InlineCompletionList.t
    ]

  val provide_inline_completion_items_result_t_to_js
    :  provide_inline_completion_items_result_t
    -> Ojs.t

  val provide_inline_completion_items_result_t_of_js
    :  Ojs.t
    -> provide_inline_completion_items_result_t

  val provideInlineCompletionItems
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> context:InlineCompletionContext.t
    -> token:CancellationToken.t
    -> provide_inline_completion_items_result_t ProviderResult.t

  val create
    :  provideInlineCompletionItems:
         (document:TextDocument.t
          -> position:Position.t
          -> context:InlineCompletionContext.t
          -> token:CancellationToken.t
          -> provide_inline_completion_items_result_t ProviderResult.t)
    -> unit
    -> t
end

module CodeActionTriggerKind : sig
  type t =
    | Invoke
    | Automatic

  include Ojs.T with type t := t
end

module CodeActionKind : sig
  include Ojs.T

  val empty : unit -> t
  val quickFix : unit -> t
  val refactor : unit -> t
  val refactorExtract : unit -> t
  val refactorInline : unit -> t
  val refactorMove : unit -> t
  val refactorRewrite : unit -> t
  val source : unit -> t
  val sourceOrganizeImports : unit -> t
  val sourceFixAll : unit -> t
  val notebook : unit -> t
  val value : t -> string
  val append : t -> parts:string -> t
  val intersects : t -> other:t -> bool
  val contains : t -> other:t -> bool
end

module CodeActionContext : sig
  include Ojs.T

  val triggerKind : t -> CodeActionTriggerKind.t
  val diagnostics : t -> Diagnostic.t list
  val only : t -> CodeActionKind.t or_undefined

  val create
    :  triggerKind:CodeActionTriggerKind.t
    -> diagnostics:Diagnostic.t list
    -> only:CodeActionKind.t or_undefined
    -> unit
    -> t
end

module CodeActionProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    type provide_code_actions_range =
      [ `Range of Range.t
      | `Selection of Selection.t
      ]

    val provide_code_actions_range_to_js : provide_code_actions_range -> Ojs.t
    val provide_code_actions_range_of_js : Ojs.t -> provide_code_actions_range

    type provide_code_actions_result_t_item =
      [ `Command of Command.t
      | `T of T.t
      ]

    val provide_code_actions_result_t_item_to_js
      :  provide_code_actions_result_t_item
      -> Ojs.t

    val provide_code_actions_result_t_item_of_js
      :  Ojs.t
      -> provide_code_actions_result_t_item

    val provideCodeActions
      :  t
      -> document:TextDocument.t
      -> range:provide_code_actions_range
      -> context:CodeActionContext.t
      -> token:CancellationToken.t
      -> provide_code_actions_result_t_item list ProviderResult.t

    val resolveCodeAction
      :  t
      -> (codeAction:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
           or_undefined

    val create
      :  provideCodeActions:
           (document:TextDocument.t
            -> range:provide_code_actions_range
            -> context:CodeActionContext.t
            -> token:CancellationToken.t
            -> provide_code_actions_result_t_item list ProviderResult.t)
      -> ?resolveCodeAction:
           (codeAction:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
      -> unit
      -> t
  end
end

module CodeAction : sig
  include Ojs.T

  type disabled = { reason : string }

  val disabled_to_js : disabled -> Ojs.t
  val disabled_of_js : Ojs.t -> disabled
  val title : t -> string
  val set_title : t -> string -> unit
  val edit : t -> WorkspaceEdit.t or_undefined
  val set_edit : t -> WorkspaceEdit.t or_undefined -> unit
  val diagnostics : t -> Diagnostic.t list or_undefined
  val set_diagnostics : t -> Diagnostic.t list or_undefined -> unit
  val command : t -> Command.t or_undefined
  val set_command : t -> Command.t or_undefined -> unit
  val kind : t -> CodeActionKind.t or_undefined
  val set_kind : t -> CodeActionKind.t or_undefined -> unit
  val isPreferred : t -> bool or_undefined
  val set_isPreferred : t -> bool or_undefined -> unit
  val disabled : t -> disabled or_undefined
  val set_disabled : t -> disabled or_undefined -> unit
  val make : title:string -> ?kind:CodeActionKind.t -> unit -> t
end

module CodeActionProviderMetadata : sig
  include Ojs.T

  type documentation_item =
    { kind : CodeActionKind.t
    ; command : Command.t
    }

  val documentation_item_to_js : documentation_item -> Ojs.t
  val documentation_item_of_js : Ojs.t -> documentation_item
  val providedCodeActionKinds : t -> CodeActionKind.t list or_undefined
  val documentation : t -> documentation_item list or_undefined

  val create
    :  ?providedCodeActionKinds:CodeActionKind.t list
    -> ?documentation:documentation_item list
    -> unit
    -> t
end

module CodeLens : sig
  include Ojs.T

  val range : t -> Range.t
  val set_range : t -> Range.t -> unit
  val command : t -> Command.t or_undefined
  val set_command : t -> Command.t or_undefined -> unit
  val isResolved : t -> bool
  val make : range:Range.t -> ?command:Command.t -> unit -> t
end

module CodeLensProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val onDidChangeCodeLenses : t -> unit Event.t or_undefined
    val set_onDidChangeCodeLenses : t -> unit Event.t or_undefined -> unit

    val provideCodeLenses
      :  t
      -> document:TextDocument.t
      -> token:CancellationToken.t
      -> T.t list ProviderResult.t

    val resolveCodeLens
      :  t
      -> (codeLens:T.t -> token:CancellationToken.t -> T.t ProviderResult.t) or_undefined

    val create
      :  ?onDidChangeCodeLenses:unit Event.t
      -> provideCodeLenses:
           (document:TextDocument.t
            -> token:CancellationToken.t
            -> T.t list ProviderResult.t)
      -> ?resolveCodeLens:
           (codeLens:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
      -> unit
      -> t
  end
end

module Definition : sig
  type value =
    [ `Location of Location.t
    | `Items of Location.t list
    ]

  val value_to_js : value -> Ojs.t
  val value_of_js : Ojs.t -> value

  type t = value

  include Ojs.T with type t := t
end

module LocationLink : sig
  include Ojs.T

  val originSelectionRange : t -> Range.t or_undefined
  val set_originSelectionRange : t -> Range.t or_undefined -> unit
  val targetUri : t -> Uri.t
  val set_targetUri : t -> Uri.t -> unit
  val targetRange : t -> Range.t
  val set_targetRange : t -> Range.t -> unit
  val targetSelectionRange : t -> Range.t or_undefined
  val set_targetSelectionRange : t -> Range.t or_undefined -> unit

  val create
    :  ?originSelectionRange:Range.t
    -> targetUri:Uri.t
    -> targetRange:Range.t
    -> ?targetSelectionRange:Range.t
    -> unit
    -> t
end

module DefinitionLink : sig
  type t = LocationLink.t

  include Ojs.T with type t := t
end

module DefinitionProvider : sig
  include Ojs.T

  type provide_definition_result_t =
    [ `Definition of Definition.t
    | `Items of DefinitionLink.t list
    ]

  val provide_definition_result_t_to_js : provide_definition_result_t -> Ojs.t
  val provide_definition_result_t_of_js : Ojs.t -> provide_definition_result_t

  val provideDefinition
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> token:CancellationToken.t
    -> provide_definition_result_t ProviderResult.t

  val create
    :  provideDefinition:
         (document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> provide_definition_result_t ProviderResult.t)
    -> unit
    -> t
end

module ImplementationProvider : sig
  include Ojs.T

  type provide_implementation_result_t =
    [ `Definition of Definition.t
    | `Items of DefinitionLink.t list
    ]

  val provide_implementation_result_t_to_js : provide_implementation_result_t -> Ojs.t
  val provide_implementation_result_t_of_js : Ojs.t -> provide_implementation_result_t

  val provideImplementation
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> token:CancellationToken.t
    -> provide_implementation_result_t ProviderResult.t

  val create
    :  provideImplementation:
         (document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> provide_implementation_result_t ProviderResult.t)
    -> unit
    -> t
end

module TypeDefinitionProvider : sig
  include Ojs.T

  type provide_type_definition_result_t =
    [ `Definition of Definition.t
    | `Items of DefinitionLink.t list
    ]

  val provide_type_definition_result_t_to_js : provide_type_definition_result_t -> Ojs.t
  val provide_type_definition_result_t_of_js : Ojs.t -> provide_type_definition_result_t

  val provideTypeDefinition
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> token:CancellationToken.t
    -> provide_type_definition_result_t ProviderResult.t

  val create
    :  provideTypeDefinition:
         (document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> provide_type_definition_result_t ProviderResult.t)
    -> unit
    -> t
end

module Declaration : sig
  type value =
    [ `Location of Location.t
    | `Items of Location.t list
    | `ItemsValue of LocationLink.t list
    ]

  val value_to_js : value -> Ojs.t
  val value_of_js : Ojs.t -> value

  type t = value

  include Ojs.T with type t := t
end

module DeclarationProvider : sig
  include Ojs.T

  val provideDeclaration
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> token:CancellationToken.t
    -> Declaration.t ProviderResult.t

  val create
    :  provideDeclaration:
         (document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> Declaration.t ProviderResult.t)
    -> unit
    -> t
end

module EvaluatableExpression : sig
  include Ojs.T

  val range : t -> Range.t
  val expression : t -> string or_undefined
  val make : range:Range.t -> ?expression:string -> unit -> t
end

module EvaluatableExpressionProvider : sig
  include Ojs.T

  val provideEvaluatableExpression
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> token:CancellationToken.t
    -> EvaluatableExpression.t ProviderResult.t

  val create
    :  provideEvaluatableExpression:
         (document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> EvaluatableExpression.t ProviderResult.t)
    -> unit
    -> t
end

module InlineValueContext : sig
  include Ojs.T

  val frameId : t -> int
  val stoppedLocation : t -> Range.t
  val create : frameId:int -> stoppedLocation:Range.t -> unit -> t
end

module InlineValueText : sig
  include Ojs.T

  val range : t -> Range.t
  val text : t -> string
  val make : range:Range.t -> text:string -> t
end

module InlineValueVariableLookup : sig
  include Ojs.T

  val range : t -> Range.t
  val variableName : t -> string or_undefined
  val caseSensitiveLookup : t -> bool

  val make
    :  range:Range.t
    -> ?variableName:string
    -> ?caseSensitiveLookup:bool
    -> unit
    -> t
end

module InlineValueEvaluatableExpression : sig
  include Ojs.T

  val range : t -> Range.t
  val expression : t -> string or_undefined
  val make : range:Range.t -> ?expression:string -> unit -> t
end

module InlineValue : sig
  type value =
    [ `InlineValueText of InlineValueText.t
    | `InlineValueVariableLookup of InlineValueVariableLookup.t
    | `InlineValueEvaluatableExpression of InlineValueEvaluatableExpression.t
    ]

  val value_to_js : value -> Ojs.t
  val value_of_js : Ojs.t -> value

  type t = value

  include Ojs.T with type t := t
end

module InlineValuesProvider : sig
  include Ojs.T

  val onDidChangeInlineValues : t -> unit Event.t or_undefined
  val set_onDidChangeInlineValues : t -> unit Event.t or_undefined -> unit

  val provideInlineValues
    :  t
    -> document:TextDocument.t
    -> viewPort:Range.t
    -> context:InlineValueContext.t
    -> token:CancellationToken.t
    -> InlineValue.t list ProviderResult.t

  val create
    :  ?onDidChangeInlineValues:unit Event.t
    -> provideInlineValues:
         (document:TextDocument.t
          -> viewPort:Range.t
          -> context:InlineValueContext.t
          -> token:CancellationToken.t
          -> InlineValue.t list ProviderResult.t)
    -> unit
    -> t
end

module DocumentHighlightKind : sig
  type t =
    | Text
    | Read
    | Write

  include Ojs.T with type t := t
end

module DocumentHighlight : sig
  include Ojs.T

  val range : t -> Range.t
  val set_range : t -> Range.t -> unit
  val kind : t -> DocumentHighlightKind.t or_undefined
  val set_kind : t -> DocumentHighlightKind.t or_undefined -> unit
  val make : range:Range.t -> ?kind:DocumentHighlightKind.t -> unit -> t
end

module DocumentHighlightProvider : sig
  include Ojs.T

  val provideDocumentHighlights
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> token:CancellationToken.t
    -> DocumentHighlight.t list ProviderResult.t

  val create
    :  provideDocumentHighlights:
         (document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> DocumentHighlight.t list ProviderResult.t)
    -> unit
    -> t
end

module SymbolKind : sig
  type t =
    | File
    | Module
    | Namespace
    | Package
    | Class
    | Method
    | Property
    | Field
    | Constructor
    | Enum
    | Interface
    | Function
    | Variable
    | Constant
    | String
    | Number
    | Boolean
    | Array
    | Object
    | Key
    | Null
    | EnumMember
    | Struct
    | Event
    | Operator
    | TypeParameter

  include Ojs.T with type t := t
end

module SymbolTag : sig
  type t = Deprecated

  include Ojs.T with type t := t
end

module SymbolInformation : sig
  include Ojs.T

  val name : t -> string
  val set_name : t -> string -> unit
  val containerName : t -> string
  val set_containerName : t -> string -> unit
  val kind : t -> SymbolKind.t
  val set_kind : t -> SymbolKind.t -> unit
  val tags : t -> SymbolTag.t list or_undefined
  val set_tags : t -> SymbolTag.t list or_undefined -> unit
  val location : t -> Location.t
  val set_location : t -> Location.t -> unit

  val make
    :  name:string
    -> kind:SymbolKind.t
    -> containerName:string
    -> location:Location.t
    -> t

  (** @deprecated Please use the constructor taking a Location object. *)
  val makeRange
    :  name:string
    -> kind:SymbolKind.t
    -> range:Range.t
    -> ?uri:Uri.t
    -> ?containerName:string
    -> unit
    -> t
end

module DocumentSymbol : sig
  include Ojs.T

  val name : t -> string
  val set_name : t -> string -> unit
  val detail : t -> string
  val set_detail : t -> string -> unit
  val kind : t -> SymbolKind.t
  val set_kind : t -> SymbolKind.t -> unit
  val tags : t -> SymbolTag.t list or_undefined
  val set_tags : t -> SymbolTag.t list or_undefined -> unit
  val range : t -> Range.t
  val set_range : t -> Range.t -> unit
  val selectionRange : t -> Range.t
  val set_selectionRange : t -> Range.t -> unit
  val children : t -> t list
  val set_children : t -> t list -> unit

  val make
    :  name:string
    -> detail:string
    -> kind:SymbolKind.t
    -> range:Range.t
    -> selectionRange:Range.t
    -> t
end

module DocumentSymbolProvider : sig
  include Ojs.T

  type provide_document_symbols_result_t =
    [ `Items of SymbolInformation.t list
    | `ItemsValue of DocumentSymbol.t list
    ]

  val provide_document_symbols_result_t_to_js : provide_document_symbols_result_t -> Ojs.t
  val provide_document_symbols_result_t_of_js : Ojs.t -> provide_document_symbols_result_t

  val provideDocumentSymbols
    :  t
    -> document:TextDocument.t
    -> token:CancellationToken.t
    -> provide_document_symbols_result_t ProviderResult.t

  val create
    :  provideDocumentSymbols:
         (document:TextDocument.t
          -> token:CancellationToken.t
          -> provide_document_symbols_result_t ProviderResult.t)
    -> unit
    -> t
end

module DocumentSymbolProviderMetadata : sig
  include Ojs.T

  val label : t -> string or_undefined
  val set_label : t -> string or_undefined -> unit
  val create : ?label:string -> unit -> t
end

module WorkspaceSymbolProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val provideWorkspaceSymbols
      :  t
      -> query:string
      -> token:CancellationToken.t
      -> T.t list ProviderResult.t

    val resolveWorkspaceSymbol
      :  t
      -> (symbol:T.t -> token:CancellationToken.t -> T.t ProviderResult.t) or_undefined

    val create
      :  provideWorkspaceSymbols:
           (query:string -> token:CancellationToken.t -> T.t list ProviderResult.t)
      -> ?resolveWorkspaceSymbol:
           (symbol:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
      -> unit
      -> t
  end
end

module ReferenceContext : sig
  include Ojs.T

  val includeDeclaration : t -> bool
  val create : includeDeclaration:bool -> unit -> t
end

module ReferenceProvider : sig
  include Ojs.T

  val provideReferences
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> context:ReferenceContext.t
    -> token:CancellationToken.t
    -> Location.t list ProviderResult.t

  val create
    :  provideReferences:
         (document:TextDocument.t
          -> position:Position.t
          -> context:ReferenceContext.t
          -> token:CancellationToken.t
          -> Location.t list ProviderResult.t)
    -> unit
    -> t
end

module RenameProvider : sig
  include Ojs.T

  type prepare_rename_result_t_item =
    { range : Range.t
    ; placeholder : string
    }

  val prepare_rename_result_t_item_to_js : prepare_rename_result_t_item -> Ojs.t
  val prepare_rename_result_t_item_of_js : Ojs.t -> prepare_rename_result_t_item

  type prepare_rename_result_t =
    [ `Range of Range.t
    | `Options of prepare_rename_result_t_item
    ]

  val prepare_rename_result_t_to_js : prepare_rename_result_t -> Ojs.t
  val prepare_rename_result_t_of_js : Ojs.t -> prepare_rename_result_t

  val provideRenameEdits
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> newName:string
    -> token:CancellationToken.t
    -> WorkspaceEdit.t ProviderResult.t

  val prepareRename
    :  t
    -> (document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> prepare_rename_result_t ProviderResult.t)
         or_undefined

  val create
    :  provideRenameEdits:
         (document:TextDocument.t
          -> position:Position.t
          -> newName:string
          -> token:CancellationToken.t
          -> WorkspaceEdit.t ProviderResult.t)
    -> ?prepareRename:
         (document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> prepare_rename_result_t ProviderResult.t)
    -> unit
    -> t
end

module Uint32Array : sig
  include Ojs.T

  val of_array : int array -> t
  val to_array : t -> int array
end

module SemanticTokens : sig
  include Ojs.T

  val resultId : t -> string or_undefined
  val data : t -> Uint32Array.t
  val make : data:Uint32Array.t -> ?resultId:string -> unit -> t
end

module SemanticTokensEdit : sig
  include Ojs.T

  val start : t -> int
  val deleteCount : t -> int
  val data : t -> Uint32Array.t or_undefined
  val make : start:int -> deleteCount:int -> ?data:Uint32Array.t -> unit -> t
end

module SemanticTokensEdits : sig
  include Ojs.T

  val resultId : t -> string or_undefined
  val edits : t -> SemanticTokensEdit.t list
  val make : edits:SemanticTokensEdit.t list -> ?resultId:string -> unit -> t
end

module DocumentSemanticTokensProvider : sig
  include Ojs.T

  type provide_document_semantic_tokens_edits_result_t =
    [ `SemanticTokens of SemanticTokens.t
    | `SemanticTokensEdits of SemanticTokensEdits.t
    ]

  val provide_document_semantic_tokens_edits_result_t_to_js
    :  provide_document_semantic_tokens_edits_result_t
    -> Ojs.t

  val provide_document_semantic_tokens_edits_result_t_of_js
    :  Ojs.t
    -> provide_document_semantic_tokens_edits_result_t

  val onDidChangeSemanticTokens : t -> unit Event.t or_undefined
  val set_onDidChangeSemanticTokens : t -> unit Event.t or_undefined -> unit

  val provideDocumentSemanticTokens
    :  t
    -> document:TextDocument.t
    -> token:CancellationToken.t
    -> SemanticTokens.t ProviderResult.t

  val provideDocumentSemanticTokensEdits
    :  t
    -> (document:TextDocument.t
        -> previousResultId:string
        -> token:CancellationToken.t
        -> provide_document_semantic_tokens_edits_result_t ProviderResult.t)
         or_undefined

  val create
    :  ?onDidChangeSemanticTokens:unit Event.t
    -> provideDocumentSemanticTokens:
         (document:TextDocument.t
          -> token:CancellationToken.t
          -> SemanticTokens.t ProviderResult.t)
    -> ?provideDocumentSemanticTokensEdits:
         (document:TextDocument.t
          -> previousResultId:string
          -> token:CancellationToken.t
          -> provide_document_semantic_tokens_edits_result_t ProviderResult.t)
    -> unit
    -> t
end

module SemanticTokensLegend : sig
  include Ojs.T

  val tokenTypes : t -> string list
  val tokenModifiers : t -> string list
  val make : tokenTypes:string list -> ?tokenModifiers:string list -> unit -> t
end

module DocumentRangeSemanticTokensProvider : sig
  include Ojs.T

  val onDidChangeSemanticTokens : t -> unit Event.t or_undefined
  val set_onDidChangeSemanticTokens : t -> unit Event.t or_undefined -> unit

  val provideDocumentRangeSemanticTokens
    :  t
    -> document:TextDocument.t
    -> range:Range.t
    -> token:CancellationToken.t
    -> SemanticTokens.t ProviderResult.t

  val create
    :  ?onDidChangeSemanticTokens:unit Event.t
    -> provideDocumentRangeSemanticTokens:
         (document:TextDocument.t
          -> range:Range.t
          -> token:CancellationToken.t
          -> SemanticTokens.t ProviderResult.t)
    -> unit
    -> t
end

module DocumentRangeFormattingEditProvider : sig
  include Ojs.T

  val provideDocumentRangeFormattingEdits
    :  t
    -> document:TextDocument.t
    -> range:Range.t
    -> options:FormattingOptions.t
    -> token:CancellationToken.t
    -> TextEdit.t list ProviderResult.t

  val provideDocumentRangesFormattingEdits
    :  t
    -> (document:TextDocument.t
        -> ranges:Range.t list
        -> options:FormattingOptions.t
        -> token:CancellationToken.t
        -> TextEdit.t list ProviderResult.t)
         or_undefined

  val create
    :  provideDocumentRangeFormattingEdits:
         (document:TextDocument.t
          -> range:Range.t
          -> options:FormattingOptions.t
          -> token:CancellationToken.t
          -> TextEdit.t list ProviderResult.t)
    -> ?provideDocumentRangesFormattingEdits:
         (document:TextDocument.t
          -> ranges:Range.t list
          -> options:FormattingOptions.t
          -> token:CancellationToken.t
          -> TextEdit.t list ProviderResult.t)
    -> unit
    -> t
end

module OnTypeFormattingEditProvider : sig
  include Ojs.T

  val provideOnTypeFormattingEdits
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> ch:string
    -> options:FormattingOptions.t
    -> token:CancellationToken.t
    -> TextEdit.t list ProviderResult.t

  val create
    :  provideOnTypeFormattingEdits:
         (document:TextDocument.t
          -> position:Position.t
          -> ch:string
          -> options:FormattingOptions.t
          -> token:CancellationToken.t
          -> TextEdit.t list ProviderResult.t)
    -> unit
    -> t
end

module SignatureHelpTriggerKind : sig
  type t =
    | Invoke
    | TriggerCharacter
    | ContentChange

  include Ojs.T with type t := t
end

module ParameterInformation : sig
  include Ojs.T

  type label =
    [ `String of string
    | `Options of int * int
    ]

  val label_to_js : label -> Ojs.t
  val label_of_js : Ojs.t -> label

  type documentation =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val documentation_to_js : documentation -> Ojs.t
  val documentation_of_js : Ojs.t -> documentation
  val label : t -> label
  val set_label : t -> label -> unit
  val documentation : t -> documentation or_undefined
  val set_documentation : t -> documentation or_undefined -> unit
  val make : label:label -> ?documentation:documentation -> unit -> t
end

module SignatureInformation : sig
  include Ojs.T

  type documentation =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val documentation_to_js : documentation -> Ojs.t
  val documentation_of_js : Ojs.t -> documentation
  val label : t -> string
  val set_label : t -> string -> unit
  val documentation : t -> documentation or_undefined
  val set_documentation : t -> documentation or_undefined -> unit
  val parameters : t -> ParameterInformation.t list
  val set_parameters : t -> ParameterInformation.t list -> unit
  val activeParameter : t -> int or_undefined
  val set_activeParameter : t -> int or_undefined -> unit
  val make : label:string -> ?documentation:documentation -> unit -> t
end

module SignatureHelp : sig
  include Ojs.T

  val signatures : t -> SignatureInformation.t list
  val set_signatures : t -> SignatureInformation.t list -> unit
  val activeSignature : t -> int
  val set_activeSignature : t -> int -> unit
  val activeParameter : t -> int
  val set_activeParameter : t -> int -> unit
  val make : unit -> t
end

module SignatureHelpContext : sig
  include Ojs.T

  val triggerKind : t -> SignatureHelpTriggerKind.t
  val triggerCharacter : t -> string or_undefined
  val isRetrigger : t -> bool
  val activeSignatureHelp : t -> SignatureHelp.t or_undefined

  val create
    :  triggerKind:SignatureHelpTriggerKind.t
    -> triggerCharacter:string or_undefined
    -> isRetrigger:bool
    -> activeSignatureHelp:SignatureHelp.t or_undefined
    -> unit
    -> t
end

module SignatureHelpProvider : sig
  include Ojs.T

  val provideSignatureHelp
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> token:CancellationToken.t
    -> context:SignatureHelpContext.t
    -> SignatureHelp.t ProviderResult.t

  val create
    :  provideSignatureHelp:
         (document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> context:SignatureHelpContext.t
          -> SignatureHelp.t ProviderResult.t)
    -> unit
    -> t
end

module SignatureHelpProviderMetadata : sig
  include Ojs.T

  val triggerCharacters : t -> string list
  val retriggerCharacters : t -> string list

  val create
    :  triggerCharacters:string list
    -> retriggerCharacters:string list
    -> unit
    -> t
end

module DocumentLink : sig
  include Ojs.T

  val range : t -> Range.t
  val set_range : t -> Range.t -> unit
  val target : t -> Uri.t or_undefined
  val set_target : t -> Uri.t or_undefined -> unit
  val tooltip : t -> string or_undefined
  val set_tooltip : t -> string or_undefined -> unit
  val make : range:Range.t -> ?target:Uri.t -> unit -> t
end

module DocumentLinkProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val provideDocumentLinks
      :  t
      -> document:TextDocument.t
      -> token:CancellationToken.t
      -> T.t list ProviderResult.t

    val resolveDocumentLink
      :  t
      -> (link:T.t -> token:CancellationToken.t -> T.t ProviderResult.t) or_undefined

    val create
      :  provideDocumentLinks:
           (document:TextDocument.t
            -> token:CancellationToken.t
            -> T.t list ProviderResult.t)
      -> ?resolveDocumentLink:
           (link:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
      -> unit
      -> t
  end
end

module Color : sig
  include Ojs.T

  val red : t -> int
  val green : t -> int
  val blue : t -> int
  val alpha : t -> int
  val make : red:int -> green:int -> blue:int -> alpha:int -> t
end

module ColorInformation : sig
  include Ojs.T

  val range : t -> Range.t
  val set_range : t -> Range.t -> unit
  val color : t -> Color.t
  val set_color : t -> Color.t -> unit
  val make : range:Range.t -> color:Color.t -> t
end

module ColorPresentation : sig
  include Ojs.T

  val label : t -> string
  val set_label : t -> string -> unit
  val textEdit : t -> TextEdit.t or_undefined
  val set_textEdit : t -> TextEdit.t or_undefined -> unit
  val additionalTextEdits : t -> TextEdit.t list or_undefined
  val set_additionalTextEdits : t -> TextEdit.t list or_undefined -> unit
  val make : label:string -> t
end

module DocumentColorProvider : sig
  include Ojs.T

  type provide_color_presentations_context =
    { document : TextDocument.t
    ; range : Range.t
    }

  val provide_color_presentations_context_to_js
    :  provide_color_presentations_context
    -> Ojs.t

  val provide_color_presentations_context_of_js
    :  Ojs.t
    -> provide_color_presentations_context

  val provideDocumentColors
    :  t
    -> document:TextDocument.t
    -> token:CancellationToken.t
    -> ColorInformation.t list ProviderResult.t

  val provideColorPresentations
    :  t
    -> color:Color.t
    -> context:provide_color_presentations_context
    -> token:CancellationToken.t
    -> ColorPresentation.t list ProviderResult.t

  val create
    :  provideDocumentColors:
         (document:TextDocument.t
          -> token:CancellationToken.t
          -> ColorInformation.t list ProviderResult.t)
    -> provideColorPresentations:
         (color:Color.t
          -> context:provide_color_presentations_context
          -> token:CancellationToken.t
          -> ColorPresentation.t list ProviderResult.t)
    -> unit
    -> t
end

module InlayHintLabelPart : sig
  include Ojs.T

  type tooltip =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val tooltip_to_js : tooltip -> Ojs.t
  val tooltip_of_js : Ojs.t -> tooltip
  val value : t -> string
  val set_value : t -> string -> unit
  val tooltip : t -> tooltip or_undefined
  val set_tooltip : t -> tooltip or_undefined -> unit
  val location : t -> Location.t or_undefined
  val set_location : t -> Location.t or_undefined -> unit
  val command : t -> Command.t or_undefined
  val set_command : t -> Command.t or_undefined -> unit
  val make : value:string -> t
end

module InlayHintKind : sig
  type t =
    | Type
    | Parameter

  include Ojs.T with type t := t
end

module InlayHint : sig
  include Ojs.T

  type label =
    [ `String of string
    | `Items of InlayHintLabelPart.t list
    ]

  val label_to_js : label -> Ojs.t
  val label_of_js : Ojs.t -> label

  type tooltip =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val tooltip_to_js : tooltip -> Ojs.t
  val tooltip_of_js : Ojs.t -> tooltip
  val position : t -> Position.t
  val set_position : t -> Position.t -> unit
  val label : t -> label
  val set_label : t -> label -> unit
  val tooltip : t -> tooltip or_undefined
  val set_tooltip : t -> tooltip or_undefined -> unit
  val kind : t -> InlayHintKind.t or_undefined
  val set_kind : t -> InlayHintKind.t or_undefined -> unit
  val textEdits : t -> TextEdit.t list or_undefined
  val set_textEdits : t -> TextEdit.t list or_undefined -> unit
  val paddingLeft : t -> bool or_undefined
  val set_paddingLeft : t -> bool or_undefined -> unit
  val paddingRight : t -> bool or_undefined
  val set_paddingRight : t -> bool or_undefined -> unit
  val make : position:Position.t -> label:label -> ?kind:InlayHintKind.t -> unit -> t
end

module InlayHintsProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val onDidChangeInlayHints : t -> unit Event.t or_undefined
    val set_onDidChangeInlayHints : t -> unit Event.t or_undefined -> unit

    val provideInlayHints
      :  t
      -> document:TextDocument.t
      -> range:Range.t
      -> token:CancellationToken.t
      -> T.t list ProviderResult.t

    val resolveInlayHint
      :  t
      -> (hint:T.t -> token:CancellationToken.t -> T.t ProviderResult.t) or_undefined

    val create
      :  ?onDidChangeInlayHints:unit Event.t
      -> provideInlayHints:
           (document:TextDocument.t
            -> range:Range.t
            -> token:CancellationToken.t
            -> T.t list ProviderResult.t)
      -> ?resolveInlayHint:(hint:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
      -> unit
      -> t
  end
end

module FoldingContext : sig
  include Ojs.T
end

module FoldingRangeKind : sig
  type t =
    | Comment
    | Imports
    | Region

  include Ojs.T with type t := t
end

module FoldingRange : sig
  include Ojs.T

  val start : t -> int
  val set_start : t -> int -> unit
  val end_ : t -> int
  val set_end_ : t -> int -> unit
  val kind : t -> FoldingRangeKind.t or_undefined
  val set_kind : t -> FoldingRangeKind.t or_undefined -> unit
  val make : start:int -> end_:int -> ?kind:FoldingRangeKind.t -> unit -> t
end

module FoldingRangeProvider : sig
  include Ojs.T

  val onDidChangeFoldingRanges : t -> unit Event.t or_undefined
  val set_onDidChangeFoldingRanges : t -> unit Event.t or_undefined -> unit

  val provideFoldingRanges
    :  t
    -> document:TextDocument.t
    -> context:FoldingContext.t
    -> token:CancellationToken.t
    -> FoldingRange.t list ProviderResult.t

  val create
    :  ?onDidChangeFoldingRanges:unit Event.t
    -> provideFoldingRanges:
         (document:TextDocument.t
          -> context:FoldingContext.t
          -> token:CancellationToken.t
          -> FoldingRange.t list ProviderResult.t)
    -> unit
    -> t
end

module SelectionRange : sig
  include Ojs.T

  val range : t -> Range.t
  val set_range : t -> Range.t -> unit
  val parent : t -> t or_undefined
  val set_parent : t -> t or_undefined -> unit
  val make : range:Range.t -> ?parent:t -> unit -> t
end

module SelectionRangeProvider : sig
  include Ojs.T

  val provideSelectionRanges
    :  t
    -> document:TextDocument.t
    -> positions:Position.t list
    -> token:CancellationToken.t
    -> SelectionRange.t list ProviderResult.t

  val create
    :  provideSelectionRanges:
         (document:TextDocument.t
          -> positions:Position.t list
          -> token:CancellationToken.t
          -> SelectionRange.t list ProviderResult.t)
    -> unit
    -> t
end

module CallHierarchyItem : sig
  include Ojs.T

  val name : t -> string
  val set_name : t -> string -> unit
  val kind : t -> SymbolKind.t
  val set_kind : t -> SymbolKind.t -> unit
  val tags : t -> SymbolTag.t list or_undefined
  val set_tags : t -> SymbolTag.t list or_undefined -> unit
  val detail : t -> string or_undefined
  val set_detail : t -> string or_undefined -> unit
  val uri : t -> Uri.t
  val set_uri : t -> Uri.t -> unit
  val range : t -> Range.t
  val set_range : t -> Range.t -> unit
  val selectionRange : t -> Range.t
  val set_selectionRange : t -> Range.t -> unit

  val make
    :  kind:SymbolKind.t
    -> name:string
    -> detail:string
    -> uri:Uri.t
    -> range:Range.t
    -> selectionRange:Range.t
    -> t
end

module CallHierarchyIncomingCall : sig
  include Ojs.T

  val from : t -> CallHierarchyItem.t
  val set_from : t -> CallHierarchyItem.t -> unit
  val fromRanges : t -> Range.t list
  val set_fromRanges : t -> Range.t list -> unit
  val make : item:CallHierarchyItem.t -> fromRanges:Range.t list -> t
end

module CallHierarchyOutgoingCall : sig
  include Ojs.T

  val to_ : t -> CallHierarchyItem.t
  val set_to_ : t -> CallHierarchyItem.t -> unit
  val fromRanges : t -> Range.t list
  val set_fromRanges : t -> Range.t list -> unit
  val make : item:CallHierarchyItem.t -> fromRanges:Range.t list -> t
end

module CallHierarchyProvider : sig
  include Ojs.T

  type prepare_call_hierarchy_result_t =
    [ `CallHierarchyItem of CallHierarchyItem.t
    | `Items of CallHierarchyItem.t list
    ]

  val prepare_call_hierarchy_result_t_to_js : prepare_call_hierarchy_result_t -> Ojs.t
  val prepare_call_hierarchy_result_t_of_js : Ojs.t -> prepare_call_hierarchy_result_t

  val prepareCallHierarchy
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> token:CancellationToken.t
    -> prepare_call_hierarchy_result_t ProviderResult.t

  val provideCallHierarchyIncomingCalls
    :  t
    -> item:CallHierarchyItem.t
    -> token:CancellationToken.t
    -> CallHierarchyIncomingCall.t list ProviderResult.t

  val provideCallHierarchyOutgoingCalls
    :  t
    -> item:CallHierarchyItem.t
    -> token:CancellationToken.t
    -> CallHierarchyOutgoingCall.t list ProviderResult.t

  val create
    :  prepareCallHierarchy:
         (document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> prepare_call_hierarchy_result_t ProviderResult.t)
    -> provideCallHierarchyIncomingCalls:
         (item:CallHierarchyItem.t
          -> token:CancellationToken.t
          -> CallHierarchyIncomingCall.t list ProviderResult.t)
    -> provideCallHierarchyOutgoingCalls:
         (item:CallHierarchyItem.t
          -> token:CancellationToken.t
          -> CallHierarchyOutgoingCall.t list ProviderResult.t)
    -> unit
    -> t
end

module TypeHierarchyItem : sig
  include Ojs.T

  val name : t -> string
  val set_name : t -> string -> unit
  val kind : t -> SymbolKind.t
  val set_kind : t -> SymbolKind.t -> unit
  val tags : t -> SymbolTag.t list or_undefined
  val set_tags : t -> SymbolTag.t list or_undefined -> unit
  val detail : t -> string or_undefined
  val set_detail : t -> string or_undefined -> unit
  val uri : t -> Uri.t
  val set_uri : t -> Uri.t -> unit
  val range : t -> Range.t
  val set_range : t -> Range.t -> unit
  val selectionRange : t -> Range.t
  val set_selectionRange : t -> Range.t -> unit

  val make
    :  kind:SymbolKind.t
    -> name:string
    -> detail:string
    -> uri:Uri.t
    -> range:Range.t
    -> selectionRange:Range.t
    -> t
end

module TypeHierarchyProvider : sig
  include Ojs.T

  type prepare_type_hierarchy_result_t =
    [ `TypeHierarchyItem of TypeHierarchyItem.t
    | `Items of TypeHierarchyItem.t list
    ]

  val prepare_type_hierarchy_result_t_to_js : prepare_type_hierarchy_result_t -> Ojs.t
  val prepare_type_hierarchy_result_t_of_js : Ojs.t -> prepare_type_hierarchy_result_t

  val prepareTypeHierarchy
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> token:CancellationToken.t
    -> prepare_type_hierarchy_result_t ProviderResult.t

  val provideTypeHierarchySupertypes
    :  t
    -> item:TypeHierarchyItem.t
    -> token:CancellationToken.t
    -> TypeHierarchyItem.t list ProviderResult.t

  val provideTypeHierarchySubtypes
    :  t
    -> item:TypeHierarchyItem.t
    -> token:CancellationToken.t
    -> TypeHierarchyItem.t list ProviderResult.t

  val create
    :  prepareTypeHierarchy:
         (document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> prepare_type_hierarchy_result_t ProviderResult.t)
    -> provideTypeHierarchySupertypes:
         (item:TypeHierarchyItem.t
          -> token:CancellationToken.t
          -> TypeHierarchyItem.t list ProviderResult.t)
    -> provideTypeHierarchySubtypes:
         (item:TypeHierarchyItem.t
          -> token:CancellationToken.t
          -> TypeHierarchyItem.t list ProviderResult.t)
    -> unit
    -> t
end

module LinkedEditingRanges : sig
  include Ojs.T

  val make : ranges:Range.t list -> ?wordPattern:Regexp.t -> unit -> t
  val ranges : t -> Range.t list
  val wordPattern : t -> Regexp.t or_undefined
end

module LinkedEditingRangeProvider : sig
  include Ojs.T

  val provideLinkedEditingRanges
    :  t
    -> document:TextDocument.t
    -> position:Position.t
    -> token:CancellationToken.t
    -> LinkedEditingRanges.t ProviderResult.t

  val create
    :  provideLinkedEditingRanges:
         (document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> LinkedEditingRanges.t ProviderResult.t)
    -> unit
    -> t
end

module DocumentDropEditProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    type provide_document_drop_edits_result_t =
      [ `T of T.t
      | `Items of T.t list
      ]

    val provide_document_drop_edits_result_t_to_js
      :  provide_document_drop_edits_result_t
      -> Ojs.t

    val provide_document_drop_edits_result_t_of_js
      :  Ojs.t
      -> provide_document_drop_edits_result_t

    val provideDocumentDropEdits
      :  t
      -> document:TextDocument.t
      -> position:Position.t
      -> dataTransfer:DataTransfer.t
      -> token:CancellationToken.t
      -> provide_document_drop_edits_result_t ProviderResult.t

    val resolveDocumentDropEdit
      :  t
      -> (edit:T.t -> token:CancellationToken.t -> T.t ProviderResult.t) or_undefined

    val create
      :  provideDocumentDropEdits:
           (document:TextDocument.t
            -> position:Position.t
            -> dataTransfer:DataTransfer.t
            -> token:CancellationToken.t
            -> provide_document_drop_edits_result_t ProviderResult.t)
      -> ?resolveDocumentDropEdit:
           (edit:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
      -> unit
      -> t
  end
end

module DocumentDropOrPasteEditKind : sig
  include Ojs.T

  val empty : unit -> t
  val text : unit -> t
  val textUpdateImports : unit -> t
  val value : t -> string
  val append : t -> parts:string list -> t
  val intersects : t -> other:t -> bool
  val contains : t -> other:t -> bool
end

module DocumentDropEdit : sig
  include Ojs.T

  type insert_text =
    [ `String of string
    | `SnippetString of SnippetString.t
    ]

  val insert_text_to_js : insert_text -> Ojs.t
  val insert_text_of_js : Ojs.t -> insert_text
  val title : t -> string or_undefined
  val set_title : t -> string or_undefined -> unit
  val kind : t -> DocumentDropOrPasteEditKind.t or_undefined
  val set_kind : t -> DocumentDropOrPasteEditKind.t or_undefined -> unit
  val yieldTo : t -> DocumentDropOrPasteEditKind.t list or_undefined
  val set_yieldTo : t -> DocumentDropOrPasteEditKind.t list or_undefined -> unit
  val insertText : t -> insert_text
  val set_insertText : t -> insert_text -> unit
  val additionalEdit : t -> WorkspaceEdit.t or_undefined
  val set_additionalEdit : t -> WorkspaceEdit.t or_undefined -> unit

  val make
    :  insertText:insert_text
    -> ?title:string
    -> ?kind:DocumentDropOrPasteEditKind.t
    -> unit
    -> t
end

module DocumentDropEditProviderMetadata : sig
  include Ojs.T

  val providedDropEditKinds : t -> DocumentDropOrPasteEditKind.t list or_undefined
  val dropMimeTypes : t -> string list

  val create
    :  ?providedDropEditKinds:DocumentDropOrPasteEditKind.t list
    -> dropMimeTypes:string list
    -> unit
    -> t
end

module DocumentPasteEdit : sig
  include Ojs.T

  type insert_text =
    [ `String of string
    | `SnippetString of SnippetString.t
    ]

  val insert_text_to_js : insert_text -> Ojs.t
  val insert_text_of_js : Ojs.t -> insert_text
  val title : t -> string
  val set_title : t -> string -> unit
  val kind : t -> DocumentDropOrPasteEditKind.t
  val set_kind : t -> DocumentDropOrPasteEditKind.t -> unit
  val insertText : t -> insert_text
  val set_insertText : t -> insert_text -> unit
  val additionalEdit : t -> WorkspaceEdit.t or_undefined
  val set_additionalEdit : t -> WorkspaceEdit.t or_undefined -> unit
  val yieldTo : t -> DocumentDropOrPasteEditKind.t list or_undefined
  val set_yieldTo : t -> DocumentDropOrPasteEditKind.t list or_undefined -> unit

  val make
    :  insertText:insert_text
    -> title:string
    -> kind:DocumentDropOrPasteEditKind.t
    -> t
end

module DocumentPasteTriggerKind : sig
  type t =
    | Automatic
    | PasteAs

  include Ojs.T with type t := t
end

module DocumentPasteEditContext : sig
  include Ojs.T

  val only : t -> DocumentDropOrPasteEditKind.t or_undefined
  val triggerKind : t -> DocumentPasteTriggerKind.t

  val create
    :  only:DocumentDropOrPasteEditKind.t or_undefined
    -> triggerKind:DocumentPasteTriggerKind.t
    -> unit
    -> t
end

module DocumentPasteEditProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    type prepare_document_paste_result =
      [ `Unit of unit
      | `Promise of unit Promise.t
      ]

    val prepare_document_paste_result_to_js : prepare_document_paste_result -> Ojs.t
    val prepare_document_paste_result_of_js : Ojs.t -> prepare_document_paste_result

    val prepareDocumentPaste
      :  t
      -> (document:TextDocument.t
          -> ranges:Range.t list
          -> dataTransfer:DataTransfer.t
          -> token:CancellationToken.t
          -> prepare_document_paste_result)
           or_undefined

    val provideDocumentPasteEdits
      :  t
      -> (document:TextDocument.t
          -> ranges:Range.t list
          -> dataTransfer:DataTransfer.t
          -> context:DocumentPasteEditContext.t
          -> token:CancellationToken.t
          -> T.t list ProviderResult.t)
           or_undefined

    val resolveDocumentPasteEdit
      :  t
      -> (pasteEdit:T.t -> token:CancellationToken.t -> T.t ProviderResult.t) or_undefined

    val create
      :  ?prepareDocumentPaste:
           (document:TextDocument.t
            -> ranges:Range.t list
            -> dataTransfer:DataTransfer.t
            -> token:CancellationToken.t
            -> prepare_document_paste_result)
      -> ?provideDocumentPasteEdits:
           (document:TextDocument.t
            -> ranges:Range.t list
            -> dataTransfer:DataTransfer.t
            -> context:DocumentPasteEditContext.t
            -> token:CancellationToken.t
            -> T.t list ProviderResult.t)
      -> ?resolveDocumentPasteEdit:
           (pasteEdit:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
      -> unit
      -> t
  end
end

module DocumentPasteProviderMetadata : sig
  include Ojs.T

  val providedPasteEditKinds : t -> DocumentDropOrPasteEditKind.t list
  val copyMimeTypes : t -> string list or_undefined
  val pasteMimeTypes : t -> string list or_undefined

  val create
    :  providedPasteEditKinds:DocumentDropOrPasteEditKind.t list
    -> ?copyMimeTypes:string list
    -> ?pasteMimeTypes:string list
    -> unit
    -> t
end

module LineCommentRule : sig
  include Ojs.T

  val comment : t -> string
  val set_comment : t -> string -> unit
  val noIndent : t -> bool or_undefined
  val set_noIndent : t -> bool or_undefined -> unit
  val create : comment:string -> ?noIndent:bool -> unit -> t
end

module CharacterPair : sig
  type t = string * string

  include Ojs.T with type t := t
end

module CommentRule : sig
  include Ojs.T

  type line_comment =
    [ `String of string
    | `LineCommentRule of LineCommentRule.t
    ]

  val line_comment_to_js : line_comment -> Ojs.t
  val line_comment_of_js : Ojs.t -> line_comment
  val lineComment : t -> line_comment or_undefined
  val set_lineComment : t -> line_comment or_undefined -> unit
  val blockComment : t -> CharacterPair.t or_undefined
  val set_blockComment : t -> CharacterPair.t or_undefined -> unit
  val create : ?lineComment:line_comment -> ?blockComment:CharacterPair.t -> unit -> t
end

module IndentationRule : sig
  include Ojs.T

  val decreaseIndentPattern : t -> Regexp.t
  val set_decreaseIndentPattern : t -> Regexp.t -> unit
  val increaseIndentPattern : t -> Regexp.t
  val set_increaseIndentPattern : t -> Regexp.t -> unit
  val indentNextLinePattern : t -> Regexp.t or_undefined
  val set_indentNextLinePattern : t -> Regexp.t or_undefined -> unit
  val unIndentedLinePattern : t -> Regexp.t or_undefined
  val set_unIndentedLinePattern : t -> Regexp.t or_undefined -> unit

  val create
    :  decreaseIndentPattern:Regexp.t
    -> increaseIndentPattern:Regexp.t
    -> ?indentNextLinePattern:Regexp.t
    -> ?unIndentedLinePattern:Regexp.t
    -> unit
    -> t
end

module IndentAction : sig
  type t =
    | None
    | Indent
    | IndentOutdent
    | Outdent

  include Ojs.T with type t := t
end

module EnterAction : sig
  include Ojs.T

  val indentAction : t -> IndentAction.t
  val set_indentAction : t -> IndentAction.t -> unit
  val appendText : t -> string or_undefined
  val set_appendText : t -> string or_undefined -> unit
  val removeText : t -> int or_undefined
  val set_removeText : t -> int or_undefined -> unit

  val create
    :  indentAction:IndentAction.t
    -> ?appendText:string
    -> ?removeText:int
    -> unit
    -> t
end

module OnEnterRule : sig
  include Ojs.T

  val beforeText : t -> Regexp.t
  val set_beforeText : t -> Regexp.t -> unit
  val afterText : t -> Regexp.t or_undefined
  val set_afterText : t -> Regexp.t or_undefined -> unit
  val previousLineText : t -> Regexp.t or_undefined
  val set_previousLineText : t -> Regexp.t or_undefined -> unit
  val action : t -> EnterAction.t
  val set_action : t -> EnterAction.t -> unit

  val create
    :  beforeText:Regexp.t
    -> ?afterText:Regexp.t
    -> ?previousLineText:Regexp.t
    -> action:EnterAction.t
    -> unit
    -> t
end

module SyntaxTokenType : sig
  type t =
    | Other
    | Comment
    | String
    | RegEx

  include Ojs.T with type t := t
end

module AutoClosingPair : sig
  include Ojs.T

  val open_ : t -> string
  val set_open_ : t -> string -> unit
  val close : t -> string
  val set_close : t -> string -> unit
  val notIn : t -> SyntaxTokenType.t list or_undefined
  val set_notIn : t -> SyntaxTokenType.t list or_undefined -> unit
  val create : open_:string -> close:string -> ?notIn:SyntaxTokenType.t list -> unit -> t
end

module LanguageConfiguration : sig
  include Ojs.T

  type _electric_character_support_doc_comment =
    { scope : string (** @deprecated Deprecated by the VS Code API. *)
    ; open_ : string (** @deprecated Deprecated by the VS Code API. *)
    ; lineStart : string (** @deprecated Deprecated by the VS Code API. *)
    ; close : string or_undefined (** @deprecated Deprecated by the VS Code API. *)
    }

  val _electric_character_support_doc_comment_to_js
    :  _electric_character_support_doc_comment
    -> Ojs.t

  val _electric_character_support_doc_comment_of_js
    :  Ojs.t
    -> _electric_character_support_doc_comment

  type _electric_character_support =
    { brackets : Ojs.t or_undefined (** @deprecated Deprecated by the VS Code API. *)
    ; docComment : _electric_character_support_doc_comment or_undefined
      (** @deprecated Deprecated by the VS Code API. *)
    }

  val _electric_character_support_to_js : _electric_character_support -> Ojs.t
  val _electric_character_support_of_js : Ojs.t -> _electric_character_support

  type _character_pair_support_auto_closing_pairs_item =
    { open_ : string (** @deprecated Deprecated by the VS Code API. *)
    ; close : string (** @deprecated Deprecated by the VS Code API. *)
    ; notIn : string list or_undefined (** @deprecated Deprecated by the VS Code API. *)
    }

  val _character_pair_support_auto_closing_pairs_item_to_js
    :  _character_pair_support_auto_closing_pairs_item
    -> Ojs.t

  val _character_pair_support_auto_closing_pairs_item_of_js
    :  Ojs.t
    -> _character_pair_support_auto_closing_pairs_item

  type _character_pair_support =
    { autoClosingPairs : _character_pair_support_auto_closing_pairs_item list
      (** @deprecated Deprecated by the VS Code API. *)
    }

  val _character_pair_support_to_js : _character_pair_support -> Ojs.t
  val _character_pair_support_of_js : Ojs.t -> _character_pair_support
  val comments : t -> CommentRule.t or_undefined
  val set_comments : t -> CommentRule.t or_undefined -> unit
  val brackets : t -> CharacterPair.t list or_undefined
  val set_brackets : t -> CharacterPair.t list or_undefined -> unit
  val wordPattern : t -> Regexp.t or_undefined
  val set_wordPattern : t -> Regexp.t or_undefined -> unit
  val indentationRules : t -> IndentationRule.t or_undefined
  val set_indentationRules : t -> IndentationRule.t or_undefined -> unit
  val onEnterRules : t -> OnEnterRule.t list or_undefined
  val set_onEnterRules : t -> OnEnterRule.t list or_undefined -> unit
  val autoClosingPairs : t -> AutoClosingPair.t list or_undefined
  val set_autoClosingPairs : t -> AutoClosingPair.t list or_undefined -> unit

  (** @deprecated Will be replaced by a better API soon. *)
  val __electricCharacterSupport : t -> _electric_character_support or_undefined

  (** @deprecated Will be replaced by a better API soon. *)
  val set___electricCharacterSupport
    :  t
    -> _electric_character_support or_undefined
    -> unit

  (** @deprecated
        * Use the autoClosingPairs property in the language configuration file instead. *)
  val __characterPairSupport : t -> _character_pair_support or_undefined

  (** @deprecated
        * Use the autoClosingPairs property in the language configuration file instead. *)
  val set___characterPairSupport : t -> _character_pair_support or_undefined -> unit

  val create
    :  ?comments:CommentRule.t
    -> ?brackets:CharacterPair.t list
    -> ?wordPattern:Regexp.t
    -> ?indentationRules:IndentationRule.t
    -> ?onEnterRules:OnEnterRule.t list
    -> ?autoClosingPairs:AutoClosingPair.t list
    -> ?__electricCharacterSupport:_electric_character_support
    -> ?__characterPairSupport:_character_pair_support
    -> unit
    -> t
end

module Languages : sig
  val registerDocumentFormattingEditProvider
    :  selector:DocumentSelector.t
    -> provider:DocumentFormattingEditProvider.t
    -> Disposable.t

  val registerHoverProvider
    :  selector:DocumentSelector.t
    -> provider:HoverProvider.t
    -> Disposable.t

  val getDiagnostics : Uri.t -> Diagnostic.t list
  val getDiagnostics_all : unit -> (Uri.t * Diagnostic.t list) list
  val getLanguages : unit -> string list Promise.t

  val setTextDocumentLanguage
    :  document:TextDocument.t
    -> languageId:string
    -> TextDocument.t Promise.t

  val match_ : selector:DocumentSelector.t -> document:TextDocument.t -> int
  val onDidChangeDiagnostics : unit -> DiagnosticChangeEvent.t Event.t
  val createDiagnosticCollection : ?name:string -> unit -> DiagnosticCollection.t

  val createLanguageStatusItem
    :  id:string
    -> selector:DocumentSelector.t
    -> LanguageStatusItem.t

  val registerCompletionItemProvider
    :  selector:DocumentSelector.t
    -> provider:CompletionItem.t CompletionItemProvider.t
    -> triggerCharacters:string list
    -> Disposable.t

  val registerInlineCompletionItemProvider
    :  selector:DocumentSelector.t
    -> provider:InlineCompletionItemProvider.t
    -> Disposable.t

  val registerCodeActionsProvider
    :  selector:DocumentSelector.t
    -> provider:CodeAction.t CodeActionProvider.t
    -> ?metadata:CodeActionProviderMetadata.t
    -> unit
    -> Disposable.t

  val registerCodeLensProvider
    :  selector:DocumentSelector.t
    -> provider:CodeLens.t CodeLensProvider.t
    -> Disposable.t

  val registerDefinitionProvider
    :  selector:DocumentSelector.t
    -> provider:DefinitionProvider.t
    -> Disposable.t

  val registerImplementationProvider
    :  selector:DocumentSelector.t
    -> provider:ImplementationProvider.t
    -> Disposable.t

  val registerTypeDefinitionProvider
    :  selector:DocumentSelector.t
    -> provider:TypeDefinitionProvider.t
    -> Disposable.t

  val registerDeclarationProvider
    :  selector:DocumentSelector.t
    -> provider:DeclarationProvider.t
    -> Disposable.t

  val registerEvaluatableExpressionProvider
    :  selector:DocumentSelector.t
    -> provider:EvaluatableExpressionProvider.t
    -> Disposable.t

  val registerInlineValuesProvider
    :  selector:DocumentSelector.t
    -> provider:InlineValuesProvider.t
    -> Disposable.t

  val registerDocumentHighlightProvider
    :  selector:DocumentSelector.t
    -> provider:DocumentHighlightProvider.t
    -> Disposable.t

  val registerDocumentSymbolProvider
    :  selector:DocumentSelector.t
    -> provider:DocumentSymbolProvider.t
    -> ?metaData:DocumentSymbolProviderMetadata.t
    -> unit
    -> Disposable.t

  val registerWorkspaceSymbolProvider
    :  provider:SymbolInformation.t WorkspaceSymbolProvider.t
    -> Disposable.t

  val registerReferenceProvider
    :  selector:DocumentSelector.t
    -> provider:ReferenceProvider.t
    -> Disposable.t

  val registerRenameProvider
    :  selector:DocumentSelector.t
    -> provider:RenameProvider.t
    -> Disposable.t

  val registerDocumentSemanticTokensProvider
    :  selector:DocumentSelector.t
    -> provider:DocumentSemanticTokensProvider.t
    -> legend:SemanticTokensLegend.t
    -> Disposable.t

  val registerDocumentRangeSemanticTokensProvider
    :  selector:DocumentSelector.t
    -> provider:DocumentRangeSemanticTokensProvider.t
    -> legend:SemanticTokensLegend.t
    -> Disposable.t

  val registerDocumentRangeFormattingEditProvider
    :  selector:DocumentSelector.t
    -> provider:DocumentRangeFormattingEditProvider.t
    -> Disposable.t

  val registerOnTypeFormattingEditProvider
    :  selector:DocumentSelector.t
    -> provider:OnTypeFormattingEditProvider.t
    -> firstTriggerCharacter:string
    -> moreTriggerCharacter:string list
    -> Disposable.t

  val registerSignatureHelpProvider
    :  selector:DocumentSelector.t
    -> provider:SignatureHelpProvider.t
    -> triggerCharacters:string list
    -> Disposable.t

  val registerSignatureHelpProviderWithMetadata
    :  selector:DocumentSelector.t
    -> provider:SignatureHelpProvider.t
    -> metadata:SignatureHelpProviderMetadata.t
    -> Disposable.t

  val registerDocumentLinkProvider
    :  selector:DocumentSelector.t
    -> provider:DocumentLink.t DocumentLinkProvider.t
    -> Disposable.t

  val registerColorProvider
    :  selector:DocumentSelector.t
    -> provider:DocumentColorProvider.t
    -> Disposable.t

  val registerInlayHintsProvider
    :  selector:DocumentSelector.t
    -> provider:InlayHint.t InlayHintsProvider.t
    -> Disposable.t

  val registerFoldingRangeProvider
    :  selector:DocumentSelector.t
    -> provider:FoldingRangeProvider.t
    -> Disposable.t

  val registerSelectionRangeProvider
    :  selector:DocumentSelector.t
    -> provider:SelectionRangeProvider.t
    -> Disposable.t

  val registerCallHierarchyProvider
    :  selector:DocumentSelector.t
    -> provider:CallHierarchyProvider.t
    -> Disposable.t

  val registerTypeHierarchyProvider
    :  selector:DocumentSelector.t
    -> provider:TypeHierarchyProvider.t
    -> Disposable.t

  val registerLinkedEditingRangeProvider
    :  selector:DocumentSelector.t
    -> provider:LinkedEditingRangeProvider.t
    -> Disposable.t

  val registerDocumentDropEditProvider
    :  selector:DocumentSelector.t
    -> provider:DocumentDropEdit.t DocumentDropEditProvider.t
    -> ?metadata:DocumentDropEditProviderMetadata.t
    -> unit
    -> Disposable.t

  val registerDocumentPasteEditProvider
    :  selector:DocumentSelector.t
    -> provider:DocumentPasteEdit.t DocumentPasteEditProvider.t
    -> metadata:DocumentPasteProviderMetadata.t
    -> Disposable.t

  val setLanguageConfiguration
    :  language:string
    -> configuration:LanguageConfiguration.t
    -> Disposable.t
end

module TaskFilter : sig
  include Ojs.T

  val version : t -> string or_undefined
  val set_version : t -> string or_undefined -> unit
  val type_ : t -> string or_undefined
  val set_type_ : t -> string or_undefined -> unit
  val create : ?version:string -> ?type_:string -> unit -> t
end

module TaskExecution : sig
  include Ojs.T

  val task : t -> Task.t
  val set_task : t -> Task.t -> unit
  val terminate : t -> unit
  val create : task:Task.t -> terminate:(unit -> unit) -> unit -> t
end

module TaskStartEvent : sig
  include Ojs.T

  val execution : t -> TaskExecution.t
  val create : execution:TaskExecution.t -> unit -> t
end

module TaskEndEvent : sig
  include Ojs.T

  val execution : t -> TaskExecution.t
  val create : execution:TaskExecution.t -> unit -> t
end

module TaskProcessStartEvent : sig
  include Ojs.T

  val execution : t -> TaskExecution.t
  val processId : t -> int
  val create : execution:TaskExecution.t -> processId:int -> unit -> t
end

module TaskProcessEndEvent : sig
  include Ojs.T

  val execution : t -> TaskExecution.t
  val exitCode : t -> int or_undefined
  val create : execution:TaskExecution.t -> exitCode:int or_undefined -> unit -> t
end

module Tasks : sig
  val registerTaskProvider
    :  type_:string
    -> provider:Task.t TaskProvider.t
    -> Disposable.t

  val registerTaskProviderTyped
    :  type_:string
    -> provider:Task.t TaskProvider.t
    -> Disposable.t

  val fetchTasks : ?filter:TaskFilter.t -> unit -> Task.t list Promise.t
  val executeTask : task:Task.t -> TaskExecution.t Promise.t
  val taskExecutions : unit -> TaskExecution.t list
  val onDidStartTask : unit -> TaskStartEvent.t Event.t
  val onDidEndTask : unit -> TaskEndEvent.t Event.t
  val onDidStartTaskProcess : unit -> TaskProcessStartEvent.t Event.t
  val onDidEndTaskProcess : unit -> TaskProcessEndEvent.t Event.t
end

module TelemetryLogger : sig
  include Ojs.T

  val onDidChangeEnableStates : t -> t Event.t
  val isUsageEnabled : t -> bool
  val isErrorsEnabled : t -> bool
  val logUsage : t -> eventName:string -> ?data:Ojs.t Dict.t -> unit -> unit
  val logError : t -> eventName:string -> ?data:Ojs.t Dict.t -> unit -> unit
  val logException : t -> error:JsError.t -> ?data:Ojs.t Dict.t -> unit -> unit
  val dispose : t -> unit
end

module TelemetrySender : sig
  include Ojs.T

  type flush_result =
    [ `Unit of unit
    | `Promise of unit Promise.t
    ]

  val flush_result_to_js : flush_result -> Ojs.t
  val flush_result_of_js : Ojs.t -> flush_result
  val sendEventData : t -> eventName:string -> ?data:Ojs.t Dict.t -> unit -> unit
  val sendErrorData : t -> error:JsError.t -> ?data:Ojs.t Dict.t -> unit -> unit
  val flush : t -> (unit -> flush_result) or_undefined

  val create
    :  sendEventData:(eventName:string -> ?data:Ojs.t Dict.t -> unit -> unit)
    -> sendErrorData:(error:JsError.t -> ?data:Ojs.t Dict.t -> unit -> unit)
    -> ?flush:(unit -> flush_result)
    -> unit
    -> t
end

module TelemetryLoggerOptions : sig
  include Ojs.T

  val ignoreBuiltInCommonProperties : t -> bool or_undefined
  val ignoreUnhandledErrors : t -> bool or_undefined
  val additionalCommonProperties : t -> Ojs.t Dict.t or_undefined

  val create
    :  ?ignoreBuiltInCommonProperties:bool
    -> ?ignoreUnhandledErrors:bool
    -> ?additionalCommonProperties:Ojs.t Dict.t
    -> unit
    -> t
end

module UIKind : sig
  type t =
    | Desktop
    | Web

  include Ojs.T with type t := t
end

module Env : sig
  val isAppPortable : unit -> bool
  val shell : unit -> string
  val clipboard : unit -> Clipboard.t
  val appName : unit -> string
  val appRoot : unit -> string
  val appHost : unit -> string
  val uriScheme : unit -> string
  val language : unit -> string
  val machineId : unit -> string
  val sessionId : unit -> string
  val isNewAppInstall : unit -> bool
  val isTelemetryEnabled : unit -> bool
  val onDidChangeTelemetryEnabled : unit -> bool Event.t
  val onDidChangeShell : unit -> string Event.t

  val createTelemetryLogger
    :  sender:TelemetrySender.t
    -> ?options:TelemetryLoggerOptions.t
    -> unit
    -> TelemetryLogger.t

  val remoteName : unit -> string or_undefined
  val uiKind : unit -> UIKind.t
  val openExternal : target:Uri.t -> bool Promise.t
  val asExternalUri : target:Uri.t -> Uri.t Promise.t
  val logLevel : unit -> LogLevel.t
  val onDidChangeLogLevel : unit -> LogLevel.t Event.t
end

module DebugAdapterExecutableOptions : sig
  include Ojs.T

  val cwd : t -> string or_undefined
  val env : t -> string Dict.t or_undefined
  val set_env : t -> string Dict.t or_undefined -> unit
  val set_cwd : t -> string or_undefined -> unit
  val create : ?env:string Dict.t -> ?cwd:string -> unit -> t
end

module DebugAdapterExecutable : sig
  include Ojs.T

  val make
    :  command:string
    -> ?args:string list
    -> ?options:DebugAdapterExecutableOptions.t
    -> unit
    -> t

  val command : t -> string
  val args : t -> string list
  val options : t -> DebugAdapterExecutableOptions.t or_undefined
end

module DebugAdapterServer : sig
  include Ojs.T

  val port : t -> int
  val host : t -> string or_undefined
  val make : port:int -> ?host:string -> unit -> t
end

module DebugAdapterNamedPipeServer : sig
  include Ojs.T

  val path : t -> string
  val make : path:string -> t
end

module DebugProtocolMessage : sig
  include Ojs.T
end

module DebugAdapter : sig
  include Ojs.T with type t = private Disposable.t

  type from_disposable_likes_item = { dispose : unit -> Ojs.t }

  val from_disposable_likes_item_to_js : from_disposable_likes_item -> Ojs.t
  val from_disposable_likes_item_of_js : Ojs.t -> from_disposable_likes_item
  val to_disposable : t -> Disposable.t
  val from : disposableLikes:from_disposable_likes_item list -> Disposable.t
  val dispose : t -> Ojs.t
  val onDidSendMessage : t -> DebugProtocolMessage.t Event.t
  val handleMessage : t -> message:DebugProtocolMessage.t -> unit

  val create
    :  from:Disposable.t
    -> dispose:Ojs.t
    -> onDidSendMessage:DebugProtocolMessage.t Event.t
    -> handleMessage:(message:DebugProtocolMessage.t -> unit)
    -> unit
    -> t
end

module DebugAdapterInlineImplementation : sig
  include Ojs.T

  val make : implementation:DebugAdapter.t -> t
end

module DebugAdapterDescriptor : sig
  type t =
    [ `Executable of DebugAdapterExecutable.t
    | `Server of DebugAdapterServer.t
    | `NamedPipeServer of DebugAdapterNamedPipeServer.t
    | `InlineImplementation of DebugAdapterInlineImplementation.t
    ]

  include Ojs.T with type t := t
end

module DebugConfiguration : sig
  include Ojs.T

  val create : name:string -> request:string -> type_:string -> t
  val set : t -> string -> Ojs.t -> unit
  val type_ : t -> string
  val set_type_ : t -> string -> unit
  val name : t -> string
  val set_name : t -> string -> unit
  val request : t -> string
  val set_request : t -> string -> unit
  val getProperty : t -> key:string -> Ojs.t or_undefined
  val setProperty : t -> key:string -> value:Ojs.t -> unit
end

module Breakpoint : sig
  include Ojs.T

  val id : t -> string
  val enabled : t -> bool
  val condition : t -> string or_undefined
  val hitCondition : t -> string or_undefined
  val logMessage : t -> string or_undefined
end

module DebugProtocolBreakpoint : sig
  include Ojs.T
end

module DebugSession : sig
  include Ojs.T

  val customRequest : t -> command:string -> ?args:Ojs.t -> unit -> Ojs.t Promise.t
  val id : t -> string
  val type_ : t -> string
  val parentSession : t -> t or_undefined
  val name : t -> string
  val set_name : t -> string -> unit
  val workspaceFolder : t -> WorkspaceFolder.t or_undefined
  val configuration : t -> DebugConfiguration.t

  val getDebugProtocolBreakpoint
    :  t
    -> breakpoint:Breakpoint.t
    -> DebugProtocolBreakpoint.t or_undefined Promise.t

  val create
    :  id:string
    -> type_:string
    -> ?parentSession:t
    -> name:string
    -> workspaceFolder:WorkspaceFolder.t or_undefined
    -> configuration:DebugConfiguration.t
    -> customRequest:(command:string -> ?args:Ojs.t -> unit -> Ojs.t Promise.t)
    -> getDebugProtocolBreakpoint:
         (breakpoint:Breakpoint.t -> DebugProtocolBreakpoint.t or_undefined Promise.t)
    -> unit
    -> t
end

module DebugThread : sig
  include Ojs.T

  val session : t -> DebugSession.t
  val threadId : t -> int
end

module DebugStackFrame : sig
  include Ojs.T

  val session : t -> DebugSession.t
  val threadId : t -> int
  val frameId : t -> int
end

module DebugAdapterDescriptorFactory : sig
  include Ojs.T

  val createDebugAdapterDescriptor
    :  t
    -> session:DebugSession.t
    -> executable:DebugAdapterExecutable.t or_undefined
    -> DebugAdapterDescriptor.t ProviderResult.t

  val create
    :  createDebugAdapterDescriptor:
         (session:DebugSession.t
          -> executable:DebugAdapterExecutable.t or_undefined
          -> DebugAdapterDescriptor.t ProviderResult.t)
    -> unit
    -> t
end

module DebugConfigurationProvider : sig
  include Ojs.T

  val provideDebugConfigurations
    :  t
    -> (folder:WorkspaceFolder.t or_undefined
        -> ?token:CancellationToken.t
        -> unit
        -> DebugConfiguration.t list ProviderResult.t)
         or_undefined

  val resolveDebugConfiguration
    :  t
    -> (folder:WorkspaceFolder.t or_undefined
        -> debugConfiguration:DebugConfiguration.t
        -> ?token:CancellationToken.t
        -> unit
        -> DebugConfiguration.t ProviderResult.t)
         or_undefined

  val resolveDebugConfigurationWithSubstitutedVariables
    :  t
    -> (folder:WorkspaceFolder.t or_undefined
        -> debugConfiguration:DebugConfiguration.t
        -> ?token:CancellationToken.t
        -> unit
        -> DebugConfiguration.t ProviderResult.t)
         or_undefined

  val create
    :  ?provideDebugConfigurations:
         (folder:WorkspaceFolder.t or_undefined
          -> ?token:CancellationToken.t
          -> unit
          -> DebugConfiguration.t list ProviderResult.t)
    -> ?resolveDebugConfiguration:
         (folder:WorkspaceFolder.t or_undefined
          -> debugConfiguration:DebugConfiguration.t
          -> ?token:CancellationToken.t
          -> unit
          -> DebugConfiguration.t ProviderResult.t)
    -> ?resolveDebugConfigurationWithSubstitutedVariables:
         (folder:WorkspaceFolder.t or_undefined
          -> debugConfiguration:DebugConfiguration.t
          -> ?token:CancellationToken.t
          -> unit
          -> DebugConfiguration.t ProviderResult.t)
    -> unit
    -> t
end

module DebugConfigurationProviderTriggerKind : sig
  type t =
    | Initial
    | Dynamic

  include Ojs.T with type t := t
end

module DebugConsoleMode : sig
  type t =
    | Separate
    | MergeWithParent

  include Ojs.T with type t := t
end

module TestMessageStackFrame : sig
  include Ojs.T

  val uri : t -> Uri.t or_undefined
  val set_uri : t -> Uri.t or_undefined -> unit
  val position : t -> Position.t or_undefined
  val set_position : t -> Position.t or_undefined -> unit
  val label : t -> string
  val set_label : t -> string -> unit
  val make : label:string -> ?uri:Uri.t -> ?position:Position.t -> unit -> t
end

module TestMessage : sig
  include Ojs.T

  type message =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val message_to_js : message -> Ojs.t
  val message_of_js : Ojs.t -> message
  val message : t -> message
  val set_message : t -> message -> unit
  val expectedOutput : t -> string or_undefined
  val set_expectedOutput : t -> string or_undefined -> unit
  val actualOutput : t -> string or_undefined
  val set_actualOutput : t -> string or_undefined -> unit
  val location : t -> Location.t or_undefined
  val set_location : t -> Location.t or_undefined -> unit
  val contextValue : t -> string or_undefined
  val set_contextValue : t -> string or_undefined -> unit
  val stackTrace : t -> TestMessageStackFrame.t list or_undefined
  val set_stackTrace : t -> TestMessageStackFrame.t list or_undefined -> unit
  val diff : message:message -> expected:string -> actual:string -> t
  val make : message:message -> t
end

module TestTag : sig
  include Ojs.T

  val id : t -> string
  val make : id:string -> t
end

module rec TestItem : sig
  include Ojs.T

  type error =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val error_to_js : error -> Ojs.t
  val error_of_js : Ojs.t -> error
  val id : t -> string
  val uri : t -> Uri.t or_undefined
  val children : t -> TestItemCollection.t
  val parent : t -> t or_undefined
  val tags : t -> TestTag.t list
  val set_tags : t -> TestTag.t list -> unit
  val canResolveChildren : t -> bool
  val set_canResolveChildren : t -> bool -> unit
  val busy : t -> bool
  val set_busy : t -> bool -> unit
  val label : t -> string
  val set_label : t -> string -> unit
  val description : t -> string or_undefined
  val set_description : t -> string or_undefined -> unit
  val sortText : t -> string or_undefined
  val set_sortText : t -> string or_undefined -> unit
  val range : t -> Range.t or_undefined
  val set_range : t -> Range.t or_undefined -> unit
  val error : t -> error or_undefined
  val set_error : t -> error or_undefined -> unit
end

and TestItemCollection : sig
  include Ojs.T

  val size : t -> int
  val replace : t -> items:TestItem.t list -> unit

  val forEach
    :  t
    -> callback:(item:TestItem.t -> collection:t -> Ojs.t)
    -> ?thisArg:Ojs.t
    -> unit
    -> unit

  val add : t -> item:TestItem.t -> unit
  val delete : t -> itemId:string -> unit
  val get : t -> itemId:string -> TestItem.t or_undefined
  val iterator : t -> (string * TestItem.t) IterableIterator.t
end

module TestCoverageCount : sig
  include Ojs.T

  val covered : t -> int
  val set_covered : t -> int -> unit
  val total : t -> int
  val set_total : t -> int -> unit
  val make : covered:int -> total:int -> t
end

module BranchCoverage : sig
  include Ojs.T

  type executed =
    [ `Int of int
    | `Bool of bool
    ]

  val executed_to_js : executed -> Ojs.t
  val executed_of_js : Ojs.t -> executed

  type location =
    [ `Position of Position.t
    | `Range of Range.t
    ]

  val location_to_js : location -> Ojs.t
  val location_of_js : Ojs.t -> location
  val executed : t -> executed
  val set_executed : t -> executed -> unit
  val location : t -> location or_undefined
  val set_location : t -> location or_undefined -> unit
  val label : t -> string or_undefined
  val set_label : t -> string or_undefined -> unit
  val make : executed:executed -> ?location:location -> ?label:string -> unit -> t
end

module StatementCoverage : sig
  include Ojs.T

  type executed =
    [ `Int of int
    | `Bool of bool
    ]

  val executed_to_js : executed -> Ojs.t
  val executed_of_js : Ojs.t -> executed

  type location =
    [ `Position of Position.t
    | `Range of Range.t
    ]

  val location_to_js : location -> Ojs.t
  val location_of_js : Ojs.t -> location
  val executed : t -> executed
  val set_executed : t -> executed -> unit
  val location : t -> location
  val set_location : t -> location -> unit
  val branches : t -> BranchCoverage.t list
  val set_branches : t -> BranchCoverage.t list -> unit

  val make
    :  executed:executed
    -> location:location
    -> ?branches:BranchCoverage.t list
    -> unit
    -> t
end

module DeclarationCoverage : sig
  include Ojs.T

  type executed =
    [ `Int of int
    | `Bool of bool
    ]

  val executed_to_js : executed -> Ojs.t
  val executed_of_js : Ojs.t -> executed

  type location =
    [ `Position of Position.t
    | `Range of Range.t
    ]

  val location_to_js : location -> Ojs.t
  val location_of_js : Ojs.t -> location
  val name : t -> string
  val set_name : t -> string -> unit
  val executed : t -> executed
  val set_executed : t -> executed -> unit
  val location : t -> location
  val set_location : t -> location -> unit
  val make : name:string -> executed:executed -> location:location -> t
end

module FileCoverageDetail : sig
  type value =
    [ `StatementCoverage of StatementCoverage.t
    | `DeclarationCoverage of DeclarationCoverage.t
    ]

  val value_to_js : value -> Ojs.t
  val value_of_js : Ojs.t -> value

  type t = value

  include Ojs.T with type t := t
end

module FileCoverage : sig
  include Ojs.T

  val uri : t -> Uri.t
  val statementCoverage : t -> TestCoverageCount.t
  val set_statementCoverage : t -> TestCoverageCount.t -> unit
  val branchCoverage : t -> TestCoverageCount.t or_undefined
  val set_branchCoverage : t -> TestCoverageCount.t or_undefined -> unit
  val declarationCoverage : t -> TestCoverageCount.t or_undefined
  val set_declarationCoverage : t -> TestCoverageCount.t or_undefined -> unit
  val includesTests : t -> TestItem.t list or_undefined
  val set_includesTests : t -> TestItem.t list or_undefined -> unit
  val fromDetails : uri:Uri.t -> details:FileCoverageDetail.t list -> t

  val make
    :  uri:Uri.t
    -> statementCoverage:TestCoverageCount.t
    -> ?branchCoverage:TestCoverageCount.t
    -> ?declarationCoverage:TestCoverageCount.t
    -> ?includesTests:TestItem.t list
    -> unit
    -> t
end

module TestRun : sig
  include Ojs.T

  type failed_message =
    [ `TestMessage of TestMessage.t
    | `Items of TestMessage.t list
    ]

  val failed_message_to_js : failed_message -> Ojs.t
  val failed_message_of_js : Ojs.t -> failed_message
  val name : t -> string or_undefined
  val token : t -> CancellationToken.t
  val isPersisted : t -> bool
  val enqueued : t -> test:TestItem.t -> unit
  val started : t -> test:TestItem.t -> unit
  val skipped : t -> test:TestItem.t -> unit

  val failed
    :  t
    -> test:TestItem.t
    -> message:failed_message
    -> ?duration:float
    -> unit
    -> unit

  val errored
    :  t
    -> test:TestItem.t
    -> message:failed_message
    -> ?duration:float
    -> unit
    -> unit

  val passed : t -> test:TestItem.t -> ?duration:float -> unit -> unit

  val appendOutput
    :  t
    -> output:string
    -> ?location:Location.t
    -> ?test:TestItem.t
    -> unit
    -> unit

  val addCoverage : t -> fileCoverage:FileCoverage.t -> unit
  val end_ : t -> unit
  val onDidDispose : t -> unit Event.t
end

module DebugSessionOptions : sig
  include Ojs.T

  val parentSession : t -> DebugSession.t or_undefined
  val set_parentSession : t -> DebugSession.t or_undefined -> unit
  val lifecycleManagedByParent : t -> bool or_undefined
  val set_lifecycleManagedByParent : t -> bool or_undefined -> unit
  val consoleMode : t -> DebugConsoleMode.t or_undefined
  val set_consoleMode : t -> DebugConsoleMode.t or_undefined -> unit
  val noDebug : t -> bool or_undefined
  val set_noDebug : t -> bool or_undefined -> unit
  val compact : t -> bool or_undefined
  val set_compact : t -> bool or_undefined -> unit
  val suppressSaveBeforeStart : t -> bool or_undefined
  val set_suppressSaveBeforeStart : t -> bool or_undefined -> unit
  val suppressDebugToolbar : t -> bool or_undefined
  val set_suppressDebugToolbar : t -> bool or_undefined -> unit
  val suppressDebugStatusbar : t -> bool or_undefined
  val set_suppressDebugStatusbar : t -> bool or_undefined -> unit
  val suppressDebugView : t -> bool or_undefined
  val set_suppressDebugView : t -> bool or_undefined -> unit
  val testRun : t -> TestRun.t or_undefined
  val set_testRun : t -> TestRun.t or_undefined -> unit

  val create
    :  ?parentSession:DebugSession.t
    -> ?lifecycleManagedByParent:bool
    -> ?consoleMode:DebugConsoleMode.t
    -> ?noDebug:bool
    -> ?compact:bool
    -> ?suppressSaveBeforeStart:bool
    -> ?suppressDebugToolbar:bool
    -> ?suppressDebugStatusbar:bool
    -> ?suppressDebugView:bool
    -> ?testRun:TestRun.t
    -> unit
    -> t
end

module DebugConsole : sig
  include Ojs.T

  val append : t -> value:string -> unit
  val appendLine : t -> value:string -> unit

  val create
    :  append:(value:string -> unit)
    -> appendLine:(value:string -> unit)
    -> unit
    -> t
end

module DebugSessionCustomEvent : sig
  include Ojs.T

  val session : t -> DebugSession.t
  val event : t -> string
  val body : t -> Ojs.t
  val create : session:DebugSession.t -> event:string -> body:Ojs.t -> unit -> t
end

module BreakpointsChangeEvent : sig
  include Ojs.T

  val added : t -> Breakpoint.t list
  val removed : t -> Breakpoint.t list
  val changed : t -> Breakpoint.t list

  val create
    :  added:Breakpoint.t list
    -> removed:Breakpoint.t list
    -> changed:Breakpoint.t list
    -> unit
    -> t
end

module DebugAdapterTracker : sig
  include Ojs.T

  val onWillStartSession : t -> (unit -> unit) or_undefined
  val onWillReceiveMessage : t -> (message:Ojs.t -> unit) or_undefined
  val onDidSendMessage : t -> (message:Ojs.t -> unit) or_undefined
  val onWillStopSession : t -> (unit -> unit) or_undefined
  val onError : t -> (error:JsError.t -> unit) or_undefined

  val onExit
    :  t
    -> (code:int or_undefined -> signal:string or_undefined -> unit) or_undefined

  val create
    :  ?onWillStartSession:(unit -> unit)
    -> ?onWillReceiveMessage:(message:Ojs.t -> unit)
    -> ?onDidSendMessage:(message:Ojs.t -> unit)
    -> ?onWillStopSession:(unit -> unit)
    -> ?onError:(error:JsError.t -> unit)
    -> ?onExit:(code:int or_undefined -> signal:string or_undefined -> unit)
    -> unit
    -> t
end

module DebugAdapterTrackerFactory : sig
  include Ojs.T

  val createDebugAdapterTracker
    :  t
    -> session:DebugSession.t
    -> DebugAdapterTracker.t ProviderResult.t

  val create
    :  createDebugAdapterTracker:
         (session:DebugSession.t -> DebugAdapterTracker.t ProviderResult.t)
    -> unit
    -> t
end

module DebugProtocolSource : sig
  include Ojs.T
end

module Debug : sig
  type active_stack_item =
    [ `DebugThread of DebugThread.t
    | `DebugStackFrame of DebugStackFrame.t
    ]

  val active_stack_item_to_js : active_stack_item -> Ojs.t
  val active_stack_item_of_js : Ojs.t -> active_stack_item

  type start_debugging_with_options_name_or_configuration =
    [ `String of string
    | `DebugConfiguration of DebugConfiguration.t
    ]

  val start_debugging_with_options_name_or_configuration_to_js
    :  start_debugging_with_options_name_or_configuration
    -> Ojs.t

  val start_debugging_with_options_name_or_configuration_of_js
    :  Ojs.t
    -> start_debugging_with_options_name_or_configuration

  type start_debugging_with_options_parent_session_or_options =
    [ `DebugSession of DebugSession.t
    | `DebugSessionOptions of DebugSessionOptions.t
    ]

  val start_debugging_with_options_parent_session_or_options_to_js
    :  start_debugging_with_options_parent_session_or_options
    -> Ojs.t

  val start_debugging_with_options_parent_session_or_options_of_js
    :  Ojs.t
    -> start_debugging_with_options_parent_session_or_options

  type stackItem =
    [ `Thread of DebugThread.t
    | `StackFrame of DebugStackFrame.t
    ]

  val activeStackItem : unit -> active_stack_item or_undefined
  val onDidChangeActiveStackItem : unit -> active_stack_item or_undefined Event.t
  val activeDebugSession : unit -> DebugSession.t or_undefined

  val registerDebugAdapterDescriptorFactory
    :  debugType:string
    -> factory:DebugAdapterDescriptorFactory.t
    -> Disposable.t

  val registerDebugConfigurationProvider
    :  debugType:string
    -> provider:DebugConfigurationProvider.t
    -> ?triggerKind:DebugConfigurationProviderTriggerKind.t
    -> unit
    -> Disposable.t

  val startDebugging
    :  folder:WorkspaceFolder.t or_undefined
    -> nameOrConfiguration:[ `Name of string | `Configuration of DebugConfiguration.t ]
    -> ?parentSessionOrOptions:Ojs.t
    -> unit
    -> bool Promise.t

  val activeDebugConsole : unit -> DebugConsole.t
  val breakpoints : unit -> Breakpoint.t list
  val onDidChangeActiveDebugSession : unit -> DebugSession.t or_undefined Event.t
  val onDidStartDebugSession : unit -> DebugSession.t Event.t
  val onDidReceiveDebugSessionCustomEvent : unit -> DebugSessionCustomEvent.t Event.t
  val onDidTerminateDebugSession : unit -> DebugSession.t Event.t
  val onDidChangeBreakpoints : unit -> BreakpointsChangeEvent.t Event.t

  val registerDebugAdapterTrackerFactory
    :  debugType:string
    -> factory:DebugAdapterTrackerFactory.t
    -> Disposable.t

  val startDebuggingWithOptions
    :  folder:WorkspaceFolder.t or_undefined
    -> nameOrConfiguration:start_debugging_with_options_name_or_configuration
    -> ?parentSessionOrOptions:start_debugging_with_options_parent_session_or_options
    -> unit
    -> bool Promise.t

  val stopDebugging : ?session:DebugSession.t -> unit -> unit Promise.t
  val addBreakpoints : breakpoints:Breakpoint.t list -> unit
  val removeBreakpoints : breakpoints:Breakpoint.t list -> unit

  val asDebugSourceUri
    :  source:DebugProtocolSource.t
    -> ?session:DebugSession.t
    -> unit
    -> Uri.t
end

module CancellationTokenSource : sig
  include Ojs.T

  val token : t -> CancellationToken.t
  val set_token : t -> CancellationToken.t -> unit
  val cancel : t -> unit
  val dispose : t -> unit
  val make : unit -> t
end

module CancellationError : sig
  include Ojs.T with type t = private JsError.t

  val to_js_error : t -> JsError.t
  val name : t -> string
  val set_name : t -> string -> unit
  val message : t -> string
  val set_message : t -> string -> unit
  val stack : t -> string or_undefined
  val set_stack : t -> string or_undefined -> unit
  val cause : t -> Ojs.t or_undefined
  val set_cause : t -> Ojs.t or_undefined -> unit
  val make : unit -> t
end

module SemanticTokensBuilder : sig
  include Ojs.T

  val make : ?legend:SemanticTokensLegend.t -> unit -> t

  val push
    :  t
    -> line:int
    -> char:int
    -> length:int
    -> tokenType:int
    -> ?tokenModifiers:int
    -> unit
    -> unit

  val pushRange
    :  t
    -> range:Range.t
    -> tokenType:string
    -> ?tokenModifiers:string list
    -> unit
    -> unit

  val build : t -> ?resultId:string -> unit -> SemanticTokens.t
end

module FileSystemError : sig
  include Ojs.T with type t = private JsError.t

  type file_not_found_message_or_uri =
    [ `String of string
    | `Uri of Uri.t
    ]

  val file_not_found_message_or_uri_to_js : file_not_found_message_or_uri -> Ojs.t
  val file_not_found_message_or_uri_of_js : Ojs.t -> file_not_found_message_or_uri
  val to_js_error : t -> JsError.t
  val name : t -> string
  val set_name : t -> string -> unit
  val message : t -> string
  val set_message : t -> string -> unit
  val stack : t -> string or_undefined
  val set_stack : t -> string or_undefined -> unit
  val cause : t -> Ojs.t or_undefined
  val set_cause : t -> Ojs.t or_undefined -> unit
  val fileNotFound : ?messageOrUri:file_not_found_message_or_uri -> unit -> t
  val fileExists : ?messageOrUri:file_not_found_message_or_uri -> unit -> t
  val fileNotADirectory : ?messageOrUri:file_not_found_message_or_uri -> unit -> t
  val fileIsADirectory : ?messageOrUri:file_not_found_message_or_uri -> unit -> t
  val noPermissions : ?messageOrUri:file_not_found_message_or_uri -> unit -> t
  val unavailable : ?messageOrUri:file_not_found_message_or_uri -> unit -> t
  val make : ?messageOrUri:file_not_found_message_or_uri -> unit -> t
  val code : t -> string
end

module NotebookRendererMessaging : sig
  include Ojs.T

  type on_did_receive_message_t =
    { editor : NotebookEditor.t
    ; message : Ojs.t
    }

  val on_did_receive_message_t_to_js : on_did_receive_message_t -> Ojs.t
  val on_did_receive_message_t_of_js : Ojs.t -> on_did_receive_message_t
  val onDidReceiveMessage : t -> on_did_receive_message_t Event.t

  val postMessage
    :  t
    -> message:Ojs.t
    -> ?editor:NotebookEditor.t
    -> unit
    -> bool Promise.t

  val create
    :  onDidReceiveMessage:on_did_receive_message_t Event.t
    -> postMessage:(message:Ojs.t -> ?editor:NotebookEditor.t -> unit -> bool Promise.t)
    -> unit
    -> t
end

module NotebookControllerAffinity : sig
  type t =
    | Default
    | Preferred

  include Ojs.T with type t := t
end

module NotebookCellExecution : sig
  include Ojs.T

  type replace_output_out =
    [ `NotebookCellOutput of NotebookCellOutput.t
    | `Items of NotebookCellOutput.t list
    ]

  val replace_output_out_to_js : replace_output_out -> Ojs.t
  val replace_output_out_of_js : Ojs.t -> replace_output_out

  type replace_output_items =
    [ `NotebookCellOutputItem of NotebookCellOutputItem.t
    | `Items of NotebookCellOutputItem.t list
    ]

  val replace_output_items_to_js : replace_output_items -> Ojs.t
  val replace_output_items_of_js : Ojs.t -> replace_output_items
  val cell : t -> NotebookCell.t
  val token : t -> CancellationToken.t
  val executionOrder : t -> int or_undefined
  val set_executionOrder : t -> int or_undefined -> unit
  val start : t -> ?startTime:float -> unit -> unit
  val end_ : t -> success:bool or_undefined -> ?endTime:float -> unit -> unit
  val clearOutput : t -> ?cell:NotebookCell.t -> unit -> unit Promise.t

  val replaceOutput
    :  t
    -> out:replace_output_out
    -> ?cell:NotebookCell.t
    -> unit
    -> unit Promise.t

  val appendOutput
    :  t
    -> out:replace_output_out
    -> ?cell:NotebookCell.t
    -> unit
    -> unit Promise.t

  val replaceOutputItems
    :  t
    -> items:replace_output_items
    -> output:NotebookCellOutput.t
    -> unit Promise.t

  val appendOutputItems
    :  t
    -> items:replace_output_items
    -> output:NotebookCellOutput.t
    -> unit Promise.t
end

module NotebookController : sig
  include Ojs.T

  type execute_handler_result =
    [ `Unit of unit
    | `Promise of unit Promise.t
    ]

  val execute_handler_result_to_js : execute_handler_result -> Ojs.t
  val execute_handler_result_of_js : Ojs.t -> execute_handler_result

  type on_did_change_selected_notebooks_t =
    { notebook : NotebookDocument.t
    ; selected : bool
    }

  val on_did_change_selected_notebooks_t_to_js
    :  on_did_change_selected_notebooks_t
    -> Ojs.t

  val on_did_change_selected_notebooks_t_of_js
    :  Ojs.t
    -> on_did_change_selected_notebooks_t

  val id : t -> string
  val notebookType : t -> string
  val supportedLanguages : t -> string list or_undefined
  val set_supportedLanguages : t -> string list or_undefined -> unit
  val label : t -> string
  val set_label : t -> string -> unit
  val description : t -> string or_undefined
  val set_description : t -> string or_undefined -> unit
  val detail : t -> string or_undefined
  val set_detail : t -> string or_undefined -> unit
  val supportsExecutionOrder : t -> bool or_undefined
  val set_supportsExecutionOrder : t -> bool or_undefined -> unit
  val createNotebookCellExecution : t -> cell:NotebookCell.t -> NotebookCellExecution.t

  val executeHandler
    :  t
    -> cells:NotebookCell.t list
    -> notebook:NotebookDocument.t
    -> controller:t
    -> execute_handler_result

  val set_executeHandler
    :  t
    -> (cells:NotebookCell.t list
        -> notebook:NotebookDocument.t
        -> controller:t
        -> execute_handler_result)
    -> unit

  val interruptHandler
    :  t
    -> (notebook:NotebookDocument.t -> execute_handler_result) or_undefined

  val set_interruptHandler
    :  t
    -> (notebook:NotebookDocument.t -> execute_handler_result) or_undefined
    -> unit

  val onDidChangeSelectedNotebooks : t -> on_did_change_selected_notebooks_t Event.t

  val updateNotebookAffinity
    :  t
    -> notebook:NotebookDocument.t
    -> affinity:NotebookControllerAffinity.t
    -> unit

  val dispose : t -> unit
end

module NotebookCellStatusBarAlignment : sig
  type t =
    | Left
    | Right

  include Ojs.T with type t := t
end

module NotebookCellStatusBarItem : sig
  include Ojs.T

  type command =
    [ `String of string
    | `Command of Command.t
    ]

  val command_to_js : command -> Ojs.t
  val command_of_js : Ojs.t -> command
  val text : t -> string
  val set_text : t -> string -> unit
  val alignment : t -> NotebookCellStatusBarAlignment.t
  val set_alignment : t -> NotebookCellStatusBarAlignment.t -> unit
  val command : t -> command or_undefined
  val set_command : t -> command or_undefined -> unit
  val tooltip : t -> string or_undefined
  val set_tooltip : t -> string or_undefined -> unit
  val priority : t -> float or_undefined
  val set_priority : t -> float or_undefined -> unit
  val accessibilityInformation : t -> AccessibilityInformation.t or_undefined
  val set_accessibilityInformation : t -> AccessibilityInformation.t or_undefined -> unit
  val make : text:string -> alignment:NotebookCellStatusBarAlignment.t -> t
end

module NotebookCellStatusBarItemProvider : sig
  include Ojs.T

  type provide_cell_status_bar_items_result_t =
    [ `NotebookCellStatusBarItem of NotebookCellStatusBarItem.t
    | `Items of NotebookCellStatusBarItem.t list
    ]

  val provide_cell_status_bar_items_result_t_to_js
    :  provide_cell_status_bar_items_result_t
    -> Ojs.t

  val provide_cell_status_bar_items_result_t_of_js
    :  Ojs.t
    -> provide_cell_status_bar_items_result_t

  val onDidChangeCellStatusBarItems : t -> unit Event.t or_undefined
  val set_onDidChangeCellStatusBarItems : t -> unit Event.t or_undefined -> unit

  val provideCellStatusBarItems
    :  t
    -> cell:NotebookCell.t
    -> token:CancellationToken.t
    -> provide_cell_status_bar_items_result_t ProviderResult.t

  val create
    :  ?onDidChangeCellStatusBarItems:unit Event.t
    -> provideCellStatusBarItems:
         (cell:NotebookCell.t
          -> token:CancellationToken.t
          -> provide_cell_status_bar_items_result_t ProviderResult.t)
    -> unit
    -> t
end

module Notebooks : sig
  type create_notebook_controller_handler_result =
    [ `Unit of unit
    | `Promise of unit Promise.t
    ]

  val create_notebook_controller_handler_result_to_js
    :  create_notebook_controller_handler_result
    -> Ojs.t

  val create_notebook_controller_handler_result_of_js
    :  Ojs.t
    -> create_notebook_controller_handler_result

  val createNotebookController
    :  id:string
    -> notebookType:string
    -> label:string
    -> ?handler:
         (cells:NotebookCell.t list
          -> notebook:NotebookDocument.t
          -> controller:NotebookController.t
          -> create_notebook_controller_handler_result)
    -> unit
    -> NotebookController.t

  val registerNotebookCellStatusBarItemProvider
    :  notebookType:string
    -> provider:NotebookCellStatusBarItemProvider.t
    -> Disposable.t

  val createRendererMessaging : rendererId:string -> NotebookRendererMessaging.t
end

module SourceControlInputBox : sig
  include Ojs.T

  val value : t -> string
  val set_value : t -> string -> unit
  val placeholder : t -> string
  val set_placeholder : t -> string -> unit
  val enabled : t -> bool
  val set_enabled : t -> bool -> unit
  val visible : t -> bool
  val set_visible : t -> bool -> unit
end

module QuickDiffProvider : sig
  include Ojs.T

  val provideOriginalResource
    :  t
    -> (uri:Uri.t -> token:CancellationToken.t -> Uri.t ProviderResult.t) or_undefined

  val create
    :  ?provideOriginalResource:
         (uri:Uri.t -> token:CancellationToken.t -> Uri.t ProviderResult.t)
    -> unit
    -> t
end

module SourceControlResourceThemableDecorations : sig
  include Ojs.T

  type icon_path =
    [ `String of string
    | `Uri of Uri.t
    | `ThemeIcon of ThemeIcon.t
    ]

  val icon_path_to_js : icon_path -> Ojs.t
  val icon_path_of_js : Ojs.t -> icon_path
  val iconPath : t -> icon_path or_undefined
  val create : ?iconPath:icon_path -> unit -> t
end

module SourceControlResourceDecorations : sig
  include Ojs.T with type t = private SourceControlResourceThemableDecorations.t

  type icon_path =
    [ `String of string
    | `Uri of Uri.t
    | `ThemeIcon of ThemeIcon.t
    ]

  val icon_path_to_js : icon_path -> Ojs.t
  val icon_path_of_js : Ojs.t -> icon_path

  val to_source_control_resource_themable_decorations
    :  t
    -> SourceControlResourceThemableDecorations.t

  val iconPath : t -> icon_path or_undefined
  val strikeThrough : t -> bool or_undefined
  val faded : t -> bool or_undefined
  val tooltip : t -> string or_undefined
  val light : t -> SourceControlResourceThemableDecorations.t or_undefined
  val dark : t -> SourceControlResourceThemableDecorations.t or_undefined

  val create
    :  ?iconPath:icon_path
    -> ?strikeThrough:bool
    -> ?faded:bool
    -> ?tooltip:string
    -> ?light:SourceControlResourceThemableDecorations.t
    -> ?dark:SourceControlResourceThemableDecorations.t
    -> unit
    -> t
end

module SourceControlResourceState : sig
  include Ojs.T

  val resourceUri : t -> Uri.t
  val command : t -> Command.t or_undefined
  val decorations : t -> SourceControlResourceDecorations.t or_undefined
  val contextValue : t -> string or_undefined

  val create
    :  resourceUri:Uri.t
    -> ?command:Command.t
    -> ?decorations:SourceControlResourceDecorations.t
    -> ?contextValue:string
    -> unit
    -> t
end

module SourceControlResourceGroup : sig
  include Ojs.T

  val id : t -> string
  val label : t -> string
  val set_label : t -> string -> unit
  val hideWhenEmpty : t -> bool or_undefined
  val set_hideWhenEmpty : t -> bool or_undefined -> unit
  val contextValue : t -> string or_undefined
  val set_contextValue : t -> string or_undefined -> unit
  val resourceStates : t -> SourceControlResourceState.t list
  val set_resourceStates : t -> SourceControlResourceState.t list -> unit
  val dispose : t -> unit
end

module SourceControl : sig
  include Ojs.T

  val id : t -> string
  val label : t -> string
  val rootUri : t -> Uri.t or_undefined
  val inputBox : t -> SourceControlInputBox.t
  val count : t -> int or_undefined
  val set_count : t -> int or_undefined -> unit
  val quickDiffProvider : t -> QuickDiffProvider.t or_undefined
  val set_quickDiffProvider : t -> QuickDiffProvider.t or_undefined -> unit
  val commitTemplate : t -> string or_undefined
  val set_commitTemplate : t -> string or_undefined -> unit
  val acceptInputCommand : t -> Command.t or_undefined
  val set_acceptInputCommand : t -> Command.t or_undefined -> unit
  val statusBarCommands : t -> Command.t list or_undefined
  val set_statusBarCommands : t -> Command.t list or_undefined -> unit
  val createResourceGroup : t -> id:string -> label:string -> SourceControlResourceGroup.t
  val dispose : t -> unit
end

module Scm : sig
  (** @deprecated Use SourceControl.inputBox instead *)
  val inputBox : unit -> SourceControlInputBox.t

  val createSourceControl
    :  id:string
    -> label:string
    -> ?rootUri:Uri.t
    -> unit
    -> SourceControl.t
end

module SourceBreakpoint : sig
  include Ojs.T with type t = private Breakpoint.t

  val to_breakpoint : t -> Breakpoint.t
  val id : t -> string
  val enabled : t -> bool
  val condition : t -> string or_undefined
  val hitCondition : t -> string or_undefined
  val logMessage : t -> string or_undefined
  val location : t -> Location.t

  val make
    :  location:Location.t
    -> ?enabled:bool
    -> ?condition:string
    -> ?hitCondition:string
    -> ?logMessage:string
    -> unit
    -> t
end

module FunctionBreakpoint : sig
  include Ojs.T with type t = private Breakpoint.t

  val to_breakpoint : t -> Breakpoint.t
  val id : t -> string
  val enabled : t -> bool
  val condition : t -> string or_undefined
  val hitCondition : t -> string or_undefined
  val logMessage : t -> string or_undefined
  val functionName : t -> string

  val make
    :  functionName:string
    -> ?enabled:bool
    -> ?condition:string
    -> ?hitCondition:string
    -> ?logMessage:string
    -> unit
    -> t
end

module CommentThreadCollapsibleState : sig
  type t =
    | Collapsed
    | Expanded

  include Ojs.T with type t := t
end

module CommentMode : sig
  type t =
    | Editing
    | Preview

  include Ojs.T with type t := t
end

module CommentThreadState : sig
  type t =
    | Unresolved
    | Resolved

  include Ojs.T with type t := t
end

module CommentAuthorInformation : sig
  include Ojs.T

  val name : t -> string
  val set_name : t -> string -> unit
  val iconPath : t -> Uri.t or_undefined
  val set_iconPath : t -> Uri.t or_undefined -> unit
  val create : name:string -> ?iconPath:Uri.t -> unit -> t
end

module CommentReaction : sig
  include Ojs.T

  type icon_path =
    [ `String of string
    | `Uri of Uri.t
    ]

  val icon_path_to_js : icon_path -> Ojs.t
  val icon_path_of_js : Ojs.t -> icon_path
  val label : t -> string
  val iconPath : t -> icon_path
  val count : t -> int
  val authorHasReacted : t -> bool

  val create
    :  label:string
    -> iconPath:icon_path
    -> count:int
    -> authorHasReacted:bool
    -> unit
    -> t
end

module JsDate : sig
  include Ojs.T

  val make : ?milliseconds:float -> unit -> t
  val getTime : t -> float
  val toISOString : t -> string
end

module Comment : sig
  include Ojs.T

  type body =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val body_to_js : body -> Ojs.t
  val body_of_js : Ojs.t -> body
  val body : t -> body
  val set_body : t -> body -> unit
  val mode : t -> CommentMode.t
  val set_mode : t -> CommentMode.t -> unit
  val author : t -> CommentAuthorInformation.t
  val set_author : t -> CommentAuthorInformation.t -> unit
  val contextValue : t -> string or_undefined
  val set_contextValue : t -> string or_undefined -> unit
  val reactions : t -> CommentReaction.t list or_undefined
  val set_reactions : t -> CommentReaction.t list or_undefined -> unit
  val label : t -> string or_undefined
  val set_label : t -> string or_undefined -> unit
  val timestamp : t -> JsDate.t or_undefined
  val set_timestamp : t -> JsDate.t or_undefined -> unit

  val create
    :  body:body
    -> mode:CommentMode.t
    -> author:CommentAuthorInformation.t
    -> ?contextValue:string
    -> ?reactions:CommentReaction.t list
    -> ?label:string
    -> ?timestamp:JsDate.t
    -> unit
    -> t
end

module CommentThread : sig
  include Ojs.T

  type can_reply =
    [ `Bool of bool
    | `CommentAuthorInformation of CommentAuthorInformation.t
    ]

  val can_reply_to_js : can_reply -> Ojs.t
  val can_reply_of_js : Ojs.t -> can_reply
  val uri : t -> Uri.t
  val range : t -> Range.t or_undefined
  val set_range : t -> Range.t or_undefined -> unit
  val comments : t -> Comment.t list
  val set_comments : t -> Comment.t list -> unit
  val collapsibleState : t -> CommentThreadCollapsibleState.t
  val set_collapsibleState : t -> CommentThreadCollapsibleState.t -> unit
  val canReply : t -> can_reply
  val set_canReply : t -> can_reply -> unit
  val contextValue : t -> string or_undefined
  val set_contextValue : t -> string or_undefined -> unit
  val label : t -> string or_undefined
  val set_label : t -> string or_undefined -> unit
  val state : t -> CommentThreadState.t or_undefined
  val set_state : t -> CommentThreadState.t or_undefined -> unit
  val dispose : t -> unit
end

module CommentReply : sig
  include Ojs.T

  val thread : t -> CommentThread.t
  val set_thread : t -> CommentThread.t -> unit
  val text : t -> string
  val set_text : t -> string -> unit
  val create : thread:CommentThread.t -> text:string -> unit -> t
end

module CommentingRanges : sig
  include Ojs.T

  val enableFileComments : t -> bool
  val set_enableFileComments : t -> bool -> unit
  val ranges : t -> Range.t list or_undefined
  val set_ranges : t -> Range.t list or_undefined -> unit
  val create : enableFileComments:bool -> ?ranges:Range.t list -> unit -> t
end

module CommentingRangeProvider : sig
  include Ojs.T

  type provide_commenting_ranges_result_t =
    [ `Items of Range.t list
    | `CommentingRanges of CommentingRanges.t
    ]

  val provide_commenting_ranges_result_t_to_js
    :  provide_commenting_ranges_result_t
    -> Ojs.t

  val provide_commenting_ranges_result_t_of_js
    :  Ojs.t
    -> provide_commenting_ranges_result_t

  val provideCommentingRanges
    :  t
    -> document:TextDocument.t
    -> token:CancellationToken.t
    -> provide_commenting_ranges_result_t ProviderResult.t

  val create
    :  provideCommentingRanges:
         (document:TextDocument.t
          -> token:CancellationToken.t
          -> provide_commenting_ranges_result_t ProviderResult.t)
    -> unit
    -> t
end

module CommentOptions : sig
  include Ojs.T

  val prompt : t -> string or_undefined
  val set_prompt : t -> string or_undefined -> unit
  val placeHolder : t -> string or_undefined
  val set_placeHolder : t -> string or_undefined -> unit
  val create : ?prompt:string -> ?placeHolder:string -> unit -> t
end

module CommentController : sig
  include Ojs.T

  val id : t -> string
  val label : t -> string
  val options : t -> CommentOptions.t or_undefined
  val set_options : t -> CommentOptions.t or_undefined -> unit
  val commentingRangeProvider : t -> CommentingRangeProvider.t or_undefined
  val set_commentingRangeProvider : t -> CommentingRangeProvider.t or_undefined -> unit

  val createCommentThread
    :  t
    -> uri:Uri.t
    -> range:Range.t
    -> comments:Comment.t list
    -> CommentThread.t

  val reactionHandler
    :  t
    -> (comment:Comment.t -> reaction:CommentReaction.t -> unit Promise.t) or_undefined

  val set_reactionHandler
    :  t
    -> (comment:Comment.t -> reaction:CommentReaction.t -> unit Promise.t) or_undefined
    -> unit

  val dispose : t -> unit
end

module Comments : sig
  val createCommentController : id:string -> label:string -> CommentController.t
end

module AuthenticationSessionAccountInformation : sig
  include Ojs.T

  val id : t -> string
  val label : t -> string
  val create : id:string -> label:string -> unit -> t
end

module AuthenticationSession : sig
  include Ojs.T

  val id : t -> string
  val accessToken : t -> string
  val idToken : t -> string or_undefined
  val account : t -> AuthenticationSessionAccountInformation.t
  val scopes : t -> string list

  val create
    :  id:string
    -> accessToken:string
    -> ?idToken:string
    -> account:AuthenticationSessionAccountInformation.t
    -> scopes:string list
    -> unit
    -> t
end

module AuthenticationGetSessionPresentationOptions : sig
  include Ojs.T

  val detail : t -> string or_undefined
  val set_detail : t -> string or_undefined -> unit
  val create : ?detail:string -> unit -> t
end

(** @deprecated Use AuthenticationGetSessionPresentationOptions instead. *)
module AuthenticationForceNewSessionOptions : sig
  type t = AuthenticationGetSessionPresentationOptions.t

  include Ojs.T with type t := t
end

module AuthenticationGetSessionOptions : sig
  include Ojs.T

  type create_if_none =
    [ `Bool of bool
    | `AuthenticationGetSessionPresentationOptions of
        AuthenticationGetSessionPresentationOptions.t
    ]

  val create_if_none_to_js : create_if_none -> Ojs.t
  val create_if_none_of_js : Ojs.t -> create_if_none

  type force_new_session =
    [ `Bool of bool
    | `AuthenticationGetSessionPresentationOptions of
        AuthenticationGetSessionPresentationOptions.t
    | `AuthenticationForceNewSessionOptions of AuthenticationForceNewSessionOptions.t
    ]

  val force_new_session_to_js : force_new_session -> Ojs.t
  val force_new_session_of_js : Ojs.t -> force_new_session
  val clearSessionPreference : t -> bool or_undefined
  val set_clearSessionPreference : t -> bool or_undefined -> unit
  val createIfNone : t -> create_if_none or_undefined
  val set_createIfNone : t -> create_if_none or_undefined -> unit
  val forceNewSession : t -> force_new_session or_undefined
  val set_forceNewSession : t -> force_new_session or_undefined -> unit
  val silent : t -> bool or_undefined
  val set_silent : t -> bool or_undefined -> unit
  val account : t -> AuthenticationSessionAccountInformation.t or_undefined
  val set_account : t -> AuthenticationSessionAccountInformation.t or_undefined -> unit

  val create
    :  ?clearSessionPreference:bool
    -> ?createIfNone:create_if_none
    -> ?forceNewSession:force_new_session
    -> ?silent:bool
    -> ?account:AuthenticationSessionAccountInformation.t
    -> unit
    -> t
end

module AuthenticationWwwAuthenticateRequest : sig
  include Ojs.T

  val wwwAuthenticate : t -> string
  val fallbackScopes : t -> string list or_undefined
  val create : wwwAuthenticate:string -> ?fallbackScopes:string list -> unit -> t
end

module AuthenticationProviderInformation : sig
  include Ojs.T

  val id : t -> string
  val label : t -> string
  val create : id:string -> label:string -> unit -> t
end

module AuthenticationSessionsChangeEvent : sig
  include Ojs.T

  val provider : t -> AuthenticationProviderInformation.t
  val create : provider:AuthenticationProviderInformation.t -> unit -> t
end

module AuthenticationProviderOptions : sig
  include Ojs.T

  val supportsMultipleAccounts : t -> bool or_undefined
  val create : ?supportsMultipleAccounts:bool -> unit -> t
end

module AuthenticationProviderAuthenticationSessionsChangeEvent : sig
  include Ojs.T

  val added : t -> AuthenticationSession.t list or_undefined
  val removed : t -> AuthenticationSession.t list or_undefined
  val changed : t -> AuthenticationSession.t list or_undefined

  val create
    :  added:AuthenticationSession.t list or_undefined
    -> removed:AuthenticationSession.t list or_undefined
    -> changed:AuthenticationSession.t list or_undefined
    -> unit
    -> t
end

module AuthenticationProviderSessionOptions : sig
  include Ojs.T

  val account : t -> AuthenticationSessionAccountInformation.t or_undefined
  val set_account : t -> AuthenticationSessionAccountInformation.t or_undefined -> unit
  val create : ?account:AuthenticationSessionAccountInformation.t -> unit -> t
end

module AuthenticationProvider : sig
  include Ojs.T

  val onDidChangeSessions
    :  t
    -> AuthenticationProviderAuthenticationSessionsChangeEvent.t Event.t

  val getSessions
    :  t
    -> scopes:string list or_undefined
    -> options:AuthenticationProviderSessionOptions.t
    -> AuthenticationSession.t list Promise.t

  val createSession
    :  t
    -> scopes:string list
    -> options:AuthenticationProviderSessionOptions.t
    -> AuthenticationSession.t Promise.t

  val removeSession : t -> sessionId:string -> unit Promise.t

  val create
    :  onDidChangeSessions:
         AuthenticationProviderAuthenticationSessionsChangeEvent.t Event.t
    -> getSessions:
         (scopes:string list or_undefined
          -> options:AuthenticationProviderSessionOptions.t
          -> AuthenticationSession.t list Promise.t)
    -> createSession:
         (scopes:string list
          -> options:AuthenticationProviderSessionOptions.t
          -> AuthenticationSession.t Promise.t)
    -> removeSession:(sessionId:string -> unit Promise.t)
    -> unit
    -> t
end

module Authentication : sig
  type get_session_creating_scope_list_or_request =
    [ `ReadonlyArray of string list
    | `AuthenticationWwwAuthenticateRequest of AuthenticationWwwAuthenticateRequest.t
    ]

  val get_session_creating_scope_list_or_request_to_js
    :  get_session_creating_scope_list_or_request
    -> Ojs.t

  val get_session_creating_scope_list_or_request_of_js
    :  Ojs.t
    -> get_session_creating_scope_list_or_request

  type get_session_creating_options_create_if_none =
    [ `True
    | `AuthenticationGetSessionPresentationOptions of
        AuthenticationGetSessionPresentationOptions.t
    ]

  val get_session_creating_options_create_if_none_to_js
    :  get_session_creating_options_create_if_none
    -> Ojs.t

  val get_session_creating_options_create_if_none_of_js
    :  Ojs.t
    -> get_session_creating_options_create_if_none

  type get_session_creating_options_force_new_session =
    [ `Bool of bool
    | `AuthenticationGetSessionPresentationOptions of
        AuthenticationGetSessionPresentationOptions.t
    | `AuthenticationForceNewSessionOptions of AuthenticationForceNewSessionOptions.t
    ]

  val get_session_creating_options_force_new_session_to_js
    :  get_session_creating_options_force_new_session
    -> Ojs.t

  val get_session_creating_options_force_new_session_of_js
    :  Ojs.t
    -> get_session_creating_options_force_new_session

  type get_session_creating_options =
    { clearSessionPreference : bool or_undefined
    ; createIfNone : get_session_creating_options_create_if_none
    ; forceNewSession : get_session_creating_options_force_new_session or_undefined
    ; silent : bool or_undefined
    ; account : AuthenticationSessionAccountInformation.t or_undefined
    }

  val get_session_creating_options_to_js : get_session_creating_options -> Ojs.t
  val get_session_creating_options_of_js : Ojs.t -> get_session_creating_options

  type get_session_forcing_new_options_create_if_none =
    [ `Bool of bool
    | `AuthenticationGetSessionPresentationOptions of
        AuthenticationGetSessionPresentationOptions.t
    ]

  val get_session_forcing_new_options_create_if_none_to_js
    :  get_session_forcing_new_options_create_if_none
    -> Ojs.t

  val get_session_forcing_new_options_create_if_none_of_js
    :  Ojs.t
    -> get_session_forcing_new_options_create_if_none

  type get_session_forcing_new_options_force_new_session =
    [ `True
    | `AuthenticationGetSessionPresentationOptions of
        AuthenticationGetSessionPresentationOptions.t
    | `AuthenticationForceNewSessionOptions of AuthenticationForceNewSessionOptions.t
    ]

  val get_session_forcing_new_options_force_new_session_to_js
    :  get_session_forcing_new_options_force_new_session
    -> Ojs.t

  val get_session_forcing_new_options_force_new_session_of_js
    :  Ojs.t
    -> get_session_forcing_new_options_force_new_session

  type get_session_forcing_new_options =
    { clearSessionPreference : bool or_undefined
    ; createIfNone : get_session_forcing_new_options_create_if_none or_undefined
    ; forceNewSession : get_session_forcing_new_options_force_new_session
    ; silent : bool or_undefined
    ; account : AuthenticationSessionAccountInformation.t or_undefined
    }

  val get_session_forcing_new_options_to_js : get_session_forcing_new_options -> Ojs.t
  val get_session_forcing_new_options_of_js : Ojs.t -> get_session_forcing_new_options

  val getSessionCreating
    :  providerId:string
    -> scopeListOrRequest:get_session_creating_scope_list_or_request
    -> options:get_session_creating_options
    -> AuthenticationSession.t Promise.t

  val getSessionForcingNew
    :  providerId:string
    -> scopeListOrRequest:get_session_creating_scope_list_or_request
    -> options:get_session_forcing_new_options
    -> AuthenticationSession.t Promise.t

  val getSession
    :  providerId:string
    -> scopeListOrRequest:get_session_creating_scope_list_or_request
    -> ?options:AuthenticationGetSessionOptions.t
    -> unit
    -> AuthenticationSession.t or_undefined Promise.t

  val getAccounts
    :  providerId:string
    -> AuthenticationSessionAccountInformation.t list Promise.t

  val onDidChangeSessions : unit -> AuthenticationSessionsChangeEvent.t Event.t

  val registerAuthenticationProvider
    :  id:string
    -> label:string
    -> provider:AuthenticationProvider.t
    -> ?options:AuthenticationProviderOptions.t
    -> unit
    -> Disposable.t
end

module L10n : sig
  type t_args_item =
    [ `String of string
    | `Float of float
    | `Bool of bool
    ]

  val t_args_item_to_js : t_args_item -> Ojs.t
  val t_args_item_of_js : Ojs.t -> t_args_item

  type t_with_options_args =
    [ `Array of t_args_item list
    | `Record of t_args_item Dict.t
    ]

  val t_with_options_args_to_js : t_with_options_args -> Ojs.t
  val t_with_options_args_of_js : Ojs.t -> t_with_options_args

  type t_with_options_comment =
    [ `String of string
    | `Items of string list
    ]

  val t_with_options_comment_to_js : t_with_options_comment -> Ojs.t
  val t_with_options_comment_of_js : Ojs.t -> t_with_options_comment

  type t_with_options =
    { message : string
    ; args : t_with_options_args or_undefined
    ; comment : t_with_options_comment
    }

  val t_with_options_to_js : t_with_options -> Ojs.t
  val t_with_options_of_js : Ojs.t -> t_with_options
  val t : message:string -> args:t_args_item list -> string
  val tNamed : message:string -> args:t_args_item Dict.t -> string
  val tWithOptions : options:t_with_options -> string
  val bundle : unit -> string Dict.t or_undefined
  val uri : unit -> Uri.t or_undefined
end

module TestRunProfileKind : sig
  type t =
    | Run
    | Debug
    | Coverage

  include Ojs.T with type t := t
end

module rec TestRunProfile : sig
  include Ojs.T

  type run_handler_result =
    [ `Promise of unit Promise.t
    | `Unit of unit
    ]

  val run_handler_result_to_js : run_handler_result -> Ojs.t
  val run_handler_result_of_js : Ojs.t -> run_handler_result
  val label : t -> string
  val set_label : t -> string -> unit
  val kind : t -> TestRunProfileKind.t
  val isDefault : t -> bool
  val set_isDefault : t -> bool -> unit
  val onDidChangeDefault : t -> bool Event.t
  val supportsContinuousRun : t -> bool
  val set_supportsContinuousRun : t -> bool -> unit
  val tag : t -> TestTag.t or_undefined
  val set_tag : t -> TestTag.t or_undefined -> unit
  val configureHandler : t -> (unit -> unit) or_undefined
  val set_configureHandler : t -> (unit -> unit) or_undefined -> unit

  val runHandler
    :  t
    -> request:TestRunRequest.t
    -> token:CancellationToken.t
    -> run_handler_result

  val set_runHandler
    :  t
    -> (request:TestRunRequest.t -> token:CancellationToken.t -> run_handler_result)
    -> unit

  val loadDetailedCoverage
    :  t
    -> (testRun:TestRun.t
        -> fileCoverage:FileCoverage.t
        -> token:CancellationToken.t
        -> FileCoverageDetail.t list Promise.t)
         or_undefined

  val set_loadDetailedCoverage
    :  t
    -> (testRun:TestRun.t
        -> fileCoverage:FileCoverage.t
        -> token:CancellationToken.t
        -> FileCoverageDetail.t list Promise.t)
         or_undefined
    -> unit

  val loadDetailedCoverageForTest
    :  t
    -> (testRun:TestRun.t
        -> fileCoverage:FileCoverage.t
        -> fromTestItem:TestItem.t
        -> token:CancellationToken.t
        -> FileCoverageDetail.t list Promise.t)
         or_undefined

  val set_loadDetailedCoverageForTest
    :  t
    -> (testRun:TestRun.t
        -> fileCoverage:FileCoverage.t
        -> fromTestItem:TestItem.t
        -> token:CancellationToken.t
        -> FileCoverageDetail.t list Promise.t)
         or_undefined
    -> unit

  val dispose : t -> unit

  val create
    :  label:string
    -> kind:TestRunProfileKind.t
    -> isDefault:bool
    -> onDidChangeDefault:bool Event.t
    -> supportsContinuousRun:bool
    -> tag:TestTag.t or_undefined
    -> configureHandler:(unit -> unit) or_undefined
    -> runHandler:
         (request:TestRunRequest.t -> token:CancellationToken.t -> run_handler_result)
    -> ?loadDetailedCoverage:
         (testRun:TestRun.t
          -> fileCoverage:FileCoverage.t
          -> token:CancellationToken.t
          -> FileCoverageDetail.t list Promise.t)
    -> ?loadDetailedCoverageForTest:
         (testRun:TestRun.t
          -> fileCoverage:FileCoverage.t
          -> fromTestItem:TestItem.t
          -> token:CancellationToken.t
          -> FileCoverageDetail.t list Promise.t)
    -> dispose:(unit -> unit)
    -> unit
    -> t
end

and TestRunRequest : sig
  include Ojs.T

  val include_ : t -> TestItem.t list or_undefined
  val exclude : t -> TestItem.t list or_undefined
  val profile : t -> TestRunProfile.t or_undefined
  val continuous : t -> bool or_undefined
  val preserveFocus : t -> bool

  val make
    :  ?include_:TestItem.t list
    -> ?exclude:TestItem.t list
    -> ?profile:TestRunProfile.t
    -> ?continuous:bool
    -> ?preserveFocus:bool
    -> unit
    -> t
end

module TestController : sig
  include Ojs.T

  type create_run_profile_run_handler_result =
    [ `Promise of unit Promise.t
    | `Unit of unit
    ]

  val create_run_profile_run_handler_result_to_js
    :  create_run_profile_run_handler_result
    -> Ojs.t

  val create_run_profile_run_handler_result_of_js
    :  Ojs.t
    -> create_run_profile_run_handler_result

  type invalidate_test_results_items =
    [ `TestItem of TestItem.t
    | `Items of TestItem.t list
    ]

  val invalidate_test_results_items_to_js : invalidate_test_results_items -> Ojs.t
  val invalidate_test_results_items_of_js : Ojs.t -> invalidate_test_results_items
  val id : t -> string
  val label : t -> string
  val set_label : t -> string -> unit
  val items : t -> TestItemCollection.t

  val createRunProfile
    :  t
    -> label:string
    -> kind:TestRunProfileKind.t
    -> runHandler:
         (request:TestRunRequest.t
          -> token:CancellationToken.t
          -> create_run_profile_run_handler_result)
    -> ?isDefault:bool
    -> ?tag:TestTag.t
    -> ?supportsContinuousRun:bool
    -> unit
    -> TestRunProfile.t

  val resolveHandler
    :  t
    -> (item:TestItem.t or_undefined -> create_run_profile_run_handler_result)
         or_undefined

  val set_resolveHandler
    :  t
    -> (item:TestItem.t or_undefined -> create_run_profile_run_handler_result)
         or_undefined
    -> unit

  val refreshHandler
    :  t
    -> (token:CancellationToken.t -> create_run_profile_run_handler_result) or_undefined

  val set_refreshHandler
    :  t
    -> (token:CancellationToken.t -> create_run_profile_run_handler_result) or_undefined
    -> unit

  val createTestRun
    :  t
    -> request:TestRunRequest.t
    -> ?name:string
    -> ?persist:bool
    -> unit
    -> TestRun.t

  val createTestItem : t -> id:string -> label:string -> ?uri:Uri.t -> unit -> TestItem.t
  val invalidateTestResults : t -> ?items:invalidate_test_results_items -> unit -> unit
  val dispose : t -> unit
end

module Tests : sig
  val createTestController : id:string -> label:string -> TestController.t
end

module TabInputText : sig
  include Ojs.T

  val uri : t -> Uri.t
  val make : uri:Uri.t -> t
end

module TabInputTextDiff : sig
  include Ojs.T

  val original : t -> Uri.t
  val modified : t -> Uri.t
  val make : original:Uri.t -> modified:Uri.t -> t
end

module TabInputCustom : sig
  include Ojs.T

  val uri : t -> Uri.t
  val viewType : t -> string
  val make : uri:Uri.t -> viewType:string -> t
end

module TabInputWebview : sig
  include Ojs.T

  val viewType : t -> string
  val make : viewType:string -> t
end

module TabInputNotebook : sig
  include Ojs.T

  val uri : t -> Uri.t
  val notebookType : t -> string
  val make : uri:Uri.t -> notebookType:string -> t
end

module TabInputNotebookDiff : sig
  include Ojs.T

  val original : t -> Uri.t
  val modified : t -> Uri.t
  val notebookType : t -> string
  val make : original:Uri.t -> modified:Uri.t -> notebookType:string -> t
end

module TabInputTerminal : sig
  include Ojs.T

  val make : unit -> t
end

module TelemetryTrustedValue : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val value : t -> T.t
    val make : value:T.t -> t
  end
end

module ChatPromptReference : sig
  include Ojs.T

  val id : t -> string
  val range : t -> (int * int) or_undefined
  val modelDescription : t -> string or_undefined
  val value : t -> Ojs.t

  val create
    :  id:string
    -> ?range:int * int
    -> ?modelDescription:string
    -> value:Ojs.t
    -> unit
    -> t
end

module ChatLanguageModelToolReference : sig
  include Ojs.T

  val name : t -> string
  val range : t -> (int * int) or_undefined
  val create : name:string -> ?range:int * int -> unit -> t
end

module ChatRequestTurn : sig
  include Ojs.T

  val prompt : t -> string
  val participant : t -> string
  val command : t -> string or_undefined
  val references : t -> ChatPromptReference.t list
  val toolReferences : t -> ChatLanguageModelToolReference.t list
end

module ChatResponseMarkdownPart : sig
  include Ojs.T

  type make_value =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val make_value_to_js : make_value -> Ojs.t
  val make_value_of_js : Ojs.t -> make_value
  val value : t -> MarkdownString.t
  val set_value : t -> MarkdownString.t -> unit
  val make : value:make_value -> t
end

module ChatResponseFileTree : sig
  include Ojs.T

  val name : t -> string
  val set_name : t -> string -> unit
  val children : t -> t list or_undefined
  val set_children : t -> t list or_undefined -> unit
  val create : name:string -> ?children:t list -> unit -> t
end

module ChatResponseFileTreePart : sig
  include Ojs.T

  val value : t -> ChatResponseFileTree.t list
  val set_value : t -> ChatResponseFileTree.t list -> unit
  val baseUri : t -> Uri.t
  val set_baseUri : t -> Uri.t -> unit
  val make : value:ChatResponseFileTree.t list -> baseUri:Uri.t -> t
end

module ChatResponseAnchorPart : sig
  include Ojs.T

  type value =
    [ `Uri of Uri.t
    | `Location of Location.t
    ]

  val value_to_js : value -> Ojs.t
  val value_of_js : Ojs.t -> value
  val value : t -> value
  val set_value : t -> value -> unit
  val title : t -> string or_undefined
  val set_title : t -> string or_undefined -> unit
  val make : value:value -> ?title:string -> unit -> t
end

module ChatResponseCommandButtonPart : sig
  include Ojs.T

  val value : t -> Command.t
  val set_value : t -> Command.t -> unit
  val make : value:Command.t -> t
end

module ChatErrorDetails : sig
  include Ojs.T

  val message : t -> string
  val set_message : t -> string -> unit
  val responseIsFiltered : t -> bool or_undefined
  val set_responseIsFiltered : t -> bool or_undefined -> unit
  val create : message:string -> ?responseIsFiltered:bool -> unit -> t
end

module ChatResult : sig
  include Ojs.T

  val errorDetails : t -> ChatErrorDetails.t or_undefined
  val set_errorDetails : t -> ChatErrorDetails.t or_undefined -> unit
  val metadata : t -> Ojs.t Dict.t or_undefined
  val create : ?errorDetails:ChatErrorDetails.t -> ?metadata:Ojs.t Dict.t -> unit -> t
end

module ChatResponseTurn : sig
  include Ojs.T

  type response_item =
    [ `ChatResponseMarkdownPart of ChatResponseMarkdownPart.t
    | `ChatResponseFileTreePart of ChatResponseFileTreePart.t
    | `ChatResponseAnchorPart of ChatResponseAnchorPart.t
    | `ChatResponseCommandButtonPart of ChatResponseCommandButtonPart.t
    ]

  val response_item_to_js : response_item -> Ojs.t
  val response_item_of_js : Ojs.t -> response_item
  val response : t -> response_item list
  val result : t -> ChatResult.t
  val participant : t -> string
  val command : t -> string or_undefined
end

module ChatContext : sig
  include Ojs.T

  type history_item =
    [ `ChatRequestTurn of ChatRequestTurn.t
    | `ChatResponseTurn of ChatResponseTurn.t
    ]

  val history_item_to_js : history_item -> Ojs.t
  val history_item_of_js : Ojs.t -> history_item
  val history : t -> history_item list
  val create : history:history_item list -> unit -> t
end

module ChatResultFeedbackKind : sig
  type t =
    | Unhelpful
    | Helpful

  include Ojs.T with type t := t
end

module ChatResultFeedback : sig
  include Ojs.T

  val result : t -> ChatResult.t
  val kind : t -> ChatResultFeedbackKind.t
  val create : result:ChatResult.t -> kind:ChatResultFeedbackKind.t -> unit -> t
end

module ChatFollowup : sig
  include Ojs.T

  val prompt : t -> string
  val set_prompt : t -> string -> unit
  val label : t -> string or_undefined
  val set_label : t -> string or_undefined -> unit
  val participant : t -> string or_undefined
  val set_participant : t -> string or_undefined -> unit
  val command : t -> string or_undefined
  val set_command : t -> string or_undefined -> unit

  val create
    :  prompt:string
    -> ?label:string
    -> ?participant:string
    -> ?command:string
    -> unit
    -> t
end

module ChatFollowupProvider : sig
  include Ojs.T

  val provideFollowups
    :  t
    -> result:ChatResult.t
    -> context:ChatContext.t
    -> token:CancellationToken.t
    -> ChatFollowup.t list ProviderResult.t

  val create
    :  provideFollowups:
         (result:ChatResult.t
          -> context:ChatContext.t
          -> token:CancellationToken.t
          -> ChatFollowup.t list ProviderResult.t)
    -> unit
    -> t
end

module ChatParticipantToolToken : sig
  include Ojs.T
end

module ChatRequest : sig
  include Ojs.T

  val prompt : t -> string
  val command : t -> string or_undefined
  val references : t -> ChatPromptReference.t list
  val toolReferences : t -> ChatLanguageModelToolReference.t list
  val toolInvocationToken : t -> ChatParticipantToolToken.t
  val model : t -> LanguageModelChat.t

  val create
    :  prompt:string
    -> command:string or_undefined
    -> references:ChatPromptReference.t list
    -> toolReferences:ChatLanguageModelToolReference.t list
    -> toolInvocationToken:ChatParticipantToolToken.t
    -> model:LanguageModelChat.t
    -> unit
    -> t
end

module ChatResponseProgressPart : sig
  include Ojs.T

  val value : t -> string
  val set_value : t -> string -> unit
  val make : value:string -> t
end

module ChatResponseReferencePart : sig
  include Ojs.T

  type value =
    [ `Uri of Uri.t
    | `Location of Location.t
    ]

  val value_to_js : value -> Ojs.t
  val value_of_js : Ojs.t -> value
  val value : t -> value
  val set_value : t -> value -> unit
  val iconPath : t -> IconPath.t or_undefined
  val set_iconPath : t -> IconPath.t or_undefined -> unit
  val make : value:value -> ?iconPath:IconPath.t -> unit -> t
end

module ChatResponsePart : sig
  type value =
    [ `ChatResponseMarkdownPart of ChatResponseMarkdownPart.t
    | `ChatResponseFileTreePart of ChatResponseFileTreePart.t
    | `ChatResponseAnchorPart of ChatResponseAnchorPart.t
    | `ChatResponseProgressPart of ChatResponseProgressPart.t
    | `ChatResponseReferencePart of ChatResponseReferencePart.t
    | `ChatResponseCommandButtonPart of ChatResponseCommandButtonPart.t
    ]

  val value_to_js : value -> Ojs.t
  val value_of_js : Ojs.t -> value

  type t = value

  include Ojs.T with type t := t
end

module ChatResponseStream : sig
  include Ojs.T

  type markdown_value =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val markdown_value_to_js : markdown_value -> Ojs.t
  val markdown_value_of_js : Ojs.t -> markdown_value

  type anchor_value =
    [ `Uri of Uri.t
    | `Location of Location.t
    ]

  val anchor_value_to_js : anchor_value -> Ojs.t
  val anchor_value_of_js : Ojs.t -> anchor_value
  val markdown : t -> value:markdown_value -> unit
  val anchor : t -> value:anchor_value -> ?title:string -> unit -> unit
  val button : t -> command:Command.t -> unit
  val filetree : t -> value:ChatResponseFileTree.t list -> baseUri:Uri.t -> unit
  val progress : t -> value:string -> unit
  val reference : t -> value:anchor_value -> ?iconPath:IconPath.t -> unit -> unit
  val push : t -> part:ChatResponsePart.t -> unit

  val create
    :  markdown:(value:markdown_value -> unit)
    -> anchor:(value:anchor_value -> ?title:string -> unit -> unit)
    -> button:(command:Command.t -> unit)
    -> filetree:(value:ChatResponseFileTree.t list -> baseUri:Uri.t -> unit)
    -> progress:(value:string -> unit)
    -> reference:(value:anchor_value -> ?iconPath:IconPath.t -> unit -> unit)
    -> push:(part:ChatResponsePart.t -> unit)
    -> unit
    -> t
end

module ChatRequestHandler : sig
  type value_result_t =
    [ `ChatResult of ChatResult.t
    | `Unit of unit
    ]

  val value_result_t_to_js : value_result_t -> Ojs.t
  val value_result_t_of_js : Ojs.t -> value_result_t

  type t =
    request:ChatRequest.t
    -> context:ChatContext.t
    -> response:ChatResponseStream.t
    -> token:CancellationToken.t
    -> value_result_t ProviderResult.t

  include Ojs.T with type t := t
end

module ChatParticipant : sig
  include Ojs.T

  val id : t -> string
  val iconPath : t -> IconPath.t or_undefined
  val set_iconPath : t -> IconPath.t or_undefined -> unit
  val requestHandler : t -> ChatRequestHandler.t
  val set_requestHandler : t -> ChatRequestHandler.t -> unit
  val followupProvider : t -> ChatFollowupProvider.t or_undefined
  val set_followupProvider : t -> ChatFollowupProvider.t or_undefined -> unit
  val onDidReceiveFeedback : t -> ChatResultFeedback.t Event.t
  val dispose : t -> unit
end

module Chat : sig
  val createChatParticipant
    :  id:string
    -> handler:ChatRequestHandler.t
    -> ChatParticipant.t
end

module LanguageModelChatSelector : sig
  include Ojs.T

  val vendor : t -> string or_undefined
  val set_vendor : t -> string or_undefined -> unit
  val family : t -> string or_undefined
  val set_family : t -> string or_undefined -> unit
  val version : t -> string or_undefined
  val set_version : t -> string or_undefined -> unit
  val id : t -> string or_undefined
  val set_id : t -> string or_undefined -> unit

  val create
    :  ?vendor:string
    -> ?family:string
    -> ?version:string
    -> ?id:string
    -> unit
    -> t
end

module LanguageModelError : sig
  include Ojs.T with type t = private JsError.t

  type make_options = { cause : Ojs.t or_undefined }

  val make_options_to_js : make_options -> Ojs.t
  val make_options_of_js : Ojs.t -> make_options
  val to_js_error : t -> JsError.t
  val name : t -> string
  val set_name : t -> string -> unit
  val message : t -> string
  val set_message : t -> string -> unit
  val stack : t -> string or_undefined
  val set_stack : t -> string or_undefined -> unit
  val cause : t -> Ojs.t or_undefined
  val set_cause : t -> Ojs.t or_undefined -> unit
  val noPermissions : ?message:string -> unit -> t
  val blocked : ?message:string -> unit -> t
  val notFound : ?message:string -> unit -> t
  val code : t -> string
  val make : ?message:string -> ?options:make_options -> unit -> t
end

module McpStdioServerDefinition : sig
  include Ojs.T

  type env_value =
    [ `String of string
    | `Float of float
    | `Null
    ]

  val env_value_to_js : env_value -> Ojs.t
  val env_value_of_js : Ojs.t -> env_value
  val label : t -> string
  val cwd : t -> Uri.t or_undefined
  val set_cwd : t -> Uri.t or_undefined -> unit
  val command : t -> string
  val set_command : t -> string -> unit
  val args : t -> string list
  val set_args : t -> string list -> unit
  val env : t -> env_value Dict.t
  val set_env : t -> env_value Dict.t -> unit
  val version : t -> string or_undefined
  val set_version : t -> string or_undefined -> unit

  val make
    :  label:string
    -> command:string
    -> ?args:string list
    -> ?env:env_value Dict.t
    -> ?version:string
    -> unit
    -> t
end

module McpHttpServerDefinition : sig
  include Ojs.T

  val label : t -> string
  val uri : t -> Uri.t
  val set_uri : t -> Uri.t -> unit
  val headers : t -> string Dict.t
  val set_headers : t -> string Dict.t -> unit
  val version : t -> string or_undefined
  val set_version : t -> string or_undefined -> unit

  val make
    :  label:string
    -> uri:Uri.t
    -> ?headers:string Dict.t
    -> ?version:string
    -> unit
    -> t
end

module McpServerDefinition : sig
  type value =
    [ `McpStdioServerDefinition of McpStdioServerDefinition.t
    | `McpHttpServerDefinition of McpHttpServerDefinition.t
    ]

  val value_to_js : value -> Ojs.t
  val value_of_js : Ojs.t -> value

  type t = value

  include Ojs.T with type t := t
end

module McpServerDefinitionProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val onDidChangeMcpServerDefinitions : t -> unit Event.t or_undefined

    val provideMcpServerDefinitions
      :  t
      -> token:CancellationToken.t
      -> T.t list ProviderResult.t

    val resolveMcpServerDefinition
      :  t
      -> (server:T.t -> token:CancellationToken.t -> T.t ProviderResult.t) or_undefined

    val create
      :  ?onDidChangeMcpServerDefinitions:unit Event.t
      -> provideMcpServerDefinitions:
           (token:CancellationToken.t -> T.t list ProviderResult.t)
      -> ?resolveMcpServerDefinition:
           (server:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
      -> unit
      -> t
  end
end

module ProvideLanguageModelChatResponseOptions : sig
  include Ojs.T

  val modelOptions : t -> Ojs.t Dict.t or_undefined
  val tools : t -> LanguageModelChatTool.t list or_undefined
  val toolMode : t -> LanguageModelChatToolMode.t

  val create
    :  ?modelOptions:Ojs.t Dict.t
    -> ?tools:LanguageModelChatTool.t list
    -> toolMode:LanguageModelChatToolMode.t
    -> unit
    -> t
end

module LanguageModelChatCapabilities : sig
  include Ojs.T

  type tool_calling =
    [ `Bool of bool
    | `Int of int
    ]

  val tool_calling_to_js : tool_calling -> Ojs.t
  val tool_calling_of_js : Ojs.t -> tool_calling
  val imageInput : t -> bool or_undefined
  val toolCalling : t -> tool_calling or_undefined
  val create : ?imageInput:bool -> ?toolCalling:tool_calling -> unit -> t
end

module LanguageModelChatInformation : sig
  include Ojs.T

  val id : t -> string
  val name : t -> string
  val family : t -> string
  val tooltip : t -> string or_undefined
  val detail : t -> string or_undefined
  val version : t -> string
  val maxInputTokens : t -> int
  val maxOutputTokens : t -> int
  val capabilities : t -> LanguageModelChatCapabilities.t

  val create
    :  id:string
    -> name:string
    -> family:string
    -> ?tooltip:string
    -> ?detail:string
    -> version:string
    -> maxInputTokens:int
    -> maxOutputTokens:int
    -> capabilities:LanguageModelChatCapabilities.t
    -> unit
    -> t
end

module LanguageModelChatRequestMessage : sig
  include Ojs.T

  val role : t -> LanguageModelChatMessageRole.t
  val content : t -> Ojs.t list
  val name : t -> string or_undefined

  val create
    :  role:LanguageModelChatMessageRole.t
    -> content:Ojs.t list
    -> name:string or_undefined
    -> unit
    -> t
end

module LanguageModelResponsePart : sig
  type value =
    [ `LanguageModelTextPart of LanguageModelTextPart.t
    | `LanguageModelToolResultPart of LanguageModelToolResultPart.t
    | `LanguageModelToolCallPart of LanguageModelToolCallPart.t
    | `LanguageModelDataPart of LanguageModelDataPart.t
    ]

  val value_to_js : value -> Ojs.t
  val value_of_js : Ojs.t -> value

  type t = value

  include Ojs.T with type t := t
end

module PrepareLanguageModelChatModelOptions : sig
  include Ojs.T

  val silent : t -> bool
  val create : silent:bool -> unit -> t
end

module LanguageModelChatProvider : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    type provide_token_count_text =
      [ `String of string
      | `LanguageModelChatRequestMessage of LanguageModelChatRequestMessage.t
      ]

    val provide_token_count_text_to_js : provide_token_count_text -> Ojs.t
    val provide_token_count_text_of_js : Ojs.t -> provide_token_count_text
    val onDidChangeLanguageModelChatInformation : t -> unit Event.t or_undefined

    val provideLanguageModelChatInformation
      :  t
      -> options:PrepareLanguageModelChatModelOptions.t
      -> token:CancellationToken.t
      -> T.t list ProviderResult.t

    val provideLanguageModelChatResponse
      :  t
      -> model:T.t
      -> messages:LanguageModelChatRequestMessage.t list
      -> options:ProvideLanguageModelChatResponseOptions.t
      -> progress:LanguageModelResponsePart.t Progress.t
      -> token:CancellationToken.t
      -> unit Promise.t

    val provideTokenCount
      :  t
      -> model:T.t
      -> text:provide_token_count_text
      -> token:CancellationToken.t
      -> int Promise.t

    val create
      :  ?onDidChangeLanguageModelChatInformation:unit Event.t
      -> provideLanguageModelChatInformation:
           (options:PrepareLanguageModelChatModelOptions.t
            -> token:CancellationToken.t
            -> T.t list ProviderResult.t)
      -> provideLanguageModelChatResponse:
           (model:T.t
            -> messages:LanguageModelChatRequestMessage.t list
            -> options:ProvideLanguageModelChatResponseOptions.t
            -> progress:LanguageModelResponsePart.t Progress.t
            -> token:CancellationToken.t
            -> unit Promise.t)
      -> provideTokenCount:
           (model:T.t
            -> text:provide_token_count_text
            -> token:CancellationToken.t
            -> int Promise.t)
      -> unit
      -> t
  end
end

module LanguageModelToolTokenizationOptions : sig
  include Ojs.T

  val tokenBudget : t -> int
  val set_tokenBudget : t -> int -> unit

  val countTokens
    :  t
    -> text:string
    -> ?token:CancellationToken.t
    -> unit
    -> int Promise.t

  val create
    :  tokenBudget:int
    -> countTokens:(text:string -> ?token:CancellationToken.t -> unit -> int Promise.t)
    -> unit
    -> t
end

module LanguageModelToolInvocationOptions : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val toolInvocationToken : t -> ChatParticipantToolToken.t or_undefined
    val set_toolInvocationToken : t -> ChatParticipantToolToken.t or_undefined -> unit
    val input : t -> T.t
    val set_input : t -> T.t -> unit
    val tokenizationOptions : t -> LanguageModelToolTokenizationOptions.t or_undefined

    val set_tokenizationOptions
      :  t
      -> LanguageModelToolTokenizationOptions.t or_undefined
      -> unit

    val create
      :  toolInvocationToken:ChatParticipantToolToken.t or_undefined
      -> input:T.t
      -> ?tokenizationOptions:LanguageModelToolTokenizationOptions.t
      -> unit
      -> t
  end
end

module LanguageModelToolResult : sig
  include Ojs.T

  val content : t -> Ojs.t list
  val set_content : t -> Ojs.t list -> unit
  val make : content:Ojs.t list -> t
end

module LanguageModelToolInvocationPrepareOptions : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val input : t -> T.t
    val set_input : t -> T.t -> unit
    val create : input:T.t -> unit -> t
  end
end

module LanguageModelToolConfirmationMessages : sig
  include Ojs.T

  type message =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val message_to_js : message -> Ojs.t
  val message_of_js : Ojs.t -> message
  val title : t -> string
  val set_title : t -> string -> unit
  val message : t -> message
  val set_message : t -> message -> unit
  val create : title:string -> message:message -> unit -> t
end

module PreparedToolInvocation : sig
  include Ojs.T

  type invocation_message =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  val invocation_message_to_js : invocation_message -> Ojs.t
  val invocation_message_of_js : Ojs.t -> invocation_message
  val invocationMessage : t -> invocation_message or_undefined
  val set_invocationMessage : t -> invocation_message or_undefined -> unit
  val confirmationMessages : t -> LanguageModelToolConfirmationMessages.t or_undefined

  val set_confirmationMessages
    :  t
    -> LanguageModelToolConfirmationMessages.t or_undefined
    -> unit

  val create
    :  ?invocationMessage:invocation_message
    -> ?confirmationMessages:LanguageModelToolConfirmationMessages.t
    -> unit
    -> t
end

module LanguageModelTool : sig
  include Js.Generic

  module Make (T : Ojs.T) : sig
    include Ojs.T with type t = T.t t

    val invoke
      :  t
      -> options:T.t LanguageModelToolInvocationOptions.t
      -> token:CancellationToken.t
      -> LanguageModelToolResult.t ProviderResult.t

    val prepareInvocation
      :  t
      -> (options:T.t LanguageModelToolInvocationPrepareOptions.t
          -> token:CancellationToken.t
          -> PreparedToolInvocation.t ProviderResult.t)
           or_undefined

    val create
      :  invoke:
           (options:T.t LanguageModelToolInvocationOptions.t
            -> token:CancellationToken.t
            -> LanguageModelToolResult.t ProviderResult.t)
      -> ?prepareInvocation:
           (options:T.t LanguageModelToolInvocationPrepareOptions.t
            -> token:CancellationToken.t
            -> PreparedToolInvocation.t ProviderResult.t)
      -> unit
      -> t
  end
end

module LanguageModelToolInformation : sig
  include Ojs.T

  val name : t -> string
  val description : t -> string
  val inputSchema : t -> Ojs.t or_undefined
  val tags : t -> string list

  val create
    :  name:string
    -> description:string
    -> inputSchema:Ojs.t or_undefined
    -> tags:string list
    -> unit
    -> t
end

module Lm : sig
  val onDidChangeChatModels : unit -> unit Event.t

  val selectChatModels
    :  ?selector:LanguageModelChatSelector.t
    -> unit
    -> LanguageModelChat.t list Promise.t

  val registerTool
    :  'p_t Js.t
    -> name:string
    -> tool:'p_t LanguageModelTool.t
    -> Disposable.t

  val tools : unit -> LanguageModelToolInformation.t list

  val invokeTool
    :  name:string
    -> options:Ojs.t LanguageModelToolInvocationOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> LanguageModelToolResult.t Promise.t

  val registerMcpServerDefinitionProvider
    :  id:string
    -> provider:McpServerDefinition.t McpServerDefinitionProvider.t
    -> Disposable.t

  val registerLanguageModelChatProvider
    :  vendor:string
    -> provider:LanguageModelChatInformation.t LanguageModelChatProvider.t
    -> Disposable.t
end

module LanguageModelPromptTsxPart : sig
  include Ojs.T

  val value : t -> Ojs.t
  val set_value : t -> Ojs.t -> unit
  val make : value:Ojs.t -> t
end
