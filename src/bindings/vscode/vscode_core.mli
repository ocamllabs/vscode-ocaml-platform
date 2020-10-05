module Disposable : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val from : t list -> t

  val make : dispose:(unit -> unit) -> t

  val dispose : t -> unit
end

module Command : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val title : t -> string

  val command : t -> string

  val tooltip : t -> string option

  val arguments : t -> Ojs.t list

  val create :
       title:string
    -> command:string
    -> ?tooltip:string
    -> ?arguments:Ojs.t list
    -> unit
    -> t
end

module Position : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val line : t -> int

  val character : t -> int

  val make : line:int -> character:int -> t

  val is_before : t -> other:t -> bool

  val is_before_or_equal : t -> other:t -> bool

  val is_after : t -> other:t -> bool

  val is_after_or_equal : t -> other:t -> bool

  val is_equal : t -> other:t -> bool

  val compare_to : t -> other:t -> int

  val translate : t -> ?line_delta:int -> ?character_delta:int -> unit -> t

  val with_ : t -> ?line:int -> ?character:int -> unit -> t
end

module Range : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val start : t -> Position.t

  val end_ : t -> Position.t

  val make_positions : start:Position.t -> end_:Position.t -> t

  val make_coordinates :
       start_line:int
    -> start_character:int
    -> end_line:int
    -> end_character:int
    -> t

  val is_empty : t -> bool

  val is_single_line : t -> bool

  val contains :
    t -> position_or_range:[ `Position of Position.t | `Range of t ] -> bool

  val is_equal : t -> other:t -> bool

  val intersection : t -> range:t -> t option

  val union : t -> other:t -> t

  val with_ : t -> ?start:Position.t -> ?end_:Position.t -> unit -> t
end

module TextLine : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val line_number : t -> int

  val text : t -> string

  val range : t -> Range.t

  val range_including_line_break : t -> Range.t

  val first_non_whitespace_character_index : t -> int

  val is_empty_or_whitespace : t -> bool

  val create :
       line_number:int
    -> text:string
    -> range:Range.t
    -> range_including_line_break:Range.t
    -> first_non_whitespace_character_index:int
    -> is_empty_or_whitespace:bool
    -> t
end

module EndOfLine : sig
  type t =
    | CRLF
    | LF

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module TextEdit : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val replace : range:Range.t -> new_text:string -> t

  val insert : position:Position.t -> new_text:string -> t

  val delete : Range.t -> t

  val set_end_of_line : EndOfLine.t -> t

  val range : t -> Range.t

  val new_text : t -> string

  val new_eol : t -> EndOfLine.t option

  val make : range:Range.t -> new_text:string -> t
end

module Uri : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val parse : string -> ?strict:bool -> unit -> t

  val file : string -> t

  val join_path : t -> path_segments:string list -> t

  val scheme : t -> string

  val authority : t -> string

  val path : t -> string

  val query : t -> string

  val fragment : t -> string

  val fs_path : t -> string

  val with_ :
       t
    -> ?scheme:string
    -> ?authority:string
    -> ?path:string
    -> ?query:string
    -> ?fragment:string
    -> unit
    -> t

  val to_string : t -> ?skip_encoding:bool -> unit -> string

  val to_json : t -> Jsonoo.t
end

module TextDocument : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val uri : t -> Uri.t

  val file_name : t -> string

  val is_untitled : t -> bool

  val language_id : t -> string

  val version : t -> int

  val is_dirty : t -> bool

  val is_closed : t -> bool

  val save : t -> bool Promise.t

  val eol : t -> EndOfLine.t

  val line_count : t -> int

  val line_at : t -> line:int -> TextLine.t

  val line_at_position : t -> position:Position.t -> TextLine.t

  val offset_at : t -> position:Position.t -> int

  val position_at : t -> offset:int -> Position.t

  val get_text : t -> ?range:Range.t -> unit -> string

  val get_word_range_at_position :
       t
    -> position:Position.t
    -> ?regex:Js_of_ocaml.Regexp.regexp
    -> unit
    -> Range.t option

  val validate_range : t -> range:Range.t -> Range.t

  val validate_position : t -> position:Position.t -> Position.t
end

module WorkspaceFolder : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val uri : t -> Uri.t

  val name : t -> string

  val index : t -> int

  val create : uri:Uri.t -> name:string -> index:int -> t
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

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module Selection : sig
  type t = private Range.t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val anchor : t -> Position.t

  val active : t -> Position.t

  val make_positions : anchor:Position.t -> active:Position.t -> t

  val make_coordinates :
       anchor_line:int
    -> anchor_character:int
    -> active_line:int
    -> active_character:int
    -> t

  val is_reversed : t -> bool
end

module TextEditorEdit : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type replace_location =
    [ `Position of Position.t
    | `Range of Range.t
    | `Selection of Selection.t
    ]

  type delete_location =
    [ `Range of Range.t
    | `Selection of Selection.t
    ]

  val replace : t -> location:replace_location -> value:string -> unit

  val insert : t -> location:Position.t -> value:string -> unit

  val delete : t -> location:delete_location -> unit

  val set_end_of_line : t -> end_of_line:EndOfLine.t -> t

  val create :
       replace:(location:replace_location -> value:string -> unit)
    -> insert:(location:Position.t -> value:string -> unit)
    -> delete:(location:delete_location -> unit)
    -> set_end_of_line:(end_of_line:EndOfLine.t -> t)
    -> t
end

module TextEditorCursorStyle : sig
  type t =
    | Line
    | Block
    | Underline
    | Line_thin
    | Block_outline
    | Underline_thin

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module TextEditorLineNumbersStyle : sig
  type t =
    | Off
    | On
    | Relative

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module TextEditorRevealType : sig
  type t =
    | Default
    | In_center
    | In_center_if_outside_viewport
    | At_top

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module TextEditorOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type tab_size =
    [ `Int of int
    | `String of string
    ]

  type insert_spaces =
    [ `Bool of bool
    | `String of string
    ]

  val tab_size : t -> tab_size option

  val insert_spaces : t -> insert_spaces option

  val cursor_style : t -> TextEditorCursorStyle.t option

  val line_numbers : t -> TextEditorLineNumbersStyle.t option

  val create :
       ?tab_size:tab_size
    -> ?insert_spaces:insert_spaces
    -> ?cursor_style:TextEditorCursorStyle.t
    -> ?line_numbers:TextEditorLineNumbersStyle.t
    -> unit
    -> t
end

module TextEditorDecorationType : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val key : t -> string

  val dispose : t -> unit

  val disposable : t -> Disposable.t

  val create : key:string -> dispose:(unit -> unit) -> t
end

module MarkdownString : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val value : t -> string

  val is_trusted : t -> bool option

  val support_theme_icons : t -> bool option

  val make : ?value:string -> ?support_theme_icons:bool -> unit -> t

  val append_text : t -> value:string -> t

  val append_markdown : t -> value:string -> t

  val append_codeblock : t -> value:string -> ?language:string -> unit -> t
end

module ThemeColor : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val make : id:string -> t
end

module ThemableDecorationAttachmentRenderOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type content_icon_path =
    [ `String of string
    | `Uri of Uri.t
    ]

  type color =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  val content_text : t -> string option

  val content_icon_path : t -> content_icon_path option

  val border : t -> string option

  val border_color : t -> color option

  val font_style : t -> string option

  val font_weight : t -> string option

  val text_decoration : t -> string option

  val color : t -> color option

  val background_color : t -> color option

  val margin : t -> string option

  val width : t -> string option

  val height : t -> string option

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
end

module ThemableDecorationInstanceRenderOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val before : t -> ThemableDecorationAttachmentRenderOptions.t option

  val after : t -> ThemableDecorationAttachmentRenderOptions.t option

  val create :
       ?before:ThemableDecorationAttachmentRenderOptions.t
    -> ?after:ThemableDecorationAttachmentRenderOptions.t
    -> unit
    -> t
end

module DecorationInstanceRenderOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val light : t -> ThemableDecorationInstanceRenderOptions.t option

  val dark : t -> ThemableDecorationInstanceRenderOptions.t option

  val create :
       ?light:ThemableDecorationInstanceRenderOptions.t
    -> ?dark:ThemableDecorationInstanceRenderOptions.t
    -> unit
    -> t
end

module DecorationOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type hover_message =
    [ `MarkdownString of MarkdownString.t
    | `MarkdownStrings of MarkdownString.t list
    ]

  val range : t -> Range.t

  val hover_message : t -> hover_message option

  val render_options : t -> DecorationInstanceRenderOptions.t option

  val create :
       range:Range.t
    -> ?hover_message:hover_message
    -> ?render_options:DecorationInstanceRenderOptions.t option
    -> unit
    -> t
end

module SnippetString : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val value : t -> string

  val make : ?value:string -> unit -> t

  val append_text : t -> string:string -> t

  val append_tab_stop : t -> number:int -> t

  val append_place_holder :
       t
    -> value:[ `String of string | `Function of t -> unit ]
    -> ?number:int
    -> unit
    -> t

  val append_choice : t -> values:string list -> ?number:int -> unit -> t

  val append_variable :
       t
    -> name:string
    -> default_value:[ `String of string | `Function of t -> unit ]
    -> t
end

module TextEditor : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type insert_snippet_location =
    [ `Position of Position.t
    | `Range of Range.t
    | `Positions of Position.t list
    | `Ranges of Range.t list
    ]

  val document : t -> TextDocument.t

  val selection : t -> Selection.t

  val selections : t -> Selection.t list

  val visible_ranges : t -> Range.t list

  val options : t -> TextEditorOptions.t

  val view_column : t -> ViewColumn.t option

  val edit :
       t
    -> callback:(edit_builder:TextEditorEdit.t -> unit)
    -> ?undo_stop_before:bool
    -> ?undo_stop_after:bool
    -> unit
    -> bool Promise.t

  val insert_snippet :
       t
    -> snippet:SnippetString.t
    -> ?location:insert_snippet_location
    -> ?undo_stop_before:bool
    -> ?undo_stop_after:bool
    -> unit
    -> bool Promise.t

  val set_decorations :
       t
    -> decoration_type:TextEditorDecorationType.t
    -> ranges_or_options:
         [ `Ranges of Range.t list | `Options of DecorationOptions.t list ]
    -> unit

  val reveal_range :
    t -> range:Range.t -> ?reveal_type:TextEditorRevealType.t -> unit -> unit
end

module ConfigurationTarget : sig
  type t =
    | Global
    | Workspace
    | Workspace_folder

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module WorkspaceConfiguration : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type configuration_target =
    [ `ConfigurationTarget of ConfigurationTarget.t
    | `Bool of bool
    ]

  type inspect_result =
    { key : string
    ; default_value : Jsonoo.t option
    ; global_value : Jsonoo.t option
    ; workspace_value : Jsonoo.t option
    ; workspace_folder_value : Jsonoo.t option
    ; default_language_value : Jsonoo.t option
    ; global_language_value : Jsonoo.t option
    ; workspace_language_value : Jsonoo.t option
    ; workspace_folder_language_value : Jsonoo.t option
    ; language_ids : string option
    }

  val get : t -> section:string -> unit -> Jsonoo.t option

  val has : t -> section:string -> bool

  val inspect : t -> section:string -> inspect_result

  val update :
       t
    -> section:string
    -> value:Jsonoo.t
    -> ?configuration_target:configuration_target
    -> ?override_in_language:bool
    -> unit
    -> Promise.void
end

module StatusBarAlignment : sig
  type t =
    | Left
    | Right

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module AccessibilityInformation : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val label : t -> string

  val role : t -> string option

  val create : label:string -> ?role:string -> unit -> t
end

module StatusBarItem : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type color =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  type command =
    [ `String of string
    | `Command of Command.t
    ]

  val alignment : t -> StatusBarAlignment.t

  val priority : t -> int option

  val text : t -> string

  val tooltip : t -> string option

  val color : t -> color option

  val command : t -> command option

  val accessibility_information : t -> AccessibilityInformation.t option

  val set_alignment : t -> StatusBarAlignment.t -> unit

  val set_priority : t -> int -> unit

  val set_text : t -> string -> unit

  val set_tooltip : t -> string -> unit

  val set_color : t -> color -> unit

  val set_command : t -> command -> unit

  val set_accessibility_information : t -> AccessibilityInformation.t -> unit

  val show : t -> unit

  val hide : t -> unit

  val dispose : t -> unit

  val disposable : t -> Disposable.t
end

module WorkspaceFoldersChangeEvent : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val added : t -> WorkspaceFolder.t list

  val removed : t -> WorkspaceFolder.t list

  val create :
    added:WorkspaceFolder.t list -> removed:WorkspaceFolder.t list -> t
end

module FormattingOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val tab_size : t -> int

  val insert_spaces : t -> bool

  val create : tab_size:int -> insert_spaces:bool -> t
end

module Event : sig
  type 'a t = listener:('a -> unit) -> Disposable.t

  val t_of_js : (Ojs.t -> 'a) -> Ojs.t -> listener:('a -> 'b) -> Disposable.t

  val t_to_js :
    ('a -> Ojs.t) -> (listener:('a -> unit) -> Disposable.t) -> Ojs.t
end

module CancellationToken : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val is_cancellation_requested : t -> bool

  val on_cancellation_requested : t -> Ojs.t Event.t

  val create :
       is_cancellation_requested:bool
    -> on_cancellation_requested:Ojs.t Event.t
    -> t
end

module QuickPickItem : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val label : t -> string

  val description : t -> string option

  val detail : t -> string option

  val picked : t -> bool option

  val always_show : t -> bool option

  val create :
       label:string
    -> ?description:string
    -> ?detail:string
    -> ?picked:bool
    -> ?always_show:bool
    -> unit
    -> t
end

module QuickPickOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type on_did_select_item_args =
    [ `QuickPickItem of QuickPickItem.t
    | `String of string
    ]

  val match_on_description : t -> bool option

  val match_on_detail : t -> bool option

  val place_holder : t -> string option

  val ignore_focus_out : t -> bool option

  val can_pick_many : t -> bool option

  val on_did_select_item : t -> (on_did_select_item_args -> unit) option

  val create :
       ?match_on_description:bool
    -> ?match_on_detail:bool
    -> ?place_holder:string
    -> ?ignore_focus_out:bool
    -> ?can_pick_many:bool
    -> ?on_did_select_item:(item:on_did_select_item_args -> unit)
    -> unit
    -> t
end

module ProviderResult : sig
  type 'a t =
    [ `Value of 'a option
    | `Promise of 'a option Promise.t
    ]

  val t_to_js : ('a -> Ojs.t) -> 'a t -> Ojs.t

  val t_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a t
end

module InputBoxOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val value : t -> string option

  val value_selection : t -> (int * int) option

  val prompt : t -> string option

  val place_holder : t -> string option

  val password : t -> bool option

  val ignore_focus_out : t -> bool option

  val validate_input : t -> (string -> string ProviderResult.t) option

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
end

module MessageItem : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val title : t -> string

  val is_close_affordance : t -> bool option

  val create : title:string -> ?is_close_affordance:bool -> unit -> t
end

module Location : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val uri : t -> Uri.t

  val range : t -> Range.t

  val make :
       uri:Uri.t
    -> range_or_position:[ `Range of Range.t | `Position of Position.t ]
    -> t
end

module ProgressLocation : sig
  type t =
    | Source_control
    | Window
    | Notification

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module ProgressOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type location =
    [ `ProgressLocation of ProgressLocation.t
    | `ViewIdLocation of view_id_location
    ]

  and view_id_location = { view_id : string }

  val location : t -> location

  val title : t -> string option

  val cancellable : t -> bool option

  val create :
    location:location -> ?title:string -> ?cancellable:bool -> unit -> t
end

module TextDocumentShowOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val view_column : t -> ViewColumn.t option

  val preserve_focus : t -> bool option

  val preview : t -> bool option

  val selection : t -> Range.t option

  val create :
       view_column:ViewColumn.t
    -> ?preserve_focus:bool
    -> ?preview:bool
    -> ?selection:Range.t
    -> unit
    -> t
end

module TerminalOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type shell_args =
    [ `Arg of string
    | `Args of string list
    ]

  type cwd =
    [ `String of string
    | `Uri of Uri.t
    ]

  val name : t -> string option

  val shell_path : t -> string option

  val shell_args : t -> shell_args option

  val cwd : t -> cwd option

  val env : t -> (string, string option) Core_kernel.Hashtbl.t option

  val strict_env : t -> bool

  val hide_from_user : t -> bool
end

module TerminalDimensions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val columns : t -> int

  val rows : t -> int

  val create : columns:int -> rows:int -> t
end

module Pseudoterminal : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val on_did_write : t -> string Event.t

  val on_did_override_dimensions :
    t -> TerminalDimensions.t option Event.t option

  val on_did_close : t -> int option Event.t option

  val open_ : t -> ?initial_dimensions:TerminalDimensions.t -> unit -> unit

  val close : t -> unit

  val handle_input : t -> (data:string -> unit) option

  val set_dimensions : t -> (dimensions:TerminalDimensions.t -> unit) option

  val create :
       on_did_write:string Event.t
    -> ?on_did_override_dimensions:TerminalDimensions.t option Event.t
    -> ?on_did_close:int option Event.t
    -> open_:(?initial_dimensions:TerminalDimensions.t -> unit -> unit)
    -> close:(unit -> unit)
    -> ?handle_input:(data:string -> unit)
    -> ?set_dimensions:(dimensions:TerminalDimensions.t -> unit)
    -> unit
    -> t
end

module ExtensionTerminalOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val name : t -> string

  val pty : t -> Pseudoterminal.t

  val create : name:string -> pty:Pseudoterminal.t -> t
end

module TerminalExitStatus : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val code : t -> int

  val create : code:int -> t
end

module Terminal : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type creation_options =
    [ `TerminalOptions of TerminalOptions.t
    | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
    ]

  val name : t -> string

  val process_id : t -> int option Promise.t

  val creation_options : t -> creation_options

  val exit_status : t -> TerminalExitStatus.t option

  val send_text : t -> text:string -> ?add_new_line:bool -> unit -> unit

  val show : t -> ?preserve_focus:bool -> unit -> unit

  val hide : t -> unit

  val dispose : t -> unit

  val disposable : t -> Disposable.t
end

module OutputChannel : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val name : t -> string

  val append : t -> value:string -> unit

  val append_line : t -> value:string -> unit

  val clear : t -> unit

  val show : t -> ?preserve_focus:bool -> unit -> unit

  val hide : t -> unit

  val dispose : t -> unit

  val disposable : t -> Disposable.t
end

module Memento : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val get : t -> key:string -> Jsonoo.t option

  val update : t -> key:string -> value:Jsonoo.t -> Promise.void
end

module EnvironmentVariableMutatorType : sig
  type t =
    | Replace
    | Append
    | Prepend

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module EnvironmentVariableMutator : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val type_ : t -> EnvironmentVariableMutatorType.t

  val value : t -> string
end

module EnvironmentVariableCollection : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val persistent : t -> bool

  val replace : t -> variable:string -> value:string -> unit

  val append : t -> variable:string -> value:string -> unit

  val prepend : t -> variable:string -> value:string -> unit

  val get : t -> variable:string -> EnvironmentVariableMutator.t option

  val for_each :
       t
    -> callback:
         (   variable:string
          -> mutator:EnvironmentVariableMutator.t
          -> collection:t
          -> unit)
    -> unit

  val delete : t -> variable:string -> unit

  val clear : t -> unit
end

module ExtensionMode : sig
  type t =
    | Production
    | Development
    | Test

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module ExtensionContext : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val subscriptions : t -> Disposable.t list

  val workspace_state : t -> Memento.t

  val global_state : t -> Memento.t

  val extension_uri : t -> Uri.t

  val extension_path : t -> string

  val environment_variable_collection : t -> EnvironmentVariableCollection.t

  val as_absolute_path : t -> relative_path:string -> string

  val storage_uri : t -> Uri.t option

  val global_storage_uri : t -> Uri.t

  val log_uri : t -> Uri.t

  val extension_mode : t -> ExtensionMode.t

  val subscribe : t -> disposable:Disposable.t -> unit
end

module ShellQuotingOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type escape_literal =
    { escape_char : string
    ; chars_to_escape : string
    }

  type escape =
    [ `String of string
    | `Literal of escape_literal
    ]

  val escape : t -> escape option

  val strong : t -> string option

  val weak : t -> string option

  val create : ?escape:escape -> ?strong:string -> ?weak:string -> unit -> t
end

module ShellExecutionOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val executable : t -> string option

  val shell_args : t -> string list

  val shell_quoting : t -> ShellQuotingOptions.t option

  val cwd : t -> string option

  val env : t -> (string, string) Core_kernel.Hashtbl.t option

  val create :
       ?executable:string
    -> ?shell_args:string list
    -> ?shell_quoting:ShellQuotingOptions.t
    -> ?cwd:string
    -> ?env:(string, string) Core_kernel.Hashtbl.t
    -> unit
    -> t
end

module ShellQuoting : sig
  type t =
    | Escape
    | Strong
    | Weak

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module ShellQuotedString : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val value : t -> string

  val quoting : t -> ShellQuoting.t

  val create : value:string -> quoting:ShellQuoting.t -> t
end

module ShellExecution : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type shell_string =
    [ `String of string
    | `ShellQuotedString of ShellQuotedString.t
    ]

  val make_command_line :
    command_line:string -> ?options:ShellExecutionOptions.t -> unit -> t

  val make_command_args :
       command:shell_string
    -> args:shell_string list
    -> ?options:ShellExecutionOptions.t
    -> unit
    -> t

  val command_line : t -> string option

  val command : t -> shell_string

  val args : t -> shell_string list

  val options : t -> ShellExecutionOptions.t option
end

module ProcessExecutionOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val cwd : t -> string option

  val env : t -> (string, string) Core_kernel.Hashtbl.t option

  val create :
    ?cwd:string -> ?env:(string, string) Core_kernel.Hashtbl.t -> unit -> t
end

module ProcessExecution : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val make_process :
    process:string -> ?options:ProcessExecutionOptions.t -> unit -> t

  val make_process_args :
       process:string
    -> args:string list
    -> ?options:ProcessExecutionOptions.t
    -> unit
    -> t

  val process : t -> string

  val args : t -> string list

  val options : t -> ProcessExecutionOptions.t option
end

module TaskDefinition : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val type_ : t -> string

  val get_attribute : t -> string -> Ojs.t

  val set_attribute : t -> string -> Ojs.t -> unit

  val create : type_:string -> ?attributes:(string * Ojs.t) list -> unit -> t
end

module CustomExecution : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val make :
       callback:
         (resolved_definition:TaskDefinition.t -> Pseudoterminal.t Promise.t)
    -> t
end

module RelativePattern : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val base : t -> string

  val pattern : t -> string

  val make :
       base:[ `String of string | `WorkspaceFolder of WorkspaceFolder.t ]
    -> pattern:string
    -> t
end

module GlobPattern : sig
  type t =
    [ `String of string
    | `RelativePattern of RelativePattern.t
    ]

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module DocumentFilter : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val language : t -> string option

  val scheme : t -> string option

  val pattern : t -> GlobPattern.t option

  val create :
    ?language:string -> ?scheme:string -> ?pattern:GlobPattern.t -> unit -> t
end

module DocumentSelector : sig
  type selectors =
    [ `Filter of DocumentFilter.t
    | `String of string
    ]

  type t =
    [ selectors
    | `List of selectors list
    ]

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module DocumentFormattingEditProvider : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val provide_document_formatting_edits :
       t
    -> document:TextDocument.t
    -> options:FormattingOptions.t
    -> token:CancellationToken.t
    -> TextEdit.t list ProviderResult.t

  val create :
       provide_document_formatting_edits:
         (   document:TextDocument.t
          -> options:FormattingOptions.t
          -> token:CancellationToken.t
          -> TextEdit.t list ProviderResult.t)
    -> t
end

module TaskGroup : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val clean : t

  val build : t

  val rebuild : t

  val test : t
end

module TaskScope : sig
  type t =
    | Folder of WorkspaceFolder.t
    | Global
    | Workspace

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module RunOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val reevaluate_on_rerun : t -> bool option

  val create : ?reevaluate_on_rerun:bool -> unit -> t
end

module TaskRevealKind : sig
  type t =
    | Always
    | Silent
    | Never

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module TaskPanelKind : sig
  type t =
    | Shared
    | Dedicated
    | New

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module TaskPresentationOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val reveal : t -> TaskRevealKind.t option

  val echo : t -> bool option

  val focus : t -> bool option

  val panel : t -> TaskPanelKind.t option

  val show_reuse_message : t -> bool option

  val clear : t -> bool option

  val create :
       ?reveal:TaskRevealKind.t
    -> ?echo:bool
    -> ?focus:bool
    -> ?panel:TaskPanelKind.t
    -> ?show_reuse_message:bool
    -> ?clear:bool
    -> unit
    -> t
end

module Task : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  type execution =
    [ `ProcessExecution of ProcessExecution.t
    | `ShellExecution of ShellExecution.t
    | `CustomExecution of CustomExecution.t
    ]

  val make :
       definition:TaskDefinition.t
    -> scope:TaskScope.t
    -> name:string
    -> source:string
    -> ?execution:execution
    -> ?problem_matchers:string list
    -> unit
    -> t

  val definition : t -> TaskDefinition.t

  val scope : t -> TaskScope.t option

  val name : t -> string

  val detail : t -> string option

  val execution : t -> execution option

  val is_background : t -> bool

  val source : t -> string

  val group : t -> TaskGroup.t option

  val presentation_options : t -> TaskPresentationOptions.t

  val run_options : t -> RunOptions.t

  val set_group : t -> TaskGroup.t -> unit
end

module TaskProvider : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val provide_tasks :
    t -> ?token:CancellationToken.t -> unit -> Task.t list ProviderResult.t

  val resolve_tasks :
       t
    -> task:Task.t
    -> ?token:CancellationToken.t
    -> unit
    -> Task.t ProviderResult.t

  val create :
       provide_tasks:
         (?token:CancellationToken.t -> unit -> Task.t list ProviderResult.t)
    -> resolve_tasks:
         (   task:Task.t
          -> ?token:CancellationToken.t
          -> unit
          -> Task.t ProviderResult.t)
    -> t
end

module ConfigurationScope : sig
  type t =
    [ `Uri of Uri.t
    | `TextDocument of TextDocument.t
    | `WorkspaceFolder of WorkspaceFolder.t
    ]

  val t_to_js : t -> Ojs.t
end

module MessageOptions : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val modal : t -> bool option

  val create : ?modal:bool -> unit -> t
end

module Progress : sig
  type value =
    { message : string option
    ; increment : int option
    }

  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val report : t -> value:value -> unit
end

module Workspace : sig
  val workspace_folders : unit -> WorkspaceFolder.t list

  val name : unit -> string option

  val workspace_file : unit -> Uri.t option

  val text_documents : unit -> TextDocument.t list

  val on_did_change_workspace_folders : WorkspaceFolder.t Event.t

  val get_workspace_folder : uri:Uri.t -> WorkspaceFolder.t option

  val on_did_open_text_document : TextDocument.t Event.t

  val on_did_close_text_document : TextDocument.t Event.t

  val get_configuration :
       ?section:string
    -> ?scope:ConfigurationScope.t
    -> unit
    -> WorkspaceConfiguration.t

  val find_files :
       includes:GlobPattern.t
    -> ?excludes:GlobPattern.t
    -> ?max_results:int
    -> ?token:CancellationToken.t
    -> unit
    -> Uri.t list Promise.t

  type text_document_options =
    { language : string
    ; content : string
    }

  val open_text_document :
       [ `Uri of Uri.t
       | `Filename of string
       | `Interactive of text_document_options option
       ]
    -> TextDocument.t Promise.t
end

module Window : sig
  val active_text_editor : unit -> TextEditor.t option

  val show_quick_pick_items :
       choices:(QuickPickItem.t * 'a) list
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> 'a option Promise.t

  val show_quick_pick :
       items:string list
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string option Promise.t

  val show_input_box :
       ?options:InputBoxOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string option Promise.t

  val get_choices : (string * 'a) list -> (MessageItem.t * 'a) list

  val show_information_message :
       message:string
    -> ?options:MessageOptions.t
    -> ?choices:(string * 'a) list
    -> unit
    -> 'a option Promise.t

  val show_warning_message :
       message:string
    -> ?options:MessageOptions.t
    -> ?choices:(string * 'a) list
    -> unit
    -> 'a option Promise.t

  val show_error_message :
       message:string
    -> ?options:MessageOptions.t
    -> ?choices:(string * 'a) list
    -> unit
    -> 'a option Promise.t

  val with_progress :
       options:ProgressOptions.t
    -> task:(progress:Progress.t -> token:CancellationToken.t -> 'a)
    -> 'b

  val create_status_bar_item :
    ?alignment:StatusBarAlignment.t -> ?priority:int -> unit -> StatusBarItem.t

  val show_text_document :
       document:[ `TextDocument of TextDocument.t | `Uri of Uri.t ]
    -> ?column:ViewColumn.t
    -> ?preserve_focus:bool
    -> unit
    -> TextEditor.t Promise.t

  val create_terminal :
       ?name:string
    -> ?shell_path:string
    -> ?shell_args:[ `String of string | `Strings of string list ]
    -> unit
    -> Terminal.t

  val create_terminal_from_options :
       options:
         [ `TerminalOptions of TerminalOptions.t
         | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
         ]
    -> Terminal.t

  val create_output_channel : name:string -> OutputChannel.t
end

module Commands : sig
  val register_command :
    command:string -> callback:(args:Ojs.t list -> unit) -> Disposable.t

  val register_text_editor_command :
       command:string
    -> callback:
         (   text_editor:TextEditor.t
          -> edit:TextEditorEdit.t
          -> args:Ojs.t list
          -> unit)
    -> Disposable.t

  val execute_command :
    command:string -> args:Ojs.t list -> Ojs.t option Promise.t

  val get_commands : ?filter_internal:bool -> unit -> string list Promise.t
end

module Languages : sig
  val register_document_formatting_edit_provider :
       selector:DocumentSelector.t
    -> provider:DocumentFormattingEditProvider.t
    -> Disposable.t
end

module Tasks : sig
  val register_task_provider :
    type_:string -> provider:TaskProvider.t -> Disposable.t
end

module Env : sig
  val shell : unit -> string
end
