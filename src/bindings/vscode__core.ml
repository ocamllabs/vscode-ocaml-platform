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

  val is_before : t -> other:t -> bool [@@js.call]

  val is_before_or_equal : t -> other:t -> bool [@@js.call]

  val is_after : t -> other:t -> bool [@@js.call]

  val is_after_or_equal : t -> other:t -> bool [@@js.call]

  val is_equal : t -> other:t -> bool [@@js.call]

  val compare_to : t -> other:t -> int [@@js.call]

  val translate : t -> ?line_delta:int -> ?character_delta:int -> unit -> t
    [@@js.call]

  val with_ : t -> ?line:int -> ?character:int -> unit -> t [@@js.call]
end

module Range = struct
  type t = private (* class *) Ojs.t [@@js]

  val start : t -> Position.t [@@js.get]

  val end_ : t -> Position.t [@@js.get]

  val make_positions : start:Position.t -> end_:Position.t -> t
    [@@js.new "vscode.Range"]

  val make_coordinates :
       start_line:int
    -> start_character:int
    -> end_line:int
    -> end_character:int
    -> t
    [@@js.new "vscode.Range"]

  val is_empty : t -> bool [@@js.get]

  val is_single_line : t -> bool [@@js.get]

  val contains :
       t
    -> position_or_range:([ `Position of Position.t | `Range of t ][@js.union])
    -> bool
    [@@js.call]

  val is_equal : t -> other:t -> bool [@@js.call]

  val intersection : t -> range:t -> t or_undefined [@@js.call]

  val union : t -> other:t -> t [@@js.call]

  val with_ : t -> ?start:Position.t -> ?end_:Position.t -> unit -> t
    [@@js.call]
end

module TextLine = struct
  type t = private (* interface *) Ojs.t [@@js]

  val line_number : t -> int [@@js.get]

  val text : t -> string [@@js.get]

  val range : t -> Range.t [@@js.get]

  val range_including_line_break : t -> Range.t [@@js.get]

  val first_non_whitespace_character_index : t -> int [@@js.get]

  val is_empty_or_whitespace : t -> bool [@@js.get]

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

module EndOfLine = struct
  type t =
    | CRLF [@js 2]
    | LF [@js 1]
  [@@js.enum] [@@js]
end

module TextEdit = struct
  type t = private (* class *) Ojs.t [@@js]

  val replace : range:Range.t -> new_text:string -> t
    [@@js.global "vscode.TextEdit.replace"]

  val insert : position:Position.t -> new_text:string -> t
    [@@js.global "vscode.TextEdit.insert"]

  val delete : Range.t -> t [@@js.global "vscode.TextEdit.delete"]

  val set_end_of_line : EndOfLine.t -> t
    [@@js.global "vscode.TextEdit.setEndOfLine"]

  val range : t -> Range.t [@@js.get]

  val new_text : t -> string [@@js.get]

  val new_eol : t -> EndOfLine.t or_undefined [@@js.get]

  val make : range:Range.t -> new_text:string -> t [@@js.new "vscode.TextEdit"]
end

module Uri = struct
  type t = private (* class *) Ojs.t [@@js]

  val parse : string -> ?strict:bool -> unit -> t
    [@@js.global "vscode.Uri.parse"]

  val file : string -> t [@@js.global "vscode.Uri.file"]

  val join_path : t -> path_segments:(string list[@js.variadic]) -> t
    [@@js.global "vscode.Uri.joinPath"]

  val scheme : t -> string [@@js.get]

  val authority : t -> string [@@js.get]

  val path : t -> string [@@js.get]

  val query : t -> string [@@js.get]

  val fragment : t -> string [@@js.get]

  val fs_path : t -> string [@@js.get]

  val with_ : t -> Ojs.t -> t [@@js.call]

  let with_ this ?scheme ?authority ?path ?query ?fragment () =
    let change = Ojs.obj [||] in
    iter_set change "scheme" Ojs.string_to_js scheme;
    iter_set change "authority" Ojs.string_to_js authority;
    iter_set change "path" Ojs.string_to_js path;
    iter_set change "query" Ojs.string_to_js query;
    iter_set change "fragment" Ojs.string_to_js fragment;
    with_ this change

  val to_string : t -> ?skip_encoding:bool -> unit -> string [@@js.call]

  val to_json : t -> Jsonoo.t [@@js.call]
end

module TextDocument = struct
  type t = private (* interface *) Ojs.t [@@js]

  val uri : t -> Uri.t [@@js.get]

  val file_name : t -> string [@@js.get]

  val is_untitled : t -> bool [@@js.get]

  val language_id : t -> string [@@js.get]

  val version : t -> int [@@js.get]

  val is_dirty : t -> bool [@@js.get]

  val is_closed : t -> bool [@@js.get]

  val save : t -> bool Promise.t [@@js.call]

  val eol : t -> EndOfLine.t [@@js.get]

  val line_count : t -> int [@@js.get]

  val line_at : t -> line:int -> TextLine.t [@@js.call]

  val line_at_position : t -> position:Position.t -> TextLine.t
    [@@js.call "lineAt"]

  val offset_at : t -> position:Position.t -> int [@@js.call]

  val position_at : t -> offset:int -> Position.t [@@js.call]

  val get_text : t -> ?range:Range.t -> unit -> string [@@js.call]

  val get_word_range_at_position :
    t -> position:Position.t -> ?regex:Regexp.t -> unit -> Range.t or_undefined
    [@@js.call]

  val validate_range : t -> range:Range.t -> Range.t [@@js.call]

  val validate_position : t -> position:Position.t -> Position.t [@@js.call]
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

  val make_positions : anchor:Position.t -> active:Position.t -> t
    [@@js.new "vscode.Selection"]

  val make_coordinates :
       anchor_line:int
    -> anchor_character:int
    -> active_line:int
    -> active_character:int
    -> t
    [@@js.new "vscode.Selection"]

  val is_reversed : t -> bool [@@js.get]
end

module TextEditorEdit = struct
  type t = private (* interface *) Ojs.t [@@js]

  type replace_location =
    ([ `Position of Position.t
     | `Range of Range.t
     | `Selection of Selection.t
     ]
    [@js.union])
  [@@js]

  let replace_location_of_js js_val =
    if Ojs.has_property js_val "anchor" then
      `Position (Selection.t_of_js js_val)
    else if Ojs.has_property js_val "start" then
      `Range (Range.t_of_js js_val)
    else
      `Selection (Selection.t_of_js js_val)

  type delete_location =
    ([ `Range of Range.t
     | `Selection of Selection.t
     ]
    [@js.union])
  [@@js]

  let delete_location_of_js js_val =
    if Ojs.has_property js_val "anchor" then
      `Selection (Selection.t_of_js js_val)
    else
      `Range (Range.t_of_js js_val)

  val replace : t -> location:replace_location -> value:string -> unit
    [@@js.call]

  val insert : t -> location:Position.t -> value:string -> unit [@@js.call]

  val delete : t -> location:delete_location -> unit [@@js.call]

  val set_end_of_line : t -> end_of_line:EndOfLine.t -> t [@@js.call]

  val create :
       replace:(location:replace_location -> value:string -> unit)
    -> insert:(location:Position.t -> value:string -> unit)
    -> delete:(location:delete_location -> unit)
    -> set_end_of_line:(end_of_line:EndOfLine.t -> t)
    -> t
    [@@js.builder]
end

module TextEditorCursorStyle = struct
  type t =
    | Line [@js 1]
    | Block [@js 2]
    | Underline [@js 3]
    | Line_thin [@js 4]
    | Block_outline [@js 5]
    | Underline_thin [@js 6]
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
    | In_center [@js 1]
    | In_center_if_outside_viewport [@js 2]
    | At_top [@js 3]
  [@@js.enum] [@@js]
end

module TextEditorOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type tab_size =
    ([ `Int of int
     | `String of string
     ]
    [@js.union])
  [@@js]

  let tab_size_of_js js_val =
    match Ojs.type_of js_val with
    | "number" -> `Int (Ojs.int_of_js js_val)
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> assert false

  type insert_spaces =
    ([ `Bool of bool
     | `String of string
     ]
    [@js.union])
  [@@js]

  let insert_spaces_of_js js_val =
    match Ojs.type_of js_val with
    | "boolean" -> `Bool (Ojs.bool_of_js js_val)
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> assert false

  val tab_size : t -> tab_size or_undefined [@@js.get]

  val insert_spaces : t -> insert_spaces or_undefined [@@js.get]

  val cursor_style : t -> TextEditorCursorStyle.t or_undefined [@@js.get]

  val line_numbers : t -> TextEditorLineNumbersStyle.t or_undefined [@@js.get]

  val create :
       ?tab_size:tab_size
    -> ?insert_spaces:insert_spaces
    -> ?cursor_style:TextEditorCursorStyle.t
    -> ?line_numbers:TextEditorLineNumbersStyle.t
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

  val is_trusted : t -> bool or_undefined [@@js.get]

  val support_theme_icons : t -> bool or_undefined [@@js.get]

  val make : ?value:string -> ?support_theme_icons:bool -> unit -> t
    [@@js.new "vscode.MarkdownString"]

  val append_text : t -> value:string -> t [@@js.call]

  val append_markdown : t -> value:string -> t [@@js.call]

  val append_codeblock : t -> value:string -> ?language:string -> unit -> t
    [@@js.call]
end

module ThemeColor = struct
  type t = private (* class *) Ojs.t [@@js]

  val make : id:string -> t [@@js.new "vscode.ThemeColor"]
end

module ThemableDecorationAttachmentRenderOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type content_icon_path =
    ([ `String of string
     | `Uri of Uri.t
     ]
    [@js.union])
  [@@js]

  let content_icon_path_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> `Uri (Uri.t_of_js js_val)

  type color =
    ([ `String of string
     | `ThemeColor of ThemeColor.t
     ]
    [@js.union])
  [@@js]

  let color_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> `ThemeColor (ThemeColor.t_of_js js_val)

  val content_text : t -> string or_undefined [@@js.get]

  val content_icon_path : t -> content_icon_path or_undefined [@@js.get]

  val border : t -> string or_undefined [@@js.get]

  val border_color : t -> color or_undefined [@@js.get]

  val font_style : t -> string or_undefined [@@js.get]

  val font_weight : t -> string or_undefined [@@js.get]

  val text_decoration : t -> string or_undefined [@@js.get]

  val color : t -> color or_undefined [@@js.get]

  val background_color : t -> color or_undefined [@@js.get]

  val margin : t -> string or_undefined [@@js.get]

  val width : t -> string or_undefined [@@js.get]

  val height : t -> string or_undefined [@@js.get]

  val create :
       ?content_text:string
    -> ?content_icon_path:content_icon_path
    -> ?border:string
    -> ?border_color:color
    -> ?font_style:string
    -> ?font_weight:string
    -> ?text_decoration:string
    -> ?color:color
    -> ?background_color:color
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

  type hover_message =
    ([ `MarkdownString of MarkdownString.t
     | `MarkdownStrings of MarkdownString.t list
     ]
    [@js.union])
  [@@js]

  let hover_message_of_js js_val =
    if Ojs.has_property js_val "value" then
      `MarkdownString (MarkdownString.t_of_js js_val)
    else
      `MarkdownStrings (Ojs.list_of_js MarkdownString.t_of_js js_val)

  val range : t -> Range.t [@@js.get]

  val hover_message : t -> hover_message or_undefined [@@js.get]

  val render_options : t -> DecorationInstanceRenderOptions.t or_undefined
    [@@js.get]

  val create :
       range:Range.t
    -> ?hover_message:hover_message
    -> ?render_options:DecorationInstanceRenderOptions.t or_undefined
    -> unit
    -> t
    [@@js.builder]
end

module SnippetString = struct
  type t = private (* class *) Ojs.t [@@js]

  val value : t -> string [@@js.get]

  val make : ?value:string -> unit -> t [@@js.new "vscode.SnippetString"]

  val append_text : t -> string:string -> t [@@js.call]

  val append_tab_stop : t -> number:int -> t [@@js.call]

  val append_place_holder :
       t
    -> value:([ `String of string | `Function of t -> unit ][@js.union])
    -> ?number:int
    -> unit
    -> t
    [@@js.call]

  val append_choice : t -> values:string list -> ?number:int -> unit -> t
    [@@js.call]

  val append_variable :
       t
    -> name:string
    -> default_value:([ `String of string | `Function of t -> unit ][@js.union])
    -> t
    [@@js.call]
end

module TextEditor = struct
  type t = private (* interface*) Ojs.t [@@js]

  type insert_snippet_location =
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

  val visible_ranges : t -> Range.t list [@@js.get]

  val options : t -> TextEditorOptions.t [@@js.get]

  val view_column : t -> ViewColumn.t or_undefined [@@js.get]

  val edit :
       t
    -> callback:(edit_builder:TextEditorEdit.t -> unit)
    -> Ojs.t
    -> unit
    -> bool Promise.t
    [@@js.call]

  let edit this ~callback ?undo_stop_before ?undo_stop_after () =
    let options = Ojs.obj [||] in
    iter_set options "undoStopBefore" Ojs.bool_to_js undo_stop_before;
    iter_set options "undoStopAfter" Ojs.bool_to_js undo_stop_after;
    edit this ~callback options ()

  val insert_snippet :
       t
    -> snippet:SnippetString.t
    -> ?location:insert_snippet_location
    -> Ojs.t
    -> bool Promise.t
    [@@js.call]

  let insert_snippet this ~snippet ?location ?undo_stop_before ?undo_stop_after
      () =
    let options = Ojs.obj [||] in
    iter_set options "undoStopBefore" Ojs.bool_to_js undo_stop_before;
    iter_set options "undoStopAfter" Ojs.bool_to_js undo_stop_after;
    insert_snippet this ~snippet ?location options

  val set_decorations :
       t
    -> decoration_type:TextEditorDecorationType.t
    -> ranges_or_options:
         ([ `Ranges of Range.t list | `Options of DecorationOptions.t list ]
         [@js.union])
    -> unit
    [@@js.call]

  val reveal_range :
    t -> range:Range.t -> ?reveal_type:TextEditorRevealType.t -> unit -> unit
    [@@js.call]
end

module ConfigurationTarget = struct
  type t =
    | Global [@js 1]
    | Workspace [@js 2]
    | Workspace_folder [@js 3]
  [@@js.enum] [@@js]
end

module WorkspaceConfiguration = struct
  type t = private (* interface *) Ojs.t [@@js]

  type configuration_target =
    ([ `ConfigurationTarget of ConfigurationTarget.t
     | `Bool of bool
     ]
    [@js.union])
  [@@js]

  type inspect_result =
    { key : string
    ; default_value : Jsonoo.t or_undefined
    ; global_value : Jsonoo.t or_undefined
    ; workspace_value : Jsonoo.t or_undefined
    ; workspace_folder_value : Jsonoo.t or_undefined
    ; default_language_value : Jsonoo.t or_undefined
    ; global_language_value : Jsonoo.t or_undefined
    ; workspace_language_value : Jsonoo.t or_undefined
    ; workspace_folder_language_value : Jsonoo.t or_undefined
    ; language_ids : string or_undefined
    }
  [@@js]

  val get : t -> section:string -> unit -> Jsonoo.t or_undefined [@@js.call]

  val has : t -> section:string -> bool [@@js.call]

  val inspect : t -> section:string -> inspect_result [@@js.call]

  val update :
       t
    -> section:string
    -> value:Jsonoo.t
    -> ?configuration_target:configuration_target
    -> ?override_in_language:bool
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
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> `ThemeColor (ThemeColor.t_of_js js_val)

  type command =
    ([ `String of string
     | `Command of Command.t
     ]
    [@js.union])
  [@@js]

  let command_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> `Command (Command.t_of_js js_val)

  val alignment : t -> StatusBarAlignment.t [@@js.get]

  val priority : t -> int or_undefined [@@js.get]

  val text : t -> string [@@js.get]

  val tooltip : t -> string or_undefined [@@js.get]

  val color : t -> color or_undefined [@@js.get]

  val command : t -> command or_undefined [@@js.get]

  val accessibility_information : t -> AccessibilityInformation.t or_undefined
    [@@js.get]

  val set_alignment : t -> StatusBarAlignment.t -> unit [@@js.set]

  val set_priority : t -> int -> unit [@@js.set]

  val set_text : t -> string -> unit [@@js.set]

  val set_tooltip : t -> string -> unit [@@js.set]

  val set_color : t -> color -> unit [@@js.set]

  val set_command : t -> command -> unit [@@js.set]

  val set_accessibility_information : t -> AccessibilityInformation.t -> unit
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

  val tab_size : t -> int [@@js.get]

  val insert_spaces : t -> bool [@@js.get]

  val create : tab_size:int -> insert_spaces:bool -> t [@@js.builder]
end

module Event = struct
  type 'a t = listener:('a -> unit) -> Disposable.t

  let t_of_js ml_of_js js_fun =
   fun [@js.dummy] ~listener:ml_listener ->
    let js_listener =
      Ojs.fun_to_js 1 @@ fun js_arg -> ml_listener (ml_of_js js_arg)
    in
    let (disposable : Ojs.t) =
      Ojs.call js_fun "call" [| Ojs.null; js_listener |]
    in
    Disposable.t_of_js disposable

  let t_to_js ml_to_js ml_fun =
    Ojs.fun_to_js 1 @@ fun js_listener ->
    let ml_listener ml_arg =
      ignore @@ Ojs.call js_listener "call" [| Ojs.null; ml_to_js ml_arg |]
    in
    let (disposable : Disposable.t) = ml_fun ~listener:ml_listener in
    Disposable.t_to_js disposable
end

module CancellationToken = struct
  type t = private (* interface *) Ojs.t [@@js]

  val is_cancellation_requested : t -> bool [@@js.get]

  val on_cancellation_requested : t -> Ojs.t Event.t [@@js.get]

  val create :
       is_cancellation_requested:bool
    -> on_cancellation_requested:Ojs.t Event.t
    -> t
    [@@js.builder]
end

module QuickPickItem = struct
  type t = private (* interface *) Ojs.t [@@js]

  val label : t -> string [@@js.get]

  val description : t -> string or_undefined [@@js.get]

  val detail : t -> string or_undefined [@@js.get]

  val picked : t -> bool or_undefined [@@js.get]

  val always_show : t -> bool or_undefined [@@js.get]

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

module QuickPickOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type on_did_select_item_args =
    ([ `QuickPickItem of QuickPickItem.t
     | `String of string
     ]
    [@js.union])
  [@@js]

  let on_did_select_item_args_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> `QuickPickItem (QuickPickItem.t_of_js js_val)

  val match_on_description : t -> bool or_undefined [@@js.get]

  val match_on_detail : t -> bool or_undefined [@@js.get]

  val place_holder : t -> string or_undefined [@@js.get]

  val ignore_focus_out : t -> bool or_undefined [@@js.get]

  val can_pick_many : t -> bool or_undefined [@@js.get]

  val on_did_select_item : t -> (on_did_select_item_args -> unit) or_undefined
    [@@js.get]

  val create :
       ?match_on_description:bool
    -> ?match_on_detail:bool
    -> ?place_holder:string
    -> ?ignore_focus_out:bool
    -> ?can_pick_many:bool
    -> ?on_did_select_item:(item:on_did_select_item_args -> unit)
    -> unit
    -> t
    [@@js.builder]
end

module ProviderResult = struct
  type 'a t =
    [ `Value of 'a or_undefined
    | `Promise of 'a or_undefined Promise.t
    ]

  let t_to_js to_js = function
    | `Value v -> or_undefined_to_js to_js v
    | `Promise p -> Promise.t_to_js (or_undefined_to_js to_js) p

  let t_of_js of_js js_val =
    if Ojs.has_property js_val "then" then
      `Promise (Promise.t_of_js (or_undefined_of_js of_js) js_val)
    else
      `Value (or_undefined_of_js of_js js_val)
end

module InputBoxOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val value : t -> string or_undefined [@@js.get]

  val value_selection : t -> (int * int) or_undefined [@@js.get]

  val prompt : t -> string or_undefined [@@js.get]

  val place_holder : t -> string or_undefined [@@js.get]

  val password : t -> bool or_undefined [@@js.get]

  val ignore_focus_out : t -> bool or_undefined [@@js.get]

  val validate_input : t -> (string -> string ProviderResult.t) or_undefined
    [@@js.get]

  val create :
       ?value:string
    -> ?value_selection:int * int
    -> ?prompt:string
    -> ?place_holder:string
    -> ?password:bool
    -> ?ignore_focus_out:bool
    -> ?validate_input:(value:string -> string option Promise.t)
    -> unit
    -> t
    [@@js.builder]
end

module MessageItem = struct
  type t = private (* interface *) Ojs.t [@@js]

  val title : t -> string [@@js.get]

  val is_close_affordance : t -> bool or_undefined [@@js.get]

  val create : title:string -> ?is_close_affordance:bool -> unit -> t
    [@@js.builder]
end

module Location = struct
  type t = private (* class *) Ojs.t [@@js]

  val uri : t -> Uri.t [@@js.get]

  val range : t -> Range.t [@@js.get]

  val make :
       uri:Uri.t
    -> range_or_position:([ `Range of Range.t | `Position of Position.t ]
         [@js.union])
    -> t
    [@@js.new "vscode.Location"]
end

module ProgressLocation = struct
  type t =
    | Source_control [@js 1]
    | Window [@js 10]
    | Notification [@js 25]
  [@@js.enum] [@@js]
end

module ProgressOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type view_id_location = { view_id : string } [@@js]

  type location =
    ([ `ProgressLocation of ProgressLocation.t
     | `ViewIdLocation of view_id_location
     ]
    [@js.union])
  [@@js]

  let location_of_js js_val =
    match Ojs.type_of js_val with
    | "number" -> `ProgressLocation (ProgressLocation.t_of_js js_val)
    | _ -> `ViewIdLocation (view_id_location_of_js js_val)

  val location : t -> location [@@js.get]

  val title : t -> string or_undefined [@@js.get]

  val cancellable : t -> bool or_undefined [@@js.get]

  val create :
    location:location -> ?title:string -> ?cancellable:bool -> unit -> t
    [@@js.builder]
end

module TextDocumentShowOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val view_column : t -> ViewColumn.t or_undefined [@@js.get]

  val preserve_focus : t -> bool or_undefined [@@js.get]

  val preview : t -> bool or_undefined [@@js.get]

  val selection : t -> Range.t or_undefined [@@js.get]

  val create :
       view_column:ViewColumn.t
    -> ?preserve_focus:bool
    -> ?preview:bool
    -> ?selection:Range.t
    -> unit
    -> t
    [@@js.builder]
end

module TerminalOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type shell_args =
    ([ `Arg of string
     | `Args of string list
     ]
    [@js.union])
  [@@js]

  let shell_args_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `Arg (Ojs.string_of_js js_val)
    | _ -> `Args (Ojs.list_of_js Ojs.string_of_js js_val)

  type cwd =
    ([ `String of string
     | `Uri of Uri.t
     ]
    [@js.union])
  [@@js]

  let cwd_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> `Uri (Uri.t_of_js js_val)

  val name : t -> string or_undefined [@@js.get]

  val shell_path : t -> string or_undefined [@@js.get]

  val shell_args : t -> shell_args or_undefined [@@js.get]

  val cwd : t -> cwd or_undefined [@@js.get]

  val env : t -> string or_undefined Dict.t or_undefined [@@js.get]

  val strict_env : t -> bool [@@js.get]

  val hide_from_user : t -> bool [@@js.get]
end

module TerminalDimensions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val columns : t -> int [@@js.get]

  val rows : t -> int [@@js.get]

  val create : columns:int -> rows:int -> t [@@js.builder]
end

module Pseudoterminal = struct
  type t = private (* interface *) Ojs.t [@@js]

  val on_did_write : t -> string Event.t [@@js.get]

  val on_did_override_dimensions :
    t -> TerminalDimensions.t or_undefined Event.t or_undefined
    [@@js.get]

  val on_did_close : t -> int or_undefined Event.t or_undefined [@@js.get]

  val open_ : t -> ?initial_dimensions:TerminalDimensions.t -> unit -> unit
    [@@js.call]

  val close : t -> unit [@@js.call]

  val handle_input : t -> (data:string -> unit) or_undefined [@@js.get]

  val set_dimensions :
    t -> (dimensions:TerminalDimensions.t -> unit) or_undefined
    [@@js.get]

  val create :
       on_did_write:string Event.t
    -> ?on_did_override_dimensions:TerminalDimensions.t or_undefined Event.t
    -> ?on_did_close:int or_undefined Event.t
    -> open_:(?initial_dimensions:TerminalDimensions.t -> unit -> unit)
    -> close:(unit -> unit)
    -> ?handle_input:(data:string -> unit)
    -> ?set_dimensions:(dimensions:TerminalDimensions.t -> unit)
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

  type creation_options =
    ([ `TerminalOptions of TerminalOptions.t
     | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
     ]
    [@js.union])
  [@@js]

  let creation_options_of_js js_val =
    if Ojs.has_property js_val "pty" then
      `ExtensionTerminalOptions (ExtensionTerminalOptions.t_of_js js_val)
    else
      `TerminalOptions (TerminalOptions.t_of_js js_val)

  val name : t -> string [@@js.get]

  val process_id : t -> int or_undefined Promise.t [@@js.get]

  val creation_options : t -> creation_options [@@js.get]

  val exit_status : t -> TerminalExitStatus.t or_undefined [@@js.get]

  val send_text : t -> text:string -> ?add_new_line:bool -> unit -> unit
    [@@js.call]

  val show : t -> ?preserve_focus:bool -> unit -> unit [@@js.call]

  val hide : t -> unit [@@js.call]

  val dispose : t -> unit [@@js.call]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)
end

module OutputChannel = struct
  type t = private (* interface *) Ojs.t [@@js]

  val name : t -> string [@@js.get]

  val append : t -> value:string -> unit [@@js.call]

  val append_line : t -> value:string -> unit [@@js.call]

  val clear : t -> unit [@@js.call]

  val show : t -> ?preserve_focus:bool -> unit -> unit [@@js.call]

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

  val for_each :
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

  val workspace_state : t -> Memento.t [@@js.get]

  val global_state : t -> Memento.t [@@js.get]

  val extension_uri : t -> Uri.t [@@js.get]

  val extension_path : t -> string [@@js.get]

  val environment_variable_collection : t -> EnvironmentVariableCollection.t
    [@@js.get]

  val as_absolute_path : t -> relative_path:string -> string [@@js.call]

  val storage_uri : t -> Uri.t or_undefined [@@js.get]

  val global_storage_uri : t -> Uri.t [@@js.get]

  val log_uri : t -> Uri.t [@@js.get]

  val extension_mode : t -> ExtensionMode.t [@@js.get]

  let subscribe this ~disposable =
    let subscriptions = Ojs.get this "subscriptions" in
    let (_ : Ojs.t) = Ojs.call subscriptions "push" [| disposable |] in
    ()
end

module ShellQuotingOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  type escape_literal =
    { escape_char : string
    ; chars_to_escape : string
    }
  [@@js]

  type escape =
    ([ `String of string
     | `Literal of escape_literal
     ]
    [@js.union])
  [@@js]

  let escape_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> `Literal (escape_literal_of_js js_val)

  val escape : t -> escape or_undefined [@@js.get]

  val strong : t -> string or_undefined [@@js.get]

  val weak : t -> string or_undefined [@@js.get]

  val create : ?escape:escape -> ?strong:string -> ?weak:string -> unit -> t
    [@@js.builder]
end

module ShellExecutionOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val executable : t -> string or_undefined [@@js.get]

  val shell_args : t -> string maybe_list [@@js.get]

  val shell_quoting : t -> ShellQuotingOptions.t or_undefined [@@js.get]

  val cwd : t -> string or_undefined [@@js.get]

  val env : t -> string Dict.t or_undefined [@@js.get]

  val create :
       ?executable:string
    -> ?shell_args:string list
    -> ?shell_quoting:ShellQuotingOptions.t
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

  type shell_string =
    ([ `String of string
     | `ShellQuotedString of ShellQuotedString.t
     ]
    [@js.union])
  [@@js]

  let shell_string_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> `ShellQuotedString (ShellQuotedString.t_of_js js_val)

  val make_command_line :
    command_line:string -> ?options:ShellExecutionOptions.t -> unit -> t
    [@@js.new "vscode.ShellExecution"]

  val make_command_args :
       command:shell_string
    -> args:shell_string list
    -> ?options:ShellExecutionOptions.t
    -> unit
    -> t
    [@@js.new "vscode.ShellExecution"]

  val command_line : t -> string or_undefined [@@js.get]

  val command : t -> shell_string [@@js.get]

  val args : t -> shell_string list [@@js.get]

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

  val make_process :
    process:string -> ?options:ProcessExecutionOptions.t -> unit -> t
    [@@js.new "vscode.ProcessExecution"]

  val make_process_args :
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
    let obj = Ojs.obj [| ("type", Ojs.string_to_js type_) |] in

    Core_kernel.List.iter attributes ~f:(fun (k, v) -> Ojs.set obj k v);
    obj
end

module CustomExecution = struct
  type t = private (* class *) Ojs.t [@@js]

  val make :
       callback:
         (resolved_definition:TaskDefinition.t -> Pseudoterminal.t Promise.t)
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
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> `RelativePattern (RelativePattern.t_of_js js_val)
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
  type selectors =
    ([ `Filter of DocumentFilter.t
     | `String of string
     ]
    [@js.union])
  [@@js]

  let selectors_of_js js_val =
    match Ojs.type_of js_val with
    | "string" -> `String (Ojs.string_of_js js_val)
    | _ -> `Filter (DocumentFilter.t_of_js js_val)

  type t =
    ([ `Filter of DocumentFilter.t
     | `String of string
     | `List of selectors list
     ]
    [@js.union])
  [@@js]

  let t_of_js js_val =
    if Ojs.type_of js_val = "string" then
      `String (Ojs.string_of_js js_val)
    else if Ojs.has_property js_val "length" then
      `List (Ojs.list_of_js selectors_of_js js_val)
    else
      `Filter (DocumentFilter.t_of_js js_val)
end

module DocumentFormattingEditProvider = struct
  type t = private (* interface *) Ojs.t [@@js]

  val provide_document_formatting_edits :
       t
    -> document:TextDocument.t
    -> options:FormattingOptions.t
    -> token:CancellationToken.t
    -> TextEdit.t list ProviderResult.t
    [@@js.call]

  val create :
       provide_document_formatting_edits:
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
    | Folder f -> WorkspaceFolder.t_to_js f
    | Global -> Ojs.int_to_js 1
    | Workspace -> Ojs.int_to_js 2

  let t_of_js js_val =
    match Ojs.type_of js_val with
    | "number" when Ojs.int_of_js js_val = 1 -> Global
    | "number" when Ojs.int_of_js js_val = 2 -> Workspace
    | _ -> Folder (WorkspaceFolder.t_of_js js_val)
end

module RunOptions = struct
  type t = private (* interface *) Ojs.t [@@js]

  val reevaluate_on_rerun : t -> bool or_undefined [@@js.get]

  val create : ?reevaluate_on_rerun:bool -> unit -> t [@@js.builder]
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

  val show_reuse_message : t -> bool or_undefined [@@js.get]

  val clear : t -> bool or_undefined [@@js.get]

  val create :
       ?reveal:TaskRevealKind.t
    -> ?echo:bool
    -> ?focus:bool
    -> ?panel:TaskPanelKind.t
    -> ?show_reuse_message:bool
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
      `ProcessExecution (ProcessExecution.t_of_js js_val)
    else if Ojs.has_property js_val "command" then
      `ShellExecution (ShellExecution.t_of_js js_val)
    else
      `CustomExecution (CustomExecution.t_of_js js_val)

  val make :
       definition:TaskDefinition.t
    -> scope:TaskScope.t
    -> name:string
    -> source:string
    -> ?execution:execution
    -> ?problem_matchers:string list
    -> unit
    -> t
    [@@js.new "vscode.Task"]

  val definition : t -> TaskDefinition.t [@@js.get]

  val scope : t -> TaskScope.t or_undefined [@@js.get]

  val name : t -> string [@@js.get]

  val detail : t -> string or_undefined [@@js.get]

  val execution : t -> execution or_undefined [@@js.get]

  val is_background : t -> bool [@@js.get]

  val source : t -> string [@@js.get]

  val group : t -> TaskGroup.t or_undefined [@@js.get]

  val presentation_options : t -> TaskPresentationOptions.t [@@js.get]

  val run_options : t -> RunOptions.t [@@js.get]

  val set_group : t -> TaskGroup.t -> unit [@@js.set]
end

module TaskProvider = struct
  type t = private (* interface *) Ojs.t [@@js]

  val provide_tasks :
    t -> ?token:CancellationToken.t -> unit -> Task.t list ProviderResult.t
    [@@js.call]

  val resolve_tasks :
       t
    -> task:Task.t
    -> ?token:CancellationToken.t
    -> unit
    -> Task.t ProviderResult.t
    [@@js.call]

  val create :
       provide_tasks:
         (?token:CancellationToken.t -> unit -> Task.t list ProviderResult.t)
    -> resolve_tasks:
         (   task:Task.t
          -> ?token:CancellationToken.t
          -> unit
          -> Task.t ProviderResult.t)
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
  val workspace_folders : unit -> WorkspaceFolder.t list
    [@@js.get "vscode.workspace.workspaceFolders"]

  val name : unit -> string or_undefined [@@js.get "vscode.workspace.name"]

  val workspace_file : unit -> Uri.t or_undefined
    [@@js.get "vscode.workspace.workspaceFile"]

  val text_documents : unit -> TextDocument.t list
    [@@js.get "vscode.workspace.textDocuments"]

  val on_did_change_workspace_folders : WorkspaceFolder.t Event.t
    [@@js.global "vscode.workspace.onDidChangeWorkspaceFolders"]

  val get_workspace_folder : uri:Uri.t -> WorkspaceFolder.t or_undefined
    [@@js.global "vscode.workspace.getWorkspaceFolder"]

  val on_did_open_text_document : TextDocument.t Event.t
    [@@js.global "vscode.workspace.onDidOpenTextDocument"]

  val on_did_close_text_document : TextDocument.t Event.t
    [@@js.global "vscode.workspace.onDidCloseTextDocument"]

  val get_configuration :
       ?section:string
    -> ?scope:ConfigurationScope.t
    -> unit
    -> WorkspaceConfiguration.t
    [@@js.global "vscode.workspace.getConfiguration"]

  val find_files :
       includes:GlobPattern.t
    -> ?excludes:GlobPattern.t
    -> ?max_results:int
    -> ?token:CancellationToken.t
    -> unit
    -> Uri.t list Promise.t
    [@@js.global "vscode.workspace.findFiles"]

  type text_document_options =
    { language : string
    ; content : string
    }
  [@@js]

  val open_text_document :
       ([ `Uri of Uri.t
        | `Filename of string
        | `Interactive of text_document_options or_undefined
        ]
       [@js.union])
    -> TextDocument.t Promise.t
    [@@js.global "vscode.workspace.openTextDocument"]
end

module Window = struct
  val active_text_editor : unit -> TextEditor.t or_undefined
    [@@js.get "vscode.window.activeTextEditor"]

  val show_quick_pick :
       choices:QuickPickItem.t list
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> QuickPickItem.t or_undefined Promise.t
    [@@js.global "vscode.window.showQuickPick"]

  let show_quick_pick_items ~choices ?options ?token () =
    let open Promise.Syntax in
    show_quick_pick ~choices:(List.map fst choices) ?options ?token ()
    >>| Option.map (fun q -> List.assoc q choices)

  val show_quick_pick :
       items:string list
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string or_undefined Promise.t
    [@@js.global "vscode.window.showQuickPick"]

  val show_input_box :
       ?options:InputBoxOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string or_undefined Promise.t
    [@@js.global "vscode.window.showInputBox"]

  let get_choices choices =
    choices
    |> List.map (fun (title, choice) -> (MessageItem.create ~title (), choice))

  val show_information_message :
       message:string
    -> ?options:MessageOptions.t
    -> items:(MessageItem.t list[@js.variadic])
    -> unit
    -> MessageItem.t or_undefined Promise.t
    [@@js.global "vscode.window.showInformationMessage"]

  let show_information_message ~message ?options ?(choices = []) () =
    let choices = get_choices choices in
    let open Promise.Syntax in
    show_information_message ~message ?options ~items:(List.map fst choices) ()
    >>| Option.map (fun q -> List.assoc q choices)

  val show_warning_message :
       message:string
    -> ?options:MessageOptions.t
    -> items:(MessageItem.t list[@js.variadic])
    -> unit
    -> MessageItem.t or_undefined Promise.t
    [@@js.global "vscode.window.showWarningMessage"]

  let show_warning_message ~message ?options ?(choices = []) () =
    let choices = get_choices choices in
    let open Promise.Syntax in
    show_warning_message ~message ?options ~items:(List.map fst choices) ()
    >>| Option.map (fun q -> List.assoc q choices)

  val show_error_message :
       message:string
    -> ?options:MessageOptions.t
    -> items:(MessageItem.t list[@js.variadic])
    -> unit
    -> MessageItem.t or_undefined Promise.t
    [@@js.global "vscode.window.showErrorMessage"]

  let show_error_message ~message ?options ?(choices = []) () =
    let choices = get_choices choices in
    let open Promise.Syntax in
    show_error_message ~message ?options ~items:(List.map fst choices) ()
    >>| Option.map (fun q -> List.assoc q choices)

  val with_progress :
       options:ProgressOptions.t
    -> task:
         (progress:Progress.t -> token:CancellationToken.t -> Ojs.t Promise.t)
    -> Ojs.t Promise.t
    [@@js.global "vscode.window.withProgress"]

  let with_progress ~options ~task =
    let task ~progress ~token = Obj.magic (task ~progress ~token) in
    Obj.magic (with_progress ~options ~task)

  val create_status_bar_item :
    ?alignment:StatusBarAlignment.t -> ?priority:int -> unit -> StatusBarItem.t
    [@@js.global "vscode.window.createStatusBarItem"]

  val show_text_document :
       document:([ `TextDocument of TextDocument.t | `Uri of Uri.t ][@js.union])
    -> ?column:ViewColumn.t
    -> ?preserve_focus:bool
    -> unit
    -> TextEditor.t Promise.t
    [@@js.global "vscode.window.showTextDocument"]

  val create_terminal :
       ?name:string
    -> ?shell_path:string
    -> ?shell_args:([ `String of string | `Strings of string list ][@js.union])
    -> unit
    -> Terminal.t
    [@@js.global "vscode.window.createTerminal"]

  val create_terminal_from_options :
       options:
         ([ `TerminalOptions of TerminalOptions.t
          | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
          ][@js.union])
    -> Terminal.t
    [@@js.global "vscode.window.createTerminal"]

  val create_output_channel : name:string -> OutputChannel.t
    [@@js.global "vscode.window.createOutputChannel"]
end

module Commands = struct
  val register_command :
       command:string
    -> callback:(args:(Ojs.t list[@js.variadic]) -> unit)
    -> Disposable.t
    [@@js.global "vscode.commands.registerCommand"]

  val register_text_editor_command :
       command:string
    -> callback:
         (   text_editor:TextEditor.t
          -> edit:TextEditorEdit.t
          -> args:(Ojs.t list[@js.variadic])
          -> unit)
    -> Disposable.t
    [@@js.global "vscode.commands.registerTextEditorCommand"]

  val execute_command :
       command:string
    -> args:(Ojs.t list[@js.variadic])
    -> Ojs.t or_undefined Promise.t
    [@@js.global "vscode.commands.executeCommand"]

  val get_commands : ?filter_internal:bool -> unit -> string list Promise.t
    [@@js.global "vscode.commands.getCommands"]
end

module Languages = struct
  val register_document_formatting_edit_provider :
       selector:DocumentSelector.t
    -> provider:DocumentFormattingEditProvider.t
    -> Disposable.t
    [@@js.global "vscode.languages.registerDocumentFormattingEditProvider"]
end

module Tasks = struct
  val register_task_provider :
    type_:string -> provider:TaskProvider.t -> Disposable.t
    [@@js.global "vscode.tasks.registerTaskProvider"]
end

module Env = struct
  val shell : unit -> string [@@js.get "vscode.env.shell"]
end
