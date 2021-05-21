[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

[@@@js.scope "__LIB__VSCODE__IMPORTS"]

open Es2015

module Vscode : sig
  val version : string [@@js.global "version"]

  module Command : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val title : t -> string [@@js.get "title"]

    val set_title : t -> string -> unit [@@js.set "title"]

    val command : t -> string [@@js.get "command"]

    val set_command : t -> string -> unit [@@js.set "command"]

    val tooltip : t -> string [@@js.get "tooltip"]

    val set_tooltip : t -> string -> unit [@@js.set "tooltip"]

    val arguments : t -> any list [@@js.get "arguments"]

    val set_arguments : t -> any list -> unit [@@js.set "arguments"]

    val create :
         title:string
      -> command:string
      -> ?tooltip:string
      -> ?arguments:any list
      -> unit
      -> t
      [@@js.builder]
  end
  [@@js.scope "Command"]

  module Position : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val line : t -> int [@@js.get "line"]

    val character : t -> int [@@js.get "character"]

    val create : line:int -> character:int -> t [@@js.create]

    val is_before : t -> other:t -> bool [@@js.call "isBefore"]

    val is_before_or_equal : t -> other:t -> bool [@@js.call "isBeforeOrEqual"]

    val is_after : t -> other:t -> bool [@@js.call "isAfter"]

    val is_after_or_equal : t -> other:t -> bool [@@js.call "isAfterOrEqual"]

    val is_equal : t -> other:t -> bool [@@js.call "isEqual"]

    val compare_to : t -> other:t -> int [@@js.call "compareTo"]

    val translate : t -> ?line_delta:int -> ?character_delta:int -> unit -> t
      [@@js.call "translate"]

    module Translate_change : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val line_delta : t -> int [@@js.get "lineDelta"]

      val set_line_delta : t -> int -> unit [@@js.set "lineDelta"]

      val character_delta : t -> int [@@js.get "characterDelta"]

      val set_character_delta : t -> int -> unit [@@js.set "characterDelta"]
    end

    val translate' : t -> Translate_change.t -> t [@@js.call "translate"]

    val with_ : t -> ?line:int -> ?character:int -> unit -> t [@@js.call "with"]

    module With_change : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val line : t -> int [@@js.get "line"]

      val set_line : t -> int -> unit [@@js.set "line"]

      val character : t -> int [@@js.get "character"]

      val set_character : t -> int -> unit [@@js.set "character"]
    end

    val with' : t -> With_change.t -> t [@@js.call "with"]

    val make : line:int -> character:int -> t [@@js.new "Position"]
  end

  module Range : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val start : t -> Position.t [@@js.get "start"]

    val end_ : t -> Position.t [@@js.get "end"]

    val create : start:Position.t -> end_:Position.t -> t [@@js.create]

    val create' :
         start_line:int
      -> start_character:int
      -> end_line:int
      -> end_character:int
      -> t
      [@@js.create]

    val is_empty : t -> bool [@@js.get "isEmpty"]

    val set_is_empty : t -> bool -> unit [@@js.set "isEmpty"]

    val is_single_line : t -> bool [@@js.get "isSingleLine"]

    val set_is_single_line : t -> bool -> unit [@@js.set "isSingleLine"]

    val contains : t -> (Position.t, t) union2 -> bool [@@js.call "contains"]

    val is_equal : t -> other:t -> bool [@@js.call "isEqual"]

    val intersection : t -> range:t -> t or_undefined [@@js.call "intersection"]

    val union : t -> other:t -> t [@@js.call "union"]

    val with_ : t -> ?start:Position.t -> ?end_:Position.t -> unit -> t
      [@@js.call "with"]

    module With_change : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val start : t -> Position.t [@@js.get "start"]

      val set_start : t -> Position.t -> unit [@@js.set "start"]

      val end_ : t -> Position.t [@@js.get "end"]

      val set_end : t -> Position.t -> unit [@@js.set "end"]
    end

    val with' : t -> change:With_change.t -> t [@@js.call "with"]

    val make_positions : start:Position.t -> end_:Position.t -> t
      [@@js.new "Range"]

    val make_coordinates :
         start_line:int
      -> start_character:int
      -> end_line:int
      -> end_character:int
      -> t
      [@@js.new "Range"]
  end

  module Uri : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val parse : string -> ?strict:bool -> unit -> t [@@js.global "parse"]

    val file : string -> t [@@js.global "file"]

    val join_path : t -> (string list[@js.variadic]) -> t
      [@@js.global "joinPath"]

    val create :
         scheme:string
      -> authority:string
      -> path:string
      -> query:string
      -> fragment:string
      -> t
      [@@js.create]

    val scheme : t -> string [@@js.get "scheme"]

    val authority : t -> string [@@js.get "authority"]

    val path : t -> string [@@js.get "path"]

    val query : t -> string [@@js.get "query"]

    val fragment : t -> string [@@js.get "fragment"]

    val fs_path : t -> string [@@js.get "fsPath"]

    module With_change : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val scheme : t -> string [@@js.get "scheme"]

      val set_scheme : t -> string -> unit [@@js.set "scheme"]

      val authority : t -> string [@@js.get "authority"]

      val set_authority : t -> string -> unit [@@js.set "authority"]

      val path : t -> string [@@js.get "path"]

      val set_path : t -> string -> unit [@@js.set "path"]

      val query : t -> string [@@js.get "query"]

      val set_query : t -> string -> unit [@@js.set "query"]

      val fragment : t -> string [@@js.get "fragment"]

      val set_fragment : t -> string -> unit [@@js.set "fragment"]

      val create :
           ?scheme:string
        -> ?authority:string
        -> ?path:string
        -> ?query:string
        -> ?fragment:string
        -> unit
        -> t
        [@@js.builder]
    end

    val with_ : t -> With_change.t -> t [@@js.call "with"]

    val to_string : t -> ?skip_encoding:bool -> unit -> string
      [@@js.call "toString"]

    val to_json : t -> any [@@js.call "toJSON"]
  end
  [@@js.scope "Uri"]

  module Text_line : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val line_number : t -> int [@@js.get "lineNumber"]

    val text : t -> string [@@js.get "text"]

    val range : t -> Range.t [@@js.get "range"]

    val range_including_line_break : t -> Range.t
      [@@js.get "rangeIncludingLineBreak"]

    val first_non_whitespace_character_index : t -> int
      [@@js.get "firstNonWhitespaceCharacterIndex"]

    val is_empty_or_whitespace : t -> bool [@@js.get "isEmptyOrWhitespace"]

    val create :
         line_number:int
      -> text:string
      -> range:Range.t
      -> range_including_line_break:Range.t
      -> first_non_whitespace_character_index:int
      -> is_empty_or_whitespace:bool
      -> t
      [@@js.builder]
  end
  [@@js.scope "TextLine"]

  module End_of_line : sig
    type t =
      ([ `LF [@js 1]
       | `CRLF [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Text_document : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val uri : t -> Uri.t [@@js.get "uri"]

    val file_name : t -> string [@@js.get "fileName"]

    val is_untitled : t -> bool [@@js.get "isUntitled"]

    val language_id : t -> string [@@js.get "languageId"]

    val version : t -> int [@@js.get "version"]

    val is_dirty : t -> bool [@@js.get "isDirty"]

    val is_closed : t -> bool [@@js.get "isClosed"]

    val save : t -> bool Promise.t [@@js.call "save"]

    val eol : t -> End_of_line.t [@@js.get "eol"]

    val line_count : t -> int [@@js.get "lineCount"]

    val line_at : t -> int -> Text_line.t [@@js.call "lineAt"]

    val line_at' : t -> Position.t -> Text_line.t [@@js.call "lineAt"]

    val offset_at : t -> Position.t -> int [@@js.call "offsetAt"]

    val position_at : t -> int -> Position.t [@@js.call "positionAt"]

    val get_text : t -> ?range:Range.t -> unit -> string [@@js.call "getText"]

    val get_word_range_at_position :
      t -> Position.t -> ?regex:regexp -> unit -> Range.t or_undefined
      [@@js.call "getWordRangeAtPosition"]

    val validate_range : t -> Range.t -> Range.t [@@js.call "validateRange"]

    val validate_position : t -> Position.t -> Position.t
      [@@js.call "validatePosition"]
  end
  [@@js.scope "TextDocument"]

  module Selection : sig
    include module type of struct
      include Range
    end

    val anchor : t -> Position.t [@@js.get "anchor"]

    val set_anchor : t -> Position.t -> unit [@@js.set "anchor"]

    val active : t -> Position.t [@@js.get "active"]

    val set_active : t -> Position.t -> unit [@@js.set "active"]

    val create : anchor:Position.t -> active:Position.t -> t [@@js.create]

    val create' :
         anchor_line:int
      -> anchor_character:int
      -> active_line:int
      -> active_character:int
      -> t
      [@@js.create]

    val is_reversed : t -> bool [@@js.get "isReversed"]

    val set_is_reversed : t -> bool -> unit [@@js.set "isReversed"]
  end
  [@@js.scope "Selection"]

  module Text_editor_cursor_style : sig
    type t =
      ([ `Line [@js 1]
       | `Block [@js 2]
       | `Underline [@js 3]
       | `LineThin [@js 4]
       | `BlockOutline [@js 5]
       | `UnderlineThin [@js 6]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Text_editor_line_numbers_style : sig
    type t =
      ([ `Off [@js 0]
       | `On [@js 1]
       | `Relative [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Text_editor_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val tab_size : t -> string or_number [@@js.get "tabSize"]

    val set_tab_size : t -> string or_number -> unit [@@js.set "tabSize"]

    val insert_spaces : t -> bool or_string [@@js.get "insertSpaces"]

    val set_insert_spaces : t -> bool or_string -> unit
      [@@js.set "insertSpaces"]

    val cursor_style : t -> Text_editor_cursor_style.t [@@js.get "cursorStyle"]

    val set_cursor_style : t -> Text_editor_cursor_style.t -> unit
      [@@js.set "cursorStyle"]

    val line_numbers : t -> Text_editor_line_numbers_style.t
      [@@js.get "lineNumbers"]

    val set_line_numbers : t -> Text_editor_line_numbers_style.t -> unit
      [@@js.set "lineNumbers"]

    val create :
         ?tab_size:string or_number
      -> ?insert_spaces:bool or_string
      -> ?cursor_style:Text_editor_cursor_style.t
      -> ?line_numbers:Text_editor_line_numbers_style.t
      -> unit
      -> t
      [@@js.builder]
  end
  [@@js.scope "TextEditorOptions"]

  module Text_editor_decoration_type : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val key : t -> string [@@js.get "key"]

    val dispose : t -> unit [@@js.call "dispose"]

    val create : key:string -> dispose:(unit -> unit) -> t [@@js.builder]
  end
  [@@js.scope "TextEditorDecorationType"]

  module Text_editor_reveal_type : sig
    type t =
      ([ `Default [@js 0]
       | `InCenter [@js 1]
       | `InCenterIfOutsideViewport [@js 2]
       | `AtTop [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Text_editor_selection_change_kind : sig
    type t =
      ([ `Keyboard [@js 1]
       | `Mouse [@js 2]
       | `Command [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Text_editor_edit : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    type replace_location =
      ([ `Position of Position.t
       | `Range of Range.t
       | `Selection of Selection.t
       ]
      [@js.union])

    [@@@js.implem
    let replace_location_of_js js_val =
      if Ojs.has_property js_val "anchor" then
        `Position ([%js.to: Position.t] js_val)
      else if Ojs.has_property js_val "start" then
        `Range ([%js.to: Range.t] js_val)
      else
        `Selection ([%js.to: Selection.t] js_val)]

    type delete_location =
      ([ `Range of Range.t
       | `Selection of Selection.t
       ]
      [@js.union])

    [@@@js.implem
    let delete_location_of_js js_val =
      if Ojs.has_property js_val "anchor" then
        `Selection ([%js.to: Selection.t] js_val)
      else
        `Range ([%js.to: Range.t] js_val)]

    val replace : t -> location:replace_location -> value:string -> unit
      [@@js.call "replace"]

    val insert : t -> location:Position.t -> value:string -> unit
      [@@js.call "insert"]

    val delete : t -> delete_location -> unit [@@js.call "delete"]

    val set_end_of_line : t -> End_of_line.t -> unit [@@js.call "setEndOfLine"]

    val create :
         replace:(location:replace_location -> value:string -> unit)
      -> insert:(location:Position.t -> value:string -> unit)
      -> delete:(location:delete_location -> unit)
      -> set_end_of_line:(end_of_line:End_of_line.t -> t)
      -> t
      [@@js.builder]
  end
  [@@js.scope "TextEditorEdit"]

  module View_column : sig
    type t =
      ([ `Active [@js -1]
       | `Beside [@js -2]
       | `One [@js 1]
       | `Two [@js 2]
       | `Three [@js 3]
       | `Four [@js 4]
       | `Five [@js 5]
       | `Six [@js 6]
       | `Seven [@js 7]
       | `Eight [@js 8]
       | `Nine [@js 9]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Snippet_string : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val value : t -> string [@@js.get "value"]

    val set_value : t -> string -> unit [@@js.set "value"]

    val create : ?value:string -> unit -> t [@@js.create]

    val append_text : t -> string -> t [@@js.call "appendText"]

    val append_tabstop : t -> ?number:int -> unit -> t
      [@@js.call "appendTabstop"]

    val append_placeholder : t -> string -> ?number:int -> unit -> t
      [@@js.call "appendPlaceholder"]

    val append_choice : t -> string list -> ?number:int -> unit -> t
      [@@js.call "appendChoice"]

    val append_variable : t -> string -> default:string -> t
      [@@js.call "appendVariable"]
  end
  [@@js.scope "SnippetString"]

  module Theme_color : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : string -> t [@@js.create]
  end
  [@@js.scope "ThemeColor"]

  module Theme_icon : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val file : unit -> t [@@js.get "File"]

    val folder : unit -> t [@@js.get "Folder"]

    val id : t -> string [@@js.get "id"]

    val color : t -> Theme_color.t [@@js.get "color"]

    val create : string -> ?color:Theme_color.t -> unit -> t [@@js.create]
  end
  [@@js.scope "ThemeIcon"]

  module Themable_decoration_attachment_render_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val content_text : t -> string [@@js.get "contentText"]

    val set_content_text : t -> string -> unit [@@js.set "contentText"]

    val content_icon_path : t -> Uri.t or_string [@@js.get "contentIconPath"]

    val set_content_icon_path : t -> Uri.t or_string -> unit
      [@@js.set "contentIconPath"]

    val border : t -> string [@@js.get "border"]

    val set_border : t -> string -> unit [@@js.set "border"]

    val border_color : t -> Theme_color.t or_string [@@js.get "borderColor"]

    val set_border_color : t -> Theme_color.t or_string -> unit
      [@@js.set "borderColor"]

    val font_style : t -> string [@@js.get "fontStyle"]

    val set_font_style : t -> string -> unit [@@js.set "fontStyle"]

    val font_weight : t -> string [@@js.get "fontWeight"]

    val set_font_weight : t -> string -> unit [@@js.set "fontWeight"]

    val text_decoration : t -> string [@@js.get "textDecoration"]

    val set_text_decoration : t -> string -> unit [@@js.set "textDecoration"]

    val color : t -> Theme_color.t or_string [@@js.get "color"]

    val set_color : t -> Theme_color.t or_string -> unit [@@js.set "color"]

    val background_color : t -> Theme_color.t or_string
      [@@js.get "backgroundColor"]

    val set_background_color : t -> Theme_color.t or_string -> unit
      [@@js.set "backgroundColor"]

    val margin : t -> string [@@js.get "margin"]

    val set_margin : t -> string -> unit [@@js.set "margin"]

    val width : t -> string [@@js.get "width"]

    val set_width : t -> string -> unit [@@js.set "width"]

    val height : t -> string [@@js.get "height"]

    val set_height : t -> string -> unit [@@js.set "height"]
  end
  [@@js.scope "ThemableDecorationAttachmentRenderOptions"]

  module Themable_decoration_render_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val background_color : t -> Theme_color.t or_string
      [@@js.get "backgroundColor"]

    val set_background_color : t -> Theme_color.t or_string -> unit
      [@@js.set "backgroundColor"]

    val outline : t -> string [@@js.get "outline"]

    val set_outline : t -> string -> unit [@@js.set "outline"]

    val outline_color : t -> Theme_color.t or_string [@@js.get "outlineColor"]

    val set_outline_color : t -> Theme_color.t or_string -> unit
      [@@js.set "outlineColor"]

    val outline_style : t -> string [@@js.get "outlineStyle"]

    val set_outline_style : t -> string -> unit [@@js.set "outlineStyle"]

    val outline_width : t -> string [@@js.get "outlineWidth"]

    val set_outline_width : t -> string -> unit [@@js.set "outlineWidth"]

    val border : t -> string [@@js.get "border"]

    val set_border : t -> string -> unit [@@js.set "border"]

    val border_color : t -> Theme_color.t or_string [@@js.get "borderColor"]

    val set_border_color : t -> Theme_color.t or_string -> unit
      [@@js.set "borderColor"]

    val border_radius : t -> string [@@js.get "borderRadius"]

    val set_border_radius : t -> string -> unit [@@js.set "borderRadius"]

    val border_spacing : t -> string [@@js.get "borderSpacing"]

    val set_border_spacing : t -> string -> unit [@@js.set "borderSpacing"]

    val border_style : t -> string [@@js.get "borderStyle"]

    val set_border_style : t -> string -> unit [@@js.set "borderStyle"]

    val border_width : t -> string [@@js.get "borderWidth"]

    val set_border_width : t -> string -> unit [@@js.set "borderWidth"]

    val font_style : t -> string [@@js.get "fontStyle"]

    val set_font_style : t -> string -> unit [@@js.set "fontStyle"]

    val font_weight : t -> string [@@js.get "fontWeight"]

    val set_font_weight : t -> string -> unit [@@js.set "fontWeight"]

    val text_decoration : t -> string [@@js.get "textDecoration"]

    val set_text_decoration : t -> string -> unit [@@js.set "textDecoration"]

    val cursor : t -> string [@@js.get "cursor"]

    val set_cursor : t -> string -> unit [@@js.set "cursor"]

    val color : t -> Theme_color.t or_string [@@js.get "color"]

    val set_color : t -> Theme_color.t or_string -> unit [@@js.set "color"]

    val opacity : t -> string [@@js.get "opacity"]

    val set_opacity : t -> string -> unit [@@js.set "opacity"]

    val letter_spacing : t -> string [@@js.get "letterSpacing"]

    val set_letter_spacing : t -> string -> unit [@@js.set "letterSpacing"]

    val gutter_icon_path : t -> Uri.t or_string [@@js.get "gutterIconPath"]

    val set_gutter_icon_path : t -> Uri.t or_string -> unit
      [@@js.set "gutterIconPath"]

    val gutter_icon_size : t -> string [@@js.get "gutterIconSize"]

    val set_gutter_icon_size : t -> string -> unit [@@js.set "gutterIconSize"]

    val overview_ruler_color : t -> Theme_color.t or_string
      [@@js.get "overviewRulerColor"]

    val set_overview_ruler_color : t -> Theme_color.t or_string -> unit
      [@@js.set "overviewRulerColor"]

    val before : t -> Themable_decoration_attachment_render_options.t
      [@@js.get "before"]

    val set_before :
      t -> Themable_decoration_attachment_render_options.t -> unit
      [@@js.set "before"]

    val after : t -> Themable_decoration_attachment_render_options.t
      [@@js.get "after"]

    val set_after : t -> Themable_decoration_attachment_render_options.t -> unit
      [@@js.set "after"]
  end
  [@@js.scope "ThemableDecorationRenderOptions"]

  module Overview_ruler_lane : sig
    type t =
      ([ `Left [@js 1]
       | `Center [@js 2]
       | `Right [@js 4]
       | `Full [@js 7]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Decoration_range_behavior : sig
    type t =
      ([ `OpenOpen [@js 0]
       | `ClosedClosed [@js 1]
       | `OpenClosed [@js 2]
       | `ClosedOpen [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Decoration_render_options : sig
    include module type of struct
      include Themable_decoration_render_options
    end

    val is_whole_line : t -> bool [@@js.get "isWholeLine"]

    val set_is_whole_line : t -> bool -> unit [@@js.set "isWholeLine"]

    val range_behavior : t -> Decoration_range_behavior.t
      [@@js.get "rangeBehavior"]

    val set_range_behavior : t -> Decoration_range_behavior.t -> unit
      [@@js.set "rangeBehavior"]

    val overview_ruler_lane : t -> Overview_ruler_lane.t
      [@@js.get "overviewRulerLane"]

    val set_overview_ruler_lane : t -> Overview_ruler_lane.t -> unit
      [@@js.set "overviewRulerLane"]

    val light : t -> Themable_decoration_render_options.t [@@js.get "light"]

    val set_light : t -> Themable_decoration_render_options.t -> unit
      [@@js.set "light"]

    val dark : t -> Themable_decoration_render_options.t [@@js.get "dark"]

    val set_dark : t -> Themable_decoration_render_options.t -> unit
      [@@js.set "dark"]
  end
  [@@js.scope "DecorationRenderOptions"]

  module Themable_decoration_instance_render_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val before : t -> Themable_decoration_attachment_render_options.t
      [@@js.get "before"]

    val set_before :
      t -> Themable_decoration_attachment_render_options.t -> unit
      [@@js.set "before"]

    val after : t -> Themable_decoration_attachment_render_options.t
      [@@js.get "after"]

    val set_after : t -> Themable_decoration_attachment_render_options.t -> unit
      [@@js.set "after"]
  end
  [@@js.scope "ThemableDecorationInstanceRenderOptions"]

  module Decoration_instance_render_options : sig
    include module type of struct
      include Themable_decoration_instance_render_options
    end

    val light : t -> Themable_decoration_instance_render_options.t
      [@@js.get "light"]

    val set_light : t -> Themable_decoration_instance_render_options.t -> unit
      [@@js.set "light"]

    val dark : t -> Themable_decoration_instance_render_options.t
      [@@js.get "dark"]

    val set_dark : t -> Themable_decoration_instance_render_options.t -> unit
      [@@js.set "dark"]
  end
  [@@js.scope "DecorationInstanceRenderOptions"]

  module Marked_string : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Decoration_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val hover_message : t -> (Marked_string.t, Marked_string.t) or_array
      [@@js.get "hoverMessage"]

    val set_hover_message :
      t -> (Marked_string.t, Marked_string.t) or_array -> unit
      [@@js.set "hoverMessage"]

    val render_options : t -> Decoration_instance_render_options.t
      [@@js.get "renderOptions"]

    val set_render_options : t -> Decoration_instance_render_options.t -> unit
      [@@js.set "renderOptions"]
  end
  [@@js.scope "DecorationOptions"]

  module Text_editor : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val document : t -> Text_document.t [@@js.get "document"]

    val selection : t -> Selection.t [@@js.get "selection"]

    val set_selection : t -> Selection.t -> unit [@@js.set "selection"]

    val selections : t -> Selection.t list [@@js.get "selections"]

    val set_selections : t -> Selection.t list -> unit [@@js.set "selections"]

    val visible_ranges : t -> Range.t list [@@js.get "visibleRanges"]

    val options : t -> Text_editor_options.t [@@js.get "options"]

    val set_options : t -> Text_editor_options.t -> unit [@@js.set "options"]

    val view_column : t -> View_column.t [@@js.get "viewColumn"]

    module Edit_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val undo_stop_before : t -> bool [@@js.get "undoStopBefore"]

      val set_undo_stop_before : t -> bool -> unit [@@js.set "undoStopBefore"]

      val undo_stop_after : t -> bool [@@js.get "undoStopAfter"]

      val set_undo_stop_after : t -> bool -> unit [@@js.set "undoStopAfter"]
    end

    val edit :
         t
      -> (Text_editor_edit.t -> unit)
      -> ?options:Edit_options.t
      -> unit
      -> bool Promise.t
      [@@js.call "edit"]

    val insert_snippet :
         t
      -> Snippet_string.t
      -> ?location:(Position.t, Range.t, Position.t list, Range.t list) union4
      -> ?options:Edit_options.t
      -> unit
      -> bool Promise.t
      [@@js.call "insertSnippet"]

    val set_decorations :
         t
      -> Text_editor_decoration_type.t
      -> (Decoration_options.t, Range.t) union2 list
      -> unit
      [@@js.call "setDecorations"]

    val reveal_range :
      t -> Range.t -> ?reveal_type_:Text_editor_reveal_type.t -> unit -> unit
      [@@js.call "revealRange"]

    val show : t -> ?column:View_column.t -> unit -> unit [@@js.call "show"]

    val hide : t -> unit [@@js.call "hide"]
  end
  [@@js.scope "TextEditor"]

  module Text_editor_selection_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val text_editor : t -> Text_editor.t [@@js.get "textEditor"]

    val selections : t -> Selection.t list [@@js.get "selections"]

    val kind : t -> Text_editor_selection_change_kind.t [@@js.get "kind"]
  end
  [@@js.scope "TextEditorSelectionChangeEvent"]

  module Text_editor_visible_ranges_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val text_editor : t -> Text_editor.t [@@js.get "textEditor"]

    val visible_ranges : t -> Range.t list [@@js.get "visibleRanges"]
  end
  [@@js.scope "TextEditorVisibleRangesChangeEvent"]

  module Text_editor_options_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val text_editor : t -> Text_editor.t [@@js.get "textEditor"]

    val options : t -> Text_editor_options.t [@@js.get "options"]
  end
  [@@js.scope "TextEditorOptionsChangeEvent"]

  module Text_editor_view_column_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val text_editor : t -> Text_editor.t [@@js.get "textEditor"]

    val view_column : t -> View_column.t [@@js.get "viewColumn"]
  end
  [@@js.scope "TextEditorViewColumnChangeEvent"]

  module Text_document_show_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val view_column : t -> View_column.t [@@js.get "viewColumn"]

    val set_view_column : t -> View_column.t -> unit [@@js.set "viewColumn"]

    val preserve_focus : t -> bool [@@js.get "preserveFocus"]

    val set_preserve_focus : t -> bool -> unit [@@js.set "preserveFocus"]

    val preview : t -> bool [@@js.get "preview"]

    val set_preview : t -> bool -> unit [@@js.set "preview"]

    val selection : t -> Range.t [@@js.get "selection"]

    val set_selection : t -> Range.t -> unit [@@js.set "selection"]
  end
  [@@js.scope "TextDocumentShowOptions"]

  module Disposable : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val from : (t list[@js.variadic]) -> t [@@js.global "from"]

    val create : (unit -> unit) -> t [@@js.create]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "Disposable"]

  module Event : sig
    type 'T t =
         ('T -> unit)
      -> ?this_args:any
      -> ?disposables:Disposable.t list
      -> unit
      -> Disposable.t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
  end

  module Cancellation_token : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val is_cancellation_requested : t -> bool
      [@@js.get "isCancellationRequested"]

    val set_is_cancellation_requested : t -> bool -> unit
      [@@js.set "isCancellationRequested"]

    val on_cancellation_requested : t -> any Event.t
      [@@js.get "onCancellationRequested"]

    val set_on_cancellation_requested : t -> any Event.t -> unit
      [@@js.set "onCancellationRequested"]
  end
  [@@js.scope "CancellationToken"]

  module Cancellation_token_source : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val token : t -> Cancellation_token.t [@@js.get "token"]

    val set_token : t -> Cancellation_token.t -> unit [@@js.set "token"]

    val cancel : t -> unit [@@js.call "cancel"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "CancellationTokenSource"]

  module Cancellation_error : sig
    include module type of struct
      include Error
    end

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : unit -> t [@@js.create]
  end
  [@@js.scope "CancellationError"]

  module Event_emitter : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val event : 'T t -> 'T Event.t [@@js.get "event"]

    val set_event : 'T t -> 'T Event.t -> unit [@@js.set "event"]

    val fire : 'T t -> 'T -> unit [@@js.call "fire"]

    val dispose : 'T t -> unit [@@js.call "dispose"]

    val create : unit -> 'T t [@@js.new "EventEmitter"]
  end

  module File_system_watcher : sig
    include module type of struct
      include Disposable
    end

    val ignore_create_events : t -> bool [@@js.get "ignoreCreateEvents"]

    val set_ignore_create_events : t -> bool -> unit
      [@@js.set "ignoreCreateEvents"]

    val ignore_change_events : t -> bool [@@js.get "ignoreChangeEvents"]

    val set_ignore_change_events : t -> bool -> unit
      [@@js.set "ignoreChangeEvents"]

    val ignore_delete_events : t -> bool [@@js.get "ignoreDeleteEvents"]

    val set_ignore_delete_events : t -> bool -> unit
      [@@js.set "ignoreDeleteEvents"]

    val on_did_create : t -> Uri.t Event.t [@@js.get "onDidCreate"]

    val set_on_did_create : t -> Uri.t Event.t -> unit [@@js.set "onDidCreate"]

    val on_did_change : t -> Uri.t Event.t [@@js.get "onDidChange"]

    val set_on_did_change : t -> Uri.t Event.t -> unit [@@js.set "onDidChange"]

    val on_did_delete : t -> Uri.t Event.t [@@js.get "onDidDelete"]

    val set_on_did_delete : t -> Uri.t Event.t -> unit [@@js.set "onDidDelete"]
  end
  [@@js.scope "FileSystemWatcher"]

  module Provider_result : sig
    type 'T t =
      ([ `Value of 'T or_null_or_undefined
       | `Promise of 'T or_null_or_undefined Promise.t
       ]
      [@js.union])

    [@@@js.stop]

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    [@@@js.start]

    [@@@js.implem
    let t_to_js ml_to_js = function
      | `Value v -> or_undefined_to_js ml_to_js v
      | `Promise p -> Promise.t_to_js (or_undefined_to_js ml_to_js) p

    let t_of_js ml_of_js js_val =
      if Ojs.has_property js_val "then" then
        `Promise (Promise.t_of_js (or_undefined_of_js ml_of_js) js_val)
      else
        `Value (or_undefined_of_js ml_of_js js_val)]
  end

  module Text_document_content_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val on_did_change : t -> Uri.t Event.t [@@js.get "onDidChange"]

    val set_on_did_change : t -> Uri.t Event.t -> unit [@@js.set "onDidChange"]

    val provide_text_document_content :
      t -> uri:Uri.t -> token:Cancellation_token.t -> string Provider_result.t
      [@@js.call "provideTextDocumentContent"]
  end
  [@@js.scope "TextDocumentContentProvider"]

  module Quick_pick_item : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val description : t -> string [@@js.get "description"]

    val set_description : t -> string -> unit [@@js.set "description"]

    val detail : t -> string [@@js.get "detail"]

    val set_detail : t -> string -> unit [@@js.set "detail"]

    val picked : t -> bool [@@js.get "picked"]

    val set_picked : t -> bool -> unit [@@js.set "picked"]

    val always_show : t -> bool [@@js.get "alwaysShow"]

    val set_always_show : t -> bool -> unit [@@js.set "alwaysShow"]

    val create :
         label:string
      -> ?description:string
      -> ?detail:string
      -> ?picked:bool
      -> ?always_show:bool
      -> unit
      -> t
      [@@js.builder]
  end
  [@@js.scope "QuickPickItem"]

  module Quick_pick_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    [@@@js.stop]

    type on_did_select_item_args =
      [ `QuickPickItem of Quick_pick_item.t
      | `String of string
      ]

    val on_did_select_item_args_to_js : on_did_select_item_args -> Ojs.t

    val on_did_select_item_args_of_js : Ojs.t -> on_did_select_item_args

    [@@@js.start]

    [@@@js.implem
    type on_did_select_item_args =
      ([ `QuickPickItem of Quick_pick_item.t
       | `String of string
       ]
      [@js.union])
    [@@js]

    let on_did_select_item_args_of_js js_val =
      match Ojs.type_of js_val with
      | "string" -> `String ([%js.to: string] js_val)
      | _ -> `QuickPickItem ([%js.to: Quick_pick_item.t] js_val)]

    val match_on_description : t -> bool [@@js.get "matchOnDescription"]

    val set_match_on_description : t -> bool -> unit
      [@@js.set "matchOnDescription"]

    val match_on_detail : t -> bool [@@js.get "matchOnDetail"]

    val set_match_on_detail : t -> bool -> unit [@@js.set "matchOnDetail"]

    val place_holder : t -> string [@@js.get "placeHolder"]

    val set_place_holder : t -> string -> unit [@@js.set "placeHolder"]

    val ignore_focus_out : t -> bool [@@js.get "ignoreFocusOut"]

    val set_ignore_focus_out : t -> bool -> unit [@@js.set "ignoreFocusOut"]

    val can_pick_many : t -> bool [@@js.get "canPickMany"]

    val set_can_pick_many : t -> bool -> unit [@@js.set "canPickMany"]

    val on_did_select_item : t -> item:on_did_select_item_args -> any
      [@@js.call "onDidSelectItem"]

    val create :
         ?match_on_description:bool
      -> ?match_on_detail:bool
      -> ?place_holder:string
      -> ?ignore_focus_out:bool
      -> ?can_pick_many:bool
      -> ?on_did_select_item:(on_did_select_item_args -> unit)
      -> unit
      -> t
      [@@js.builder]
  end
  [@@js.scope "QuickPickOptions"]

  module Workspace_folder_pick_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val place_holder : t -> string [@@js.get "placeHolder"]

    val set_place_holder : t -> string -> unit [@@js.set "placeHolder"]

    val ignore_focus_out : t -> bool [@@js.get "ignoreFocusOut"]

    val set_ignore_focus_out : t -> bool -> unit [@@js.set "ignoreFocusOut"]
  end
  [@@js.scope "WorkspaceFolderPickOptions"]

  module Open_dialog_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val default_uri : t -> Uri.t [@@js.get "defaultUri"]

    val set_default_uri : t -> Uri.t -> unit [@@js.set "defaultUri"]

    val open_label : t -> string [@@js.get "openLabel"]

    val set_open_label : t -> string -> unit [@@js.set "openLabel"]

    val can_select_files : t -> bool [@@js.get "canSelectFiles"]

    val set_can_select_files : t -> bool -> unit [@@js.set "canSelectFiles"]

    val can_select_folders : t -> bool [@@js.get "canSelectFolders"]

    val set_can_select_folders : t -> bool -> unit [@@js.set "canSelectFolders"]

    val can_select_many : t -> bool [@@js.get "canSelectMany"]

    val set_can_select_many : t -> bool -> unit [@@js.set "canSelectMany"]

    module Filters : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get : t -> string -> string list [@@js.index_get]

      val set : t -> string -> string list -> unit [@@js.index_set]
    end

    val filters : t -> Filters.t [@@js.get "filters"]

    val set_filters : t -> Filters.t -> unit [@@js.set "filters"]

    val title : t -> string [@@js.get "title"]

    val set_title : t -> string -> unit [@@js.set "title"]
  end
  [@@js.scope "OpenDialogOptions"]

  module Save_dialog_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val default_uri : t -> Uri.t [@@js.get "defaultUri"]

    val set_default_uri : t -> Uri.t -> unit [@@js.set "defaultUri"]

    val save_label : t -> string [@@js.get "saveLabel"]

    val set_save_label : t -> string -> unit [@@js.set "saveLabel"]

    module Filters : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get : t -> string -> string list [@@js.index_get]

      val set : t -> string -> string list -> unit [@@js.index_set]
    end

    val filters : t -> Filters.t [@@js.get "filters"]

    val set_filters : t -> Filters.t -> unit [@@js.set "filters"]

    val title : t -> string [@@js.get "title"]

    val set_title : t -> string -> unit [@@js.set "title"]
  end
  [@@js.scope "SaveDialogOptions"]

  module Message_item : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val title : t -> string [@@js.get "title"]

    val set_title : t -> string -> unit [@@js.set "title"]

    val is_close_affordance : t -> bool [@@js.get "isCloseAffordance"]

    val set_is_close_affordance : t -> bool -> unit
      [@@js.set "isCloseAffordance"]
  end
  [@@js.scope "MessageItem"]

  module Message_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val modal : t -> bool [@@js.get "modal"]

    val set_modal : t -> bool -> unit [@@js.set "modal"]
  end
  [@@js.scope "MessageOptions"]

  module Input_box_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val value : t -> string [@@js.get "value"]

    val set_value : t -> string -> unit [@@js.set "value"]

    val value_selection : t -> int * int [@@js.get "valueSelection"]

    val set_value_selection : t -> int * int -> unit [@@js.set "valueSelection"]

    val prompt : t -> string [@@js.get "prompt"]

    val set_prompt : t -> string -> unit [@@js.set "prompt"]

    val place_holder : t -> string [@@js.get "placeHolder"]

    val set_place_holder : t -> string -> unit [@@js.set "placeHolder"]

    val password : t -> bool [@@js.get "password"]

    val set_password : t -> bool -> unit [@@js.set "password"]

    val ignore_focus_out : t -> bool [@@js.get "ignoreFocusOut"]

    val set_ignore_focus_out : t -> bool -> unit [@@js.set "ignoreFocusOut"]

    val validate_input :
         t
      -> value:string
      -> string or_null_or_undefined Promise.t or_string or_null_or_undefined
      [@@js.call "validateInput"]

    val create :
         ?value:string
      -> ?value_selection:int * int
      -> ?prompt:string
      -> ?place_holder:string
      -> ?password:bool
      -> ?ignore_focus_out:bool
      -> ?validate_input:(string -> string option Promise.t)
      -> unit
      -> t
      [@@js.builder]
  end
  [@@js.scope "InputBoxOptions"]

  module Workspace_folder : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val uri : t -> Uri.t [@@js.get "uri"]

    val name : t -> string [@@js.get "name"]

    val index : t -> int [@@js.get "index"]

    val create : uri:Uri.t -> name:string -> index:int -> t [@@js.builder]
  end
  [@@js.scope "WorkspaceFolder"]

  module Relative_pattern : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val base : t -> string [@@js.get "base"]

    val set_base : t -> string -> unit [@@js.set "base"]

    val pattern : t -> string [@@js.get "pattern"]

    val set_pattern : t -> string -> unit [@@js.set "pattern"]

    val create :
      base:(Uri.t, Workspace_folder.t) union2 or_string -> pattern:string -> t
      [@@js.create]
  end
  [@@js.scope "RelativePattern"]

  module Glob_pattern : sig
    [@@@js.stop]

    type t =
      [ `String of string
      | `RelativePattern of Relative_pattern.t
      ]

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    [@@@js.start]

    [@@@js.implem
    type t =
      ([ `String of string
       | `RelativePattern of Relative_pattern.t
       ]
      [@js.union])
    [@@js]

    let t_of_js js_val =
      match Ojs.type_of js_val with
      | "string" -> `String ([%js.to: string] js_val)
      | _ -> `RelativePattern ([%js.to: Relative_pattern.t] js_val)]
  end

  module Document_filter : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val language : t -> string [@@js.get "language"]

    val scheme : t -> string [@@js.get "scheme"]

    val pattern : t -> Glob_pattern.t [@@js.get "pattern"]

    val create :
      ?language:string -> ?scheme:string -> ?pattern:Glob_pattern.t -> unit -> t
      [@@js.builder]
  end
  [@@js.scope "DocumentFilter"]

  module Document_selector : sig
    [@@@js.stop]

    type selector =
      [ `Filter of Document_filter.t
      | `String of string
      ]

    type t =
      [ `Filter of Document_filter.t
      | `String of string
      | `List of selector list
      ]

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val selector_to_js : selector -> Ojs.t

    val selector_of_js : Ojs.t -> selector

    [@@@js.start]

    [@@@js.implem
    type selector =
      ([ `Filter of Document_filter.t
       | `String of string
       ]
      [@js.union])
    [@@js]

    let selector_of_js js_val =
      match Ojs.type_of js_val with
      | "string" -> `String ([%js.to: string] js_val)
      | _ -> `Filter ([%js.to: Document_filter.t] js_val)

    type t =
      ([ `Filter of Document_filter.t
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
        `Filter ([%js.to: Document_filter.t] js_val)]
  end

  module Location : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val uri : t -> Uri.t [@@js.get "uri"]

    val set_uri : t -> Uri.t -> unit [@@js.set "uri"]

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val create :
      uri:Uri.t -> range_or_position:(Position.t, Range.t) union2 -> t
      [@@js.create]
  end
  [@@js.scope "Location"]

  module Diagnostic_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val uris : t -> Uri.t list [@@js.get "uris"]
  end
  [@@js.scope "DiagnosticChangeEvent"]

  module Diagnostic_severity : sig
    type t =
      ([ `Error [@js 0]
       | `Warning [@js 1]
       | `Information [@js 2]
       | `Hint [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Diagnostic_related_information : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val location : t -> Location.t [@@js.get "location"]

    val set_location : t -> Location.t -> unit [@@js.set "location"]

    val message : t -> string [@@js.get "message"]

    val set_message : t -> string -> unit [@@js.set "message"]

    val create : location:Location.t -> message:string -> t [@@js.create]
  end
  [@@js.scope "DiagnosticRelatedInformation"]

  module Diagnostic_tag : sig
    type t =
      ([ `Unnecessary [@js 1]
       | `Deprecated [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Diagnostic : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val message : t -> string [@@js.get "message"]

    val set_message : t -> string -> unit [@@js.set "message"]

    val severity : t -> Diagnostic_severity.t [@@js.get "severity"]

    val set_severity : t -> Diagnostic_severity.t -> unit [@@js.set "severity"]

    val source : t -> string [@@js.get "source"]

    val set_source : t -> string -> unit [@@js.set "source"]

    module Code : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val value : t -> string or_number [@@js.get "value"]

      val set_value : t -> string or_number -> unit [@@js.set "value"]

      val target : t -> Uri.t [@@js.get "target"]

      val set_target : t -> Uri.t -> unit [@@js.set "target"]
    end

    val code : t -> Code.t or_string or_number [@@js.get "code"]

    val set_code : t -> Code.t or_string or_number -> unit [@@js.set "code"]

    val related_information : t -> Diagnostic_related_information.t list
      [@@js.get "relatedInformation"]

    val set_related_information :
      t -> Diagnostic_related_information.t list -> unit
      [@@js.set "relatedInformation"]

    val tags : t -> Diagnostic_tag.t list [@@js.get "tags"]

    val set_tags : t -> Diagnostic_tag.t list -> unit [@@js.set "tags"]

    val create :
         range:Range.t
      -> message:string
      -> ?severity:Diagnostic_severity.t
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "Diagnostic"]

  module Diagnostic_collection : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val name : t -> string [@@js.get "name"]

    val set :
      t -> uri:Uri.t -> diagnostics:Diagnostic.t list or_undefined -> unit
      [@@js.call "set"]

    val set' :
      t -> entries:(Uri.t * Diagnostic.t list or_undefined) list -> unit
      [@@js.call "set"]

    val delete : t -> uri:Uri.t -> unit [@@js.call "delete"]

    val clear : t -> unit [@@js.call "clear"]

    val for_each :
         t
      -> callback:
           (uri:Uri.t -> diagnostics:Diagnostic.t list -> collection:t -> any)
      -> ?this_arg:any
      -> unit
      -> unit
      [@@js.call "forEach"]

    val get : t -> uri:Uri.t -> Diagnostic.t list or_undefined [@@js.call "get"]

    val has : t -> uri:Uri.t -> bool [@@js.call "has"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "DiagnosticCollection"]

  module Code_action_kind : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val empty : unit -> t [@@js.get "Empty"]

    val quick_fix : unit -> t [@@js.get "QuickFix"]

    val refactor : unit -> t [@@js.get "Refactor"]

    val refactor_extract : unit -> t [@@js.get "RefactorExtract"]

    val refactor_inline : unit -> t [@@js.get "RefactorInline"]

    val refactor_rewrite : unit -> t [@@js.get "RefactorRewrite"]

    val source : unit -> t [@@js.get "Source"]

    val source_organize_imports : unit -> t [@@js.get "SourceOrganizeImports"]

    val source_fix_all : unit -> t [@@js.get "SourceFixAll"]

    val create : value:string -> t [@@js.create]

    val value : t -> string [@@js.get "value"]

    val append : t -> parts:string -> t [@@js.call "append"]

    val intersects : t -> other:t -> bool [@@js.call "intersects"]

    val contains : t -> other:t -> bool [@@js.call "contains"]
  end
  [@@js.scope "CodeActionKind"]

  module Code_action_trigger_kind : sig
    type t =
      ([ `Invoke [@js 1]
       | `Automatic [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Code_action_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val trigger_kind : t -> Code_action_trigger_kind.t [@@js.get "triggerKind"]

    val diagnostics : t -> Diagnostic.t list [@@js.get "diagnostics"]

    val only : t -> Code_action_kind.t [@@js.get "only"]
  end
  [@@js.scope "CodeActionContext"]

  module Code_lens : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val command : t -> Command.t [@@js.get "command"]

    val set_command : t -> Command.t -> unit [@@js.set "command"]

    val is_resolved : t -> bool [@@js.get "isResolved"]

    val create : range:Range.t -> ?command:Command.t -> unit -> t [@@js.create]
  end
  [@@js.scope "CodeLens"]

  module Code_lens_provider : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val on_did_change_code_lenses : 'T t -> unit Event.t
      [@@js.get "onDidChangeCodeLenses"]

    val set_on_did_change_code_lenses : 'T t -> unit Event.t -> unit
      [@@js.set "onDidChangeCodeLenses"]

    val provide_code_lenses :
         'T t
      -> document:Text_document.t
      -> token:Cancellation_token.t
      -> 'T list Provider_result.t
      [@@js.call "provideCodeLenses"]

    val resolve_code_lens :
      'T t -> code_lens:'T -> token:Cancellation_token.t -> 'T Provider_result.t
      [@@js.call "resolveCodeLens"]
  end
  [@@js.scope "CodeLensProvider"]

  module Definition_link : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Definition : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Definition_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_definition :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> token:Cancellation_token.t
      -> (Definition.t, Definition_link.t) or_array Provider_result.t
      [@@js.call "provideDefinition"]
  end
  [@@js.scope "DefinitionProvider"]

  module Implementation_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_implementation :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> token:Cancellation_token.t
      -> (Definition.t, Definition_link.t) or_array Provider_result.t
      [@@js.call "provideImplementation"]
  end
  [@@js.scope "ImplementationProvider"]

  module Type_definition_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_type_definition :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> token:Cancellation_token.t
      -> (Definition.t, Definition_link.t) or_array Provider_result.t
      [@@js.call "provideTypeDefinition"]
  end
  [@@js.scope "TypeDefinitionProvider"]

  module Declaration : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Declaration_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_declaration :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> token:Cancellation_token.t
      -> Declaration.t Provider_result.t
      [@@js.call "provideDeclaration"]
  end
  [@@js.scope "DeclarationProvider"]

  module Markdown_string : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val value : t -> string [@@js.get "value"]

    val set_value : t -> string -> unit [@@js.set "value"]

    val is_trusted : t -> bool [@@js.get "isTrusted"]

    val set_is_trusted : t -> bool -> unit [@@js.set "isTrusted"]

    val support_theme_icons : t -> bool [@@js.get "supportThemeIcons"]

    val create : ?value:string -> ?support_theme_icons:bool -> unit -> t
      [@@js.create]

    val append_text : t -> value:string -> t [@@js.call "appendText"]

    val append_markdown : t -> value:string -> t [@@js.call "appendMarkdown"]

    val append_codeblock : t -> value:string -> ?language:string -> unit -> t
      [@@js.call "appendCodeblock"]
  end
  [@@js.scope "MarkdownString"]

  module Hover : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val contents : t -> Marked_string.t list [@@js.get "contents"]

    val set_contents : t -> Marked_string.t list -> unit [@@js.set "contents"]

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val create :
         contents:(Marked_string.t, Marked_string.t) or_array
      -> ?range:Range.t
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "Hover"]

  module Hover_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_hover :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> token:Cancellation_token.t
      -> Hover.t Provider_result.t
      [@@js.call "provideHover"]
  end
  [@@js.scope "HoverProvider"]

  module Evaluatable_expression : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val range : t -> Range.t [@@js.get "range"]

    val expression : t -> string [@@js.get "expression"]

    val create : range:Range.t -> ?expression:string -> unit -> t [@@js.create]
  end
  [@@js.scope "EvaluatableExpression"]

  module Evaluatable_expression_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_evaluatable_expression :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> token:Cancellation_token.t
      -> Evaluatable_expression.t Provider_result.t
      [@@js.call "provideEvaluatableExpression"]
  end
  [@@js.scope "EvaluatableExpressionProvider"]

  module Inline_value_text : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val range : t -> Range.t [@@js.get "range"]

    val text : t -> string [@@js.get "text"]

    val create : range:Range.t -> text:string -> t [@@js.create]
  end
  [@@js.scope "InlineValueText"]

  module Inline_value_variable_lookup : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val range : t -> Range.t [@@js.get "range"]

    val variable_name : t -> string [@@js.get "variableName"]

    val case_sensitive_lookup : t -> bool [@@js.get "caseSensitiveLookup"]

    val create :
         range:Range.t
      -> ?variable_name:string
      -> ?case_sensitive_lookup:bool
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "InlineValueVariableLookup"]

  module Inline_value_evaluatable_expression : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val range : t -> Range.t [@@js.get "range"]

    val expression : t -> string [@@js.get "expression"]

    val create : range:Range.t -> ?expression:string -> unit -> t [@@js.create]
  end
  [@@js.scope "InlineValueEvaluatableExpression"]

  module Inline_value : sig
    type t =
      ( Inline_value_evaluatable_expression.t
      , Inline_value_text.t
      , Inline_value_variable_lookup.t )
      union3

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Inline_value_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val frame_id : t -> int [@@js.get "frameId"]

    val stopped_location : t -> Range.t [@@js.get "stoppedLocation"]
  end
  [@@js.scope "InlineValueContext"]

  module Inline_values_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val on_did_change_inline_values : t -> unit Event.t or_undefined
      [@@js.get "onDidChangeInlineValues"]

    val set_on_did_change_inline_values : t -> unit Event.t or_undefined -> unit
      [@@js.set "onDidChangeInlineValues"]

    val provide_inline_values :
         t
      -> document:Text_document.t
      -> view_port:Range.t
      -> context:Inline_value_context.t
      -> token:Cancellation_token.t
      -> Inline_value.t list Provider_result.t
      [@@js.call "provideInlineValues"]
  end
  [@@js.scope "InlineValuesProvider"]

  module Document_highlight_kind : sig
    type t =
      ([ `Text [@js 0]
       | `Read [@js 1]
       | `Write [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Document_highlight : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val kind : t -> Document_highlight_kind.t [@@js.get "kind"]

    val set_kind : t -> Document_highlight_kind.t -> unit [@@js.set "kind"]

    val create : range:Range.t -> ?kind:Document_highlight_kind.t -> unit -> t
      [@@js.create]
  end
  [@@js.scope "DocumentHighlight"]

  module Document_highlight_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_document_highlights :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> token:Cancellation_token.t
      -> Document_highlight.t list Provider_result.t
      [@@js.call "provideDocumentHighlights"]
  end
  [@@js.scope "DocumentHighlightProvider"]

  module Symbol_kind : sig
    type t =
      ([ `File [@js 0]
       | `Module [@js 1]
       | `Namespace [@js 2]
       | `Package [@js 3]
       | `Class [@js 4]
       | `Method [@js 5]
       | `Property [@js 6]
       | `Field [@js 7]
       | `Constructor [@js 8]
       | `Enum [@js 9]
       | `Interface [@js 10]
       | `Function [@js 11]
       | `Variable [@js 12]
       | `Constant [@js 13]
       | `String [@js 14]
       | `Number [@js 15]
       | `Boolean [@js 16]
       | `Array [@js 17]
       | `Object [@js 18]
       | `Key [@js 19]
       | `Null [@js 20]
       | `EnumMember [@js 21]
       | `Struct [@js 22]
       | `Event [@js 23]
       | `Operator [@js 24]
       | `TypeParameter [@js 25]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Symbol_tag : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Symbol_information : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val container_name : t -> string [@@js.get "containerName"]

    val set_container_name : t -> string -> unit [@@js.set "containerName"]

    val kind : t -> Symbol_kind.t [@@js.get "kind"]

    val set_kind : t -> Symbol_kind.t -> unit [@@js.set "kind"]

    val tags : t -> Symbol_tag.t list [@@js.get "tags"]

    val set_tags : t -> Symbol_tag.t list -> unit [@@js.set "tags"]

    val location : t -> Location.t [@@js.get "location"]

    val set_location : t -> Location.t -> unit [@@js.set "location"]

    val create :
         name:string
      -> kind:Symbol_kind.t
      -> container_name:string
      -> location:Location.t
      -> t
      [@@js.create]

    val create' :
         name:string
      -> kind:Symbol_kind.t
      -> range:Range.t
      -> ?uri:Uri.t
      -> ?container_name:string
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "SymbolInformation"]

  module Document_symbol : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val detail : t -> string [@@js.get "detail"]

    val set_detail : t -> string -> unit [@@js.set "detail"]

    val kind : t -> Symbol_kind.t [@@js.get "kind"]

    val set_kind : t -> Symbol_kind.t -> unit [@@js.set "kind"]

    val tags : t -> Symbol_tag.t list [@@js.get "tags"]

    val set_tags : t -> Symbol_tag.t list -> unit [@@js.set "tags"]

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val selection_range : t -> Range.t [@@js.get "selectionRange"]

    val set_selection_range : t -> Range.t -> unit [@@js.set "selectionRange"]

    val children : t -> t list [@@js.get "children"]

    val set_children : t -> t list -> unit [@@js.set "children"]

    val create :
         name:string
      -> detail:string
      -> kind:Symbol_kind.t
      -> range:Range.t
      -> selection_range:Range.t
      -> t
      [@@js.create]
  end
  [@@js.scope "DocumentSymbol"]

  module Document_symbol_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_document_symbols :
         t
      -> document:Text_document.t
      -> token:Cancellation_token.t
      -> ([ `U_n_0 of (Document_symbol.t, Symbol_information.t) union2 [@js 0]
          | `U_n_1 of (Document_symbol.t, Symbol_information.t) union2 [@js 1]
          | `U_n_2 of (Document_symbol.t, Symbol_information.t) union2 [@js 2]
          | `U_n_3 of (Document_symbol.t, Symbol_information.t) union2 [@js 3]
          | `U_n_4 of (Document_symbol.t, Symbol_information.t) union2 [@js 4]
          | `U_n_5 of (Document_symbol.t, Symbol_information.t) union2 [@js 5]
          | `U_n_6 of (Document_symbol.t, Symbol_information.t) union2 [@js 6]
          | `U_n_7 of (Document_symbol.t, Symbol_information.t) union2 [@js 7]
          | `U_n_8 of (Document_symbol.t, Symbol_information.t) union2 [@js 8]
          | `U_n_9 of (Document_symbol.t, Symbol_information.t) union2 [@js 9]
          | `U_n_10 of (Document_symbol.t, Symbol_information.t) union2 [@js 10]
          | `U_n_11 of (Document_symbol.t, Symbol_information.t) union2 [@js 11]
          | `U_n_12 of (Document_symbol.t, Symbol_information.t) union2 [@js 12]
          | `U_n_13 of (Document_symbol.t, Symbol_information.t) union2 [@js 13]
          | `U_n_14 of (Document_symbol.t, Symbol_information.t) union2 [@js 14]
          | `U_n_15 of (Document_symbol.t, Symbol_information.t) union2 [@js 15]
          | `U_n_16 of (Document_symbol.t, Symbol_information.t) union2 [@js 16]
          | `U_n_17 of (Document_symbol.t, Symbol_information.t) union2 [@js 17]
          | `U_n_18 of (Document_symbol.t, Symbol_information.t) union2 [@js 18]
          | `U_n_19 of (Document_symbol.t, Symbol_information.t) union2 [@js 19]
          | `U_n_20 of (Document_symbol.t, Symbol_information.t) union2 [@js 20]
          | `U_n_21 of (Document_symbol.t, Symbol_information.t) union2 [@js 21]
          | `U_n_22 of (Document_symbol.t, Symbol_information.t) union2 [@js 22]
          | `U_n_23 of (Document_symbol.t, Symbol_information.t) union2 [@js 23]
          | `U_n_24 of (Document_symbol.t, Symbol_information.t) union2 [@js 24]
          | `U_n_25 of (Document_symbol.t, Symbol_information.t) union2 [@js 25]
          ]
         [@js.union on_field "kind"])
         list
         Provider_result.t
      [@@js.call "provideDocumentSymbols"]
  end
  [@@js.scope "DocumentSymbolProvider"]

  module Document_symbol_provider_metadata : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]
  end
  [@@js.scope "DocumentSymbolProviderMetadata"]

  module Workspace_symbol_provider : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val provide_workspace_symbols :
         'T t
      -> query:string
      -> token:Cancellation_token.t
      -> 'T list Provider_result.t
      [@@js.call "provideWorkspaceSymbols"]

    val resolve_workspace_symbol :
      'T t -> symbol:'T -> token:Cancellation_token.t -> 'T Provider_result.t
      [@@js.call "resolveWorkspaceSymbol"]
  end
  [@@js.scope "WorkspaceSymbolProvider"]

  module Reference_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val include_declaration : t -> bool [@@js.get "includeDeclaration"]

    val set_include_declaration : t -> bool -> unit
      [@@js.set "includeDeclaration"]
  end
  [@@js.scope "ReferenceContext"]

  module Reference_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_references :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> context:Reference_context.t
      -> token:Cancellation_token.t
      -> Location.t list Provider_result.t
      [@@js.call "provideReferences"]
  end
  [@@js.scope "ReferenceProvider"]

  module Text_edit : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val replace : range:Range.t -> new_text:string -> t [@@js.global "replace"]

    val insert : position:Position.t -> new_text:string -> t
      [@@js.global "insert"]

    val delete : range:Range.t -> t [@@js.global "delete"]

    val set_end_of_line : eol:End_of_line.t -> t [@@js.global "setEndOfLine"]

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val new_text : t -> string [@@js.get "newText"]

    val set_new_text : t -> string -> unit [@@js.set "newText"]

    val new_eol : t -> End_of_line.t [@@js.get "newEol"]

    val set_new_eol : t -> End_of_line.t -> unit [@@js.set "newEol"]

    val create : range:Range.t -> new_text:string -> t [@@js.create]
  end
  [@@js.scope "TextEdit"]

  module Icon_path : sig
    type t =
      { light : ([ `String of string | `Uri of Uri.t ][@js.union])
      ; dark : ([ `String of string | `Uri of Uri.t ][@js.union])
      }

    [@@@js.stop]

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    [@@@js.start]

    [@@@js.implem
    let t_of_js js_val =
      let light_js = Ojs.get_prop_ascii js_val "light" in
      let dark_js = Ojs.get_prop_ascii js_val "dark" in
      let light =
        if Ojs.has_property light_js "parse" then
          `Uri ([%js.to: Uri.t] light_js)
        else
          `String ([%js.to: string] light_js)
      in
      let dark =
        if Ojs.has_property dark_js "parse" then
          `Uri ([%js.to: Uri.t] dark_js)
        else
          `String ([%js.to: string] dark_js)
      in
      { light; dark }]
  end

  module Workspace_edit_entry_metadata : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val needs_confirmation : t -> bool [@@js.get "needsConfirmation"]

    val set_needs_confirmation : t -> bool -> unit
      [@@js.set "needsConfirmation"]

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val description : t -> string [@@js.get "description"]

    val set_description : t -> string -> unit [@@js.set "description"]

    val icon_path : t -> (Theme_icon.t, Uri.t, Icon_path.t) union3
      [@@js.get "iconPath"]

    val set_icon_path : t -> (Theme_icon.t, Uri.t, Icon_path.t) union3 -> unit
      [@@js.set "iconPath"]
  end
  [@@js.scope "WorkspaceEditEntryMetadata"]

  module Workspace_edit : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val size : t -> int [@@js.get "size"]

    val replace :
         t
      -> uri:Uri.t
      -> range:Range.t
      -> new_text:string
      -> ?metadata:Workspace_edit_entry_metadata.t
      -> unit
      -> unit
      [@@js.call "replace"]

    val insert :
         t
      -> uri:Uri.t
      -> position:Position.t
      -> new_text:string
      -> ?metadata:Workspace_edit_entry_metadata.t
      -> unit
      -> unit
      [@@js.call "insert"]

    val delete :
         t
      -> uri:Uri.t
      -> range:Range.t
      -> ?metadata:Workspace_edit_entry_metadata.t
      -> unit
      -> unit
      [@@js.call "delete"]

    val has : t -> uri:Uri.t -> bool [@@js.call "has"]

    val set_ : t -> uri:Uri.t -> edits:Text_edit.t list -> unit
      [@@js.call "set"]

    val get : t -> uri:Uri.t -> Text_edit.t list [@@js.call "get"]

    module Create_file_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val overwrite : t -> bool [@@js.get "overwrite"]

      val set_overwrite : t -> bool -> unit [@@js.set "overwrite"]

      val ignore_if_exists : t -> bool [@@js.get "ignoreIfExists"]

      val set_ignore_if_exists : t -> bool -> unit [@@js.set "ignoreIfExists"]
    end

    module Delete_file_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val recursive : t -> bool [@@js.get "recursive"]

      val set_recursive : t -> bool -> unit [@@js.set "recursive"]

      val ignore_if_not_exists : t -> bool [@@js.get "ignoreIfNotExists"]

      val set_ignore_if_not_exists : t -> bool -> unit
        [@@js.set "ignoreIfNotExists"]
    end

    val create_file :
         t
      -> uri:Uri.t
      -> ?options:Create_file_options.t
      -> ?metadata:Workspace_edit_entry_metadata.t
      -> unit
      -> unit
      [@@js.call "createFile"]

    val delete_file :
         t
      -> uri:Uri.t
      -> ?options:Delete_file_options.t
      -> ?metadata:Workspace_edit_entry_metadata.t
      -> unit
      -> unit
      [@@js.call "deleteFile"]

    val rename_file :
         t
      -> old_uri:Uri.t
      -> new_uri:Uri.t
      -> ?options:Create_file_options.t
      -> ?metadata:Workspace_edit_entry_metadata.t
      -> unit
      -> unit
      [@@js.call "renameFile"]

    val entries : t -> (Uri.t * Text_edit.t list) list [@@js.call "entries"]
  end
  [@@js.scope "WorkspaceEdit"]

  module Code_action : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    module Disabled : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val reason : t -> string [@@js.get "reason"]
    end

    val title : t -> string [@@js.get "title"]

    val set_title : t -> string -> unit [@@js.set "title"]

    val edit : t -> Workspace_edit.t [@@js.get "edit"]

    val set_edit : t -> Workspace_edit.t -> unit [@@js.set "edit"]

    val diagnostics : t -> Diagnostic.t list [@@js.get "diagnostics"]

    val set_diagnostics : t -> Diagnostic.t list -> unit
      [@@js.set "diagnostics"]

    val command : t -> Command.t [@@js.get "command"]

    val set_command : t -> Command.t -> unit [@@js.set "command"]

    val kind : t -> Code_action_kind.t [@@js.get "kind"]

    val set_kind : t -> Code_action_kind.t -> unit [@@js.set "kind"]

    val is_preferred : t -> bool [@@js.get "isPreferred"]

    val set_is_preferred : t -> bool -> unit [@@js.set "isPreferred"]

    val disabled : t -> Disabled.t [@@js.get "disabled"]

    val set_disabled : t -> Disabled.t -> unit [@@js.set "disabled"]

    val create : title:string -> ?kind:Code_action_kind.t -> unit -> t
      [@@js.create]
  end
  [@@js.scope "CodeAction"]

  module Code_action_provider : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val provide_code_actions :
         'T t
      -> document:Text_document.t
      -> range:(Range.t, Selection.t) union2
      -> context:Code_action_context.t
      -> token:Cancellation_token.t
      -> (Command.t, 'T) union2 list Provider_result.t
      [@@js.call "provideCodeActions"]

    val resolve_code_action :
         'T t
      -> code_action:'T
      -> token:Cancellation_token.t
      -> 'T Provider_result.t
      [@@js.call "resolveCodeAction"]
  end
  [@@js.scope "CodeActionProvider"]

  module Code_action_provider_metadata : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provided_code_action_kinds : t -> Code_action_kind.t list
      [@@js.get "providedCodeActionKinds"]

    module Documentation : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val kind : t -> Code_action_kind.t [@@js.get "kind"]

      val command : t -> Command.t [@@js.get "command"]
    end

    val documentation : t -> Documentation.t list [@@js.get "documentation"]
  end
  [@@js.scope "CodeActionProviderMetadata"]

  module Rename_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_rename_edits :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> new_name:string
      -> token:Cancellation_token.t
      -> Workspace_edit.t Provider_result.t
      [@@js.call "provideRenameEdits"]

    module Range_with_place_holder : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val range : t -> Range.t [@@js.get "range"]

      val set_range : t -> Range.t -> unit [@@js.set "range"]

      val placeholder : t -> string [@@js.get "placeholder"]

      val set_placeholder : t -> string -> unit [@@js.set "placeholder"]
    end

    val prepare_rename :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> token:Cancellation_token.t
      -> (Range.t, Range_with_place_holder.t) union2 Provider_result.t
      [@@js.call "prepareRename"]
  end
  [@@js.scope "RenameProvider"]

  module Semantic_tokens_legend : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val token_types : t -> string list [@@js.get "tokenTypes"]

    val token_modifiers : t -> string list [@@js.get "tokenModifiers"]

    val create :
      token_types:string list -> ?token_modifiers:string list -> unit -> t
      [@@js.create]
  end
  [@@js.scope "SemanticTokensLegend"]

  module Semantic_tokens : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val result_id : t -> string [@@js.get "resultId"]

    val data : t -> Uint32_array.t [@@js.get "data"]

    val create : data:Uint32_array.t -> ?result_id:string -> unit -> t
      [@@js.create]
  end
  [@@js.scope "SemanticTokens"]

  module Semantic_tokens_edit : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val start : t -> int [@@js.get "start"]

    val delete_count : t -> int [@@js.get "deleteCount"]

    val data : t -> Uint32_array.t [@@js.get "data"]

    val create :
      start:int -> delete_count:int -> ?data:Uint32_array.t -> unit -> t
      [@@js.create]
  end
  [@@js.scope "SemanticTokensEdit"]

  module Semantic_tokens_edits : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val result_id : t -> string [@@js.get "resultId"]

    val edits : t -> Semantic_tokens_edit.t list [@@js.get "edits"]

    val create :
      edits:Semantic_tokens_edit.t list -> ?result_id:string -> unit -> t
      [@@js.create]
  end
  [@@js.scope "SemanticTokensEdits"]

  module Semantic_tokens_builder : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : ?legend:Semantic_tokens_legend.t -> unit -> t [@@js.create]

    val push :
         t
      -> line:int
      -> char:int
      -> length:int
      -> token_type_:int
      -> ?token_modifiers:int
      -> unit
      -> unit
      [@@js.call "push"]

    val push' :
         t
      -> range:Range.t
      -> token_type_:string
      -> ?token_modifiers:string list
      -> unit
      -> unit
      [@@js.call "push"]

    val build : t -> ?result_id:string -> unit -> Semantic_tokens.t
      [@@js.call "build"]
  end
  [@@js.scope "SemanticTokensBuilder"]

  module Document_semantic_tokens_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val on_did_change_semantic_tokens : t -> unit Event.t
      [@@js.get "onDidChangeSemanticTokens"]

    val set_on_did_change_semantic_tokens : t -> unit Event.t -> unit
      [@@js.set "onDidChangeSemanticTokens"]

    val provide_document_semantic_tokens :
         t
      -> document:Text_document.t
      -> token:Cancellation_token.t
      -> Semantic_tokens.t Provider_result.t
      [@@js.call "provideDocumentSemanticTokens"]

    val provide_document_semantic_tokens_edits :
         t
      -> document:Text_document.t
      -> previous_result_id:string
      -> token:Cancellation_token.t
      -> (Semantic_tokens.t, Semantic_tokens_edits.t) union2 Provider_result.t
      [@@js.call "provideDocumentSemanticTokensEdits"]
  end
  [@@js.scope "DocumentSemanticTokensProvider"]

  module Document_range_semantic_tokens_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_document_range_semantic_tokens :
         t
      -> document:Text_document.t
      -> range:Range.t
      -> token:Cancellation_token.t
      -> Semantic_tokens.t Provider_result.t
      [@@js.call "provideDocumentRangeSemanticTokens"]
  end
  [@@js.scope "DocumentRangeSemanticTokensProvider"]

  module Formatting_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val tab_size : t -> int [@@js.get "tabSize"]

    val set_tab_size : t -> int -> unit [@@js.set "tabSize"]

    val insert_spaces : t -> bool [@@js.get "insertSpaces"]

    val set_insert_spaces : t -> bool -> unit [@@js.set "insertSpaces"]

    val get : t -> string -> bool or_string or_number [@@js.index_get]

    val set : t -> string -> bool or_string or_number -> unit [@@js.index_set]
  end
  [@@js.scope "FormattingOptions"]

  module Document_formatting_edit_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_document_formatting_edits :
         t
      -> document:Text_document.t
      -> options:Formatting_options.t
      -> token:Cancellation_token.t
      -> Text_edit.t list Provider_result.t
      [@@js.call "provideDocumentFormattingEdits"]

    val create :
         provide_document_formatting_edits:
           (   document:Text_document.t
            -> options:Formatting_options.t
            -> token:Cancellation_token.t
            -> Text_edit.t list Provider_result.t)
      -> t
      [@@js.builder]
  end
  [@@js.scope "DocumentFormattingEditProvider"]

  module Document_range_formatting_edit_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_document_range_formatting_edits :
         t
      -> document:Text_document.t
      -> range:Range.t
      -> options:Formatting_options.t
      -> token:Cancellation_token.t
      -> Text_edit.t list Provider_result.t
      [@@js.call "provideDocumentRangeFormattingEdits"]
  end
  [@@js.scope "DocumentRangeFormattingEditProvider"]

  module On_type_formatting_edit_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_on_type_formatting_edits :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> ch:string
      -> options:Formatting_options.t
      -> token:Cancellation_token.t
      -> Text_edit.t list Provider_result.t
      [@@js.call "provideOnTypeFormattingEdits"]
  end
  [@@js.scope "OnTypeFormattingEditProvider"]

  module Parameter_information : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val label : t -> (int * int) or_string [@@js.get "label"]

    val set_label : t -> (int * int) or_string -> unit [@@js.set "label"]

    val documentation : t -> Markdown_string.t or_string
      [@@js.get "documentation"]

    val set_documentation : t -> Markdown_string.t or_string -> unit
      [@@js.set "documentation"]

    val create :
         label:(int * int) or_string
      -> ?documentation:Markdown_string.t or_string
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "ParameterInformation"]

  module Signature_information : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val documentation : t -> Markdown_string.t or_string
      [@@js.get "documentation"]

    val set_documentation : t -> Markdown_string.t or_string -> unit
      [@@js.set "documentation"]

    val parameters : t -> Parameter_information.t list [@@js.get "parameters"]

    val set_parameters : t -> Parameter_information.t list -> unit
      [@@js.set "parameters"]

    val active_parameter : t -> int [@@js.get "activeParameter"]

    val set_active_parameter : t -> int -> unit [@@js.set "activeParameter"]

    val create :
      label:string -> ?documentation:Markdown_string.t or_string -> unit -> t
      [@@js.create]
  end
  [@@js.scope "SignatureInformation"]

  module Signature_help : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val signatures : t -> Signature_information.t list [@@js.get "signatures"]

    val set_signatures : t -> Signature_information.t list -> unit
      [@@js.set "signatures"]

    val active_signature : t -> int [@@js.get "activeSignature"]

    val set_active_signature : t -> int -> unit [@@js.set "activeSignature"]

    val active_parameter : t -> int [@@js.get "activeParameter"]

    val set_active_parameter : t -> int -> unit [@@js.set "activeParameter"]
  end
  [@@js.scope "SignatureHelp"]

  module Signature_help_trigger_kind : sig
    type t =
      ([ `Invoke [@js 1]
       | `TriggerCharacter [@js 2]
       | `ContentChange [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Signature_help_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val trigger_kind : t -> Signature_help_trigger_kind.t
      [@@js.get "triggerKind"]

    val trigger_character : t -> string [@@js.get "triggerCharacter"]

    val is_retrigger : t -> bool [@@js.get "isRetrigger"]

    val active_signature_help : t -> Signature_help.t
      [@@js.get "activeSignatureHelp"]
  end
  [@@js.scope "SignatureHelpContext"]

  module Signature_help_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_signature_help :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> token:Cancellation_token.t
      -> context:Signature_help_context.t
      -> Signature_help.t Provider_result.t
      [@@js.call "provideSignatureHelp"]
  end
  [@@js.scope "SignatureHelpProvider"]

  module Signature_help_provider_metadata : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val trigger_characters : t -> string list [@@js.get "triggerCharacters"]

    val retrigger_characters : t -> string list [@@js.get "retriggerCharacters"]
  end
  [@@js.scope "SignatureHelpProviderMetadata"]

  module Completion_item_kind : sig
    type t =
      ([ `Text [@js 0]
       | `Method [@js 1]
       | `Function [@js 2]
       | `Constructor [@js 3]
       | `Field [@js 4]
       | `Variable [@js 5]
       | `Class [@js 6]
       | `Interface [@js 7]
       | `Module [@js 8]
       | `Property [@js 9]
       | `Unit [@js 10]
       | `Value [@js 11]
       | `Enum [@js 12]
       | `Keyword [@js 13]
       | `Snippet [@js 14]
       | `Color [@js 15]
       | `Reference [@js 17]
       | `File [@js 16]
       | `Folder [@js 18]
       | `EnumMember [@js 19]
       | `Constant [@js 20]
       | `Struct [@js 21]
       | `Event [@js 22]
       | `Operator [@js 23]
       | `TypeParameter [@js 24]
       | `User [@js 25]
       | `Issue [@js 26]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Completion_item_tag : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Completion_item : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val kind : t -> Completion_item_kind.t [@@js.get "kind"]

    val set_kind : t -> Completion_item_kind.t -> unit [@@js.set "kind"]

    val tags : t -> Completion_item_tag.t list [@@js.get "tags"]

    val set_tags : t -> Completion_item_tag.t list -> unit [@@js.set "tags"]

    val detail : t -> string [@@js.get "detail"]

    val set_detail : t -> string -> unit [@@js.set "detail"]

    val documentation : t -> Markdown_string.t or_string
      [@@js.get "documentation"]

    val set_documentation : t -> Markdown_string.t or_string -> unit
      [@@js.set "documentation"]

    val sort_text : t -> string [@@js.get "sortText"]

    val set_sort_text : t -> string -> unit [@@js.set "sortText"]

    val filter_text : t -> string [@@js.get "filterText"]

    val set_filter_text : t -> string -> unit [@@js.set "filterText"]

    val preselect : t -> bool [@@js.get "preselect"]

    val set_preselect : t -> bool -> unit [@@js.set "preselect"]

    val insert_text : t -> Snippet_string.t or_string [@@js.get "insertText"]

    val set_insert_text : t -> Snippet_string.t or_string -> unit
      [@@js.set "insertText"]

    module Range_with_edit : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val inserting : t -> Range.t [@@js.get "inserting"]

      val set_inserting : t -> Range.t -> unit [@@js.set "inserting"]

      val replacing : t -> Range.t [@@js.get "replacing"]

      val set_replacing : t -> Range.t -> unit [@@js.set "replacing"]
    end

    val range : t -> (Range.t, Range_with_edit.t) union2 [@@js.get "range"]

    val set_range : t -> (Range.t, Range_with_edit.t) union2 -> unit
      [@@js.set "range"]

    val commit_characters : t -> string list [@@js.get "commitCharacters"]

    val set_commit_characters : t -> string list -> unit
      [@@js.set "commitCharacters"]

    val keep_whitespace : t -> bool [@@js.get "keepWhitespace"]

    val set_keep_whitespace : t -> bool -> unit [@@js.set "keepWhitespace"]

    val text_edit : t -> Text_edit.t [@@js.get "textEdit"]

    val set_text_edit : t -> Text_edit.t -> unit [@@js.set "textEdit"]

    val additional_text_edits : t -> Text_edit.t list
      [@@js.get "additionalTextEdits"]

    val set_additional_text_edits : t -> Text_edit.t list -> unit
      [@@js.set "additionalTextEdits"]

    val command : t -> Command.t [@@js.get "command"]

    val set_command : t -> Command.t -> unit [@@js.set "command"]

    val create : label:string -> ?kind:Completion_item_kind.t -> unit -> t
      [@@js.create]
  end
  [@@js.scope "CompletionItem"]

  module Completion_list : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val is_incomplete : 'T t -> bool [@@js.get "isIncomplete"]

    val set_is_incomplete : 'T t -> bool -> unit [@@js.set "isIncomplete"]

    val items : 'T t -> 'T list [@@js.get "items"]

    val set_items : 'T t -> 'T list -> unit [@@js.set "items"]

    val create : ?items:'T list -> ?is_incomplete:bool -> unit -> 'T t
      [@@js.create]
  end
  [@@js.scope "CompletionList"]

  module Completion_trigger_kind : sig
    type t =
      ([ `Invoke [@js 0]
       | `TriggerCharacter [@js 1]
       | `TriggerForIncompleteCompletions [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Completion_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val trigger_kind : t -> Completion_trigger_kind.t [@@js.get "triggerKind"]

    val trigger_character : t -> string [@@js.get "triggerCharacter"]
  end
  [@@js.scope "CompletionContext"]

  module Completion_item_provider : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val provide_completion_items :
         'T t
      -> document:Text_document.t
      -> position:Position.t
      -> token:Cancellation_token.t
      -> context:Completion_context.t
      -> ('T Completion_list.t, 'T) or_array Provider_result.t
      [@@js.call "provideCompletionItems"]

    val resolve_completion_item :
      'T t -> item:'T -> token:Cancellation_token.t -> 'T Provider_result.t
      [@@js.call "resolveCompletionItem"]
  end
  [@@js.scope "CompletionItemProvider"]

  module Document_link : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val target : t -> Uri.t [@@js.get "target"]

    val set_target : t -> Uri.t -> unit [@@js.set "target"]

    val tooltip : t -> string [@@js.get "tooltip"]

    val set_tooltip : t -> string -> unit [@@js.set "tooltip"]

    val create : range:Range.t -> ?target:Uri.t -> unit -> t [@@js.create]
  end
  [@@js.scope "DocumentLink"]

  module Document_link_provider : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val provide_document_links :
         'T t
      -> document:Text_document.t
      -> token:Cancellation_token.t
      -> 'T list Provider_result.t
      [@@js.call "provideDocumentLinks"]

    val resolve_document_link :
      'T t -> link:'T -> token:Cancellation_token.t -> 'T Provider_result.t
      [@@js.call "resolveDocumentLink"]
  end
  [@@js.scope "DocumentLinkProvider"]

  module Color : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val red : t -> int [@@js.get "red"]

    val green : t -> int [@@js.get "green"]

    val blue : t -> int [@@js.get "blue"]

    val alpha : t -> int [@@js.get "alpha"]

    val create : red:int -> green:int -> blue:int -> alpha:int -> t
      [@@js.create]
  end
  [@@js.scope "Color"]

  module Color_information : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val color : t -> Color.t [@@js.get "color"]

    val set_color : t -> Color.t -> unit [@@js.set "color"]

    val create : range:Range.t -> color:Color.t -> t [@@js.create]
  end
  [@@js.scope "ColorInformation"]

  module Color_presentation : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val text_edit : t -> Text_edit.t [@@js.get "textEdit"]

    val set_text_edit : t -> Text_edit.t -> unit [@@js.set "textEdit"]

    val additional_text_edits : t -> Text_edit.t list
      [@@js.get "additionalTextEdits"]

    val set_additional_text_edits : t -> Text_edit.t list -> unit
      [@@js.set "additionalTextEdits"]

    val create : label:string -> t [@@js.create]
  end
  [@@js.scope "ColorPresentation"]

  module Document_color_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_document_colors :
         t
      -> document:Text_document.t
      -> token:Cancellation_token.t
      -> Color_information.t list Provider_result.t
      [@@js.call "provideDocumentColors"]

    module Context : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val document : t -> Text_document.t [@@js.get "document"]

      val set_document : t -> Text_document.t -> unit [@@js.set "document"]

      val range : t -> Range.t [@@js.get "range"]

      val set_range : t -> Range.t -> unit [@@js.set "range"]
    end

    val provide_color_presentations :
         t
      -> color:Color.t
      -> context:Context.t
      -> token:Cancellation_token.t
      -> Color_presentation.t list Provider_result.t
      [@@js.call "provideColorPresentations"]
  end
  [@@js.scope "DocumentColorProvider"]

  module Folding_range_kind : sig
    type t =
      ([ `Comment [@js 1]
       | `Imports [@js 2]
       | `Region [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Folding_range : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val start : t -> int [@@js.get "start"]

    val set_start : t -> int -> unit [@@js.set "start"]

    val end_ : t -> int [@@js.get "end"]

    val set_end : t -> int -> unit [@@js.set "end"]

    val kind : t -> Folding_range_kind.t [@@js.get "kind"]

    val set_kind : t -> Folding_range_kind.t -> unit [@@js.set "kind"]

    val create :
      start:int -> end_:int -> ?kind:Folding_range_kind.t -> unit -> t
      [@@js.create]
  end
  [@@js.scope "FoldingRange"]

  module Folding_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Folding_range_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val on_did_change_folding_ranges : t -> unit Event.t
      [@@js.get "onDidChangeFoldingRanges"]

    val set_on_did_change_folding_ranges : t -> unit Event.t -> unit
      [@@js.set "onDidChangeFoldingRanges"]

    val provide_folding_ranges :
         t
      -> document:Text_document.t
      -> context:Folding_context.t
      -> token:Cancellation_token.t
      -> Folding_range.t list Provider_result.t
      [@@js.call "provideFoldingRanges"]
  end
  [@@js.scope "FoldingRangeProvider"]

  module Selection_range : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val parent : t -> t [@@js.get "parent"]

    val set_parent : t -> t -> unit [@@js.set "parent"]

    val create : range:Range.t -> ?parent:t -> unit -> t [@@js.create]
  end
  [@@js.scope "SelectionRange"]

  module Selection_range_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_selection_ranges :
         t
      -> document:Text_document.t
      -> positions:Position.t list
      -> token:Cancellation_token.t
      -> Selection_range.t list Provider_result.t
      [@@js.call "provideSelectionRanges"]
  end
  [@@js.scope "SelectionRangeProvider"]

  module Call_hierarchy_item : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val kind : t -> Symbol_kind.t [@@js.get "kind"]

    val set_kind : t -> Symbol_kind.t -> unit [@@js.set "kind"]

    val tags : t -> Symbol_tag.t list [@@js.get "tags"]

    val set_tags : t -> Symbol_tag.t list -> unit [@@js.set "tags"]

    val detail : t -> string [@@js.get "detail"]

    val set_detail : t -> string -> unit [@@js.set "detail"]

    val uri : t -> Uri.t [@@js.get "uri"]

    val set_uri : t -> Uri.t -> unit [@@js.set "uri"]

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val selection_range : t -> Range.t [@@js.get "selectionRange"]

    val set_selection_range : t -> Range.t -> unit [@@js.set "selectionRange"]

    val create :
         kind:Symbol_kind.t
      -> name:string
      -> detail:string
      -> uri:Uri.t
      -> range:Range.t
      -> selection_range:Range.t
      -> t
      [@@js.create]
  end
  [@@js.scope "CallHierarchyItem"]

  module Call_hierarchy_incoming_call : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val from : t -> Call_hierarchy_item.t [@@js.get "from"]

    val set_from : t -> Call_hierarchy_item.t -> unit [@@js.set "from"]

    val from_ranges : t -> Range.t list [@@js.get "fromRanges"]

    val set_from_ranges : t -> Range.t list -> unit [@@js.set "fromRanges"]

    val create : item:Call_hierarchy_item.t -> from_ranges:Range.t list -> t
      [@@js.create]
  end
  [@@js.scope "CallHierarchyIncomingCall"]

  module Call_hierarchy_outgoing_call : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val to_ : t -> Call_hierarchy_item.t [@@js.get "to"]

    val set_to : t -> Call_hierarchy_item.t -> unit [@@js.set "to"]

    val from_ranges : t -> Range.t list [@@js.get "fromRanges"]

    val set_from_ranges : t -> Range.t list -> unit [@@js.set "fromRanges"]

    val create : item:Call_hierarchy_item.t -> from_ranges:Range.t list -> t
      [@@js.create]
  end
  [@@js.scope "CallHierarchyOutgoingCall"]

  module Call_hierarchy_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val prepare_call_hierarchy :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> token:Cancellation_token.t
      -> (Call_hierarchy_item.t, Call_hierarchy_item.t) or_array
         Provider_result.t
      [@@js.call "prepareCallHierarchy"]

    val provide_call_hierarchy_incoming_calls :
         t
      -> item:Call_hierarchy_item.t
      -> token:Cancellation_token.t
      -> Call_hierarchy_incoming_call.t list Provider_result.t
      [@@js.call "provideCallHierarchyIncomingCalls"]

    val provide_call_hierarchy_outgoing_calls :
         t
      -> item:Call_hierarchy_item.t
      -> token:Cancellation_token.t
      -> Call_hierarchy_outgoing_call.t list Provider_result.t
      [@@js.call "provideCallHierarchyOutgoingCalls"]
  end
  [@@js.scope "CallHierarchyProvider"]

  module Linked_editing_ranges : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : ranges:Range.t list -> ?word_pattern:regexp -> unit -> t
      [@@js.create]

    val ranges : t -> Range.t list [@@js.get "ranges"]

    val word_pattern : t -> regexp [@@js.get "wordPattern"]
  end
  [@@js.scope "LinkedEditingRanges"]

  module Linked_editing_range_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_linked_editing_ranges :
         t
      -> document:Text_document.t
      -> position:Position.t
      -> token:Cancellation_token.t
      -> Linked_editing_ranges.t Provider_result.t
      [@@js.call "provideLinkedEditingRanges"]
  end
  [@@js.scope "LinkedEditingRangeProvider"]

  module Character_pair : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Comment_rule : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val line_comment : t -> string [@@js.get "lineComment"]

    val set_line_comment : t -> string -> unit [@@js.set "lineComment"]

    val block_comment : t -> Character_pair.t [@@js.get "blockComment"]

    val set_block_comment : t -> Character_pair.t -> unit
      [@@js.set "blockComment"]
  end
  [@@js.scope "CommentRule"]

  module Indentation_rule : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val decrease_indent_pattern : t -> regexp [@@js.get "decreaseIndentPattern"]

    val set_decrease_indent_pattern : t -> regexp -> unit
      [@@js.set "decreaseIndentPattern"]

    val increase_indent_pattern : t -> regexp [@@js.get "increaseIndentPattern"]

    val set_increase_indent_pattern : t -> regexp -> unit
      [@@js.set "increaseIndentPattern"]

    val indent_next_line_pattern : t -> regexp
      [@@js.get "indentNextLinePattern"]

    val set_indent_next_line_pattern : t -> regexp -> unit
      [@@js.set "indentNextLinePattern"]

    val un_indented_line_pattern : t -> regexp
      [@@js.get "unIndentedLinePattern"]

    val set_un_indented_line_pattern : t -> regexp -> unit
      [@@js.set "unIndentedLinePattern"]
  end
  [@@js.scope "IndentationRule"]

  module Indent_action : sig
    type t =
      ([ `None [@js 0]
       | `Indent [@js 1]
       | `IndentOutdent [@js 2]
       | `Outdent [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Enter_action : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val indent_action : t -> Indent_action.t [@@js.get "indentAction"]

    val set_indent_action : t -> Indent_action.t -> unit
      [@@js.set "indentAction"]

    val append_text : t -> string [@@js.get "appendText"]

    val set_append_text : t -> string -> unit [@@js.set "appendText"]

    val remove_text : t -> int [@@js.get "removeText"]

    val set_remove_text : t -> int -> unit [@@js.set "removeText"]
  end
  [@@js.scope "EnterAction"]

  module On_enter_rule : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val before_text : t -> regexp [@@js.get "beforeText"]

    val set_before_text : t -> regexp -> unit [@@js.set "beforeText"]

    val after_text : t -> regexp [@@js.get "afterText"]

    val set_after_text : t -> regexp -> unit [@@js.set "afterText"]

    val previous_line_text : t -> regexp [@@js.get "previousLineText"]

    val set_previous_line_text : t -> regexp -> unit
      [@@js.set "previousLineText"]

    val action : t -> Enter_action.t [@@js.get "action"]

    val set_action : t -> Enter_action.t -> unit [@@js.set "action"]
  end
  [@@js.scope "OnEnterRule"]

  module Auto_closing_pairs : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val open_ : t -> string [@@js.get "open"]

    val set_open : t -> string -> unit [@@js.set "open"]

    val close : t -> string [@@js.get "close"]

    val set_close : t -> string -> unit [@@js.set "close"]

    val not_in : t -> string list [@@js.get "notIn"]

    val set_not_in : t -> string list -> unit [@@js.set "notIn"]
  end

  module Character_pair_support : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val auto_closing_pairs : t -> Auto_closing_pairs.t list
      [@@js.get "autoClosingPairs"]

    val set_auto_closing_pairs : t -> Auto_closing_pairs.t list -> unit
      [@@js.set "autoClosingPairs"]
  end

  module Doc_comment : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val scope : t -> string [@@js.get "scope"]

    val set_scope : t -> string -> unit [@@js.set "scope"]

    val open_ : t -> string [@@js.get "open"]

    val set_open : t -> string -> unit [@@js.set "open"]

    val line_start : t -> string [@@js.get "lineStart"]

    val set_line_start : t -> string -> unit [@@js.set "lineStart"]

    val close : t -> string [@@js.get "close"]

    val set_close : t -> string -> unit [@@js.set "close"]
  end

  module Electric_character_support : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val brackets : t -> any [@@js.get "brackets"]

    val set_brackets : t -> any -> unit [@@js.set "brackets"]

    val doc_comment : t -> Doc_comment.t [@@js.get "docComment"]

    val set_doc_comment : t -> Doc_comment.t -> unit [@@js.set "docComment"]
  end

  module Language_configuration : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val comments : t -> Comment_rule.t [@@js.get "comments"]

    val set_comments : t -> Comment_rule.t -> unit [@@js.set "comments"]

    val brackets : t -> Character_pair.t list [@@js.get "brackets"]

    val set_brackets : t -> Character_pair.t list -> unit [@@js.set "brackets"]

    val word_pattern : t -> regexp [@@js.get "wordPattern"]

    val set_word_pattern : t -> regexp -> unit [@@js.set "wordPattern"]

    val indentation_rules : t -> Indentation_rule.t
      [@@js.get "indentationRules"]

    val set_indentation_rules : t -> Indentation_rule.t -> unit
      [@@js.set "indentationRules"]

    val on_enter_rules : t -> On_enter_rule.t list [@@js.get "onEnterRules"]

    val set_on_enter_rules : t -> On_enter_rule.t list -> unit
      [@@js.set "onEnterRules"]

    val electric_character_support : t -> Electric_character_support.t
      [@@js.get "__electricCharacterSupport"]

    val set_electric_character_support :
      t -> Electric_character_support.t -> unit
      [@@js.set "__electricCharacterSupport"]

    val character_pair_support : t -> Character_pair_support.t
      [@@js.get "__characterPairSupport"]

    val set_character_pair_support : t -> Character_pair_support.t -> unit
      [@@js.set "__characterPairSupport"]
  end
  [@@js.scope "LanguageConfiguration"]

  module Configuration_target : sig
    type t =
      ([ `Global [@js 1]
       | `Workspace [@js 2]
       | `WorkspaceFolder [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Inspection_result : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val key : t -> string [@@js.get "key"]

    val set_key : t -> string -> unit [@@js.set "key"]

    val default : t -> 'T [@@js.get "defaultValue"]

    val set_default : t -> 'T -> unit [@@js.set "defaultValue"]

    val global_value : t -> 'T [@@js.get "globalValue"]

    val set_global_value : t -> 'T -> unit [@@js.set "globalValue"]

    val workspace_value : t -> 'T [@@js.get "workspaceValue"]

    val set_workspace_value : t -> 'T -> unit [@@js.set "workspaceValue"]

    val workspace_folder_value : t -> 'T [@@js.get "workspaceFolderValue"]

    val set_workspace_folder_value : t -> 'T -> unit
      [@@js.set "workspaceFolderValue"]

    val default_language_value : t -> 'T [@@js.get "defaultLanguageValue"]

    val set_default_language_value : t -> 'T -> unit
      [@@js.set "defaultLanguageValue"]

    val global_language_value : t -> 'T [@@js.get "globalLanguageValue"]

    val set_global_language_value : t -> 'T -> unit
      [@@js.set "globalLanguageValue"]

    val workspace_language_value : t -> 'T [@@js.get "workspaceLanguageValue"]

    val set_workspace_language_value : t -> 'T -> unit
      [@@js.set "workspaceLanguageValue"]

    val workspace_folder_language_value : t -> 'T
      [@@js.get "workspaceFolderLanguageValue"]

    val set_workspace_folder_language_value : t -> 'T -> unit
      [@@js.set "workspaceFolderLanguageValue"]

    val language_ids : t -> string list [@@js.get "languageIds"]

    val set_language_ids : t -> string list -> unit [@@js.set "languageIds"]
  end

  module Workspace_configuration : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get : t -> string -> 'T or_undefined [@@js.call "get"]

    val get' : t -> string -> default:'T -> 'T [@@js.call "get"]

    val has : t -> string -> bool [@@js.call "has"]

    val inspect : t -> string -> Inspection_result.t or_undefined
      [@@js.call "inspect"]

    val update :
         t
      -> section:string
      -> value:any
      -> ?configuration_target:
           ([ `Configuration_target of Configuration_target.t | `Bool of bool ]
           [@js.union])
      -> ?override_in_language:bool
      -> unit
      -> unit Promise.t
      [@@js.call "update"]
  end
  [@@js.scope "WorkspaceConfiguration"]

  module Location_link : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val origin_selection_range : t -> Range.t [@@js.get "originSelectionRange"]

    val set_origin_selection_range : t -> Range.t -> unit
      [@@js.set "originSelectionRange"]

    val target_uri : t -> Uri.t [@@js.get "targetUri"]

    val set_target_uri : t -> Uri.t -> unit [@@js.set "targetUri"]

    val target_range : t -> Range.t [@@js.get "targetRange"]

    val set_target_range : t -> Range.t -> unit [@@js.set "targetRange"]

    val target_selection_range : t -> Range.t [@@js.get "targetSelectionRange"]

    val set_target_selection_range : t -> Range.t -> unit
      [@@js.set "targetSelectionRange"]
  end
  [@@js.scope "LocationLink"]

  module Output_channel : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val name : t -> string [@@js.get "name"]

    val append : t -> value:string -> unit [@@js.call "append"]

    val append_line : t -> value:string -> unit [@@js.call "appendLine"]

    val clear : t -> unit [@@js.call "clear"]

    val show : t -> ?preserve_focus:bool -> unit -> unit [@@js.call "show"]

    val show' :
      t -> ?column:View_column.t -> ?preserve_focus:bool -> unit -> unit
      [@@js.call "show"]

    val hide : t -> unit [@@js.call "hide"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "OutputChannel"]

  module Accessibility_information : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val role : t -> string [@@js.get "role"]

    val set_role : t -> string -> unit [@@js.set "role"]
  end
  [@@js.scope "AccessibilityInformation"]

  module Status_bar_alignment : sig
    type t =
      ([ `Left [@js 1]
       | `Right [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Status_bar_item : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val alignment : t -> Status_bar_alignment.t [@@js.get "alignment"]

    val priority : t -> int [@@js.get "priority"]

    val text : t -> string [@@js.get "text"]

    val set_text : t -> string -> unit [@@js.set "text"]

    val tooltip : t -> string or_undefined [@@js.get "tooltip"]

    val set_tooltip : t -> string or_undefined -> unit [@@js.set "tooltip"]

    val color : t -> Theme_color.t or_string or_undefined [@@js.get "color"]

    val set_color : t -> Theme_color.t or_string or_undefined -> unit
      [@@js.set "color"]

    val background_color : t -> Theme_color.t or_undefined
      [@@js.get "backgroundColor"]

    val set_background_color : t -> Theme_color.t or_undefined -> unit
      [@@js.set "backgroundColor"]

    [@@@js.stop]

    type command =
      [ `String of string
      | `Command of Command.t
      ]

    [@@@js.start]

    [@@@js.implem
    type command =
      ([ `String of string
       | `Command of Command.t
       ]
      [@js.union])
    [@@js]

    let command_of_js js_val =
      match Ojs.type_of js_val with
      | "string" -> `String ([%js.to: string] js_val)
      | _ -> `Command ([%js.to: Command.t] js_val)]

    val command : t -> command [@@js.get "command"]

    val set_command : t -> command -> unit [@@js.set "command"]

    val accessibility_information : t -> Accessibility_information.t
      [@@js.get "accessibilityInformation"]

    val set_accessibility_information : t -> Accessibility_information.t -> unit
      [@@js.set "accessibilityInformation"]

    val show : t -> unit [@@js.call "show"]

    val hide : t -> unit [@@js.call "hide"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "StatusBarItem"]

  module Progress : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val report : 'T t -> value:'T -> unit [@@js.call "report"]
  end
  [@@js.scope "Progress"]

  module Terminal_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val shell_path : t -> string [@@js.get "shellPath"]

    val set_shell_path : t -> string -> unit [@@js.set "shellPath"]

    val shell_args : t -> string list [@@js.get "shellArgs"]

    val set_shell_args : t -> string list -> unit [@@js.set "shellArgs"]

    val cwd : t -> Uri.t or_string [@@js.get "cwd"]

    val set_cwd : t -> Uri.t or_string -> unit [@@js.set "cwd"]

    module Env : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get : t -> string -> string or_null_or_undefined [@@js.index_get]

      val set : t -> string -> string or_null_or_undefined -> unit
        [@@js.index_set]
    end

    val env : t -> Env.t [@@js.get "env"]

    val set_env : t -> Env.t -> unit [@@js.set "env"]

    val strict_env : t -> bool [@@js.get "strictEnv"]

    val set_strict_env : t -> bool -> unit [@@js.set "strictEnv"]

    val hide_from_user : t -> bool [@@js.get "hideFromUser"]

    val set_hide_from_user : t -> bool -> unit [@@js.set "hideFromUser"]
  end
  [@@js.scope "TerminalOptions"]

  module Terminal_dimensions : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val columns : t -> int [@@js.get "columns"]

    val rows : t -> int [@@js.get "rows"]
  end
  [@@js.scope "TerminalDimensions"]

  module Terminal_exit_status : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val code : t -> int or_undefined [@@js.get "code"]
  end
  [@@js.scope "TerminalExitStatus"]

  module Pseudoterminal : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val on_did_write : t -> string Event.t [@@js.get "onDidWrite"]

    val set_on_did_write : t -> string Event.t -> unit [@@js.set "onDidWrite"]

    val on_did_override_dimensions :
      t -> Terminal_dimensions.t or_undefined Event.t
      [@@js.get "onDidOverrideDimensions"]

    val set_on_did_override_dimensions :
      t -> Terminal_dimensions.t or_undefined Event.t -> unit
      [@@js.set "onDidOverrideDimensions"]

    val on_did_close : t -> unit or_number Event.t [@@js.get "onDidClose"]

    val set_on_did_close : t -> unit or_number Event.t -> unit
      [@@js.set "onDidClose"]

    val open_ :
      t -> initial_dimensions:Terminal_dimensions.t or_undefined -> unit
      [@@js.call "open"]

    val close : t -> unit [@@js.call "close"]

    val handle_input : t -> data:string -> unit [@@js.call "handleInput"]

    val set_dimensions : t -> dimensions:Terminal_dimensions.t -> unit
      [@@js.call "setDimensions"]
  end
  [@@js.scope "Pseudoterminal"]

  module Extension_terminal_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val pty : t -> Pseudoterminal.t [@@js.get "pty"]

    val set_pty : t -> Pseudoterminal.t -> unit [@@js.set "pty"]
  end
  [@@js.scope "ExtensionTerminalOptions"]

  module Terminal : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val name : t -> string [@@js.get "name"]

    val process_id : t -> int or_undefined Promise.t [@@js.get "processId"]

    val creation_options :
      t -> (Extension_terminal_options.t, Terminal_options.t) union2 Readonly.t
      [@@js.get "creationOptions"]

    val exit_status : t -> Terminal_exit_status.t or_undefined
      [@@js.get "exitStatus"]

    val send_text : t -> text:string -> ?add_new_line:bool -> unit -> unit
      [@@js.call "sendText"]

    val show : t -> ?preserve_focus:bool -> unit -> unit [@@js.call "show"]

    val hide : t -> unit [@@js.call "hide"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "Terminal"]

  module Terminal_link_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val line : t -> string [@@js.get "line"]

    val set_line : t -> string -> unit [@@js.set "line"]

    val terminal : t -> Terminal.t [@@js.get "terminal"]

    val set_terminal : t -> Terminal.t -> unit [@@js.set "terminal"]
  end
  [@@js.scope "TerminalLinkContext"]

  module Terminal_link_provider : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val provide_terminal_links :
         'T t
      -> context:Terminal_link_context.t
      -> token:Cancellation_token.t
      -> 'T list Provider_result.t
      [@@js.call "provideTerminalLinks"]

    val handle_terminal_link : 'T t -> link:'T -> unit Provider_result.t
      [@@js.call "handleTerminalLink"]
  end
  [@@js.scope "TerminalLinkProvider"]

  module Terminal_link : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val start_index : t -> int [@@js.get "startIndex"]

    val set_start_index : t -> int -> unit [@@js.set "startIndex"]

    val length : t -> int [@@js.get "length"]

    val set_length : t -> int -> unit [@@js.set "length"]

    val tooltip : t -> string [@@js.get "tooltip"]

    val set_tooltip : t -> string -> unit [@@js.set "tooltip"]
  end
  [@@js.scope "TerminalLink"]

  module File_decoration : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val badge : t -> string [@@js.get "badge"]

    val set_badge : t -> string -> unit [@@js.set "badge"]

    val tooltip : t -> string [@@js.get "tooltip"]

    val set_tooltip : t -> string -> unit [@@js.set "tooltip"]

    val color : t -> Theme_color.t [@@js.get "color"]

    val set_color : t -> Theme_color.t -> unit [@@js.set "color"]

    val propagate : t -> bool [@@js.get "propagate"]

    val set_propagate : t -> bool -> unit [@@js.set "propagate"]

    val create :
      ?badge:string -> ?tooltip:string -> ?color:Theme_color.t -> unit -> t
      [@@js.create]
  end
  [@@js.scope "FileDecoration"]

  module File_decoration_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val on_did_change_file_decorations :
      t -> (Uri.t, Uri.t) or_array or_undefined Event.t
      [@@js.get "onDidChangeFileDecorations"]

    val set_on_did_change_file_decorations :
      t -> (Uri.t, Uri.t) or_array or_undefined Event.t -> unit
      [@@js.set "onDidChangeFileDecorations"]

    val provide_file_decoration :
         t
      -> uri:Uri.t
      -> token:Cancellation_token.t
      -> File_decoration.t Provider_result.t
      [@@js.call "provideFileDecoration"]
  end
  [@@js.scope "FileDecorationProvider"]

  module Extension_kind : sig
    type t =
      ([ `UI [@js 1]
       | `Workspace [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Extension : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val id : 'T t -> string [@@js.get "id"]

    val extension_uri : 'T t -> Uri.t [@@js.get "extensionUri"]

    val extension_path : 'T t -> string [@@js.get "extensionPath"]

    val is_active : 'T t -> bool [@@js.get "isActive"]

    val package_json : 'T t -> any [@@js.get "packageJSON"]

    val extension_kind : 'T t -> Extension_kind.t [@@js.get "extensionKind"]

    val set_extension_kind : 'T t -> Extension_kind.t -> unit
      [@@js.set "extensionKind"]

    val exports : 'T t -> 'T [@@js.get "exports"]

    val activate : 'T t -> 'T Promise.t [@@js.call "activate"]
  end
  [@@js.scope "Extension"]

  module Extension_mode : sig
    type t =
      ([ `Production [@js 1]
       | `Development [@js 2]
       | `Test [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Memento : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get : t -> key:string -> 'T or_undefined [@@js.call "get"]

    val get' : t -> key:string -> default:'T -> 'T [@@js.call "get"]

    val update : t -> key:string -> value:any -> unit Promise.t
      [@@js.call "update"]
  end
  [@@js.scope "Memento"]

  module Secret_storage_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val key : t -> string [@@js.get "key"]
  end
  [@@js.scope "SecretStorageChangeEvent"]

  module Secret_storage : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get : t -> key:string -> string or_undefined Promise.t [@@js.call "get"]

    val store : t -> key:string -> value:string -> unit Promise.t
      [@@js.call "store"]

    val delete : t -> key:string -> unit Promise.t [@@js.call "delete"]

    val on_did_change : t -> Secret_storage_change_event.t Event.t
      [@@js.get "onDidChange"]

    val set_on_did_change : t -> Secret_storage_change_event.t Event.t -> unit
      [@@js.set "onDidChange"]
  end
  [@@js.scope "SecretStorage"]

  module Environment_variable_mutator_type : sig
    type t =
      ([ `Replace [@js 1]
       | `Append [@js 2]
       | `Prepend [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Environment_variable_mutator : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val type_ : t -> Environment_variable_mutator_type.t [@@js.get "type"]

    val value : t -> string [@@js.get "value"]
  end
  [@@js.scope "EnvironmentVariableMutator"]

  module Environment_variable_collection : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val persistent : t -> bool [@@js.get "persistent"]

    val set_persistent : t -> bool -> unit [@@js.set "persistent"]

    val replace : t -> variable:string -> value:string -> unit
      [@@js.call "replace"]

    val append : t -> variable:string -> value:string -> unit
      [@@js.call "append"]

    val prepend : t -> variable:string -> value:string -> unit
      [@@js.call "prepend"]

    val get :
      t -> variable:string -> Environment_variable_mutator.t or_undefined
      [@@js.call "get"]

    val for_each :
         t
      -> callback:
           (   variable:string
            -> mutator:Environment_variable_mutator.t
            -> collection:t
            -> any)
      -> ?this_arg:any
      -> unit
      -> unit
      [@@js.call "forEach"]

    val delete : t -> variable:string -> unit [@@js.call "delete"]

    val clear : t -> unit [@@js.call "clear"]
  end
  [@@js.scope "EnvironmentVariableCollection"]

  module Extension_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    module Subscription : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val dispose : t -> any [@@js.call "dispose"]
    end

    module Global_state : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val set_keys_for_sync : t -> keys:string list -> unit
        [@@js.call "setKeysForSync"]
    end

    val subscriptions : t -> Subscription.t list [@@js.get "subscriptions"]

    val workspace_state : t -> Memento.t [@@js.get "workspaceState"]

    val global_state : t -> (Memento.t, Global_state.t) intersection2
      [@@js.get "globalState"]

    val secrets : t -> Secret_storage.t [@@js.get "secrets"]

    val extension_uri : t -> Uri.t [@@js.get "extensionUri"]

    val extension_path : t -> string [@@js.get "extensionPath"]

    val environment_variable_collection : t -> Environment_variable_collection.t
      [@@js.get "environmentVariableCollection"]

    val as_absolute_path : t -> relative_path:string -> string
      [@@js.call "asAbsolutePath"]

    val storage_uri : t -> Uri.t or_undefined [@@js.get "storageUri"]

    val storage_path : t -> string or_undefined [@@js.get "storagePath"]

    val global_storage_uri : t -> Uri.t [@@js.get "globalStorageUri"]

    val global_storage_path : t -> string [@@js.get "globalStoragePath"]

    val log_uri : t -> Uri.t [@@js.get "logUri"]

    val log_path : t -> string [@@js.get "logPath"]

    val extension_mode : t -> Extension_mode.t [@@js.get "extensionMode"]

    val extension : t -> any Extension.t [@@js.get "extension"]

    [@@@js.stop]

    val subscribe : t -> Disposable.t -> unit

    [@@@js.start]

    [@@@js.implem
    let subscribe t disposable =
      let subscriptions = Ojs.get_prop_ascii ([%js.of: t] t) "subscriptions" in
      let (_ : Ojs.t) =
        Ojs.call subscriptions "push" [| [%js.of: Disposable.t] disposable |]
      in
      ()]
  end
  [@@js.scope "ExtensionContext"]

  module Color_theme_kind : sig
    type t =
      ([ `Light [@js 1]
       | `Dark [@js 2]
       | `HighContrast [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Color_theme : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val kind : t -> Color_theme_kind.t [@@js.get "kind"]
  end
  [@@js.scope "ColorTheme"]

  module Task_reveal_kind : sig
    type t =
      ([ `Always [@js 1]
       | `Silent [@js 2]
       | `Never [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Task_panel_kind : sig
    type t =
      ([ `Shared [@js 1]
       | `Dedicated [@js 2]
       | `New [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Task_presentation_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val reveal : t -> Task_reveal_kind.t [@@js.get "reveal"]

    val set_reveal : t -> Task_reveal_kind.t -> unit [@@js.set "reveal"]

    val echo : t -> bool [@@js.get "echo"]

    val set_echo : t -> bool -> unit [@@js.set "echo"]

    val focus : t -> bool [@@js.get "focus"]

    val set_focus : t -> bool -> unit [@@js.set "focus"]

    val panel : t -> Task_panel_kind.t [@@js.get "panel"]

    val set_panel : t -> Task_panel_kind.t -> unit [@@js.set "panel"]

    val show_reuse_message : t -> bool [@@js.get "showReuseMessage"]

    val set_show_reuse_message : t -> bool -> unit [@@js.set "showReuseMessage"]

    val clear : t -> bool [@@js.get "clear"]

    val set_clear : t -> bool -> unit [@@js.set "clear"]
  end
  [@@js.scope "TaskPresentationOptions"]

  module Task_group : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val clean : unit -> t [@@js.get "Clean"]

    val set_clean : t -> unit [@@js.set "Clean"]

    val build : unit -> t [@@js.get "Build"]

    val set_build : t -> unit [@@js.set "Build"]

    val rebuild : unit -> t [@@js.get "Rebuild"]

    val set_rebuild : t -> unit [@@js.set "Rebuild"]

    val test : unit -> t [@@js.get "Test"]

    val set_test : t -> unit [@@js.set "Test"]

    val create : id:string -> label:string -> t [@@js.create]
  end
  [@@js.scope "TaskGroup"]

  module Task_definition : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val type_ : t -> string [@@js.get "type"]

    val get : t -> string -> any [@@js.index_get]

    val set : t -> string -> any -> unit [@@js.index_set]

    [@@@js.stop]

    val create : type_:string -> ?attributes:(string * any) list -> unit -> t

    [@@@js.start]

    [@@@js.implem
    let create ~type_ ?(attributes = []) () =
      let obj = Ojs.obj [| ("type", [%js.of: string] type_) |] in
      let set (key, value) = Ojs.set_prop_ascii obj key value in
      List.iter set attributes;
      [%js.to: t] obj]
  end
  [@@js.scope "TaskDefinition"]

  module Process_execution_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val cwd : t -> string [@@js.get "cwd"]

    val set_cwd : t -> string -> unit [@@js.set "cwd"]

    module Env : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get : t -> string -> string [@@js.index_get]

      val set : t -> string -> string -> unit [@@js.index_set]
    end

    val env : t -> Env.t [@@js.get "env"]

    val set_env : t -> Env.t -> unit [@@js.set "env"]
  end
  [@@js.scope "ProcessExecutionOptions"]

  module Process_execution : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create :
      process:string -> ?options:Process_execution_options.t -> unit -> t
      [@@js.create]

    val create' :
         process:string
      -> args:string list
      -> ?options:Process_execution_options.t
      -> unit
      -> t
      [@@js.create]

    val process : t -> string [@@js.get "process"]

    val set_process : t -> string -> unit [@@js.set "process"]

    val args : t -> string list [@@js.get "args"]

    val set_args : t -> string list -> unit [@@js.set "args"]

    val options : t -> Process_execution_options.t [@@js.get "options"]

    val set_options : t -> Process_execution_options.t -> unit
      [@@js.set "options"]
  end
  [@@js.scope "ProcessExecution"]

  module Shell_quoting_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    module Escape : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val escape_char : t -> string [@@js.get "escapeChar"]

      val set_escape_char : t -> string -> unit [@@js.set "escapeChar"]

      val chars_to_escape : t -> string [@@js.get "charsToEscape"]

      val set_chars_to_escape : t -> string -> unit [@@js.set "charsToEscape"]
    end

    val escape : t -> Escape.t or_string [@@js.get "escape"]

    val set_escape : t -> Escape.t or_string -> unit [@@js.set "escape"]

    val strong : t -> string [@@js.get "strong"]

    val set_strong : t -> string -> unit [@@js.set "strong"]

    val weak : t -> string [@@js.get "weak"]

    val set_weak : t -> string -> unit [@@js.set "weak"]
  end
  [@@js.scope "ShellQuotingOptions"]

  module Shell_execution_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val executable : t -> string [@@js.get "executable"]

    val set_executable : t -> string -> unit [@@js.set "executable"]

    val shell_args : t -> string list [@@js.get "shellArgs"]

    val set_shell_args : t -> string list -> unit [@@js.set "shellArgs"]

    val shell_quoting : t -> Shell_quoting_options.t [@@js.get "shellQuoting"]

    val set_shell_quoting : t -> Shell_quoting_options.t -> unit
      [@@js.set "shellQuoting"]

    val cwd : t -> string [@@js.get "cwd"]

    val set_cwd : t -> string -> unit [@@js.set "cwd"]

    module Env : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get : t -> string -> string [@@js.index_get]

      val set : t -> string -> string -> unit [@@js.index_set]
    end

    val env : t -> Env.t [@@js.get "env"]

    val set_env : t -> Env.t -> unit [@@js.set "env"]

    val create :
         ?executable:string
      -> ?shell_args:string list
      -> ?shell_quoting:Shell_quoting_options.t
      -> ?cwd:string
      -> ?env:Env.t
      -> unit
      -> t
      [@@js.builder]
  end
  [@@js.scope "ShellExecutionOptions"]

  module Shell_quoting : sig
    type t =
      ([ `Escape [@js 1]
       | `Strong [@js 2]
       | `Weak [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Shell_quoted_string : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val value : t -> string [@@js.get "value"]

    val set_value : t -> string -> unit [@@js.set "value"]

    val quoting : t -> Shell_quoting.t [@@js.get "quoting"]

    val set_quoting : t -> Shell_quoting.t -> unit [@@js.set "quoting"]
  end
  [@@js.scope "ShellQuotedString"]

  module Shell_execution : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create_command_line :
      command_line:string -> ?options:Shell_execution_options.t -> unit -> t
      [@@js.create]

    val create_command_args :
         command:Shell_quoted_string.t or_string
      -> args:Shell_quoted_string.t or_string list
      -> ?options:Shell_execution_options.t
      -> unit
      -> t
      [@@js.create]

    val command_line : t -> string or_undefined [@@js.get "commandLine"]

    val set_command_line : t -> string or_undefined -> unit
      [@@js.set "commandLine"]

    val command : t -> Shell_quoted_string.t or_string [@@js.get "command"]

    val set_command : t -> Shell_quoted_string.t or_string -> unit
      [@@js.set "command"]

    val args : t -> Shell_quoted_string.t or_string list [@@js.get "args"]

    val set_args : t -> Shell_quoted_string.t or_string list -> unit
      [@@js.set "args"]

    val options : t -> Shell_execution_options.t [@@js.get "options"]

    val set_options : t -> Shell_execution_options.t -> unit
      [@@js.set "options"]
  end
  [@@js.scope "ShellExecution"]

  module Custom_execution : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create :
         callback:
           (resolvedDefinition:Task_definition.t -> Pseudoterminal.t Promise.t)
      -> t
      [@@js.create]
  end
  [@@js.scope "CustomExecution"]

  module Task_scope : sig
    [@@@js.stop]

    type t =
      | Folder of Workspace_folder.t
      | Global
      | Workspace

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    [@@@js.start]

    [@@@js.implem
    type t =
      | Folder of Workspace_folder.t
      | Global
      | Workspace

    let t_to_js = function
      | Folder f -> [%js.of: Workspace_folder.t] f
      | Global -> [%js.of: int] 1
      | Workspace -> [%js.of: int] 2

    let t_of_js js_val =
      match Ojs.type_of js_val with
      | "number" when [%js.to: int] js_val = 1 -> Global
      | "number" when [%js.to: int] js_val = 2 -> Workspace
      | _ -> Folder ([%js.to: Workspace_folder.t] js_val)]
  end

  module Run_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val reevaluate_on_rerun : t -> bool [@@js.get "reevaluateOnRerun"]

    val set_reevaluate_on_rerun : t -> bool -> unit
      [@@js.set "reevaluateOnRerun"]
  end
  [@@js.scope "RunOptions"]

  module Task : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    [@@@js.stop]

    type execution =
      [ `ProcessExecution of Process_execution.t
      | `ShellExecution of Shell_execution.t
      | `CustomExecution of Custom_execution.t
      ]

    [@@@js.start]

    [@@@js.implem
    type execution =
      ([ `ProcessExecution of Process_execution.t
       | `ShellExecution of Shell_execution.t
       | `CustomExecution of Custom_execution.t
       ]
      [@js.union])
    [@@js]

    let execution_of_js js_val =
      if Ojs.has_property js_val "process" then
        `ProcessExecution ([%js.to: Process_execution.t] js_val)
      else if Ojs.has_property js_val "command" then
        `ShellExecution ([%js.to: Shell_execution.t] js_val)
      else
        `CustomExecution ([%js.to: Custom_execution.t] js_val)]

    val create :
         task_definition:Task_definition.t
      -> scope:Task_scope.t
      -> name:string
      -> source:string
      -> ?execution:execution
      -> ?problem_matchers:string list
      -> unit
      -> t
      [@@js.create]

    val create' :
         task_definition:Task_definition.t
      -> name:string
      -> source:string
      -> ?execution:(Process_execution.t, Shell_execution.t) union2
      -> ?problem_matchers:string list
      -> unit
      -> t
      [@@js.create]

    val definition : t -> Task_definition.t [@@js.get "definition"]

    val set_definition : t -> Task_definition.t -> unit [@@js.set "definition"]

    val scope :
         t
      -> ( Workspace_folder.t
         , ([ `Global [@js 1] | `Workspace [@js 2] ][@js.enum]) )
         or_enum
      [@@js.get "scope"]

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val detail : t -> string [@@js.get "detail"]

    val set_detail : t -> string -> unit [@@js.set "detail"]

    val execution :
      t -> (Custom_execution.t, Process_execution.t, Shell_execution.t) union3
      [@@js.get "execution"]

    val set_execution :
         t
      -> (Custom_execution.t, Process_execution.t, Shell_execution.t) union3
      -> unit
      [@@js.set "execution"]

    val is_background : t -> bool [@@js.get "isBackground"]

    val set_is_background : t -> bool -> unit [@@js.set "isBackground"]

    val source : t -> string [@@js.get "source"]

    val set_source : t -> string -> unit [@@js.set "source"]

    val group : t -> Task_group.t [@@js.get "group"]

    val set_group : t -> Task_group.t -> unit [@@js.set "group"]

    val presentation_options : t -> Task_presentation_options.t
      [@@js.get "presentationOptions"]

    val set_presentation_options : t -> Task_presentation_options.t -> unit
      [@@js.set "presentationOptions"]

    val problem_matchers : t -> string list [@@js.get "problemMatchers"]

    val set_problem_matchers : t -> string list -> unit
      [@@js.set "problemMatchers"]

    val run_options : t -> Run_options.t [@@js.get "runOptions"]

    val set_run_options : t -> Run_options.t -> unit [@@js.set "runOptions"]
  end
  [@@js.scope "Task"]

  module Task_provider : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val provide_tasks :
      'T t -> token:Cancellation_token.t -> 'T list Provider_result.t
      [@@js.call "provideTasks"]

    val resolve_task :
      'T t -> task:'T -> token:Cancellation_token.t -> 'T Provider_result.t
      [@@js.call "resolveTask"]

    val create :
         provide_tasks:(token:Cancellation_token.t -> 'a list Provider_result.t)
      -> resolve_task:
           (task:'a -> token:Cancellation_token.t -> 'a Provider_result.t)
      -> 'a t
      [@@js.builder]
  end
  [@@js.scope "TaskProvider"]

  module Task_execution : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val task : t -> Task.t [@@js.get "task"]

    val set_task : t -> Task.t -> unit [@@js.set "task"]

    val terminate : t -> unit [@@js.call "terminate"]
  end
  [@@js.scope "TaskExecution"]

  module Task_start_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val execution : t -> Task_execution.t [@@js.get "execution"]
  end
  [@@js.scope "TaskStartEvent"]

  module Task_end_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val execution : t -> Task_execution.t [@@js.get "execution"]
  end
  [@@js.scope "TaskEndEvent"]

  module Task_process_start_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val execution : t -> Task_execution.t [@@js.get "execution"]

    val process_id : t -> int [@@js.get "processId"]
  end
  [@@js.scope "TaskProcessStartEvent"]

  module Task_process_end_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val execution : t -> Task_execution.t [@@js.get "execution"]

    val exit_code : t -> int or_undefined [@@js.get "exitCode"]
  end
  [@@js.scope "TaskProcessEndEvent"]

  module Task_filter : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val version : t -> string [@@js.get "version"]

    val set_version : t -> string -> unit [@@js.set "version"]

    val type_ : t -> string [@@js.get "type"]

    val set_type : t -> string -> unit [@@js.set "type"]
  end
  [@@js.scope "TaskFilter"]

  module Tasks : sig
    val register_task_provider :
      type_:string -> provider:Task.t Task_provider.t -> Disposable.t
      [@@js.global "registerTaskProvider"]

    val fetch_tasks : ?filter:Task_filter.t -> unit -> Task.t list Promise.t
      [@@js.global "fetchTasks"]

    val execute_task : task:Task.t -> Task_execution.t Promise.t
      [@@js.global "executeTask"]

    val task_executions : Task_execution.t list [@@js.global "taskExecutions"]

    val on_did_start_task : Task_start_event.t Event.t
      [@@js.global "onDidStartTask"]

    val on_did_end_task : Task_end_event.t Event.t [@@js.global "onDidEndTask"]

    val on_did_start_task_process : Task_process_start_event.t Event.t
      [@@js.global "onDidStartTaskProcess"]

    val on_did_end_task_process : Task_process_end_event.t Event.t
      [@@js.global "onDidEndTaskProcess"]
  end
  [@@js.scope "tasks"]

  module File_type : sig
    type t =
      ([ `Unknown [@js 0]
       | `File [@js 1]
       | `Directory [@js 2]
       | `SymbolicLink [@js 64]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module File_stat : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val type_ : t -> File_type.t [@@js.get "type"]

    val set_type : t -> File_type.t -> unit [@@js.set "type"]

    val ctime : t -> int [@@js.get "ctime"]

    val set_ctime : t -> int -> unit [@@js.set "ctime"]

    val mtime : t -> int [@@js.get "mtime"]

    val set_mtime : t -> int -> unit [@@js.set "mtime"]

    val size : t -> int [@@js.get "size"]

    val set_size : t -> int -> unit [@@js.set "size"]
  end
  [@@js.scope "FileStat"]

  module File_system_error : sig
    include module type of struct
      include Error
    end

    val file_not_found : ?message_or_uri:Uri.t or_string -> unit -> t
      [@@js.global "FileNotFound"]

    val file_exists : ?message_or_uri:Uri.t or_string -> unit -> t
      [@@js.global "FileExists"]

    val file_not_a_directory : ?message_or_uri:Uri.t or_string -> unit -> t
      [@@js.global "FileNotADirectory"]

    val file_is_a_directory : ?message_or_uri:Uri.t or_string -> unit -> t
      [@@js.global "FileIsADirectory"]

    val no_permissions : ?message_or_uri:Uri.t or_string -> unit -> t
      [@@js.global "NoPermissions"]

    val unavailable : ?message_or_uri:Uri.t or_string -> unit -> t
      [@@js.global "Unavailable"]

    val create : ?message_or_uri:Uri.t or_string -> unit -> t [@@js.create]

    val code : t -> string [@@js.get "code"]
  end
  [@@js.scope "FileSystemError"]

  module File_change_type : sig
    type t =
      ([ `Changed [@js 1]
       | `Created [@js 2]
       | `Deleted [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module File_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val type_ : t -> File_change_type.t [@@js.get "type"]

    val uri : t -> Uri.t [@@js.get "uri"]
  end
  [@@js.scope "FileChangeEvent"]

  module File_system_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val on_did_change_file : t -> File_change_event.t list Event.t
      [@@js.get "onDidChangeFile"]

    module Watch_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val recursive : t -> bool [@@js.get "recursive"]

      val set_recursive : t -> bool -> unit [@@js.set "recursive"]

      val excludes : t -> string list [@@js.get "excludes"]

      val set_excludes : t -> string list -> unit [@@js.set "excludes"]
    end

    val watch : t -> uri:Uri.t -> options:Watch_options.t -> Disposable.t
      [@@js.call "watch"]

    val stat : t -> uri:Uri.t -> (File_stat.t, File_stat.t Promise.t) union2
      [@@js.call "stat"]

    val read_directory :
         t
      -> uri:Uri.t
      -> ((string * File_type.t) list Promise.t, string * File_type.t) or_array
      [@@js.call "readDirectory"]

    val create_directory : t -> uri:Uri.t -> (unit, unit Promise.t) union2
      [@@js.call "createDirectory"]

    val read_file :
      t -> uri:Uri.t -> (Uint8_array.t, Uint8_array.t Promise.t) union2
      [@@js.call "readFile"]

    module Write_file_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val create : t -> bool [@@js.get "create"]

      val set_create : t -> bool -> unit [@@js.set "create"]

      val overwrite : t -> bool [@@js.get "overwrite"]

      val set_overwrite : t -> bool -> unit [@@js.set "overwrite"]
    end

    val write_file :
         t
      -> uri:Uri.t
      -> content:Uint8_array.t
      -> options:Write_file_options.t
      -> (unit, unit Promise.t) union2
      [@@js.call "writeFile"]

    module Delete_file_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val recursive : t -> bool [@@js.get "recursive"]

      val set_recursive : t -> bool -> unit [@@js.set "recursive"]
    end

    val delete :
         t
      -> uri:Uri.t
      -> options:Delete_file_options.t
      -> (unit, unit Promise.t) union2
      [@@js.call "delete"]

    module Rename_file_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val overwrite : t -> bool [@@js.get "overwrite"]

      val set_overwrite : t -> bool -> unit [@@js.set "overwrite"]
    end

    val rename :
         t
      -> old_uri:Uri.t
      -> new_uri:Uri.t
      -> options:Rename_file_options.t
      -> (unit, unit Promise.t) union2
      [@@js.call "rename"]

    val copy :
         t
      -> source:Uri.t
      -> destination:Uri.t
      -> options:Rename_file_options.t
      -> (unit, unit Promise.t) union2
      [@@js.call "copy"]
  end
  [@@js.scope "FileSystemProvider"]

  module File_system : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val stat : t -> uri:Uri.t -> File_stat.t Promise.t [@@js.call "stat"]

    val read_directory : t -> uri:Uri.t -> (string * File_type.t) list Promise.t
      [@@js.call "readDirectory"]

    val create_directory : t -> uri:Uri.t -> unit Promise.t
      [@@js.call "createDirectory"]

    val read_file : t -> uri:Uri.t -> Uint8_array.t Promise.t
      [@@js.call "readFile"]

    val write_file : t -> uri:Uri.t -> content:Uint8_array.t -> unit Promise.t
      [@@js.call "writeFile"]

    module Delete_file_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val recursive : t -> bool [@@js.get "recursive"]

      val set_recursive : t -> bool -> unit [@@js.set "recursive"]

      val use_trash : t -> bool [@@js.get "useTrash"]

      val set_use_trash : t -> bool -> unit [@@js.set "useTrash"]
    end

    val delete :
      t -> uri:Uri.t -> ?options:Delete_file_options.t -> unit -> unit Promise.t
      [@@js.call "delete"]

    module Rename_file_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val overwrite : t -> bool [@@js.get "overwrite"]

      val set_overwrite : t -> bool -> unit [@@js.set "overwrite"]
    end

    val rename :
         t
      -> source:Uri.t
      -> target:Uri.t
      -> ?options:Rename_file_options.t
      -> unit
      -> unit Promise.t
      [@@js.call "rename"]

    val copy :
         t
      -> source:Uri.t
      -> target:Uri.t
      -> ?options:Rename_file_options.t
      -> unit
      -> unit Promise.t
      [@@js.call "copy"]

    val is_writable_file_system : t -> scheme:string -> bool or_undefined
      [@@js.call "isWritableFileSystem"]
  end
  [@@js.scope "FileSystem"]

  module Webview_port_mapping : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val webview_port : t -> int [@@js.get "webviewPort"]

    val extension_host_port : t -> int [@@js.get "extensionHostPort"]
  end
  [@@js.scope "WebviewPortMapping"]

  module Webview_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val enable_scripts : t -> bool [@@js.get "enableScripts"]

    val enable_command_uris : t -> bool [@@js.get "enableCommandUris"]

    val local_resource_roots : t -> Uri.t list [@@js.get "localResourceRoots"]

    val port_mapping : t -> Webview_port_mapping.t list [@@js.get "portMapping"]
  end
  [@@js.scope "WebviewOptions"]

  module Webview : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val options : t -> Webview_options.t [@@js.get "options"]

    val set_options : t -> Webview_options.t -> unit [@@js.set "options"]

    val html : t -> string [@@js.get "html"]

    val set_html : t -> string -> unit [@@js.set "html"]

    val on_did_receive_message : t -> any Event.t
      [@@js.get "onDidReceiveMessage"]

    val post_message : t -> message:any -> bool Promise.t
      [@@js.call "postMessage"]

    val as_webview_uri : t -> local_resource:Uri.t -> Uri.t
      [@@js.call "asWebviewUri"]

    val csp_source : t -> string [@@js.get "cspSource"]
  end
  [@@js.scope "Webview"]

  module Webview_panel_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val enable_find_widget : t -> bool [@@js.get "enableFindWidget"]

    val retain_context_when_hidden : t -> bool
      [@@js.get "retainContextWhenHidden"]
  end
  [@@js.scope "WebviewPanelOptions"]

  module Webview_panel : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val view_type : t -> string [@@js.get "viewType"]

    val title : t -> string [@@js.get "title"]

    val set_title : t -> string -> unit [@@js.set "title"]

    val icon_path : t -> (Uri.t, Icon_path.t) union2 [@@js.get "iconPath"]

    val set_icon_path : t -> (Uri.t, Icon_path.t) union2 -> unit
      [@@js.set "iconPath"]

    val webview : t -> Webview.t [@@js.get "webview"]

    val options : t -> Webview_panel_options.t [@@js.get "options"]

    val view_column : t -> View_column.t [@@js.get "viewColumn"]

    val active : t -> bool [@@js.get "active"]

    val visible : t -> bool [@@js.get "visible"]

    module On_did_change_view_state_event : sig
      type webview_panel = t

      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val webview_panel : t -> webview_panel [@@js.get "webviewPanel"]
    end
    [@@js.scope "WebviewPanelOnDidChangeViewStateEvent"]

    val on_did_change_view_state : t -> On_did_change_view_state_event.t Event.t
      [@@js.get "onDidChangeViewState"]

    val on_did_dispose : t -> unit Event.t [@@js.get "onDidDispose"]

    val reveal :
      t -> ?view_column:View_column.t -> ?preserve_focus:bool -> unit -> unit
      [@@js.call "reveal"]

    val dispose : t -> any [@@js.call "dispose"]
  end
  [@@js.scope "WebviewPanel"]

  module Webview_panel_serializer : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val deserialize_webview_panel :
      'T t -> webview_panel:Webview_panel.t -> state:'T -> unit Promise.t
      [@@js.call "deserializeWebviewPanel"]
  end
  [@@js.scope "WebviewPanelSerializer"]

  module Webview_view : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val view_type : t -> string [@@js.get "viewType"]

    val webview : t -> Webview.t [@@js.get "webview"]

    val title : t -> string [@@js.get "title"]

    val set_title : t -> string -> unit [@@js.set "title"]

    val description : t -> string [@@js.get "description"]

    val set_description : t -> string -> unit [@@js.set "description"]

    val on_did_dispose : t -> unit Event.t [@@js.get "onDidDispose"]

    val visible : t -> bool [@@js.get "visible"]

    val on_did_change_visibility : t -> unit Event.t
      [@@js.get "onDidChangeVisibility"]

    val show : t -> ?preserve_focus:bool -> unit -> unit [@@js.call "show"]
  end
  [@@js.scope "WebviewView"]

  module Webview_view_resolve_context : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val state : 'T t -> 'T or_undefined [@@js.get "state"]
  end
  [@@js.scope "WebviewViewResolveContext"]

  module Webview_view_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val resolve_webview_view :
         t
      -> webview_view:Webview_view.t
      -> context:unknown Webview_view_resolve_context.t
      -> token:Cancellation_token.t
      -> (unit, unit Promise.t) union2
      [@@js.call "resolveWebviewView"]
  end
  [@@js.scope "WebviewViewProvider"]

  module Custom_text_editor_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val resolve_custom_text_editor :
         t
      -> document:Text_document.t
      -> webview_panel:Webview_panel.t
      -> token:Cancellation_token.t
      -> (unit, unit Promise.t) union2
      [@@js.call "resolveCustomTextEditor"]
  end
  [@@js.scope "CustomTextEditorProvider"]

  module Custom_document : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val uri : t -> Uri.t [@@js.get "uri"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "CustomDocument"]

  module Custom_document_edit_event : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val document : 'T t -> 'T [@@js.get "document"]

    val undo : 'T t -> (unit, unit Promise.t) union2 [@@js.call "undo"]

    val redo : 'T t -> (unit, unit Promise.t) union2 [@@js.call "redo"]

    val label : 'T t -> string [@@js.get "label"]
  end
  [@@js.scope "CustomDocumentEditEvent"]

  module Custom_document_content_change_event : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val document : 'T t -> 'T [@@js.get "document"]
  end
  [@@js.scope "CustomDocumentContentChangeEvent"]

  module Custom_document_backup : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val delete : t -> unit [@@js.call "delete"]
  end
  [@@js.scope "CustomDocumentBackup"]

  module Custom_document_backup_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val destination : t -> Uri.t [@@js.get "destination"]
  end
  [@@js.scope "CustomDocumentBackupContext"]

  module Custom_document_open_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val backup_id : t -> string [@@js.get "backupId"]

    val untitled_document_data : t -> Uint8_array.t
      [@@js.get "untitledDocumentData"]
  end
  [@@js.scope "CustomDocumentOpenContext"]

  module Custom_readonly_editor_provider : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val open_custom_document :
         'T t
      -> uri:Uri.t
      -> open_context:Custom_document_open_context.t
      -> token:Cancellation_token.t
      -> ('T, 'T Promise.t) union2
      [@@js.call "openCustomDocument"]

    val resolve_custom_editor :
         'T t
      -> document:'T
      -> webview_panel:Webview_panel.t
      -> token:Cancellation_token.t
      -> (unit, unit Promise.t) union2
      [@@js.call "resolveCustomEditor"]
  end
  [@@js.scope "CustomReadonlyEditorProvider"]

  module Custom_editor_provider : sig
    include module type of struct
      include Custom_readonly_editor_provider
    end

    val on_did_change_custom_document :
         'T t
      -> ( 'T Custom_document_content_change_event.t Event.t
         , 'T Custom_document_edit_event.t Event.t )
         union2
      [@@js.get "onDidChangeCustomDocument"]

    val save_custom_document :
      'T t -> document:'T -> cancellation:Cancellation_token.t -> unit Promise.t
      [@@js.call "saveCustomDocument"]

    val save_custom_document_as :
         'T t
      -> document:'T
      -> destination:Uri.t
      -> cancellation:Cancellation_token.t
      -> unit Promise.t
      [@@js.call "saveCustomDocumentAs"]

    val revert_custom_document :
      'T t -> document:'T -> cancellation:Cancellation_token.t -> unit Promise.t
      [@@js.call "revertCustomDocument"]

    val backup_custom_document :
         'T t
      -> document:'T
      -> context:Custom_document_backup_context.t
      -> cancellation:Cancellation_token.t
      -> Custom_document_backup.t Promise.t
      [@@js.call "backupCustomDocument"]

    include module type of struct
      include Custom_readonly_editor_provider
    end
  end
  [@@js.scope "CustomEditorProvider"]

  module Clipboard : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val read_text : t -> string Promise.t [@@js.call "readText"]

    val write_text : t -> value:string -> unit Promise.t [@@js.call "writeText"]
  end
  [@@js.scope "Clipboard"]

  module Ui_kind : sig
    type t =
      ([ `Desktop [@js 1]
       | `Web [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Env : sig
    val app_name : string [@@js.global "appName"]

    val app_root : string [@@js.global "appRoot"]

    val uri_scheme : string [@@js.global "uriScheme"]

    val language : string [@@js.global "language"]

    val clipboard : Clipboard.t [@@js.global "clipboard"]

    val machine_id : string [@@js.global "machineId"]

    val session_id : string [@@js.global "sessionId"]

    val is_new_app_install : bool [@@js.global "isNewAppInstall"]

    val is_telemetry_enabled : bool [@@js.global "isTelemetryEnabled"]

    val on_did_change_telemetry_enabled : bool Event.t
      [@@js.global "onDidChangeTelemetryEnabled"]

    val remote_name : string or_undefined [@@js.global "remoteName"]

    val shell : string [@@js.global "shell"]

    val ui_kind : Ui_kind.t [@@js.global "uiKind"]

    val open_external : target:Uri.t -> bool Promise.t
      [@@js.global "openExternal"]

    val as_external_uri : target:Uri.t -> Uri.t Promise.t
      [@@js.global "asExternalUri"]
  end
  [@@js.scope "env"]

  module Commands : sig
    val register_command :
      string -> ((any list[@js.variadic]) -> 'a) -> Disposable.t
      [@@js.global "registerCommand"]

    val register_text_editor_command :
         string
      -> (   text_editor:Text_editor.t
          -> edit:Text_editor_edit.t
          -> args:(any list[@js.variadic])
          -> unit)
      -> Disposable.t
      [@@js.global "registerTextEditorCommand"]

    val execute_command :
      string -> (any list[@js.variadic]) -> 'T or_undefined Promise.t
      [@@js.global "executeCommand"]

    val get_commands : ?filter_internal:bool -> unit -> string list Promise.t
      [@@js.global "getCommands"]
  end
  [@@js.scope "commands"]

  module Window_state : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val focused : t -> bool [@@js.get "focused"]
  end
  [@@js.scope "WindowState"]

  module Uri_handler : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val handle_uri : t -> uri:Uri.t -> unit Provider_result.t
      [@@js.call "handleUri"]
  end
  [@@js.scope "UriHandler"]

  module Quick_input : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val title : t -> string or_undefined [@@js.get "title"]

    val set_title : t -> string or_undefined -> unit [@@js.set "title"]

    val step : t -> int or_undefined [@@js.get "step"]

    val set_step : t -> int or_undefined -> unit [@@js.set "step"]

    val total_steps : t -> int or_undefined [@@js.get "totalSteps"]

    val set_total_steps : t -> int or_undefined -> unit [@@js.set "totalSteps"]

    val enabled : t -> bool [@@js.get "enabled"]

    val set_enabled : t -> bool -> unit [@@js.set "enabled"]

    val busy : t -> bool [@@js.get "busy"]

    val set_busy : t -> bool -> unit [@@js.set "busy"]

    val ignore_focus_out : t -> bool [@@js.get "ignoreFocusOut"]

    val set_ignore_focus_out : t -> bool -> unit [@@js.set "ignoreFocusOut"]

    val show : t -> unit [@@js.call "show"]

    val hide : t -> unit [@@js.call "hide"]

    val on_did_hide : t -> unit Event.t [@@js.get "onDidHide"]

    val set_on_did_hide : t -> unit Event.t -> unit [@@js.set "onDidHide"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "QuickInput"]

  module Quick_input_button : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val icon_path : t -> (Theme_icon.t, Uri.t, Icon_path.t) union3
      [@@js.get "iconPath"]

    val tooltip : t -> string or_undefined [@@js.get "tooltip"]
  end
  [@@js.scope "QuickInputButton"]

  module Quick_input_buttons : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val back : unit -> Quick_input_button.t [@@js.get "Back"]

    val create : unit -> t [@@js.create]
  end
  [@@js.scope "QuickInputButtons"]

  module Quick_pick : sig
    include module type of struct
      include Quick_input
    end

    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val value : 'T t -> string [@@js.get "value"]

    val set_value : 'T t -> string -> unit [@@js.set "value"]

    val placeholder : 'T t -> string or_undefined [@@js.get "placeholder"]

    val set_placeholder : 'T t -> string or_undefined -> unit
      [@@js.set "placeholder"]

    val on_did_change_value : 'T t -> string Event.t
      [@@js.get "onDidChangeValue"]

    val on_did_accept : 'T t -> unit Event.t [@@js.get "onDidAccept"]

    val buttons : 'T t -> Quick_input_button.t list [@@js.get "buttons"]

    val set_buttons : 'T t -> Quick_input_button.t list -> unit
      [@@js.set "buttons"]

    val on_did_trigger_button : 'T t -> Quick_input_button.t Event.t
      [@@js.get "onDidTriggerButton"]

    val items : 'T t -> 'T list [@@js.get "items"]

    val set_items : 'T t -> 'T list -> unit [@@js.set "items"]

    val can_select_many : 'T t -> bool [@@js.get "canSelectMany"]

    val set_can_select_many : 'T t -> bool -> unit [@@js.set "canSelectMany"]

    val match_on_description : 'T t -> bool [@@js.get "matchOnDescription"]

    val set_match_on_description : 'T t -> bool -> unit
      [@@js.set "matchOnDescription"]

    val match_on_detail : 'T t -> bool [@@js.get "matchOnDetail"]

    val set_match_on_detail : 'T t -> bool -> unit [@@js.set "matchOnDetail"]

    val active_items : 'T t -> 'T list [@@js.get "activeItems"]

    val set_active_items : 'T t -> 'T list -> unit [@@js.set "activeItems"]

    val on_did_change_active : 'T t -> 'T list Event.t
      [@@js.get "onDidChangeActive"]

    val selected_items : 'T t -> 'T list [@@js.get "selectedItems"]

    val set_selected_items : 'T t -> 'T list -> unit [@@js.set "selectedItems"]

    val on_did_change_selection : 'T t -> 'T list Event.t
      [@@js.get "onDidChangeSelection"]
  end
  [@@js.scope "QuickPick"]

  module Input_box : sig
    include module type of struct
      include Quick_input
    end

    val value : t -> string [@@js.get "value"]

    val set_value : t -> string -> unit [@@js.set "value"]

    val placeholder : t -> string or_undefined [@@js.get "placeholder"]

    val set_placeholder : t -> string or_undefined -> unit
      [@@js.set "placeholder"]

    val password : t -> bool [@@js.get "password"]

    val set_password : t -> bool -> unit [@@js.set "password"]

    val on_did_change_value : t -> string Event.t [@@js.get "onDidChangeValue"]

    val on_did_accept : t -> unit Event.t [@@js.get "onDidAccept"]

    val buttons : t -> Quick_input_button.t list [@@js.get "buttons"]

    val set_buttons : t -> Quick_input_button.t list -> unit
      [@@js.set "buttons"]

    val on_did_trigger_button : t -> Quick_input_button.t Event.t
      [@@js.get "onDidTriggerButton"]

    val prompt : t -> string or_undefined [@@js.get "prompt"]

    val set_prompt : t -> string or_undefined -> unit [@@js.set "prompt"]

    val validation_message : t -> string or_undefined
      [@@js.get "validationMessage"]

    val set_validation_message : t -> string or_undefined -> unit
      [@@js.set "validationMessage"]
  end
  [@@js.scope "InputBox"]

  module Progress_location : sig
    type t =
      ([ `SourceControl [@js 1]
       | `Window [@js 10]
       | `Notification [@js 15]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Progress_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    [@@@js.stop]

    type view_id = { viewId : string }

    type location =
      [ `ProgressLocation of Progress_location.t
      | `ViewId of view_id
      ]

    [@@@js.start]

    [@@@js.implem
    type view_id = { viewId : string } [@@js]

    type location =
      ([ `ProgressLocation of Progress_location.t
       | `ViewId of view_id
       ]
      [@js.union])
    [@@js]

    let location_of_js js_val =
      match Ojs.type_of js_val with
      | "number" -> `ProgressLocation ([%js.to: Progress_location.t] js_val)
      | _ -> `ViewId ([%js.to: view_id] js_val)]

    val location : t -> location [@@js.get "location"]

    val set_location : t -> location -> unit [@@js.set "location"]

    val title : t -> string [@@js.get "title"]

    val set_title : t -> string -> unit [@@js.set "title"]

    val cancellable : t -> bool [@@js.get "cancellable"]

    val set_cancellable : t -> bool -> unit [@@js.set "cancellable"]

    val create :
      location:location -> ?title:string -> ?cancellable:bool -> unit -> t
      [@@js.builder]
  end
  [@@js.scope "ProgressOptions"]

  module Tree_item_collapsible_state : sig
    type t =
      ([ `None [@js 0]
       | `Collapsed [@js 1]
       | `Expanded [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Tree_item_label : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val highlights : t -> (int * int) list [@@js.get "highlights"]

    val set_highlights : t -> (int * int) list -> unit [@@js.set "highlights"]

    val create : label:string -> ?highlights:(int * int) list -> unit -> t
      [@@js.builder]
  end
  [@@js.scope "TreeItemLabel"]

  module Tree_item : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val label : t -> Tree_item_label.t or_string [@@js.get "label"]

    val set_label : t -> Tree_item_label.t or_string -> unit [@@js.set "label"]

    val id : t -> string [@@js.get "id"]

    val set_id : t -> string -> unit [@@js.set "id"]

    val icon_path : t -> (Theme_icon.t, Uri.t, Icon_path.t) union3 or_string
      [@@js.get "iconPath"]

    val set_icon_path :
         t
      -> ([ `ThemeIcon of Theme_icon.t
          | `Uri of Uri.t
          | `IconPath of Icon_path.t
          | `String of string
          ]
         [@js.union])
      -> unit
      [@@js.set "iconPath"]

    val description : t -> bool or_string [@@js.get "description"]

    val set_description : t -> bool or_string -> unit [@@js.set "description"]

    val resource_uri : t -> Uri.t [@@js.get "resourceUri"]

    val set_resource_uri : t -> Uri.t -> unit [@@js.set "resourceUri"]

    [@@@js.stop]

    type tooltip =
      [ `String of string
      | `MarkdownString of Markdown_string.t
      | `Undefined
      ]

    [@@@js.start]

    [@@@js.implem
    type tooltip =
      ([ `String of string
       | `MarkdownString of Markdown_string.t
       | `Undefined
       ]
      [@js.union])
    [@@js]

    let tooltip_of_js js_val =
      if Ojs.type_of js_val = "string" then
        `String ([%js.to: string] js_val)
      else if Ojs.type_of js_val = "undefined" then
        `Undefined
      else if Ojs.has_property js_val "value" then
        `MarkdownString ([%js.to: Markdown_string.t] js_val)
      else
        assert false]

    val tooltip : t -> tooltip [@@js.get "tooltip"]

    val set_tooltip : t -> tooltip -> unit [@@js.set "tooltip"]

    val command : t -> Command.t [@@js.get "command"]

    val set_command : t -> Command.t -> unit [@@js.set "command"]

    val collapsible_state : t -> Tree_item_collapsible_state.t
      [@@js.get "collapsibleState"]

    val set_collapsible_state : t -> Tree_item_collapsible_state.t -> unit
      [@@js.set "collapsibleState"]

    val context_value : t -> string [@@js.get "contextValue"]

    val set_context_value : t -> string -> unit [@@js.set "contextValue"]

    val accessibility_information : t -> Accessibility_information.t
      [@@js.get "accessibilityInformation"]

    val set_accessibility_information : t -> Accessibility_information.t -> unit
      [@@js.set "accessibilityInformation"]

    val create :
         label:
           ([ `String of string
            | `TreeItemLabel of Tree_item_label.t
            | `Uri of Uri.t
            ]
           [@js.union])
      -> ?collapsible_state:Tree_item_collapsible_state.t
      -> unit
      -> t
      [@@js.new "TreeItem"]
  end

  module Tree_data_provider : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    module On_did_change_tree_data : sig
      type 'T t = 'T or_null_or_undefined Event.t
    end

    val on_did_change_tree_data : 'T t -> 'T On_did_change_tree_data.t
      [@@js.get "onDidChangeTreeData"]

    val set_on_did_change_tree_data :
      'T t -> 'T On_did_change_tree_data.t -> unit
      [@@js.set "onDidChangeTreeData"]

    val get_tree_item :
      'T t -> 'T -> (Tree_item.t, Tree_item.t Promise.t) union2
      [@@js.call "getTreeItem"]

    val get_children : 'T t -> ?element:'T -> unit -> 'T list Provider_result.t
      [@@js.call "getChildren"]

    val get_parent : 'T t -> 'T -> 'T Provider_result.t [@@js.call "getParent"]

    val resolve_tree_item :
         'T t
      -> item:Tree_item.t
      -> element:'T
      -> token:Cancellation_token.t
      -> Tree_item.t Provider_result.t
      [@@js.call "resolveTreeItem"]

    val create :
         ?on_did_change_tree_data:'T On_did_change_tree_data.t
      -> get_tree_item:
           (   'T
            -> ([ `Value of Tree_item.t | `Promise of Tree_item.t Promise.t ]
               [@js.union]))
      -> get_children:(?element:'T -> unit -> 'T list Provider_result.t)
      -> ?get_parent:('T -> 'T Provider_result.t)
      -> ?resolve_tree_item:
           (   item:Tree_item.t
            -> element:'T
            -> token:Cancellation_token.t
            -> Tree_item.t Provider_result.t)
      -> unit
      -> 'T t
      [@@js.builder]
  end
  [@@js.scope "TreeDataProvider"]

  module Tree_view_options : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val tree_data_provider : 'T t -> 'T Tree_data_provider.t
      [@@js.get "treeDataProvider"]

    val set_tree_data_provider : 'T t -> 'T Tree_data_provider.t -> unit
      [@@js.set "treeDataProvider"]

    val show_collapse_all : 'T t -> bool [@@js.get "showCollapseAll"]

    val set_show_collapse_all : 'T t -> bool -> unit
      [@@js.set "showCollapseAll"]

    val can_select_many : 'T t -> bool [@@js.get "canSelectMany"]

    val set_can_select_many : 'T t -> bool -> unit [@@js.set "canSelectMany"]
  end
  [@@js.scope "TreeViewOptions"]

  module Tree_view_expansion_event : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val element : 'T t -> 'T [@@js.get "element"]
  end
  [@@js.scope "TreeViewExpansionEvent"]

  module Tree_view_selection_change_event : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val selection : 'T t -> 'T list [@@js.get "selection"]
  end
  [@@js.scope "TreeViewSelectionChangeEvent"]

  module Tree_view_visibility_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val visible : t -> bool [@@js.get "visible"]
  end
  [@@js.scope "TreeViewVisibilityChangeEvent"]

  module Tree_view : sig
    include module type of struct
      include Disposable
    end

    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val on_did_expand_element : 'T t -> 'T Tree_view_expansion_event.t Event.t
      [@@js.get "onDidExpandElement"]

    val on_did_collapse_element : 'T t -> 'T Tree_view_expansion_event.t Event.t
      [@@js.get "onDidCollapseElement"]

    val selection : 'T t -> 'T list [@@js.get "selection"]

    val on_did_change_selection :
      'T t -> 'T Tree_view_selection_change_event.t Event.t
      [@@js.get "onDidChangeSelection"]

    val visible : 'T t -> bool [@@js.get "visible"]

    val on_did_change_visibility :
      'T t -> Tree_view_visibility_change_event.t Event.t
      [@@js.get "onDidChangeVisibility"]

    val message : 'T t -> string [@@js.get "message"]

    val set_message : 'T t -> string -> unit [@@js.set "message"]

    val title : 'T t -> string [@@js.get "title"]

    val set_title : 'T t -> string -> unit [@@js.set "title"]

    val description : 'T t -> string [@@js.get "description"]

    val set_description : 'T t -> string -> unit [@@js.set "description"]

    module Reveal_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val select : t -> bool [@@js.get "select"]

      val set_select : t -> bool -> unit [@@js.set "select"]

      val focus : t -> bool [@@js.get "focus"]

      val set_focus : t -> bool -> unit [@@js.set "focus"]

      val expand : t -> bool or_number [@@js.get "expand"]

      val set_expand : t -> bool or_number -> unit [@@js.set "expand"]
    end

    val reveal :
      'T t -> 'T -> ?options:Reveal_options.t -> unit -> unit Promise.t
      [@@js.call "reveal"]
  end
  [@@js.scope "TreeView"]

  module Window : sig
    val active_text_editor : unit -> Text_editor.t or_undefined
      [@@js.get "activeTextEditor"]

    val visible_text_editors : unit -> Text_editor.t list
      [@@js.get "visibleTextEditors"]

    val on_did_change_active_text_editor :
      unit -> Text_editor.t or_undefined Event.t
      [@@js.get "onDidChangeActiveTextEditor"]

    val on_did_change_visible_text_editors : unit -> Text_editor.t list Event.t
      [@@js.get "onDidChangeVisibleTextEditors"]

    val on_did_change_text_editor_selection :
      unit -> Text_editor_selection_change_event.t Event.t
      [@@js.get "onDidChangeTextEditorSelection"]

    val on_did_change_text_editor_visible_ranges :
      unit -> Text_editor_visible_ranges_change_event.t Event.t
      [@@js.get "onDidChangeTextEditorVisibleRanges"]

    val on_did_change_text_editor_options :
      unit -> Text_editor_options_change_event.t Event.t
      [@@js.get "onDidChangeTextEditorOptions"]

    val on_did_change_text_editor_view_column :
      unit -> Text_editor_view_column_change_event.t Event.t
      [@@js.get "onDidChangeTextEditorViewColumn"]

    val terminals : unit -> Terminal.t list [@@js.get "terminals"]

    val active_terminal : unit -> Terminal.t or_undefined
      [@@js.get "activeTerminal"]

    val on_did_change_active_terminal : unit -> Terminal.t or_undefined Event.t
      [@@js.get "onDidChangeActiveTerminal"]

    val on_did_open_terminal : unit -> Terminal.t Event.t
      [@@js.get "onDidOpenTerminal"]

    val on_did_close_terminal : unit -> Terminal.t Event.t
      [@@js.get "onDidCloseTerminal"]

    val state : unit -> Window_state.t [@@js.get "state"]

    val on_did_change_window_state : unit -> Window_state.t Event.t
      [@@js.get "onDidChangeWindowState"]

    val show_text_document :
         Text_document.t
      -> ?column:View_column.t
      -> ?preserve_focus:bool
      -> unit
      -> Text_editor.t Promise.t
      [@@js.global "showTextDocument"]

    val show_text_document_with_options :
         Text_document.t
      -> ?options:Text_document_show_options.t
      -> unit
      -> Text_editor.t Promise.t
      [@@js.global "showTextDocument"]

    val show_text_document_with_uri :
         Uri.t
      -> ?options:Text_document_show_options.t
      -> unit
      -> Text_editor.t Promise.t
      [@@js.global "showTextDocument"]

    val create_text_editor_decoration_type :
      Decoration_render_options.t -> Text_editor_decoration_type.t
      [@@js.global "createTextEditorDecorationType"]

    val show_information_message :
         string
      -> ?options:Message_options.t
      -> ?choices:(string * 'T) list
      -> unit
      -> 'T or_undefined Promise.t
      [@@js.global "showInformationMessage"]

    val show_warning_message :
         string
      -> ?options:Message_options.t
      -> ?choices:(string * 'T) list
      -> unit
      -> 'T or_undefined Promise.t
      [@@js.global "showWarningMessage"]

    val show_error_message :
         string
      -> ?options:Message_options.t
      -> ?choices:(string * 'T) list
      -> unit
      -> 'T or_undefined Promise.t
      [@@js.global "showErrorMessage"]

    module Show_quick_pick_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val can_pick_many : t -> ([ `L_b_true [@js true] ][@js.enum])
        [@@js.get "canPickMany"]

      val set_can_pick_many : t -> ([ `L_b_true ][@js.enum]) -> unit
        [@@js.set "canPickMany"]
    end

    val show_quick_pick :
         string list
      -> ?options:Quick_pick_options.t
      -> ?token:Cancellation_token.t
      -> unit
      -> string or_undefined Promise.t
      [@@js.global "showQuickPick"]

    val show_quick_pick_items :
         Quick_pick_item.t list
      -> ?options:Quick_pick_options.t
      -> ?token:Cancellation_token.t
      -> unit
      -> Quick_pick_item.t or_undefined Promise.t
      [@@js.global "showQuickPick"]

    val show_workspace_folder_pick :
         ?options:Workspace_folder_pick_options.t
      -> unit
      -> Workspace_folder.t or_undefined Promise.t
      [@@js.global "showWorkspaceFolderPick"]

    val show_open_dialog :
         ?options:Open_dialog_options.t
      -> unit
      -> Uri.t list or_undefined Promise.t
      [@@js.global "showOpenDialog"]

    val show_save_dialog :
      ?options:Save_dialog_options.t -> unit -> Uri.t or_undefined Promise.t
      [@@js.global "showSaveDialog"]

    val show_input_box :
         ?options:Input_box_options.t
      -> ?token:Cancellation_token.t
      -> unit
      -> string or_undefined Promise.t
      [@@js.global "showInputBox"]

    val create_quick_pick : unit -> 'T Quick_pick.t
      [@@js.global "createQuickPick"]

    val create_input_box : unit -> Input_box.t [@@js.global "createInputBox"]

    val create_output_channel : name:string -> Output_channel.t
      [@@js.global "createOutputChannel"]

    module Progress_info : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val message : t -> string [@@js.get "message"]

      val set_message : t -> string -> unit [@@js.set "message"]

      val increment : t -> int [@@js.get "increment"]

      val set_increment : t -> int -> unit [@@js.set "increment"]
    end

    module View_column_like : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val view_column : t -> View_column.t [@@js.get "viewColumn"]

      val set_view_column : t -> View_column.t -> unit [@@js.set "viewColumn"]

      val preserve_focus : t -> bool [@@js.get "preserveFocus"]

      val set_preserve_focus : t -> bool -> unit [@@js.set "preserveFocus"]
    end

    module Register_custom_editor_provider_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val webview_options : t -> Webview_panel_options.t
        [@@js.get "webviewOptions"]

      val supports_multiple_editors_per_document : t -> bool
        [@@js.get "supportsMultipleEditorsPerDocument"]
    end

    module Webview_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val retain_context_when_hidden : t -> bool
        [@@js.get "retainContextWhenHidden"]
    end

    module Register_webview_view_provider_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val webview_options : t -> Webview_options.t [@@js.get "webviewOptions"]
    end

    val create_webview_panel :
         view_type_:string
      -> title:string
      -> show_options:
           ( (View_column.t, View_column_like.t) union2
           , ([ `Active
              | `Beside
              | `Eight
              | `Five
              | `Four
              | `Nine
              | `One
              | `Seven
              | `Six
              | `Three
              | `Two
              ]
             [@js.enum]) )
           or_enum
      -> ?options:(Webview_panel_options.t, Webview_options.t) intersection2
      -> unit
      -> Webview_panel.t
      [@@js.global "createWebviewPanel"]

    val set_status_bar_message :
      text:string -> hide_after_timeout:int -> Disposable.t
      [@@js.global "setStatusBarMessage"]

    val set_status_bar_message :
      text:string -> hide_when_done:any Promise.t -> Disposable.t
      [@@js.global "setStatusBarMessage"]

    val set_status_bar_message : text:string -> Disposable.t
      [@@js.global "setStatusBarMessage"]

    val with_scm_progress :
      task:(progress:int Progress.t -> 'R Promise.t) -> 'R Promise.t
      [@@js.global "withScmProgress"]

    val with_progress :
         options:Progress_options.t
      -> task:
           (   progress:Progress_info.t Progress.t
            -> token:Cancellation_token.t
            -> 'R Promise.t)
      -> 'R Promise.t
      [@@js.global "withProgress"]

    val create_status_bar_item :
         ?alignment:Status_bar_alignment.t
      -> ?priority:int
      -> unit
      -> Status_bar_item.t
      [@@js.global "createStatusBarItem"]

    val create_terminal :
         ?name:string
      -> ?shell_path:string
      -> ?shell_args:string list
      -> unit
      -> Terminal.t
      [@@js.global "createTerminal"]

    val create_terminal_with_options : options:Terminal_options.t -> Terminal.t
      [@@js.global "createTerminal"]

    val register_tree_data_provider :
      string -> 'T Tree_data_provider.t -> Disposable.t
      [@@js.global "registerTreeDataProvider"]

    val create_tree_view :
      string -> options:'T Tree_view_options.t -> 'T Tree_view.t
      [@@js.global "createTreeView"]

    val register_uri_handler : handler:Uri_handler.t -> Disposable.t
      [@@js.global "registerUriHandler"]

    val register_webview_panel_serializer :
      string -> unknown Webview_panel_serializer.t -> Disposable.t
      [@@js.global "registerWebviewPanelSerializer"]

    val register_webview_view_provider :
         string
      -> Webview_view_provider.t
      -> ?options:Register_webview_view_provider_options.t
      -> unit
      -> Disposable.t
      [@@js.global "registerWebviewViewProvider"]

    val register_custom_editor_provider :
         string
      -> ( Custom_document.t Custom_editor_provider.t
         , Custom_document.t Custom_readonly_editor_provider.t
         , Custom_text_editor_provider.t )
         union3
      -> ?options:Register_custom_editor_provider_options.t
      -> unit
      -> Disposable.t
      [@@js.global "registerCustomEditorProvider"]

    val register_terminal_link_provider :
      Terminal_link.t Terminal_link_provider.t -> Disposable.t
      [@@js.global "registerTerminalLinkProvider"]

    val register_file_decoration_provider :
      File_decoration_provider.t -> Disposable.t
      [@@js.global "registerFileDecorationProvider"]

    val active_color_theme : Color_theme.t [@@js.global "activeColorTheme"]

    val on_did_change_active_color_theme : Color_theme.t Event.t
      [@@js.global "onDidChangeActiveColorTheme"]
  end
  [@@js.scope "window"]

  module Text_document_content_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val range : t -> Range.t [@@js.get "range"]

    val range_offset : t -> int [@@js.get "rangeOffset"]

    val range_length : t -> int [@@js.get "rangeLength"]

    val text : t -> string [@@js.get "text"]
  end
  [@@js.scope "TextDocumentContentChangeEvent"]

  module Text_document_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val document : t -> Text_document.t [@@js.get "document"]

    val content_changes : t -> Text_document_content_change_event.t list
      [@@js.get "contentChanges"]
  end
  [@@js.scope "TextDocumentChangeEvent"]

  module Text_document_save_reason : sig
    type t =
      ([ `Manual [@js 1]
       | `AfterDelay [@js 2]
       | `FocusOut [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Text_document_will_save_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val document : t -> Text_document.t [@@js.get "document"]

    val reason : t -> Text_document_save_reason.t [@@js.get "reason"]

    val wait_until : t -> Text_edit.t list Promise.t -> unit
      [@@js.call "waitUntil"]

    val wait_until' : t -> any Promise.t -> unit [@@js.call "waitUntil"]
  end
  [@@js.scope "TextDocumentWillSaveEvent"]

  module File_will_create_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val files : t -> Uri.t list [@@js.get "files"]

    val wait_until : t -> Workspace_edit.t Promise.t -> unit
      [@@js.call "waitUntil"]

    val wait_until' : t -> any Promise.t -> unit [@@js.call "waitUntil"]
  end
  [@@js.scope "FileWillCreateEvent"]

  module File_create_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val files : t -> Uri.t list [@@js.get "files"]
  end
  [@@js.scope "FileCreateEvent"]

  module File_will_delete_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val files : t -> Uri.t list [@@js.get "files"]

    val wait_until : t -> Workspace_edit.t Promise.t -> unit
      [@@js.call "waitUntil"]

    val wait_until' : t -> any Promise.t -> unit [@@js.call "waitUntil"]
  end
  [@@js.scope "FileWillDeleteEvent"]

  module File_delete_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val files : t -> Uri.t list [@@js.get "files"]
  end
  [@@js.scope "FileDeleteEvent"]

  module File_will_rename_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    module File : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val old_uri : t -> Uri.t [@@js.get "oldUri"]

      val set_old_uri : t -> Uri.t -> unit [@@js.set "oldUri"]

      val new_uri : t -> Uri.t [@@js.get "newUri"]

      val set_new_uri : t -> Uri.t -> unit [@@js.set "newUri"]
    end

    val files : t -> File.t list [@@js.get "files"]

    val wait_until : t -> Workspace_edit.t Promise.t -> unit
      [@@js.call "waitUntil"]

    val wait_until' : t -> any Promise.t -> unit [@@js.call "waitUntil"]
  end
  [@@js.scope "FileWillRenameEvent"]

  module File_rename_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    module File : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val old_uri : t -> Uri.t [@@js.get "oldUri"]

      val set_old_uri : t -> Uri.t -> unit [@@js.set "oldUri"]

      val new_uri : t -> Uri.t [@@js.get "newUri"]

      val set_new_uri : t -> Uri.t -> unit [@@js.set "newUri"]
    end

    val files : t -> File.t list [@@js.get "files"]
  end
  [@@js.scope "FileRenameEvent"]

  module Workspace_folders_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val added : t -> Workspace_folder.t list [@@js.get "added"]

    val removed : t -> Workspace_folder.t list [@@js.get "removed"]
  end
  [@@js.scope "WorkspaceFoldersChangeEvent"]

  module Uri_with_language_id : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val uri : t -> Uri.t [@@js.get "uri"]

    val set_uri : t -> Uri.t -> unit [@@js.set "uri"]

    val language_id : t -> string [@@js.get "languageId"]

    val set_language_id : t -> string -> unit [@@js.set "languageId"]
  end

  module Configuration_scope : sig
    type t =
      ( Text_document.t
      , Uri.t
      , Workspace_folder.t
      , Uri_with_language_id.t )
      union4

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Configuration_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val affects_configuration :
      t -> string -> ?scope:Configuration_scope.t -> unit -> bool
      [@@js.call "affectsConfiguration"]
  end
  [@@js.scope "ConfigurationChangeEvent"]

  module Workspace : sig
    module Register_file_system_provider_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val is_case_sensitive : t -> bool [@@js.get "isCaseSensitive"]

      val is_readonly : t -> bool [@@js.get "isReadonly"]
    end

    module Open_text_document_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val language : t -> string [@@js.get "language"]

      val set_language : t -> string -> unit [@@js.set "language"]

      val content : t -> string [@@js.get "content"]

      val set_content : t -> string -> unit [@@js.set "content"]
    end

    val fs : unit -> File_system.t [@@js.get "fs"]

    val root_path : unit -> string or_undefined [@@js.get "rootPath"]

    [@@@js.stop]

    val workspace_folders : unit -> Workspace_folder.t list

    [@@@js.start]

    [@@@js.implem
    val workspace_folders : unit -> Workspace_folder.t list or_undefined
      [@@js.get "workspaceFolders"]

    let workspace_folders () =
      match workspace_folders () with
      | None -> []
      | Some x -> x]

    val name : unit -> string or_undefined [@@js.get "name"]

    val workspace_file : unit -> Uri.t or_undefined [@@js.get "workspaceFile"]

    val on_did_change_workspace_folders :
      unit -> Workspace_folders_change_event.t Event.t
      [@@js.get "onDidChangeWorkspaceFolders"]

    val get_workspace_folder : uri:Uri.t -> Workspace_folder.t or_undefined
      [@@js.global "getWorkspaceFolder"]

    val as_relative_path :
      Uri.t or_string -> ?include_workspace_folder:bool -> unit -> string
      [@@js.global "asRelativePath"]

    val update_workspace_folders :
         start:int
      -> delete_count:int or_null_or_undefined
      -> workspace_folders_to_add:(Workspace_folder.t list[@js.variadic])
      -> bool
      [@@js.global "updateWorkspaceFolders"]

    val create_file_system_watcher :
         Glob_pattern.t
      -> ?ignore_create_events:bool
      -> ?ignore_change_events:bool
      -> ?ignore_delete_events:bool
      -> unit
      -> File_system_watcher.t
      [@@js.global "createFileSystemWatcher"]

    val find_files :
         Glob_pattern.t
      -> ?exclude:Glob_pattern.t
      -> ?max_results:int
      -> ?token:Cancellation_token.t
      -> unit
      -> Uri.t list Promise.t
      [@@js.global "findFiles"]

    val save_all : ?include_untitled:bool -> unit -> bool Promise.t
      [@@js.global "saveAll"]

    val apply_edit : Workspace_edit.t -> bool Promise.t
      [@@js.global "applyEdit"]

    val text_documents : Text_document.t list [@@js.global "textDocuments"]

    val open_text_document :
         ([ `Uri of Uri.t
          | `Filename of string
          | `Interactive of Open_text_document_options.t option
          ]
         [@js.union])
      -> Text_document.t Promise.t
      [@@js.global "openTextDocument"]

    val register_text_document_content_provider :
      scheme:string -> provider:Text_document_content_provider.t -> Disposable.t
      [@@js.global "registerTextDocumentContentProvider"]

    val on_did_open_text_document : Text_document.t Event.t
      [@@js.global "onDidOpenTextDocument"]

    val on_did_close_text_document : Text_document.t Event.t
      [@@js.global "onDidCloseTextDocument"]

    val on_did_change_text_document : Text_document_change_event.t Event.t
      [@@js.global "onDidChangeTextDocument"]

    val on_will_save_text_document : Text_document_will_save_event.t Event.t
      [@@js.global "onWillSaveTextDocument"]

    val on_did_save_text_document : Text_document.t Event.t
      [@@js.global "onDidSaveTextDocument"]

    val on_will_create_files : File_will_create_event.t Event.t
      [@@js.global "onWillCreateFiles"]

    val on_did_create_files : File_create_event.t Event.t
      [@@js.global "onDidCreateFiles"]

    val on_will_delete_files : File_will_delete_event.t Event.t
      [@@js.global "onWillDeleteFiles"]

    val on_did_delete_files : File_delete_event.t Event.t
      [@@js.global "onDidDeleteFiles"]

    val on_will_rename_files : File_will_rename_event.t Event.t
      [@@js.global "onWillRenameFiles"]

    val on_did_rename_files : File_rename_event.t Event.t
      [@@js.global "onDidRenameFiles"]

    val get_configuration :
         ?section:string
      -> ?scope:Configuration_scope.t
      -> unit
      -> Workspace_configuration.t
      [@@js.global "getConfiguration"]

    val on_did_change_configuration : Configuration_change_event.t Event.t
      [@@js.global "onDidChangeConfiguration"]

    val register_task_provider :
      type_:string -> provider:Task.t Task_provider.t -> Disposable.t
      [@@js.global "registerTaskProvider"]

    val register_file_system_provider :
         scheme:string
      -> provider:File_system_provider.t
      -> ?options:Register_file_system_provider_options.t
      -> unit
      -> Disposable.t
      [@@js.global "registerFileSystemProvider"]
  end
  [@@js.scope "workspace"]

  module Languages : sig
    val get_languages : unit -> string list Promise.t
      [@@js.global "getLanguages"]

    val set_text_document_language :
         document:Text_document.t
      -> language_id:string
      -> Text_document.t Promise.t
      [@@js.global "setTextDocumentLanguage"]

    val match_ : selector:Document_selector.t -> document:Text_document.t -> int
      [@@js.global "match"]

    val on_did_change_diagnostics : Diagnostic_change_event.t Event.t
      [@@js.global "onDidChangeDiagnostics"]

    val get_diagnostics : resource:Uri.t -> Diagnostic.t list
      [@@js.global "getDiagnostics"]

    val get_diagnostics : unit -> (Uri.t * Diagnostic.t list) list
      [@@js.global "getDiagnostics"]

    val create_diagnostic_collection :
      ?name:string -> unit -> Diagnostic_collection.t
      [@@js.global "createDiagnosticCollection"]

    val register_completion_item_provider :
         selector:Document_selector.t
      -> provider:Completion_item.t Completion_item_provider.t
      -> trigger_characters:(string list[@js.variadic])
      -> Disposable.t
      [@@js.global "registerCompletionItemProvider"]

    val register_code_actions_provider :
         selector:Document_selector.t
      -> provider:Code_action.t Code_action_provider.t
      -> ?metadata:Code_action_provider_metadata.t
      -> unit
      -> Disposable.t
      [@@js.global "registerCodeActionsProvider"]

    val register_code_lens_provider :
         selector:Document_selector.t
      -> provider:Code_lens.t Code_lens_provider.t
      -> Disposable.t
      [@@js.global "registerCodeLensProvider"]

    val register_definition_provider :
         selector:Document_selector.t
      -> provider:Definition_provider.t
      -> Disposable.t
      [@@js.global "registerDefinitionProvider"]

    val register_implementation_provider :
         selector:Document_selector.t
      -> provider:Implementation_provider.t
      -> Disposable.t
      [@@js.global "registerImplementationProvider"]

    val register_type_definition_provider :
         selector:Document_selector.t
      -> provider:Type_definition_provider.t
      -> Disposable.t
      [@@js.global "registerTypeDefinitionProvider"]

    val register_declaration_provider :
         selector:Document_selector.t
      -> provider:Declaration_provider.t
      -> Disposable.t
      [@@js.global "registerDeclarationProvider"]

    val register_hover_provider :
      selector:Document_selector.t -> provider:Hover_provider.t -> Disposable.t
      [@@js.global "registerHoverProvider"]

    val register_evaluatable_expression_provider :
         selector:Document_selector.t
      -> provider:Evaluatable_expression_provider.t
      -> Disposable.t
      [@@js.global "registerEvaluatableExpressionProvider"]

    val register_inline_values_provider :
         selector:Document_selector.t
      -> provider:Inline_values_provider.t
      -> Disposable.t
      [@@js.global "registerInlineValuesProvider"]

    val register_document_highlight_provider :
         selector:Document_selector.t
      -> provider:Document_highlight_provider.t
      -> Disposable.t
      [@@js.global "registerDocumentHighlightProvider"]

    val register_document_symbol_provider :
         selector:Document_selector.t
      -> provider:Document_symbol_provider.t
      -> ?meta_data:Document_symbol_provider_metadata.t
      -> unit
      -> Disposable.t
      [@@js.global "registerDocumentSymbolProvider"]

    val register_workspace_symbol_provider :
      provider:Symbol_information.t Workspace_symbol_provider.t -> Disposable.t
      [@@js.global "registerWorkspaceSymbolProvider"]

    val register_reference_provider :
         selector:Document_selector.t
      -> provider:Reference_provider.t
      -> Disposable.t
      [@@js.global "registerReferenceProvider"]

    val register_rename_provider :
      selector:Document_selector.t -> provider:Rename_provider.t -> Disposable.t
      [@@js.global "registerRenameProvider"]

    val register_document_semantic_tokens_provider :
         selector:Document_selector.t
      -> provider:Document_semantic_tokens_provider.t
      -> legend:Semantic_tokens_legend.t
      -> Disposable.t
      [@@js.global "registerDocumentSemanticTokensProvider"]

    val register_document_range_semantic_tokens_provider :
         selector:Document_selector.t
      -> provider:Document_range_semantic_tokens_provider.t
      -> legend:Semantic_tokens_legend.t
      -> Disposable.t
      [@@js.global "registerDocumentRangeSemanticTokensProvider"]

    val register_document_formatting_edit_provider :
         selector:Document_selector.t
      -> provider:Document_formatting_edit_provider.t
      -> Disposable.t
      [@@js.global "registerDocumentFormattingEditProvider"]

    val register_document_range_formatting_edit_provider :
         selector:Document_selector.t
      -> provider:Document_range_formatting_edit_provider.t
      -> Disposable.t
      [@@js.global "registerDocumentRangeFormattingEditProvider"]

    val register_on_type_formatting_edit_provider :
         selector:Document_selector.t
      -> provider:On_type_formatting_edit_provider.t
      -> first_trigger_character:string
      -> more_trigger_character:(string list[@js.variadic])
      -> Disposable.t
      [@@js.global "registerOnTypeFormattingEditProvider"]

    val register_signature_help_provider :
         selector:Document_selector.t
      -> provider:Signature_help_provider.t
      -> trigger_characters:(string list[@js.variadic])
      -> Disposable.t
      [@@js.global "registerSignatureHelpProvider"]

    val register_signature_help_provider :
         selector:Document_selector.t
      -> provider:Signature_help_provider.t
      -> metadata:Signature_help_provider_metadata.t
      -> Disposable.t
      [@@js.global "registerSignatureHelpProvider"]

    val register_document_link_provider :
         selector:Document_selector.t
      -> provider:Document_link.t Document_link_provider.t
      -> Disposable.t
      [@@js.global "registerDocumentLinkProvider"]

    val register_color_provider :
         selector:Document_selector.t
      -> provider:Document_color_provider.t
      -> Disposable.t
      [@@js.global "registerColorProvider"]

    val register_folding_range_provider :
         selector:Document_selector.t
      -> provider:Folding_range_provider.t
      -> Disposable.t
      [@@js.global "registerFoldingRangeProvider"]

    val register_selection_range_provider :
         selector:Document_selector.t
      -> provider:Selection_range_provider.t
      -> Disposable.t
      [@@js.global "registerSelectionRangeProvider"]

    val register_call_hierarchy_provider :
         selector:Document_selector.t
      -> provider:Call_hierarchy_provider.t
      -> Disposable.t
      [@@js.global "registerCallHierarchyProvider"]

    val register_linked_editing_range_provider :
         selector:Document_selector.t
      -> provider:Linked_editing_range_provider.t
      -> Disposable.t
      [@@js.global "registerLinkedEditingRangeProvider"]

    val set_language_configuration :
      language:string -> configuration:Language_configuration.t -> Disposable.t
      [@@js.global "setLanguageConfiguration"]
  end
  [@@js.scope "languages"]

  module Source_control_input_box : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val value : t -> string [@@js.get "value"]

    val set_value : t -> string -> unit [@@js.set "value"]

    val placeholder : t -> string [@@js.get "placeholder"]

    val set_placeholder : t -> string -> unit [@@js.set "placeholder"]

    val visible : t -> bool [@@js.get "visible"]

    val set_visible : t -> bool -> unit [@@js.set "visible"]
  end
  [@@js.scope "SourceControlInputBox"]

  module Quick_diff_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_original_resource :
      t -> uri:Uri.t -> token:Cancellation_token.t -> Uri.t Provider_result.t
      [@@js.call "provideOriginalResource"]
  end
  [@@js.scope "QuickDiffProvider"]

  module Source_control_resource_themable_decorations : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val icon_path : t -> Uri.t or_string [@@js.get "iconPath"]
  end
  [@@js.scope "SourceControlResourceThemableDecorations"]

  module Source_control_resource_decorations : sig
    include module type of struct
      include Source_control_resource_themable_decorations
    end

    val strike_through : t -> bool [@@js.get "strikeThrough"]

    val faded : t -> bool [@@js.get "faded"]

    val tooltip : t -> string [@@js.get "tooltip"]

    val light : t -> Source_control_resource_themable_decorations.t
      [@@js.get "light"]

    val dark : t -> Source_control_resource_themable_decorations.t
      [@@js.get "dark"]
  end
  [@@js.scope "SourceControlResourceDecorations"]

  module Source_control_resource_state : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val resource_uri : t -> Uri.t [@@js.get "resourceUri"]

    val command : t -> Command.t [@@js.get "command"]

    val decorations : t -> Source_control_resource_decorations.t
      [@@js.get "decorations"]

    val context_value : t -> string [@@js.get "contextValue"]
  end
  [@@js.scope "SourceControlResourceState"]

  module Source_control_resource_group : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val hide_when_empty : t -> bool [@@js.get "hideWhenEmpty"]

    val set_hide_when_empty : t -> bool -> unit [@@js.set "hideWhenEmpty"]

    val resource_states : t -> Source_control_resource_state.t list
      [@@js.get "resourceStates"]

    val set_resource_states : t -> Source_control_resource_state.t list -> unit
      [@@js.set "resourceStates"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "SourceControlResourceGroup"]

  module Source_control : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val label : t -> string [@@js.get "label"]

    val root_uri : t -> Uri.t or_undefined [@@js.get "rootUri"]

    val input_box : t -> Source_control_input_box.t [@@js.get "inputBox"]

    val count : t -> int [@@js.get "count"]

    val set_count : t -> int -> unit [@@js.set "count"]

    val quick_diff_provider : t -> Quick_diff_provider.t
      [@@js.get "quickDiffProvider"]

    val set_quick_diff_provider : t -> Quick_diff_provider.t -> unit
      [@@js.set "quickDiffProvider"]

    val commit_template : t -> string [@@js.get "commitTemplate"]

    val set_commit_template : t -> string -> unit [@@js.set "commitTemplate"]

    val accept_input_command : t -> Command.t [@@js.get "acceptInputCommand"]

    val set_accept_input_command : t -> Command.t -> unit
      [@@js.set "acceptInputCommand"]

    val status_bar_commands : t -> Command.t list [@@js.get "statusBarCommands"]

    val set_status_bar_commands : t -> Command.t list -> unit
      [@@js.set "statusBarCommands"]

    val create_resource_group :
      t -> id:string -> label:string -> Source_control_resource_group.t
      [@@js.call "createResourceGroup"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "SourceControl"]

  module Scm : sig
    val input_box : Source_control_input_box.t [@@js.global "inputBox"]

    val create_source_control :
      id:string -> label:string -> ?root_uri:Uri.t -> unit -> Source_control.t
      [@@js.global "createSourceControl"]
  end
  [@@js.scope "scm"]

  module Debug_protocol_message : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Debug_protocol_source : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Breakpoint : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val enabled : t -> bool [@@js.get "enabled"]

    val condition : t -> string [@@js.get "condition"]

    val hit_condition : t -> string [@@js.get "hitCondition"]

    val log_message : t -> string [@@js.get "logMessage"]

    val create :
         ?enabled:bool
      -> ?condition:string
      -> ?hit_condition:string
      -> ?log_message:string
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "Breakpoint"]

  module Source_breakpoint : sig
    include module type of struct
      include Breakpoint
    end

    val location : t -> Location.t [@@js.get "location"]

    val create :
         location:Location.t
      -> ?enabled:bool
      -> ?condition:string
      -> ?hit_condition:string
      -> ?log_message:string
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "SourceBreakpoint"]

  module Function_breakpoint : sig
    include module type of struct
      include Breakpoint
    end

    val function_name : t -> string [@@js.get "functionName"]

    val create :
         function_name:string
      -> ?enabled:bool
      -> ?condition:string
      -> ?hit_condition:string
      -> ?log_message:string
      -> unit
      -> t
      [@@js.create]

    include module type of struct
      include Breakpoint
    end
  end
  [@@js.scope "FunctionBreakpoint"]

  module Breakpoints_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val added : t -> Breakpoint.t list [@@js.get "added"]

    val removed : t -> Breakpoint.t list [@@js.get "removed"]

    val changed : t -> Breakpoint.t list [@@js.get "changed"]
  end
  [@@js.scope "BreakpointsChangeEvent"]

  module Debug_protocol_breakpoint : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Debug_configuration : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val type_ : t -> string [@@js.get "type"]

    val set_type : t -> string -> unit [@@js.set "type"]

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val request : t -> string [@@js.get "request"]

    val set_request : t -> string -> unit [@@js.set "request"]

    val get : t -> string -> any [@@js.index_get]

    val set : t -> string -> any -> unit [@@js.index_set]
  end
  [@@js.scope "DebugConfiguration"]

  module Debug_session : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val type_ : t -> string [@@js.get "type"]

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val workspace_folder : t -> Workspace_folder.t or_undefined
      [@@js.get "workspaceFolder"]

    val configuration : t -> Debug_configuration.t [@@js.get "configuration"]

    val custom_request :
      t -> command:string -> ?args:any -> unit -> any Promise.t
      [@@js.call "customRequest"]

    val get_debug_protocol_breakpoint :
         t
      -> breakpoint:Breakpoint.t
      -> Debug_protocol_breakpoint.t or_undefined Promise.t
      [@@js.call "getDebugProtocolBreakpoint"]
  end
  [@@js.scope "DebugSession"]

  module Debug_session_custom_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val session : t -> Debug_session.t [@@js.get "session"]

    val event : t -> string [@@js.get "event"]

    val body : t -> any [@@js.get "body"]
  end
  [@@js.scope "DebugSessionCustomEvent"]

  module Debug_configuration_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_debug_configurations :
         t
      -> folder:Workspace_folder.t or_undefined
      -> ?token:Cancellation_token.t
      -> unit
      -> Debug_configuration.t list Provider_result.t
      [@@js.call "provideDebugConfigurations"]

    val resolve_debug_configuration :
         t
      -> folder:Workspace_folder.t or_undefined
      -> debug_configuration:Debug_configuration.t
      -> ?token:Cancellation_token.t
      -> unit
      -> Debug_configuration.t Provider_result.t
      [@@js.call "resolveDebugConfiguration"]

    val resolve_debug_configuration_with_substituted_variables :
         t
      -> folder:Workspace_folder.t or_undefined
      -> debug_configuration:Debug_configuration.t
      -> ?token:Cancellation_token.t
      -> unit
      -> Debug_configuration.t Provider_result.t
      [@@js.call "resolveDebugConfigurationWithSubstitutedVariables"]
  end
  [@@js.scope "DebugConfigurationProvider"]

  module Debug_adapter_executable_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    module Env : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get : t -> string -> string [@@js.index_get]

      val set : t -> string -> string -> unit [@@js.index_set]
    end

    val env : t -> Env.t [@@js.get "env"]

    val set_env : t -> Env.t -> unit [@@js.set "env"]

    val cwd : t -> string [@@js.get "cwd"]

    val set_cwd : t -> string -> unit [@@js.set "cwd"]
  end
  [@@js.scope "DebugAdapterExecutableOptions"]

  module Debug_adapter_executable : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create :
         command:string
      -> ?args:string list
      -> ?options:Debug_adapter_executable_options.t
      -> unit
      -> t
      [@@js.create]

    val command : t -> string [@@js.get "command"]

    val args : t -> string list [@@js.get "args"]

    val options : t -> Debug_adapter_executable_options.t [@@js.get "options"]
  end
  [@@js.scope "DebugAdapterExecutable"]

  module Debug_adapter_server : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val port : t -> int [@@js.get "port"]

    val host : t -> string [@@js.get "host"]

    val create : port:int -> ?host:string -> unit -> t [@@js.create]
  end
  [@@js.scope "DebugAdapterServer"]

  module Debug_adapter_named_pipe_server : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val path : t -> string [@@js.get "path"]

    val create : path:string -> t [@@js.create]
  end
  [@@js.scope "DebugAdapterNamedPipeServer"]

  module Debug_adapter : sig
    include module type of struct
      include Disposable
    end

    val on_did_send_message : t -> Debug_protocol_message.t Event.t
      [@@js.get "onDidSendMessage"]

    val handle_message : t -> message:Debug_protocol_message.t -> unit
      [@@js.call "handleMessage"]
  end
  [@@js.scope "DebugAdapter"]

  module Debug_adapter_inline_implementation : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : implementation:Debug_adapter.t -> t [@@js.create]
  end
  [@@js.scope "DebugAdapterInlineImplementation"]

  module Debug_adapter_descriptor : sig
    type t =
      ( Debug_adapter_executable.t
      , Debug_adapter_inline_implementation.t
      , Debug_adapter_named_pipe_server.t
      , Debug_adapter_server.t )
      union4

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Debug_adapter_descriptor_factory : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create_debug_adapter_descriptor :
         t
      -> session:Debug_session.t
      -> executable:Debug_adapter_executable.t or_undefined
      -> Debug_adapter_descriptor.t Provider_result.t
      [@@js.call "createDebugAdapterDescriptor"]
  end
  [@@js.scope "DebugAdapterDescriptorFactory"]

  module Debug_adapter_tracker : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val on_will_start_session : t -> unit [@@js.call "onWillStartSession"]

    val on_will_receive_message : t -> message:any -> unit
      [@@js.call "onWillReceiveMessage"]

    val on_did_send_message : t -> message:any -> unit
      [@@js.call "onDidSendMessage"]

    val on_will_stop_session : t -> unit [@@js.call "onWillStopSession"]

    val on_error : t -> error:Error.t -> unit [@@js.call "onError"]

    val on_exit :
      t -> code:int or_undefined -> signal:string or_undefined -> unit
      [@@js.call "onExit"]
  end
  [@@js.scope "DebugAdapterTracker"]

  module Debug_adapter_tracker_factory : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create_debug_adapter_tracker :
      t -> session:Debug_session.t -> Debug_adapter_tracker.t Provider_result.t
      [@@js.call "createDebugAdapterTracker"]
  end
  [@@js.scope "DebugAdapterTrackerFactory"]

  module Debug_console : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val append : t -> value:string -> unit [@@js.call "append"]

    val append_line : t -> value:string -> unit [@@js.call "appendLine"]
  end
  [@@js.scope "DebugConsole"]

  module Debug_console_mode : sig
    type t =
      ([ `Separate [@js 0]
       | `MergeWithParent [@js 1]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Debug_session_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val parent_session : t -> Debug_session.t [@@js.get "parentSession"]

    val set_parent_session : t -> Debug_session.t -> unit
      [@@js.set "parentSession"]

    val console_mode : t -> Debug_console_mode.t [@@js.get "consoleMode"]

    val set_console_mode : t -> Debug_console_mode.t -> unit
      [@@js.set "consoleMode"]

    val no_debug : t -> bool [@@js.get "noDebug"]

    val set_no_debug : t -> bool -> unit [@@js.set "noDebug"]

    val compact : t -> bool [@@js.get "compact"]

    val set_compact : t -> bool -> unit [@@js.set "compact"]
  end
  [@@js.scope "DebugSessionOptions"]

  module Debug_configuration_provider_trigger_kind : sig
    type t =
      ([ `Initial [@js 1]
       | `Dynamic [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Debug : sig
    val active_debug_session : Debug_session.t or_undefined
      [@@js.global "activeDebugSession"]

    val active_debug_console : Debug_console.t
      [@@js.global "activeDebugConsole"]

    val breakpoints : Breakpoint.t list [@@js.global "breakpoints"]

    val on_did_change_active_debug_session :
      Debug_session.t or_undefined Event.t
      [@@js.global "onDidChangeActiveDebugSession"]

    val on_did_start_debug_session : Debug_session.t Event.t
      [@@js.global "onDidStartDebugSession"]

    val on_did_receive_debug_session_custom_event :
      Debug_session_custom_event.t Event.t
      [@@js.global "onDidReceiveDebugSessionCustomEvent"]

    val on_did_terminate_debug_session : Debug_session.t Event.t
      [@@js.global "onDidTerminateDebugSession"]

    val on_did_change_breakpoints : Breakpoints_change_event.t Event.t
      [@@js.global "onDidChangeBreakpoints"]

    val register_debug_configuration_provider :
         debug_type_:string
      -> provider:Debug_configuration_provider.t
      -> ?trigger_kind:Debug_configuration_provider_trigger_kind.t
      -> unit
      -> Disposable.t
      [@@js.global "registerDebugConfigurationProvider"]

    val register_debug_adapter_descriptor_factory :
         debug_type_:string
      -> factory:Debug_adapter_descriptor_factory.t
      -> Disposable.t
      [@@js.global "registerDebugAdapterDescriptorFactory"]

    val register_debug_adapter_tracker_factory :
         debug_type_:string
      -> factory:Debug_adapter_tracker_factory.t
      -> Disposable.t
      [@@js.global "registerDebugAdapterTrackerFactory"]

    val start_debugging :
         folder:Workspace_folder.t or_undefined
      -> name_or_configuration:Debug_configuration.t or_string
      -> ?parent_session_or_options:
           (Debug_session.t, Debug_session_options.t) union2
      -> unit
      -> bool Promise.t
      [@@js.global "startDebugging"]

    val stop_debugging : ?session:Debug_session.t -> unit -> unit Promise.t
      [@@js.global "stopDebugging"]

    val add_breakpoints : breakpoints:Breakpoint.t list -> unit
      [@@js.global "addBreakpoints"]

    val remove_breakpoints : breakpoints:Breakpoint.t list -> unit
      [@@js.global "removeBreakpoints"]

    val as_debug_source_uri :
         source:Debug_protocol_source.t
      -> ?session:Debug_session.t
      -> unit
      -> Uri.t
      [@@js.global "asDebugSourceUri"]
  end
  [@@js.scope "debug"]

  module Extensions : sig
    val get_extension : extension_id:string -> any Extension.t or_undefined
      [@@js.global "getExtension"]

    val get_extension : extension_id:string -> 'T Extension.t or_undefined
      [@@js.global "getExtension"]

    val all : any Extension.t list [@@js.global "all"]

    val on_did_change : unit Event.t [@@js.global "onDidChange"]
  end
  [@@js.scope "extensions"]

  module Comment_thread_collapsible_state : sig
    type t =
      ([ `Collapsed [@js 0]
       | `Expanded [@js 1]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Comment_mode : sig
    type t =
      ([ `Editing [@js 0]
       | `Preview [@js 1]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Comment_author_information : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val icon_path : t -> Uri.t [@@js.get "iconPath"]

    val set_icon_path : t -> Uri.t -> unit [@@js.set "iconPath"]
  end
  [@@js.scope "CommentAuthorInformation"]

  module Comment_reaction : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val label : t -> string [@@js.get "label"]

    val icon_path : t -> Uri.t or_string [@@js.get "iconPath"]

    val count : t -> int [@@js.get "count"]

    val author_has_reacted : t -> bool [@@js.get "authorHasReacted"]
  end
  [@@js.scope "CommentReaction"]

  module Comment : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val body : t -> Markdown_string.t or_string [@@js.get "body"]

    val set_body : t -> Markdown_string.t or_string -> unit [@@js.set "body"]

    val mode : t -> Comment_mode.t [@@js.get "mode"]

    val set_mode : t -> Comment_mode.t -> unit [@@js.set "mode"]

    val author : t -> Comment_author_information.t [@@js.get "author"]

    val set_author : t -> Comment_author_information.t -> unit
      [@@js.set "author"]

    val context_value : t -> string [@@js.get "contextValue"]

    val set_context_value : t -> string -> unit [@@js.set "contextValue"]

    val reactions : t -> Comment_reaction.t list [@@js.get "reactions"]

    val set_reactions : t -> Comment_reaction.t list -> unit
      [@@js.set "reactions"]

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]
  end
  [@@js.scope "Comment"]

  module Comment_thread : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val uri : t -> Uri.t [@@js.get "uri"]

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val comments : t -> Comment.t list [@@js.get "comments"]

    val set_comments : t -> Comment.t list -> unit [@@js.set "comments"]

    val collapsible_state : t -> Comment_thread_collapsible_state.t
      [@@js.get "collapsibleState"]

    val set_collapsible_state : t -> Comment_thread_collapsible_state.t -> unit
      [@@js.set "collapsibleState"]

    val can_reply : t -> bool [@@js.get "canReply"]

    val set_can_reply : t -> bool -> unit [@@js.set "canReply"]

    val context_value : t -> string [@@js.get "contextValue"]

    val set_context_value : t -> string -> unit [@@js.set "contextValue"]

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "CommentThread"]

  module Comment_reply : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val thread : t -> Comment_thread.t [@@js.get "thread"]

    val set_thread : t -> Comment_thread.t -> unit [@@js.set "thread"]

    val text : t -> string [@@js.get "text"]

    val set_text : t -> string -> unit [@@js.set "text"]
  end
  [@@js.scope "CommentReply"]

  module Commenting_range_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_commenting_ranges :
         t
      -> document:Text_document.t
      -> token:Cancellation_token.t
      -> Range.t list Provider_result.t
      [@@js.call "provideCommentingRanges"]
  end
  [@@js.scope "CommentingRangeProvider"]

  module Comment_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val prompt : t -> string [@@js.get "prompt"]

    val set_prompt : t -> string -> unit [@@js.set "prompt"]

    val place_holder : t -> string [@@js.get "placeHolder"]

    val set_place_holder : t -> string -> unit [@@js.set "placeHolder"]
  end
  [@@js.scope "CommentOptions"]

  module Comment_controller : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val label : t -> string [@@js.get "label"]

    val options : t -> Comment_options.t [@@js.get "options"]

    val set_options : t -> Comment_options.t -> unit [@@js.set "options"]

    val commenting_range_provider : t -> Commenting_range_provider.t
      [@@js.get "commentingRangeProvider"]

    val set_commenting_range_provider : t -> Commenting_range_provider.t -> unit
      [@@js.set "commentingRangeProvider"]

    val create_comment_thread :
         t
      -> uri:Uri.t
      -> range:Range.t
      -> comments:Comment.t list
      -> Comment_thread.t
      [@@js.call "createCommentThread"]

    val reaction_handler :
      t -> comment:Comment.t -> reaction:Comment_reaction.t -> unit Promise.t
      [@@js.call "reactionHandler"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "CommentController"]

  module Comments : sig
    val create_comment_controller :
      id:string -> label:string -> Comment_controller.t
      [@@js.global "createCommentController"]
  end
  [@@js.scope "comments"]

  module Authentication_session_account_information : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val label : t -> string [@@js.get "label"]
  end
  [@@js.scope "AuthenticationSessionAccountInformation"]

  module Authentication_session : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val access_token : t -> string [@@js.get "accessToken"]

    val account : t -> Authentication_session_account_information.t
      [@@js.get "account"]

    val scopes : t -> string list [@@js.get "scopes"]
  end
  [@@js.scope "AuthenticationSession"]

  module Authentication_get_session_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create_if_none : t -> bool [@@js.get "createIfNone"]

    val set_create_if_none : t -> bool -> unit [@@js.set "createIfNone"]

    val clear_session_preference : t -> bool [@@js.get "clearSessionPreference"]

    val set_clear_session_preference : t -> bool -> unit
      [@@js.set "clearSessionPreference"]
  end
  [@@js.scope "AuthenticationGetSessionOptions"]

  module Authentication_provider_information : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val label : t -> string [@@js.get "label"]
  end
  [@@js.scope "AuthenticationProviderInformation"]

  module Authentication_sessions_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provider : t -> Authentication_provider_information.t
      [@@js.get "provider"]
  end
  [@@js.scope "AuthenticationSessionsChangeEvent"]

  module Authentication_provider_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val supports_multiple_accounts : t -> bool
      [@@js.get "supportsMultipleAccounts"]
  end
  [@@js.scope "AuthenticationProviderOptions"]

  module Authentication_provider_authentication_sessions_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val added : t -> Authentication_session.t list [@@js.get "added"]

    val removed : t -> Authentication_session.t list [@@js.get "removed"]

    val changed : t -> Authentication_session.t list [@@js.get "changed"]
  end
  [@@js.scope "AuthenticationProviderAuthenticationSessionsChangeEvent"]

  module Authentication_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val on_did_change_sessions :
         t
      -> Authentication_provider_authentication_sessions_change_event.t Event.t
      [@@js.get "onDidChangeSessions"]

    val get_sessions :
         t
      -> ?scopes:string list
      -> unit
      -> Authentication_session.t list Promise.t
      [@@js.call "getSessions"]

    val create_session :
      t -> scopes:string list -> Authentication_session.t Promise.t
      [@@js.call "createSession"]

    val remove_session : t -> session_id:string -> unit Promise.t
      [@@js.call "removeSession"]
  end
  [@@js.scope "AuthenticationProvider"]

  module Authentication : sig
    module Authentication_get_session_options2 : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val create_if_none : t -> ([ `L_b_true [@js true] ][@js.enum])
        [@@js.get "createIfNone"]

      val set_create_if_none : t -> ([ `L_b_true ][@js.enum]) -> unit
        [@@js.set "createIfNone"]
    end

    val get_session :
         provider_id:string
      -> scopes:string list
      -> options:
           ( Authentication_get_session_options.t
           , Authentication_get_session_options2.t )
           intersection2
      -> Authentication_session.t Promise.t
      [@@js.global "getSession"]

    val get_session :
         provider_id:string
      -> scopes:string list
      -> ?options:Authentication_get_session_options.t
      -> unit
      -> Authentication_session.t or_undefined Promise.t
      [@@js.global "getSession"]

    val on_did_change_sessions : Authentication_sessions_change_event.t Event.t
      [@@js.global "onDidChangeSessions"]

    val register_authentication_provider :
         id:string
      -> label:string
      -> provider:Authentication_provider.t
      -> ?options:Authentication_provider_options.t
      -> unit
      -> Disposable.t
      [@@js.global "registerAuthenticationProvider"]
  end
  [@@js.scope "authentication"]
end
[@@js.scope "vscode"]

include module type of struct
  include Vscode
end
