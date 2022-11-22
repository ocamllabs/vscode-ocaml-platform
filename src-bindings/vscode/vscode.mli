open Interop

val version : string

module Disposable : sig
  include Js.T

  val from : t list -> t

  val make : dispose:(unit -> unit) -> t

  val dispose : t -> unit
end

module Command : sig
  include Js.T

  val title : t -> string

  val command : t -> string

  val tooltip : t -> string option

  val arguments : t -> Js.Any.t list

  val create :
       title:string
    -> command:string
    -> ?tooltip:string
    -> ?arguments:Js.Any.t list
    -> unit
    -> t
end

module Position : sig
  include Js.T

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
end

module Range : sig
  include Js.T

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
end

module TextLine : sig
  include Js.T

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
end

module EndOfLine : sig
  type t =
    | CRLF
    | LF

  include Js.T with type t := t
end

module TextEdit : sig
  include Js.T

  val replace : range:Range.t -> newText:string -> t

  val insert : position:Position.t -> newText:string -> t

  val delete : Range.t -> t

  val setEndOfLine : EndOfLine.t -> t

  val range : t -> Range.t

  val newText : t -> string

  val newEol : t -> EndOfLine.t option

  val make : range:Range.t -> newText:string -> t
end

module Uri : sig
  include Js.T

  module Scheme : sig
    type t =
      [ `File
      | `Untitled
        (** URI scheme used by vscode for new draft (not-saved) files *)
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

  val with_ :
       t
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
end

module TextDocument : sig
  include Js.T

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
end

module WorkspaceFolder : sig
  include Js.T

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

  include Js.T with type t := t
end

module Selection : sig
  include module type of Range with type t = private Range.t

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
  include Js.T

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
end

module TextEditorCursorStyle : sig
  type t =
    | Line
    | Block
    | Underline
    | LineThin
    | BlockOutline
    | UnderlineThin

  include Js.T with type t := t
end

module TextEditorLineNumbersStyle : sig
  type t =
    | Off
    | On
    | Relative

  include Js.T with type t := t
end

module TextEditorRevealType : sig
  type t =
    | Default
    | InCenter
    | InCenterIfOutsideViewport
    | AtTop

  include Js.T with type t := t
end

module TextEditorOptions : sig
  include Js.T

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
end

module TextEditorDecorationType : sig
  include Js.T

  val key : t -> string

  val dispose : t -> unit

  val disposable : t -> Disposable.t

  val create : key:string -> dispose:(unit -> unit) -> t
end

module MarkdownString : sig
  include Js.T

  val value : t -> string

  val isTrusted : t -> bool option

  val supportThemeIcons : t -> bool option

  val make : ?value:string -> ?supportThemeIcons:bool -> unit -> t

  val appendText : t -> value:string -> t

  val appendMarkdown : t -> value:string -> t

  val appendCodeblock : t -> value:string -> ?language:string -> unit -> t
end

module ThemeColor : sig
  include Js.T

  val make : id:string -> t
end

module ThemableDecorationAttachmentRenderOptions : sig
  include Js.T

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
end

module ThemableDecorationInstanceRenderOptions : sig
  include Js.T

  val before : t -> ThemableDecorationAttachmentRenderOptions.t option

  val after : t -> ThemableDecorationAttachmentRenderOptions.t option

  val create :
       ?before:ThemableDecorationAttachmentRenderOptions.t
    -> ?after:ThemableDecorationAttachmentRenderOptions.t
    -> unit
    -> t
end

module DecorationInstanceRenderOptions : sig
  include Js.T

  val light : t -> ThemableDecorationInstanceRenderOptions.t option

  val dark : t -> ThemableDecorationInstanceRenderOptions.t option

  val create :
       ?light:ThemableDecorationInstanceRenderOptions.t
    -> ?dark:ThemableDecorationInstanceRenderOptions.t
    -> unit
    -> t
end

module DecorationOptions : sig
  include Js.T

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
end

module SnippetString : sig
  include Js.T

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
end

module TextEditor : sig
  include Js.T

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
end

module ConfigurationTarget : sig
  type t =
    | Global
    | Workspace
    | WorkspaceFolder

  include Js.T with type t := t
end

module WorkspaceConfiguration : sig
  include Js.T

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

  val get : t -> section:string -> Js.Any.t option

  val get_default : 'a Js.t -> t -> section:string -> defaultValue:'a -> 'a

  val has : t -> section:string -> bool

  val inspect : 'a Js.t -> t -> section:string -> 'a inspectResult option

  val update :
       t
    -> section:string
    -> value:Js.Any.t
    -> ?configurationTarget:
         [ `ConfigurationTarget of ConfigurationTarget.t | `Bool of bool ]
    -> ?overrideInLanguage:bool
    -> unit
    -> Promise.void
end

module WorkspaceEdit : sig
  include Js.T

  val size : t -> int

  val replace :
       t
    -> uri:Uri.t
    -> range:Range.t
    -> newText:string (*TODO ->?metadata:WorkspaceEditEntryMetadata.t*)
    -> unit

  val make : unit -> t
end

module StatusBarAlignment : sig
  type t =
    | Left
    | Right

  include Js.T with type t := t
end

module AccessibilityInformation : sig
  include Js.T

  val label : t -> string

  val role : t -> string option

  val create : label:string -> ?role:string -> unit -> t
end

module StatusBarItem : sig
  include Js.T

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

  val backgroundColor : t -> ThemeColor.t option

  val command : t -> command option

  val accessibilityInformation : t -> AccessibilityInformation.t option

  val set_alignment : t -> StatusBarAlignment.t -> unit

  val set_priority : t -> int -> unit

  val set_text : t -> string -> unit

  val set_tooltip : t -> string -> unit

  val set_color : t -> color -> unit

  val set_backgroundColor : t -> ThemeColor.t -> unit

  val set_command : t -> command -> unit

  val set_accessibilityInformation : t -> AccessibilityInformation.t -> unit

  val show : t -> unit

  val hide : t -> unit

  val dispose : t -> unit

  val disposable : t -> Disposable.t
end

module WorkspaceFoldersChangeEvent : sig
  include Js.T

  val added : t -> WorkspaceFolder.t list

  val removed : t -> WorkspaceFolder.t list

  val create :
    added:WorkspaceFolder.t list -> removed:WorkspaceFolder.t list -> t
end

module FormattingOptions : sig
  include Js.T

  val tabSize : t -> int

  val insertSpaces : t -> bool

  val create : tabSize:int -> insertSpaces:bool -> t
end

module Event : sig
  type 'a t =
       listener:('a -> unit)
    -> ?thisArgs:Js.Any.t
    -> ?disposables:Disposable.t list
    -> unit
    -> Disposable.t

  module Make (T : Js.T) : Js.T with type t = T.t t
end

module EventEmitter : sig
  type 'a t

  module Make (T : Js.T) : sig
    include Js.T with type t = T.t t

    val make : unit -> t

    val event : t -> T.t Event.t

    val fire : t -> T.t -> unit

    val dispose : t -> unit -> unit
  end
end

module CancellationToken : sig
  include Js.T

  val isCancellationRequested : t -> bool

  val onCancellationRequested : t -> Js.Any.t Event.t

  val create :
       isCancellationRequested:bool
    -> onCancellationRequested:Js.Any.t Event.t
    -> t
end

module CustomDocument : sig
  module type T = sig
    include Js.T

    val uri : t -> Uri.t

    val dispose : t -> unit
  end

  include T

  val create : uri:Uri.t -> dispose:(unit -> unit) -> t
end

module QuickPickItem : sig
  include Js.T

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
end

module QuickPickOptions : sig
  include Js.T

  type onDidSelectItemArgs =
    [ `QuickPickItem of QuickPickItem.t
    | `String of string
    ]

  val title : t -> string option

  val matchOnDescription : t -> bool option

  val matchOnDetail : t -> bool option

  val placeHolder : t -> string option

  val ignoreFocusOut : t -> bool option

  val canPickMany : t -> bool option

  val onDidSelectItem : t -> (onDidSelectItemArgs -> unit) option

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
  include Js.T

  val title : t -> string option

  val value : t -> string option

  val valueSelection : t -> (int * int) option

  val prompt : t -> string option

  val placeHolder : t -> string option

  val password : t -> bool option

  val ignoreFocusOut : t -> bool option

  val validateInput : t -> (string -> string ProviderResult.t) option

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
end

module MessageItem : sig
  include Js.T

  val title : t -> string

  val isCloseAffordance : t -> bool option

  val create : title:string -> ?isCloseAffordance:bool -> unit -> t
end

module Location : sig
  include Js.T

  val uri : t -> Uri.t

  val range : t -> Range.t

  val make :
       uri:Uri.t
    -> rangeOrPosition:[ `Range of Range.t | `Position of Position.t ]
    -> t
end

module ProgressLocation : sig
  type t =
    | SourceControl
    | Window
    | Notification

  include Js.T with type t := t
end

module ProgressOptions : sig
  include Js.T

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
end

module DiagnosticSeverity : sig
  type t =
    | Error
    | Hint
    | Information
    | Warning
end

module DiagnosticRelatedInformation : sig
  include Js.T

  val location : t -> Location.t

  val message : t -> string

  val make : location:Location.t -> message:string -> t
end

module DiagnosticTag : sig
  type t =
    | Unnecessary
    | Deprecated
end

module Diagnostic : sig
  include Js.T

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

  val source : t -> string option

  val code : t -> code option

  val relatedInformation : t -> DiagnosticRelatedInformation.t list option

  val tags : t -> DiagnosticTag.t list option

  val make : ?severity:DiagnosticSeverity.t -> message:string -> Range.t -> t
end

module TextDocumentShowOptions : sig
  include Js.T

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
end

module TerminalOptions : sig
  include Js.T

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
end

module TerminalDimensions : sig
  include Js.T

  val columns : t -> int

  val rows : t -> int

  val create : columns:int -> rows:int -> t
end

module Pseudoterminal : sig
  include Js.T

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
end

module ExtensionTerminalOptions : sig
  include Js.T

  val name : t -> string

  val pty : t -> Pseudoterminal.t

  val create : name:string -> pty:Pseudoterminal.t -> t
end

module Extension : sig
  include Js.T
end

module Extensions : sig
  val getExtension : string -> Extension.t or_undefined
end

module TerminalExitStatus : sig
  include Js.T

  val code : t -> int

  val create : code:int -> t
end

module Terminal : sig
  include Js.T

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
end

module OutputChannel : sig
  include Js.T

  val name : t -> string

  val append : t -> value:string -> unit

  val appendLine : t -> value:string -> unit

  val clear : t -> unit

  val show : t -> ?preserveFocus:bool -> unit -> unit

  val hide : t -> unit

  val dispose : t -> unit

  val disposable : t -> Disposable.t
end

module Memento : sig
  include Js.T

  val get : t -> key:string -> Js.Any.t option

  val get_default : 'a Js.t -> t -> key:string -> defaultValue:'a -> 'a

  val update : t -> key:string -> value:Js.Any.t -> Promise.void
end

module EnvironmentVariableMutatorType : sig
  type t =
    | Replace
    | Append
    | Prepend

  include Js.T with type t := t
end

module EnvironmentVariableMutator : sig
  include Js.T

  val type_ : t -> EnvironmentVariableMutatorType.t

  val value : t -> string
end

module EnvironmentVariableCollection : sig
  include Js.T

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
end

module ExtensionMode : sig
  type t =
    | Production
    | Development
    | Test

  include Js.T with type t := t
end

module SecretStorageChangeEvent : sig
  include Js.T

  val key : t -> string
end

module SecretStorage : sig
  include Js.T

  val get : t -> key:string -> string option Promise.t

  val store : t -> key:string -> value:string -> Promise.void

  val delete : t -> key:string -> Promise.void

  val onDidChange : t -> SecretStorageChangeEvent.t Event.t
end

module ExtensionContext : sig
  include Js.T

  val subscriptions : t -> Disposable.t list

  val workspaceState : t -> Memento.t

  val globalState : t -> Memento.t

  val secrets : t -> SecretStorage.t

  val extensionUri : t -> Uri.t

  val extensionPath : t -> string

  val environmentVariableCollection : t -> EnvironmentVariableCollection.t

  val asAbsolutePath : t -> relativePath:string -> string

  val storageUri : t -> Uri.t option

  val globalStorageUri : t -> Uri.t

  val logUri : t -> Uri.t

  val extensionMode : t -> ExtensionMode.t

  val subscribe : t -> disposable:Disposable.t -> unit
end

module ShellQuotingOptions : sig
  include Js.T

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
end

module ShellExecutionOptions : sig
  include Js.T

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
end

module ShellQuoting : sig
  type t =
    | Escape
    | Strong
    | Weak

  include Js.T with type t := t
end

module ShellQuotedString : sig
  include Js.T

  val value : t -> string

  val quoting : t -> ShellQuoting.t

  val create : value:string -> quoting:ShellQuoting.t -> t
end

module ShellExecution : sig
  include Js.T

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
end

module ProcessExecutionOptions : sig
  include Js.T

  val cwd : t -> string option

  val env : t -> string Interop.Dict.t option

  val create : ?cwd:string -> ?env:string Interop.Dict.t -> unit -> t
end

module ProcessExecution : sig
  include Js.T

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
end

module TaskDefinition : sig
  include Js.T

  val type_ : t -> string

  val get_attribute : t -> string -> Js.Any.t

  val set_attribute : t -> string -> Js.Any.t -> unit

  val create : type_:string -> ?attributes:(string * Js.Any.t) list -> unit -> t
end

module CustomExecution : sig
  include Js.T

  val make :
       callback:
         (resolvedDefinition:TaskDefinition.t -> Pseudoterminal.t Promise.t)
    -> t
end

module RelativePattern : sig
  include Js.T

  val base : t -> string

  val pattern : t -> string

  val make :
       base:
         [ `String of string
         | `Uri of Uri.t
         | `WorkspaceFolder of WorkspaceFolder.t
         ]
    -> pattern:string
    -> t
end

module GlobPattern : sig
  type t =
    [ `String of string
    | `RelativePattern of RelativePattern.t
    ]

  include Js.T with type t := t
end

module DocumentFilter : sig
  include Js.T

  val language : t -> string option

  val scheme : t -> string option

  val pattern : t -> GlobPattern.t option

  val create :
    ?language:string -> ?scheme:string -> ?pattern:GlobPattern.t -> unit -> t
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

  include Js.T with type t := t
end

module DocumentFormattingEditProvider : sig
  include Js.T

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
end

module Hover : sig
  include Js.T

  val contents : t -> MarkdownString.t

  val range : t -> Range.t option

  val make :
       contents:
         [ `MarkdownString of MarkdownString.t
         | `MarkdownStringArray of MarkdownString.t list
         ]
    -> t
end

module HoverProvider : sig
  include Js.T

  val provideHover :
       t
    -> document:TextDocument.t
    -> position:Position.t
    -> token:CancellationToken.t
    -> Hover.t ProviderResult.t

  val create :
       provideHover:
         (   document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> Hover.t ProviderResult.t)
    -> t
end

module TaskGroup : sig
  include Js.T

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

  include Js.T with type t := t
end

module RunOptions : sig
  include Js.T

  val reevaluateOnRerun : t -> bool option

  val create : ?reevaluateOnRerun:bool -> unit -> t
end

module TaskRevealKind : sig
  type t =
    | Always
    | Silent
    | Never

  include Js.T with type t := t
end

module TaskPanelKind : sig
  type t =
    | Shared
    | Dedicated
    | New

  include Js.T with type t := t
end

module TaskPresentationOptions : sig
  include Js.T

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
end

module Task : sig
  include Js.T

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
end

module TaskProvider : sig
  type 'a t

  module Make (T : Js.T) : sig
    type nonrec t = T.t t

    val provideTasks :
      t -> token:CancellationToken.t -> T.t list ProviderResult.t

    val resolveTask :
      t -> task:T.t -> token:CancellationToken.t -> T.t ProviderResult.t

    val create :
         provideTasks:(token:CancellationToken.t -> T.t list ProviderResult.t)
      -> resolveTask:
           (task:T.t -> token:CancellationToken.t -> T.t ProviderResult.t)
      -> t
  end

  module Default : module type of Make (Task)
end

module ConfigurationScope : sig
  type t =
    [ `Uri of Uri.t
    | `TextDocument of TextDocument.t
    | `WorkspaceFolder of WorkspaceFolder.t
    ]

  include Js.T with type t := t
end

module MessageOptions : sig
  include Js.T

  val modal : t -> bool option

  val create : ?modal:bool -> unit -> t
end

module Progress : sig
  include Js.T

  type value =
    { message : string option
    ; increment : int option
    }

  val report : t -> value:value -> unit
end

module TextDocumentContentChangeEvent : sig
  include Js.T

  val range : t -> Range.t

  val rangeLength : t -> int

  val rangeOffset : t -> int

  val text : t -> string
end

module TextDocumentChangeEvent : sig
  include Js.T

  val contentChanges : t -> TextDocumentContentChangeEvent.t list

  val document : t -> TextDocument.t
end

module TextDocumentContentProvider : sig
  include Js.T

  val onDidChange : t -> Uri.t Event.t option

  val provideTextDocumentContent :
    t -> uri:Uri.t -> token:CancellationToken.t -> string ProviderResult.t

  val create :
       ?onDidChange:Uri.t Event.t
    -> provideTextDocumentContent:
         (uri:Uri.t -> token:CancellationToken.t -> string ProviderResult.t)
    -> unit
    -> t
end

module FileSystemWatcher : sig
  include Js.T

  val onDidChange : t -> Uri.t Event.t
end

module Workspace : sig
  val workspaceFolders : unit -> WorkspaceFolder.t list

  val name : unit -> string option

  val createFileSystemWatcher :
       GlobPattern.t
    -> ?ignoreCreateEvents:bool
    -> ?ignoreChangeEvents:bool
    -> ?ignoreDeleteEvents:bool
    -> unit
    -> FileSystemWatcher.t

  val workspaceFile : unit -> Uri.t option

  val rootPath : unit -> string or_undefined

  val onDidChangeWorkspaceFolders : WorkspaceFolder.t Event.t

  val onDidChangeTextDocument : TextDocumentChangeEvent.t Event.t

  val asRelativePath :
       pathOrUri:([ `String of string | `Uri of Uri.t ][@js.union])
    -> ?includeWorkspaceFolder:bool
    -> unit
    -> string

  val getWorkspaceFolder : uri:Uri.t -> WorkspaceFolder.t option

  val findFiles :
       includes:GlobPattern.t
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

  val openTextDocument :
       [ `Uri of Uri.t
       | `Filename of string
       | `Interactive of textDocumentOptions option
       ]
    -> TextDocument.t Promise.t

  val onDidOpenTextDocument : TextDocument.t Event.t

  val onDidCloseTextDocument : TextDocument.t Event.t

  val onDidSaveTextDocument : TextDocument.t Event.t

  val applyEdit : edit:WorkspaceEdit.t -> bool Promise.t

  val getConfiguration :
       ?section:string
    -> ?scope:ConfigurationScope.t
    -> unit
    -> WorkspaceConfiguration.t

  val registerTextDocumentContentProvider :
    scheme:string -> provider:TextDocumentContentProvider.t -> Disposable.t

  type workspaceFolderToAdd =
    { name : string
    ; uri : Uri.t
    }

  val updateWorkspaceFolders :
       start:int
    -> deleteCount:int or_undefined
    -> workspaceFoldersToAdd:(workspaceFolderToAdd list[@js.variadic])
    -> bool
end

module TreeItemCollapsibleState : sig
  type t =
    | None
    | Collapsed
    | Expanded

  include Js.T with type t := t
end

module TreeItemLabel : sig
  include Js.T

  val create : label:string -> ?highlights:(int * int) list -> unit -> t

  val label : t -> string

  val highlights : t -> (int * int) list option
end

module ThemeIcon : sig
  include Js.T

  val make : id:string -> ?color:ThemeColor.t -> unit -> t

  val file : t

  val folder : t

  val id : t -> string

  val color : t -> ThemeColor.t option
end

module TreeItem : sig
  include Js.T

  type label =
    [ `String of string
    | `TreeItemLabel of TreeItemLabel.t
    ]

  module LightDarkIcon : sig
    type t =
      { light : [ `String of string | `Uri of Uri.t ]
      ; dark : [ `String of string | `Uri of Uri.t ]
      }

    include Js.T with type t := t
  end

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

  val make_label :
    label:label -> ?collapsibleState:TreeItemCollapsibleState.t -> unit -> t

  val make_resource :
       resourceUri:Uri.t
    -> ?collapsibleState:TreeItemCollapsibleState.t
    -> unit
    -> t

  val label : t -> label option

  val set_label : t -> label -> unit

  val id : t -> string option

  val set_id : t -> string -> unit

  val iconPath : t -> iconPath option

  val set_iconPath : t -> iconPath -> unit

  val description : t -> description option

  val set_description : t -> description -> unit

  val resourceUri : t -> Uri.t option

  val set_resourceUri : t -> Uri.t -> unit

  val tooltip : t -> tooltip option

  val set_tooltip : t -> tooltip -> unit

  val collapsibleState : t -> TreeItemCollapsibleState.t option

  val set_collapsibleState : t -> TreeItemCollapsibleState.t -> unit

  val command : t -> Command.t option

  val set_command : t -> Command.t -> unit

  val contextValue : t -> string option

  val set_contextValue : t -> string -> unit

  val accessibilityInformation : t -> AccessibilityInformation.t option

  val set_accessibilityInformation : t -> AccessibilityInformation.t -> unit
end

module TreeDataProvider : sig
  type 'a t

  module Make (T : Js.T) : sig
    type nonrec t = T.t t

    val onDidChangeTreeData : t -> T.t option Event.t option

    val getTreeItem :
         t
      -> element:T.t
      -> [ `Value of TreeItem.t | `Promise of TreeItem.t Promise.t ]

    val getChildren : t -> ?element:T.t -> unit -> T.t list ProviderResult.t

    val getParent : t -> (element:T.t -> T.t ProviderResult.t) option

    val resolveTreeItem :
         t
      -> (   item:TreeItem.t
          -> element:T.t
          -> token:CancellationToken.t
          -> TreeItem.t ProviderResult.t)
         option

    val create :
         ?onDidChangeTreeData:T.t option Event.t
      -> getTreeItem:
           (   element:T.t
            -> [ `Value of TreeItem.t | `Promise of TreeItem.t Promise.t ])
      -> getChildren:(?element:T.t -> unit -> T.t list ProviderResult.t)
      -> ?getParent:(element:T.t -> T.t ProviderResult.t)
      -> ?resolveTreeItem:
           (   item:TreeItem.t
            -> element:T.t
            -> token:CancellationToken.t
            -> TreeItem.t ProviderResult.t)
      -> unit
      -> t
  end
end

module TreeViewOptions : sig
  type 'a t

  module Make (T : Js.T) : sig
    type nonrec t = T.t t

    val treeDataProvider : t -> T.t TreeDataProvider.t

    val showCollapseAll : t -> bool option

    val canSelectMany : t -> bool option
  end
end

module TreeViewExpansionEvent : sig
  type 'a t

  module Make (T : Js.T) : sig
    type nonrec t = T.t t

    val element : t -> T.t

    val create : element:T.t -> t
  end
end

module TreeViewSelectionChangeEvent : sig
  type 'a t

  module Make (T : Js.T) : sig
    type nonrec t = T.t t

    val selection : t -> T.t list

    val create : selection:T.t list -> t
  end
end

module TreeViewVisibilityChangeEvent : sig
  include Js.T

  val visible : t -> bool

  val create : visible:bool -> t
end

module TreeView : sig
  type 'a t = private Disposable.t

  module Make (T : Js.T) : sig
    type nonrec t = T.t t

    val onDidExpandElement : t -> T.t TreeViewExpansionEvent.t Event.t

    val onDidCollapseElement : t -> T.t TreeViewExpansionEvent.t Event.t

    val selection : t -> T.t list

    val onDidChangeSelection : t -> T.t TreeViewSelectionChangeEvent.t Event.t

    val visible : t -> bool

    val onDidChangeVisibility : t -> TreeViewVisibilityChangeEvent.t Event.t

    val message : t -> string option

    val title : t -> string option

    val description : t -> string option

    val reveal :
         t
      -> element:T.t
      -> ?select:bool
      -> ?focus:bool
      -> ?expand:[ `Bool of bool | `Int of int ]
      -> unit
      -> Promise.void
      [@@js.call]
  end
end

module WebviewPanelOptions : sig
  include Js.T

  val enableFindWidget : t -> bool option

  val retainContextWhenHidden : t -> bool option
end

module WebviewPortMapping : sig
  include Js.T

  val extensionHostPort : t -> int

  val webviewPort : t -> int
end

module WebviewOptions : sig
  include Js.T

  val enableCommandUris : t -> bool option

  val enableScripts : t -> bool option

  val localResourceRoots : t -> Uri.t list option

  val portMapping : t -> WebviewPortMapping.t list option

  val create :
       ?enableCommandUris:bool
    -> ?enableScripts:bool
    -> ?localResourceRoots:Uri.t list
    -> ?portMapping:WebviewPortMapping.t list
    -> unit
    -> t
end

module WebView : sig
  include Js.T

  val onDidReceiveMessage : t -> Js.Any.t Event.t

  val cspSource : t -> string

  val html : t -> string

  val set_html : t -> string -> unit

  val options : t -> WebviewOptions.t

  val set_options : t -> WebviewOptions.t -> unit

  val asWebviewUri : t -> localResource:Uri.t -> Uri.t

  val postMessage : t -> Js.Any.t -> bool Promise.t

  val create :
       onDidReceiveMessage:Js.Any.t Event.t
    -> cspSource:string
    -> html:string
    -> options:WebviewOptions.t
    -> close:(unit -> unit)
    -> asWebviewUri:(Uri.t -> Uri.t)
    -> postMessage:(Js.Any.t -> bool Promise.t)
    -> t
end

module WebviewPanel : sig
  include Js.T

  module WebviewPanelOnDidChangeViewStateEvent : sig
    type webviewPanel := t

    include Js.T

    val webviewPanel : t -> webviewPanel
  end

  module LightDarkIcon : sig
    type t =
      { light : Uri.t
      ; dark : Uri.t
      }

    include Js.T with type t := t
  end

  val onDidChangeViewState :
    t -> WebviewPanelOnDidChangeViewStateEvent.t Event.t

  val onDidDispose : t -> unit Event.t

  val active : t -> bool

  type iconPath =
    [ `Uri of Uri.t
    | `LightDark of LightDarkIcon.t
    ]

  val options : t -> WebviewPanelOptions.t

  val title : t -> string

  val viewColumn : t -> ViewColumn.t option

  val viewType : t -> string

  val visible : t -> bool

  val webview : t -> WebView.t

  val set_webview : t -> WebView.t -> unit

  val dispose : t -> Js.Any.t

  val reveal :
    t -> ?preserveFocus:bool -> ?viewColumn:ViewColumn.t -> unit -> unit

  val create :
       onDidChangeViewState:WebviewPanelOnDidChangeViewStateEvent.t Event.t
    -> onDidDispose:Js.Unit.t Event.t
    -> active:bool
    -> options:WebviewPanelOptions.t
    -> title:string
    -> viewColumn:ViewColumn.t
    -> viewType:string
    -> visible:bool
    -> webview:WebView.t
    -> dispose:Js.Any.t
    -> reveal:(?preserveFocus:bool -> ?viewColumn:ViewColumn.t -> unit -> unit)
    -> t
end

module CustomTextEditorProvider : sig
  include Js.T

  module ResolvedEditor : sig
    type t =
      [ `Promise of Promise.void
      | `Unit of Js.Unit.t
      ]

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  val resolveCustomTextEditor :
       t
    -> document:TextDocument.t
    -> webviewPanel:WebviewPanel.t
    -> token:CancellationToken.t
    -> ResolvedEditor.t

  val create :
       resolveCustomTextEditor:
         (   document:TextDocument.t
          -> webviewPanel:WebviewPanel.t
          -> token:CancellationToken.t
          -> ResolvedEditor.t)
    -> t
end

module CustomDocumentOpenContext : sig
  include Js.T

  val backupId : t -> string or_undefined
end

module CustomReadonlyEditorProvider : sig
  type 'a t

  module Make (T : CustomDocument.T) : sig
    type nonrec t = T.t t

    val openCustomDocument :
         t
      -> uri:Uri.t
      -> openContext:CustomDocumentOpenContext.t
      -> token:CancellationToken.t
      -> T.t Promise.t

    val resolveCustomEditor :
         t
      -> document:T.t
      -> webviewPanel:WebviewPanel.t
      -> token:CancellationToken.t
      -> unit Promise.t

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
  end
end

module RegisterCustomEditorProviderOptions : sig
  include Js.T

  val supportsMultipleEditorsPerDocument : t -> bool or_undefined

  val create : ?supportsMultipleEditorsPerDocument:bool -> unit -> t
end

module Window : sig
  val activeTextEditor : unit -> TextEditor.t option

  val visibleTextEditors : unit -> TextEditor.t list

  val onDidChangeActiveTextEditor : unit -> TextEditor.t Event.t

  val onDidChangeVisibleTextEditors : unit -> TextEditor.t list Event.t

  val terminals : unit -> Terminal.t List.t

  val activeTerminal : unit -> Terminal.t option

  val onDidChangeActiveTerminal : unit -> Terminal.t option Event.t

  val onDidOpenTerminal : unit -> Terminal.t Event.t

  val onDidCloseTerminal : unit -> Terminal.t Event.t

  val showTextDocument :
       document:[ `TextDocument of TextDocument.t | `Uri of Uri.t ]
    -> ?column:ViewColumn.t
    -> ?preserveFocus:bool
    -> unit
    -> TextEditor.t Promise.t

  val showInformationMessage :
       message:string
    -> ?options:MessageOptions.t
    -> ?choices:(string * 'a) list
    -> unit
    -> 'a option Promise.t

  val showWarningMessage :
       message:string
    -> ?options:MessageOptions.t
    -> ?choices:(string * 'a) list
    -> unit
    -> 'a option Promise.t

  val showErrorMessage :
       message:string
    -> ?options:MessageOptions.t
    -> ?choices:(string * 'a) list
    -> unit
    -> 'a option Promise.t

  val showQuickPickItems :
       choices:(QuickPickItem.t * 'a) list
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> 'a option Promise.t

  val showQuickPick :
       items:string list
    -> ?options:QuickPickOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string option Promise.t

  val showInputBox :
       ?options:InputBoxOptions.t
    -> ?token:CancellationToken.t
    -> unit
    -> string option Promise.t

  val createOutputChannel : name:string -> OutputChannel.t

  val setStatusBarMessage :
    text:string -> ?hide:[ `AfterTimeout of int ] -> unit -> Disposable.t

  val withProgress :
       'a Js.t
    -> options:ProgressOptions.t
    -> task:(progress:Progress.t -> token:CancellationToken.t -> 'a Promise.t)
    -> 'a Promise.t

  val createStatusBarItem :
    ?alignment:StatusBarAlignment.t -> ?priority:int -> unit -> StatusBarItem.t

  val createTerminal :
       ?name:string
    -> ?shellPath:string
    -> ?shellArgs:[ `String of string | `Strings of string list ]
    -> unit
    -> Terminal.t

  val createTerminalFromOptions :
       options:
         [ `TerminalOptions of TerminalOptions.t
         | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
         ]
    -> Terminal.t

  val registerTreeDataProvider :
       'a Js.t
    -> viewId:string
    -> treeDataProvider:'a TreeDataProvider.t
    -> Disposable.t

  val createTreeView :
    'a Js.t -> viewId:string -> options:'a TreeViewOptions.t -> 'a TreeView.t

  val createWebviewPanel :
       viewType:string
    -> title:string
    -> showOptions:ViewColumn.t
    -> WebviewPanel.t

  val registerCustomTextEditorProvider :
       viewType:string
    -> provider:CustomTextEditorProvider.t
    -> ?options:RegisterCustomEditorProviderOptions.t
    -> unit
    -> Disposable.t

  val registerCustomReadonlyEditorProvider :
       (module CustomDocument.T with type t = 'a)
    -> viewType:string
    -> provider:'a CustomReadonlyEditorProvider.t
    -> ?options:RegisterCustomEditorProviderOptions.t
    -> unit
    -> Disposable.t
end

module Commands : sig
  val registerCommand :
    command:string -> callback:(args:Js.Any.t list -> unit) -> Disposable.t

  val registerTextEditorCommand :
       command:string
    -> callback:
         (   textEditor:TextEditor.t
          -> edit:TextEditorEdit.t
          -> args:Js.Any.t list
          -> unit)
    -> Disposable.t

  val executeCommand :
    command:string -> args:Js.Any.t list -> Js.Any.t option Promise.t

  val getCommands : ?filterInternal:bool -> unit -> string list Promise.t
end

module Languages : sig
  val registerDocumentFormattingEditProvider :
       selector:DocumentSelector.t
    -> provider:DocumentFormattingEditProvider.t
    -> Disposable.t

  val registerHoverProvider :
    selector:DocumentSelector.t -> provider:HoverProvider.t -> Disposable.t

  val getDiagnostics : Uri.t -> Diagnostic.t list

  val getDiagnostics_all : unit -> (Uri.t * Diagnostic.t list) list
end

module Tasks : sig
  val registerTaskProvider :
    type_:string -> provider:Task.t TaskProvider.t -> Disposable.t
end

module Env : sig
  val shell : unit -> string
end
