(** {b VS Code API} is a set of JavaScript APIs that you can invoke in your
    Visual Studio Code extension. *)

(** The version of the editor. *)
val version : string

(** Represents a type which can release resources, such as event listening or a
    timer. *)
module Disposable : sig
  type t

  (** {4 Constructors} *)

  (** Combine many disposable-likes into one. Use this method when having
      objects with a dispose function which are not instances of Disposable.

      @param disposableLikes Objects that have at least a [dispose]-function
      member.
      @return Returns a new disposable which, upon dispose, will dispose all
      provided disposables. *)
  val from : t list -> t

  (** Creates a new Disposable calling the provided function on dispose.

      @param callOnDispose Function that disposes something. *)
  val make : dispose:(unit -> unit) -> t

  (** Dispose this object. *)
  val dispose : t -> unit

  (** {4 Converters} *)

  (** Get a [Disposable.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [Disposable.t]. *)
  val t_to_js : t -> Ojs.t
end

(** Represents a reference to a command.

    Provides a title which will be used to represent a command in the UI and,
    optionally, an array of arguments which will be passed to the command
    handler function when invoked. *)
module Command : sig
  type t

  (** {4 Constructors} *)

  (** Create a new Command. *)
  val create :
       title:string
    -> command:string
    -> ?tooltip:string
    -> ?arguments:Ojs.t list
    -> unit
    -> t

  (** {4 Properties} *)

  (** Title of the command, like `save`. *)
  val title : t -> string

  (** The identifier of the actual command handler.

      See {{!Commands.registerCommand} [Commands.registerCommand]} *)
  val command : t -> string

  (** A tooltip for the command, when represented in the UI. *)
  val tooltip : t -> string option

  (** Arguments that the command handler should be invoked with. *)
  val arguments : t -> Ojs.t list

  (** {4 Converters} *)

  (** Get a [Command.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [Command.t]. *)
  val t_to_js : t -> Ojs.t
end

(** Represents a line and character position, such as the position of the
    cursor.

    Position objects are {b immutable}. Use the {{!Position.with_} [with_]} or
    {{!Position.translate} [translate]} methods to derive new positions from an
    existing position. *)
module Position : sig
  type t

  (** {4 Constructors} *)

  (** @param line A zero-based line value.
      @param character A zero-based character value. *)
  val make : line:int -> character:int -> t

  (** {4 Properties} *)

  (** The zero-based line value. *)
  val line : t -> int

  (** The zero-based character value. *)
  val character : t -> int

  (** {4 Methods} *)

  (** Check if this position is before [other].

      @param other A position.
      @return [true] if position is on a smaller line or on the same line on a
      smaller character. *)
  val isBefore : t -> other:t -> bool

  (** Check if this position is before or equal to [other].

      @param other A position.
      @return [true] if position is on a smaller line or on the same line on a
      smaller or equal character. *)
  val isBeforeOrEqual : t -> other:t -> bool

  (** Check if this position is after [other].

      @param other A position.
      @return [true] if position is on a greater line or on the same line on a
      greater character. *)
  val isAfter : t -> other:t -> bool

  (** Check if this position is after or equal to [other].

      @param other A position.
      @return [true] if position is on a greater line or on the same line on a
      greater or equal character. *)
  val isAfterOrEqual : t -> other:t -> bool

  (** Check if this position is equal to [other].

      @param other A position.
      @return [true] if the line and character of the given position are equal
      to the line and character of this position. *)
  val isEqual : t -> other:t -> bool

  (** Compare this to [other].

      @param other A position.
      @return A number smaller than zero if this position is before the given
      position, a number greater than zero if this position is after the given
      position, or zero when this and the given position are equal. *)
  val compareTo : t -> other:t -> int

  (** Create a new position relative to this position.

      @param lineDelta Delta value for the line value, default is [0].
      @param characterDelta Delta value for the character value, default is [0].
      @return A position which line and character is the sum of the current line
      and character and the corresponding deltas. *)
  val translate : t -> ?lineDelta:int -> ?characterDelta:int -> unit -> t

  (** Create a new position derived from this position.

      @param line Value that should be used as line value, default is the
      {{!Position.line} [existing value]}
      @param character Value that should be used as character value, default is
      the {{!Position.character} [existing value]}
      @return A position where line and character are replaced by the given
      values. *)
  val with_ : t -> ?line:int -> ?character:int -> unit -> t

  (** {4 Converters} *)

  (** Get a [Position.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [Position.t]. *)
  val t_to_js : t -> Ojs.t
end

(** A range represents an ordered pair of two positions.

    It is guaranteed that [isBeforeOrEqual] {{!Range.start} [start]}
    ({{!Range.end_} [end_]})

    Range objects are {b immutable}. Use the {{!Range.with_} [with_]},
    {{!Range.start} [start]} [intersection](#Range.intersection), or
    [union](#Range.union) methods to derive new ranges from an existing range. *)
module Range : sig
  type t

  val start : t -> Position.t

  val end_ : t -> Position.t

  val makePositions : start:Position.t -> end_:Position.t -> t

  val makeCoordinates :
    startLine:int -> startCharacter:int -> endLine:int -> endCharacter:int -> t

  val isEmpty : t -> bool

  val isSingleLine : t -> bool

  val contains :
    t -> positionOrRange:[ `Position of Position.t | `Range of t ] -> bool

  val isEqual : t -> other:t -> bool

  val intersection : t -> range:t -> t option

  val union : t -> other:t -> t

  val with_ : t -> ?start:Position.t -> ?end_:Position.t -> unit -> t

  (** {4 Converters} *)

  (** Get a [Range.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [Range.t]. *)
  val t_to_js : t -> Ojs.t
end

module TextLine : sig
  type t

  val lineNumber : t -> int

  val text : t -> string

  val range : t -> Range.t

  val rangeIncludingLineBreak : t -> Range.t

  val firstNonWhitespaceCharacterIndex : t -> int

  val isEmptyOrWhitespace : t -> bool

  val create :
       lineNumber:int
    -> text:string
    -> range:Range.t
    -> rangeIncludingLineBreak:Range.t
    -> firstNonWhitespaceCharacterIndex:int
    -> isEmptyOrWhitespace:bool
    -> t

  (** {4 Converters} *)

  (** Get a [TextLine.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TextLine.t]. *)
  val t_to_js : t -> Ojs.t
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

  val replace : range:Range.t -> newText:string -> t

  val insert : position:Position.t -> newText:string -> t

  val delete : Range.t -> t

  val setEndOfLine : EndOfLine.t -> t

  val range : t -> Range.t

  val newText : t -> string

  val newEol : t -> EndOfLine.t option

  val make : range:Range.t -> newText:string -> t

  (** {4 Converters} *)

  (** Get a [TextEdit.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TextEdit.t]. *)
  val t_to_js : t -> Ojs.t
end

module Uri : sig
  type t

  val parse : string -> ?strict:bool -> unit -> t

  val file : string -> t

  val joinPath : t -> pathSegments:string list -> t

  val scheme : t -> string

  val authority : t -> string

  val path : t -> string

  val query : t -> string

  val fragment : t -> string

  val fsPath : t -> string

  val with_ :
       t
    -> ?scheme:string
    -> ?authority:string
    -> ?path:string
    -> ?query:string
    -> ?fragment:string
    -> unit
    -> t

  val toString : t -> ?skipEncoding:bool -> unit -> string

  val toJson : t -> Jsonoo.t

  (** {4 Converters} *)

  (** Get a [Uri.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [Uri.t]. *)
  val t_to_js : t -> Ojs.t
end

module TextDocument : sig
  type t

  val uri : t -> Uri.t

  val fileName : t -> string

  val isUntitled : t -> bool

  val languageId : t -> string

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

  val getWordRangeAtPosition :
       t
    -> position:Position.t
    -> ?regex:Js_of_ocaml.Regexp.regexp
    -> unit
    -> Range.t option

  val validateRange : t -> range:Range.t -> Range.t

  val validatePosition : t -> position:Position.t -> Position.t

  (** {4 Converters} *)

  (** Get a [TextDocument.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TextDocument.t]. *)
  val t_to_js : t -> Ojs.t
end

module WorkspaceFolder : sig
  type t

  val uri : t -> Uri.t

  val name : t -> string

  val index : t -> int

  val create : uri:Uri.t -> name:string -> index:int -> t

  (** {4 Converters} *)

  (** Get a [WorkspaceFolder.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [WorkspaceFolder.t]. *)
  val t_to_js : t -> Ojs.t
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

  val makePositions : anchor:Position.t -> active:Position.t -> t

  val makeCoordinates :
       anchorLine:int
    -> anchorCharacter:int
    -> activeLine:int
    -> activeCharacter:int
    -> t

  val isReversed : t -> bool
end

module TextEditorEdit : sig
  type t

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

  val setEndOfLine : t -> endOfLine:EndOfLine.t -> t

  val create :
       replace:(location:replaceLocation -> value:string -> unit)
    -> insert:(location:Position.t -> value:string -> unit)
    -> delete:(location:deleteLocation -> unit)
    -> setEndOfLine:(endOfLine:EndOfLine.t -> t)
    -> t

  (** {4 Converters} *)

  (** Get a [TextEditorEdit.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TextEditorEdit.t]. *)
  val t_to_js : t -> Ojs.t
end

module TextEditorCursorStyle : sig
  type t =
    | Line
    | Block
    | Underline
    | LineThin
    | BlockOutline
    | UnderlineThin

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
    | InCenter
    | InCenterIfOutsideViewport
    | AtTop

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module TextEditorOptions : sig
  type t

  type tabSize =
    [ `Int of int
    | `String of string
    ]

  type insertSpaces =
    [ `Bool of bool
    | `String of string
    ]

  val tabSize : t -> tabSize option

  val insertSpaces : t -> insertSpaces option

  val cursorStyle : t -> TextEditorCursorStyle.t option

  val lineNumbers : t -> TextEditorLineNumbersStyle.t option

  val create :
       ?tabSize:tabSize
    -> ?insertSpaces:insertSpaces
    -> ?cursorStyle:TextEditorCursorStyle.t
    -> ?lineNumbers:TextEditorLineNumbersStyle.t
    -> unit
    -> t

  (** {4 Converters} *)

  (** Get a [TextEditorOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TextEditorOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module TextEditorDecorationType : sig
  type t

  val key : t -> string

  val dispose : t -> unit

  val disposable : t -> Disposable.t

  val create : key:string -> dispose:(unit -> unit) -> t

  (** {4 Converters} *)

  (** Get a [TextEditorDecorationType.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TextEditorDecorationType.t]. *)
  val t_to_js : t -> Ojs.t
end

module MarkdownString : sig
  type t

  val value : t -> string

  val isTrusted : t -> bool option

  val supportThemeIcons : t -> bool option

  val make : ?value:string -> ?supportThemeIcons:bool -> unit -> t

  val appendText : t -> value:string -> t

  val appendMarkdown : t -> value:string -> t

  val appendCodeblock : t -> value:string -> ?language:string -> unit -> t

  (** {4 Converters} *)

  (** Get a [MarkdownString.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [MarkdownString.t]. *)
  val t_to_js : t -> Ojs.t
end

module ThemeColor : sig
  type t

  val make : id:string -> t

  (** {4 Converters} *)

  (** Get a [ThemeColor.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [ThemeColor.t]. *)
  val t_to_js : t -> Ojs.t
end

module ThemableDecorationAttachmentRenderOptions : sig
  type t

  type contentIconPath =
    [ `String of string
    | `Uri of Uri.t
    ]

  type color =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  val contentText : t -> string option

  val contentIconPath : t -> contentIconPath option

  val border : t -> string option

  val borderColor : t -> color option

  val fontStyle : t -> string option

  val fontWeight : t -> string option

  val textDecoration : t -> string option

  val color : t -> color option

  val backgroundColor : t -> color option

  val margin : t -> string option

  val width : t -> string option

  val height : t -> string option

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

  (** {4 Converters} *)

  (** Get a [ThemableDecorationAttachmentRenderOptions.t] from a JavaScript
      object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a
      [ThemableDecorationAttachmentRenderOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module ThemableDecorationInstanceRenderOptions : sig
  type t

  val before : t -> ThemableDecorationAttachmentRenderOptions.t option

  val after : t -> ThemableDecorationAttachmentRenderOptions.t option

  val create :
       ?before:ThemableDecorationAttachmentRenderOptions.t
    -> ?after:ThemableDecorationAttachmentRenderOptions.t
    -> unit
    -> t

  (** {4 Converters} *)

  (** Get a [ThemableDecorationInstanceRenderOptions.t] from a JavaScript
      object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a
      [ThemableDecorationInstanceRenderOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module DecorationInstanceRenderOptions : sig
  type t

  val light : t -> ThemableDecorationInstanceRenderOptions.t option

  val dark : t -> ThemableDecorationInstanceRenderOptions.t option

  val create :
       ?light:ThemableDecorationInstanceRenderOptions.t
    -> ?dark:ThemableDecorationInstanceRenderOptions.t
    -> unit
    -> t

  (** {4 Converters} *)

  (** Get a [DecorationInstanceRenderOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [DecorationInstanceRenderOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module DecorationOptions : sig
  type t

  type hoverMessage =
    [ `MarkdownString of MarkdownString.t
    | `MarkdownStrings of MarkdownString.t list
    ]

  val range : t -> Range.t

  val hoverMessage : t -> hoverMessage option

  val renderOptions : t -> DecorationInstanceRenderOptions.t option

  val create :
       range:Range.t
    -> ?hoverMessage:hoverMessage
    -> ?renderOptions:DecorationInstanceRenderOptions.t option
    -> unit
    -> t

  (** {4 Converters} *)

  (** Get a [DecorationOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [DecorationOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module SnippetString : sig
  type t

  val value : t -> string

  val make : ?value:string -> unit -> t

  val appendText : t -> string:string -> t

  val appendTabStop : t -> number:int -> t

  val appendPlaceHolder :
       t
    -> value:[ `String of string | `Function of t -> unit ]
    -> ?number:int
    -> unit
    -> t

  val appendChoice : t -> values:string list -> ?number:int -> unit -> t

  val appendVariable :
       t
    -> name:string
    -> defaultValue:[ `String of string | `Function of t -> unit ]
    -> t

  (** {4 Converters} *)

  (** Get a [SnippetString.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [SnippetString.t]. *)
  val t_to_js : t -> Ojs.t
end

module TextEditor : sig
  type t

  type insertSnippetLocation =
    [ `Position of Position.t
    | `Range of Range.t
    | `Positions of Position.t list
    | `Ranges of Range.t list
    ]

  val document : t -> TextDocument.t

  val selection : t -> Selection.t

  val selections : t -> Selection.t list

  val visibleRanges : t -> Range.t list

  val options : t -> TextEditorOptions.t

  val viewColumn : t -> ViewColumn.t option

  val edit :
       t
    -> callback:(editBuilder:TextEditorEdit.t -> unit)
    -> ?undoStopBefore:bool
    -> ?undoStopAfter:bool
    -> unit
    -> bool Promise.t

  val insertSnippet :
       t
    -> snippet:SnippetString.t
    -> ?location:insertSnippetLocation
    -> ?undoStopBefore:bool
    -> ?undoStopAfter:bool
    -> unit
    -> bool Promise.t

  val setDecorations :
       t
    -> decorationType:TextEditorDecorationType.t
    -> rangesOrOptions:
         [ `Ranges of Range.t list | `Options of DecorationOptions.t list ]
    -> unit

  val revealRange :
    t -> range:Range.t -> ?revealType:TextEditorRevealType.t -> unit -> unit

  (** {4 Converters} *)

  (** Get a [TextEditor.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TextEditor.t]. *)
  val t_to_js : t -> Ojs.t
end

module ConfigurationTarget : sig
  type t =
    | Global
    | Workspace
    | WorkspaceFolder

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module WorkspaceConfiguration : sig
  type t

  type configurationTarget =
    [ `ConfigurationTarget of ConfigurationTarget.t
    | `Bool of bool
    ]

  type inspectResult =
    { key : string
    ; defaultValue : Jsonoo.t option
    ; globalValue : Jsonoo.t option
    ; workspaceValue : Jsonoo.t option
    ; workspaceFolderValue : Jsonoo.t option
    ; defaultLanguageValue : Jsonoo.t option
    ; globalLanguageValue : Jsonoo.t option
    ; workspaceLanguageValue : Jsonoo.t option
    ; workspaceFolderLanguageValue : Jsonoo.t option
    ; languageIds : string option
    }

  val get : t -> section:string -> unit -> Jsonoo.t option

  val has : t -> section:string -> bool

  val inspect : t -> section:string -> inspectResult

  val update :
       t
    -> section:string
    -> value:Jsonoo.t
    -> ?configurationTarget:configurationTarget
    -> ?overrideInLanguage:bool
    -> unit
    -> Promise.void

  (** {4 Converters} *)

  (** Get a [WorkspaceConfiguration.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [WorkspaceConfiguration.t]. *)
  val t_to_js : t -> Ojs.t
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

  val label : t -> string

  val role : t -> string option

  val create : label:string -> ?role:string -> unit -> t

  (** {4 Converters} *)

  (** Get a [AccessibilityInformation.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [AccessibilityInformation.t]. *)
  val t_to_js : t -> Ojs.t
end

module StatusBarItem : sig
  type t

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

  val accessibilityInformation : t -> AccessibilityInformation.t option

  val set_alignment : t -> StatusBarAlignment.t -> unit

  val set_priority : t -> int -> unit

  val set_text : t -> string -> unit

  val set_tooltip : t -> string -> unit

  val set_color : t -> color -> unit

  val set_command : t -> command -> unit

  val set_accessibilityInformation : t -> AccessibilityInformation.t -> unit

  val show : t -> unit

  val hide : t -> unit

  val dispose : t -> unit

  val disposable : t -> Disposable.t

  (** {4 Converters} *)

  (** Get a [StatusBarItem.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [StatusBarItem.t]. *)
  val t_to_js : t -> Ojs.t
end

module WorkspaceFoldersChangeEvent : sig
  type t

  val added : t -> WorkspaceFolder.t list

  val removed : t -> WorkspaceFolder.t list

  val create :
    added:WorkspaceFolder.t list -> removed:WorkspaceFolder.t list -> t

  (** {4 Converters} *)

  (** Get a [WorkspaceFoldersChangeEvent.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [WorkspaceFoldersChangeEvent.t]. *)
  val t_to_js : t -> Ojs.t
end

module FormattingOptions : sig
  type t

  val tabSize : t -> int

  val insertSpaces : t -> bool

  val create : tabSize:int -> insertSpaces:bool -> t

  (** {4 Converters} *)

  (** Get a [FormattingOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [FormattingOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module Event : sig
  type 'a t = listener:('a -> unit) -> Disposable.t

  val t_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a t

  val t_to_js : ('a -> Ojs.t) -> 'a t -> Ojs.t
end

module CancellationToken : sig
  type t

  val isCancellationRequested : t -> bool

  val onCancellationRequested : t -> Ojs.t Event.t

  val create :
    isCancellationRequested:bool -> onCancellationRequested:Ojs.t Event.t -> t

  (** {4 Converters} *)

  (** Get a [CancellationToken.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [CancellationToken.t]. *)
  val t_to_js : t -> Ojs.t
end

module QuickPickItem : sig
  type t

  val label : t -> string

  val description : t -> string option

  val detail : t -> string option

  val picked : t -> bool option

  val alwaysShow : t -> bool option

  val create :
       label:string
    -> ?description:string
    -> ?detail:string
    -> ?picked:bool
    -> ?alwaysShow:bool
    -> unit
    -> t

  (** {4 Converters} *)

  (** Get a [QuickPickItem.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [QuickPickItem.t]. *)
  val t_to_js : t -> Ojs.t
end

module QuickPickOptions : sig
  type t

  type onDidSelectItemArgs =
    [ `QuickPickItem of QuickPickItem.t
    | `String of string
    ]

  val matchOnDescription : t -> bool option

  val matchOnDetail : t -> bool option

  val placeHolder : t -> string option

  val ignoreFocusOut : t -> bool option

  val canPickMany : t -> bool option

  val onDidSelectItem : t -> (onDidSelectItemArgs -> unit) option

  val create :
       ?matchOnDescription:bool
    -> ?matchOnDetail:bool
    -> ?placeHolder:string
    -> ?ignoreFocusOut:bool
    -> ?canPickMany:bool
    -> ?onDidSelectItem:(item:onDidSelectItemArgs -> unit)
    -> unit
    -> t

  (** {4 Converters} *)

  (** Get a [QuickPickOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [QuickPickOptions.t]. *)
  val t_to_js : t -> Ojs.t
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

  val value : t -> string option

  val valueSelection : t -> (int * int) option

  val prompt : t -> string option

  val placeHolder : t -> string option

  val password : t -> bool option

  val ignoreFocusOut : t -> bool option

  val validateInput : t -> (string -> string ProviderResult.t) option

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

  (** {4 Converters} *)

  (** Get a [InputBoxOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [InputBoxOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module MessageItem : sig
  type t

  val title : t -> string

  val isCloseAffordance : t -> bool option

  val create : title:string -> ?isCloseAffordance:bool -> unit -> t

  (** {4 Converters} *)

  (** Get a [MessageItem.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [MessageItem.t]. *)
  val t_to_js : t -> Ojs.t
end

module Location : sig
  type t

  val uri : t -> Uri.t

  val range : t -> Range.t

  val make :
       uri:Uri.t
    -> rangeOrPosition:[ `Range of Range.t | `Position of Position.t ]
    -> t

  (** {4 Converters} *)

  (** Get a [Location.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [Location.t]. *)
  val t_to_js : t -> Ojs.t
end

module ProgressLocation : sig
  type t =
    | SourceControl
    | Window
    | Notification

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module ProgressOptions : sig
  type t

  type location =
    [ `ProgressLocation of ProgressLocation.t
    | `ViewIdLocation of viewIdLocation
    ]

  and viewIdLocation = { viewId : string }

  val location : t -> location

  val title : t -> string option

  val cancellable : t -> bool option

  val create :
    location:location -> ?title:string -> ?cancellable:bool -> unit -> t

  (** {4 Converters} *)

  (** Get a [ProgressOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [ProgressOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module TextDocumentShowOptions : sig
  type t

  val viewColumn : t -> ViewColumn.t option

  val preserveFocus : t -> bool option

  val preview : t -> bool option

  val selection : t -> Range.t option

  val create :
       viewColumn:ViewColumn.t
    -> ?preserveFocus:bool
    -> ?preview:bool
    -> ?selection:Range.t
    -> unit
    -> t

  (** {4 Converters} *)

  (** Get a [TextDocumentShowOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TextDocumentShowOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module TerminalOptions : sig
  type t

  type shellArgs =
    [ `Arg of string
    | `Args of string list
    ]

  type cwd =
    [ `String of string
    | `Uri of Uri.t
    ]

  val name : t -> string option

  val shellPath : t -> string option

  val shellArgs : t -> shellArgs option

  val cwd : t -> cwd option

  val env : t -> string option Interop.Dict.t option

  val strictEnv : t -> bool

  val hideFromUser : t -> bool

  (** {4 Converters} *)

  (** Get a [TerminalOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TerminalOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module TerminalDimensions : sig
  type t

  val columns : t -> int

  val rows : t -> int

  val create : columns:int -> rows:int -> t

  (** {4 Converters} *)

  (** Get a [TerminalDimensions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TerminalDimensions.t]. *)
  val t_to_js : t -> Ojs.t
end

module Pseudoterminal : sig
  type t

  val onDidWrite : t -> string Event.t

  val onDidOverrideDimensions : t -> TerminalDimensions.t option Event.t option

  val onDidClose : t -> int option Event.t option

  val open_ : t -> ?initialDimensions:TerminalDimensions.t -> unit -> unit

  val close : t -> unit

  val handleInput : t -> (data:string -> unit) option

  val setDimensions : t -> (dimensions:TerminalDimensions.t -> unit) option

  val create :
       onDidWrite:string Event.t
    -> ?onDidOverrideDimensions:TerminalDimensions.t option Event.t
    -> ?onDidClose:int option Event.t
    -> open_:(?initialDimensions:TerminalDimensions.t -> unit -> unit)
    -> close:(unit -> unit)
    -> ?handleInput:(data:string -> unit)
    -> ?setDimensions:(dimensions:TerminalDimensions.t -> unit)
    -> unit
    -> t

  (** {4 Converters} *)

  (** Get a [Pseudoterminal.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [Pseudoterminal.t]. *)
  val t_to_js : t -> Ojs.t
end

module ExtensionTerminalOptions : sig
  type t

  val name : t -> string

  val pty : t -> Pseudoterminal.t

  val create : name:string -> pty:Pseudoterminal.t -> t

  (** {4 Converters} *)

  (** Get a [ExtensionTerminalOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [ExtensionTerminalOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module TerminalExitStatus : sig
  type t

  val code : t -> int

  val create : code:int -> t

  (** {4 Converters} *)

  (** Get a [TerminalExitStatus.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TerminalExitStatus.t]. *)
  val t_to_js : t -> Ojs.t
end

module Terminal : sig
  type t

  type creationOptions =
    [ `TerminalOptions of TerminalOptions.t
    | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
    ]

  val name : t -> string

  val processId : t -> int option Promise.t

  val creationOptions : t -> creationOptions

  val exitStatus : t -> TerminalExitStatus.t option

  val sendText : t -> text:string -> ?addNewLine:bool -> unit -> unit

  val show : t -> ?preserveFocus:bool -> unit -> unit

  val hide : t -> unit

  val dispose : t -> unit

  val disposable : t -> Disposable.t

  (** {4 Converters} *)

  (** Get a [Terminal.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [Terminal.t]. *)
  val t_to_js : t -> Ojs.t
end

module OutputChannel : sig
  type t

  val name : t -> string

  val append : t -> value:string -> unit

  val appendLine : t -> value:string -> unit

  val clear : t -> unit

  val show : t -> ?preserveFocus:bool -> unit -> unit

  val hide : t -> unit

  val dispose : t -> unit

  val disposable : t -> Disposable.t

  (** {4 Converters} *)

  (** Get a [OutputChannel.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [OutputChannel.t]. *)
  val t_to_js : t -> Ojs.t
end

module Memento : sig
  type t

  val get : t -> key:string -> Jsonoo.t option

  val update : t -> key:string -> value:Jsonoo.t -> Promise.void

  (** {4 Converters} *)

  (** Get a [Memento.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [Memento.t]. *)
  val t_to_js : t -> Ojs.t
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

  val type_ : t -> EnvironmentVariableMutatorType.t

  val value : t -> string

  (** {4 Converters} *)

  (** Get a [EnvironmentVariableMutator.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [EnvironmentVariableMutator.t]. *)
  val t_to_js : t -> Ojs.t
end

module EnvironmentVariableCollection : sig
  type t

  val persistent : t -> bool

  val replace : t -> variable:string -> value:string -> unit

  val append : t -> variable:string -> value:string -> unit

  val prepend : t -> variable:string -> value:string -> unit

  val get : t -> variable:string -> EnvironmentVariableMutator.t option

  val forEach :
       t
    -> callback:
         (   variable:string
          -> mutator:EnvironmentVariableMutator.t
          -> collection:t
          -> unit)
    -> unit

  val delete : t -> variable:string -> unit

  val clear : t -> unit

  (** {4 Converters} *)

  (** Get a [EnvironmentVariableCollection.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [EnvironmentVariableCollection.t]. *)
  val t_to_js : t -> Ojs.t
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

  val subscriptions : t -> Disposable.t list

  val workspaceState : t -> Memento.t

  val globalState : t -> Memento.t

  val extensionUri : t -> Uri.t

  val extensionPath : t -> string

  val environmentVariableCollection : t -> EnvironmentVariableCollection.t

  val asAbsolutePath : t -> relativePath:string -> string

  val storageUri : t -> Uri.t option

  val globalStorageUri : t -> Uri.t

  val logUri : t -> Uri.t

  val extensionMode : t -> ExtensionMode.t

  val subscribe : t -> disposable:Disposable.t -> unit

  (** {4 Converters} *)

  (** Get a [ExtensionContext.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [ExtensionContext.t]. *)
  val t_to_js : t -> Ojs.t
end

module ShellQuotingOptions : sig
  type t

  type escapeLiteral =
    { escapeChar : string
    ; charsToEscape : string
    }

  type escape =
    [ `String of string
    | `Literal of escapeLiteral
    ]

  val escape : t -> escape option

  val strong : t -> string option

  val weak : t -> string option

  val create : ?escape:escape -> ?strong:string -> ?weak:string -> unit -> t

  (** {4 Converters} *)

  (** Get a [ShellQuotingOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [ShellQuotingOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module ShellExecutionOptions : sig
  type t

  val executable : t -> string option

  val shellArgs : t -> string list

  val shellQuoting : t -> ShellQuotingOptions.t option

  val cwd : t -> string option

  val env : t -> string Interop.Dict.t option

  val create :
       ?executable:string
    -> ?shellArgs:string list
    -> ?shellQuoting:ShellQuotingOptions.t
    -> ?cwd:string
    -> ?env:string Interop.Dict.t
    -> unit
    -> t

  (** {4 Converters} *)

  (** Get a [ShellExecutionOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [ShellExecutionOptions.t]. *)
  val t_to_js : t -> Ojs.t
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

  val value : t -> string

  val quoting : t -> ShellQuoting.t

  val create : value:string -> quoting:ShellQuoting.t -> t

  (** {4 Converters} *)

  (** Get a [ShellQuotedString.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [ShellQuotedString.t]. *)
  val t_to_js : t -> Ojs.t
end

module ShellExecution : sig
  type t

  type shellString =
    [ `String of string
    | `ShellQuotedString of ShellQuotedString.t
    ]

  val makeCommandLine :
    commandLine:string -> ?options:ShellExecutionOptions.t -> unit -> t

  val makeCommandArgs :
       command:shellString
    -> args:shellString list
    -> ?options:ShellExecutionOptions.t
    -> unit
    -> t

  val commandLine : t -> string option

  val command : t -> shellString

  val args : t -> shellString list

  val options : t -> ShellExecutionOptions.t option

  (** {4 Converters} *)

  (** Get a [ShellExecution.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [ShellExecution.t]. *)
  val t_to_js : t -> Ojs.t
end

module ProcessExecutionOptions : sig
  type t

  val cwd : t -> string option

  val env : t -> string Interop.Dict.t option

  val create : ?cwd:string -> ?env:string Interop.Dict.t -> unit -> t

  (** {4 Converters} *)

  (** Get a [ProcessExecutionOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [ProcessExecutionOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module ProcessExecution : sig
  type t

  val makeProcess :
    process:string -> ?options:ProcessExecutionOptions.t -> unit -> t

  val makeProcessArgs :
       process:string
    -> args:string list
    -> ?options:ProcessExecutionOptions.t
    -> unit
    -> t

  val process : t -> string

  val args : t -> string list

  val options : t -> ProcessExecutionOptions.t option

  (** {4 Converters} *)

  (** Get a [ProcessExecution.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [ProcessExecution.t]. *)
  val t_to_js : t -> Ojs.t
end

module TaskDefinition : sig
  type t

  val type_ : t -> string

  val get_attribute : t -> string -> Ojs.t

  val set_attribute : t -> string -> Ojs.t -> unit

  val create : type_:string -> ?attributes:(string * Ojs.t) list -> unit -> t

  (** {4 Converters} *)

  (** Get a [TaskDefinition.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TaskDefinition.t]. *)
  val t_to_js : t -> Ojs.t
end

module CustomExecution : sig
  type t

  val make :
       callback:
         (resolvedDefinition:TaskDefinition.t -> Pseudoterminal.t Promise.t)
    -> t

  (** {4 Converters} *)

  (** Get a [CustomExecution.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [CustomExecution.t]. *)
  val t_to_js : t -> Ojs.t
end

module RelativePattern : sig
  type t

  val base : t -> string

  val pattern : t -> string

  val make :
       base:[ `String of string | `WorkspaceFolder of WorkspaceFolder.t ]
    -> pattern:string
    -> t

  (** {4 Converters} *)

  (** Get a [RelativePattern.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [RelativePattern.t]. *)
  val t_to_js : t -> Ojs.t
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

  val language : t -> string option

  val scheme : t -> string option

  val pattern : t -> GlobPattern.t option

  val create :
    ?language:string -> ?scheme:string -> ?pattern:GlobPattern.t -> unit -> t

  (** {4 Converters} *)

  (** Get a [DocumentFilter.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [DocumentFilter.t]. *)
  val t_to_js : t -> Ojs.t
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

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module DocumentFormattingEditProvider : sig
  type t

  val provideDocumentFormattingEdits :
       t
    -> document:TextDocument.t
    -> options:FormattingOptions.t
    -> token:CancellationToken.t
    -> TextEdit.t list ProviderResult.t

  val create :
       provideDocumentFormattingEdits:
         (   document:TextDocument.t
          -> options:FormattingOptions.t
          -> token:CancellationToken.t
          -> TextEdit.t list ProviderResult.t)
    -> t

  (** {4 Converters} *)

  (** Get a [DocumentFormattingEditProvider.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [DocumentFormattingEditProvider.t]. *)
  val t_to_js : t -> Ojs.t
end

module TaskGroup : sig
  type t

  val clean : t

  val build : t

  val rebuild : t

  val test : t

  (** {4 Converters} *)

  (** Get a [TaskGroup.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TaskGroup.t]. *)
  val t_to_js : t -> Ojs.t
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

  val reevaluateOnRerun : t -> bool option

  val create : ?reevaluateOnRerun:bool -> unit -> t

  (** {4 Converters} *)

  (** Get a [RunOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [RunOptions.t]. *)
  val t_to_js : t -> Ojs.t
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

  val reveal : t -> TaskRevealKind.t option

  val echo : t -> bool option

  val focus : t -> bool option

  val panel : t -> TaskPanelKind.t option

  val showReuseMessage : t -> bool option

  val clear : t -> bool option

  val create :
       ?reveal:TaskRevealKind.t
    -> ?echo:bool
    -> ?focus:bool
    -> ?panel:TaskPanelKind.t
    -> ?showReuseMessage:bool
    -> ?clear:bool
    -> unit
    -> t

  (** {4 Converters} *)

  (** Get a [TaskPresentationOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TaskPresentationOptions.t]. *)
  val t_to_js : t -> Ojs.t
end

module Task : sig
  type t

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
    -> ?problemMatchers:string list
    -> unit
    -> t

  val definition : t -> TaskDefinition.t

  val scope : t -> TaskScope.t option

  val name : t -> string

  val detail : t -> string option

  val execution : t -> execution option

  val isBackground : t -> bool

  val source : t -> string

  val group : t -> TaskGroup.t option

  val presentationOptions : t -> TaskPresentationOptions.t

  val runOptions : t -> RunOptions.t

  val set_group : t -> TaskGroup.t -> unit

  (** {4 Converters} *)

  (** Get a [Task.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [Task.t]. *)
  val t_to_js : t -> Ojs.t
end

module TaskProvider : sig
  type t

  val provideTasks :
    t -> token:CancellationToken.t -> Task.t list ProviderResult.t

  val resolveTasks :
    t -> task:Task.t -> token:CancellationToken.t -> Task.t ProviderResult.t

  val create :
       provideTasks:(token:CancellationToken.t -> Task.t list ProviderResult.t)
    -> resolveTasks:
         (task:Task.t -> token:CancellationToken.t -> Task.t ProviderResult.t)
    -> t

  (** {4 Converters} *)

  (** Get a [TaskProvider.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TaskProvider.t]. *)
  val t_to_js : t -> Ojs.t
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

  val modal : t -> bool option

  val create : ?modal:bool -> unit -> t

  (** {4 Converters} *)

  (** Get a [MessageOptions.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [MessageOptions.t]. *)
  val t_to_js : t -> Ojs.t
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

(** Namespace for dealing with the current workspace.

    A workspace is the representation of the folder that has been opened. There
    is no workspace when just a file but not a folder has been opened.

    The workspace offers support for
    [listening](#workspace.createFileSystemWatcher) to fs events and for
    [finding](#workspace.findFiles) files. Both perform well and run _outside_
    the editor-process so that they should be always used instead of
    nodejs-equivalents. *)
module Workspace : sig
  (** List of workspace folders or `undefined` when no folder is open. *Note*
      that the first entry corresponds to the value of `rootPath`. *)
  val workspaceFolders : unit -> WorkspaceFolder.t list

  (** The name of the workspace. `undefined` when no folder has been opened. *)
  val name : unit -> string option

  (** The location of the workspace file, for example:

      `file:///Users/name/Development/myProject.code-workspace`

      or

      `untitled:1555503116870`

      for a workspace that is untitled and not yet saved.

      Depending on the workspace that is opened, the value will be: *
      `undefined` when no workspace or a single folder is opened * the path of
      the workspace file as `Uri` otherwise. if the workspace is untitled, the
      returned URI will use the `untitled:` scheme

      The location can e.g. be used with the `vscode.openFolder` command to open
      the workspace again after it has been closed.

      **Example:** ```typescript
      vscode.commands.executeCommand('vscode.openFolder', uriOfWorkspace); ```

      **Note:** it is not advised to use `workspace.workspaceFile` to write
      configuration data into the file. You can use
      `workspace.getConfiguration().update()` for that purpose which will work
      both when a single folder is opened as well as an untitled or saved
      workspace. *)
  val workspaceFile : unit -> Uri.t option

  (** An event that is emitted when a workspace folder is added or removed. *)
  val onDidChangeWorkspaceFolders : WorkspaceFolder.t Event.t

  (** Returns the [workspace folder](#WorkspaceFolder) that contains a given
      uri.

      - returns `undefined` when the given uri doesn't match any workspace
        folder
      - returns the *input* when the given uri is a workspace folder itself

      @param uri An uri.
      @return A workspace folder or `undefined` *)
  val getWorkspaceFolder : uri:Uri.t -> WorkspaceFolder.t option

  (** Find files across all [workspace folders](#workspace.workspaceFolders) in
      the workspace.

      @param include A [glob pattern](#GlobPattern) that defines the files to
      search for. The glob pattern will be matched against the file paths of
      resulting matches relative to their workspace. Use a
      [relative pattern](#RelativePattern) to restrict the search results to a
      [workspace folder](#WorkspaceFolder).
      @param exclude A [glob pattern](#GlobPattern) that defines files and
      folders to exclude. The glob pattern will be matched against the file
      paths of resulting matches relative to their workspace. When `undefined`
      only default excludes will apply, when `null` no excludes will apply.
      @param maxResults An upper-bound for the result.
      @param token A token that can be used to signal cancellation to the
      underlying search engine.
      @return A thenable that resolves to an array of resource identifiers. Will
      return no results if no [workspace folders](#workspace.workspaceFolders)
      are opened. *)
  val findFiles :
       includes:GlobPattern.t
    -> ?excludes:GlobPattern.t
    -> ?maxResults:int
    -> ?token:CancellationToken.t
    -> unit
    -> Uri.t list Promise.t

  (** All text documents currently known to the system. *)
  val textDocuments : unit -> TextDocument.t list

  type textDocumentOptions =
    { language : string
    ; content : string
    }

  (** Opens a document. Will return early if this document is already open.
      Otherwise the document is loaded and the
      [didOpen](#workspace.onDidOpenTextDocument)-event fires.

      The document is denoted by an [uri](#Uri). Depending on the
      [scheme](#Uri.scheme) the following rules apply:

      - `file`-scheme: Open a file on disk, will be rejected if the file does
        not exist or cannot be loaded.
      - `untitled`-scheme: A new file that should be saved on disk, e.g.
        `untitled:c:\frodo\new.js`. The language will be derived from the file
        name. * For all other schemes contributed
        [text document content providers](#TextDocumentContentProvider) and
        [file system providers](#FileSystemProvider) are consulted.

      *Note* that the lifecycle of the returned document is owned by the editor
      and not by the extension. That means an
      [`onDidClose`](#workspace.onDidCloseTextDocument)-event can occur at any
      time after opening it.

      @param uri Identifies the resource to open.
      @return A promise that resolves to a [document](#TextDocument). *)
  val openTextDocument :
       [ `Uri of Uri.t
       | `Filename of string
       | `Interactive of textDocumentOptions option
       ]
    -> TextDocument.t Promise.t

  (** An event that is emitted when a [text document](#TextDocument) is opened
      or when the language id of a text document
      [has been changed](#languages.setTextDocumentLanguage).

      To add an event listener when a visible text document is opened, use the
      [TextEditor](#TextEditor) events in the [window](#window) namespace. Note
      that:

      - The event is emitted before the [document](#TextDocument) is updated in
        the [active text editor](#window.activeTextEditor)
      - When a [text document](#TextDocument) is already open (e.g.: open in
        another [visible text editor](#window.visibleTextEditors)) this event is
        not emitted *)
  val onDidOpenTextDocument : TextDocument.t Event.t

  (** An event that is emitted when a [text document](#TextDocument) is disposed
      or when the language id of a text document
      [has been changed](#languages.setTextDocumentLanguage).

      *Note 1:* There is no guarantee that this event fires when an editor tab
      is closed, use the
      [`onDidChangeVisibleTextEditors`](#window.onDidChangeVisibleTextEditors)-event
      to know when editors change.

      *Note 2:* A document can be open but not shown in an editor which means
      this event can fire for a document that has not been shown in an editor. *)
  val onDidCloseTextDocument : TextDocument.t Event.t

  (** Get a workspace configuration object.

      When a section-identifier is provided only that part of the configuration
      is returned. Dots in the section-identifier are interpreted as
      child-access, like

      {[ { myExt: { setting: { doIt: true }}} ]}

      and `getConfiguration('myExt.setting').get('doIt') === true`.

      When a scope is provided configuration confined to that scope is returned.
      Scope can be a resource or a language identifier or both.

      @param section A dot-separated identifier.
      @param scope A scope for which the configuration is asked for.
      @return The full configuration or a subset. *)
  val getConfiguration :
       ?section:string
    -> ?scope:ConfigurationScope.t
    -> unit
    -> WorkspaceConfiguration.t
end

(** Collapsible state of the tree item *)
module TreeItemCollapsibleState : sig
  type t =
    | None
        (** Determines an item can be neither collapsed nor expanded. Implies it
            has no children. *)
    | Collapsed  (** Determines an item is collapsed *)
    | Expanded  (** Determines an item is expanded *)
end

(** Label describing the [Tree item](#TreeItem) *)
module TreeItemLabel : sig
  type t

  val create : label:string -> ?highlights:(int * int) list -> unit -> t

  (** Label describing the [Tree item](#TreeItem) *)
  val label : t -> string

  (** Ranges in the label to highlight.

      A range is defined as a tuple of two number where the first is the
      inclusive start index and the second the exclusive end index *)
  val highlights : t -> (int * int) list option

  (** {4 Converters} *)

  (** Get a [TreeItem.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TreeItem.t]. *)
  val t_to_js : t -> Ojs.t
end

(** A reference to a named icon.

    Currently, [File](#ThemeIcon.File), [Folder](#ThemeIcon.Folder), and
    [ThemeIcon ids](https://code.visualstudio.com/api/references/icons-in-labels#icon-listing)
    are supported. Using a theme icon is preferred over a custom icon as it
    gives product theme authors the possibility to change the icons.

    *Note* that theme icons can also be rendered inside labels and descriptions.
    Places that support theme icons spell this out and they use the
    [$(<name>)]-syntax, for instance [quickPick.label = "Hello World $(globe)"]. *)
module ThemeIcon : sig
  type t

  (** {4 Constructors} *)

  (** Creates a reference to a theme icon.

      @param id id of the icon. The available icons are listed in
      https://code.visualstudio.com/api/references/icons-in-labels#icon-listing.
      @param color optional `ThemeColor` for the icon. The color is currently
      only used in [TreeItem](#TreeItem). *)
  val make : id:string -> ?color:ThemeColor.t -> unit -> t

  (** {4 Properties} *)

  (** Reference to an icon representing a file. The icon is taken from the
      current file icon theme or a placeholder icon is used. *)
  val file : t

  (** Reference to an icon representing a folder. The icon is taken from the
      current file icon theme or a placeholder icon is used. *)
  val folder : t

  (** The id of the icon. The available icons are listed in
      https://code.visualstudio.com/api/references/icons-in-labels#icon-listing. *)
  val id : t -> string

  (** The optional ThemeColor of the icon. The color is currently only used in
      [TreeItem](#TreeItem). *)
  val color : t -> ThemeColor.t option

  (** {4 Converters} *)

  (** Get a [TreeItem.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TreeItem.t]. *)
  val t_to_js : t -> Ojs.t
end

module TreeItem : sig
  type t

  type lightDarkIcon =
    { light : [ `String of string | `Uri of Uri.t ]
    ; dark : [ `String of string | `Uri of Uri.t ]
    }

  type iconPath =
    [ `String of string
    | `Uri of Uri.t
    | `LightDark of lightDarkIcon
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

  (** {4 Constructors} *)

  (** Create a new TreeItem.

      @param label A human-readable string describing this item.
      @param collapsibleState [TreeItemCollapsibleState] of the tree item.
      Default is [TreeItemCollapsibleState.None] *)
  val make :
       label:TreeItemLabel.t
    -> ?collapsibleState:TreeItemCollapsibleState.t
    -> unit
    -> t

  (** Create a new TreeItem from a resource URI.

      @param uri The uri of the resource representing this item.
      @param collapsibleState [TreeItemCollapsibleState] of the tree item.
      Default is [TreeItemCollapsibleState.None] *)
  val of_uri :
       resourceUri:Uri.t
    -> ?collapsibleState:TreeItemCollapsibleState.t
    -> unit
    -> t

  (** {4 Properties} *)

  (** A human-readable string describing this item. When [falsy], it is derived
      from {{!TreeItem.resourceUri} [resourceUri]}. *)
  val label : t -> TreeItemLabel.t option

  val set_label : t -> TreeItemLabel.t -> unit

  (** Optional id for the tree item that has to be unique across tree. The id is
      used to preserve the selection and expansion state of the tree item.

      If not provided, an id is generated using the tree item's label. {b Note}
      that when labels change, ids will change and that selection and expansion
      state cannot be kept stable anymore. *)
  val id : t -> string option

  val set_id : t -> string -> unit

  (** The [ThemeIcon](#ThemeIcon) for the tree item.

      When [falsy], [Folder Theme Icon](#ThemeIcon.Folder) is assigned, if item
      is collapsible otherwise [File Theme Icon](#ThemeIcon.File).

      When a file or folder [ThemeIcon](#ThemeIcon) is specified, icon is
      derived from the current file icon theme for the specified theme icon
      using [resourceUri](#TreeItem.resourceUri) (if provided). *)
  val iconPath : t -> iconPath option

  val set_iconPath : t -> iconPath -> unit

  (** A human-readable string which is rendered less prominent.

      When [true], it is derived from [resourceUri](#TreeItem.resourceUri) and
      when [falsy], it is not shown. *)
  val description : t -> description option

  val set_description : t -> description -> unit

  (** The [uri](#Uri) of the resource representing this item.

      Will be used to derive the [label](#TreeItem.label), when it is not
      provided.

      Will be used to derive the icon from current file icon theme, when
      [iconPath](#TreeItem.iconPath) has [ThemeIcon](#ThemeIcon) value. *)
  val resourceUri : t -> Uri.t option

  val set_resourceUri : t -> Uri.t -> unit

  (** The tooltip text when you hover over this item. *)
  val tooltip : t -> tooltip option

  val set_tooltip : t -> tooltip -> unit

  (** TreeItemCollapsibleState of the tree item. *)
  val collapsibleState : t -> TreeItemCollapsibleState.t option

  val set_collapsibleState : t -> TreeItemCollapsibleState.t -> unit

  (** The command that should be executed when the tree item is selected. *)
  val command : t -> Command.t option

  val set_command : t -> Command.t -> unit

  (** Context value of the tree item. This can be used to contribute item
      specific actions in the tree. For example, a tree item is given a context
      value as [folder]. When contributing actions to [view/item/context] using
      [menus] extension point, you can specify context value for key [viewItem]
      in [when] expression like [viewItem == folder].

      {[
        "contributes": {
            "menus": {
                "view/item/context": [
                    {
                        "command": "extension.deleteFolder",
                        "when": "viewItem == folder"
                    }
                ]
            }
        }
      ]}

      This will show action [extension.deleteFolder] only for items with
      [contextValue] is [folder]. *)
  val contextValue : t -> string option

  val set_contextValue : t -> string -> unit

  (** Accessibility information used when screen reader interacts with this tree
      item.

      Generally, a TreeItem has no need to set the [role] of the
      accessibilityInformation however, there are cases where a TreeItem is not
      displayed in a tree-like way where setting the [role] may make sense. *)
  val accessibilityInformation : t -> AccessibilityInformation.t option

  val set_accessibilityInformation : t -> AccessibilityInformation.t -> unit

  (** {4 Converters} *)

  (** Get a [TreeItem.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TreeItem.t]. *)
  val t_to_js : t -> Ojs.t
end

(** A data provider that provides tree data *)
module TreeDataProvider : sig
  type t

  val create :
       getTreeItem:(element:TreeItem.t -> TreeItem.t Promise.t)
    -> getChildren:
         (element:TreeItem.t option -> TreeItem.t list ProviderResult.t)
    -> ?getParent:(element:TreeItem.t -> TreeItem.t ProviderResult.t)
    -> ?onDidChangeTreeData:Ojs.t option Event.t
    -> ?resolveTreeItem:
         (item:TreeItem.t -> element:TreeItem.t -> TreeItem.t ProviderResult.t)
    -> unit
    -> t

  (** An optional event to signal that an element or root has changed.

      This will trigger the view to update the changed element/root and its
      children recursively (if shown). To signal that root has changed, do not
      pass any argument or pass `undefined` or `null`. *)
  val onDidChangeTreeData : t -> Ojs.t option Event.t option

  (** Get TreeItem representation of the element

      @param element The element for which TreeItem representation is asked for.
      @return TreeItem representation of the element *)
  val getTreeItem : t -> element:TreeItem.t -> TreeItem.t Promise.t

  (** Get the children of element or root if no element is passed.

      @param element The element from which the provider gets children. Can be
      undefined.
      @return Children of element or root if no element is passed. *)
  val getChildren :
    t -> element:TreeItem.t option -> TreeItem.t list ProviderResult.t

  (** Optional method to return the parent of element. Return null or undefined
      if element is a child of root.

      {b NOTE:} This method should be implemented in order to access
      {{:https://code.visualstudio.com/api/references/vscode-api#TreeView.reveal}
      reveal} API.

      @param element The element for which the parent has to be returned.
      @return Parent of element. *)
  val getParent :
    t -> (element:TreeItem.t -> TreeItem.t ProviderResult.t) option

  (** Called only on hover to resolve the [TreeItem](#TreeItem.tooltip) property
      if it is undefined. Only properties that were undefined can be resolved in
      `resolveTreeItem`. Functionality may be expanded later to include being
      called to resolve other missing properties on selection and/or on open.

      Will only ever be called once per TreeItem.

      onDidChangeTreeData should not be triggered from within resolveTreeItem.

      *Note* that this function is called when tree items are already showing in
      the UI. Because of that, no property that changes the presentation (label,
      description, command, etc.) can be changed.

      @param element The object associated with the TreeItem
      @param item Undefined properties of `item` should be set then `item`
      should be returned.
      @return The resolved tree item or a thenable that resolves to such. It is
      OK to return the given `item`. When no result is returned, the given
      `item` will be used. *)
  val resolveTreeItem :
       t
    -> (item:TreeItem.t -> element:TreeItem.t -> TreeItem.t ProviderResult.t)
       option
end

(** Options for creating a [TreeView](#TreeView) *)
module TreeViewOptions : sig
  type t

  (** A data provider that provides tree data. *)
  val treeDataProvider : t -> TreeDataProvider.t

  (** Whether to show collapse all action or not. *)
  val showCollapseAll : t -> bool option

  (** Whether the tree supports multi-select.

      When the tree supports multi-select and a command is executed from the
      tree, the first argument to the command is the tree item that the command
      was executed on and the second argument is an array containing all
      selected tree items. *)
  val canSelectMany : t -> bool option
end

(** The event that is fired when an element in the [TreeView](#TreeView) is
    expanded or collapsed *)

(* module TreeViewExpansionEvent : sig type t

   (** Element that is expanded or collapsed. *) val element : t -> 'a end *)

(** The event that is fired when there is a change in
    [tree view's selection](#TreeView.selection) *)

(* module TreeViewSelectionChangeEvent : sig type t

   (** Selected elements. *) val selection : t -> 'a list end *)

(** The event that is fired when there is a change in
    [tree view's visibility](#TreeView.visible) *)

(* module TreeViewVisibilityChangeEvent : sig type t

   (** `true` if the [tree view](#TreeView) is visible otherwise `false`. *) val
   visible : t -> bool end *)

(** Represents a Tree view *)
module TreeView : sig
  type t

  (** Event that is fired when an element is expanded *)

  (* val onDidExpandElement : t -> TreeViewExpansionEvent.t Event.t *)

  (** Event that is fired when an element is collapsed *)

  (* val onDidCollapseElement : t -> TreeViewExpansionEvent.t Event.t *)

  (** Currently selected elements. *)

  (* val selection : t -> 'a list *)

  (** Event that is fired when the [selection](#TreeView.selection) has changed *)

  (* val onDidChangeSelection : t -> TreeViewSelectionChangeEvent.t Event.t *)

  (** `true` if the [tree view](#TreeView) is visible otherwise `false`. *)
  val visible : t -> bool

  (** Event that is fired when [visibility](#TreeView.visible) has changed *)

  (* val onDidChangeVisibility : t -> TreeViewVisibilityChangeEvent.t Event.t *)

  (** An optional human-readable message that will be rendered in the view.
      Setting the message to null, undefined, or empty string will remove the
      message from the view. *)
  val message : t -> string option

  (** The tree view title is initially taken from the extension package.json
      Changes to the title property will be properly reflected in the UI in the
      title of the view. *)
  val title : t -> string option

  (** An optional human-readable description which is rendered less prominently
      in the title of the view. Setting the title description to null,
      undefined, or empty string will remove the description from the view. *)
  val description : t -> string option

  (** Reveals the given element in the tree view. If the tree view is not
      visible then the tree view is shown and element is revealed.

      By default revealed element is selected. In order to not to select, set
      the option `select` to `false`. In order to focus, set the option `focus`
      to `true`. In order to expand the revealed element, set the option
      `expand` to `true`. To expand recursively set `expand` to the number of
      levels to expand. **NOTE:** You can expand only to 3 levels maximum.

      **NOTE:** The [TreeDataProvider](#TreeDataProvider) that the `TreeView`
      [is registered with](#window.createTreeView) with must implement
      [getParent](#TreeDataProvider.getParent) method to access this API. *)

  (* val reveal : element:'a -> ?select:bool -> ?focus:bool -> ?expand:bool ->
     unit -> unit Promise.t *)

  (** {4 Converters} *)

  (** Get a [TreeDataProvider.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [TreeDataProvider.t]. *)
  val t_to_js : t -> Ojs.t
end

(** Namespace for dealing with the current window of the editor.

    That is visible and active editors, as well as, UI elements to show
    messages, selections, and asking for user input. *)
module Window : sig
  (** The currently active editor or `undefined`.

      The active editor is the one that currently has focus or, when none has
      focus, the one that has changed input most recently. *)
  val activeTextEditor : unit -> TextEditor.t option

  (** The currently visible editors or an empty array. *)
  val visibleTextEditors : unit -> TextEditor.t Array.t

  (** An [event](#Event) which fires when the
      [active editor](#window.activeTextEditor) has changed. *Note* that the
      event also fires when the active editor changes to `undefined`. *)
  val onDidChangeActiveTextEditor : unit -> TextEditor.t Event.t

  (** An [event](#Event) which fires when the array of
      [visible editors](#window.visibleTextEditors) has changed. *)
  val onDidChangeVisibleTextEditors : unit -> TextEditor.t Array.t Event.t

  (** The currently opened terminals or an empty array. *)
  val terminals : unit -> Terminal.t List.t

  (** The currently active terminal or `undefined`. The active terminal is the
      one that currently has focus or most recently had focus. *)
  val activeTerminal : unit -> Terminal.t option

  (** An [event](#Event) which fires when the
      [active terminal](#window.activeTerminal) has changed. *Note* that the
      event also fires when the active terminal changes to `undefined`. *)
  val onDidChangeActiveTerminal : unit -> Terminal.t option Event.t

  (** An [event](#Event) which fires when a terminal has been created, either
      through the [createTerminal](#window.createTerminal) API or commands. *)
  val onDidOpenTerminal : unit -> Terminal.t Event.t

  (** An [event](#Event) which fires when a terminal is disposed. *)
  val onDidCloseTerminal : unit -> Terminal.t Event.t

  (** Show the given document in a text editor. A [column](#ViewColumn) can be
      provided to control where the editor is being shown. Might change the
      [active editor](#window.activeTextEditor).

      @param document A text document to be shown.
      @param column A view column in which the [editor](#TextEditor) should be
      shown. The default is the [active](#ViewColumn.Active), other values are
      adjusted to be `Min(column, columnCount + 1)`, the
      [active](#ViewColumn.Active)-column is not adjusted. Use
      [`ViewColumn.Beside`](#ViewColumn.Beside) to open the editor to the side
      of the currently active one.
      @param preserveFocus When `true` the editor will not take focus.
      @return A promise that resolves to an [editor](#TextEditor). *)
  val showTextDocument :
       document:[ `TextDocument of TextDocument.t | `Uri of Uri.t ]
    -> ?column:ViewColumn.t
    -> ?preserveFocus:bool
    -> unit
    -> TextEditor.t Promise.t

  (** Show an information message to users. Optionally provide an array of items
      which will be presented as clickable buttons.

      @param message The message to show.
      @param options Configures the behaviour of the message.
      @param items A set of items that will be rendered as actions in the
      message.
      @return A promise that resolves to the selected item or `undefined` when
      being dismissed. *)
  val showInformationMessage :
       message:string
    -> ?options:MessageOptions.t
    -> ?choices:(string * 'a) list
    -> unit
    -> 'a option Promise.t

  (** Show a warning message.

      See [showInformationMessage](#window.showInformationMessage)

      @param message The message to show.
      @param options Configures the behaviour of the message.
      @param items A set of items that will be rendered as actions in the
      message.
      @return A promise that resolves to the selected item or `undefined` when
      being dismissed. *)
  val showWarningMessage :
       message:string
    -> ?options:MessageOptions.t
    -> ?choices:(string * 'a) list
    -> unit
    -> 'a option Promise.t

  (** Show an error message.

      See [showInformationMessage](#window.showInformationMessage)

      @param message The message to show.
      @param options Configures the behaviour of the message.
      @param items A set of items that will be rendered as actions in the
      message.
      @return A promise that resolves to the selected item or `undefined` when
      being dismissed. *)
  val showErrorMessage :
       message:string
    -> ?options:MessageOptions.t
    -> ?choices:(string * 'a) list
    -> unit
    -> 'a option Promise.t

  (** Shows a selection list.

      @param items An association of [QuickPickItem.t] and the type to resolve
      on selection.
      @param options Configures the behavior of the selection list.
      @param token A token that can be used to signal cancellation.
      @return A promise that resolves to the selected items or `undefined`. *)
  val showQuickPickItems :
       choices:(QuickPickItem.t * 'a) list
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> 'a option Promise.t

  (** Shows a selection list allowing a single selections.

      @param items A list of strings.
      @param options Configures the behavior of the selection list.
      @param token A token that can be used to signal cancellation.
      @return A promise that resolves to the selected items or `undefined`. *)
  val showQuickPick :
       items:string list
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string option Promise.t

  (** Opens an input box to ask the user for input.

      The returned value will be `undefined` if the input box was canceled (e.g.
      pressing ESC). Otherwise the returned value will be the string typed by
      the user or an empty string if the user did not type anything but
      dismissed the input box with OK.

      @param options Configures the behavior of the input box.
      @param token A token that can be used to signal cancellation.
      @return A promise that resolves to a string the user provided or to
      `undefined` in case of dismissal. *)
  val showInputBox :
       ?options:InputBoxOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string option Promise.t

  (** Creates a new [output channel](#OutputChannel) with the given name.

      @param name Human-readable string which will be used to represent the
      channel in the UI. *)
  val createOutputChannel : name:string -> OutputChannel.t

  (** Set a message to the status bar. This is a short hand for the more
      powerful status bar [items](#window.createStatusBarItem).

      @param text The message to show, supports icon substitution as in status
      bar [items](#StatusBarItem.text).
      @param hide Timeout in milliseconds after which the message will be
      disposed or Promise on which completion (resolve or reject) the message
      will be disposed.
      @return A disposable which hides the status bar message. *)
  val setStatusBarMessage :
    text:string -> ?hide:[ `AfterTimeout of int ] -> unit -> Disposable.t

  (** Show progress in the editor. Progress is shown while running the given
      callback and while the promise it returned isn't resolved nor rejected.
      The location at which progress should show (and other details) is defined
      via the passed [`ProgressOptions`](#ProgressOptions).

      @param task A callback returning a promise. Progress state can be reported
      with the provided [progress](#Progress)-object.

      To report discrete progress, use `increment` to indicate how much work has
      been completed. Each call with a `increment` value will be summed up and
      reflected as overall progress until 100% is reached (a value of e.g. `10`
      accounts for `10%` of work done). Note that currently only
      `ProgressLocation.Notification` is capable of showing discrete
      progress.

      To monitor if the operation has been cancelled by the user, use the
      provided [`CancellationToken`](#CancellationToken). Note that currently
      only `ProgressLocation.Notification` is supporting to show a cancel button
      to cancel the long running operation.
      @return The promise the task-callback returned. *)
  val withProgress :
       options:ProgressOptions.t
    -> task:(progress:Progress.t -> token:CancellationToken.t -> 'a Promise.t)
    -> 'a Promise.t

  (** Creates a status bar [item](#StatusBarItem).

      @param alignment The alignment of the item.
      @param priority The priority of the item. Higher values mean the item
      should be shown more to the left.
      @return A new status bar item. *)
  val createStatusBarItem :
    ?alignment:StatusBarAlignment.t -> ?priority:int -> unit -> StatusBarItem.t

  (** Creates a [Terminal](#Terminal) with a backing shell process. The cwd of
      the terminal will be the workspace directory if it exists.

      @param name Optional human-readable string which will be used to represent
      the terminal in the UI.
      @param shellPath Optional path to a custom shell executable to be used in
      the terminal.
      @param shellArgs Optional args for the custom shell executable. A string
      can be used on Windows only which allows specifying shell args in
      [command-line format](https://msdn.microsoft.com/en-au/08dfcab2-eb6e-49a4-80eb-87d4076c98c6).
      @return A new Terminal.
      @raise When running in an environment where a new process cannot be
      started. *)
  val createTerminal :
       ?name:string
    -> ?shellPath:string
    -> ?shellArgs:[ `String of string | `Strings of string list ]
    -> unit
    -> Terminal.t

  (** Creates a [Terminal](#Terminal) with a backing shell process.

      @param options A TerminalOptions object describing the characteristics of
      the new terminal.
      @return A new Terminal.
      @raise When running in an environment where a new process cannot be
      started. *)
  val createTerminalFromOptions :
       options:
         [ `TerminalOptions of TerminalOptions.t
         | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
         ]
    -> Terminal.t

  (** Register a [TreeDataProvider](#TreeDataProvider) for the view contributed
      using the extension point `views`. This will allow you to contribute data
      to the [TreeView](#TreeView) and update if the data changes.

      **Note:** To get access to the [TreeView](#TreeView) and perform
      operations on it, use [createTreeView](#window.createTreeView).

      @param viewId Id of the view contributed using the extension point
      `views`.
      @param treeDataProvider A [TreeDataProvider](#TreeDataProvider) that
      provides tree data for the view *)
  val registerTreeDataProvider :
    viewId:string -> treeDataProvider:TreeDataProvider.t -> Disposable.t

  (** Create a [TreeView](#TreeView) for the view contributed using the
      extension point `views`.

      @param viewId Id of the view contributed using the extension point
      `views`.
      @param options Options for creating the [TreeView](#TreeView)
      @return a [TreeView](#TreeView). *)
  val createTreeView : viewId:string -> options:TreeViewOptions.t -> TreeView.t
end

module Commands : sig
  val registerCommand :
    command:string -> callback:(args:Ojs.t list -> unit) -> Disposable.t

  val registerTextEditorCommand :
       command:string
    -> callback:
         (   textEditor:TextEditor.t
          -> edit:TextEditorEdit.t
          -> args:Ojs.t list
          -> unit)
    -> Disposable.t

  val executeCommand :
    command:string -> args:Ojs.t list -> Ojs.t option Promise.t

  val getCommands : ?filterInternal:bool -> unit -> string list Promise.t
end

module Languages : sig
  val registerDocumentFormattingEditProvider :
       selector:DocumentSelector.t
    -> provider:DocumentFormattingEditProvider.t
    -> Disposable.t
end

module Tasks : sig
  val registerTaskProvider :
    type_:string -> provider:TaskProvider.t -> Disposable.t
end

module Env : sig
  val shell : unit -> string
end

module LabelIcons : sig
  val package : string
end
