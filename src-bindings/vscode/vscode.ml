open Interop

let or_undefined_of_js convert value =
  if Ojs.type_of value = "undefined" then None else Some (convert value)
;;

include
  [%js:
    val version : string [@@js.global "@vscode.version"]
    val vscode_module : Ojs.t [@@js.global "@vscode"]]

let binding_has_member value name =
  let kind = Ojs.type_of value in
  (kind = "object" || kind = "function")
  && (not (Ojs.is_null value))
  && Ojs.bool_of_js
       (Ojs.call
          (Ojs.get_prop_ascii Ojs.global "Reflect")
          "has"
          [| value; Ojs.string_to_js name |])
;;

let binding_is_array value =
  Ojs.bool_of_js (Ojs.call (Ojs.get_prop_ascii Ojs.global "Array") "isArray" [| value |])
;;

let binding_is_thenable value =
  let kind = Ojs.type_of value in
  (kind = "object" || kind = "function")
  && (not (Ojs.is_null value))
  && Ojs.type_of (Ojs.get_prop_ascii value "then") = "function"
;;

let binding_constructor value names =
  let kind = Ojs.type_of value in
  if (kind <> "object" && kind <> "function") || Ojs.is_null value
  then None
  else (
    let prototypes =
      List.map
        (fun name ->
           name, Ojs.get_prop_ascii (Ojs.get_prop_ascii vscode_module name) "prototype")
        names
    in
    let parent obj =
      Ojs.call (Ojs.get_prop_ascii Ojs.global "Object") "getPrototypeOf" [| obj |]
    in
    let rec find obj =
      if Ojs.is_null obj
      then None
      else (
        match List.find_opt (fun (_, prototype) -> obj == prototype) prototypes with
        | Some (name, _) -> Some name
        | None -> find (parent obj))
    in
    find (parent value))
;;

let binding_arguments fixed required rest =
  let rest = Ojs.array_of_js Ojs.t_of_js rest in
  let rec length n =
    if n > required && Ojs.type_of fixed.(n - 1) = "undefined" then length (n - 1) else n
  in
  let fixed =
    if Array.length rest = 0
    then Array.sub fixed 0 (length (Array.length fixed))
    else fixed
  in
  Array.append fixed rest
;;

module Disposable = struct
  include Class.Make ()

  include
    [%js:
      val from : (t list[@js.variadic]) -> t [@@js.global "@vscode.Disposable.from"]
      val make : dispose:(unit -> unit) -> t [@@js.new "@vscode.Disposable"]
      val dispose : t -> unit [@@js.call]]
end

module Command = struct
  include Interface.Make ()

  include
    [%js:
      val title : t -> string [@@js.get "title"]
      val command : t -> string [@@js.get "command"]
      val tooltip : t -> string or_undefined [@@js.get "tooltip"]
      val arguments : t -> Ojs.t list or_undefined [@@js.get "arguments"]]

  include
    [%js:
      val set_title : t -> string -> unit [@@js.set "title"]
      val set_command : t -> string -> unit [@@js.set "command"]
      val set_tooltip : t -> string or_undefined -> unit [@@js.set "tooltip"]
      val set_arguments : t -> Ojs.t list or_undefined -> unit [@@js.set "arguments"]]

  let create ~title ~command ?tooltip ?arguments () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "title" (Ojs.string_to_js title);
    Ojs.set_prop_ascii obj "command" (Ojs.string_to_js command);
    iter_set obj "tooltip" Ojs.string_to_js tooltip;
    iter_set obj "arguments" (Ojs.list_to_js Ojs.t_to_js) arguments;
    t_of_js obj
  ;;
end

module Position = struct
  include Class.Make ()

  type translate_with_change =
    { lineDelta : int or_undefined
    ; characterDelta : int or_undefined
    }

  let translate_with_change_to_js (value : translate_with_change) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "lineDelta" Ojs.int_to_js value.lineDelta;
    iter_set js_val "characterDelta" Ojs.int_to_js value.characterDelta;
    js_val
  ;;

  let translate_with_change_of_js js_val : translate_with_change =
    { lineDelta =
        (or_undefined_of_js Ojs.int_of_js) (Ojs.get_prop_ascii js_val "lineDelta")
    ; characterDelta =
        (or_undefined_of_js Ojs.int_of_js) (Ojs.get_prop_ascii js_val "characterDelta")
    }
  ;;

  type with_change =
    { line : int or_undefined
    ; character : int or_undefined
    }

  let with_change_to_js (value : with_change) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "line" Ojs.int_to_js value.line;
    iter_set js_val "character" Ojs.int_to_js value.character;
    js_val
  ;;

  let with_change_of_js js_val : with_change =
    { line = (or_undefined_of_js Ojs.int_of_js) (Ojs.get_prop_ascii js_val "line")
    ; character =
        (or_undefined_of_js Ojs.int_of_js) (Ojs.get_prop_ascii js_val "character")
    }
  ;;

  include
    [%js:
      val line : t -> int [@@js.get "line"]
      val character : t -> int [@@js.get "character"]
      val make : line:int -> character:int -> t [@@js.new "@vscode.Position"]
      val isBefore : t -> other:t -> bool [@@js.call]
      val isBeforeOrEqual : t -> other:t -> bool [@@js.call]
      val isAfter : t -> other:t -> bool [@@js.call]
      val isAfterOrEqual : t -> other:t -> bool [@@js.call]
      val isEqual : t -> other:t -> bool [@@js.call]
      val compareTo : t -> other:t -> int [@@js.call]
      val translate : t -> ?lineDelta:int -> ?characterDelta:int -> unit -> t [@@js.call]
      val with_ : t -> ?line:int -> ?character:int -> unit -> t [@@js.call]

      val translateWithChange : t -> change:translate_with_change -> t
      [@@js.call "translate"]

      val withChange : t -> change:with_change -> t [@@js.call "with"]]
end

module Range = struct
  include Class.Make ()

  type with_change =
    { start : Position.t or_undefined
    ; end_ : Position.t or_undefined
    }

  let with_change_to_js (value : with_change) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "start" Position.t_to_js value.start;
    iter_set js_val "end" Position.t_to_js value.end_;
    js_val
  ;;

  let with_change_of_js js_val : with_change =
    { start = (or_undefined_of_js Position.t_of_js) (Ojs.get_prop_ascii js_val "start")
    ; end_ = (or_undefined_of_js Position.t_of_js) (Ojs.get_prop_ascii js_val "end")
    }
  ;;

  include
    [%js:
      val start : t -> Position.t [@@js.get "start"]
      val end_ : t -> Position.t [@@js.get "end"]

      val makePositions : start:Position.t -> end_:Position.t -> t
      [@@js.new "@vscode.Range"]

      val makeCoordinates
        :  startLine:int
        -> startCharacter:int
        -> endLine:int
        -> endCharacter:int
        -> t
      [@@js.new "@vscode.Range"]

      val isEmpty : t -> bool [@@js.get "isEmpty"]
      val isSingleLine : t -> bool [@@js.get "isSingleLine"]

      val contains
        :  t
        -> positionOrRange:([ `Position of Position.t | `Range of t ][@js.union])
        -> bool
      [@@js.call]

      val isEqual : t -> other:t -> bool [@@js.call]
      val intersection : t -> range:t -> t or_undefined [@@js.call]
      val union : t -> other:t -> t [@@js.call]
      val with_ : t -> ?start:Position.t -> ?end_:Position.t -> unit -> t [@@js.call]
      val set_isEmpty : t -> bool -> unit [@@js.set "isEmpty"]
      val set_isSingleLine : t -> bool -> unit [@@js.set "isSingleLine"]
      val withChange : t -> change:with_change -> t [@@js.call "with"]]
end

module TextLine = struct
  include Interface.Make ()

  include
    [%js:
      val lineNumber : t -> int [@@js.get "lineNumber"]
      val text : t -> string [@@js.get "text"]
      val range : t -> Range.t [@@js.get "range"]
      val rangeIncludingLineBreak : t -> Range.t [@@js.get "rangeIncludingLineBreak"]

      val firstNonWhitespaceCharacterIndex : t -> int
      [@@js.get "firstNonWhitespaceCharacterIndex"]

      val isEmptyOrWhitespace : t -> bool [@@js.get "isEmptyOrWhitespace"]]

  let create
        ~lineNumber
        ~text
        ~range
        ~rangeIncludingLineBreak
        ~firstNonWhitespaceCharacterIndex
        ~isEmptyOrWhitespace
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "lineNumber" (Ojs.int_to_js lineNumber);
    Ojs.set_prop_ascii obj "text" (Ojs.string_to_js text);
    Ojs.set_prop_ascii obj "range" (Range.t_to_js range);
    Ojs.set_prop_ascii
      obj
      "rangeIncludingLineBreak"
      (Range.t_to_js rangeIncludingLineBreak);
    Ojs.set_prop_ascii
      obj
      "firstNonWhitespaceCharacterIndex"
      (Ojs.int_to_js firstNonWhitespaceCharacterIndex);
    Ojs.set_prop_ascii obj "isEmptyOrWhitespace" (Ojs.bool_to_js isEmptyOrWhitespace);
    t_of_js obj
  ;;
end

module EndOfLine = struct
  type t =
    | LF [@js 1]
    | CRLF [@js 2]
  [@@js.enum] [@@js]
end

module TextEdit = struct
  include Class.Make ()

  include
    [%js:
      val replace : range:Range.t -> newText:string -> t
      [@@js.global "@vscode.TextEdit.replace"]

      val insert : position:Position.t -> newText:string -> t
      [@@js.global "@vscode.TextEdit.insert"]

      val delete : Range.t -> t [@@js.global "@vscode.TextEdit.delete"]
      val setEndOfLine : EndOfLine.t -> t [@@js.global "@vscode.TextEdit.setEndOfLine"]
      val range : t -> Range.t [@@js.get "range"]
      val newText : t -> string [@@js.get "newText"]
      val newEol : t -> EndOfLine.t or_undefined [@@js.get "newEol"]
      val make : range:Range.t -> newText:string -> t [@@js.new "@vscode.TextEdit"]
      val set_range : t -> Range.t -> unit [@@js.set "range"]
      val set_newText : t -> string -> unit [@@js.set "newText"]
      val set_newEol : t -> EndOfLine.t or_undefined -> unit [@@js.set "newEol"]]
end

module Uri = struct
  include Class.Make ()

  type from_components =
    { scheme : string
    ; authority : string or_undefined
    ; path : string or_undefined
    ; query : string or_undefined
    ; fragment : string or_undefined
    }

  let from_components_to_js (value : from_components) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "scheme" (Ojs.string_to_js value.scheme);
    iter_set js_val "authority" Ojs.string_to_js value.authority;
    iter_set js_val "path" Ojs.string_to_js value.path;
    iter_set js_val "query" Ojs.string_to_js value.query;
    iter_set js_val "fragment" Ojs.string_to_js value.fragment;
    js_val
  ;;

  let from_components_of_js js_val : from_components =
    { scheme = Ojs.string_of_js (Ojs.get_prop_ascii js_val "scheme")
    ; authority =
        (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "authority")
    ; path = (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "path")
    ; query = (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "query")
    ; fragment =
        (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "fragment")
    }
  ;;

  type with_components_change =
    { scheme : string or_undefined
    ; authority : string or_undefined
    ; path : string or_undefined
    ; query : string or_undefined
    ; fragment : string or_undefined
    }

  let with_components_change_to_js (value : with_components_change) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "scheme" Ojs.string_to_js value.scheme;
    iter_set js_val "authority" Ojs.string_to_js value.authority;
    iter_set js_val "path" Ojs.string_to_js value.path;
    iter_set js_val "query" Ojs.string_to_js value.query;
    iter_set js_val "fragment" Ojs.string_to_js value.fragment;
    js_val
  ;;

  let with_components_change_of_js js_val : with_components_change =
    { scheme = (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "scheme")
    ; authority =
        (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "authority")
    ; path = (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "path")
    ; query = (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "query")
    ; fragment =
        (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "fragment")
    }
  ;;

  module Scheme = struct
    type t =
      [ `File
      | `Untitled (** URI scheme used by vscode for new draft (not-saved) files *)
      ]

    let to_string = function
      | `File -> "file"
      | `Untitled -> "untitled"
    ;;
  end

  include
    [%js:
      val parse : string -> ?strict:bool -> unit -> t [@@js.global "@vscode.Uri.parse"]
      val file : string -> t [@@js.global "@vscode.Uri.file"]

      val joinPath : t -> pathSegments:(string list[@js.variadic]) -> t
      [@@js.global "@vscode.Uri.joinPath"]

      val scheme : t -> string [@@js.get "scheme"]
      val authority : t -> string [@@js.get "authority"]
      val path : t -> string [@@js.get "path"]
      val query : t -> string [@@js.get "query"]
      val fragment : t -> string [@@js.get "fragment"]
      val fsPath : t -> string [@@js.get "fsPath"]
      val with_ : t -> Ojs.t -> t [@@js.call]
      val toString : t -> ?skipEncoding:bool -> unit -> string [@@js.call]
      val toJson : t -> Jsonoo.t [@@js.call "toJSON"]]

  let with_ this ?scheme ?authority ?path ?query ?fragment () =
    let change = Ojs.obj [||] in
    iter_set change "scheme" [%js.of: string] (Option.map Scheme.to_string scheme);
    iter_set change "authority" [%js.of: string] authority;
    iter_set change "path" [%js.of: string] path;
    iter_set change "query" [%js.of: string] query;
    iter_set change "fragment" [%js.of: string] fragment;
    with_ this change
  ;;

  let equal a b = String.equal (toString a ()) (toString b ())

  include
    [%js:
      val from : components:from_components -> t [@@js.global "@vscode.Uri.from"]
      val withComponents : t -> change:with_components_change -> t [@@js.call "with"]]
end

module LightDarkIcon = struct
  type t =
    { light : Uri.t
    ; dark : Uri.t
    }
  [@@js]
end

module ThemeColor = struct
  include Class.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val make : id:string -> t [@@js.new "@vscode.ThemeColor"]]
end

module ThemeIcon = struct
  include Class.Make ()

  include
    [%js:
      val make : id:string -> ?color:ThemeColor.t -> unit -> t
      [@@js.new "@vscode.ThemeIcon"]

      val file : t [@@js.global "@vscode.ThemeIcon.File"]
      val folder : t [@@js.global "@vscode.ThemeIcon.Folder"]
      val id : t -> string [@@js.get "id"]
      val color : t -> ThemeColor.t or_undefined [@@js.get "color"]]
end

module IconPath = struct
  type t =
    ([ `Uri of Uri.t
     | `LightDark of LightDarkIcon.t
     | `ThemeIcon of ThemeIcon.t
     ]
    [@js.union])
  [@@js]

  let t_of_js js_val =
    if binding_has_member js_val "path"
    then `Uri ([%js.to: Uri.t] js_val)
    else if binding_has_member js_val "id"
    then `ThemeIcon ([%js.to: ThemeIcon.t] js_val)
    else if binding_has_member js_val "light"
    then `LightDark ([%js.to: LightDarkIcon.t] js_val)
    else assert false
  ;;
end

module TextDocument = struct
  include Interface.Make ()

  include
    [%js:
      val uri : t -> Uri.t [@@js.get "uri"]
      val fileName : t -> string [@@js.get "fileName"]
      val isUntitled : t -> bool [@@js.get "isUntitled"]
      val languageId : t -> string [@@js.get "languageId"]
      val encoding : t -> string [@@js.get "encoding"]
      val version : t -> int [@@js.get "version"]
      val isDirty : t -> bool [@@js.get "isDirty"]
      val isClosed : t -> bool [@@js.get "isClosed"]
      val save : t -> bool Promise.t [@@js.call]
      val eol : t -> EndOfLine.t [@@js.get "eol"]
      val lineCount : t -> int [@@js.get "lineCount"]
      val lineAt : t -> line:int -> TextLine.t [@@js.call]
      val lineAtPosition : t -> position:Position.t -> TextLine.t [@@js.call "lineAt"]
      val offsetAt : t -> position:Position.t -> int [@@js.call]
      val positionAt : t -> offset:int -> Position.t [@@js.call]
      val getText : t -> ?range:Range.t -> unit -> string [@@js.call]

      val getWordRangeAtPosition
        :  t
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
      val uri : t -> Uri.t [@@js.get "uri"]
      val name : t -> string [@@js.get "name"]
      val index : t -> int [@@js.get "index"]]

  let create ~uri ~name ~index () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "uri" (Uri.t_to_js uri);
    Ojs.set_prop_ascii obj "name" (Ojs.string_to_js name);
    Ojs.set_prop_ascii obj "index" (Ojs.int_to_js index);
    t_of_js obj
  ;;
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

  type with_change = Range.with_change

  let with_change_to_js = Range.with_change_to_js
  let with_change_of_js = Range.with_change_of_js

  include
    [%js:
      val start : t -> Position.t [@@js.get "start"]
      val end_ : t -> Position.t [@@js.get "end"]
      val isEmpty : t -> bool [@@js.get "isEmpty"]
      val isSingleLine : t -> bool [@@js.get "isSingleLine"]

      val contains
        :  t
        -> positionOrRange:([ `Position of Position.t | `Range of Range.t ][@js.union])
        -> bool
      [@@js.call]

      val isEqual : t -> other:Range.t -> bool [@@js.call]
      val intersection : t -> range:Range.t -> Range.t or_undefined [@@js.call]
      val union : t -> other:Range.t -> Range.t [@@js.call]

      val with_ : t -> ?start:Position.t -> ?end_:Position.t -> unit -> Range.t
      [@@js.call]

      val withChange : t -> change:with_change -> Range.t [@@js.call "with"]
      val set_isEmpty : t -> bool -> unit [@@js.set "isEmpty"]
      val set_isSingleLine : t -> bool -> unit [@@js.set "isSingleLine"]]

  let to_range (x : t) = (x :> Range.t)

  include
    [%js:
      val anchor : t -> Position.t [@@js.get "anchor"]
      val active : t -> Position.t [@@js.get "active"]

      val makePositions : anchor:Position.t -> active:Position.t -> t
      [@@js.new "@vscode.Selection"]

      val makeCoordinates
        :  anchorLine:int
        -> anchorCharacter:int
        -> activeLine:int
        -> activeCharacter:int
        -> t
      [@@js.new "@vscode.Selection"]

      val isReversed : t -> bool [@@js.get "isReversed"]]
end

module Clipboard = struct
  include Interface.Make ()

  include
    [%js:
      val readText : t -> string Promise.t [@@js.call]
      val writeText : t -> string -> unit Promise.t [@@js.call]]

  let create ~readText ~writeText () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "readText" ([%js.of: unit -> string Promise.t] readText);
    Ojs.set_prop_ascii
      obj
      "writeText"
      ([%js.of: value:string -> unit Promise.t] writeText);
    t_of_js obj
  ;;
end

module TextEditorEdit = struct
  include Interface.Make ()

  type create_replace_arg0 =
    [ `Position of Position.t
    | `Range of Range.t
    | `Selection of Selection.t
    ]

  let create_replace_arg0_to_js = function
    | `Position value -> Position.t_to_js value
    | `Range value -> Range.t_to_js value
    | `Selection value -> Selection.t_to_js value
  ;;

  let create_replace_arg0_of_js js_val =
    match binding_constructor js_val [ "Position"; "Range"; "Selection" ] with
    | Some "Position" -> `Position (Position.t_of_js js_val)
    | Some "Range" -> `Range (Range.t_of_js js_val)
    | Some "Selection" -> `Selection (Selection.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "line"
        && binding_has_member js_val "character"
        && binding_has_member js_val "isBefore"
        && binding_has_member js_val "isBeforeOrEqual"
        && binding_has_member js_val "isAfter"
        && binding_has_member js_val "isAfterOrEqual"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "compareTo"
        && binding_has_member js_val "translate"
        && binding_has_member js_val "translate"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
      then `Position (Position.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "start"
        && binding_has_member js_val "end"
        && binding_has_member js_val "isEmpty"
        && binding_has_member js_val "isSingleLine"
        && binding_has_member js_val "contains"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "intersection"
        && binding_has_member js_val "union"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
      then `Range (Range.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "start"
        && binding_has_member js_val "end"
        && binding_has_member js_val "isEmpty"
        && binding_has_member js_val "isSingleLine"
        && binding_has_member js_val "contains"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "intersection"
        && binding_has_member js_val "union"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
        && binding_has_member js_val "anchor"
        && binding_has_member js_val "active"
        && binding_has_member js_val "isReversed"
      then `Selection (Selection.t_of_js js_val)
      else invalid_arg "TextEditorEdit.create_replace_arg0: unexpected JavaScript value"
  ;;

  type create_delete_arg0 =
    [ `Range of Range.t
    | `Selection of Selection.t
    ]

  let create_delete_arg0_to_js = function
    | `Range value -> Range.t_to_js value
    | `Selection value -> Selection.t_to_js value
  ;;

  let create_delete_arg0_of_js js_val =
    match binding_constructor js_val [ "Range"; "Selection" ] with
    | Some "Range" -> `Range (Range.t_of_js js_val)
    | Some "Selection" -> `Selection (Selection.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "start"
        && binding_has_member js_val "end"
        && binding_has_member js_val "isEmpty"
        && binding_has_member js_val "isSingleLine"
        && binding_has_member js_val "contains"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "intersection"
        && binding_has_member js_val "union"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
      then `Range (Range.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "start"
        && binding_has_member js_val "end"
        && binding_has_member js_val "isEmpty"
        && binding_has_member js_val "isSingleLine"
        && binding_has_member js_val "contains"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "intersection"
        && binding_has_member js_val "union"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
        && binding_has_member js_val "anchor"
        && binding_has_member js_val "active"
        && binding_has_member js_val "isReversed"
      then `Selection (Selection.t_of_js js_val)
      else invalid_arg "TextEditorEdit.create_delete_arg0: unexpected JavaScript value"
  ;;

  type replaceLocation =
    ([ `Position of Position.t
     | `Range of Range.t
     | `Selection of Selection.t
     ]
    [@js.union])
  [@@js]

  let replaceLocation_of_js js_val =
    if binding_has_member js_val "anchor"
    then `Position ([%js.to: Position.t] js_val)
    else if binding_has_member js_val "start"
    then `Range ([%js.to: Range.t] js_val)
    else `Selection ([%js.to: Selection.t] js_val)
  ;;

  type deleteLocation =
    ([ `Range of Range.t
     | `Selection of Selection.t
     ]
    [@js.union])
  [@@js]

  let deleteLocation_of_js js_val =
    if binding_has_member js_val "anchor"
    then `Selection ([%js.to: Selection.t] js_val)
    else `Range ([%js.to: Range.t] js_val)
  ;;

  include
    [%js:
      val replace : t -> location:replaceLocation -> value:string -> unit [@@js.call]
      val insert : t -> location:Position.t -> value:string -> unit [@@js.call]
      val delete : t -> location:deleteLocation -> unit [@@js.call]
      val setEndOfLine : t -> endOfLine:EndOfLine.t -> unit [@@js.call]]

  let create ~replace ~insert ~delete ~setEndOfLine () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "replace"
      ([%js.of: location:create_replace_arg0 -> value:string -> unit] replace);
    Ojs.set_prop_ascii
      obj
      "insert"
      ([%js.of: location:Position.t -> value:string -> unit] insert);
    Ojs.set_prop_ascii obj "delete" ([%js.of: location:create_delete_arg0 -> unit] delete);
    Ojs.set_prop_ascii
      obj
      "setEndOfLine"
      ([%js.of: endOfLine:EndOfLine.t -> unit] setEndOfLine);
    t_of_js obj
  ;;
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
    | Interval [@js 3]
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

  type tab_size =
    [ `Int of int
    | `String of string
    ]

  let tab_size_to_js = function
    | `Int value -> Ojs.int_to_js value
    | `String value -> Ojs.string_to_js value
  ;;

  let tab_size_of_js js_val =
    if Ojs.type_of js_val = "number"
    then `Int (Ojs.int_of_js js_val)
    else if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else invalid_arg "TextEditorOptions.tab_size: unexpected JavaScript value"
  ;;

  type insert_spaces =
    [ `Bool of bool
    | `String of string
    ]

  let insert_spaces_to_js = function
    | `Bool value -> Ojs.bool_to_js value
    | `String value -> Ojs.string_to_js value
  ;;

  let insert_spaces_of_js js_val =
    if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else invalid_arg "TextEditorOptions.insert_spaces: unexpected JavaScript value"
  ;;

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
  ;;

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
  ;;

  include
    [%js:
      val tabSize : t -> tab_size or_undefined [@@js.get "tabSize"]
      val indentSize : t -> tab_size or_undefined [@@js.get "indentSize"]
      val insertSpaces : t -> insert_spaces or_undefined [@@js.get "insertSpaces"]
      val cursorStyle : t -> TextEditorCursorStyle.t or_undefined [@@js.get "cursorStyle"]

      val lineNumbers : t -> TextEditorLineNumbersStyle.t or_undefined
      [@@js.get "lineNumbers"]]

  include
    [%js:
      val set_tabSize : t -> tab_size or_undefined -> unit [@@js.set "tabSize"]
      val set_indentSize : t -> tab_size or_undefined -> unit [@@js.set "indentSize"]

      val set_insertSpaces : t -> insert_spaces or_undefined -> unit
      [@@js.set "insertSpaces"]

      val set_cursorStyle : t -> TextEditorCursorStyle.t or_undefined -> unit
      [@@js.set "cursorStyle"]

      val set_lineNumbers : t -> TextEditorLineNumbersStyle.t or_undefined -> unit
      [@@js.set "lineNumbers"]]

  let create ?tabSize ?indentSize ?insertSpaces ?cursorStyle ?lineNumbers () =
    let obj = Ojs.obj [||] in
    iter_set obj "tabSize" tab_size_to_js tabSize;
    iter_set obj "indentSize" tab_size_to_js indentSize;
    iter_set obj "insertSpaces" insert_spaces_to_js insertSpaces;
    iter_set obj "cursorStyle" TextEditorCursorStyle.t_to_js cursorStyle;
    iter_set obj "lineNumbers" TextEditorLineNumbersStyle.t_to_js lineNumbers;
    t_of_js obj
  ;;
end

module TextEditorDecorationType = struct
  include Interface.Make ()

  include
    [%js:
      val key : t -> string [@@js.get "key"]
      val dispose : t -> unit [@@js.call]]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)

  let create ~key ~dispose () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "key" (Ojs.string_to_js key);
    Ojs.set_prop_ascii obj "dispose" ([%js.of: unit -> unit] dispose);
    t_of_js obj
  ;;
end

module MarkdownString = struct
  include Class.Make ()

  type is_trusted_item = { enabledCommands : string list }

  let is_trusted_item_to_js (value : is_trusted_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii
      js_val
      "enabledCommands"
      ((Ojs.list_to_js Ojs.string_to_js) value.enabledCommands);
    js_val
  ;;

  let is_trusted_item_of_js js_val : is_trusted_item =
    { enabledCommands =
        (Ojs.list_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "enabledCommands")
    }
  ;;

  type is_trusted =
    [ `Bool of bool
    | `Options of is_trusted_item
    ]

  let is_trusted_to_js = function
    | `Bool value -> Ojs.bool_to_js value
    | `Options value -> is_trusted_item_to_js value
  ;;

  let is_trusted_of_js js_val =
    if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else if
      (Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "enabledCommands"
    then `Options (is_trusted_item_of_js js_val)
    else invalid_arg "MarkdownString.is_trusted: unexpected JavaScript value"
  ;;

  include
    [%js:
      val value : t -> string [@@js.get "value"]
      val isTrusted : t -> is_trusted or_undefined [@@js.get "isTrusted"]
      val supportThemeIcons : t -> bool or_undefined [@@js.get "supportThemeIcons"]

      val make : ?value:string -> ?supportThemeIcons:bool -> unit -> t
      [@@js.new "@vscode.MarkdownString"]

      val appendText : t -> value:string -> t [@@js.call]
      val appendMarkdown : t -> value:string -> t [@@js.call]
      val appendCodeblock : t -> value:string -> ?language:string -> unit -> t [@@js.call]
      val set_value : t -> string -> unit [@@js.set "value"]
      val set_isTrusted : t -> is_trusted or_undefined -> unit [@@js.set "isTrusted"]

      val set_supportThemeIcons : t -> bool or_undefined -> unit
      [@@js.set "supportThemeIcons"]

      val supportHtml : t -> bool or_undefined [@@js.get "supportHtml"]
      val set_supportHtml : t -> bool or_undefined -> unit [@@js.set "supportHtml"]
      val baseUri : t -> Uri.t or_undefined [@@js.get "baseUri"]
      val set_baseUri : t -> Uri.t or_undefined -> unit [@@js.set "baseUri"]]
end

module ThemableDecorationAttachmentRenderOptions = struct
  include Interface.Make ()

  type content_icon_path =
    [ `String of string
    | `Uri of Uri.t
    ]

  let content_icon_path_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Uri value -> Uri.t_to_js value
  ;;

  let content_icon_path_of_js js_val =
    match binding_constructor js_val [ "Uri" ] with
    | Some "Uri" -> `Uri (Uri.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "scheme"
        && binding_has_member js_val "authority"
        && binding_has_member js_val "path"
        && binding_has_member js_val "query"
        && binding_has_member js_val "fragment"
        && binding_has_member js_val "fsPath"
        && binding_has_member js_val "with"
        && binding_has_member js_val "toString"
        && binding_has_member js_val "toJSON"
      then `Uri (Uri.t_of_js js_val)
      else
        invalid_arg
          "ThemableDecorationAttachmentRenderOptions.content_icon_path: unexpected \
           JavaScript value"
  ;;

  type border_color =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  let border_color_to_js = function
    | `String value -> Ojs.string_to_js value
    | `ThemeColor value -> ThemeColor.t_to_js value
  ;;

  let border_color_of_js js_val =
    match binding_constructor js_val [ "ThemeColor" ] with
    | Some "ThemeColor" -> `ThemeColor (ThemeColor.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "id"
      then `ThemeColor (ThemeColor.t_of_js js_val)
      else
        invalid_arg
          "ThemableDecorationAttachmentRenderOptions.border_color: unexpected JavaScript \
           value"
  ;;

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
  ;;

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
  ;;

  include
    [%js:
      val contentText : t -> string or_undefined [@@js.get "contentText"]

      val contentIconPath : t -> content_icon_path or_undefined
      [@@js.get "contentIconPath"]

      val border : t -> string or_undefined [@@js.get "border"]
      val borderColor : t -> border_color or_undefined [@@js.get "borderColor"]
      val fontStyle : t -> string or_undefined [@@js.get "fontStyle"]
      val fontWeight : t -> string or_undefined [@@js.get "fontWeight"]
      val textDecoration : t -> string or_undefined [@@js.get "textDecoration"]
      val color : t -> border_color or_undefined [@@js.get "color"]
      val backgroundColor : t -> border_color or_undefined [@@js.get "backgroundColor"]
      val margin : t -> string or_undefined [@@js.get "margin"]
      val width : t -> string or_undefined [@@js.get "width"]
      val height : t -> string or_undefined [@@js.get "height"]]

  include
    [%js:
      val set_contentText : t -> string or_undefined -> unit [@@js.set "contentText"]

      val set_contentIconPath : t -> content_icon_path or_undefined -> unit
      [@@js.set "contentIconPath"]

      val set_border : t -> string or_undefined -> unit [@@js.set "border"]

      val set_borderColor : t -> border_color or_undefined -> unit
      [@@js.set "borderColor"]

      val set_fontStyle : t -> string or_undefined -> unit [@@js.set "fontStyle"]
      val set_fontWeight : t -> string or_undefined -> unit [@@js.set "fontWeight"]

      val set_textDecoration : t -> string or_undefined -> unit
      [@@js.set "textDecoration"]

      val set_color : t -> border_color or_undefined -> unit [@@js.set "color"]

      val set_backgroundColor : t -> border_color or_undefined -> unit
      [@@js.set "backgroundColor"]

      val set_margin : t -> string or_undefined -> unit [@@js.set "margin"]
      val set_width : t -> string or_undefined -> unit [@@js.set "width"]
      val set_height : t -> string or_undefined -> unit [@@js.set "height"]]

  let create
        ?contentText
        ?contentIconPath
        ?border
        ?borderColor
        ?fontStyle
        ?fontWeight
        ?textDecoration
        ?color
        ?backgroundColor
        ?margin
        ?width
        ?height
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set obj "contentText" Ojs.string_to_js contentText;
    iter_set obj "contentIconPath" content_icon_path_to_js contentIconPath;
    iter_set obj "border" Ojs.string_to_js border;
    iter_set obj "borderColor" border_color_to_js borderColor;
    iter_set obj "fontStyle" Ojs.string_to_js fontStyle;
    iter_set obj "fontWeight" Ojs.string_to_js fontWeight;
    iter_set obj "textDecoration" Ojs.string_to_js textDecoration;
    iter_set obj "color" border_color_to_js color;
    iter_set obj "backgroundColor" border_color_to_js backgroundColor;
    iter_set obj "margin" Ojs.string_to_js margin;
    iter_set obj "width" Ojs.string_to_js width;
    iter_set obj "height" Ojs.string_to_js height;
    t_of_js obj
  ;;
end

module ThemableDecorationRenderOptions = struct
  include Interface.Make ()

  type background_color =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  let background_color_to_js = function
    | `String value -> Ojs.string_to_js value
    | `ThemeColor value -> ThemeColor.t_to_js value
  ;;

  let background_color_of_js js_val =
    match binding_constructor js_val [ "ThemeColor" ] with
    | Some "ThemeColor" -> `ThemeColor (ThemeColor.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "id"
      then `ThemeColor (ThemeColor.t_of_js js_val)
      else
        invalid_arg
          "ThemableDecorationRenderOptions.background_color: unexpected JavaScript value"
  ;;

  type gutter_icon_path =
    [ `String of string
    | `Uri of Uri.t
    ]

  let gutter_icon_path_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Uri value -> Uri.t_to_js value
  ;;

  let gutter_icon_path_of_js js_val =
    match binding_constructor js_val [ "Uri" ] with
    | Some "Uri" -> `Uri (Uri.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "scheme"
        && binding_has_member js_val "authority"
        && binding_has_member js_val "path"
        && binding_has_member js_val "query"
        && binding_has_member js_val "fragment"
        && binding_has_member js_val "fsPath"
        && binding_has_member js_val "with"
        && binding_has_member js_val "toString"
        && binding_has_member js_val "toJSON"
      then `Uri (Uri.t_of_js js_val)
      else
        invalid_arg
          "ThemableDecorationRenderOptions.gutter_icon_path: unexpected JavaScript value"
  ;;

  include
    [%js:
      val backgroundColor : t -> background_color or_undefined
      [@@js.get "backgroundColor"]

      val set_backgroundColor : t -> background_color or_undefined -> unit
      [@@js.set "backgroundColor"]

      val outline : t -> string or_undefined [@@js.get "outline"]
      val set_outline : t -> string or_undefined -> unit [@@js.set "outline"]
      val outlineColor : t -> background_color or_undefined [@@js.get "outlineColor"]

      val set_outlineColor : t -> background_color or_undefined -> unit
      [@@js.set "outlineColor"]

      val outlineStyle : t -> string or_undefined [@@js.get "outlineStyle"]
      val set_outlineStyle : t -> string or_undefined -> unit [@@js.set "outlineStyle"]
      val outlineWidth : t -> string or_undefined [@@js.get "outlineWidth"]
      val set_outlineWidth : t -> string or_undefined -> unit [@@js.set "outlineWidth"]
      val border : t -> string or_undefined [@@js.get "border"]
      val set_border : t -> string or_undefined -> unit [@@js.set "border"]
      val borderColor : t -> background_color or_undefined [@@js.get "borderColor"]

      val set_borderColor : t -> background_color or_undefined -> unit
      [@@js.set "borderColor"]

      val borderRadius : t -> string or_undefined [@@js.get "borderRadius"]
      val set_borderRadius : t -> string or_undefined -> unit [@@js.set "borderRadius"]
      val borderSpacing : t -> string or_undefined [@@js.get "borderSpacing"]
      val set_borderSpacing : t -> string or_undefined -> unit [@@js.set "borderSpacing"]
      val borderStyle : t -> string or_undefined [@@js.get "borderStyle"]
      val set_borderStyle : t -> string or_undefined -> unit [@@js.set "borderStyle"]
      val borderWidth : t -> string or_undefined [@@js.get "borderWidth"]
      val set_borderWidth : t -> string or_undefined -> unit [@@js.set "borderWidth"]
      val fontStyle : t -> string or_undefined [@@js.get "fontStyle"]
      val set_fontStyle : t -> string or_undefined -> unit [@@js.set "fontStyle"]
      val fontWeight : t -> string or_undefined [@@js.get "fontWeight"]
      val set_fontWeight : t -> string or_undefined -> unit [@@js.set "fontWeight"]
      val textDecoration : t -> string or_undefined [@@js.get "textDecoration"]

      val set_textDecoration : t -> string or_undefined -> unit
      [@@js.set "textDecoration"]

      val cursor : t -> string or_undefined [@@js.get "cursor"]
      val set_cursor : t -> string or_undefined -> unit [@@js.set "cursor"]
      val color : t -> background_color or_undefined [@@js.get "color"]
      val set_color : t -> background_color or_undefined -> unit [@@js.set "color"]
      val opacity : t -> string or_undefined [@@js.get "opacity"]
      val set_opacity : t -> string or_undefined -> unit [@@js.set "opacity"]
      val letterSpacing : t -> string or_undefined [@@js.get "letterSpacing"]
      val set_letterSpacing : t -> string or_undefined -> unit [@@js.set "letterSpacing"]
      val gutterIconPath : t -> gutter_icon_path or_undefined [@@js.get "gutterIconPath"]

      val set_gutterIconPath : t -> gutter_icon_path or_undefined -> unit
      [@@js.set "gutterIconPath"]

      val gutterIconSize : t -> string or_undefined [@@js.get "gutterIconSize"]

      val set_gutterIconSize : t -> string or_undefined -> unit
      [@@js.set "gutterIconSize"]

      val overviewRulerColor : t -> background_color or_undefined
      [@@js.get "overviewRulerColor"]

      val set_overviewRulerColor : t -> background_color or_undefined -> unit
      [@@js.set "overviewRulerColor"]

      val before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
      [@@js.get "before"]

      val set_before
        :  t
        -> ThemableDecorationAttachmentRenderOptions.t or_undefined
        -> unit
      [@@js.set "before"]

      val after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
      [@@js.get "after"]

      val set_after
        :  t
        -> ThemableDecorationAttachmentRenderOptions.t or_undefined
        -> unit
      [@@js.set "after"]]

  let create
        ?backgroundColor
        ?outline
        ?outlineColor
        ?outlineStyle
        ?outlineWidth
        ?border
        ?borderColor
        ?borderRadius
        ?borderSpacing
        ?borderStyle
        ?borderWidth
        ?fontStyle
        ?fontWeight
        ?textDecoration
        ?cursor
        ?color
        ?opacity
        ?letterSpacing
        ?gutterIconPath
        ?gutterIconSize
        ?overviewRulerColor
        ?before
        ?after
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set obj "backgroundColor" background_color_to_js backgroundColor;
    iter_set obj "outline" Ojs.string_to_js outline;
    iter_set obj "outlineColor" background_color_to_js outlineColor;
    iter_set obj "outlineStyle" Ojs.string_to_js outlineStyle;
    iter_set obj "outlineWidth" Ojs.string_to_js outlineWidth;
    iter_set obj "border" Ojs.string_to_js border;
    iter_set obj "borderColor" background_color_to_js borderColor;
    iter_set obj "borderRadius" Ojs.string_to_js borderRadius;
    iter_set obj "borderSpacing" Ojs.string_to_js borderSpacing;
    iter_set obj "borderStyle" Ojs.string_to_js borderStyle;
    iter_set obj "borderWidth" Ojs.string_to_js borderWidth;
    iter_set obj "fontStyle" Ojs.string_to_js fontStyle;
    iter_set obj "fontWeight" Ojs.string_to_js fontWeight;
    iter_set obj "textDecoration" Ojs.string_to_js textDecoration;
    iter_set obj "cursor" Ojs.string_to_js cursor;
    iter_set obj "color" background_color_to_js color;
    iter_set obj "opacity" Ojs.string_to_js opacity;
    iter_set obj "letterSpacing" Ojs.string_to_js letterSpacing;
    iter_set obj "gutterIconPath" gutter_icon_path_to_js gutterIconPath;
    iter_set obj "gutterIconSize" Ojs.string_to_js gutterIconSize;
    iter_set obj "overviewRulerColor" background_color_to_js overviewRulerColor;
    iter_set obj "before" ThemableDecorationAttachmentRenderOptions.t_to_js before;
    iter_set obj "after" ThemableDecorationAttachmentRenderOptions.t_to_js after;
    t_of_js obj
  ;;
end

module DecorationRangeBehavior = struct
  type t =
    | OpenOpen [@js 0]
    | ClosedClosed [@js 1]
    | OpenClosed [@js 2]
    | ClosedOpen [@js 3]
  [@@js.enum] [@@js]
end

module OverviewRulerLane = struct
  type t = int [@@js]

  let left = 1
  let center = 2
  let right = 4
  let full = 7
  let combine flags = List.fold_left ( lor ) 0 flags
  let mem value ~flag = value land flag = flag
end

module DecorationRenderOptions = struct
  include Interface.Extend (ThemableDecorationRenderOptions) ()

  type background_color =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  let background_color_to_js = function
    | `String value -> Ojs.string_to_js value
    | `ThemeColor value -> ThemeColor.t_to_js value
  ;;

  let background_color_of_js js_val =
    match binding_constructor js_val [ "ThemeColor" ] with
    | Some "ThemeColor" -> `ThemeColor (ThemeColor.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "id"
      then `ThemeColor (ThemeColor.t_of_js js_val)
      else
        invalid_arg
          "DecorationRenderOptions.background_color: unexpected JavaScript value"
  ;;

  type gutter_icon_path =
    [ `String of string
    | `Uri of Uri.t
    ]

  let gutter_icon_path_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Uri value -> Uri.t_to_js value
  ;;

  let gutter_icon_path_of_js js_val =
    match binding_constructor js_val [ "Uri" ] with
    | Some "Uri" -> `Uri (Uri.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "scheme"
        && binding_has_member js_val "authority"
        && binding_has_member js_val "path"
        && binding_has_member js_val "query"
        && binding_has_member js_val "fragment"
        && binding_has_member js_val "fsPath"
        && binding_has_member js_val "with"
        && binding_has_member js_val "toString"
        && binding_has_member js_val "toJSON"
      then `Uri (Uri.t_of_js js_val)
      else
        invalid_arg
          "DecorationRenderOptions.gutter_icon_path: unexpected JavaScript value"
  ;;

  type color = ThemableDecorationAttachmentRenderOptions.color [@@js]

  let to_themable_decoration_render_options (value : t) =
    (value :> ThemableDecorationRenderOptions.t)
  ;;

  include
    [%js:
      val backgroundColor : t -> background_color or_undefined
      [@@js.get "backgroundColor"]

      val set_backgroundColor : t -> background_color or_undefined -> unit
      [@@js.set "backgroundColor"]

      val outline : t -> string or_undefined [@@js.get "outline"]
      val set_outline : t -> string or_undefined -> unit [@@js.set "outline"]
      val outlineColor : t -> background_color or_undefined [@@js.get "outlineColor"]

      val set_outlineColor : t -> background_color or_undefined -> unit
      [@@js.set "outlineColor"]

      val outlineStyle : t -> string or_undefined [@@js.get "outlineStyle"]
      val set_outlineStyle : t -> string or_undefined -> unit [@@js.set "outlineStyle"]
      val outlineWidth : t -> string or_undefined [@@js.get "outlineWidth"]
      val set_outlineWidth : t -> string or_undefined -> unit [@@js.set "outlineWidth"]
      val border : t -> string or_undefined [@@js.get "border"]
      val set_border : t -> string or_undefined -> unit [@@js.set "border"]
      val borderColor : t -> background_color or_undefined [@@js.get "borderColor"]

      val set_borderColor : t -> background_color or_undefined -> unit
      [@@js.set "borderColor"]

      val borderRadius : t -> string or_undefined [@@js.get "borderRadius"]
      val set_borderRadius : t -> string or_undefined -> unit [@@js.set "borderRadius"]
      val borderSpacing : t -> string or_undefined [@@js.get "borderSpacing"]
      val set_borderSpacing : t -> string or_undefined -> unit [@@js.set "borderSpacing"]
      val borderStyle : t -> string or_undefined [@@js.get "borderStyle"]
      val set_borderStyle : t -> string or_undefined -> unit [@@js.set "borderStyle"]
      val borderWidth : t -> string or_undefined [@@js.get "borderWidth"]
      val set_borderWidth : t -> string or_undefined -> unit [@@js.set "borderWidth"]
      val fontStyle : t -> string or_undefined [@@js.get "fontStyle"]
      val set_fontStyle : t -> string or_undefined -> unit [@@js.set "fontStyle"]
      val fontWeight : t -> string or_undefined [@@js.get "fontWeight"]
      val set_fontWeight : t -> string or_undefined -> unit [@@js.set "fontWeight"]
      val textDecoration : t -> string or_undefined [@@js.get "textDecoration"]

      val set_textDecoration : t -> string or_undefined -> unit
      [@@js.set "textDecoration"]

      val cursor : t -> string or_undefined [@@js.get "cursor"]
      val set_cursor : t -> string or_undefined -> unit [@@js.set "cursor"]
      val color : t -> background_color or_undefined [@@js.get "color"]
      val set_color : t -> background_color or_undefined -> unit [@@js.set "color"]
      val opacity : t -> string or_undefined [@@js.get "opacity"]
      val set_opacity : t -> string or_undefined -> unit [@@js.set "opacity"]
      val letterSpacing : t -> string or_undefined [@@js.get "letterSpacing"]
      val set_letterSpacing : t -> string or_undefined -> unit [@@js.set "letterSpacing"]
      val gutterIconPath : t -> gutter_icon_path or_undefined [@@js.get "gutterIconPath"]

      val set_gutterIconPath : t -> gutter_icon_path or_undefined -> unit
      [@@js.set "gutterIconPath"]

      val gutterIconSize : t -> string or_undefined [@@js.get "gutterIconSize"]

      val set_gutterIconSize : t -> string or_undefined -> unit
      [@@js.set "gutterIconSize"]

      val overviewRulerColor : t -> background_color or_undefined
      [@@js.get "overviewRulerColor"]

      val set_overviewRulerColor : t -> background_color or_undefined -> unit
      [@@js.set "overviewRulerColor"]

      val before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
      [@@js.get "before"]

      val set_before
        :  t
        -> ThemableDecorationAttachmentRenderOptions.t or_undefined
        -> unit
      [@@js.set "before"]

      val after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
      [@@js.get "after"]

      val set_after
        :  t
        -> ThemableDecorationAttachmentRenderOptions.t or_undefined
        -> unit
      [@@js.set "after"]

      val isWholeLine : t -> bool or_undefined [@@js.get "isWholeLine"]
      val set_isWholeLine : t -> bool or_undefined -> unit [@@js.set "isWholeLine"]

      val rangeBehavior : t -> DecorationRangeBehavior.t or_undefined
      [@@js.get "rangeBehavior"]

      val set_rangeBehavior : t -> DecorationRangeBehavior.t or_undefined -> unit
      [@@js.set "rangeBehavior"]

      val overviewRulerLane : t -> OverviewRulerLane.t or_undefined
      [@@js.get "overviewRulerLane"]

      val set_overviewRulerLane : t -> OverviewRulerLane.t or_undefined -> unit
      [@@js.set "overviewRulerLane"]

      val light : t -> ThemableDecorationRenderOptions.t or_undefined [@@js.get "light"]

      val set_light : t -> ThemableDecorationRenderOptions.t or_undefined -> unit
      [@@js.set "light"]

      val dark : t -> ThemableDecorationRenderOptions.t or_undefined [@@js.get "dark"]

      val set_dark : t -> ThemableDecorationRenderOptions.t or_undefined -> unit
      [@@js.set "dark"]]

  let create
        ?backgroundColor
        ?outline
        ?outlineColor
        ?outlineStyle
        ?outlineWidth
        ?border
        ?borderColor
        ?borderRadius
        ?borderSpacing
        ?borderStyle
        ?borderWidth
        ?fontStyle
        ?fontWeight
        ?textDecoration
        ?cursor
        ?color
        ?opacity
        ?letterSpacing
        ?gutterIconPath
        ?gutterIconSize
        ?overviewRulerColor
        ?before
        ?after
        ?isWholeLine
        ?rangeBehavior
        ?overviewRulerLane
        ?light
        ?dark
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set obj "backgroundColor" background_color_to_js backgroundColor;
    iter_set obj "outline" Ojs.string_to_js outline;
    iter_set obj "outlineColor" background_color_to_js outlineColor;
    iter_set obj "outlineStyle" Ojs.string_to_js outlineStyle;
    iter_set obj "outlineWidth" Ojs.string_to_js outlineWidth;
    iter_set obj "border" Ojs.string_to_js border;
    iter_set obj "borderColor" background_color_to_js borderColor;
    iter_set obj "borderRadius" Ojs.string_to_js borderRadius;
    iter_set obj "borderSpacing" Ojs.string_to_js borderSpacing;
    iter_set obj "borderStyle" Ojs.string_to_js borderStyle;
    iter_set obj "borderWidth" Ojs.string_to_js borderWidth;
    iter_set obj "fontStyle" Ojs.string_to_js fontStyle;
    iter_set obj "fontWeight" Ojs.string_to_js fontWeight;
    iter_set obj "textDecoration" Ojs.string_to_js textDecoration;
    iter_set obj "cursor" Ojs.string_to_js cursor;
    iter_set obj "color" background_color_to_js color;
    iter_set obj "opacity" Ojs.string_to_js opacity;
    iter_set obj "letterSpacing" Ojs.string_to_js letterSpacing;
    iter_set obj "gutterIconPath" gutter_icon_path_to_js gutterIconPath;
    iter_set obj "gutterIconSize" Ojs.string_to_js gutterIconSize;
    iter_set obj "overviewRulerColor" background_color_to_js overviewRulerColor;
    iter_set obj "before" ThemableDecorationAttachmentRenderOptions.t_to_js before;
    iter_set obj "after" ThemableDecorationAttachmentRenderOptions.t_to_js after;
    iter_set obj "isWholeLine" Ojs.bool_to_js isWholeLine;
    iter_set obj "rangeBehavior" DecorationRangeBehavior.t_to_js rangeBehavior;
    iter_set obj "overviewRulerLane" OverviewRulerLane.t_to_js overviewRulerLane;
    iter_set obj "light" ThemableDecorationRenderOptions.t_to_js light;
    iter_set obj "dark" ThemableDecorationRenderOptions.t_to_js dark;
    t_of_js obj
  ;;
end

module ThemableDecorationInstanceRenderOptions = struct
  include Interface.Make ()

  include
    [%js:
      val before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
      [@@js.get "before"]

      val after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
      [@@js.get "after"]]

  include
    [%js:
      val set_before
        :  t
        -> ThemableDecorationAttachmentRenderOptions.t or_undefined
        -> unit
      [@@js.set "before"]

      val set_after
        :  t
        -> ThemableDecorationAttachmentRenderOptions.t or_undefined
        -> unit
      [@@js.set "after"]]

  let create ?before ?after () =
    let obj = Ojs.obj [||] in
    iter_set obj "before" ThemableDecorationAttachmentRenderOptions.t_to_js before;
    iter_set obj "after" ThemableDecorationAttachmentRenderOptions.t_to_js after;
    t_of_js obj
  ;;
end

module DecorationInstanceRenderOptions = struct
  include Interface.Extend (ThemableDecorationInstanceRenderOptions) ()

  include
    [%js:
      val light : t -> ThemableDecorationInstanceRenderOptions.t or_undefined
      [@@js.get "light"]

      val dark : t -> ThemableDecorationInstanceRenderOptions.t or_undefined
      [@@js.get "dark"]]

  let to_themable_decoration_instance_render_options (value : t) =
    (value :> ThemableDecorationInstanceRenderOptions.t)
  ;;

  include
    [%js:
      val before : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
      [@@js.get "before"]

      val set_before
        :  t
        -> ThemableDecorationAttachmentRenderOptions.t or_undefined
        -> unit
      [@@js.set "before"]

      val after : t -> ThemableDecorationAttachmentRenderOptions.t or_undefined
      [@@js.get "after"]

      val set_after
        :  t
        -> ThemableDecorationAttachmentRenderOptions.t or_undefined
        -> unit
      [@@js.set "after"]

      val set_light : t -> ThemableDecorationInstanceRenderOptions.t or_undefined -> unit
      [@@js.set "light"]

      val set_dark : t -> ThemableDecorationInstanceRenderOptions.t or_undefined -> unit
      [@@js.set "dark"]]

  let create ?before ?after ?light ?dark () =
    let obj = Ojs.obj [||] in
    iter_set obj "before" ThemableDecorationAttachmentRenderOptions.t_to_js before;
    iter_set obj "after" ThemableDecorationAttachmentRenderOptions.t_to_js after;
    iter_set obj "light" ThemableDecorationInstanceRenderOptions.t_to_js light;
    iter_set obj "dark" ThemableDecorationInstanceRenderOptions.t_to_js dark;
    t_of_js obj
  ;;
end

module MarkedString = struct
  type value_item =
    { language : string
    ; value : string
    }

  let value_item_to_js (value : value_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "language" (Ojs.string_to_js value.language);
    Ojs.set_prop_ascii js_val "value" (Ojs.string_to_js value.value);
    js_val
  ;;

  let value_item_of_js js_val : value_item =
    { language = Ojs.string_of_js (Ojs.get_prop_ascii js_val "language")
    ; value = Ojs.string_of_js (Ojs.get_prop_ascii js_val "value")
    }
  ;;

  type value =
    [ `String of string
    | `Options of value_item
    ]

  let value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Options value -> value_item_to_js value
  ;;

  let value_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      (Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "language"
      && binding_has_member js_val "value"
    then `Options (value_item_of_js js_val)
    else invalid_arg "MarkedString.value: unexpected JavaScript value"
  ;;

  type t = value

  let t_to_js = value_to_js
  let t_of_js = value_of_js
end

module DecorationOptions = struct
  include Interface.Make ()

  type hover_message_item =
    [ `MarkdownString of MarkdownString.t
    | `MarkedString of MarkedString.t
    ]

  let hover_message_item_to_js = function
    | `MarkdownString value -> MarkdownString.t_to_js value
    | `MarkedString value -> MarkedString.t_to_js value
  ;;

  let hover_message_item_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else if
        Ojs.type_of js_val = "string"
        || ((Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "language"
            && binding_has_member js_val "value")
      then `MarkedString (MarkedString.t_of_js js_val)
      else invalid_arg "DecorationOptions.hover_message_item: unexpected JavaScript value"
  ;;

  type hover_message =
    [ `MarkdownString of MarkdownString.t
    | `MarkedString of MarkedString.t
    | `Array of hover_message_item list
    ]

  let hover_message_to_js = function
    | `MarkdownString value -> MarkdownString.t_to_js value
    | `MarkedString value -> MarkedString.t_to_js value
    | `Array value -> (Ojs.list_to_js hover_message_item_to_js) value
  ;;

  let hover_message_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else if
        Ojs.type_of js_val = "string"
        || ((Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "language"
            && binding_has_member js_val "value")
      then `MarkedString (MarkedString.t_of_js js_val)
      else if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            (Ojs.type_of js_val = "object"
             && (not (Ojs.is_null js_val))
             && binding_has_member js_val "value"
             && binding_has_member js_val "appendText"
             && binding_has_member js_val "appendMarkdown"
             && binding_has_member js_val "appendCodeblock")
            || Ojs.type_of js_val = "string"
            || ((Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
                && (not (Ojs.is_null js_val))
                && binding_has_member js_val "language"
                && binding_has_member js_val "value"))
      then `Array ((Ojs.list_of_js hover_message_item_of_js) js_val)
      else invalid_arg "DecorationOptions.hover_message: unexpected JavaScript value"
  ;;

  type hoverMessage =
    ([ `MarkdownString of MarkdownString.t
     | `MarkdownStrings of MarkdownString.t list
     ]
    [@js.union])
  [@@js]

  let hoverMessage_of_js js_val =
    if binding_has_member js_val "value"
    then `MarkdownString ([%js.to: MarkdownString.t] js_val)
    else `MarkdownStrings ([%js.to: MarkdownString.t list] js_val)
  ;;

  include
    [%js:
      val range : t -> Range.t [@@js.get "range"]
      val hoverMessage : t -> hover_message or_undefined [@@js.get "hoverMessage"]

      val renderOptions : t -> DecorationInstanceRenderOptions.t or_undefined
      [@@js.get "renderOptions"]]

  include
    [%js:
      val set_range : t -> Range.t -> unit [@@js.set "range"]

      val set_hoverMessage : t -> hover_message or_undefined -> unit
      [@@js.set "hoverMessage"]

      val set_renderOptions : t -> DecorationInstanceRenderOptions.t or_undefined -> unit
      [@@js.set "renderOptions"]]

  let create ~range ?hoverMessage ?renderOptions () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "range" (Range.t_to_js range);
    iter_set obj "hoverMessage" hover_message_to_js hoverMessage;
    iter_set obj "renderOptions" DecorationInstanceRenderOptions.t_to_js renderOptions;
    t_of_js obj
  ;;
end

module SnippetString = struct
  include Class.Make ()

  type append_variable_default_value =
    [ `String of string
    | `Options of snippet:t -> Ojs.t
    ]

  let append_variable_default_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Options value -> [%js.of: snippet:t -> Ojs.t] value
  ;;

  let append_variable_default_value_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if Ojs.type_of js_val = "function"
    then `Options ([%js.to: snippet:t -> Ojs.t] js_val)
    else
      invalid_arg
        "SnippetString.append_variable_default_value: unexpected JavaScript value"
  ;;

  include
    [%js:
      val value : t -> string [@@js.get "value"]
      val make : ?value:string -> unit -> t [@@js.new "@vscode.SnippetString"]
      val appendText : t -> string:string -> t [@@js.call]

      val appendPlaceholder
        :  t
        -> value:([ `String of string | `Function of t -> unit ][@js.union])
        -> ?number:int
        -> unit
        -> t
      [@@js.call]

      val appendChoice : t -> values:string list -> ?number:int -> unit -> t [@@js.call]]

  include [%js: val set_value : t -> string -> unit [@@js.set "value"]]

  let appendTabstop this ?number () =
    t_of_js
      (Ojs.call
         (t_to_js this)
         "appendTabstop"
         (binding_arguments
            [| (or_undefined_to_js Ojs.int_to_js) number |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val appendVariable
        :  t
        -> name:string
        -> defaultValue:append_variable_default_value
        -> t
      [@@js.call "appendVariable"]]
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
      val document : t -> TextDocument.t [@@js.get "document"]
      val selection : t -> Selection.t [@@js.get "selection"]
      val set_selection : t -> Selection.t -> unit [@@js.set "selection"]
      val selections : t -> Selection.t list [@@js.get "selections"]
      val visibleRanges : t -> Range.t list [@@js.get "visibleRanges"]
      val options : t -> TextEditorOptions.t [@@js.get "options"]
      val viewColumn : t -> ViewColumn.t or_undefined [@@js.get "viewColumn"]

      val edit
        :  t
        -> callback:(editBuilder:TextEditorEdit.t -> unit)
        -> Ojs.t
        -> unit
        -> bool Promise.t
      [@@js.call]

      val insertSnippet
        :  t
        -> snippet:SnippetString.t
        -> location:insertSnippetLocation or_undefined
        -> Ojs.t
        -> bool Promise.t
      [@@js.call]

      val setDecorations
        :  t
        -> decorationType:TextEditorDecorationType.t
        -> rangesOrOptions:
             ([ `Ranges of Range.t list | `Options of DecorationOptions.t list ]
             [@js.union])
        -> unit
      [@@js.call]

      val revealRange
        :  t
        -> range:Range.t
        -> ?revealType:TextEditorRevealType.t
        -> unit
        -> unit
      [@@js.call]]

  let edit this ~callback ?undoStopBefore ?undoStopAfter () =
    let options = Ojs.obj [||] in
    iter_set options "undoStopBefore" [%js.of: bool] undoStopBefore;
    iter_set options "undoStopAfter" [%js.of: bool] undoStopAfter;
    edit this ~callback options ()
  ;;

  let insertSnippet
        this
        ~snippet
        ?location
        ?undoStopBefore
        ?undoStopAfter
        ?keepWhitespace
        ()
    =
    let options = Ojs.obj [||] in
    iter_set options "undoStopBefore" [%js.of: bool] undoStopBefore;
    iter_set options "undoStopAfter" [%js.of: bool] undoStopAfter;
    iter_set options "keepWhitespace" [%js.of: bool] keepWhitespace;
    insertSnippet this ~snippet ~location options
  ;;

  include
    [%js:
      val set_selections : t -> Selection.t list -> unit [@@js.set "selections"]
      val set_options : t -> TextEditorOptions.t -> unit [@@js.set "options"]]

  let show this ?column () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "show"
         (binding_arguments
            [| (or_undefined_to_js ViewColumn.t_to_js) column |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include [%js: val hide : t -> unit [@@js.call "hide"]]
end

module TextEditorSelectionChangeKind = struct
  type t =
    | Keyboard [@js 1]
    | Mouse [@js 2]
    | Command [@js 3]
  [@@js.enum] [@@js]
end

module TextEditorSelectionChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val textEditor : t -> TextEditor.t [@@js.get "textEditor"]
      val selections : t -> Selection.t list [@@js.get "selections"]
      val kind : t -> TextEditorSelectionChangeKind.t or_undefined [@@js.get "kind"]]

  let create ~textEditor ~selections ~kind () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "textEditor" (TextEditor.t_to_js textEditor);
    Ojs.set_prop_ascii obj "selections" ((Ojs.list_to_js Selection.t_to_js) selections);
    Ojs.set_prop_ascii
      obj
      "kind"
      ((or_undefined_to_js TextEditorSelectionChangeKind.t_to_js) kind);
    t_of_js obj
  ;;
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

  type update_with_target_configuration_target =
    [ `ConfigurationTarget of ConfigurationTarget.t
    | `Bool of bool
    | `Null
    ]

  let update_with_target_configuration_target_to_js = function
    | `ConfigurationTarget value -> ConfigurationTarget.t_to_js value
    | `Bool value -> Ojs.bool_to_js value
    | `Null -> Ojs.null
  ;;

  let update_with_target_configuration_target_of_js js_val =
    if Ojs.type_of js_val = "number"
    then `ConfigurationTarget (ConfigurationTarget.t_of_js js_val)
    else if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else if Ojs.type_of js_val = "object" && Ojs.is_null js_val
    then `Null
    else
      invalid_arg
        "WorkspaceConfiguration.update_with_target_configuration_target: unexpected \
         JavaScript value"
  ;;

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
    ; workspaceFolderValue = [%js.to: t or_undefined] (field "workspaceFolderValue")
    ; defaultLanguageValue = [%js.to: t or_undefined] (field "defaultLanguageValue")
    ; globalLanguageValue = [%js.to: t or_undefined] (field "globalLanguageValue")
    ; workspaceLanguageValue = [%js.to: t or_undefined] (field "workspaceLanguageValue")
    ; workspaceFolderLanguageValue =
        [%js.to: t or_undefined] (field "workspaceFolderLanguageValue")
    ; languageIds = [%js.to: string list or_undefined] (field "languageIds")
    }
  ;;

  include
    [%js:
      val get : t -> section:string -> Ojs.t or_undefined [@@js.call]

      val get_default
        :  ((module Ojs.T with type t = 'a)[@js])
        -> t
        -> section:string
        -> defaultValue:'a
        -> 'a
      [@@js.call "get"]

      val has : t -> section:string -> bool [@@js.call]

      val inspect
        :  ((module Ojs.T with type t = 'a)[@js])
        -> t
        -> section:string
        -> 'a inspectResult or_undefined
      [@@js.call]

      val update
        :  t
        -> section:string
        -> value:Ojs.t
        -> ?configurationTarget:
             ([ `ConfigurationTarget of ConfigurationTarget.t | `Bool of bool ]
             [@js.union])
        -> ?overrideInLanguage:bool
        -> unit
        -> unit Promise.t
      [@@js.call]

      val getTyped
        :  ((module Ojs.T with type t = 'p_t)[@js])
        -> t
        -> section:string
        -> 'p_t or_undefined
      [@@js.call "get"]]

  let updateWithTarget this ~section ~value ?configurationTarget ?overrideInLanguage () =
    (Promise.t_of_js (fun _ -> ()))
      (Ojs.call
         (t_to_js this)
         "update"
         (binding_arguments
            [| Ojs.string_to_js section
             ; Ojs.t_to_js value
             ; (or_undefined_to_js update_with_target_configuration_target_to_js)
                 configurationTarget
             ; (or_undefined_to_js Ojs.bool_to_js) overrideInLanguage
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let getProperty this ~key =
    (or_undefined_of_js Ojs.t_of_js) (Ojs.get_prop (t_to_js this) (Ojs.string_to_js key))
  ;;
end

module SnippetTextEdit = struct
  include Class.Make ()

  include
    [%js:
      val replace : range:Range.t -> snippet:SnippetString.t -> t
      [@@js.global "@vscode.SnippetTextEdit.replace"]

      val insert : position:Position.t -> snippet:SnippetString.t -> t
      [@@js.global "@vscode.SnippetTextEdit.insert"]

      val range : t -> Range.t [@@js.get "range"]
      val set_range : t -> Range.t -> unit [@@js.set "range"]
      val snippet : t -> SnippetString.t [@@js.get "snippet"]
      val set_snippet : t -> SnippetString.t -> unit [@@js.set "snippet"]
      val keepWhitespace : t -> bool or_undefined [@@js.get "keepWhitespace"]
      val set_keepWhitespace : t -> bool or_undefined -> unit [@@js.set "keepWhitespace"]

      val make : range:Range.t -> snippet:SnippetString.t -> t
      [@@js.new "@vscode.SnippetTextEdit"]]
end

module Uint8Array = struct
  include Class.Make ()

  include
    [%js:
      val of_array : int array -> t [@@js.new "Uint8Array"]
      val to_array : t -> int array [@@js.global "Array.from"]]
end

module DataTransferFile = struct
  include Interface.Make ()

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val uri : t -> Uri.t or_undefined [@@js.get "uri"]
      val data : t -> Uint8Array.t Promise.t [@@js.call "data"]]

  let create ~name ?uri ~data () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "name" (Ojs.string_to_js name);
    iter_set obj "uri" Uri.t_to_js uri;
    Ojs.set_prop_ascii obj "data" ([%js.of: unit -> Uint8Array.t Promise.t] data);
    t_of_js obj
  ;;
end

module WorkspaceEditEntryMetadata = struct
  include Interface.Make ()

  include
    [%js:
      val needsConfirmation : t -> bool [@@js.get "needsConfirmation"]
      val set_needsConfirmation : t -> bool -> unit [@@js.set "needsConfirmation"]
      val label : t -> string [@@js.get "label"]
      val set_label : t -> string -> unit [@@js.set "label"]
      val description : t -> string or_undefined [@@js.get "description"]
      val set_description : t -> string or_undefined -> unit [@@js.set "description"]
      val iconPath : t -> IconPath.t or_undefined [@@js.get "iconPath"]
      val set_iconPath : t -> IconPath.t or_undefined -> unit [@@js.set "iconPath"]]

  let create ~needsConfirmation ~label ?description ?iconPath () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "needsConfirmation" (Ojs.bool_to_js needsConfirmation);
    Ojs.set_prop_ascii obj "label" (Ojs.string_to_js label);
    iter_set obj "description" Ojs.string_to_js description;
    iter_set obj "iconPath" IconPath.t_to_js iconPath;
    t_of_js obj
  ;;
end

module NotebookRange = struct
  include Class.Make ()

  type with__change =
    { start : int or_undefined
    ; end_ : int or_undefined
    }

  let with__change_to_js (value : with__change) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "start" Ojs.int_to_js value.start;
    iter_set js_val "end" Ojs.int_to_js value.end_;
    js_val
  ;;

  let with__change_of_js js_val : with__change =
    { start = (or_undefined_of_js Ojs.int_of_js) (Ojs.get_prop_ascii js_val "start")
    ; end_ = (or_undefined_of_js Ojs.int_of_js) (Ojs.get_prop_ascii js_val "end")
    }
  ;;

  include
    [%js:
      val start : t -> int [@@js.get "start"]
      val end_ : t -> int [@@js.get "end"]
      val isEmpty : t -> bool [@@js.get "isEmpty"]
      val make : start:int -> end_:int -> t [@@js.new "@vscode.NotebookRange"]
      val with_ : t -> change:with__change -> t [@@js.call "with"]]
end

module NotebookCellKind = struct
  type t =
    | Markup [@js 1]
    | Code [@js 2]
  [@@js.enum] [@@js]
end

module JsError = struct
  include Class.Make ()

  include
    [%js:
      val make : ?message:string -> unit -> t [@@js.new "Error"]
      val name : t -> string [@@js.get]
      val message : t -> string [@@js.get]
      val stack : t -> string or_undefined [@@js.get]
      val cause : t -> Ojs.t or_undefined [@@js.get]]
end

module NotebookCellOutputItem = struct
  include Class.Make ()

  let text ~value ?mime () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "NotebookCellOutputItem")
         "text"
         (binding_arguments
            [| Ojs.string_to_js value; (or_undefined_to_js Ojs.string_to_js) mime |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let json ~value ?mime () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "NotebookCellOutputItem")
         "json"
         (binding_arguments
            [| Ojs.t_to_js value; (or_undefined_to_js Ojs.string_to_js) mime |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val stdout : value:string -> t [@@js.global "@vscode.NotebookCellOutputItem.stdout"]
      val stderr : value:string -> t [@@js.global "@vscode.NotebookCellOutputItem.stderr"]

      val error : value:JsError.t -> t
      [@@js.global "@vscode.NotebookCellOutputItem.error"]

      val mime : t -> string [@@js.get "mime"]
      val set_mime : t -> string -> unit [@@js.set "mime"]
      val data : t -> Uint8Array.t [@@js.get "data"]
      val set_data : t -> Uint8Array.t -> unit [@@js.set "data"]

      val make : data:Uint8Array.t -> mime:string -> t
      [@@js.new "@vscode.NotebookCellOutputItem"]]
end

module NotebookCellOutput = struct
  include Class.Make ()

  include
    [%js:
      val items : t -> NotebookCellOutputItem.t list [@@js.get "items"]
      val set_items : t -> NotebookCellOutputItem.t list -> unit [@@js.set "items"]
      val metadata : t -> Ojs.t Dict.t or_undefined [@@js.get "metadata"]
      val set_metadata : t -> Ojs.t Dict.t or_undefined -> unit [@@js.set "metadata"]]

  let make ~items ?metadata () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "NotebookCellOutput")
         (binding_arguments
            [| (Ojs.list_to_js NotebookCellOutputItem.t_to_js) items
             ; (or_undefined_to_js (Dict.t_to_js Ojs.t_to_js)) metadata
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module NotebookCellExecutionSummary = struct
  include Interface.Make ()

  type timing =
    { startTime : float
    ; endTime : float
    }

  let timing_to_js (value : timing) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "startTime" (Ojs.float_to_js value.startTime);
    Ojs.set_prop_ascii js_val "endTime" (Ojs.float_to_js value.endTime);
    js_val
  ;;

  let timing_of_js js_val : timing =
    { startTime = Ojs.float_of_js (Ojs.get_prop_ascii js_val "startTime")
    ; endTime = Ojs.float_of_js (Ojs.get_prop_ascii js_val "endTime")
    }
  ;;

  include
    [%js:
      val executionOrder : t -> int or_undefined [@@js.get "executionOrder"]
      val success : t -> bool or_undefined [@@js.get "success"]
      val timing : t -> timing or_undefined [@@js.get "timing"]]

  let create ?executionOrder ?success ?timing () =
    let obj = Ojs.obj [||] in
    iter_set obj "executionOrder" Ojs.int_to_js executionOrder;
    iter_set obj "success" Ojs.bool_to_js success;
    iter_set obj "timing" timing_to_js timing;
    t_of_js obj
  ;;
end

module NotebookCellData = struct
  include Class.Make ()

  include
    [%js:
      val kind : t -> NotebookCellKind.t [@@js.get "kind"]
      val set_kind : t -> NotebookCellKind.t -> unit [@@js.set "kind"]
      val value : t -> string [@@js.get "value"]
      val set_value : t -> string -> unit [@@js.set "value"]
      val languageId : t -> string [@@js.get "languageId"]
      val set_languageId : t -> string -> unit [@@js.set "languageId"]
      val outputs : t -> NotebookCellOutput.t list or_undefined [@@js.get "outputs"]

      val set_outputs : t -> NotebookCellOutput.t list or_undefined -> unit
      [@@js.set "outputs"]

      val metadata : t -> Ojs.t Dict.t or_undefined [@@js.get "metadata"]
      val set_metadata : t -> Ojs.t Dict.t or_undefined -> unit [@@js.set "metadata"]

      val executionSummary : t -> NotebookCellExecutionSummary.t or_undefined
      [@@js.get "executionSummary"]

      val set_executionSummary : t -> NotebookCellExecutionSummary.t or_undefined -> unit
      [@@js.set "executionSummary"]

      val make : kind:NotebookCellKind.t -> value:string -> languageId:string -> t
      [@@js.new "@vscode.NotebookCellData"]]
end

module NotebookEdit = struct
  include Class.Make ()

  include
    [%js:
      val replaceCells : range:NotebookRange.t -> newCells:NotebookCellData.t list -> t
      [@@js.global "@vscode.NotebookEdit.replaceCells"]

      val insertCells : index:int -> newCells:NotebookCellData.t list -> t
      [@@js.global "@vscode.NotebookEdit.insertCells"]

      val deleteCells : range:NotebookRange.t -> t
      [@@js.global "@vscode.NotebookEdit.deleteCells"]

      val updateCellMetadata : index:int -> newCellMetadata:Ojs.t Dict.t -> t
      [@@js.global "@vscode.NotebookEdit.updateCellMetadata"]

      val updateNotebookMetadata : newNotebookMetadata:Ojs.t Dict.t -> t
      [@@js.global "@vscode.NotebookEdit.updateNotebookMetadata"]

      val range : t -> NotebookRange.t [@@js.get "range"]
      val set_range : t -> NotebookRange.t -> unit [@@js.set "range"]
      val newCells : t -> NotebookCellData.t list [@@js.get "newCells"]
      val set_newCells : t -> NotebookCellData.t list -> unit [@@js.set "newCells"]
      val newCellMetadata : t -> Ojs.t Dict.t or_undefined [@@js.get "newCellMetadata"]

      val set_newCellMetadata : t -> Ojs.t Dict.t or_undefined -> unit
      [@@js.set "newCellMetadata"]

      val newNotebookMetadata : t -> Ojs.t Dict.t or_undefined
      [@@js.get "newNotebookMetadata"]

      val set_newNotebookMetadata : t -> Ojs.t Dict.t or_undefined -> unit
      [@@js.set "newNotebookMetadata"]

      val make : range:NotebookRange.t -> newCells:NotebookCellData.t list -> t
      [@@js.new "@vscode.NotebookEdit"]]
end

module WorkspaceEdit = struct
  include Class.Make ()

  type set_edits_item =
    [ `TextEdit of TextEdit.t
    | `SnippetTextEdit of SnippetTextEdit.t
    ]

  let set_edits_item_to_js = function
    | `TextEdit value -> TextEdit.t_to_js value
    | `SnippetTextEdit value -> SnippetTextEdit.t_to_js value
  ;;

  let set_edits_item_of_js js_val =
    match binding_constructor js_val [ "TextEdit"; "SnippetTextEdit" ] with
    | Some "TextEdit" -> `TextEdit (TextEdit.t_of_js js_val)
    | Some "SnippetTextEdit" -> `SnippetTextEdit (SnippetTextEdit.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "range"
        && binding_has_member js_val "newText"
      then `TextEdit (TextEdit.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "range"
        && binding_has_member js_val "snippet"
      then `SnippetTextEdit (SnippetTextEdit.t_of_js js_val)
      else invalid_arg "WorkspaceEdit.set_edits_item: unexpected JavaScript value"
  ;;

  type create_file_options_contents =
    [ `Uint8Array of Uint8Array.t
    | `DataTransferFile of DataTransferFile.t
    ]

  let create_file_options_contents_to_js = function
    | `Uint8Array value -> Uint8Array.t_to_js value
    | `DataTransferFile value -> DataTransferFile.t_to_js value
  ;;

  let create_file_options_contents_of_js js_val =
    if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then `Uint8Array (Uint8Array.t_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "name"
      && binding_has_member js_val "data"
    then `DataTransferFile (DataTransferFile.t_of_js js_val)
    else
      invalid_arg
        "WorkspaceEdit.create_file_options_contents: unexpected JavaScript value"
  ;;

  type create_file_options =
    { overwrite : bool or_undefined
    ; ignoreIfExists : bool or_undefined
    ; contents : create_file_options_contents or_undefined
    }

  let create_file_options_to_js (value : create_file_options) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "overwrite" Ojs.bool_to_js value.overwrite;
    iter_set js_val "ignoreIfExists" Ojs.bool_to_js value.ignoreIfExists;
    iter_set js_val "contents" create_file_options_contents_to_js value.contents;
    js_val
  ;;

  let create_file_options_of_js js_val : create_file_options =
    { overwrite =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "overwrite")
    ; ignoreIfExists =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "ignoreIfExists")
    ; contents =
        (or_undefined_of_js create_file_options_contents_of_js)
          (Ojs.get_prop_ascii js_val "contents")
    }
  ;;

  type delete_file_options =
    { recursive : bool or_undefined
    ; ignoreIfNotExists : bool or_undefined
    }

  let delete_file_options_to_js (value : delete_file_options) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "recursive" Ojs.bool_to_js value.recursive;
    iter_set js_val "ignoreIfNotExists" Ojs.bool_to_js value.ignoreIfNotExists;
    js_val
  ;;

  let delete_file_options_of_js js_val : delete_file_options =
    { recursive =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "recursive")
    ; ignoreIfNotExists =
        (or_undefined_of_js Ojs.bool_of_js)
          (Ojs.get_prop_ascii js_val "ignoreIfNotExists")
    }
  ;;

  type rename_file_options =
    { overwrite : bool or_undefined
    ; ignoreIfExists : bool or_undefined
    }

  let rename_file_options_to_js (value : rename_file_options) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "overwrite" Ojs.bool_to_js value.overwrite;
    iter_set js_val "ignoreIfExists" Ojs.bool_to_js value.ignoreIfExists;
    js_val
  ;;

  let rename_file_options_of_js js_val : rename_file_options =
    { overwrite =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "overwrite")
    ; ignoreIfExists =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "ignoreIfExists")
    }
  ;;

  include
    [%js:
      val size : t -> int [@@js.get "size"]
      val replace : t -> uri:Uri.t -> range:Range.t -> newText:string -> unit [@@js.call]
      val make : unit -> t [@@js.new "@vscode.WorkspaceEdit"]]

  let replaceWithMetadata this ~uri ~range ~newText ?metadata () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "replace"
         (binding_arguments
            [| Uri.t_to_js uri
             ; Range.t_to_js range
             ; Ojs.string_to_js newText
             ; (or_undefined_to_js WorkspaceEditEntryMetadata.t_to_js) metadata
            |]
            3
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let insert this ~uri ~position ~newText ?metadata () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "insert"
         (binding_arguments
            [| Uri.t_to_js uri
             ; Position.t_to_js position
             ; Ojs.string_to_js newText
             ; (or_undefined_to_js WorkspaceEditEntryMetadata.t_to_js) metadata
            |]
            3
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let delete this ~uri ~range ?metadata () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "delete"
         (binding_arguments
            [| Uri.t_to_js uri
             ; Range.t_to_js range
             ; (or_undefined_to_js WorkspaceEditEntryMetadata.t_to_js) metadata
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val has : t -> uri:Uri.t -> bool [@@js.call "has"]
      val set : t -> uri:Uri.t -> edits:set_edits_item list -> unit [@@js.call "set"]

      val setWithMetadata
        :  t
        -> uri:Uri.t
        -> edits:(set_edits_item * WorkspaceEditEntryMetadata.t or_undefined) list
        -> unit
      [@@js.call "set"]

      val setNotebookEdits : t -> uri:Uri.t -> edits:NotebookEdit.t list -> unit
      [@@js.call "set"]

      val setNotebookEditsWithMetadata
        :  t
        -> uri:Uri.t
        -> edits:(NotebookEdit.t * WorkspaceEditEntryMetadata.t or_undefined) list
        -> unit
      [@@js.call "set"]

      val get : t -> uri:Uri.t -> TextEdit.t list [@@js.call "get"]]

  let createFile this ~uri ?options ?metadata () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "createFile"
         (binding_arguments
            [| Uri.t_to_js uri
             ; (or_undefined_to_js create_file_options_to_js) options
             ; (or_undefined_to_js WorkspaceEditEntryMetadata.t_to_js) metadata
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let deleteFile this ~uri ?options ?metadata () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "deleteFile"
         (binding_arguments
            [| Uri.t_to_js uri
             ; (or_undefined_to_js delete_file_options_to_js) options
             ; (or_undefined_to_js WorkspaceEditEntryMetadata.t_to_js) metadata
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let renameFile this ~oldUri ~newUri ?options ?metadata () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "renameFile"
         (binding_arguments
            [| Uri.t_to_js oldUri
             ; Uri.t_to_js newUri
             ; (or_undefined_to_js rename_file_options_to_js) options
             ; (or_undefined_to_js WorkspaceEditEntryMetadata.t_to_js) metadata
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include [%js: val entries : t -> (Uri.t * TextEdit.t list) list [@@js.call "entries"]]
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
      val label : t -> string [@@js.get "label"]
      val role : t -> string or_undefined [@@js.get "role"]]

  let create ~label ?role () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "label" (Ojs.string_to_js label);
    iter_set obj "role" Ojs.string_to_js role;
    t_of_js obj
  ;;
end

module StatusBarItem = struct
  include Interface.Make ()

  type tooltip =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let tooltip_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let tooltip_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else invalid_arg "StatusBarItem.tooltip: unexpected JavaScript value"
  ;;

  type color_value =
    [ `String of string
    | `ThemeColor of ThemeColor.t
    ]

  let color_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `ThemeColor value -> ThemeColor.t_to_js value
  ;;

  let color_value_of_js js_val =
    match binding_constructor js_val [ "ThemeColor" ] with
    | Some "ThemeColor" -> `ThemeColor (ThemeColor.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "id"
      then `ThemeColor (ThemeColor.t_of_js js_val)
      else invalid_arg "StatusBarItem.color_value: unexpected JavaScript value"
  ;;

  type command_value =
    [ `String of string
    | `Command of Command.t
    ]

  let command_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Command value -> Command.t_to_js value
  ;;

  let command_value_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "title"
      && binding_has_member js_val "command"
    then `Command (Command.t_of_js js_val)
    else invalid_arg "StatusBarItem.command_value: unexpected JavaScript value"
  ;;

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
  ;;

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
  ;;

  include
    [%js:
      val alignment : t -> StatusBarAlignment.t [@@js.get "alignment"]
      val priority : t -> float or_undefined [@@js.get "priority"]
      val text : t -> string [@@js.get "text"]
      val tooltip : t -> tooltip or_undefined [@@js.get "tooltip"]
      val color : t -> color_value or_undefined [@@js.get "color"]
      val backgroundColor : t -> ThemeColor.t or_undefined [@@js.get "backgroundColor"]
      val command : t -> command_value or_undefined [@@js.get "command"]

      val accessibilityInformation : t -> AccessibilityInformation.t or_undefined
      [@@js.get "accessibilityInformation"]

      val set_text : t -> string -> unit [@@js.set "text"]
      val set_tooltip : t -> tooltip or_undefined -> unit [@@js.set "tooltip"]
      val set_color : t -> color_value or_undefined -> unit [@@js.set "color"]

      val set_backgroundColor : t -> ThemeColor.t or_undefined -> unit
      [@@js.set "backgroundColor"]

      val set_command : t -> command_value or_undefined -> unit [@@js.set "command"]

      val set_accessibilityInformation
        :  t
        -> AccessibilityInformation.t or_undefined
        -> unit
      [@@js.set "accessibilityInformation"]

      val show : t -> unit [@@js.call]
      val hide : t -> unit [@@js.call]
      val dispose : t -> unit [@@js.call]]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val name : t -> string or_undefined [@@js.get "name"]
      val set_name : t -> string or_undefined -> unit [@@js.set "name"]]
end

module WorkspaceFoldersChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val added : t -> WorkspaceFolder.t list [@@js.get "added"]
      val removed : t -> WorkspaceFolder.t list [@@js.get "removed"]]

  let create ~added ~removed () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "added" ((Ojs.list_to_js WorkspaceFolder.t_to_js) added);
    Ojs.set_prop_ascii obj "removed" ((Ojs.list_to_js WorkspaceFolder.t_to_js) removed);
    t_of_js obj
  ;;
end

module FormattingOptions = struct
  include Interface.Make ()

  type property =
    [ `Bool of bool
    | `Int of int
    | `String of string
    ]

  let property_to_js = function
    | `Bool value -> Ojs.bool_to_js value
    | `Int value -> Ojs.int_to_js value
    | `String value -> Ojs.string_to_js value
  ;;

  let property_of_js js_val =
    if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else if Ojs.type_of js_val = "number"
    then `Int (Ojs.int_of_js js_val)
    else if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else invalid_arg "FormattingOptions.property: unexpected JavaScript value"
  ;;

  include
    [%js:
      val tabSize : t -> int [@@js.get "tabSize"]
      val insertSpaces : t -> bool [@@js.get "insertSpaces"]
      val create : tabSize:int -> insertSpaces:bool -> t [@@js.builder]
      val set_tabSize : t -> int -> unit [@@js.set "tabSize"]
      val set_insertSpaces : t -> bool -> unit [@@js.set "insertSpaces"]]

  let getProperty this ~key =
    (or_undefined_of_js property_of_js)
      (Ojs.get_prop (t_to_js this) (Ojs.string_to_js key))
  ;;

  let setProperty this ~key ~value =
    Ojs.set_prop (t_to_js this) (Ojs.string_to_js key) (property_to_js value)
  ;;
end

module Event = struct
  type 'a t =
    listener:('a -> unit)
    -> ?thisArgs:Ojs.t
    -> ?disposables:Disposable.t list
    -> unit
    -> Disposable.t
  [@@js]

  module Make (T : Ojs.T) = struct
    type t =
      listener:(T.t -> unit)
      -> ?thisArgs:Ojs.t
      -> ?disposables:Disposable.t list
      -> unit
      -> Disposable.t
    [@@js]
  end

  let map event ~f ~listener ?thisArgs ?disposables () =
    event ~listener:(fun value -> listener (f value)) ?thisArgs ?disposables ()
  ;;
end

module EventEmitter = struct
  module G = Class.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val make : unit -> t [@@js.new "@vscode.EventEmitter"]
        val event : t -> T.t Event.t [@@js.get "event"]
        val fire : t -> T.t -> unit [@@js.call]
        val dispose : t -> unit -> unit [@@js.call]
        val set_event : t -> T.t Event.t -> unit [@@js.set "event"]]
  end
end

module CancellationToken = struct
  include Interface.Make ()

  include
    [%js:
      val isCancellationRequested : t -> bool [@@js.get "isCancellationRequested"]

      val onCancellationRequested : t -> Ojs.t Event.t
      [@@js.get "onCancellationRequested"]]

  include
    [%js:
      val set_isCancellationRequested : t -> bool -> unit
      [@@js.set "isCancellationRequested"]]

  let create ~isCancellationRequested ~onCancellationRequested () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "isCancellationRequested"
      (Ojs.bool_to_js isCancellationRequested);
    Ojs.set_prop_ascii
      obj
      "onCancellationRequested"
      ((Event.t_to_js Ojs.t_to_js) onCancellationRequested);
    t_of_js obj
  ;;
end

module QuickInputButtonLocation = struct
  type t =
    | Title [@js 1]
    | Inline [@js 2]
    | Input [@js 3]
  [@@js.enum] [@@js]
end

module QuickInputButtonToggle = struct
  include Interface.Make ()

  include
    [%js:
      val checked : t -> bool [@@js.get]
      val set_checked : t -> bool -> unit [@@js.set]
      val create : checked:bool -> t [@@js.builder]]
end

module QuickInputButton = struct
  include Interface.Make ()

  type toggle = { checked : bool }

  let toggle_to_js (value : toggle) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "checked" (Ojs.bool_to_js value.checked);
    js_val
  ;;

  let toggle_of_js js_val : toggle =
    { checked = Ojs.bool_of_js (Ojs.get_prop_ascii js_val "checked") }
  ;;

  type iconPath = IconPath.t [@@js]

  include
    [%js:
      val iconPath : t -> IconPath.t [@@js.get "iconPath"]
      val tooltip : t -> string or_undefined [@@js.get "tooltip"]
      val location : t -> QuickInputButtonLocation.t or_undefined [@@js.get "location"]
      val toggle : t -> toggle or_undefined [@@js.get "toggle"]

      val set_location : t -> QuickInputButtonLocation.t or_undefined -> unit
      [@@js.set "location"]]

  let create ~iconPath ?tooltip ?location ?toggle () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "iconPath" (IconPath.t_to_js iconPath);
    iter_set obj "tooltip" Ojs.string_to_js tooltip;
    iter_set obj "location" QuickInputButtonLocation.t_to_js location;
    iter_set obj "toggle" toggle_to_js toggle;
    t_of_js obj
  ;;
end

module QuickPickItemKind = struct
  type t =
    | Separator [@js -1]
    | Default [@js 0]
  [@@js.enum] [@@js]
end

module QuickPickItem = struct
  include Interface.Make ()

  include
    [%js:
      val label : t -> string [@@js.get "label"]
      val description : t -> string or_undefined [@@js.get "description"]
      val detail : t -> string or_undefined [@@js.get "detail"]
      val picked : t -> bool or_undefined [@@js.get "picked"]
      val alwaysShow : t -> bool or_undefined [@@js.get "alwaysShow"]
      val kind : t -> QuickPickItemKind.t or_undefined [@@js.get "kind"]
      val buttons : t -> QuickInputButton.t list or_undefined [@@js.get "buttons"]
      val resourceUri : t -> Uri.t or_undefined [@@js.get "resourceUri"]
      val iconPath : t -> IconPath.t or_undefined [@@js.get "iconPath"]]

  include
    [%js:
      val set_label : t -> string -> unit [@@js.set "label"]
      val set_kind : t -> QuickPickItemKind.t or_undefined -> unit [@@js.set "kind"]
      val set_iconPath : t -> IconPath.t or_undefined -> unit [@@js.set "iconPath"]
      val set_description : t -> string or_undefined -> unit [@@js.set "description"]
      val set_detail : t -> string or_undefined -> unit [@@js.set "detail"]
      val set_resourceUri : t -> Uri.t or_undefined -> unit [@@js.set "resourceUri"]
      val set_picked : t -> bool or_undefined -> unit [@@js.set "picked"]
      val set_alwaysShow : t -> bool or_undefined -> unit [@@js.set "alwaysShow"]

      val set_buttons : t -> QuickInputButton.t list or_undefined -> unit
      [@@js.set "buttons"]]

  let create
        ~label
        ?kind
        ?iconPath
        ?description
        ?detail
        ?resourceUri
        ?picked
        ?alwaysShow
        ?buttons
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "label" (Ojs.string_to_js label);
    iter_set obj "kind" QuickPickItemKind.t_to_js kind;
    iter_set obj "iconPath" IconPath.t_to_js iconPath;
    iter_set obj "description" Ojs.string_to_js description;
    iter_set obj "detail" Ojs.string_to_js detail;
    iter_set obj "resourceUri" Uri.t_to_js resourceUri;
    iter_set obj "picked" Ojs.bool_to_js picked;
    iter_set obj "alwaysShow" Ojs.bool_to_js alwaysShow;
    iter_set obj "buttons" (Ojs.list_to_js QuickInputButton.t_to_js) buttons;
    t_of_js obj
  ;;
end

module QuickPickOptions = struct
  include Interface.Make ()

  type on_did_select_item_arg0 =
    [ `QuickPickItem of QuickPickItem.t
    | `String of string
    ]

  let on_did_select_item_arg0_to_js = function
    | `QuickPickItem value -> QuickPickItem.t_to_js value
    | `String value -> Ojs.string_to_js value
  ;;

  let on_did_select_item_arg0_of_js js_val =
    if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "label"
    then `QuickPickItem (QuickPickItem.t_of_js js_val)
    else if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else
      invalid_arg "QuickPickOptions.on_did_select_item_arg0: unexpected JavaScript value"
  ;;

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
  ;;

  include
    [%js:
      val title : t -> string or_undefined [@@js.get "title"]
      val matchOnDescription : t -> bool or_undefined [@@js.get "matchOnDescription"]
      val matchOnDetail : t -> bool or_undefined [@@js.get "matchOnDetail"]
      val placeHolder : t -> string or_undefined [@@js.get "placeHolder"]
      val prompt : t -> string or_undefined [@@js.get "prompt"]
      val ignoreFocusOut : t -> bool or_undefined [@@js.get "ignoreFocusOut"]
      val canPickMany : t -> bool or_undefined [@@js.get "canPickMany"]]

  include
    [%js:
      val set_title : t -> string or_undefined -> unit [@@js.set "title"]

      val set_matchOnDescription : t -> bool or_undefined -> unit
      [@@js.set "matchOnDescription"]

      val set_matchOnDetail : t -> bool or_undefined -> unit [@@js.set "matchOnDetail"]
      val set_placeHolder : t -> string or_undefined -> unit [@@js.set "placeHolder"]
      val set_prompt : t -> string or_undefined -> unit [@@js.set "prompt"]
      val set_ignoreFocusOut : t -> bool or_undefined -> unit [@@js.set "ignoreFocusOut"]
      val set_canPickMany : t -> bool or_undefined -> unit [@@js.set "canPickMany"]]

  let onDidSelectItem this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "onDidSelectItem" in
    if Ojs.is_null callback
    then None
    else
      Some
        ([%js.to: item:on_did_select_item_arg0 -> Ojs.t]
           (Ojs.call callback "bind" [| this |]))
  ;;

  let create
        ?title
        ?matchOnDescription
        ?matchOnDetail
        ?placeHolder
        ?prompt
        ?ignoreFocusOut
        ?canPickMany
        ?onDidSelectItem
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set obj "title" Ojs.string_to_js title;
    iter_set obj "matchOnDescription" Ojs.bool_to_js matchOnDescription;
    iter_set obj "matchOnDetail" Ojs.bool_to_js matchOnDetail;
    iter_set obj "placeHolder" Ojs.string_to_js placeHolder;
    iter_set obj "prompt" Ojs.string_to_js prompt;
    iter_set obj "ignoreFocusOut" Ojs.bool_to_js ignoreFocusOut;
    iter_set obj "canPickMany" Ojs.bool_to_js canPickMany;
    iter_set
      obj
      "onDidSelectItem"
      [%js.of: item:on_did_select_item_arg0 -> Ojs.t]
      onDidSelectItem;
    t_of_js obj
  ;;
end

module QuickPickItemButtonEvent = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val button : t -> QuickInputButton.t [@@js.get "button"]
        val item : t -> T.t [@@js.get "item"]]

    let create ~button ~item () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii obj "button" (QuickInputButton.t_to_js button);
      Ojs.set_prop_ascii obj "item" (T.t_to_js item);
      t_of_js obj
    ;;
  end
end

module QuickInput = struct
  include Interface.Make ()

  include
    [%js:
      val title : t -> string or_undefined [@@js.get "title"]
      val set_title : t -> string or_undefined -> unit [@@js.set "title"]
      val step : t -> int or_undefined [@@js.get "step"]
      val set_step : t -> int or_undefined -> unit [@@js.set "step"]
      val totalSteps : t -> int or_undefined [@@js.get "totalSteps"]
      val set_totalSteps : t -> int or_undefined -> unit [@@js.set "totalSteps"]
      val enabled : t -> bool [@@js.get "enabled"]
      val set_enabled : t -> bool -> unit [@@js.set "enabled"]
      val busy : t -> bool [@@js.get "busy"]
      val set_busy : t -> bool -> unit [@@js.set "busy"]
      val ignoreFocusOut : t -> bool [@@js.get "ignoreFocusOut"]
      val set_ignoreFocusOut : t -> bool -> unit [@@js.set "ignoreFocusOut"]
      val show : t -> unit [@@js.call "show"]
      val hide : t -> unit [@@js.call "hide"]
      val onDidHide : t -> unit Event.t [@@js.get "onDidHide"]
      val dispose : t -> unit [@@js.call "dispose"]]
end

module QuickPick = struct
  module G = Interface.Generic (QuickInput) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val onDidAccept : t -> unit Event.t [@@js.get "onDidAccept"]
        val onDidChangeActive : t -> T.t list Event.t [@@js.get "onDidChangeActive"]
        val onDidChangeSelection : t -> T.t list Event.t [@@js.get "onDidChangeSelection"]
        val onDidChangeValue : t -> string Event.t [@@js.get "onDidChangeValue"]
        val onDidHide : t -> unit Event.t [@@js.get "onDidHide"]

        val onDidTriggerButton : t -> QuickInputButton.t Event.t
        [@@js.get "onDidTriggerButton"]

        val activeItems : t -> T.t list [@@js.get "activeItems"]
        val set_activeItems : t -> T.t list -> unit [@@js.set "activeItems"]
        val busy : t -> bool [@@js.get "busy"]
        val set_busy : t -> bool -> unit [@@js.set "busy"]
        val buttons : t -> QuickInputButton.t list [@@js.get "buttons"]
        val set_buttons : t -> QuickInputButton.t list -> unit [@@js.set "buttons"]
        val canSelectMany : t -> bool [@@js.get "canSelectMany"]
        val set_canSelectMany : t -> bool -> unit [@@js.set "canSelectMany"]
        val enabled : t -> bool [@@js.get "enabled"]
        val set_enabled : t -> bool -> unit [@@js.set "enabled"]
        val ignoreFocusOut : t -> bool [@@js.get "ignoreFocusOut"]
        val set_ignoreFocusOut : t -> bool -> unit [@@js.set "ignoreFocusOut"]
        val items : t -> T.t list [@@js.get "items"]
        val set_items : t -> T.t list -> unit [@@js.set "items"]
        val keepScrollPosition : t -> bool or_undefined [@@js.get "keepScrollPosition"]

        val set_keepScrollPosition : t -> bool or_undefined -> unit
        [@@js.set "keepScrollPosition"]

        val matchOnDescription : t -> bool [@@js.get "matchOnDescription"]
        val set_matchOnDescription : t -> bool -> unit [@@js.set "matchOnDescription"]
        val matchOnDetail : t -> bool [@@js.get "matchOnDetail"]
        val set_matchOnDetail : t -> bool -> unit [@@js.set "matchOnDetail"]
        val placeholder : t -> string or_undefined [@@js.get "placeholder"]
        val prompt : t -> string or_undefined [@@js.get "prompt"]
        val set_prompt : t -> string or_undefined -> unit [@@js.set "prompt"]
        val set_placeholder : t -> string or_undefined -> unit [@@js.set "placeholder"]
        val selectedItems : t -> T.t list [@@js.get "selectedItems"]
        val set_selectedItems : t -> T.t list -> unit [@@js.set "selectedItems"]
        val step : t -> int or_undefined [@@js.get "step"]
        val set_step : t -> int or_undefined -> unit [@@js.set "step"]
        val title : t -> string or_undefined [@@js.get "title"]
        val set_title : t -> string or_undefined -> unit [@@js.set "title"]
        val totalSteps : t -> int or_undefined [@@js.get "totalSteps"]
        val set_totalSteps : t -> int or_undefined -> unit [@@js.set "totalSteps"]
        val value : t -> string [@@js.get "value"]
        val set_value : t -> string -> unit [@@js.set "value"]
        val dispose : t -> unit [@@js.call]
        val hide : t -> unit [@@js.call]
        val show : t -> unit [@@js.call]]

    let set
          t
          ?activeItems
          ?busy
          ?buttons
          ?canSelectMany
          ?enabled
          ?ignoreFocusOut
          ?items
          ?keepScrollPosition
          ?matchOnDescription
          ?matchOnDetail
          ?placeholder
          ?prompt
          ?selectedItems
          ?step
          ?title
          ?totalSteps
          ?value
          ()
      =
      Option.iter (fun value -> set_activeItems t value) activeItems;
      Option.iter (fun value -> set_busy t value) busy;
      Option.iter (fun value -> set_buttons t value) buttons;
      Option.iter (fun value -> set_canSelectMany t value) canSelectMany;
      Option.iter (fun value -> set_enabled t value) enabled;
      Option.iter (fun value -> set_ignoreFocusOut t value) ignoreFocusOut;
      Option.iter (fun value -> set_items t value) items;
      set_keepScrollPosition t keepScrollPosition;
      Option.iter (fun value -> set_matchOnDescription t value) matchOnDescription;
      Option.iter (fun value -> set_matchOnDetail t value) matchOnDetail;
      set_placeholder t placeholder;
      set_prompt t prompt;
      Option.iter (fun value -> set_selectedItems t value) selectedItems;
      set_step t step;
      set_title t title;
      set_totalSteps t totalSteps;
      Option.iter (fun value -> set_value t value) value;
      t
    ;;

    include
      [%js:
        val onDidTriggerItemButton : t -> T.t QuickPickItemButtonEvent.t Event.t
        [@@js.get "onDidTriggerItemButton"]]
  end

  let to_quick_input (type a) (value : a t) = (value :> QuickInput.t)
end

module ProviderResult = struct
  type 'a t =
    [ `Value of 'a or_undefined
    | `Promise of 'a or_undefined Promise.t
    ]

  let t_to_js ml_to_js = function
    | `Value v -> or_undefined_to_js ml_to_js v
    | `Promise p -> Promise.t_to_js (or_undefined_to_js ml_to_js) p
  ;;

  let t_of_js ml_of_js js_val =
    let value_of_js value = if Ojs.is_null value then None else Some (ml_of_js value) in
    if binding_is_thenable js_val
    then `Promise (Promise.t_of_js value_of_js js_val)
    else `Value (or_undefined_of_js ml_of_js js_val)
  ;;
end

module InputBoxValidationSeverity = struct
  type t =
    | Info [@js 1]
    | Warning [@js 2]
    | Error [@js 3]
  [@@js.enum] [@@js]
end

module InputBoxValidationMessage = struct
  include Interface.Make ()

  include
    [%js:
      val message : t -> string [@@js.get "message"]
      val severity : t -> InputBoxValidationSeverity.t [@@js.get "severity"]]

  let create ~message ~severity () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "message" (Ojs.string_to_js message);
    Ojs.set_prop_ascii obj "severity" (InputBoxValidationSeverity.t_to_js severity);
    t_of_js obj
  ;;
end

module InputBoxOptions = struct
  include Interface.Make ()

  type validate_input_result_value =
    [ `String of string
    | `InputBoxValidationMessage of InputBoxValidationMessage.t
    ]

  let validate_input_result_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `InputBoxValidationMessage value -> InputBoxValidationMessage.t_to_js value
  ;;

  let validate_input_result_value_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "message"
      && binding_has_member js_val "severity"
    then `InputBoxValidationMessage (InputBoxValidationMessage.t_of_js js_val)
    else
      invalid_arg
        "InputBoxOptions.validate_input_result_value: unexpected JavaScript value"
  ;;

  include
    [%js:
      val title : t -> string or_undefined [@@js.get "title"]
      val value : t -> string or_undefined [@@js.get "value"]
      val valueSelection : t -> (int * int) or_undefined [@@js.get "valueSelection"]
      val prompt : t -> string or_undefined [@@js.get "prompt"]
      val placeHolder : t -> string or_undefined [@@js.get "placeHolder"]
      val password : t -> bool or_undefined [@@js.get "password"]
      val ignoreFocusOut : t -> bool or_undefined [@@js.get "ignoreFocusOut"]]

  include
    [%js:
      val set_title : t -> string or_undefined -> unit [@@js.set "title"]
      val set_value : t -> string or_undefined -> unit [@@js.set "value"]

      val set_valueSelection : t -> (int * int) or_undefined -> unit
      [@@js.set "valueSelection"]

      val set_prompt : t -> string or_undefined -> unit [@@js.set "prompt"]
      val set_placeHolder : t -> string or_undefined -> unit [@@js.set "placeHolder"]
      val set_password : t -> bool or_undefined -> unit [@@js.set "password"]
      val set_ignoreFocusOut : t -> bool or_undefined -> unit [@@js.set "ignoreFocusOut"]]

  let validateInput this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "validateInput" in
    if Ojs.is_null callback
    then None
    else
      Some
        ([%js.to: value:string -> validate_input_result_value ProviderResult.t]
           (Ojs.call callback "bind" [| this |]))
  ;;

  let create
        ?title
        ?value
        ?valueSelection
        ?prompt
        ?placeHolder
        ?password
        ?ignoreFocusOut
        ?validateInput
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set obj "title" Ojs.string_to_js title;
    iter_set obj "value" Ojs.string_to_js value;
    iter_set
      obj
      "valueSelection"
      (fun (v0, v1) ->
         Ojs.array_to_js Ojs.t_to_js [| Ojs.int_to_js v0; Ojs.int_to_js v1 |])
      valueSelection;
    iter_set obj "prompt" Ojs.string_to_js prompt;
    iter_set obj "placeHolder" Ojs.string_to_js placeHolder;
    iter_set obj "password" Ojs.bool_to_js password;
    iter_set obj "ignoreFocusOut" Ojs.bool_to_js ignoreFocusOut;
    iter_set
      obj
      "validateInput"
      [%js.of: value:string -> validate_input_result_value ProviderResult.t]
      validateInput;
    t_of_js obj
  ;;
end

module InputBox = struct
  include Interface.Extend (QuickInput) ()

  type validation_message =
    [ `String of string
    | `InputBoxValidationMessage of InputBoxValidationMessage.t
    ]

  let validation_message_to_js = function
    | `String value -> Ojs.string_to_js value
    | `InputBoxValidationMessage value -> InputBoxValidationMessage.t_to_js value
  ;;

  let validation_message_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "message"
      && binding_has_member js_val "severity"
    then `InputBoxValidationMessage (InputBoxValidationMessage.t_of_js js_val)
    else invalid_arg "InputBox.validation_message: unexpected JavaScript value"
  ;;

  include
    [%js:
      val title : t -> string or_undefined [@@js.get "title"]
      val set_title : t -> string or_undefined -> unit [@@js.set "title"]
      val enabled : t -> bool [@@js.get "enabled"]
      val set_enabled : t -> bool -> unit [@@js.set "enabled"]
      val busy : t -> bool [@@js.get "busy"]
      val set_busy : t -> bool -> unit [@@js.set "busy"]
      val ignoreFocusOut : t -> bool [@@js.get "ignoreFocusOut"]
      val set_ignoreFocusOut : t -> bool -> unit [@@js.set "ignoreFocusOut"]
      val onDidHide : t -> unit Event.t [@@js.get "onDidHide"]
      val value : t -> string [@@js.get "value"]
      val set_value : t -> string -> unit [@@js.set "value"]
      val valueSelection : t -> (int * int) or_undefined [@@js.get "valueSelection"]

      val set_valueSelection : t -> (int * int) or_undefined -> unit
      [@@js.set "valueSelection"]

      val placeholder : t -> string or_undefined [@@js.get "placeholder"]
      val set_placeholder : t -> string or_undefined -> unit [@@js.set "placeholder"]
      val password : t -> bool [@@js.get "password"]
      val set_password : t -> bool -> unit [@@js.set "password"]
      val onDidChangeValue : t -> string Event.t [@@js.get "onDidChangeValue"]
      val onDidAccept : t -> unit Event.t [@@js.get "onDidAccept"]
      val prompt : t -> string or_undefined [@@js.get "prompt"]
      val set_prompt : t -> string or_undefined -> unit [@@js.set "prompt"]

      val validationMessage : t -> validation_message or_undefined
      [@@js.get "validationMessage"]

      val set_validationMessage : t -> validation_message or_undefined -> unit
      [@@js.set "validationMessage"]

      val show : t -> unit [@@js.call]]

  let set
        t
        ?title
        ?ignoreFocusOut
        ?value
        ?valueSelection
        ?placeholder
        ?password
        ?prompt
        ?validationMessage
        ()
    =
    set_title t title;
    Option.iter (fun value -> set_ignoreFocusOut t value) ignoreFocusOut;
    Option.iter (fun value -> set_value t value) value;
    set_valueSelection t valueSelection;
    set_placeholder t placeholder;
    Option.iter (fun value -> set_password t value) password;
    set_prompt t prompt;
    set_validationMessage t validationMessage;
    t
  ;;

  let to_quick_input (value : t) = (value :> QuickInput.t)

  include
    [%js:
      val step : t -> int or_undefined [@@js.get "step"]
      val set_step : t -> int or_undefined -> unit [@@js.set "step"]
      val totalSteps : t -> int or_undefined [@@js.get "totalSteps"]
      val set_totalSteps : t -> int or_undefined -> unit [@@js.set "totalSteps"]
      val hide : t -> unit [@@js.call "hide"]
      val dispose : t -> unit [@@js.call "dispose"]
      val buttons : t -> QuickInputButton.t list [@@js.get "buttons"]
      val set_buttons : t -> QuickInputButton.t list -> unit [@@js.set "buttons"]

      val onDidTriggerButton : t -> QuickInputButton.t Event.t
      [@@js.get "onDidTriggerButton"]]
end

module OpenDialogOptions = struct
  include Interface.Make ()

  include
    [%js:
      val defaultUri : t -> Uri.t or_undefined [@@js.get "defaultUri"]
      val set_defaultUri : t -> Uri.t or_undefined -> unit [@@js.set "defaultUri"]
      val openLabel : t -> string or_undefined [@@js.get "openLabel"]
      val set_openLabel : t -> string or_undefined -> unit [@@js.set "openLabel"]
      val canSelectFiles : t -> bool or_undefined [@@js.get "canSelectFiles"]
      val set_canSelectFiles : t -> bool or_undefined -> unit [@@js.set "canSelectFiles"]
      val canSelectFolders : t -> bool or_undefined [@@js.get "canSelectFolders"]

      val set_canSelectFolders : t -> bool or_undefined -> unit
      [@@js.set "canSelectFolders"]

      val canSelectMany : t -> bool or_undefined [@@js.get "canSelectMany"]
      val set_canSelectMany : t -> bool or_undefined -> unit [@@js.set "canSelectMany"]
      val filters : t -> string list Dict.t or_undefined [@@js.get "filters"]
      val set_filters : t -> string list Dict.t or_undefined -> unit [@@js.set "filters"]
      val title : t -> string or_undefined [@@js.get "title"]
      val set_title : t -> string or_undefined -> unit [@@js.set "title"]]

  let create
        ?defaultUri
        ?openLabel
        ?canSelectFiles
        ?canSelectFolders
        ?canSelectMany
        ?filters
        ?title
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set obj "defaultUri" Uri.t_to_js defaultUri;
    iter_set obj "openLabel" Ojs.string_to_js openLabel;
    iter_set obj "canSelectFiles" Ojs.bool_to_js canSelectFiles;
    iter_set obj "canSelectFolders" Ojs.bool_to_js canSelectFolders;
    iter_set obj "canSelectMany" Ojs.bool_to_js canSelectMany;
    iter_set obj "filters" (Dict.t_to_js (Ojs.list_to_js Ojs.string_to_js)) filters;
    iter_set obj "title" Ojs.string_to_js title;
    t_of_js obj
  ;;
end

module MessageItem = struct
  include Interface.Make ()

  include
    [%js:
      val title : t -> string [@@js.get "title"]
      val isCloseAffordance : t -> bool or_undefined [@@js.get "isCloseAffordance"]]

  include
    [%js:
      val set_title : t -> string -> unit [@@js.set "title"]

      val set_isCloseAffordance : t -> bool or_undefined -> unit
      [@@js.set "isCloseAffordance"]]

  let create ~title ?isCloseAffordance () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "title" (Ojs.string_to_js title);
    iter_set obj "isCloseAffordance" Ojs.bool_to_js isCloseAffordance;
    t_of_js obj
  ;;
end

module Location = struct
  include Class.Make ()

  include
    [%js:
      val uri : t -> Uri.t [@@js.get "uri"]
      val range : t -> Range.t [@@js.get "range"]

      val make
        :  uri:Uri.t
        -> rangeOrPosition:([ `Range of Range.t | `Position of Position.t ][@js.union])
        -> t
      [@@js.new "@vscode.Location"]

      val set_uri : t -> Uri.t -> unit [@@js.set "uri"]
      val set_range : t -> Range.t -> unit [@@js.set "range"]]
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

  type location_item = { viewId : string }

  let location_item_to_js (value : location_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "viewId" (Ojs.string_to_js value.viewId);
    js_val
  ;;

  let location_item_of_js js_val : location_item =
    { viewId = Ojs.string_of_js (Ojs.get_prop_ascii js_val "viewId") }
  ;;

  type location_value =
    [ `ProgressLocation of ProgressLocation.t
    | `Options of location_item
    ]

  let location_value_to_js = function
    | `ProgressLocation value -> ProgressLocation.t_to_js value
    | `Options value -> location_item_to_js value
  ;;

  let location_value_of_js js_val =
    if Ojs.type_of js_val = "number"
    then `ProgressLocation (ProgressLocation.t_of_js js_val)
    else if
      (Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "viewId"
    then `Options (location_item_of_js js_val)
    else invalid_arg "ProgressOptions.location_value: unexpected JavaScript value"
  ;;

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
  ;;

  include
    [%js:
      val location : t -> location_value [@@js.get "location"]
      val title : t -> string or_undefined [@@js.get "title"]
      val cancellable : t -> bool or_undefined [@@js.get "cancellable"]]

  include
    [%js:
      val set_location : t -> location_value -> unit [@@js.set "location"]
      val set_title : t -> string or_undefined -> unit [@@js.set "title"]
      val set_cancellable : t -> bool or_undefined -> unit [@@js.set "cancellable"]]

  let create ~location ?title ?cancellable () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "location" (location_value_to_js location);
    iter_set obj "title" Ojs.string_to_js title;
    iter_set obj "cancellable" Ojs.bool_to_js cancellable;
    t_of_js obj
  ;;
end

module DiagnosticSeverity = struct
  type t =
    | Error [@js 0]
    | Warning [@js 1]
    | Information [@js 2]
    | Hint [@js 3]
  [@@js.enum] [@@js]
end

module DiagnosticRelatedInformation = struct
  include Class.Make ()

  include
    [%js:
      val location : t -> Location.t [@@js.get "location"]
      val message : t -> string [@@js.get "message"]

      val make : location:Location.t -> message:string -> t
      [@@js.new "@vscode.DiagnosticRelatedInformation"]

      val set_location : t -> Location.t -> unit [@@js.set "location"]
      val set_message : t -> string -> unit [@@js.set "message"]]
end

module DiagnosticTag = struct
  type t =
    | Unnecessary [@js 1]
    | Deprecated [@js 2]
  [@@js.enum] [@@js]
end

module Diagnostic = struct
  include Class.Make ()

  type code_item_value =
    [ `String of string
    | `Int of int
    ]

  let code_item_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Int value -> Ojs.int_to_js value
  ;;

  let code_item_value_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if Ojs.type_of js_val = "number"
    then `Int (Ojs.int_of_js js_val)
    else invalid_arg "Diagnostic.code_item_value: unexpected JavaScript value"
  ;;

  type code_item =
    { value : code_item_value
    ; target : Uri.t
    }

  let code_item_to_js (value : code_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "value" (code_item_value_to_js value.value);
    Ojs.set_prop_ascii js_val "target" (Uri.t_to_js value.target);
    js_val
  ;;

  let code_item_of_js js_val : code_item =
    { value = code_item_value_of_js (Ojs.get_prop_ascii js_val "value")
    ; target = Uri.t_of_js (Ojs.get_prop_ascii js_val "target")
    }
  ;;

  type code_value =
    [ `String of string
    | `Int of int
    | `Options of code_item
    ]

  let code_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Int value -> Ojs.int_to_js value
    | `Options value -> code_item_to_js value
  ;;

  let code_value_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if Ojs.type_of js_val = "number"
    then `Int (Ojs.int_of_js js_val)
    else if
      (Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "value"
      && binding_has_member js_val "target"
    then `Options (code_item_of_js js_val)
    else invalid_arg "Diagnostic.code_value: unexpected JavaScript value"
  ;;

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
  ;;

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
  ;;

  include
    [%js:
      val message : t -> string [@@js.get "message"]
      val range : t -> Range.t [@@js.get "range"]
      val severity : t -> DiagnosticSeverity.t [@@js.get "severity"]
      val source : t -> string or_undefined [@@js.get "source"]
      val code : t -> code_value or_undefined [@@js.get "code"]

      val relatedInformation : t -> DiagnosticRelatedInformation.t list or_undefined
      [@@js.get "relatedInformation"]

      val tags : t -> DiagnosticTag.t list or_undefined [@@js.get "tags"]

      val make
        :  range:Range.t
        -> message:string
        -> ?severity:DiagnosticSeverity.t
        -> unit
        -> t
      [@@js.new "@vscode.Diagnostic"]]

  let make ?severity ~message range = make ~range ~message ?severity ()

  include
    [%js:
      val set_range : t -> Range.t -> unit [@@js.set "range"]
      val set_message : t -> string -> unit [@@js.set "message"]
      val set_severity : t -> DiagnosticSeverity.t -> unit [@@js.set "severity"]
      val set_source : t -> string or_undefined -> unit [@@js.set "source"]
      val set_code : t -> code_value or_undefined -> unit [@@js.set "code"]

      val set_relatedInformation
        :  t
        -> DiagnosticRelatedInformation.t list or_undefined
        -> unit
      [@@js.set "relatedInformation"]

      val set_tags : t -> DiagnosticTag.t list or_undefined -> unit [@@js.set "tags"]]
end

module TextDocumentShowOptions = struct
  include Interface.Make ()

  include
    [%js:
      val viewColumn : t -> ViewColumn.t or_undefined [@@js.get "viewColumn"]
      val preserveFocus : t -> bool or_undefined [@@js.get "preserveFocus"]
      val preview : t -> bool or_undefined [@@js.get "preview"]
      val selection : t -> Range.t or_undefined [@@js.get "selection"]]

  include
    [%js:
      val set_viewColumn : t -> ViewColumn.t or_undefined -> unit [@@js.set "viewColumn"]
      val set_preserveFocus : t -> bool or_undefined -> unit [@@js.set "preserveFocus"]
      val set_preview : t -> bool or_undefined -> unit [@@js.set "preview"]
      val set_selection : t -> Range.t or_undefined -> unit [@@js.set "selection"]]

  let create ?viewColumn ?preserveFocus ?preview ?selection () =
    let obj = Ojs.obj [||] in
    iter_set obj "viewColumn" ViewColumn.t_to_js viewColumn;
    iter_set obj "preserveFocus" Ojs.bool_to_js preserveFocus;
    iter_set obj "preview" Ojs.bool_to_js preview;
    iter_set obj "selection" Range.t_to_js selection;
    t_of_js obj
  ;;
end

module TerminalLocation = struct
  type t =
    | Panel [@js 1]
    | Editor [@js 2]
  [@@js.enum] [@@js]
end

module TerminalEditorLocationOptions = struct
  include Interface.Make ()

  include
    [%js:
      val viewColumn : t -> ViewColumn.t [@@js.get "viewColumn"]
      val set_viewColumn : t -> ViewColumn.t -> unit [@@js.set "viewColumn"]
      val preserveFocus : t -> bool or_undefined [@@js.get "preserveFocus"]
      val set_preserveFocus : t -> bool or_undefined -> unit [@@js.set "preserveFocus"]]

  let create ~viewColumn ?preserveFocus () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "viewColumn" (ViewColumn.t_to_js viewColumn);
    iter_set obj "preserveFocus" Ojs.bool_to_js preserveFocus;
    t_of_js obj
  ;;
end

module TerminalDimensions = struct
  include Interface.Make ()

  include
    [%js:
      val columns : t -> int [@@js.get "columns"]
      val rows : t -> int [@@js.get "rows"]]

  let create ~columns ~rows () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "columns" (Ojs.int_to_js columns);
    Ojs.set_prop_ascii obj "rows" (Ojs.int_to_js rows);
    t_of_js obj
  ;;
end

module Pseudoterminal = struct
  include Interface.Make ()

  type on_did_close_t =
    [ `Unit of unit
    | `Int of int
    ]

  let on_did_close_t_to_js = function
    | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
    | `Int value -> Ojs.int_to_js value
  ;;

  let on_did_close_t_of_js js_val =
    if Ojs.is_null js_val
    then `Unit ((fun _ -> ()) js_val)
    else if Ojs.type_of js_val = "number"
    then `Int (Ojs.int_of_js js_val)
    else invalid_arg "Pseudoterminal.on_did_close_t: unexpected JavaScript value"
  ;;

  include
    [%js:
      val onDidWrite : t -> string Event.t [@@js.get "onDidWrite"]

      val onDidOverrideDimensions
        :  t
        -> TerminalDimensions.t or_undefined Event.t or_undefined
      [@@js.get "onDidOverrideDimensions"]

      val onDidClose : t -> on_did_close_t Event.t or_undefined [@@js.get "onDidClose"]
      val close : t -> unit [@@js.call]]

  include
    [%js:
      val set_onDidWrite : t -> string Event.t -> unit [@@js.set "onDidWrite"]

      val set_onDidOverrideDimensions
        :  t
        -> TerminalDimensions.t or_undefined Event.t or_undefined
        -> unit
      [@@js.set "onDidOverrideDimensions"]

      val set_onDidClose : t -> on_did_close_t Event.t or_undefined -> unit
      [@@js.set "onDidClose"]

      val onDidChangeName : t -> string Event.t or_undefined [@@js.get "onDidChangeName"]

      val set_onDidChangeName : t -> string Event.t or_undefined -> unit
      [@@js.set "onDidChangeName"]

      val open_ : t -> initialDimensions:TerminalDimensions.t or_undefined -> unit
      [@@js.call "open"]]

  let handleInput this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "handleInput" in
    if Ojs.is_null callback
    then None
    else Some ([%js.to: data:string -> unit] (Ojs.call callback "bind" [| this |]))
  ;;

  let setDimensions this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "setDimensions" in
    if Ojs.is_null callback
    then None
    else
      Some
        ([%js.to: dimensions:TerminalDimensions.t -> unit]
           (Ojs.call callback "bind" [| this |]))
  ;;

  let create
        ~onDidWrite
        ?onDidOverrideDimensions
        ?onDidClose
        ?onDidChangeName
        ~open_
        ~close
        ?handleInput
        ?setDimensions
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "onDidWrite" ((Event.t_to_js Ojs.string_to_js) onDidWrite);
    iter_set
      obj
      "onDidOverrideDimensions"
      (Event.t_to_js (or_undefined_to_js TerminalDimensions.t_to_js))
      onDidOverrideDimensions;
    iter_set obj "onDidClose" (Event.t_to_js on_did_close_t_to_js) onDidClose;
    iter_set obj "onDidChangeName" (Event.t_to_js Ojs.string_to_js) onDidChangeName;
    Ojs.set_prop_ascii
      obj
      "open"
      ([%js.of: initialDimensions:TerminalDimensions.t or_undefined -> unit] open_);
    Ojs.set_prop_ascii obj "close" ([%js.of: unit -> unit] close);
    iter_set obj "handleInput" [%js.of: data:string -> unit] handleInput;
    iter_set
      obj
      "setDimensions"
      [%js.of: dimensions:TerminalDimensions.t -> unit]
      setDimensions;
    t_of_js obj
  ;;
end

module TerminalExitReason = struct
  type t =
    | Unknown [@js 0]
    | Shutdown [@js 1]
    | Process [@js 2]
    | User [@js 3]
    | Extension [@js 4]
  [@@js.enum] [@@js]
end

module TerminalExitStatus = struct
  include Interface.Make ()

  include
    [%js:
      val code : t -> int or_undefined [@@js.get "code"]
      val reason : t -> TerminalExitReason.t [@@js.get "reason"]]

  let create ~code ~reason () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "code" ((or_undefined_to_js Ojs.int_to_js) code);
    Ojs.set_prop_ascii obj "reason" (TerminalExitReason.t_to_js reason);
    t_of_js obj
  ;;
end

module TerminalState = struct
  include Interface.Make ()

  include
    [%js:
      val isInteractedWith : t -> bool [@@js.get "isInteractedWith"]
      val shell : t -> string or_undefined [@@js.get "shell"]]

  let create ~isInteractedWith ~shell () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "isInteractedWith" (Ojs.bool_to_js isInteractedWith);
    Ojs.set_prop_ascii obj "shell" ((or_undefined_to_js Ojs.string_to_js) shell);
    t_of_js obj
  ;;
end

module TerminalShellExecutionCommandLineConfidence = struct
  type t =
    | Low [@js 0]
    | Medium [@js 1]
    | High [@js 2]
  [@@js.enum] [@@js]
end

module TerminalShellExecutionCommandLine = struct
  include Interface.Make ()

  include
    [%js:
      val value : t -> string [@@js.get "value"]
      val isTrusted : t -> bool [@@js.get "isTrusted"]

      val confidence : t -> TerminalShellExecutionCommandLineConfidence.t
      [@@js.get "confidence"]]

  let create ~value ~isTrusted ~confidence () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "value" (Ojs.string_to_js value);
    Ojs.set_prop_ascii obj "isTrusted" (Ojs.bool_to_js isTrusted);
    Ojs.set_prop_ascii
      obj
      "confidence"
      (TerminalShellExecutionCommandLineConfidence.t_to_js confidence);
    t_of_js obj
  ;;
end

module IteratorResult = struct
  type 'a t =
    | Done
    | Value of 'a

  let t_to_js convert = function
    | Done -> Ojs.obj [| "done", Ojs.bool_to_js true |]
    | Value value -> Ojs.obj [| "done", Ojs.bool_to_js false; "value", convert value |]
  ;;

  let t_of_js convert value =
    let done_ = Ojs.get_prop_ascii value "done" in
    if Ojs.type_of done_ = "boolean" && Ojs.bool_of_js done_
    then Done
    else Value (convert (Ojs.get_prop_ascii value "value"))
  ;;
end

module AsyncIterator = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include [%js: val next : t -> T.t IteratorResult.t Promise.t [@@js.call]]

    let return this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "return" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to: unit -> T.t IteratorResult.t Promise.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create ~next ?return () =
      let obj =
        Ojs.obj [| "next", [%js.of: unit -> T.t IteratorResult.t Promise.t] next |]
      in
      iter_set obj "return" [%js.of: unit -> T.t IteratorResult.t Promise.t] return;
      let symbol =
        Ojs.get_prop_ascii (Ojs.get_prop_ascii Ojs.global "Symbol") "asyncIterator"
      in
      Ojs.set_prop obj symbol ([%js.of: unit -> Ojs.t] (fun () -> obj));
      t_of_js obj
    ;;
  end
end

module AsyncIterable = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    let iterator value =
      let obj = t_to_js value in
      let symbol =
        Ojs.get_prop_ascii (Ojs.get_prop_ascii Ojs.global "Symbol") "asyncIterator"
      in
      AsyncIterator.t_of_js
        T.t_of_js
        (Ojs.call (Ojs.get_prop obj symbol) "call" [| obj |])
    ;;

    let create ~iterator =
      let obj = Ojs.obj [||] in
      let symbol =
        Ojs.get_prop_ascii (Ojs.get_prop_ascii Ojs.global "Symbol") "asyncIterator"
      in
      Ojs.set_prop obj symbol ([%js.of: unit -> T.t AsyncIterator.t] iterator);
      t_of_js obj
    ;;
  end
end

module TerminalShellExecution = struct
  include Interface.Make ()

  include
    [%js:
      val commandLine : t -> TerminalShellExecutionCommandLine.t [@@js.get "commandLine"]
      val cwd : t -> Uri.t or_undefined [@@js.get "cwd"]
      val read : t -> string AsyncIterable.t [@@js.call]]

  let create ~commandLine ~cwd ~read () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "commandLine"
      (TerminalShellExecutionCommandLine.t_to_js commandLine);
    Ojs.set_prop_ascii obj "cwd" ((or_undefined_to_js Uri.t_to_js) cwd);
    Ojs.set_prop_ascii obj "read" ([%js.of: unit -> string AsyncIterable.t] read);
    t_of_js obj
  ;;
end

module TerminalShellIntegration = struct
  include Interface.Make ()

  include
    [%js:
      val cwd : t -> Uri.t or_undefined [@@js.get "cwd"]
      val executeCommand : t -> commandLine:string -> TerminalShellExecution.t [@@js.call]

      val executeCommandArgs
        :  t
        -> executable:string
        -> args:string list
        -> TerminalShellExecution.t
      [@@js.call "executeCommand"]]
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
end = struct
  include Interface.Make ()

  type shell_args =
    [ `Items of string list
    | `String of string
    ]

  let shell_args_to_js = function
    | `Items value -> (Ojs.list_to_js Ojs.string_to_js) value
    | `String value -> Ojs.string_to_js value
  ;;

  let shell_args_of_js js_val =
    if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "string")
    then `Items ((Ojs.list_of_js Ojs.string_of_js) js_val)
    else if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else invalid_arg "TerminalOptions.shell_args: unexpected JavaScript value"
  ;;

  type cwd_value =
    [ `String of string
    | `Uri of Uri.t
    ]

  let cwd_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Uri value -> Uri.t_to_js value
  ;;

  let cwd_value_of_js js_val =
    match binding_constructor js_val [ "Uri" ] with
    | Some "Uri" -> `Uri (Uri.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "scheme"
        && binding_has_member js_val "authority"
        && binding_has_member js_val "path"
        && binding_has_member js_val "query"
        && binding_has_member js_val "fragment"
        && binding_has_member js_val "fsPath"
        && binding_has_member js_val "with"
        && binding_has_member js_val "toString"
        && binding_has_member js_val "toJSON"
      then `Uri (Uri.t_of_js js_val)
      else invalid_arg "TerminalOptions.cwd_value: unexpected JavaScript value"
  ;;

  type env_value =
    [ `String of string
    | `Null
    ]

  let env_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Null -> Ojs.null
  ;;

  let env_value_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if Ojs.type_of js_val = "object" && Ojs.is_null js_val
    then `Null
    else invalid_arg "TerminalOptions.env_value: unexpected JavaScript value"
  ;;

  type location =
    [ `TerminalLocation of TerminalLocation.t
    | `TerminalEditorLocationOptions of TerminalEditorLocationOptions.t
    | `TerminalSplitLocationOptions of TerminalSplitLocationOptions.t
    ]

  let location_to_js = function
    | `TerminalLocation value -> TerminalLocation.t_to_js value
    | `TerminalEditorLocationOptions value -> TerminalEditorLocationOptions.t_to_js value
    | `TerminalSplitLocationOptions value -> TerminalSplitLocationOptions.t_to_js value
  ;;

  let location_of_js js_val =
    if Ojs.type_of js_val = "number"
    then `TerminalLocation (TerminalLocation.t_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "viewColumn"
    then `TerminalEditorLocationOptions (TerminalEditorLocationOptions.t_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "parentTerminal"
    then `TerminalSplitLocationOptions (TerminalSplitLocationOptions.t_of_js js_val)
    else invalid_arg "TerminalOptions.location: unexpected JavaScript value"
  ;;

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
  ;;

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
  ;;

  include
    [%js:
      val name : t -> string or_undefined [@@js.get "name"]
      val shellPath : t -> string or_undefined [@@js.get "shellPath"]
      val shellArgs : t -> shell_args or_undefined [@@js.get "shellArgs"]
      val cwd : t -> cwd_value or_undefined [@@js.get "cwd"]
      val env : t -> env_value or_undefined Dict.t or_undefined [@@js.get "env"]
      val strictEnv : t -> bool or_undefined [@@js.get "strictEnv"]
      val hideFromUser : t -> bool or_undefined [@@js.get "hideFromUser"]

      val shellIntegrationNonce : t -> string or_undefined
      [@@js.get "shellIntegrationNonce"]]

  include
    [%js:
      val set_name : t -> string or_undefined -> unit [@@js.set "name"]
      val set_shellPath : t -> string or_undefined -> unit [@@js.set "shellPath"]
      val set_shellArgs : t -> shell_args or_undefined -> unit [@@js.set "shellArgs"]
      val set_cwd : t -> cwd_value or_undefined -> unit [@@js.set "cwd"]

      val set_env : t -> env_value or_undefined Dict.t or_undefined -> unit
      [@@js.set "env"]

      val set_strictEnv : t -> bool or_undefined -> unit [@@js.set "strictEnv"]
      val set_hideFromUser : t -> bool or_undefined -> unit [@@js.set "hideFromUser"]
      val message : t -> string or_undefined [@@js.get "message"]
      val set_message : t -> string or_undefined -> unit [@@js.set "message"]
      val iconPath : t -> IconPath.t or_undefined [@@js.get "iconPath"]
      val set_iconPath : t -> IconPath.t or_undefined -> unit [@@js.set "iconPath"]
      val color : t -> ThemeColor.t or_undefined [@@js.get "color"]
      val set_color : t -> ThemeColor.t or_undefined -> unit [@@js.set "color"]
      val location : t -> location or_undefined [@@js.get "location"]
      val set_location : t -> location or_undefined -> unit [@@js.set "location"]
      val isTransient : t -> bool or_undefined [@@js.get "isTransient"]
      val set_isTransient : t -> bool or_undefined -> unit [@@js.set "isTransient"]

      val set_shellIntegrationNonce : t -> string or_undefined -> unit
      [@@js.set "shellIntegrationNonce"]]

  let create
        ?name
        ?shellPath
        ?shellArgs
        ?cwd
        ?env
        ?strictEnv
        ?hideFromUser
        ?message
        ?iconPath
        ?color
        ?location
        ?isTransient
        ?shellIntegrationNonce
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set obj "name" Ojs.string_to_js name;
    iter_set obj "shellPath" Ojs.string_to_js shellPath;
    iter_set obj "shellArgs" shell_args_to_js shellArgs;
    iter_set obj "cwd" cwd_value_to_js cwd;
    iter_set obj "env" (Dict.t_to_js (or_undefined_to_js env_value_to_js)) env;
    iter_set obj "strictEnv" Ojs.bool_to_js strictEnv;
    iter_set obj "hideFromUser" Ojs.bool_to_js hideFromUser;
    iter_set obj "message" Ojs.string_to_js message;
    iter_set obj "iconPath" IconPath.t_to_js iconPath;
    iter_set obj "color" ThemeColor.t_to_js color;
    iter_set obj "location" location_to_js location;
    iter_set obj "isTransient" Ojs.bool_to_js isTransient;
    iter_set obj "shellIntegrationNonce" Ojs.string_to_js shellIntegrationNonce;
    t_of_js obj
  ;;
end

and TerminalSplitLocationOptions : sig
  include Ojs.T

  val parentTerminal : t -> Terminal.t
  val set_parentTerminal : t -> Terminal.t -> unit
  val create : parentTerminal:Terminal.t -> unit -> t
end = struct
  include Interface.Make ()

  include
    [%js:
      val parentTerminal : t -> Terminal.t [@@js.get "parentTerminal"]
      val set_parentTerminal : t -> Terminal.t -> unit [@@js.set "parentTerminal"]]

  let create ~parentTerminal () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "parentTerminal" (Terminal.t_to_js parentTerminal);
    t_of_js obj
  ;;
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
end = struct
  include Interface.Make ()

  type creation_options =
    [ `TerminalOptions of TerminalOptions.t
    | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
    ]

  let creation_options_to_js = function
    | `TerminalOptions value -> TerminalOptions.t_to_js value
    | `ExtensionTerminalOptions value -> ExtensionTerminalOptions.t_to_js value
  ;;

  let creation_options_of_js js_val =
    if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then `TerminalOptions (TerminalOptions.t_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "name"
      && binding_has_member js_val "pty"
    then `ExtensionTerminalOptions (ExtensionTerminalOptions.t_of_js js_val)
    else invalid_arg "Terminal.creation_options: unexpected JavaScript value"
  ;;

  type creationOptions =
    ([ `TerminalOptions of TerminalOptions.t
     | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
     ]
    [@js.union])
  [@@js]

  let creationOptions_of_js js_val =
    if binding_has_member js_val "pty"
    then `ExtensionTerminalOptions ([%js.to: ExtensionTerminalOptions.t] js_val)
    else `TerminalOptions ([%js.to: TerminalOptions.t] js_val)
  ;;

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val processId : t -> int or_undefined Promise.t [@@js.get "processId"]
      val creationOptions : t -> creation_options [@@js.get "creationOptions"]
      val exitStatus : t -> TerminalExitStatus.t or_undefined [@@js.get "exitStatus"]
      val state : t -> TerminalState.t [@@js.get "state"]

      val shellIntegration : t -> TerminalShellIntegration.t or_undefined
      [@@js.get "shellIntegration"]

      val sendText : t -> text:string -> ?shouldExecute:bool -> unit -> unit [@@js.call]
      val show : t -> ?preserveFocus:bool -> unit -> unit [@@js.call]
      val hide : t -> unit [@@js.call]
      val dispose : t -> unit [@@js.call]]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)
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
end = struct
  include Interface.Make ()

  type location =
    [ `TerminalLocation of TerminalLocation.t
    | `TerminalEditorLocationOptions of TerminalEditorLocationOptions.t
    | `TerminalSplitLocationOptions of TerminalSplitLocationOptions.t
    ]

  let location_to_js = function
    | `TerminalLocation value -> TerminalLocation.t_to_js value
    | `TerminalEditorLocationOptions value -> TerminalEditorLocationOptions.t_to_js value
    | `TerminalSplitLocationOptions value -> TerminalSplitLocationOptions.t_to_js value
  ;;

  let location_of_js js_val =
    if Ojs.type_of js_val = "number"
    then `TerminalLocation (TerminalLocation.t_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "viewColumn"
    then `TerminalEditorLocationOptions (TerminalEditorLocationOptions.t_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "parentTerminal"
    then `TerminalSplitLocationOptions (TerminalSplitLocationOptions.t_of_js js_val)
    else invalid_arg "ExtensionTerminalOptions.location: unexpected JavaScript value"
  ;;

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val pty : t -> Pseudoterminal.t [@@js.get "pty"]

      val shellIntegrationNonce : t -> string or_undefined
      [@@js.get "shellIntegrationNonce"]]

  include
    [%js:
      val set_name : t -> string -> unit [@@js.set "name"]
      val set_pty : t -> Pseudoterminal.t -> unit [@@js.set "pty"]
      val iconPath : t -> IconPath.t or_undefined [@@js.get "iconPath"]
      val set_iconPath : t -> IconPath.t or_undefined -> unit [@@js.set "iconPath"]
      val color : t -> ThemeColor.t or_undefined [@@js.get "color"]
      val set_color : t -> ThemeColor.t or_undefined -> unit [@@js.set "color"]
      val location : t -> location or_undefined [@@js.get "location"]
      val set_location : t -> location or_undefined -> unit [@@js.set "location"]
      val isTransient : t -> bool or_undefined [@@js.get "isTransient"]
      val set_isTransient : t -> bool or_undefined -> unit [@@js.set "isTransient"]

      val set_shellIntegrationNonce : t -> string or_undefined -> unit
      [@@js.set "shellIntegrationNonce"]]

  let create ~name ~pty ?iconPath ?color ?location ?isTransient ?shellIntegrationNonce () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "name" (Ojs.string_to_js name);
    Ojs.set_prop_ascii obj "pty" (Pseudoterminal.t_to_js pty);
    iter_set obj "iconPath" IconPath.t_to_js iconPath;
    iter_set obj "color" ThemeColor.t_to_js color;
    iter_set obj "location" location_to_js location;
    iter_set obj "isTransient" Ojs.bool_to_js isTransient;
    iter_set obj "shellIntegrationNonce" Ojs.string_to_js shellIntegrationNonce;
    t_of_js obj
  ;;
end

module ExtensionKind = struct
  type t =
    | UI [@js 1]
    | Workspace [@js 2]
  [@@js.enum] [@@js]
end

module Extension = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val id : t -> string [@@js.get "id"]
        val extensionUri : t -> Uri.t [@@js.get "extensionUri"]
        val extensionPath : t -> string [@@js.get "extensionPath"]
        val isActive : t -> bool [@@js.get "isActive"]
        val packageJSON : t -> Ojs.t [@@js.get "packageJSON"]
        val extensionKind : t -> ExtensionKind.t [@@js.get "extensionKind"]
        val set_extensionKind : t -> ExtensionKind.t -> unit [@@js.set "extensionKind"]
        val exports : t -> T.t [@@js.get "exports"]
        val activate : t -> T.t Promise.t [@@js.call "activate"]]
  end
end

module Extensions = struct
  include
    [%js:
      val getExtension : string -> Ojs.t Extension.t or_undefined
      [@@js.global "@vscode.extensions.getExtension"]

      val getExtensionTyped
        :  ((module Ojs.T with type t = 'p_t)[@js])
        -> extensionId:string
        -> 'p_t Extension.t or_undefined
      [@@js.global "@vscode.extensions.getExtension"]

      val all : unit -> Ojs.t Extension.t list [@@js.get "@vscode.extensions.all"]
      val onDidChange : unit -> unit Event.t [@@js.get "@vscode.extensions.onDidChange"]]
end

module TerminalShellIntegrationChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val terminal : t -> Terminal.t [@@js.get "terminal"]
      val shellIntegration : t -> TerminalShellIntegration.t [@@js.get "shellIntegration"]]

  let create ~terminal ~shellIntegration () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "terminal" (Terminal.t_to_js terminal);
    Ojs.set_prop_ascii
      obj
      "shellIntegration"
      (TerminalShellIntegration.t_to_js shellIntegration);
    t_of_js obj
  ;;
end

module TerminalShellExecutionStartEvent = struct
  include Interface.Make ()

  include
    [%js:
      val terminal : t -> Terminal.t [@@js.get "terminal"]
      val shellIntegration : t -> TerminalShellIntegration.t [@@js.get "shellIntegration"]
      val execution : t -> TerminalShellExecution.t [@@js.get "execution"]]

  let create ~terminal ~shellIntegration ~execution () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "terminal" (Terminal.t_to_js terminal);
    Ojs.set_prop_ascii
      obj
      "shellIntegration"
      (TerminalShellIntegration.t_to_js shellIntegration);
    Ojs.set_prop_ascii obj "execution" (TerminalShellExecution.t_to_js execution);
    t_of_js obj
  ;;
end

module TerminalShellExecutionEndEvent = struct
  include Interface.Make ()

  include
    [%js:
      val terminal : t -> Terminal.t [@@js.get "terminal"]
      val shellIntegration : t -> TerminalShellIntegration.t [@@js.get "shellIntegration"]
      val execution : t -> TerminalShellExecution.t [@@js.get "execution"]
      val exitCode : t -> int or_undefined [@@js.get "exitCode"]]

  let create ~terminal ~shellIntegration ~execution ~exitCode () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "terminal" (Terminal.t_to_js terminal);
    Ojs.set_prop_ascii
      obj
      "shellIntegration"
      (TerminalShellIntegration.t_to_js shellIntegration);
    Ojs.set_prop_ascii obj "execution" (TerminalShellExecution.t_to_js execution);
    Ojs.set_prop_ascii obj "exitCode" ((or_undefined_to_js Ojs.int_to_js) exitCode);
    t_of_js obj
  ;;
end

module OutputChannel = struct
  include Interface.Make ()

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val append : t -> value:string -> unit [@@js.call]
      val appendLine : t -> value:string -> unit [@@js.call]
      val replace : t -> value:string -> unit [@@js.call]
      val clear : t -> unit [@@js.call]
      val show : t -> ?preserveFocus:bool -> unit -> unit [@@js.call]
      val hide : t -> unit [@@js.call]
      val dispose : t -> unit [@@js.call]]

  let disposable this = Disposable.make ~dispose:(fun () -> dispose this)

  let showInColumn this ?column ?preserveFocus () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "show"
         (binding_arguments
            [| (or_undefined_to_js ViewColumn.t_to_js) column
             ; (or_undefined_to_js Ojs.bool_to_js) preserveFocus
            |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module OutputChannelOptions = struct
  include Interface.Make ()
  include [%js: val log : t -> bool [@@js.get]]

  let create () = t_of_js (Ojs.obj [| "log", Ojs.bool_to_js true |])
end

module Memento = struct
  include Interface.Make ()

  include
    [%js:
      val get : t -> key:string -> Ojs.t or_undefined [@@js.call]

      val get_default
        :  ((module Ojs.T with type t = 'a)[@js])
        -> t
        -> key:string
        -> defaultValue:'a
        -> 'a
      [@@js.call "get"]

      val update : t -> key:string -> value:Ojs.t -> unit Promise.t [@@js.call]
      val keys : t -> string list [@@js.call "keys"]

      val getTyped
        :  ((module Ojs.T with type t = 'p_t)[@js])
        -> t
        -> key:string
        -> 'p_t or_undefined
      [@@js.call "get"]]
end

module EnvironmentVariableMutatorType = struct
  type t =
    | Replace [@js 1]
    | Append [@js 2]
    | Prepend [@js 3]
  [@@js.enum] [@@js]
end

module EnvironmentVariableMutatorOptions = struct
  include Interface.Make ()

  include
    [%js:
      val applyAtProcessCreation : t -> bool or_undefined
      [@@js.get "applyAtProcessCreation"]

      val set_applyAtProcessCreation : t -> bool or_undefined -> unit
      [@@js.set "applyAtProcessCreation"]

      val applyAtShellIntegration : t -> bool or_undefined
      [@@js.get "applyAtShellIntegration"]

      val set_applyAtShellIntegration : t -> bool or_undefined -> unit
      [@@js.set "applyAtShellIntegration"]]

  let create ?applyAtProcessCreation ?applyAtShellIntegration () =
    let obj = Ojs.obj [||] in
    iter_set obj "applyAtProcessCreation" Ojs.bool_to_js applyAtProcessCreation;
    iter_set obj "applyAtShellIntegration" Ojs.bool_to_js applyAtShellIntegration;
    t_of_js obj
  ;;
end

module EnvironmentVariableMutator = struct
  include Interface.Make ()

  include
    [%js:
      val type_ : t -> EnvironmentVariableMutatorType.t [@@js.get "type"]
      val value : t -> string [@@js.get "value"]
      val options : t -> EnvironmentVariableMutatorOptions.t [@@js.get "options"]]

  let create ~type_ ~value ~options () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "type" (EnvironmentVariableMutatorType.t_to_js type_);
    Ojs.set_prop_ascii obj "value" (Ojs.string_to_js value);
    Ojs.set_prop_ascii obj "options" (EnvironmentVariableMutatorOptions.t_to_js options);
    t_of_js obj
  ;;
end

module IterableIterator = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include [%js: val next : t -> T.t IteratorResult.t [@@js.call]]

    let return this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "return" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to: unit -> T.t IteratorResult.t] (Ojs.call callback "bind" [| this |]))
    ;;

    let create ~next ?return () =
      let obj = Ojs.obj [| "next", [%js.of: unit -> T.t IteratorResult.t] next |] in
      iter_set obj "return" [%js.of: unit -> T.t IteratorResult.t] return;
      let symbol =
        Ojs.get_prop_ascii (Ojs.get_prop_ascii Ojs.global "Symbol") "iterator"
      in
      Ojs.set_prop obj symbol ([%js.of: unit -> Ojs.t] (fun () -> obj));
      t_of_js obj
    ;;
  end
end

module EnvironmentVariableCollection = struct
  include Interface.Make ()

  type description =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let description_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let description_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else
        invalid_arg
          "EnvironmentVariableCollection.description: unexpected JavaScript value"
  ;;

  include
    [%js:
      val persistent : t -> bool [@@js.get "persistent"]

      val get : t -> variable:string -> EnvironmentVariableMutator.t or_undefined
      [@@js.call]

      val delete : t -> variable:string -> unit [@@js.call]
      val clear : t -> unit [@@js.call]
      val set_persistent : t -> bool -> unit [@@js.set "persistent"]
      val description : t -> description or_undefined [@@js.get "description"]
      val set_description : t -> description or_undefined -> unit [@@js.set "description"]]

  let replace this ~variable ~value ?options () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "replace"
         (binding_arguments
            [| Ojs.string_to_js variable
             ; Ojs.string_to_js value
             ; (or_undefined_to_js EnvironmentVariableMutatorOptions.t_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let append this ~variable ~value ?options () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "append"
         (binding_arguments
            [| Ojs.string_to_js variable
             ; Ojs.string_to_js value
             ; (or_undefined_to_js EnvironmentVariableMutatorOptions.t_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let prepend this ~variable ~value ?options () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "prepend"
         (binding_arguments
            [| Ojs.string_to_js variable
             ; Ojs.string_to_js value
             ; (or_undefined_to_js EnvironmentVariableMutatorOptions.t_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let forEach this ~callback ?thisArg () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "forEach"
         (binding_arguments
            [| [%js.of:
                 variable:string
                 -> mutator:EnvironmentVariableMutator.t
                 -> collection:t
                 -> Ojs.t]
                 callback
             ; (or_undefined_to_js Ojs.t_to_js) thisArg
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let iterator this =
    let this = t_to_js this in
    let symbol = Ojs.get_prop_ascii (Ojs.get_prop_ascii Ojs.global "Symbol") "iterator" in
    IterableIterator.t_of_js
      (fun js_val ->
         ( Ojs.string_of_js (Ojs.array_get js_val 0)
         , EnvironmentVariableMutator.t_of_js (Ojs.array_get js_val 1) ))
      (Ojs.call (Ojs.get_prop this symbol) "call" [| this |])
  ;;

  let create
        ~persistent
        ~description
        ~replace
        ~append
        ~prepend
        ~get
        ~forEach
        ~delete
        ~clear
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "persistent" (Ojs.bool_to_js persistent);
    Ojs.set_prop_ascii
      obj
      "description"
      ((or_undefined_to_js description_to_js) description);
    Ojs.set_prop_ascii
      obj
      "replace"
      ([%js.of:
         variable:string
         -> value:string
         -> ?options:EnvironmentVariableMutatorOptions.t
         -> unit
         -> unit]
         replace);
    Ojs.set_prop_ascii
      obj
      "append"
      ([%js.of:
         variable:string
         -> value:string
         -> ?options:EnvironmentVariableMutatorOptions.t
         -> unit
         -> unit]
         append);
    Ojs.set_prop_ascii
      obj
      "prepend"
      ([%js.of:
         variable:string
         -> value:string
         -> ?options:EnvironmentVariableMutatorOptions.t
         -> unit
         -> unit]
         prepend);
    Ojs.set_prop_ascii
      obj
      "get"
      ([%js.of: variable:string -> EnvironmentVariableMutator.t or_undefined] get);
    Ojs.set_prop_ascii
      obj
      "forEach"
      ([%js.of:
         callback:
           (variable:string
            -> mutator:EnvironmentVariableMutator.t
            -> collection:t
            -> Ojs.t)
         -> ?thisArg:Ojs.t
         -> unit
         -> unit]
         forEach);
    Ojs.set_prop_ascii obj "delete" ([%js.of: variable:string -> unit] delete);
    Ojs.set_prop_ascii obj "clear" ([%js.of: unit -> unit] clear);
    t_of_js obj
  ;;
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
  include [%js: val key : t -> string [@@js.get "key"]]

  let create ~key () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "key" (Ojs.string_to_js key);
    t_of_js obj
  ;;
end

module SecretStorage = struct
  include Interface.Make ()
  include [%js: val keys : t -> string list Promise.t [@@js.call]]

  include
    [%js:
      val get : t -> key:string -> string or_undefined Promise.t [@@js.call]
      val store : t -> key:string -> value:string -> unit Promise.t [@@js.call]
      val delete : t -> key:string -> unit Promise.t [@@js.call]
      val onDidChange : t -> SecretStorageChangeEvent.t Event.t [@@js.get "onDidChange"]]

  let create ~keys ~get ~store ~delete ~onDidChange () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "keys" ([%js.of: unit -> string list Promise.t] keys);
    Ojs.set_prop_ascii
      obj
      "get"
      ([%js.of: key:string -> string or_undefined Promise.t] get);
    Ojs.set_prop_ascii
      obj
      "store"
      ([%js.of: key:string -> value:string -> unit Promise.t] store);
    Ojs.set_prop_ascii obj "delete" ([%js.of: key:string -> unit Promise.t] delete);
    Ojs.set_prop_ascii
      obj
      "onDidChange"
      ((Event.t_to_js SecretStorageChangeEvent.t_to_js) onDidChange);
    t_of_js obj
  ;;
end

module LanguageModelTextPart = struct
  include Class.Make ()

  include
    [%js:
      val value : t -> string [@@js.get "value"]
      val set_value : t -> string -> unit [@@js.set "value"]
      val make : value:string -> t [@@js.new "@vscode.LanguageModelTextPart"]]
end

module LanguageModelToolResultPart = struct
  include Class.Make ()

  include
    [%js:
      val callId : t -> string [@@js.get "callId"]
      val set_callId : t -> string -> unit [@@js.set "callId"]
      val content : t -> Ojs.t list [@@js.get "content"]
      val set_content : t -> Ojs.t list -> unit [@@js.set "content"]

      val make : callId:string -> content:Ojs.t list -> t
      [@@js.new "@vscode.LanguageModelToolResultPart"]]
end

module LanguageModelDataPart = struct
  include Class.Make ()

  include
    [%js:
      val image : data:Uint8Array.t -> mime:string -> t
      [@@js.global "@vscode.LanguageModelDataPart.image"]]

  let json ~value ?mime () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "LanguageModelDataPart")
         "json"
         (binding_arguments
            [| Ojs.t_to_js value; (or_undefined_to_js Ojs.string_to_js) mime |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let text ~value ?mime () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "LanguageModelDataPart")
         "text"
         (binding_arguments
            [| Ojs.string_to_js value; (or_undefined_to_js Ojs.string_to_js) mime |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val mimeType : t -> string [@@js.get "mimeType"]
      val set_mimeType : t -> string -> unit [@@js.set "mimeType"]
      val data : t -> Uint8Array.t [@@js.get "data"]
      val set_data : t -> Uint8Array.t -> unit [@@js.set "data"]

      val make : data:Uint8Array.t -> mimeType:string -> t
      [@@js.new "@vscode.LanguageModelDataPart"]]
end

module LanguageModelToolCallPart = struct
  include Class.Make ()

  include
    [%js:
      val callId : t -> string [@@js.get "callId"]
      val set_callId : t -> string -> unit [@@js.set "callId"]
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val input : t -> Ojs.t [@@js.get "input"]
      val set_input : t -> Ojs.t -> unit [@@js.set "input"]

      val make : callId:string -> name:string -> input:Ojs.t -> t
      [@@js.new "@vscode.LanguageModelToolCallPart"]]
end

module LanguageModelInputPart = struct
  type value =
    [ `LanguageModelTextPart of LanguageModelTextPart.t
    | `LanguageModelToolResultPart of LanguageModelToolResultPart.t
    | `LanguageModelToolCallPart of LanguageModelToolCallPart.t
    | `LanguageModelDataPart of LanguageModelDataPart.t
    ]

  let value_to_js = function
    | `LanguageModelTextPart value -> LanguageModelTextPart.t_to_js value
    | `LanguageModelToolResultPart value -> LanguageModelToolResultPart.t_to_js value
    | `LanguageModelToolCallPart value -> LanguageModelToolCallPart.t_to_js value
    | `LanguageModelDataPart value -> LanguageModelDataPart.t_to_js value
  ;;

  let value_of_js js_val =
    match
      binding_constructor
        js_val
        [ "LanguageModelTextPart"
        ; "LanguageModelToolResultPart"
        ; "LanguageModelToolCallPart"
        ; "LanguageModelDataPart"
        ]
    with
    | Some "LanguageModelTextPart" ->
      `LanguageModelTextPart (LanguageModelTextPart.t_of_js js_val)
    | Some "LanguageModelToolResultPart" ->
      `LanguageModelToolResultPart (LanguageModelToolResultPart.t_of_js js_val)
    | Some "LanguageModelToolCallPart" ->
      `LanguageModelToolCallPart (LanguageModelToolCallPart.t_of_js js_val)
    | Some "LanguageModelDataPart" ->
      `LanguageModelDataPart (LanguageModelDataPart.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
      then `LanguageModelTextPart (LanguageModelTextPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "callId"
        && binding_has_member js_val "content"
      then `LanguageModelToolResultPart (LanguageModelToolResultPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "callId"
        && binding_has_member js_val "name"
        && binding_has_member js_val "input"
      then `LanguageModelToolCallPart (LanguageModelToolCallPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "mimeType"
        && binding_has_member js_val "data"
      then `LanguageModelDataPart (LanguageModelDataPart.t_of_js js_val)
      else invalid_arg "LanguageModelInputPart.value: unexpected JavaScript value"
  ;;

  type t = value

  let t_to_js = value_to_js
  let t_of_js = value_of_js
end

module LanguageModelChatMessageRole = struct
  type t =
    | User [@js 1]
    | Assistant [@js 2]
  [@@js.enum] [@@js]
end

module LanguageModelChatMessage = struct
  include Class.Make ()

  type user_content_item =
    [ `LanguageModelTextPart of LanguageModelTextPart.t
    | `LanguageModelToolResultPart of LanguageModelToolResultPart.t
    | `LanguageModelDataPart of LanguageModelDataPart.t
    ]

  let user_content_item_to_js = function
    | `LanguageModelTextPart value -> LanguageModelTextPart.t_to_js value
    | `LanguageModelToolResultPart value -> LanguageModelToolResultPart.t_to_js value
    | `LanguageModelDataPart value -> LanguageModelDataPart.t_to_js value
  ;;

  let user_content_item_of_js js_val =
    match
      binding_constructor
        js_val
        [ "LanguageModelTextPart"
        ; "LanguageModelToolResultPart"
        ; "LanguageModelDataPart"
        ]
    with
    | Some "LanguageModelTextPart" ->
      `LanguageModelTextPart (LanguageModelTextPart.t_of_js js_val)
    | Some "LanguageModelToolResultPart" ->
      `LanguageModelToolResultPart (LanguageModelToolResultPart.t_of_js js_val)
    | Some "LanguageModelDataPart" ->
      `LanguageModelDataPart (LanguageModelDataPart.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
      then `LanguageModelTextPart (LanguageModelTextPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "callId"
        && binding_has_member js_val "content"
      then `LanguageModelToolResultPart (LanguageModelToolResultPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "mimeType"
        && binding_has_member js_val "data"
      then `LanguageModelDataPart (LanguageModelDataPart.t_of_js js_val)
      else
        invalid_arg
          "LanguageModelChatMessage.user_content_item: unexpected JavaScript value"
  ;;

  type user_content =
    [ `String of string
    | `Array of user_content_item list
    ]

  let user_content_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Array value -> (Ojs.list_to_js user_content_item_to_js) value
  ;;

  let user_content_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          (Ojs.type_of js_val = "object"
           && (not (Ojs.is_null js_val))
           && binding_has_member js_val "value")
          || (Ojs.type_of js_val = "object"
              && (not (Ojs.is_null js_val))
              && binding_has_member js_val "callId"
              && binding_has_member js_val "content")
          || (Ojs.type_of js_val = "object"
              && (not (Ojs.is_null js_val))
              && binding_has_member js_val "mimeType"
              && binding_has_member js_val "data"))
    then `Array ((Ojs.list_of_js user_content_item_of_js) js_val)
    else invalid_arg "LanguageModelChatMessage.user_content: unexpected JavaScript value"
  ;;

  type assistant_content_item =
    [ `LanguageModelTextPart of LanguageModelTextPart.t
    | `LanguageModelToolCallPart of LanguageModelToolCallPart.t
    | `LanguageModelDataPart of LanguageModelDataPart.t
    ]

  let assistant_content_item_to_js = function
    | `LanguageModelTextPart value -> LanguageModelTextPart.t_to_js value
    | `LanguageModelToolCallPart value -> LanguageModelToolCallPart.t_to_js value
    | `LanguageModelDataPart value -> LanguageModelDataPart.t_to_js value
  ;;

  let assistant_content_item_of_js js_val =
    match
      binding_constructor
        js_val
        [ "LanguageModelTextPart"; "LanguageModelToolCallPart"; "LanguageModelDataPart" ]
    with
    | Some "LanguageModelTextPart" ->
      `LanguageModelTextPart (LanguageModelTextPart.t_of_js js_val)
    | Some "LanguageModelToolCallPart" ->
      `LanguageModelToolCallPart (LanguageModelToolCallPart.t_of_js js_val)
    | Some "LanguageModelDataPart" ->
      `LanguageModelDataPart (LanguageModelDataPart.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
      then `LanguageModelTextPart (LanguageModelTextPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "callId"
        && binding_has_member js_val "name"
        && binding_has_member js_val "input"
      then `LanguageModelToolCallPart (LanguageModelToolCallPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "mimeType"
        && binding_has_member js_val "data"
      then `LanguageModelDataPart (LanguageModelDataPart.t_of_js js_val)
      else
        invalid_arg
          "LanguageModelChatMessage.assistant_content_item: unexpected JavaScript value"
  ;;

  type assistant_content =
    [ `String of string
    | `Array of assistant_content_item list
    ]

  let assistant_content_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Array value -> (Ojs.list_to_js assistant_content_item_to_js) value
  ;;

  let assistant_content_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          (Ojs.type_of js_val = "object"
           && (not (Ojs.is_null js_val))
           && binding_has_member js_val "value")
          || (Ojs.type_of js_val = "object"
              && (not (Ojs.is_null js_val))
              && binding_has_member js_val "callId"
              && binding_has_member js_val "name"
              && binding_has_member js_val "input")
          || (Ojs.type_of js_val = "object"
              && (not (Ojs.is_null js_val))
              && binding_has_member js_val "mimeType"
              && binding_has_member js_val "data"))
    then `Array ((Ojs.list_of_js assistant_content_item_of_js) js_val)
    else
      invalid_arg
        "LanguageModelChatMessage.assistant_content: unexpected JavaScript value"
  ;;

  type make_content =
    [ `String of string
    | `Array of LanguageModelInputPart.t list
    ]

  let make_content_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Array value -> (Ojs.list_to_js LanguageModelInputPart.t_to_js) value
  ;;

  let make_content_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          ((not (Ojs.is_null js_val)) && binding_has_member js_val "value")
          || ((not (Ojs.is_null js_val))
              && binding_has_member js_val "callId"
              && binding_has_member js_val "content")
          || ((not (Ojs.is_null js_val))
              && binding_has_member js_val "callId"
              && binding_has_member js_val "name"
              && binding_has_member js_val "input")
          || ((not (Ojs.is_null js_val))
              && binding_has_member js_val "mimeType"
              && binding_has_member js_val "data"))
    then `Array ((Ojs.list_of_js LanguageModelInputPart.t_of_js) js_val)
    else invalid_arg "LanguageModelChatMessage.make_content: unexpected JavaScript value"
  ;;

  let user ~content ?name () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "LanguageModelChatMessage")
         "User"
         (binding_arguments
            [| user_content_to_js content; (or_undefined_to_js Ojs.string_to_js) name |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let assistant ~content ?name () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "LanguageModelChatMessage")
         "Assistant"
         (binding_arguments
            [| assistant_content_to_js content
             ; (or_undefined_to_js Ojs.string_to_js) name
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val role : t -> LanguageModelChatMessageRole.t [@@js.get "role"]
      val set_role : t -> LanguageModelChatMessageRole.t -> unit [@@js.set "role"]
      val content : t -> LanguageModelInputPart.t list [@@js.get "content"]
      val set_content : t -> LanguageModelInputPart.t list -> unit [@@js.set "content"]
      val name : t -> string or_undefined [@@js.get "name"]
      val set_name : t -> string or_undefined -> unit [@@js.set "name"]]

  let make ~role ~content ?name () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "LanguageModelChatMessage")
         (binding_arguments
            [| LanguageModelChatMessageRole.t_to_js role
             ; make_content_to_js content
             ; (or_undefined_to_js Ojs.string_to_js) name
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module LanguageModelChatResponse = struct
  include Interface.Make ()

  include
    [%js:
      val stream : t -> Ojs.t AsyncIterable.t [@@js.get "stream"]
      val set_stream : t -> Ojs.t AsyncIterable.t -> unit [@@js.set "stream"]
      val text : t -> string AsyncIterable.t [@@js.get "text"]
      val set_text : t -> string AsyncIterable.t -> unit [@@js.set "text"]]

  let create ~stream ~text () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "stream" ((AsyncIterable.t_to_js Ojs.t_to_js) stream);
    Ojs.set_prop_ascii obj "text" ((AsyncIterable.t_to_js Ojs.string_to_js) text);
    t_of_js obj
  ;;
end

module LanguageModelChatTool = struct
  include Interface.Make ()

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val description : t -> string [@@js.get "description"]
      val set_description : t -> string -> unit [@@js.set "description"]
      val inputSchema : t -> Ojs.t or_undefined [@@js.get "inputSchema"]
      val set_inputSchema : t -> Ojs.t or_undefined -> unit [@@js.set "inputSchema"]]

  let create ~name ~description ?inputSchema () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "name" (Ojs.string_to_js name);
    Ojs.set_prop_ascii obj "description" (Ojs.string_to_js description);
    iter_set obj "inputSchema" Ojs.t_to_js inputSchema;
    t_of_js obj
  ;;
end

module LanguageModelChatToolMode = struct
  type t =
    | Auto [@js 1]
    | Required [@js 2]
  [@@js.enum] [@@js]
end

module LanguageModelChatRequestOptions = struct
  include Interface.Make ()

  include
    [%js:
      val justification : t -> string or_undefined [@@js.get "justification"]
      val set_justification : t -> string or_undefined -> unit [@@js.set "justification"]
      val modelOptions : t -> Ojs.t Dict.t or_undefined [@@js.get "modelOptions"]

      val set_modelOptions : t -> Ojs.t Dict.t or_undefined -> unit
      [@@js.set "modelOptions"]

      val tools : t -> LanguageModelChatTool.t list or_undefined [@@js.get "tools"]

      val set_tools : t -> LanguageModelChatTool.t list or_undefined -> unit
      [@@js.set "tools"]

      val toolMode : t -> LanguageModelChatToolMode.t or_undefined [@@js.get "toolMode"]

      val set_toolMode : t -> LanguageModelChatToolMode.t or_undefined -> unit
      [@@js.set "toolMode"]]

  let create ?justification ?modelOptions ?tools ?toolMode () =
    let obj = Ojs.obj [||] in
    iter_set obj "justification" Ojs.string_to_js justification;
    iter_set obj "modelOptions" (Dict.t_to_js Ojs.t_to_js) modelOptions;
    iter_set obj "tools" (Ojs.list_to_js LanguageModelChatTool.t_to_js) tools;
    iter_set obj "toolMode" LanguageModelChatToolMode.t_to_js toolMode;
    t_of_js obj
  ;;
end

module LanguageModelChat = struct
  include Interface.Make ()

  type count_tokens_text =
    [ `String of string
    | `LanguageModelChatMessage of LanguageModelChatMessage.t
    ]

  let count_tokens_text_to_js = function
    | `String value -> Ojs.string_to_js value
    | `LanguageModelChatMessage value -> LanguageModelChatMessage.t_to_js value
  ;;

  let count_tokens_text_of_js js_val =
    match binding_constructor js_val [ "LanguageModelChatMessage" ] with
    | Some "LanguageModelChatMessage" ->
      `LanguageModelChatMessage (LanguageModelChatMessage.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "role"
        && binding_has_member js_val "content"
        && binding_has_member js_val "name"
      then `LanguageModelChatMessage (LanguageModelChatMessage.t_of_js js_val)
      else invalid_arg "LanguageModelChat.count_tokens_text: unexpected JavaScript value"
  ;;

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val name : t -> string [@@js.get "name"]
      val vendor : t -> string [@@js.get "vendor"]
      val family : t -> string [@@js.get "family"]
      val version : t -> string [@@js.get "version"]
      val maxInputTokens : t -> int [@@js.get "maxInputTokens"]]

  let sendRequest this ~messages ?options ?token () =
    (Promise.t_of_js LanguageModelChatResponse.t_of_js)
      (Ojs.call
         (t_to_js this)
         "sendRequest"
         (binding_arguments
            [| (Ojs.list_to_js LanguageModelChatMessage.t_to_js) messages
             ; (or_undefined_to_js LanguageModelChatRequestOptions.t_to_js) options
             ; (or_undefined_to_js CancellationToken.t_to_js) token
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let countTokens this ~text ?token () =
    (Promise.t_of_js Ojs.int_of_js)
      (Ojs.call
         (t_to_js this)
         "countTokens"
         (binding_arguments
            [| count_tokens_text_to_js text
             ; (or_undefined_to_js CancellationToken.t_to_js) token
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let create
        ~name
        ~id
        ~vendor
        ~family
        ~version
        ~maxInputTokens
        ~sendRequest
        ~countTokens
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "name" (Ojs.string_to_js name);
    Ojs.set_prop_ascii obj "id" (Ojs.string_to_js id);
    Ojs.set_prop_ascii obj "vendor" (Ojs.string_to_js vendor);
    Ojs.set_prop_ascii obj "family" (Ojs.string_to_js family);
    Ojs.set_prop_ascii obj "version" (Ojs.string_to_js version);
    Ojs.set_prop_ascii obj "maxInputTokens" (Ojs.int_to_js maxInputTokens);
    Ojs.set_prop_ascii
      obj
      "sendRequest"
      ([%js.of:
         messages:LanguageModelChatMessage.t list
         -> ?options:LanguageModelChatRequestOptions.t
         -> ?token:CancellationToken.t
         -> unit
         -> LanguageModelChatResponse.t Promise.t]
         sendRequest);
    Ojs.set_prop_ascii
      obj
      "countTokens"
      ([%js.of:
         text:count_tokens_text -> ?token:CancellationToken.t -> unit -> int Promise.t]
         countTokens);
    t_of_js obj
  ;;
end

module LanguageModelAccessInformation = struct
  include Interface.Make ()

  include
    [%js:
      val onDidChange : t -> unit Event.t [@@js.get "onDidChange"]
      val canSendRequest : t -> chat:LanguageModelChat.t -> bool or_undefined [@@js.call]]

  let create ~onDidChange ~canSendRequest () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "onDidChange"
      ((Event.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None))
         onDidChange);
    Ojs.set_prop_ascii
      obj
      "canSendRequest"
      ([%js.of: chat:LanguageModelChat.t -> bool or_undefined] canSendRequest);
    t_of_js obj
  ;;
end

module GlobalMemento = struct
  include Memento
  include [%js: val setKeysForSync : t -> keys:string list -> unit [@@js.call]]
end

module EnvironmentVariableScope = struct
  include Interface.Make ()

  include
    [%js:
      val workspaceFolder : t -> WorkspaceFolder.t or_undefined
      [@@js.get "workspaceFolder"]

      val set_workspaceFolder : t -> WorkspaceFolder.t or_undefined -> unit
      [@@js.set "workspaceFolder"]]

  let create ?workspaceFolder () =
    let obj = Ojs.obj [||] in
    iter_set obj "workspaceFolder" WorkspaceFolder.t_to_js workspaceFolder;
    t_of_js obj
  ;;
end

module GlobalEnvironmentVariableCollection = struct
  include Interface.Extend (EnvironmentVariableCollection) ()

  type description =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let description_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let description_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else
        invalid_arg
          "GlobalEnvironmentVariableCollection.description: unexpected JavaScript value"
  ;;

  let to_environment_variable_collection (value : t) =
    (value :> EnvironmentVariableCollection.t)
  ;;

  include
    [%js:
      val persistent : t -> bool [@@js.get "persistent"]
      val set_persistent : t -> bool -> unit [@@js.set "persistent"]
      val description : t -> description or_undefined [@@js.get "description"]
      val set_description : t -> description or_undefined -> unit [@@js.set "description"]]

  let replace this ~variable ~value ?options () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "replace"
         (binding_arguments
            [| Ojs.string_to_js variable
             ; Ojs.string_to_js value
             ; (or_undefined_to_js EnvironmentVariableMutatorOptions.t_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let append this ~variable ~value ?options () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "append"
         (binding_arguments
            [| Ojs.string_to_js variable
             ; Ojs.string_to_js value
             ; (or_undefined_to_js EnvironmentVariableMutatorOptions.t_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let prepend this ~variable ~value ?options () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "prepend"
         (binding_arguments
            [| Ojs.string_to_js variable
             ; Ojs.string_to_js value
             ; (or_undefined_to_js EnvironmentVariableMutatorOptions.t_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val get : t -> variable:string -> EnvironmentVariableMutator.t or_undefined
      [@@js.call "get"]]

  let forEach this ~callback ?thisArg () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "forEach"
         (binding_arguments
            [| [%js.of:
                 variable:string
                 -> mutator:EnvironmentVariableMutator.t
                 -> collection:EnvironmentVariableCollection.t
                 -> Ojs.t]
                 callback
             ; (or_undefined_to_js Ojs.t_to_js) thisArg
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val delete : t -> variable:string -> unit [@@js.call "delete"]
      val clear : t -> unit [@@js.call "clear"]

      val getScoped
        :  t
        -> scope:EnvironmentVariableScope.t
        -> EnvironmentVariableCollection.t
      [@@js.call "getScoped"]]

  let create
        ~persistent
        ~description
        ~replace
        ~append
        ~prepend
        ~get
        ~forEach
        ~delete
        ~clear
        ~getScoped
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "persistent" (Ojs.bool_to_js persistent);
    Ojs.set_prop_ascii
      obj
      "description"
      ((or_undefined_to_js description_to_js) description);
    Ojs.set_prop_ascii
      obj
      "replace"
      ([%js.of:
         variable:string
         -> value:string
         -> ?options:EnvironmentVariableMutatorOptions.t
         -> unit
         -> unit]
         replace);
    Ojs.set_prop_ascii
      obj
      "append"
      ([%js.of:
         variable:string
         -> value:string
         -> ?options:EnvironmentVariableMutatorOptions.t
         -> unit
         -> unit]
         append);
    Ojs.set_prop_ascii
      obj
      "prepend"
      ([%js.of:
         variable:string
         -> value:string
         -> ?options:EnvironmentVariableMutatorOptions.t
         -> unit
         -> unit]
         prepend);
    Ojs.set_prop_ascii
      obj
      "get"
      ([%js.of: variable:string -> EnvironmentVariableMutator.t or_undefined] get);
    Ojs.set_prop_ascii
      obj
      "forEach"
      ([%js.of:
         callback:
           (variable:string
            -> mutator:EnvironmentVariableMutator.t
            -> collection:EnvironmentVariableCollection.t
            -> Ojs.t)
         -> ?thisArg:Ojs.t
         -> unit
         -> unit]
         forEach);
    Ojs.set_prop_ascii obj "delete" ([%js.of: variable:string -> unit] delete);
    Ojs.set_prop_ascii obj "clear" ([%js.of: unit -> unit] clear);
    Ojs.set_prop_ascii
      obj
      "getScoped"
      ([%js.of: scope:EnvironmentVariableScope.t -> EnvironmentVariableCollection.t]
         getScoped);
    t_of_js obj
  ;;
end

module ExtensionContext = struct
  include Interface.Make ()

  type subscriptions_item = { dispose : unit -> Ojs.t }

  let subscriptions_item_to_js (value : subscriptions_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "dispose" ([%js.of: unit -> Ojs.t] value.dispose);
    js_val
  ;;

  let subscriptions_item_of_js js_val : subscriptions_item =
    { dispose = [%js.to: unit -> Ojs.t] (Ojs.get_prop_ascii js_val "dispose") }
  ;;

  include
    [%js:
      val subscriptions : t -> subscriptions_item list [@@js.get "subscriptions"]
      val workspaceState : t -> Memento.t [@@js.get "workspaceState"]
      val globalState : t -> GlobalMemento.t [@@js.get]
      val secrets : t -> SecretStorage.t [@@js.get "secrets"]
      val extensionUri : t -> Uri.t [@@js.get "extensionUri"]
      val extensionPath : t -> string [@@js.get "extensionPath"]

      val environmentVariableCollection : t -> GlobalEnvironmentVariableCollection.t
      [@@js.get "environmentVariableCollection"]

      val asAbsolutePath : t -> relativePath:string -> string [@@js.call]
      val storageUri : t -> Uri.t or_undefined [@@js.get "storageUri"]
      val globalStorageUri : t -> Uri.t [@@js.get "globalStorageUri"]
      val logUri : t -> Uri.t [@@js.get "logUri"]
      val extensionMode : t -> ExtensionMode.t [@@js.get "extensionMode"]

      val languageModelAccessInformation : t -> LanguageModelAccessInformation.t
      [@@js.get "languageModelAccessInformation"]]

  let subscribe this ~disposable =
    let subscriptions = Ojs.get_prop_ascii ([%js.of: t] this) "subscriptions" in
    let (_ : Ojs.t) =
      Ojs.call subscriptions "push" [| [%js.of: Disposable.t] disposable |]
    in
    ()
  ;;

  include
    [%js:
      val storagePath : t -> string or_undefined [@@js.get "storagePath"]
      val globalStoragePath : t -> string [@@js.get "globalStoragePath"]
      val logPath : t -> string [@@js.get "logPath"]
      val extension : t -> Ojs.t Extension.t [@@js.get "extension"]]

  let create
        ~subscriptions
        ~workspaceState
        ~globalState
        ~secrets
        ~extensionUri
        ~extensionPath
        ~environmentVariableCollection
        ~asAbsolutePath
        ~storageUri
        ~storagePath
        ~globalStorageUri
        ~globalStoragePath
        ~logUri
        ~logPath
        ~extensionMode
        ~extension
        ~languageModelAccessInformation
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "subscriptions"
      ((Ojs.list_to_js subscriptions_item_to_js) subscriptions);
    Ojs.set_prop_ascii obj "workspaceState" (Memento.t_to_js workspaceState);
    Ojs.set_prop_ascii obj "globalState" (GlobalMemento.t_to_js globalState);
    Ojs.set_prop_ascii obj "secrets" (SecretStorage.t_to_js secrets);
    Ojs.set_prop_ascii obj "extensionUri" (Uri.t_to_js extensionUri);
    Ojs.set_prop_ascii obj "extensionPath" (Ojs.string_to_js extensionPath);
    Ojs.set_prop_ascii
      obj
      "environmentVariableCollection"
      (GlobalEnvironmentVariableCollection.t_to_js environmentVariableCollection);
    Ojs.set_prop_ascii
      obj
      "asAbsolutePath"
      ([%js.of: relativePath:string -> string] asAbsolutePath);
    Ojs.set_prop_ascii obj "storageUri" ((or_undefined_to_js Uri.t_to_js) storageUri);
    Ojs.set_prop_ascii
      obj
      "storagePath"
      ((or_undefined_to_js Ojs.string_to_js) storagePath);
    Ojs.set_prop_ascii obj "globalStorageUri" (Uri.t_to_js globalStorageUri);
    Ojs.set_prop_ascii obj "globalStoragePath" (Ojs.string_to_js globalStoragePath);
    Ojs.set_prop_ascii obj "logUri" (Uri.t_to_js logUri);
    Ojs.set_prop_ascii obj "logPath" (Ojs.string_to_js logPath);
    Ojs.set_prop_ascii obj "extensionMode" (ExtensionMode.t_to_js extensionMode);
    Ojs.set_prop_ascii obj "extension" ((Extension.t_to_js Ojs.t_to_js) extension);
    Ojs.set_prop_ascii
      obj
      "languageModelAccessInformation"
      (LanguageModelAccessInformation.t_to_js languageModelAccessInformation);
    t_of_js obj
  ;;
end

module ShellQuotingOptions = struct
  include Interface.Make ()

  type escape_item =
    { escapeChar : string
    ; charsToEscape : string
    }

  let escape_item_to_js (value : escape_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "escapeChar" (Ojs.string_to_js value.escapeChar);
    Ojs.set_prop_ascii js_val "charsToEscape" (Ojs.string_to_js value.charsToEscape);
    js_val
  ;;

  let escape_item_of_js js_val : escape_item =
    { escapeChar = Ojs.string_of_js (Ojs.get_prop_ascii js_val "escapeChar")
    ; charsToEscape = Ojs.string_of_js (Ojs.get_prop_ascii js_val "charsToEscape")
    }
  ;;

  type escape_value =
    [ `String of string
    | `Options of escape_item
    ]

  let escape_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Options value -> escape_item_to_js value
  ;;

  let escape_value_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      (Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "escapeChar"
      && binding_has_member js_val "charsToEscape"
    then `Options (escape_item_of_js js_val)
    else invalid_arg "ShellQuotingOptions.escape_value: unexpected JavaScript value"
  ;;

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
  ;;

  include
    [%js:
      val escape : t -> escape_value or_undefined [@@js.get "escape"]
      val strong : t -> string or_undefined [@@js.get "strong"]
      val weak : t -> string or_undefined [@@js.get "weak"]]

  include
    [%js:
      val set_escape : t -> escape_value or_undefined -> unit [@@js.set "escape"]
      val set_strong : t -> string or_undefined -> unit [@@js.set "strong"]
      val set_weak : t -> string or_undefined -> unit [@@js.set "weak"]]

  let create ?escape ?strong ?weak () =
    let obj = Ojs.obj [||] in
    iter_set obj "escape" escape_value_to_js escape;
    iter_set obj "strong" Ojs.string_to_js strong;
    iter_set obj "weak" Ojs.string_to_js weak;
    t_of_js obj
  ;;
end

module ShellExecutionOptions = struct
  include Interface.Make ()

  include
    [%js:
      val executable : t -> string or_undefined [@@js.get "executable"]
      val shellArgs : t -> string list or_undefined [@@js.get "shellArgs"]
      val shellQuoting : t -> ShellQuotingOptions.t or_undefined [@@js.get "shellQuoting"]
      val cwd : t -> string or_undefined [@@js.get "cwd"]
      val env : t -> string Dict.t or_undefined [@@js.get "env"]]

  include
    [%js:
      val set_executable : t -> string or_undefined -> unit [@@js.set "executable"]
      val set_shellArgs : t -> string list or_undefined -> unit [@@js.set "shellArgs"]

      val set_shellQuoting : t -> ShellQuotingOptions.t or_undefined -> unit
      [@@js.set "shellQuoting"]

      val set_cwd : t -> string or_undefined -> unit [@@js.set "cwd"]
      val set_env : t -> string Dict.t or_undefined -> unit [@@js.set "env"]]

  let create ?executable ?shellArgs ?shellQuoting ?cwd ?env () =
    let obj = Ojs.obj [||] in
    iter_set obj "executable" Ojs.string_to_js executable;
    iter_set obj "shellArgs" (Ojs.list_to_js Ojs.string_to_js) shellArgs;
    iter_set obj "shellQuoting" ShellQuotingOptions.t_to_js shellQuoting;
    iter_set obj "cwd" Ojs.string_to_js cwd;
    iter_set obj "env" (Dict.t_to_js Ojs.string_to_js) env;
    t_of_js obj
  ;;
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
      val value : t -> string [@@js.get "value"]
      val quoting : t -> ShellQuoting.t [@@js.get "quoting"]]

  include
    [%js:
      val set_value : t -> string -> unit [@@js.set "value"]
      val set_quoting : t -> ShellQuoting.t -> unit [@@js.set "quoting"]]

  let create ~value ~quoting () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "value" (Ojs.string_to_js value);
    Ojs.set_prop_ascii obj "quoting" (ShellQuoting.t_to_js quoting);
    t_of_js obj
  ;;
end

module ShellExecution = struct
  include Class.Make ()

  type command =
    [ `String of string
    | `ShellQuotedString of ShellQuotedString.t
    ]

  let command_to_js = function
    | `String value -> Ojs.string_to_js value
    | `ShellQuotedString value -> ShellQuotedString.t_to_js value
  ;;

  let command_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "value"
      && binding_has_member js_val "quoting"
    then `ShellQuotedString (ShellQuotedString.t_of_js js_val)
    else invalid_arg "ShellExecution.command: unexpected JavaScript value"
  ;;

  type args_item =
    [ `String of string
    | `ShellQuotedString of ShellQuotedString.t
    ]

  let args_item_to_js = function
    | `String value -> Ojs.string_to_js value
    | `ShellQuotedString value -> ShellQuotedString.t_to_js value
  ;;

  let args_item_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "value"
      && binding_has_member js_val "quoting"
    then `ShellQuotedString (ShellQuotedString.t_of_js js_val)
    else invalid_arg "ShellExecution.args_item: unexpected JavaScript value"
  ;;

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
  ;;

  include
    [%js:
      val makeCommandLine
        :  commandLine:string
        -> ?options:ShellExecutionOptions.t
        -> unit
        -> t
      [@@js.new "@vscode.ShellExecution"]

      val makeCommandArgs
        :  command:shellString
        -> args:shellString list
        -> ?options:ShellExecutionOptions.t
        -> unit
        -> t
      [@@js.new "@vscode.ShellExecution"]

      val commandLine : t -> string or_undefined [@@js.get "commandLine"]
      val command : t -> command or_undefined [@@js.get "command"]
      val args : t -> args_item list or_undefined [@@js.get "args"]
      val options : t -> ShellExecutionOptions.t or_undefined [@@js.get "options"]
      val set_commandLine : t -> string or_undefined -> unit [@@js.set "commandLine"]
      val set_command : t -> command or_undefined -> unit [@@js.set "command"]
      val set_args : t -> args_item list or_undefined -> unit [@@js.set "args"]

      val set_options : t -> ShellExecutionOptions.t or_undefined -> unit
      [@@js.set "options"]]
end

module ProcessExecutionOptions = struct
  include Interface.Make ()

  include
    [%js:
      val cwd : t -> string or_undefined [@@js.get "cwd"]
      val env : t -> string Dict.t or_undefined [@@js.get "env"]]

  include
    [%js:
      val set_cwd : t -> string or_undefined -> unit [@@js.set "cwd"]
      val set_env : t -> string Dict.t or_undefined -> unit [@@js.set "env"]]

  let create ?cwd ?env () =
    let obj = Ojs.obj [||] in
    iter_set obj "cwd" Ojs.string_to_js cwd;
    iter_set obj "env" (Dict.t_to_js Ojs.string_to_js) env;
    t_of_js obj
  ;;
end

module ProcessExecution = struct
  include Class.Make ()

  include
    [%js:
      val makeProcess : process:string -> ?options:ProcessExecutionOptions.t -> unit -> t
      [@@js.new "@vscode.ProcessExecution"]

      val makeProcessArgs
        :  process:string
        -> args:string list
        -> ?options:ProcessExecutionOptions.t
        -> unit
        -> t
      [@@js.new "@vscode.ProcessExecution"]

      val process : t -> string [@@js.get "process"]
      val args : t -> string list [@@js.get "args"]
      val options : t -> ProcessExecutionOptions.t or_undefined [@@js.get "options"]
      val set_process : t -> string -> unit [@@js.set "process"]
      val set_args : t -> string list -> unit [@@js.set "args"]

      val set_options : t -> ProcessExecutionOptions.t or_undefined -> unit
      [@@js.set "options"]]
end

module TaskDefinition = struct
  include Interface.Make ()
  include [%js: val type_ : t -> string [@@js.get "type"]]

  let get_attribute t = Ojs.get_prop_ascii ([%js.of: t] t)
  let set_attribute t = Ojs.set_prop_ascii ([%js.of: t] t)

  let create ~type_ ?(attributes = []) () =
    let obj = Ojs.obj [| "type", [%js.of: string] type_ |] in
    let set (key, value) = Ojs.set_prop_ascii obj key value in
    List.iter set attributes;
    [%js.to: t] obj
  ;;

  let getProperty this ~key =
    (or_undefined_of_js Ojs.t_of_js) (Ojs.get_prop (t_to_js this) (Ojs.string_to_js key))
  ;;

  let setProperty this ~key ~value =
    Ojs.set_prop (t_to_js this) (Ojs.string_to_js key) (Ojs.t_to_js value)
  ;;
end

module CustomExecution = struct
  include Class.Make ()

  include
    [%js:
      val make
        :  callback:(resolvedDefinition:TaskDefinition.t -> Pseudoterminal.t Promise.t)
        -> t
      [@@js.new "@vscode.CustomExecution"]]
end

module RelativePattern = struct
  include Class.Make ()

  include
    [%js:
      val base : t -> string [@@js.get "base"]
      val pattern : t -> string [@@js.get "pattern"]

      val make
        :  base:
             ([ `WorkspaceFolder of WorkspaceFolder.t
              | `Uri of Uri.t
              | `String of string
              ]
             [@js.union])
        -> pattern:string
        -> t
      [@@js.new "@vscode.RelativePattern"]

      val baseUri : t -> Uri.t [@@js.get "baseUri"]
      val set_baseUri : t -> Uri.t -> unit [@@js.set "baseUri"]
      val set_base : t -> string -> unit [@@js.set "base"]
      val set_pattern : t -> string -> unit [@@js.set "pattern"]]
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
  ;;
end

module DocumentFilter = struct
  include Interface.Make ()

  include
    [%js:
      val language : t -> string or_undefined [@@js.get "language"]
      val scheme : t -> string or_undefined [@@js.get "scheme"]
      val pattern : t -> GlobPattern.t or_undefined [@@js.get "pattern"]]

  include [%js: val notebookType : t -> string or_undefined [@@js.get "notebookType"]]

  let create ?language ?notebookType ?scheme ?pattern () =
    let obj = Ojs.obj [||] in
    iter_set obj "language" Ojs.string_to_js language;
    iter_set obj "notebookType" Ojs.string_to_js notebookType;
    iter_set obj "scheme" Ojs.string_to_js scheme;
    iter_set obj "pattern" GlobPattern.t_to_js pattern;
    t_of_js obj
  ;;
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
  ;;

  type t =
    ([ `Filter of DocumentFilter.t
     | `String of string
     | `List of selector list
     ]
    [@js.union])
  [@@js]

  let t_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String ([%js.to: string] js_val)
    else if binding_has_member js_val "length"
    then `List ([%js.to: selector list] js_val)
    else `Filter ([%js.to: DocumentFilter.t] js_val)
  ;;
end

module DocumentFormattingEditProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideDocumentFormattingEdits
        :  t
        -> document:TextDocument.t
        -> options:FormattingOptions.t
        -> token:CancellationToken.t
        -> TextEdit.t list ProviderResult.t
      [@@js.call]]

  let create ~provideDocumentFormattingEdits () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideDocumentFormattingEdits"
      ([%js.of:
         document:TextDocument.t
         -> options:FormattingOptions.t
         -> token:CancellationToken.t
         -> TextEdit.t list ProviderResult.t]
         provideDocumentFormattingEdits);
    t_of_js obj
  ;;
end

module Hover = struct
  include Interface.Make ()

  type contents_item =
    [ `MarkdownString of MarkdownString.t
    | `MarkedString of MarkedString.t
    ]

  let contents_item_to_js = function
    | `MarkdownString value -> MarkdownString.t_to_js value
    | `MarkedString value -> MarkedString.t_to_js value
  ;;

  let contents_item_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else if
        Ojs.type_of js_val = "string"
        || ((Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "language"
            && binding_has_member js_val "value")
      then `MarkedString (MarkedString.t_of_js js_val)
      else invalid_arg "Hover.contents_item: unexpected JavaScript value"
  ;;

  type make_with_contents =
    [ `MarkdownString of MarkdownString.t
    | `MarkedString of MarkedString.t
    | `Array of contents_item list
    ]

  let make_with_contents_to_js = function
    | `MarkdownString value -> MarkdownString.t_to_js value
    | `MarkedString value -> MarkedString.t_to_js value
    | `Array value -> (Ojs.list_to_js contents_item_to_js) value
  ;;

  let make_with_contents_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else if
        Ojs.type_of js_val = "string"
        || ((Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "language"
            && binding_has_member js_val "value")
      then `MarkedString (MarkedString.t_of_js js_val)
      else if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            (Ojs.type_of js_val = "object"
             && (not (Ojs.is_null js_val))
             && binding_has_member js_val "value"
             && binding_has_member js_val "appendText"
             && binding_has_member js_val "appendMarkdown"
             && binding_has_member js_val "appendCodeblock")
            || Ojs.type_of js_val = "string"
            || ((Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
                && (not (Ojs.is_null js_val))
                && binding_has_member js_val "language"
                && binding_has_member js_val "value"))
      then `Array ((Ojs.list_of_js contents_item_of_js) js_val)
      else invalid_arg "Hover.make_with_contents: unexpected JavaScript value"
  ;;

  include
    [%js:
      val contents : t -> contents_item list [@@js.get "contents"]
      val range : t -> Range.t or_undefined [@@js.get "range"]

      val make
        :  contents:
             ([ `MarkdownString of MarkdownString.t
              | `MarkdownStringArray of MarkdownString.t list
              ]
             [@js.union])
        -> ?range:Range.t
        -> unit
        -> t
      [@@js.new "@vscode.Hover"]

      val set_contents : t -> contents_item list -> unit [@@js.set "contents"]
      val set_range : t -> Range.t or_undefined -> unit [@@js.set "range"]]

  let makeWithContents ~contents ?range () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "Hover")
         (binding_arguments
            [| make_with_contents_to_js contents
             ; (or_undefined_to_js Range.t_to_js) range
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module HoverProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideHover
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> Hover.t ProviderResult.t
      [@@js.call]]

  let create ~provideHover () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideHover"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> token:CancellationToken.t
         -> Hover.t ProviderResult.t]
         provideHover);
    t_of_js obj
  ;;
end

module TaskGroup = struct
  include Class.Make ()

  include
    [%js:
      val clean : t [@@js.global "@vscode.TaskGroup.Clean"]
      val build : t [@@js.global "@vscode.TaskGroup.Build"]
      val rebuild : t [@@js.global "@vscode.TaskGroup.Rebuild"]
      val test : t [@@js.global "@vscode.TaskGroup.Test"]
      val set_clean : t -> unit [@@js.set "@vscode.TaskGroup.Clean"]
      val set_build : t -> unit [@@js.set "@vscode.TaskGroup.Build"]
      val set_rebuild : t -> unit [@@js.set "@vscode.TaskGroup.Rebuild"]
      val set_test : t -> unit [@@js.set "@vscode.TaskGroup.Test"]
      val isDefault : t -> bool or_undefined [@@js.get "isDefault"]
      val id : t -> string [@@js.get "id"]]
end

module TaskScope = struct
  type t =
    | Global [@js 1]
    | Workspace [@js 2]
  [@@js.enum] [@@js]
end

module RunOptions = struct
  include Interface.Make ()

  include
    [%js: val reevaluateOnRerun : t -> bool or_undefined [@@js.get "reevaluateOnRerun"]]

  include
    [%js:
      val set_reevaluateOnRerun : t -> bool or_undefined -> unit
      [@@js.set "reevaluateOnRerun"]]

  let create ?reevaluateOnRerun () =
    let obj = Ojs.obj [||] in
    iter_set obj "reevaluateOnRerun" Ojs.bool_to_js reevaluateOnRerun;
    t_of_js obj
  ;;
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
      val reveal : t -> TaskRevealKind.t or_undefined [@@js.get "reveal"]
      val echo : t -> bool or_undefined [@@js.get "echo"]
      val focus : t -> bool or_undefined [@@js.get "focus"]
      val panel : t -> TaskPanelKind.t or_undefined [@@js.get "panel"]
      val showReuseMessage : t -> bool or_undefined [@@js.get "showReuseMessage"]
      val clear : t -> bool or_undefined [@@js.get "clear"]]

  include
    [%js:
      val set_reveal : t -> TaskRevealKind.t or_undefined -> unit [@@js.set "reveal"]
      val set_echo : t -> bool or_undefined -> unit [@@js.set "echo"]
      val set_focus : t -> bool or_undefined -> unit [@@js.set "focus"]
      val set_panel : t -> TaskPanelKind.t or_undefined -> unit [@@js.set "panel"]

      val set_showReuseMessage : t -> bool or_undefined -> unit
      [@@js.set "showReuseMessage"]

      val set_clear : t -> bool or_undefined -> unit [@@js.set "clear"]
      val close : t -> bool or_undefined [@@js.get "close"]
      val set_close : t -> bool or_undefined -> unit [@@js.set "close"]]

  let create ?reveal ?echo ?focus ?panel ?showReuseMessage ?clear ?close () =
    let obj = Ojs.obj [||] in
    iter_set obj "reveal" TaskRevealKind.t_to_js reveal;
    iter_set obj "echo" Ojs.bool_to_js echo;
    iter_set obj "focus" Ojs.bool_to_js focus;
    iter_set obj "panel" TaskPanelKind.t_to_js panel;
    iter_set obj "showReuseMessage" Ojs.bool_to_js showReuseMessage;
    iter_set obj "clear" Ojs.bool_to_js clear;
    iter_set obj "close" Ojs.bool_to_js close;
    t_of_js obj
  ;;
end

module Task = struct
  include Class.Make ()

  type make_with_scope =
    [ `WorkspaceFolder of WorkspaceFolder.t
    | `TaskScope of TaskScope.t
    ]

  let make_with_scope_to_js = function
    | `WorkspaceFolder value -> WorkspaceFolder.t_to_js value
    | `TaskScope value -> TaskScope.t_to_js value
  ;;

  let make_with_scope_of_js js_val =
    if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "uri"
      && binding_has_member js_val "name"
      && binding_has_member js_val "index"
    then `WorkspaceFolder (WorkspaceFolder.t_of_js js_val)
    else if Ojs.type_of js_val = "number"
    then `TaskScope (TaskScope.t_of_js js_val)
    else invalid_arg "Task.make_with_scope: unexpected JavaScript value"
  ;;

  type make_with_scope_execution =
    [ `ProcessExecution of ProcessExecution.t
    | `ShellExecution of ShellExecution.t
    | `CustomExecution of CustomExecution.t
    ]

  let make_with_scope_execution_to_js = function
    | `ProcessExecution value -> ProcessExecution.t_to_js value
    | `ShellExecution value -> ShellExecution.t_to_js value
    | `CustomExecution value -> CustomExecution.t_to_js value
  ;;

  let make_with_scope_execution_of_js js_val =
    match
      binding_constructor
        js_val
        [ "ProcessExecution"; "ShellExecution"; "CustomExecution" ]
    with
    | Some "ProcessExecution" -> `ProcessExecution (ProcessExecution.t_of_js js_val)
    | Some "ShellExecution" -> `ShellExecution (ShellExecution.t_of_js js_val)
    | Some "CustomExecution" -> `CustomExecution (CustomExecution.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "process"
        && binding_has_member js_val "args"
      then `ProcessExecution (ProcessExecution.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "commandLine"
        && binding_has_member js_val "command"
        && binding_has_member js_val "args"
      then `ShellExecution (ShellExecution.t_of_js js_val)
      else if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
      then `CustomExecution (CustomExecution.t_of_js js_val)
      else invalid_arg "Task.make_with_scope_execution: unexpected JavaScript value"
  ;;

  type make_with_scope_problem_matchers =
    [ `String of string
    | `Items of string list
    ]

  let make_with_scope_problem_matchers_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Items value -> (Ojs.list_to_js Ojs.string_to_js) value
  ;;

  let make_with_scope_problem_matchers_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "string")
    then `Items ((Ojs.list_of_js Ojs.string_of_js) js_val)
    else invalid_arg "Task.make_with_scope_problem_matchers: unexpected JavaScript value"
  ;;

  type make_without_scope_execution =
    [ `ProcessExecution of ProcessExecution.t
    | `ShellExecution of ShellExecution.t
    ]

  let make_without_scope_execution_to_js = function
    | `ProcessExecution value -> ProcessExecution.t_to_js value
    | `ShellExecution value -> ShellExecution.t_to_js value
  ;;

  let make_without_scope_execution_of_js js_val =
    match binding_constructor js_val [ "ProcessExecution"; "ShellExecution" ] with
    | Some "ProcessExecution" -> `ProcessExecution (ProcessExecution.t_of_js js_val)
    | Some "ShellExecution" -> `ShellExecution (ShellExecution.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "process"
        && binding_has_member js_val "args"
      then `ProcessExecution (ProcessExecution.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "commandLine"
        && binding_has_member js_val "command"
        && binding_has_member js_val "args"
      then `ShellExecution (ShellExecution.t_of_js js_val)
      else invalid_arg "Task.make_without_scope_execution: unexpected JavaScript value"
  ;;

  type scope =
    [ `TaskScope of TaskScope.t
    | `WorkspaceFolder of WorkspaceFolder.t
    ]

  let scope_to_js = function
    | `TaskScope value -> TaskScope.t_to_js value
    | `WorkspaceFolder value -> WorkspaceFolder.t_to_js value
  ;;

  let scope_of_js js_val =
    if Ojs.type_of js_val = "number"
    then `TaskScope (TaskScope.t_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "uri"
      && binding_has_member js_val "name"
      && binding_has_member js_val "index"
    then `WorkspaceFolder (WorkspaceFolder.t_of_js js_val)
    else invalid_arg "Task.scope: unexpected JavaScript value"
  ;;

  type execution =
    ([ `ProcessExecution of ProcessExecution.t
     | `ShellExecution of ShellExecution.t
     | `CustomExecution of CustomExecution.t
     ]
    [@js.union])
  [@@js]

  let execution_of_js js_val =
    if binding_has_member js_val "process"
    then `ProcessExecution ([%js.to: ProcessExecution.t] js_val)
    else if binding_has_member js_val "command"
    then `ShellExecution ([%js.to: ShellExecution.t] js_val)
    else `CustomExecution ([%js.to: CustomExecution.t] js_val)
  ;;

  include
    [%js:
      val make
        :  definition:TaskDefinition.t
        -> scope:TaskScope.t
        -> name:string
        -> source:string
        -> ?execution:execution
        -> ?problemMatchers:string list
        -> unit
        -> t
      [@@js.new "@vscode.Task"]

      val definition : t -> TaskDefinition.t [@@js.get "definition"]
      val scope : t -> scope or_undefined [@@js.get "scope"]
      val name : t -> string [@@js.get "name"]
      val detail : t -> string or_undefined [@@js.get "detail"]
      val execution : t -> make_with_scope_execution or_undefined [@@js.get "execution"]
      val isBackground : t -> bool [@@js.get "isBackground"]
      val source : t -> string [@@js.get "source"]
      val group : t -> TaskGroup.t or_undefined [@@js.get "group"]

      val presentationOptions : t -> TaskPresentationOptions.t
      [@@js.get "presentationOptions"]

      val runOptions : t -> RunOptions.t [@@js.get "runOptions"]
      val set_group : t -> TaskGroup.t or_undefined -> unit [@@js.set "group"]]

  let makeWithScope ~taskDefinition ~scope ~name ~source ?execution ?problemMatchers () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "Task")
         (binding_arguments
            [| TaskDefinition.t_to_js taskDefinition
             ; make_with_scope_to_js scope
             ; Ojs.string_to_js name
             ; Ojs.string_to_js source
             ; (or_undefined_to_js make_with_scope_execution_to_js) execution
             ; (or_undefined_to_js make_with_scope_problem_matchers_to_js) problemMatchers
            |]
            4
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let makeWithoutScope ~taskDefinition ~name ~source ?execution ?problemMatchers () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "Task")
         (binding_arguments
            [| TaskDefinition.t_to_js taskDefinition
             ; Ojs.string_to_js name
             ; Ojs.string_to_js source
             ; (or_undefined_to_js make_without_scope_execution_to_js) execution
             ; (or_undefined_to_js make_with_scope_problem_matchers_to_js) problemMatchers
            |]
            3
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val set_definition : t -> TaskDefinition.t -> unit [@@js.set "definition"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val set_detail : t -> string or_undefined -> unit [@@js.set "detail"]

      val set_execution : t -> make_with_scope_execution or_undefined -> unit
      [@@js.set "execution"]

      val set_isBackground : t -> bool -> unit [@@js.set "isBackground"]
      val set_source : t -> string -> unit [@@js.set "source"]

      val set_presentationOptions : t -> TaskPresentationOptions.t -> unit
      [@@js.set "presentationOptions"]

      val problemMatchers : t -> string list [@@js.get "problemMatchers"]
      val set_problemMatchers : t -> string list -> unit [@@js.set "problemMatchers"]
      val set_runOptions : t -> RunOptions.t -> unit [@@js.set "runOptions"]]
end

module TaskProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val provideTasks : t -> token:CancellationToken.t -> T.t list ProviderResult.t
        [@@js.call]

        val resolveTask
          :  t
          -> task:T.t
          -> token:CancellationToken.t
          -> T.t ProviderResult.t
        [@@js.call]]

    let create ~provideTasks ~resolveTask () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "provideTasks"
        ([%js.of: token:CancellationToken.t -> T.t list ProviderResult.t] provideTasks);
      Ojs.set_prop_ascii
        obj
        "resolveTask"
        ([%js.of: task:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
           resolveTask);
      t_of_js obj
    ;;
  end

  module Default = Make (Task)
end

module ConfigurationScope = struct
  type language =
    { uri : Uri.t or_undefined
    ; languageId : string
    }
  [@@js]

  type t =
    ([ `Uri of Uri.t
     | `TextDocument of TextDocument.t
     | `WorkspaceFolder of WorkspaceFolder.t
     | `Language of language
     ]
    [@js.union])
  [@@js]

  let t_of_js value =
    if binding_has_member value "scheme"
    then `Uri (Uri.t_of_js value)
    else if binding_has_member value "fileName"
    then `TextDocument (TextDocument.t_of_js value)
    else if binding_has_member value "index"
    then `WorkspaceFolder (WorkspaceFolder.t_of_js value)
    else `Language (language_of_js value)
  ;;
end

module MessageOptions = struct
  include Interface.Make ()
  include [%js: val modal : t -> bool or_undefined [@@js.get "modal"]]

  include
    [%js:
      val set_modal : t -> bool or_undefined -> unit [@@js.set "modal"]
      val detail : t -> string or_undefined [@@js.get "detail"]
      val set_detail : t -> string or_undefined -> unit [@@js.set "detail"]]

  let create ?modal ?detail () =
    let obj = Ojs.obj [||] in
    iter_set obj "modal" Ojs.bool_to_js modal;
    iter_set obj "detail" Ojs.string_to_js detail;
    t_of_js obj
  ;;
end

module Progress = struct
  module G = Interface.Generic (Ojs) ()
  include G

  type value =
    { message : string or_undefined
    ; increment : float or_undefined
    }
  [@@js]

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include [%js: val report : t -> value:T.t -> unit [@@js.call "report"]]
  end
end

module TextDocumentContentChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val range : t -> Range.t [@@js.get "range"]
      val rangeLength : t -> int [@@js.get "rangeLength"]
      val rangeOffset : t -> int [@@js.get "rangeOffset"]
      val text : t -> string [@@js.get "text"]]

  let create ~range ~rangeOffset ~rangeLength ~text () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "range" (Range.t_to_js range);
    Ojs.set_prop_ascii obj "rangeOffset" (Ojs.int_to_js rangeOffset);
    Ojs.set_prop_ascii obj "rangeLength" (Ojs.int_to_js rangeLength);
    Ojs.set_prop_ascii obj "text" (Ojs.string_to_js text);
    t_of_js obj
  ;;
end

module TextDocumentChangeReason = struct
  type t =
    | Undo [@js 1]
    | Redo [@js 2]
  [@@js.enum] [@@js]
end

module TextDocumentChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val contentChanges : t -> TextDocumentContentChangeEvent.t list
      [@@js.get "contentChanges"]

      val document : t -> TextDocument.t [@@js.get "document"]
      val reason : t -> TextDocumentChangeReason.t or_undefined [@@js.get "reason"]]

  let create ~document ~contentChanges ~reason () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "document" (TextDocument.t_to_js document);
    Ojs.set_prop_ascii
      obj
      "contentChanges"
      ((Ojs.list_to_js TextDocumentContentChangeEvent.t_to_js) contentChanges);
    Ojs.set_prop_ascii
      obj
      "reason"
      ((or_undefined_to_js TextDocumentChangeReason.t_to_js) reason);
    t_of_js obj
  ;;
end

module TextDocumentContentProvider = struct
  include Interface.Make ()

  include
    [%js:
      val onDidChange : t -> Uri.t Event.t or_undefined [@@js.get "onDidChange"]

      val provideTextDocumentContent
        :  t
        -> uri:Uri.t
        -> token:CancellationToken.t
        -> string ProviderResult.t
      [@@js.call]]

  include
    [%js:
      val set_onDidChange : t -> Uri.t Event.t or_undefined -> unit
      [@@js.set "onDidChange"]]

  let create ?onDidChange ~provideTextDocumentContent () =
    let obj = Ojs.obj [||] in
    iter_set obj "onDidChange" (Event.t_to_js Uri.t_to_js) onDidChange;
    Ojs.set_prop_ascii
      obj
      "provideTextDocumentContent"
      ([%js.of: uri:Uri.t -> token:CancellationToken.t -> string ProviderResult.t]
         provideTextDocumentContent);
    t_of_js obj
  ;;
end

module FileSystemWatcher = struct
  include Interface.Extend (Disposable) ()

  type from_disposable_likes_item = { dispose : unit -> Ojs.t }

  let from_disposable_likes_item_to_js (value : from_disposable_likes_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "dispose" ([%js.of: unit -> Ojs.t] value.dispose);
    js_val
  ;;

  let from_disposable_likes_item_of_js js_val : from_disposable_likes_item =
    { dispose = [%js.to: unit -> Ojs.t] (Ojs.get_prop_ascii js_val "dispose") }
  ;;

  include [%js: val onDidChange : t -> Uri.t Event.t [@@js.get "onDidChange"]]

  let to_disposable (value : t) = (value :> Disposable.t)

  include
    [%js:
      val from
        :  disposableLikes:(from_disposable_likes_item list[@js.variadic])
        -> Disposable.t
      [@@js.global "@vscode.FileSystemWatcher.from"]

      val dispose : t -> Ojs.t [@@js.call "dispose"]
      val ignoreCreateEvents : t -> bool [@@js.get "ignoreCreateEvents"]
      val ignoreChangeEvents : t -> bool [@@js.get "ignoreChangeEvents"]
      val ignoreDeleteEvents : t -> bool [@@js.get "ignoreDeleteEvents"]
      val onDidCreate : t -> Uri.t Event.t [@@js.get "onDidCreate"]
      val onDidDelete : t -> Uri.t Event.t [@@js.get "onDidDelete"]]
end

module ConfigurationChangeEvent = struct
  include Interface.Make ()

  let affectsConfiguration this ~section ?scope () =
    Ojs.bool_of_js
      (Ojs.call
         (t_to_js this)
         "affectsConfiguration"
         (binding_arguments
            [| Ojs.string_to_js section
             ; (or_undefined_to_js ConfigurationScope.t_to_js) scope
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let create ~affectsConfiguration () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "affectsConfiguration"
      ([%js.of: section:string -> ?scope:ConfigurationScope.t -> unit -> bool]
         affectsConfiguration);
    t_of_js obj
  ;;
end

module TextEncodingOptions = struct
  include Interface.Make ()

  include
    [%js:
      val encoding : t -> string or_undefined [@@js.get]
      val uri : t -> Uri.t or_undefined [@@js.get]
      val of_encoding : encoding:string -> t [@@js.builder]
      val of_uri : uri:Uri.t -> t [@@js.builder]]
end

module TextDocumentEncodingOptions = struct
  include Interface.Make ()

  include
    [%js:
      val encoding : t -> string or_undefined [@@js.get]
      val create : ?encoding:string -> unit -> t [@@js.builder]]
end

module TextDocumentOpenOptions = struct
  include Interface.Make ()

  include
    [%js:
      val encoding : t -> string or_undefined [@@js.get]
      val language : t -> string or_undefined [@@js.get]
      val content : t -> string or_undefined [@@js.get]

      val create : ?encoding:string -> ?language:string -> ?content:string -> unit -> t
      [@@js.builder]]
end

module FileType = struct
  type t = int [@@js]

  let unknown = 0
  let file = 1
  let directory = 2
  let symbolicLink = 64
  let combine flags = List.fold_left ( lor ) 0 flags
  let mem value ~flag = value land flag = flag
end

module FilePermission = struct
  type t = Readonly [@js 1] [@@js.enum] [@@js]
end

module FileStat = struct
  include Interface.Make ()

  include
    [%js:
      val type_ : t -> FileType.t [@@js.get "type"]
      val set_type_ : t -> FileType.t -> unit [@@js.set "type"]
      val ctime : t -> float [@@js.get "ctime"]
      val set_ctime : t -> float -> unit [@@js.set "ctime"]
      val mtime : t -> float [@@js.get "mtime"]
      val set_mtime : t -> float -> unit [@@js.set "mtime"]
      val size : t -> float [@@js.get "size"]
      val set_size : t -> float -> unit [@@js.set "size"]
      val permissions : t -> FilePermission.t or_undefined [@@js.get "permissions"]

      val set_permissions : t -> FilePermission.t or_undefined -> unit
      [@@js.set "permissions"]]

  let create ~type_ ~ctime ~mtime ~size ?permissions () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "type" (FileType.t_to_js type_);
    Ojs.set_prop_ascii obj "ctime" (Ojs.float_to_js ctime);
    Ojs.set_prop_ascii obj "mtime" (Ojs.float_to_js mtime);
    Ojs.set_prop_ascii obj "size" (Ojs.float_to_js size);
    iter_set obj "permissions" FilePermission.t_to_js permissions;
    t_of_js obj
  ;;
end

module FileSystem = struct
  include Interface.Make ()

  type delete_options =
    { recursive : bool or_undefined
    ; useTrash : bool or_undefined
    }

  let delete_options_to_js (value : delete_options) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "recursive" Ojs.bool_to_js value.recursive;
    iter_set js_val "useTrash" Ojs.bool_to_js value.useTrash;
    js_val
  ;;

  let delete_options_of_js js_val : delete_options =
    { recursive =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "recursive")
    ; useTrash =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "useTrash")
    }
  ;;

  type rename_options = { overwrite : bool or_undefined }

  let rename_options_to_js (value : rename_options) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "overwrite" Ojs.bool_to_js value.overwrite;
    js_val
  ;;

  let rename_options_of_js js_val : rename_options =
    { overwrite =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "overwrite")
    }
  ;;

  include
    [%js:
      val stat : t -> uri:Uri.t -> FileStat.t Promise.t [@@js.call "stat"]

      val readDirectory : t -> uri:Uri.t -> (string * FileType.t) list Promise.t
      [@@js.call "readDirectory"]

      val createDirectory : t -> uri:Uri.t -> unit Promise.t [@@js.call "createDirectory"]
      val readFile : t -> uri:Uri.t -> Uint8Array.t Promise.t [@@js.call "readFile"]

      val writeFile : t -> uri:Uri.t -> content:Uint8Array.t -> unit Promise.t
      [@@js.call "writeFile"]]

  let delete this ~uri ?options () =
    (Promise.t_of_js (fun _ -> ()))
      (Ojs.call
         (t_to_js this)
         "delete"
         (binding_arguments
            [| Uri.t_to_js uri; (or_undefined_to_js delete_options_to_js) options |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let rename this ~source ~target ?options () =
    (Promise.t_of_js (fun _ -> ()))
      (Ojs.call
         (t_to_js this)
         "rename"
         (binding_arguments
            [| Uri.t_to_js source
             ; Uri.t_to_js target
             ; (or_undefined_to_js rename_options_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let copy this ~source ~target ?options () =
    (Promise.t_of_js (fun _ -> ()))
      (Ojs.call
         (t_to_js this)
         "copy"
         (binding_arguments
            [| Uri.t_to_js source
             ; Uri.t_to_js target
             ; (or_undefined_to_js rename_options_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val isWritableFileSystem : t -> scheme:string -> bool or_undefined
      [@@js.call "isWritableFileSystem"]]

  let create
        ~stat
        ~readDirectory
        ~createDirectory
        ~readFile
        ~writeFile
        ~delete
        ~rename
        ~copy
        ~isWritableFileSystem
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "stat" ([%js.of: uri:Uri.t -> FileStat.t Promise.t] stat);
    Ojs.set_prop_ascii
      obj
      "readDirectory"
      ([%js.of: uri:Uri.t -> (string * FileType.t) list Promise.t] readDirectory);
    Ojs.set_prop_ascii
      obj
      "createDirectory"
      ([%js.of: uri:Uri.t -> unit Promise.t] createDirectory);
    Ojs.set_prop_ascii
      obj
      "readFile"
      ([%js.of: uri:Uri.t -> Uint8Array.t Promise.t] readFile);
    Ojs.set_prop_ascii
      obj
      "writeFile"
      ([%js.of: uri:Uri.t -> content:Uint8Array.t -> unit Promise.t] writeFile);
    Ojs.set_prop_ascii
      obj
      "delete"
      ([%js.of: uri:Uri.t -> ?options:delete_options -> unit -> unit Promise.t] delete);
    Ojs.set_prop_ascii
      obj
      "rename"
      ([%js.of:
         source:Uri.t -> target:Uri.t -> ?options:rename_options -> unit -> unit Promise.t]
         rename);
    Ojs.set_prop_ascii
      obj
      "copy"
      ([%js.of:
         source:Uri.t -> target:Uri.t -> ?options:rename_options -> unit -> unit Promise.t]
         copy);
    Ojs.set_prop_ascii
      obj
      "isWritableFileSystem"
      ([%js.of: scheme:string -> bool or_undefined] isWritableFileSystem);
    t_of_js obj
  ;;
end

module WorkspaceEditMetadata = struct
  include Interface.Make ()

  include
    [%js:
      val isRefactoring : t -> bool or_undefined [@@js.get "isRefactoring"]
      val set_isRefactoring : t -> bool or_undefined -> unit [@@js.set "isRefactoring"]]

  let create ?isRefactoring () =
    let obj = Ojs.obj [||] in
    iter_set obj "isRefactoring" Ojs.bool_to_js isRefactoring;
    t_of_js obj
  ;;
end

module TextDocumentSaveReason = struct
  type t =
    | Manual [@js 1]
    | AfterDelay [@js 2]
    | FocusOut [@js 3]
  [@@js.enum] [@@js]
end

module TextDocumentWillSaveEvent = struct
  include Interface.Make ()

  include
    [%js:
      val document : t -> TextDocument.t [@@js.get "document"]
      val reason : t -> TextDocumentSaveReason.t [@@js.get "reason"]

      val waitUntil : t -> thenable:TextEdit.t list Promise.t -> unit
      [@@js.call "waitUntil"]

      val waitUntilDone : t -> thenable:Ojs.t Promise.t -> unit [@@js.call "waitUntil"]]
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
end = struct
  include Interface.Make ()

  include
    [%js:
      val uri : t -> Uri.t [@@js.get "uri"]
      val notebookType : t -> string [@@js.get "notebookType"]
      val version : t -> int [@@js.get "version"]
      val isDirty : t -> bool [@@js.get "isDirty"]
      val isUntitled : t -> bool [@@js.get "isUntitled"]
      val isClosed : t -> bool [@@js.get "isClosed"]
      val metadata : t -> Ojs.t Dict.t [@@js.get "metadata"]
      val cellCount : t -> int [@@js.get "cellCount"]
      val cellAt : t -> index:int -> NotebookCell.t [@@js.call "cellAt"]]

  let getCells this ?range () =
    (Ojs.list_of_js NotebookCell.t_of_js)
      (Ojs.call
         (t_to_js this)
         "getCells"
         (binding_arguments
            [| (or_undefined_to_js NotebookRange.t_to_js) range |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include [%js: val save : t -> bool Promise.t [@@js.call "save"]]
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
end = struct
  include Interface.Make ()

  include
    [%js:
      val index : t -> int [@@js.get "index"]
      val notebook : t -> NotebookDocument.t [@@js.get "notebook"]
      val kind : t -> NotebookCellKind.t [@@js.get "kind"]
      val document : t -> TextDocument.t [@@js.get "document"]
      val metadata : t -> Ojs.t Dict.t [@@js.get "metadata"]
      val outputs : t -> NotebookCellOutput.t list [@@js.get "outputs"]

      val executionSummary : t -> NotebookCellExecutionSummary.t or_undefined
      [@@js.get "executionSummary"]]
end

module NotebookData = struct
  include Class.Make ()

  include
    [%js:
      val cells : t -> NotebookCellData.t list [@@js.get "cells"]
      val set_cells : t -> NotebookCellData.t list -> unit [@@js.set "cells"]
      val metadata : t -> Ojs.t Dict.t or_undefined [@@js.get "metadata"]
      val set_metadata : t -> Ojs.t Dict.t or_undefined -> unit [@@js.set "metadata"]
      val make : cells:NotebookCellData.t list -> t [@@js.new "@vscode.NotebookData"]]
end

module NotebookDocumentContentChange = struct
  include Interface.Make ()

  include
    [%js:
      val range : t -> NotebookRange.t [@@js.get "range"]
      val addedCells : t -> NotebookCell.t list [@@js.get "addedCells"]
      val removedCells : t -> NotebookCell.t list [@@js.get "removedCells"]]

  let create ~range ~addedCells ~removedCells () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "range" (NotebookRange.t_to_js range);
    Ojs.set_prop_ascii obj "addedCells" ((Ojs.list_to_js NotebookCell.t_to_js) addedCells);
    Ojs.set_prop_ascii
      obj
      "removedCells"
      ((Ojs.list_to_js NotebookCell.t_to_js) removedCells);
    t_of_js obj
  ;;
end

module NotebookDocumentCellChange = struct
  include Interface.Make ()

  include
    [%js:
      val cell : t -> NotebookCell.t [@@js.get "cell"]
      val document : t -> TextDocument.t or_undefined [@@js.get "document"]
      val metadata : t -> Ojs.t Dict.t or_undefined [@@js.get "metadata"]
      val outputs : t -> NotebookCellOutput.t list or_undefined [@@js.get "outputs"]

      val executionSummary : t -> NotebookCellExecutionSummary.t or_undefined
      [@@js.get "executionSummary"]]

  let create ~cell ~document ~metadata ~outputs ~executionSummary () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "cell" (NotebookCell.t_to_js cell);
    Ojs.set_prop_ascii obj "document" ((or_undefined_to_js TextDocument.t_to_js) document);
    Ojs.set_prop_ascii
      obj
      "metadata"
      ((or_undefined_to_js (Dict.t_to_js Ojs.t_to_js)) metadata);
    Ojs.set_prop_ascii
      obj
      "outputs"
      ((or_undefined_to_js (Ojs.list_to_js NotebookCellOutput.t_to_js)) outputs);
    Ojs.set_prop_ascii
      obj
      "executionSummary"
      ((or_undefined_to_js NotebookCellExecutionSummary.t_to_js) executionSummary);
    t_of_js obj
  ;;
end

module NotebookDocumentChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val notebook : t -> NotebookDocument.t [@@js.get "notebook"]
      val metadata : t -> Ojs.t Dict.t or_undefined [@@js.get "metadata"]

      val contentChanges : t -> NotebookDocumentContentChange.t list
      [@@js.get "contentChanges"]

      val cellChanges : t -> NotebookDocumentCellChange.t list [@@js.get "cellChanges"]]

  let create ~notebook ~metadata ~contentChanges ~cellChanges () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "notebook" (NotebookDocument.t_to_js notebook);
    Ojs.set_prop_ascii
      obj
      "metadata"
      ((or_undefined_to_js (Dict.t_to_js Ojs.t_to_js)) metadata);
    Ojs.set_prop_ascii
      obj
      "contentChanges"
      ((Ojs.list_to_js NotebookDocumentContentChange.t_to_js) contentChanges);
    Ojs.set_prop_ascii
      obj
      "cellChanges"
      ((Ojs.list_to_js NotebookDocumentCellChange.t_to_js) cellChanges);
    t_of_js obj
  ;;
end

module NotebookDocumentWillSaveEvent = struct
  include Interface.Make ()

  include
    [%js:
      val token : t -> CancellationToken.t [@@js.get "token"]
      val notebook : t -> NotebookDocument.t [@@js.get "notebook"]
      val reason : t -> TextDocumentSaveReason.t [@@js.get "reason"]

      val waitUntil : t -> thenable:WorkspaceEdit.t Promise.t -> unit
      [@@js.call "waitUntil"]

      val waitUntilDone : t -> thenable:Ojs.t Promise.t -> unit [@@js.call "waitUntil"]]
end

module NotebookSerializer = struct
  include Interface.Make ()

  type deserialize_notebook_result =
    [ `Value of NotebookData.t
    | `Promise of NotebookData.t Promise.t
    ]

  let deserialize_notebook_result_to_js = function
    | `Value value -> NotebookData.t_to_js value
    | `Promise value -> (Promise.t_to_js NotebookData.t_to_js) value
  ;;

  let deserialize_notebook_result_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js NotebookData.t_of_js) js_val)
    else (
      match binding_constructor js_val [ "NotebookData" ] with
      | Some "NotebookData" -> `Value (NotebookData.t_of_js js_val)
      | _ ->
        if
          Ojs.type_of js_val = "object"
          && (not (Ojs.is_null js_val))
          && binding_has_member js_val "cells"
        then `Value (NotebookData.t_of_js js_val)
        else
          invalid_arg
            "NotebookSerializer.deserialize_notebook_result: unexpected JavaScript value")
  ;;

  type serialize_notebook_result =
    [ `Value of Uint8Array.t
    | `Promise of Uint8Array.t Promise.t
    ]

  let serialize_notebook_result_to_js = function
    | `Value value -> Uint8Array.t_to_js value
    | `Promise value -> (Promise.t_to_js Uint8Array.t_to_js) value
  ;;

  let serialize_notebook_result_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js Uint8Array.t_of_js) js_val)
    else if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then `Value (Uint8Array.t_of_js js_val)
    else
      invalid_arg
        "NotebookSerializer.serialize_notebook_result: unexpected JavaScript value"
  ;;

  include
    [%js:
      val deserializeNotebook
        :  t
        -> content:Uint8Array.t
        -> token:CancellationToken.t
        -> deserialize_notebook_result
      [@@js.call "deserializeNotebook"]

      val serializeNotebook
        :  t
        -> data:NotebookData.t
        -> token:CancellationToken.t
        -> serialize_notebook_result
      [@@js.call "serializeNotebook"]]

  let create ~deserializeNotebook ~serializeNotebook () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "deserializeNotebook"
      ([%js.of:
         content:Uint8Array.t -> token:CancellationToken.t -> deserialize_notebook_result]
         deserializeNotebook);
    Ojs.set_prop_ascii
      obj
      "serializeNotebook"
      ([%js.of:
         data:NotebookData.t -> token:CancellationToken.t -> serialize_notebook_result]
         serializeNotebook);
    t_of_js obj
  ;;
end

module NotebookDocumentContentOptions = struct
  include Interface.Make ()

  include
    [%js:
      val transientOutputs : t -> bool or_undefined [@@js.get "transientOutputs"]

      val set_transientOutputs : t -> bool or_undefined -> unit
      [@@js.set "transientOutputs"]

      val transientCellMetadata : t -> bool or_undefined Dict.t or_undefined
      [@@js.get "transientCellMetadata"]

      val set_transientCellMetadata : t -> bool or_undefined Dict.t or_undefined -> unit
      [@@js.set "transientCellMetadata"]

      val transientDocumentMetadata : t -> bool or_undefined Dict.t or_undefined
      [@@js.get "transientDocumentMetadata"]

      val set_transientDocumentMetadata
        :  t
        -> bool or_undefined Dict.t or_undefined
        -> unit
      [@@js.set "transientDocumentMetadata"]]

  let create ?transientOutputs ?transientCellMetadata ?transientDocumentMetadata () =
    let obj = Ojs.obj [||] in
    iter_set obj "transientOutputs" Ojs.bool_to_js transientOutputs;
    iter_set
      obj
      "transientCellMetadata"
      (Dict.t_to_js (or_undefined_to_js Ojs.bool_to_js))
      transientCellMetadata;
    iter_set
      obj
      "transientDocumentMetadata"
      (Dict.t_to_js (or_undefined_to_js Ojs.bool_to_js))
      transientDocumentMetadata;
    t_of_js obj
  ;;
end

module FileWillCreateEvent = struct
  include Interface.Make ()

  include
    [%js:
      val token : t -> CancellationToken.t [@@js.get "token"]
      val files : t -> Uri.t list [@@js.get "files"]

      val waitUntil : t -> thenable:WorkspaceEdit.t Promise.t -> unit
      [@@js.call "waitUntil"]

      val waitUntilDone : t -> thenable:Ojs.t Promise.t -> unit [@@js.call "waitUntil"]]
end

module FileCreateEvent = struct
  include Interface.Make ()
  include [%js: val files : t -> Uri.t list [@@js.get "files"]]

  let create ~files () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "files" ((Ojs.list_to_js Uri.t_to_js) files);
    t_of_js obj
  ;;
end

module FileWillDeleteEvent = struct
  include Interface.Make ()

  include
    [%js:
      val token : t -> CancellationToken.t [@@js.get "token"]
      val files : t -> Uri.t list [@@js.get "files"]

      val waitUntil : t -> thenable:WorkspaceEdit.t Promise.t -> unit
      [@@js.call "waitUntil"]

      val waitUntilDone : t -> thenable:Ojs.t Promise.t -> unit [@@js.call "waitUntil"]]
end

module FileDeleteEvent = struct
  include Interface.Make ()
  include [%js: val files : t -> Uri.t list [@@js.get "files"]]

  let create ~files () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "files" ((Ojs.list_to_js Uri.t_to_js) files);
    t_of_js obj
  ;;
end

module FileWillRenameEvent = struct
  include Interface.Make ()

  type files_item =
    { oldUri : Uri.t
    ; newUri : Uri.t
    }

  let files_item_to_js (value : files_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "oldUri" (Uri.t_to_js value.oldUri);
    Ojs.set_prop_ascii js_val "newUri" (Uri.t_to_js value.newUri);
    js_val
  ;;

  let files_item_of_js js_val : files_item =
    { oldUri = Uri.t_of_js (Ojs.get_prop_ascii js_val "oldUri")
    ; newUri = Uri.t_of_js (Ojs.get_prop_ascii js_val "newUri")
    }
  ;;

  include
    [%js:
      val token : t -> CancellationToken.t [@@js.get "token"]
      val files : t -> files_item list [@@js.get "files"]

      val waitUntil : t -> thenable:WorkspaceEdit.t Promise.t -> unit
      [@@js.call "waitUntil"]

      val waitUntilDone : t -> thenable:Ojs.t Promise.t -> unit [@@js.call "waitUntil"]]
end

module FileRenameEvent = struct
  include Interface.Make ()

  type files_item =
    { oldUri : Uri.t
    ; newUri : Uri.t
    }

  let files_item_to_js (value : files_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "oldUri" (Uri.t_to_js value.oldUri);
    Ojs.set_prop_ascii js_val "newUri" (Uri.t_to_js value.newUri);
    js_val
  ;;

  let files_item_of_js js_val : files_item =
    { oldUri = Uri.t_of_js (Ojs.get_prop_ascii js_val "oldUri")
    ; newUri = Uri.t_of_js (Ojs.get_prop_ascii js_val "newUri")
    }
  ;;

  include [%js: val files : t -> files_item list [@@js.get "files"]]

  let create ~files () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "files" ((Ojs.list_to_js files_item_to_js) files);
    t_of_js obj
  ;;
end

module FileChangeType = struct
  type t =
    | Changed [@js 1]
    | Created [@js 2]
    | Deleted [@js 3]
  [@@js.enum] [@@js]
end

module FileChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val type_ : t -> FileChangeType.t [@@js.get "type"]
      val uri : t -> Uri.t [@@js.get "uri"]]

  let create ~type_ ~uri () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "type" (FileChangeType.t_to_js type_);
    Ojs.set_prop_ascii obj "uri" (Uri.t_to_js uri);
    t_of_js obj
  ;;
end

module FileSystemProvider = struct
  include Interface.Make ()

  type watch_options =
    { recursive : bool
    ; excludes : string list
    }

  let watch_options_to_js (value : watch_options) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "recursive" (Ojs.bool_to_js value.recursive);
    Ojs.set_prop_ascii
      js_val
      "excludes"
      ((Ojs.list_to_js Ojs.string_to_js) value.excludes);
    js_val
  ;;

  let watch_options_of_js js_val : watch_options =
    { recursive = Ojs.bool_of_js (Ojs.get_prop_ascii js_val "recursive")
    ; excludes = (Ojs.list_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "excludes")
    }
  ;;

  type stat_result =
    [ `Value of FileStat.t
    | `Promise of FileStat.t Promise.t
    ]

  let stat_result_to_js = function
    | `Value value -> FileStat.t_to_js value
    | `Promise value -> (Promise.t_to_js FileStat.t_to_js) value
  ;;

  let stat_result_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js FileStat.t_of_js) js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "type"
      && binding_has_member js_val "ctime"
      && binding_has_member js_val "mtime"
      && binding_has_member js_val "size"
    then `Value (FileStat.t_of_js js_val)
    else invalid_arg "FileSystemProvider.stat_result: unexpected JavaScript value"
  ;;

  type read_directory_result =
    [ `Value of (string * FileType.t) list
    | `Promise of (string * FileType.t) list Promise.t
    ]

  let read_directory_result_to_js = function
    | `Value value ->
      (Ojs.list_to_js (fun (v0, v1) ->
         Ojs.array_to_js Ojs.t_to_js [| Ojs.string_to_js v0; FileType.t_to_js v1 |]))
        value
    | `Promise value ->
      (Promise.t_to_js
         (Ojs.list_to_js (fun (v0, v1) ->
            Ojs.array_to_js Ojs.t_to_js [| Ojs.string_to_js v0; FileType.t_to_js v1 |])))
        value
  ;;

  let read_directory_result_of_js js_val =
    if binding_is_thenable js_val
    then
      `Promise
        ((Promise.t_of_js
            (Ojs.list_of_js (fun js_val ->
               ( Ojs.string_of_js (Ojs.array_get js_val 0)
               , FileType.t_of_js (Ojs.array_get js_val 1) ))))
           js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          binding_is_array js_val)
    then
      `Value
        ((Ojs.list_of_js (fun js_val ->
            ( Ojs.string_of_js (Ojs.array_get js_val 0)
            , FileType.t_of_js (Ojs.array_get js_val 1) )))
           js_val)
    else
      invalid_arg "FileSystemProvider.read_directory_result: unexpected JavaScript value"
  ;;

  type create_directory_result =
    [ `Unit of unit
    | `Promise of unit Promise.t
    ]

  let create_directory_result_to_js = function
    | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
    | `Promise value ->
      (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
  ;;

  let create_directory_result_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
    else if Ojs.is_null js_val
    then `Unit ((fun _ -> ()) js_val)
    else
      invalid_arg
        "FileSystemProvider.create_directory_result: unexpected JavaScript value"
  ;;

  type read_file_result =
    [ `Value of Uint8Array.t
    | `Promise of Uint8Array.t Promise.t
    ]

  let read_file_result_to_js = function
    | `Value value -> Uint8Array.t_to_js value
    | `Promise value -> (Promise.t_to_js Uint8Array.t_to_js) value
  ;;

  let read_file_result_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js Uint8Array.t_of_js) js_val)
    else if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then `Value (Uint8Array.t_of_js js_val)
    else invalid_arg "FileSystemProvider.read_file_result: unexpected JavaScript value"
  ;;

  type write_file_options =
    { create : bool
    ; overwrite : bool
    }

  let write_file_options_to_js (value : write_file_options) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "create" (Ojs.bool_to_js value.create);
    Ojs.set_prop_ascii js_val "overwrite" (Ojs.bool_to_js value.overwrite);
    js_val
  ;;

  let write_file_options_of_js js_val : write_file_options =
    { create = Ojs.bool_of_js (Ojs.get_prop_ascii js_val "create")
    ; overwrite = Ojs.bool_of_js (Ojs.get_prop_ascii js_val "overwrite")
    }
  ;;

  type delete_options = { recursive : bool }

  let delete_options_to_js (value : delete_options) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "recursive" (Ojs.bool_to_js value.recursive);
    js_val
  ;;

  let delete_options_of_js js_val : delete_options =
    { recursive = Ojs.bool_of_js (Ojs.get_prop_ascii js_val "recursive") }
  ;;

  type rename_options = { overwrite : bool }

  let rename_options_to_js (value : rename_options) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "overwrite" (Ojs.bool_to_js value.overwrite);
    js_val
  ;;

  let rename_options_of_js js_val : rename_options =
    { overwrite = Ojs.bool_of_js (Ojs.get_prop_ascii js_val "overwrite") }
  ;;

  include
    [%js:
      val onDidChangeFile : t -> FileChangeEvent.t list Event.t
      [@@js.get "onDidChangeFile"]

      val watch : t -> uri:Uri.t -> options:watch_options -> Disposable.t
      [@@js.call "watch"]

      val stat : t -> uri:Uri.t -> stat_result [@@js.call "stat"]

      val readDirectory : t -> uri:Uri.t -> read_directory_result
      [@@js.call "readDirectory"]

      val createDirectory : t -> uri:Uri.t -> create_directory_result
      [@@js.call "createDirectory"]

      val readFile : t -> uri:Uri.t -> read_file_result [@@js.call "readFile"]

      val writeFile
        :  t
        -> uri:Uri.t
        -> content:Uint8Array.t
        -> options:write_file_options
        -> create_directory_result
      [@@js.call "writeFile"]

      val delete : t -> uri:Uri.t -> options:delete_options -> create_directory_result
      [@@js.call "delete"]

      val rename
        :  t
        -> oldUri:Uri.t
        -> newUri:Uri.t
        -> options:rename_options
        -> create_directory_result
      [@@js.call "rename"]]

  let copy this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "copy" in
    if Ojs.is_null callback
    then None
    else
      Some
        ([%js.to:
           source:Uri.t
           -> destination:Uri.t
           -> options:rename_options
           -> create_directory_result]
           (Ojs.call callback "bind" [| this |]))
  ;;

  let create
        ~onDidChangeFile
        ~watch
        ~stat
        ~readDirectory
        ~createDirectory
        ~readFile
        ~writeFile
        ~delete
        ~rename
        ?copy
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "onDidChangeFile"
      ((Event.t_to_js (Ojs.list_to_js FileChangeEvent.t_to_js)) onDidChangeFile);
    Ojs.set_prop_ascii
      obj
      "watch"
      ([%js.of: uri:Uri.t -> options:watch_options -> Disposable.t] watch);
    Ojs.set_prop_ascii obj "stat" ([%js.of: uri:Uri.t -> stat_result] stat);
    Ojs.set_prop_ascii
      obj
      "readDirectory"
      ([%js.of: uri:Uri.t -> read_directory_result] readDirectory);
    Ojs.set_prop_ascii
      obj
      "createDirectory"
      ([%js.of: uri:Uri.t -> create_directory_result] createDirectory);
    Ojs.set_prop_ascii obj "readFile" ([%js.of: uri:Uri.t -> read_file_result] readFile);
    Ojs.set_prop_ascii
      obj
      "writeFile"
      ([%js.of:
         uri:Uri.t
         -> content:Uint8Array.t
         -> options:write_file_options
         -> create_directory_result]
         writeFile);
    Ojs.set_prop_ascii
      obj
      "delete"
      ([%js.of: uri:Uri.t -> options:delete_options -> create_directory_result] delete);
    Ojs.set_prop_ascii
      obj
      "rename"
      ([%js.of:
         oldUri:Uri.t -> newUri:Uri.t -> options:rename_options -> create_directory_result]
         rename);
    iter_set
      obj
      "copy"
      [%js.of:
        source:Uri.t
        -> destination:Uri.t
        -> options:rename_options
        -> create_directory_result]
      copy;
    t_of_js obj
  ;;
end

module Workspace = struct
  type find_files_with_exclusion_exclude =
    [ `GlobPattern of GlobPattern.t
    | `Null
    ]

  let find_files_with_exclusion_exclude_to_js = function
    | `GlobPattern value -> GlobPattern.t_to_js value
    | `Null -> Ojs.null
  ;;

  let find_files_with_exclusion_exclude_of_js js_val =
    if
      Ojs.type_of js_val = "string"
      || ((not (Ojs.is_null js_val))
          && binding_has_member js_val "baseUri"
          && binding_has_member js_val "base"
          && binding_has_member js_val "pattern")
    then `GlobPattern (GlobPattern.t_of_js js_val)
    else if Ojs.type_of js_val = "object" && Ojs.is_null js_val
    then `Null
    else
      invalid_arg
        "Workspace.find_files_with_exclusion_exclude: unexpected JavaScript value"
  ;;

  type get_configuration_with_scope =
    [ `ConfigurationScope of ConfigurationScope.t
    | `Null
    ]

  let get_configuration_with_scope_to_js = function
    | `ConfigurationScope value -> ConfigurationScope.t_to_js value
    | `Null -> Ojs.null
  ;;

  let get_configuration_with_scope_of_js js_val =
    if
      ((not (Ojs.is_null js_val))
       && binding_has_member js_val "scheme"
       && binding_has_member js_val "authority"
       && binding_has_member js_val "path"
       && binding_has_member js_val "query"
       && binding_has_member js_val "fragment"
       && binding_has_member js_val "fsPath"
       && binding_has_member js_val "with"
       && binding_has_member js_val "toString"
       && binding_has_member js_val "toJSON")
      || ((not (Ojs.is_null js_val))
          && binding_has_member js_val "uri"
          && binding_has_member js_val "fileName"
          && binding_has_member js_val "isUntitled"
          && binding_has_member js_val "languageId"
          && binding_has_member js_val "encoding"
          && binding_has_member js_val "version"
          && binding_has_member js_val "isDirty"
          && binding_has_member js_val "isClosed"
          && binding_has_member js_val "save"
          && binding_has_member js_val "eol"
          && binding_has_member js_val "lineCount"
          && binding_has_member js_val "lineAt"
          && binding_has_member js_val "lineAt"
          && binding_has_member js_val "offsetAt"
          && binding_has_member js_val "positionAt"
          && binding_has_member js_val "getText"
          && binding_has_member js_val "getWordRangeAtPosition"
          && binding_has_member js_val "validateRange"
          && binding_has_member js_val "validatePosition")
      || ((not (Ojs.is_null js_val))
          && binding_has_member js_val "uri"
          && binding_has_member js_val "name"
          && binding_has_member js_val "index")
      || ((Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
          && (not (Ojs.is_null js_val))
          && binding_has_member js_val "languageId")
    then `ConfigurationScope (ConfigurationScope.t_of_js js_val)
    else if Ojs.type_of js_val = "object" && Ojs.is_null js_val
    then `Null
    else invalid_arg "Workspace.get_configuration_with_scope: unexpected JavaScript value"
  ;;

  type register_file_system_provider_options_is_readonly =
    [ `Bool of bool
    | `MarkdownString of MarkdownString.t
    ]

  let register_file_system_provider_options_is_readonly_to_js = function
    | `Bool value -> Ojs.bool_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let register_file_system_provider_options_is_readonly_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "boolean"
      then `Bool (Ojs.bool_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else
        invalid_arg
          "Workspace.register_file_system_provider_options_is_readonly: unexpected \
           JavaScript value"
  ;;

  type register_file_system_provider_options =
    { isCaseSensitive : bool or_undefined
    ; isReadonly : register_file_system_provider_options_is_readonly or_undefined
    }

  let register_file_system_provider_options_to_js
        (value : register_file_system_provider_options)
    =
    let js_val = Ojs.obj [||] in
    iter_set js_val "isCaseSensitive" Ojs.bool_to_js value.isCaseSensitive;
    iter_set
      js_val
      "isReadonly"
      register_file_system_provider_options_is_readonly_to_js
      value.isReadonly;
    js_val
  ;;

  let register_file_system_provider_options_of_js js_val
    : register_file_system_provider_options
    =
    { isCaseSensitive =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "isCaseSensitive")
    ; isReadonly =
        (or_undefined_of_js register_file_system_provider_options_is_readonly_of_js)
          (Ojs.get_prop_ascii js_val "isReadonly")
    }
  ;;

  type textDocumentOptions =
    { language : string
    ; content : string
    }
  [@@js]

  type delete_count =
    [ `Int of int
    | `Null
    ]

  let delete_count_to_js = function
    | `Int value -> Ojs.int_to_js value
    | `Null -> Ojs.null
  ;;

  let delete_count_of_js value =
    if Ojs.type_of value = "number"
    then `Int (Ojs.int_of_js value)
    else if Ojs.type_of value = "object" && Ojs.is_null value
    then `Null
    else invalid_arg "Workspace.delete_count: unexpected JavaScript value"
  ;;

  type workspaceFolderToAdd =
    { name : string or_undefined
    ; uri : Uri.t
    }
  [@@js]

  include
    [%js:
      val workspaceFolders : unit -> WorkspaceFolder.t list or_undefined
      [@@js.get "@vscode.workspace.workspaceFolders"]

      val name : unit -> string or_undefined [@@js.get "@vscode.workspace.name"]

      val createFileSystemWatcher
        :  GlobPattern.t
        -> ?ignoreCreateEvents:(bool[@js.default false])
        -> ?ignoreChangeEvents:(bool[@js.default false])
        -> ?ignoreDeleteEvents:(bool[@js.default false])
        -> unit
        -> FileSystemWatcher.t
      [@@js.global "@vscode.workspace.createFileSystemWatcher"]

      val workspaceFile : unit -> Uri.t or_undefined
      [@@js.get "@vscode.workspace.workspaceFile"]

      val rootPath : unit -> string or_undefined [@@js.get "@vscode.workspace.rootPath"]

      val textDocuments : unit -> TextDocument.t list
      [@@js.get "@vscode.workspace.textDocuments"]

      val onDidChangeConfiguration : ConfigurationChangeEvent.t Event.t
      [@@js.global "@vscode.workspace.onDidChangeConfiguration"]

      val onDidChangeWorkspaceFolders : WorkspaceFoldersChangeEvent.t Event.t
      [@@js.global "@vscode.workspace.onDidChangeWorkspaceFolders"]

      val getWorkspaceFolder : uri:Uri.t -> WorkspaceFolder.t or_undefined
      [@@js.global "@vscode.workspace.getWorkspaceFolder"]

      val onDidOpenTextDocument : TextDocument.t Event.t
      [@@js.global "@vscode.workspace.onDidOpenTextDocument"]

      val onDidSaveTextDocument : TextDocument.t Event.t
      [@@js.global "@vscode.workspace.onDidSaveTextDocument"]

      val onDidCloseTextDocument : TextDocument.t Event.t
      [@@js.global "@vscode.workspace.onDidCloseTextDocument"]

      val onDidChangeTextDocument : TextDocumentChangeEvent.t Event.t
      [@@js.global "@vscode.workspace.onDidChangeTextDocument"]

      val applyEdit : edit:WorkspaceEdit.t -> bool Promise.t
      [@@js.global "@vscode.workspace.applyEdit"]

      val registerTextDocumentContentProvider
        :  scheme:string
        -> provider:TextDocumentContentProvider.t
        -> Disposable.t
      [@@js.global "@vscode.workspace.registerTextDocumentContentProvider"]

      val asRelativePath
        :  pathOrUri:([ `String of string | `Uri of Uri.t ][@js.union])
        -> ?includeWorkspaceFolder:bool
        -> unit
        -> string
      [@@js.global "@vscode.workspace.asRelativePath"]

      val getConfiguration
        :  ?section:string
        -> ?scope:ConfigurationScope.t
        -> unit
        -> WorkspaceConfiguration.t
      [@@js.global "@vscode.workspace.getConfiguration"]

      val findFiles
        :  includes:GlobPattern.t
        -> ?excludes:GlobPattern.t
        -> ?maxResults:int
        -> ?token:CancellationToken.t
        -> unit
        -> Uri.t list Promise.t
      [@@js.global "@vscode.workspace.findFiles"]

      val decode
        :  content:Uint8Array.t
        -> ?options:TextEncodingOptions.t
        -> unit
        -> string Promise.t
      [@@js.global "@vscode.workspace.decode"]

      val encode
        :  content:string
        -> ?options:TextEncodingOptions.t
        -> unit
        -> Uint8Array.t Promise.t
      [@@js.global "@vscode.workspace.encode"]

      val openTextDocumentWithEncoding
        :  ([ `Uri of Uri.t | `Filename of string ][@js.union])
        -> options:TextDocumentEncodingOptions.t
        -> TextDocument.t Promise.t
      [@@js.global "@vscode.workspace.openTextDocument"]

      val openTextDocument
        :  ([ `Uri of Uri.t
            | `Filename of string
            | `Options of TextDocumentOpenOptions.t
            | `Interactive of textDocumentOptions or_undefined
            ]
           [@js.union])
        -> TextDocument.t Promise.t
      [@@js.global "@vscode.workspace.openTextDocument"]

      val updateWorkspaceFolders
        :  start:int
        -> deleteCount:delete_count or_undefined
        -> workspaceFoldersToAdd:(workspaceFolderToAdd list[@js.variadic])
        -> bool
      [@@js.global "@vscode.workspace.updateWorkspaceFolders"]

      val fs : unit -> FileSystem.t [@@js.get "@vscode.workspace.fs"]]

  let findFilesWithExclusion ~include_ ?exclude ?maxResults ?token () =
    (Promise.t_of_js (Ojs.list_of_js Uri.t_of_js))
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "workspace")
         "findFiles"
         (binding_arguments
            [| GlobPattern.t_to_js include_
             ; (or_undefined_to_js find_files_with_exclusion_exclude_to_js) exclude
             ; (or_undefined_to_js Ojs.int_to_js) maxResults
             ; (or_undefined_to_js CancellationToken.t_to_js) token
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val save : uri:Uri.t -> Uri.t or_undefined Promise.t
      [@@js.global "@vscode.workspace.save"]

      val saveAs : uri:Uri.t -> Uri.t or_undefined Promise.t
      [@@js.global "@vscode.workspace.saveAs"]]

  let saveAll ?includeUntitled () =
    (Promise.t_of_js Ojs.bool_of_js)
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "workspace")
         "saveAll"
         (binding_arguments
            [| (or_undefined_to_js Ojs.bool_to_js) includeUntitled |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let applyEditWithMetadata ~edit ?metadata () =
    (Promise.t_of_js Ojs.bool_of_js)
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "workspace")
         "applyEdit"
         (binding_arguments
            [| WorkspaceEdit.t_to_js edit
             ; (or_undefined_to_js WorkspaceEditMetadata.t_to_js) metadata
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val onWillSaveTextDocument : unit -> TextDocumentWillSaveEvent.t Event.t
      [@@js.get "@vscode.workspace.onWillSaveTextDocument"]

      val notebookDocuments : unit -> NotebookDocument.t list
      [@@js.get "@vscode.workspace.notebookDocuments"]

      val openNotebookDocument : uri:Uri.t -> NotebookDocument.t Promise.t
      [@@js.global "@vscode.workspace.openNotebookDocument"]]

  let createNotebookDocument ~notebookType ?content () =
    (Promise.t_of_js NotebookDocument.t_of_js)
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "workspace")
         "openNotebookDocument"
         (binding_arguments
            [| Ojs.string_to_js notebookType
             ; (or_undefined_to_js NotebookData.t_to_js) content
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val onDidChangeNotebookDocument : unit -> NotebookDocumentChangeEvent.t Event.t
      [@@js.get "@vscode.workspace.onDidChangeNotebookDocument"]

      val onWillSaveNotebookDocument : unit -> NotebookDocumentWillSaveEvent.t Event.t
      [@@js.get "@vscode.workspace.onWillSaveNotebookDocument"]

      val onDidSaveNotebookDocument : unit -> NotebookDocument.t Event.t
      [@@js.get "@vscode.workspace.onDidSaveNotebookDocument"]]

  let registerNotebookSerializer ~notebookType ~serializer ?options () =
    Disposable.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "workspace")
         "registerNotebookSerializer"
         (binding_arguments
            [| Ojs.string_to_js notebookType
             ; NotebookSerializer.t_to_js serializer
             ; (or_undefined_to_js NotebookDocumentContentOptions.t_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val onDidOpenNotebookDocument : unit -> NotebookDocument.t Event.t
      [@@js.get "@vscode.workspace.onDidOpenNotebookDocument"]

      val onDidCloseNotebookDocument : unit -> NotebookDocument.t Event.t
      [@@js.get "@vscode.workspace.onDidCloseNotebookDocument"]

      val onWillCreateFiles : unit -> FileWillCreateEvent.t Event.t
      [@@js.get "@vscode.workspace.onWillCreateFiles"]

      val onDidCreateFiles : unit -> FileCreateEvent.t Event.t
      [@@js.get "@vscode.workspace.onDidCreateFiles"]

      val onWillDeleteFiles : unit -> FileWillDeleteEvent.t Event.t
      [@@js.get "@vscode.workspace.onWillDeleteFiles"]

      val onDidDeleteFiles : unit -> FileDeleteEvent.t Event.t
      [@@js.get "@vscode.workspace.onDidDeleteFiles"]

      val onWillRenameFiles : unit -> FileWillRenameEvent.t Event.t
      [@@js.get "@vscode.workspace.onWillRenameFiles"]

      val onDidRenameFiles : unit -> FileRenameEvent.t Event.t
      [@@js.get "@vscode.workspace.onDidRenameFiles"]]

  let getConfigurationWithScope ?section ?scope () =
    WorkspaceConfiguration.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "workspace")
         "getConfiguration"
         (binding_arguments
            [| (or_undefined_to_js Ojs.string_to_js) section
             ; (or_undefined_to_js get_configuration_with_scope_to_js) scope
            |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val registerTaskProvider
        :  type_:string
        -> provider:Task.t TaskProvider.t
        -> Disposable.t
      [@@js.global "@vscode.workspace.registerTaskProvider"]]

  let registerFileSystemProvider ~scheme ~provider ?options () =
    Disposable.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "workspace")
         "registerFileSystemProvider"
         (binding_arguments
            [| Ojs.string_to_js scheme
             ; FileSystemProvider.t_to_js provider
             ; (or_undefined_to_js register_file_system_provider_options_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val isTrusted : unit -> bool [@@js.get "@vscode.workspace.isTrusted"]

      val onDidGrantWorkspaceTrust : unit -> unit Event.t
      [@@js.get "@vscode.workspace.onDidGrantWorkspaceTrust"]]
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
    include Ojs.T

    val uri : t -> Uri.t
    val dispose : t -> unit
  end

  include Interface.Make ()

  include
    [%js:
      val uri : t -> Uri.t [@@js.get "uri"]
      val dispose : t -> unit [@@js.call]]

  let create ~uri ~dispose () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "uri" (Uri.t_to_js uri);
    Ojs.set_prop_ascii obj "dispose" ([%js.of: unit -> unit] dispose);
    t_of_js obj
  ;;
end

module TreeItemLabel = struct
  include Interface.Make ()

  include
    [%js:
      val label : t -> string [@@js.get "label"]
      val highlights : t -> (int * int) list or_undefined [@@js.get "highlights"]]

  include
    [%js:
      val set_label : t -> string -> unit [@@js.set "label"]

      val set_highlights : t -> (int * int) list or_undefined -> unit
      [@@js.set "highlights"]]

  let create ~label ?highlights () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "label" (Ojs.string_to_js label);
    iter_set
      obj
      "highlights"
      (Ojs.list_to_js (fun (v0, v1) ->
         Ojs.array_to_js Ojs.t_to_js [| Ojs.int_to_js v0; Ojs.int_to_js v1 |]))
      highlights;
    t_of_js obj
  ;;
end

module TreeItemCheckboxState = struct
  type t =
    | Unchecked [@js 0]
    | Checked [@js 1]
  [@@js.enum] [@@js]
end

module TreeItem = struct
  include Class.Make ()

  type label_value =
    [ `String of string
    | `TreeItemLabel of TreeItemLabel.t
    ]

  let label_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `TreeItemLabel value -> TreeItemLabel.t_to_js value
  ;;

  let label_value_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "label"
    then `TreeItemLabel (TreeItemLabel.t_of_js js_val)
    else invalid_arg "TreeItem.label_value: unexpected JavaScript value"
  ;;

  type description_value =
    [ `String of string
    | `Bool of bool
    ]

  let description_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Bool value -> Ojs.bool_to_js value
  ;;

  let description_value_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else invalid_arg "TreeItem.description_value: unexpected JavaScript value"
  ;;

  type tooltip_value =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let tooltip_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let tooltip_value_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else invalid_arg "TreeItem.tooltip_value: unexpected JavaScript value"
  ;;

  type checkbox_state_item =
    { state : TreeItemCheckboxState.t
    ; tooltip : string or_undefined
    ; accessibilityInformation : AccessibilityInformation.t or_undefined
    }

  let checkbox_state_item_to_js (value : checkbox_state_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "state" (TreeItemCheckboxState.t_to_js value.state);
    iter_set js_val "tooltip" Ojs.string_to_js value.tooltip;
    iter_set
      js_val
      "accessibilityInformation"
      AccessibilityInformation.t_to_js
      value.accessibilityInformation;
    js_val
  ;;

  let checkbox_state_item_of_js js_val : checkbox_state_item =
    { state = TreeItemCheckboxState.t_of_js (Ojs.get_prop_ascii js_val "state")
    ; tooltip =
        (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "tooltip")
    ; accessibilityInformation =
        (or_undefined_of_js AccessibilityInformation.t_of_js)
          (Ojs.get_prop_ascii js_val "accessibilityInformation")
    }
  ;;

  type checkbox_state =
    [ `TreeItemCheckboxState of TreeItemCheckboxState.t
    | `Options of checkbox_state_item
    ]

  let checkbox_state_to_js = function
    | `TreeItemCheckboxState value -> TreeItemCheckboxState.t_to_js value
    | `Options value -> checkbox_state_item_to_js value
  ;;

  let checkbox_state_of_js js_val =
    if Ojs.type_of js_val = "number"
    then `TreeItemCheckboxState (TreeItemCheckboxState.t_of_js js_val)
    else if
      (Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "state"
    then `Options (checkbox_state_item_of_js js_val)
    else invalid_arg "TreeItem.checkbox_state: unexpected JavaScript value"
  ;;

  type label =
    ([ `String of string
     | `TreeItemLabel of TreeItemLabel.t
     ]
    [@js.union])
  [@@js]

  let label_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String ([%js.to: string] js_val)
    else if binding_has_member js_val "label"
    then `TreeItemLabel ([%js.to: TreeItemLabel.t] js_val)
    else assert false
  ;;

  type iconPath =
    ([ `String of string
     | `Uri of Uri.t
     | `LightDark of LightDarkIcon.t
     | `ThemeIcon of ThemeIcon.t
     ]
    [@js.union])
  [@@js]

  let iconPath_of_js js_val =
    if binding_has_member js_val "path"
    then `Uri ([%js.to: Uri.t] js_val)
    else if binding_has_member js_val "id"
    then `ThemeIcon ([%js.to: ThemeIcon.t] js_val)
    else if Ojs.type_of js_val = "string"
    then `String ([%js.to: string] js_val)
    else if binding_has_member js_val "light"
    then `LightDark ([%js.to: LightDarkIcon.t] js_val)
    else assert false
  ;;

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
  ;;

  type tooltip =
    ([ `String of string
     | `MarkdownString of MarkdownString.t
     | `Undefined
     ]
    [@js.union])
  [@@js]

  let tooltip_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String ([%js.to: string] js_val)
    else if Ojs.type_of js_val = "undefined"
    then `Undefined
    else if binding_has_member js_val "value"
    then `MarkdownString ([%js.to: MarkdownString.t] js_val)
    else assert false
  ;;

  include
    [%js:
      val make_label
        :  label:label
        -> ?collapsibleState:TreeItemCollapsibleState.t
        -> unit
        -> t
      [@@js.new "@vscode.TreeItem"]

      val make_resource
        :  resourceUri:Uri.t
        -> ?collapsibleState:TreeItemCollapsibleState.t
        -> unit
        -> t
      [@@js.new "@vscode.TreeItem"]

      val label : t -> label_value or_undefined [@@js.get "label"]
      val set_label : t -> label_value or_undefined -> unit [@@js.set "label"]
      val id : t -> string or_undefined [@@js.get "id"]
      val set_id : t -> string or_undefined -> unit [@@js.set "id"]
      val iconPath : t -> iconPath or_undefined [@@js.get "iconPath"]
      val set_iconPath : t -> iconPath or_undefined -> unit [@@js.set "iconPath"]
      val description : t -> description_value or_undefined [@@js.get "description"]

      val set_description : t -> description_value or_undefined -> unit
      [@@js.set "description"]

      val resourceUri : t -> Uri.t or_undefined [@@js.get "resourceUri"]
      val set_resourceUri : t -> Uri.t or_undefined -> unit [@@js.set "resourceUri"]
      val tooltip : t -> tooltip_value or_undefined [@@js.get "tooltip"]
      val set_tooltip : t -> tooltip_value or_undefined -> unit [@@js.set "tooltip"]

      val collapsibleState : t -> TreeItemCollapsibleState.t or_undefined
      [@@js.get "collapsibleState"]

      val set_collapsibleState : t -> TreeItemCollapsibleState.t or_undefined -> unit
      [@@js.set "collapsibleState"]

      val command : t -> Command.t or_undefined [@@js.get "command"]
      val set_command : t -> Command.t or_undefined -> unit [@@js.set "command"]
      val contextValue : t -> string or_undefined [@@js.get "contextValue"]
      val set_contextValue : t -> string or_undefined -> unit [@@js.set "contextValue"]

      val accessibilityInformation : t -> AccessibilityInformation.t or_undefined
      [@@js.get "accessibilityInformation"]

      val set_accessibilityInformation
        :  t
        -> AccessibilityInformation.t or_undefined
        -> unit
      [@@js.set "accessibilityInformation"]

      val checkboxState : t -> checkbox_state or_undefined [@@js.get "checkboxState"]

      val set_checkboxState : t -> checkbox_state or_undefined -> unit
      [@@js.set "checkboxState"]]
end

module TreeDataProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    type change =
      [ `Element of T.t
      | `Elements of T.t list
      ]

    let change_to_js = function
      | `Element value -> T.t_to_js value
      | `Elements value -> (Ojs.list_to_js T.t_to_js) value
    ;;

    let change_of_js js_val =
      if binding_is_array js_val
      then `Elements ((Ojs.list_of_js T.t_of_js) js_val)
      else if true
      then `Element (T.t_of_js js_val)
      else invalid_arg "TreeDataProvider.change: unexpected JavaScript value"
    ;;

    type get_tree_item_result =
      [ `Value of TreeItem.t
      | `Promise of TreeItem.t Promise.t
      ]

    let get_tree_item_result_to_js = function
      | `Value value -> TreeItem.t_to_js value
      | `Promise value -> (Promise.t_to_js TreeItem.t_to_js) value
    ;;

    let get_tree_item_result_of_js js_val =
      if binding_is_thenable js_val
      then `Promise ((Promise.t_of_js TreeItem.t_of_js) js_val)
      else (
        match binding_constructor js_val [ "TreeItem" ] with
        | Some "TreeItem" -> `Value (TreeItem.t_of_js js_val)
        | _ ->
          if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
          then `Value (TreeItem.t_of_js js_val)
          else
            invalid_arg
              "TreeDataProvider.get_tree_item_result: unexpected JavaScript value")
    ;;

    type getTreeItemResult =
      ([ `Value of TreeItem.t
       | `Promise of TreeItem.t Promise.t
       ]
      [@js.union])
    [@@js]

    let getTreeItemResult_of_js js_val =
      if binding_is_thenable js_val
      then `Promise ([%js.to: TreeItem.t Promise.t] js_val)
      else `Value ([%js.to: TreeItem.t] js_val)
    ;;

    include
      [%js:
        val onDidChangeTreeData : t -> change or_undefined Event.t or_undefined
        [@@js.get "onDidChangeTreeData"]

        val getChildren : t -> ?element:T.t -> unit -> T.t list ProviderResult.t
        [@@js.call]]

    include
      [%js:
        val set_onDidChangeTreeData
          :  t
          -> change or_undefined Event.t or_undefined
          -> unit
        [@@js.set "onDidChangeTreeData"]

        val getTreeItem : t -> element:T.t -> get_tree_item_result
        [@@js.call "getTreeItem"]]

    let getParent this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "getParent" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to: element:T.t -> T.t ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let resolveTreeItem this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "resolveTreeItem" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to:
             item:TreeItem.t
             -> element:T.t
             -> token:CancellationToken.t
             -> TreeItem.t ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create
          ?onDidChangeTreeData
          ~getTreeItem
          ~getChildren
          ?getParent
          ?resolveTreeItem
          ()
      =
      let obj = Ojs.obj [||] in
      iter_set
        obj
        "onDidChangeTreeData"
        (Event.t_to_js (or_undefined_to_js change_to_js))
        onDidChangeTreeData;
      Ojs.set_prop_ascii
        obj
        "getTreeItem"
        ([%js.of: element:T.t -> get_tree_item_result] getTreeItem);
      Ojs.set_prop_ascii
        obj
        "getChildren"
        ([%js.of: ?element:T.t -> unit -> T.t list ProviderResult.t] getChildren);
      iter_set obj "getParent" [%js.of: element:T.t -> T.t ProviderResult.t] getParent;
      iter_set
        obj
        "resolveTreeItem"
        [%js.of:
          item:TreeItem.t
          -> element:T.t
          -> token:CancellationToken.t
          -> TreeItem.t ProviderResult.t]
        resolveTreeItem;
      t_of_js obj
    ;;
  end
end

module DataTransferItem = struct
  include Class.Make ()

  include
    [%js:
      val asString : t -> string Promise.t [@@js.call "asString"]
      val asFile : t -> DataTransferFile.t or_undefined [@@js.call "asFile"]
      val value : t -> Ojs.t [@@js.get "value"]
      val make : value:Ojs.t -> t [@@js.new "@vscode.DataTransferItem"]]
end

module DataTransfer = struct
  include Class.Make ()

  include
    [%js:
      val get : t -> mimeType:string -> DataTransferItem.t or_undefined [@@js.call "get"]
      val set : t -> mimeType:string -> value:DataTransferItem.t -> unit [@@js.call "set"]]

  let forEach this ~callbackfn ?thisArg () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "forEach"
         (binding_arguments
            [| [%js.of:
                 item:DataTransferItem.t -> mimeType:string -> dataTransfer:t -> unit]
                 callbackfn
             ; (or_undefined_to_js Ojs.t_to_js) thisArg
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include [%js: val make : unit -> t [@@js.new "@vscode.DataTransfer"]]

  let iterator this =
    let this = t_to_js this in
    let symbol = Ojs.get_prop_ascii (Ojs.get_prop_ascii Ojs.global "Symbol") "iterator" in
    IterableIterator.t_of_js
      (fun js_val ->
         ( Ojs.string_of_js (Ojs.array_get js_val 0)
         , DataTransferItem.t_of_js (Ojs.array_get js_val 1) ))
      (Ojs.call (Ojs.get_prop this symbol) "call" [| this |])
  ;;
end

module TreeDragAndDropController = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    type handle_drag_result =
      [ `Promise of unit Promise.t
      | `Unit of unit
      ]

    let handle_drag_result_to_js = function
      | `Promise value ->
        (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
      | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
    ;;

    let handle_drag_result_of_js js_val =
      if binding_is_thenable js_val
      then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
      else if Ojs.is_null js_val
      then `Unit ((fun _ -> ()) js_val)
      else
        invalid_arg
          "TreeDragAndDropController.handle_drag_result: unexpected JavaScript value"
    ;;

    include
      [%js:
        val dropMimeTypes : t -> string list [@@js.get "dropMimeTypes"]
        val dragMimeTypes : t -> string list [@@js.get "dragMimeTypes"]]

    let handleDrag this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "handleDrag" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to:
             source:T.t list
             -> dataTransfer:DataTransfer.t
             -> token:CancellationToken.t
             -> handle_drag_result]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let handleDrop this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "handleDrop" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to:
             target:T.t or_undefined
             -> dataTransfer:DataTransfer.t
             -> token:CancellationToken.t
             -> handle_drag_result]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create ~dropMimeTypes ~dragMimeTypes ?handleDrag ?handleDrop () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "dropMimeTypes"
        ((Ojs.list_to_js Ojs.string_to_js) dropMimeTypes);
      Ojs.set_prop_ascii
        obj
        "dragMimeTypes"
        ((Ojs.list_to_js Ojs.string_to_js) dragMimeTypes);
      iter_set
        obj
        "handleDrag"
        [%js.of:
          source:T.t list
          -> dataTransfer:DataTransfer.t
          -> token:CancellationToken.t
          -> handle_drag_result]
        handleDrag;
      iter_set
        obj
        "handleDrop"
        [%js.of:
          target:T.t or_undefined
          -> dataTransfer:DataTransfer.t
          -> token:CancellationToken.t
          -> handle_drag_result]
        handleDrop;
      t_of_js obj
    ;;
  end
end

module TreeViewOptions = struct
  module G = Class.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val treeDataProvider : t -> T.t TreeDataProvider.t [@@js.get "treeDataProvider"]
        val showCollapseAll : t -> bool or_undefined [@@js.get "showCollapseAll"]
        val canSelectMany : t -> bool or_undefined [@@js.get "canSelectMany"]

        val set_treeDataProvider : t -> T.t TreeDataProvider.t -> unit
        [@@js.set "treeDataProvider"]

        val set_showCollapseAll : t -> bool or_undefined -> unit
        [@@js.set "showCollapseAll"]

        val set_canSelectMany : t -> bool or_undefined -> unit [@@js.set "canSelectMany"]

        val dragAndDropController : t -> T.t TreeDragAndDropController.t or_undefined
        [@@js.get "dragAndDropController"]

        val set_dragAndDropController
          :  t
          -> T.t TreeDragAndDropController.t or_undefined
          -> unit
        [@@js.set "dragAndDropController"]

        val manageCheckboxStateManually : t -> bool or_undefined
        [@@js.get "manageCheckboxStateManually"]

        val set_manageCheckboxStateManually : t -> bool or_undefined -> unit
        [@@js.set "manageCheckboxStateManually"]]

    let create
          ~treeDataProvider
          ?showCollapseAll
          ?canSelectMany
          ?dragAndDropController
          ?manageCheckboxStateManually
          ()
      =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "treeDataProvider"
        ((TreeDataProvider.t_to_js T.t_to_js) treeDataProvider);
      iter_set obj "showCollapseAll" Ojs.bool_to_js showCollapseAll;
      iter_set obj "canSelectMany" Ojs.bool_to_js canSelectMany;
      iter_set
        obj
        "dragAndDropController"
        (TreeDragAndDropController.t_to_js T.t_to_js)
        dragAndDropController;
      iter_set
        obj
        "manageCheckboxStateManually"
        Ojs.bool_to_js
        manageCheckboxStateManually;
      t_of_js obj
    ;;
  end
end

module TreeViewExpansionEvent = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include [%js: val element : t -> T.t [@@js.get "element"]]

    let create ~element () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii obj "element" (T.t_to_js element);
      t_of_js obj
    ;;
  end
end

module TreeViewSelectionChangeEvent = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include [%js: val selection : t -> T.t list [@@js.get "selection"]]

    let create ~selection () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii obj "selection" ((Ojs.list_to_js T.t_to_js) selection);
      t_of_js obj
    ;;
  end
end

module TreeViewVisibilityChangeEvent = struct
  include Interface.Make ()
  include [%js: val visible : t -> bool [@@js.get "visible"]]

  let create ~visible () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "visible" (Ojs.bool_to_js visible);
    t_of_js obj
  ;;
end

module TreeCheckboxChangeEvent = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js: val items : t -> (T.t * TreeItemCheckboxState.t) list [@@js.get "items"]]

    let create ~items () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "items"
        ((Ojs.list_to_js (fun (v0, v1) ->
            Ojs.array_to_js
              Ojs.t_to_js
              [| T.t_to_js v0; TreeItemCheckboxState.t_to_js v1 |]))
           items);
      t_of_js obj
    ;;
  end
end

module ViewBadge = struct
  include Interface.Make ()

  include
    [%js:
      val tooltip : t -> string [@@js.get "tooltip"]
      val value : t -> int [@@js.get "value"]]

  let create ~tooltip ~value () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "tooltip" (Ojs.string_to_js tooltip);
    Ojs.set_prop_ascii obj "value" (Ojs.int_to_js value);
    t_of_js obj
  ;;
end

module TreeView = struct
  module G = Interface.Generic (Disposable) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]
    type from_disposable_likes_item = { dispose : unit -> Ojs.t }

    let from_disposable_likes_item_to_js (value : from_disposable_likes_item) =
      let js_val = Ojs.obj [||] in
      Ojs.set_prop_ascii js_val "dispose" ([%js.of: unit -> Ojs.t] value.dispose);
      js_val
    ;;

    let from_disposable_likes_item_of_js js_val : from_disposable_likes_item =
      { dispose = [%js.to: unit -> Ojs.t] (Ojs.get_prop_ascii js_val "dispose") }
    ;;

    include
      [%js:
        val onDidExpandElement : t -> T.t TreeViewExpansionEvent.t Event.t
        [@@js.get "onDidExpandElement"]

        val onDidCollapseElement : t -> T.t TreeViewExpansionEvent.t Event.t
        [@@js.get "onDidCollapseElement"]

        val selection : t -> T.t list [@@js.get "selection"]

        val onDidChangeSelection : t -> T.t TreeViewSelectionChangeEvent.t Event.t
        [@@js.get "onDidChangeSelection"]

        val visible : t -> bool [@@js.get "visible"]

        val onDidChangeVisibility : t -> TreeViewVisibilityChangeEvent.t Event.t
        [@@js.get "onDidChangeVisibility"]

        val message : t -> string or_undefined [@@js.get "message"]
        val title : t -> string or_undefined [@@js.get "title"]
        val description : t -> string or_undefined [@@js.get "description"]
        val reveal : t -> element:T.t -> Ojs.t -> unit Promise.t [@@js.call]]

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
    ;;

    include
      [%js:
        val from
          :  disposableLikes:(from_disposable_likes_item list[@js.variadic])
          -> Disposable.t
        [@@js.global "@vscode.TreeView.from"]

        val dispose : t -> Ojs.t [@@js.call "dispose"]

        val onDidChangeCheckboxState : t -> T.t TreeCheckboxChangeEvent.t Event.t
        [@@js.get "onDidChangeCheckboxState"]

        val set_message : t -> string or_undefined -> unit [@@js.set "message"]
        val set_title : t -> string or_undefined -> unit [@@js.set "title"]
        val set_description : t -> string or_undefined -> unit [@@js.set "description"]
        val badge : t -> ViewBadge.t or_undefined [@@js.get "badge"]
        val set_badge : t -> ViewBadge.t or_undefined -> unit [@@js.set "badge"]]
  end

  let to_disposable (type a) (value : a t) = (value :> Disposable.t)
end

module WebviewPanelOptions = struct
  include Interface.Make ()

  include
    [%js:
      val enableFindWidget : t -> bool or_undefined [@@js.get "enableFindWidget"]

      val retainContextWhenHidden : t -> bool or_undefined
      [@@js.get "retainContextWhenHidden"]]

  let create ?enableFindWidget ?retainContextWhenHidden () =
    let obj = Ojs.obj [||] in
    iter_set obj "enableFindWidget" Ojs.bool_to_js enableFindWidget;
    iter_set obj "retainContextWhenHidden" Ojs.bool_to_js retainContextWhenHidden;
    t_of_js obj
  ;;
end

module WebviewPortMapping = struct
  include Interface.Make ()

  include
    [%js:
      val extensionHostPort : t -> int [@@js.get "extensionHostPort"]
      val webviewPort : t -> int [@@js.get "webviewPort"]]

  let create ~webviewPort ~extensionHostPort () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "webviewPort" (Ojs.int_to_js webviewPort);
    Ojs.set_prop_ascii obj "extensionHostPort" (Ojs.int_to_js extensionHostPort);
    t_of_js obj
  ;;
end

module WebviewOptions = struct
  include Interface.Make ()

  type enable_command_uris =
    [ `Bool of bool
    | `Items of string list
    ]

  let enable_command_uris_to_js = function
    | `Bool value -> Ojs.bool_to_js value
    | `Items value -> (Ojs.list_to_js Ojs.string_to_js) value
  ;;

  let enable_command_uris_of_js js_val =
    if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "string")
    then `Items ((Ojs.list_of_js Ojs.string_of_js) js_val)
    else invalid_arg "WebviewOptions.enable_command_uris: unexpected JavaScript value"
  ;;

  include
    [%js:
      val enableCommandUris : t -> enable_command_uris or_undefined
      [@@js.get "enableCommandUris"]

      val enableScripts : t -> bool or_undefined [@@js.get "enableScripts"]

      val localResourceRoots : t -> Uri.t list or_undefined
      [@@js.get "localResourceRoots"]

      val portMapping : t -> WebviewPortMapping.t list or_undefined
      [@@js.get "portMapping"]]

  include [%js: val enableForms : t -> bool or_undefined [@@js.get "enableForms"]]

  let create
        ?enableScripts
        ?enableForms
        ?enableCommandUris
        ?localResourceRoots
        ?portMapping
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set obj "enableScripts" Ojs.bool_to_js enableScripts;
    iter_set obj "enableForms" Ojs.bool_to_js enableForms;
    iter_set obj "enableCommandUris" enable_command_uris_to_js enableCommandUris;
    iter_set obj "localResourceRoots" (Ojs.list_to_js Uri.t_to_js) localResourceRoots;
    iter_set obj "portMapping" (Ojs.list_to_js WebviewPortMapping.t_to_js) portMapping;
    t_of_js obj
  ;;
end

module WebView = struct
  include Interface.Make ()

  include
    [%js:
      val onDidReceiveMessage : t -> Ojs.t Event.t [@@js.get "onDidReceiveMessage"]
      val cspSource : t -> string [@@js.get "cspSource"]
      val html : t -> string [@@js.get "html"]
      val set_html : t -> string -> unit [@@js.set "html"]
      val options : t -> WebviewOptions.t [@@js.get "options"]
      val set_options : t -> WebviewOptions.t -> unit [@@js.set "options"]
      val asWebviewUri : t -> localResource:Uri.t -> Uri.t [@@js.call]
      val postMessage : t -> Ojs.t -> bool Promise.t [@@js.call]]

  let create ~options ~html ~onDidReceiveMessage ~postMessage ~asWebviewUri ~cspSource () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "options" (WebviewOptions.t_to_js options);
    Ojs.set_prop_ascii obj "html" (Ojs.string_to_js html);
    Ojs.set_prop_ascii
      obj
      "onDidReceiveMessage"
      ((Event.t_to_js Ojs.t_to_js) onDidReceiveMessage);
    Ojs.set_prop_ascii
      obj
      "postMessage"
      ([%js.of: message:Ojs.t -> bool Promise.t] postMessage);
    Ojs.set_prop_ascii
      obj
      "asWebviewUri"
      ([%js.of: localResource:Uri.t -> Uri.t] asWebviewUri);
    Ojs.set_prop_ascii obj "cspSource" (Ojs.string_to_js cspSource);
    t_of_js obj
  ;;
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
end = struct
  include Interface.Make ()
  module LightDarkIcon = LightDarkIcon

  type iconPath = IconPath.t [@@js]

  include
    [%js:
      val onDidChangeViewState : t -> WebviewPanelOnDidChangeViewStateEvent.t Event.t
      [@@js.get "onDidChangeViewState"]

      val onDidDispose : t -> unit Event.t [@@js.get "onDidDispose"]
      val active : t -> bool [@@js.get "active"]
      val options : t -> WebviewPanelOptions.t [@@js.get "options"]
      val title : t -> string [@@js.get "title"]
      val iconPath : t -> IconPath.t or_undefined [@@js.get "iconPath"]
      val set_iconPath : t -> IconPath.t or_undefined -> unit [@@js.set "iconPath"]
      val viewColumn : t -> ViewColumn.t or_undefined [@@js.get "viewColumn"]
      val viewType : t -> string [@@js.get "viewType"]
      val visible : t -> bool [@@js.get "visible"]
      val webview : t -> WebView.t [@@js.get "webview"]
      val dispose : t -> unit [@@js.call]

      val reveal : t -> ?viewColumn:ViewColumn.t -> ?preserveFocus:bool -> unit -> unit
      [@@js.call]]

  include [%js: val set_title : t -> string -> unit [@@js.set "title"]]

  let create
        ~viewType
        ~title
        ?iconPath
        ~webview
        ~options
        ~viewColumn
        ~active
        ~visible
        ~onDidChangeViewState
        ~onDidDispose
        ~reveal
        ~dispose
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "viewType" (Ojs.string_to_js viewType);
    Ojs.set_prop_ascii obj "title" (Ojs.string_to_js title);
    iter_set obj "iconPath" IconPath.t_to_js iconPath;
    Ojs.set_prop_ascii obj "webview" (WebView.t_to_js webview);
    Ojs.set_prop_ascii obj "options" (WebviewPanelOptions.t_to_js options);
    Ojs.set_prop_ascii
      obj
      "viewColumn"
      ((or_undefined_to_js ViewColumn.t_to_js) viewColumn);
    Ojs.set_prop_ascii obj "active" (Ojs.bool_to_js active);
    Ojs.set_prop_ascii obj "visible" (Ojs.bool_to_js visible);
    Ojs.set_prop_ascii
      obj
      "onDidChangeViewState"
      ((Event.t_to_js WebviewPanelOnDidChangeViewStateEvent.t_to_js) onDidChangeViewState);
    Ojs.set_prop_ascii
      obj
      "onDidDispose"
      ((Event.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None))
         onDidDispose);
    Ojs.set_prop_ascii
      obj
      "reveal"
      ([%js.of: ?viewColumn:ViewColumn.t -> ?preserveFocus:bool -> unit -> unit] reveal);
    Ojs.set_prop_ascii obj "dispose" ([%js.of: unit -> Ojs.t] dispose);
    t_of_js obj
  ;;
end

and WebviewPanelOnDidChangeViewStateEvent : sig
  include Ojs.T

  val webviewPanel : t -> WebviewPanel.t
  val create : webviewPanel:WebviewPanel.t -> unit -> t
end = struct
  include Interface.Make ()
  include [%js: val webviewPanel : t -> WebviewPanel.t [@@js.get "webviewPanel"]]

  let create ~webviewPanel () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "webviewPanel" (WebviewPanel.t_to_js webviewPanel);
    t_of_js obj
  ;;
end

module CustomTextEditorProvider = struct
  include Interface.Make ()

  type create_resolve_custom_text_editor_result =
    [ `Promise of unit Promise.t
    | `Unit of unit
    ]

  let create_resolve_custom_text_editor_result_to_js = function
    | `Promise value ->
      (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
    | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
  ;;

  let create_resolve_custom_text_editor_result_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
    else if Ojs.is_null js_val
    then `Unit ((fun _ -> ()) js_val)
    else
      invalid_arg
        "CustomTextEditorProvider.create_resolve_custom_text_editor_result: unexpected \
         JavaScript value"
  ;;

  module ResolvedEditor = struct
    type t =
      ([ `Promise of unit Promise.t
       | `Unit of unit
       ]
      [@js.union])
    [@@js]

    let t_of_js js_val =
      if Ojs.is_null js_val
      then `Unit ([%js.to: unit] js_val)
      else `Promise ([%js.to: unit Promise.t] js_val)
    ;;

    let t_to_js = function
      | `Unit v -> [%js.of: unit] v
      | `Promise p -> [%js.of: unit Promise.t] p
    ;;
  end

  include
    [%js:
      val resolveCustomTextEditor
        :  t
        -> document:TextDocument.t
        -> webviewPanel:WebviewPanel.t
        -> token:CancellationToken.t
        -> ResolvedEditor.t
      [@@js.call]]

  let create ~resolveCustomTextEditor () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "resolveCustomTextEditor"
      ([%js.of:
         document:TextDocument.t
         -> webviewPanel:WebviewPanel.t
         -> token:CancellationToken.t
         -> create_resolve_custom_text_editor_result]
         resolveCustomTextEditor);
    t_of_js obj
  ;;
end

module CustomDocumentOpenContext = struct
  include Interface.Make ()

  include
    [%js:
      val backupId : t -> string or_undefined [@@js.get "backupId"]

      val untitledDocumentData : t -> Uint8Array.t or_undefined
      [@@js.get "untitledDocumentData"]]

  let create ~backupId ~untitledDocumentData () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "backupId" ((or_undefined_to_js Ojs.string_to_js) backupId);
    Ojs.set_prop_ascii
      obj
      "untitledDocumentData"
      ((or_undefined_to_js Uint8Array.t_to_js) untitledDocumentData);
    t_of_js obj
  ;;
end

module CustomReadonlyEditorProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : CustomDocument.T) = struct
    type t = T.t G.t [@@js]

    type open_custom_document_result =
      [ `Promise of T.t Promise.t
      | `Value of T.t
      ]

    let open_custom_document_result_to_js = function
      | `Promise value -> (Promise.t_to_js T.t_to_js) value
      | `Value value -> T.t_to_js value
    ;;

    let open_custom_document_result_of_js js_val =
      if binding_is_thenable js_val
      then `Promise ((Promise.t_of_js T.t_of_js) js_val)
      else if true
      then `Value (T.t_of_js js_val)
      else
        invalid_arg
          "CustomReadonlyEditorProvider.open_custom_document_result: unexpected \
           JavaScript value"
    ;;

    type resolve_custom_editor_result =
      [ `Promise of unit Promise.t
      | `Unit of unit
      ]

    let resolve_custom_editor_result_to_js = function
      | `Promise value ->
        (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
      | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
    ;;

    let resolve_custom_editor_result_of_js js_val =
      if binding_is_thenable js_val
      then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
      else if Ojs.is_null js_val
      then `Unit ((fun _ -> ()) js_val)
      else
        invalid_arg
          "CustomReadonlyEditorProvider.resolve_custom_editor_result: unexpected \
           JavaScript value"
    ;;

    include
      [%js:
        val openCustomDocument
          :  t
          -> uri:Uri.t
          -> openContext:CustomDocumentOpenContext.t
          -> token:CancellationToken.t
          -> open_custom_document_result
        [@@js.call "openCustomDocument"]

        val resolveCustomEditor
          :  t
          -> document:T.t
          -> webviewPanel:WebviewPanel.t
          -> token:CancellationToken.t
          -> resolve_custom_editor_result
        [@@js.call "resolveCustomEditor"]]

    let create ~openCustomDocument ~resolveCustomEditor () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "openCustomDocument"
        ([%js.of:
           uri:Uri.t
           -> openContext:CustomDocumentOpenContext.t
           -> token:CancellationToken.t
           -> open_custom_document_result]
           openCustomDocument);
      Ojs.set_prop_ascii
        obj
        "resolveCustomEditor"
        ([%js.of:
           document:T.t
           -> webviewPanel:WebviewPanel.t
           -> token:CancellationToken.t
           -> resolve_custom_editor_result]
           resolveCustomEditor);
      t_of_js obj
    ;;
  end
end

module RegisterCustomEditorProviderOptions = struct
  include Interface.Make ()

  include
    [%js:
      val supportsMultipleEditorsPerDocument : t -> bool or_undefined [@@js.get]
      val webviewOptions : t -> WebviewPanelOptions.t or_undefined [@@js.get]

      val create
        :  ?supportsMultipleEditorsPerDocument:bool
        -> ?webviewOptions:WebviewPanelOptions.t
        -> unit
        -> t
      [@@js.builder]]
end

module CustomDocumentEditEvent = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    type undo_result =
      [ `Promise of unit Promise.t
      | `Unit of unit
      ]

    let undo_result_to_js = function
      | `Promise value ->
        (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
      | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
    ;;

    let undo_result_of_js js_val =
      if binding_is_thenable js_val
      then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
      else if Ojs.is_null js_val
      then `Unit ((fun _ -> ()) js_val)
      else invalid_arg "CustomDocumentEditEvent.undo_result: unexpected JavaScript value"
    ;;

    include
      [%js:
        val document : t -> T.t [@@js.get "document"]
        val undo : t -> undo_result [@@js.call "undo"]
        val redo : t -> undo_result [@@js.call "redo"]
        val label : t -> string or_undefined [@@js.get "label"]]

    let create ~document ~undo ~redo ?label () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii obj "document" (T.t_to_js document);
      Ojs.set_prop_ascii obj "undo" ([%js.of: unit -> undo_result] undo);
      Ojs.set_prop_ascii obj "redo" ([%js.of: unit -> undo_result] redo);
      iter_set obj "label" Ojs.string_to_js label;
      t_of_js obj
    ;;
  end
end

module CustomDocumentContentChangeEvent = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include [%js: val document : t -> T.t [@@js.get "document"]]

    let create ~document () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii obj "document" (T.t_to_js document);
      t_of_js obj
    ;;
  end
end

module CustomDocumentBackupContext = struct
  include Interface.Make ()
  include [%js: val destination : t -> Uri.t [@@js.get "destination"]]

  let create ~destination () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "destination" (Uri.t_to_js destination);
    t_of_js obj
  ;;
end

module CustomDocumentBackup = struct
  include Interface.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val delete : t -> unit [@@js.call "delete"]]

  let create ~id ~delete () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "id" (Ojs.string_to_js id);
    Ojs.set_prop_ascii obj "delete" ([%js.of: unit -> unit] delete);
    t_of_js obj
  ;;
end

module CustomEditorProvider = struct
  module G = struct
    type 'a t = 'a CustomReadonlyEditorProvider.t [@@js]
  end

  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    type open_custom_document_result =
      [ `Promise of T.t Promise.t
      | `Value of T.t
      ]

    let open_custom_document_result_to_js = function
      | `Promise value -> (Promise.t_to_js T.t_to_js) value
      | `Value value -> T.t_to_js value
    ;;

    let open_custom_document_result_of_js js_val =
      if binding_is_thenable js_val
      then `Promise ((Promise.t_of_js T.t_of_js) js_val)
      else if true
      then `Value (T.t_of_js js_val)
      else
        invalid_arg
          "CustomEditorProvider.open_custom_document_result: unexpected JavaScript value"
    ;;

    type resolve_custom_editor_result =
      [ `Promise of unit Promise.t
      | `Unit of unit
      ]

    let resolve_custom_editor_result_to_js = function
      | `Promise value ->
        (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
      | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
    ;;

    let resolve_custom_editor_result_of_js js_val =
      if binding_is_thenable js_val
      then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
      else if Ojs.is_null js_val
      then `Unit ((fun _ -> ()) js_val)
      else
        invalid_arg
          "CustomEditorProvider.resolve_custom_editor_result: unexpected JavaScript value"
    ;;

    type on_did_change_custom_document =
      [ `Event of T.t CustomDocumentEditEvent.t Event.t
      | `EventValue of T.t CustomDocumentContentChangeEvent.t Event.t
      ]

    let on_did_change_custom_document_to_js = function
      | `Event value -> (Event.t_to_js (CustomDocumentEditEvent.t_to_js T.t_to_js)) value
      | `EventValue value ->
        (Event.t_to_js (CustomDocumentContentChangeEvent.t_to_js T.t_to_js)) value
    ;;

    let on_did_change_custom_document_of_js js_val =
      if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
      then `Event ((Event.t_of_js (CustomDocumentEditEvent.t_of_js T.t_of_js)) js_val)
      else if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
      then
        `EventValue
          ((Event.t_of_js (CustomDocumentContentChangeEvent.t_of_js T.t_of_js)) js_val)
      else
        invalid_arg
          "CustomEditorProvider.on_did_change_custom_document: unexpected JavaScript \
           value"
    ;;

    include
      [%js:
        val openCustomDocument
          :  t
          -> uri:Uri.t
          -> openContext:CustomDocumentOpenContext.t
          -> token:CancellationToken.t
          -> open_custom_document_result
        [@@js.call "openCustomDocument"]

        val resolveCustomEditor
          :  t
          -> document:T.t
          -> webviewPanel:WebviewPanel.t
          -> token:CancellationToken.t
          -> resolve_custom_editor_result
        [@@js.call "resolveCustomEditor"]

        val onDidChangeCustomDocument : t -> on_did_change_custom_document
        [@@js.get "onDidChangeCustomDocument"]

        val saveCustomDocument
          :  t
          -> document:T.t
          -> cancellation:CancellationToken.t
          -> unit Promise.t
        [@@js.call "saveCustomDocument"]

        val saveCustomDocumentAs
          :  t
          -> document:T.t
          -> destination:Uri.t
          -> cancellation:CancellationToken.t
          -> unit Promise.t
        [@@js.call "saveCustomDocumentAs"]

        val revertCustomDocument
          :  t
          -> document:T.t
          -> cancellation:CancellationToken.t
          -> unit Promise.t
        [@@js.call "revertCustomDocument"]

        val backupCustomDocument
          :  t
          -> document:T.t
          -> context:CustomDocumentBackupContext.t
          -> cancellation:CancellationToken.t
          -> CustomDocumentBackup.t Promise.t
        [@@js.call "backupCustomDocument"]]

    let create
          ~openCustomDocument
          ~resolveCustomEditor
          ~onDidChangeCustomDocument
          ~saveCustomDocument
          ~saveCustomDocumentAs
          ~revertCustomDocument
          ~backupCustomDocument
          ()
      =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "openCustomDocument"
        ([%js.of:
           uri:Uri.t
           -> openContext:CustomDocumentOpenContext.t
           -> token:CancellationToken.t
           -> open_custom_document_result]
           openCustomDocument);
      Ojs.set_prop_ascii
        obj
        "resolveCustomEditor"
        ([%js.of:
           document:T.t
           -> webviewPanel:WebviewPanel.t
           -> token:CancellationToken.t
           -> resolve_custom_editor_result]
           resolveCustomEditor);
      Ojs.set_prop_ascii
        obj
        "onDidChangeCustomDocument"
        (on_did_change_custom_document_to_js onDidChangeCustomDocument);
      Ojs.set_prop_ascii
        obj
        "saveCustomDocument"
        ([%js.of: document:T.t -> cancellation:CancellationToken.t -> unit Promise.t]
           saveCustomDocument);
      Ojs.set_prop_ascii
        obj
        "saveCustomDocumentAs"
        ([%js.of:
           document:T.t
           -> destination:Uri.t
           -> cancellation:CancellationToken.t
           -> unit Promise.t]
           saveCustomDocumentAs);
      Ojs.set_prop_ascii
        obj
        "revertCustomDocument"
        ([%js.of: document:T.t -> cancellation:CancellationToken.t -> unit Promise.t]
           revertCustomDocument);
      Ojs.set_prop_ascii
        obj
        "backupCustomDocument"
        ([%js.of:
           document:T.t
           -> context:CustomDocumentBackupContext.t
           -> cancellation:CancellationToken.t
           -> CustomDocumentBackup.t Promise.t]
           backupCustomDocument);
      t_of_js obj
    ;;
  end

  let to_custom_readonly_editor_provider (type a) (value : a t) =
    (value :> a CustomReadonlyEditorProvider.t)
  ;;
end

module QuickInputButtons = struct
  include Class.Make ()

  include
    [%js:
      val back : unit -> QuickInputButton.t [@@js.get "@vscode.QuickInputButtons.Back"]]
end

module LogLevel = struct
  type t =
    | Off [@js 0]
    | Trace [@js 1]
    | Debug [@js 2]
    | Info [@js 3]
    | Warning [@js 4]
    | Error [@js 5]
  [@@js.enum] [@@js]
end

module LogOutputChannel = struct
  include Interface.Extend (OutputChannel) ()

  type error =
    [ `String of string
    | `Error of JsError.t
    ]

  let error_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Error value -> JsError.t_to_js value
  ;;

  let error_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if binding_has_member js_val "message"
    then `Error (JsError.t_of_js js_val)
    else invalid_arg "LogOutputChannel.error: unexpected JavaScript value"
  ;;

  let to_output_channel (value : t) = (value :> OutputChannel.t)

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val append : t -> value:string -> unit [@@js.call "append"]
      val appendLine : t -> value:string -> unit [@@js.call "appendLine"]
      val replace : t -> value:string -> unit [@@js.call "replace"]
      val clear : t -> unit [@@js.call "clear"]]

  let show this ?preserveFocus () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "show"
         (binding_arguments
            [| (or_undefined_to_js Ojs.bool_to_js) preserveFocus |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let showInColumn this ?column ?preserveFocus () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "show"
         (binding_arguments
            [| (or_undefined_to_js ViewColumn.t_to_js) column
             ; (or_undefined_to_js Ojs.bool_to_js) preserveFocus
            |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val hide : t -> unit [@@js.call "hide"]
      val dispose : t -> unit [@@js.call "dispose"]
      val logLevel : t -> LogLevel.t [@@js.get "logLevel"]
      val onDidChangeLogLevel : t -> LogLevel.t Event.t [@@js.get "onDidChangeLogLevel"]

      val trace : t -> message:string -> args:(Ojs.t list[@js.variadic]) -> unit
      [@@js.call "trace"]

      val debug : t -> message:string -> args:(Ojs.t list[@js.variadic]) -> unit
      [@@js.call "debug"]

      val info : t -> message:string -> args:(Ojs.t list[@js.variadic]) -> unit
      [@@js.call "info"]

      val warn : t -> message:string -> args:(Ojs.t list[@js.variadic]) -> unit
      [@@js.call "warn"]

      val error : t -> error:error -> args:(Ojs.t list[@js.variadic]) -> unit
      [@@js.call "error"]]
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
end = struct
  include Interface.Make ()

  include
    [%js:
      val label : t -> string [@@js.get "label"]
      val group : t -> TabGroup.t [@@js.get "group"]
      val input : t -> Ojs.t [@@js.get "input"]
      val isActive : t -> bool [@@js.get "isActive"]
      val isDirty : t -> bool [@@js.get "isDirty"]
      val isPinned : t -> bool [@@js.get "isPinned"]
      val isPreview : t -> bool [@@js.get "isPreview"]]

  let create ~label ~group ~input ~isActive ~isDirty ~isPinned ~isPreview () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "label" (Ojs.string_to_js label);
    Ojs.set_prop_ascii obj "group" (TabGroup.t_to_js group);
    Ojs.set_prop_ascii obj "input" (Ojs.t_to_js input);
    Ojs.set_prop_ascii obj "isActive" (Ojs.bool_to_js isActive);
    Ojs.set_prop_ascii obj "isDirty" (Ojs.bool_to_js isDirty);
    Ojs.set_prop_ascii obj "isPinned" (Ojs.bool_to_js isPinned);
    Ojs.set_prop_ascii obj "isPreview" (Ojs.bool_to_js isPreview);
    t_of_js obj
  ;;
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
end = struct
  include Interface.Make ()

  include
    [%js:
      val isActive : t -> bool [@@js.get "isActive"]
      val viewColumn : t -> ViewColumn.t [@@js.get "viewColumn"]
      val activeTab : t -> Tab.t or_undefined [@@js.get "activeTab"]
      val tabs : t -> Tab.t list [@@js.get "tabs"]]

  let create ~isActive ~viewColumn ~activeTab ~tabs () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "isActive" (Ojs.bool_to_js isActive);
    Ojs.set_prop_ascii obj "viewColumn" (ViewColumn.t_to_js viewColumn);
    Ojs.set_prop_ascii obj "activeTab" ((or_undefined_to_js Tab.t_to_js) activeTab);
    Ojs.set_prop_ascii obj "tabs" ((Ojs.list_to_js Tab.t_to_js) tabs);
    t_of_js obj
  ;;
end

module TabGroupChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val opened : t -> TabGroup.t list [@@js.get "opened"]
      val closed : t -> TabGroup.t list [@@js.get "closed"]
      val changed : t -> TabGroup.t list [@@js.get "changed"]]

  let create ~opened ~closed ~changed () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "opened" ((Ojs.list_to_js TabGroup.t_to_js) opened);
    Ojs.set_prop_ascii obj "closed" ((Ojs.list_to_js TabGroup.t_to_js) closed);
    Ojs.set_prop_ascii obj "changed" ((Ojs.list_to_js TabGroup.t_to_js) changed);
    t_of_js obj
  ;;
end

module TabChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val opened : t -> Tab.t list [@@js.get "opened"]
      val closed : t -> Tab.t list [@@js.get "closed"]
      val changed : t -> Tab.t list [@@js.get "changed"]]

  let create ~opened ~closed ~changed () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "opened" ((Ojs.list_to_js Tab.t_to_js) opened);
    Ojs.set_prop_ascii obj "closed" ((Ojs.list_to_js Tab.t_to_js) closed);
    Ojs.set_prop_ascii obj "changed" ((Ojs.list_to_js Tab.t_to_js) changed);
    t_of_js obj
  ;;
end

module TabGroups = struct
  include Interface.Make ()

  type close_tab =
    [ `Tab of Tab.t
    | `Items of Tab.t list
    ]

  let close_tab_to_js = function
    | `Tab value -> Tab.t_to_js value
    | `Items value -> (Ojs.list_to_js Tab.t_to_js) value
  ;;

  let close_tab_of_js js_val =
    if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "label"
      && binding_has_member js_val "group"
      && binding_has_member js_val "input"
      && binding_has_member js_val "isActive"
      && binding_has_member js_val "isDirty"
      && binding_has_member js_val "isPinned"
      && binding_has_member js_val "isPreview"
    then `Tab (Tab.t_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "object"
          && (not (Ojs.is_null js_val))
          && binding_has_member js_val "label"
          && binding_has_member js_val "group"
          && binding_has_member js_val "input"
          && binding_has_member js_val "isActive"
          && binding_has_member js_val "isDirty"
          && binding_has_member js_val "isPinned"
          && binding_has_member js_val "isPreview")
    then `Items ((Ojs.list_of_js Tab.t_of_js) js_val)
    else invalid_arg "TabGroups.close_tab: unexpected JavaScript value"
  ;;

  type close_groups_tab_group =
    [ `TabGroup of TabGroup.t
    | `Items of TabGroup.t list
    ]

  let close_groups_tab_group_to_js = function
    | `TabGroup value -> TabGroup.t_to_js value
    | `Items value -> (Ojs.list_to_js TabGroup.t_to_js) value
  ;;

  let close_groups_tab_group_of_js js_val =
    if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "isActive"
      && binding_has_member js_val "viewColumn"
      && binding_has_member js_val "activeTab"
      && binding_has_member js_val "tabs"
    then `TabGroup (TabGroup.t_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "object"
          && (not (Ojs.is_null js_val))
          && binding_has_member js_val "isActive"
          && binding_has_member js_val "viewColumn"
          && binding_has_member js_val "activeTab"
          && binding_has_member js_val "tabs")
    then `Items ((Ojs.list_of_js TabGroup.t_of_js) js_val)
    else invalid_arg "TabGroups.close_groups_tab_group: unexpected JavaScript value"
  ;;

  include
    [%js:
      val all : t -> TabGroup.t list [@@js.get "all"]
      val activeTabGroup : t -> TabGroup.t [@@js.get "activeTabGroup"]

      val onDidChangeTabGroups : t -> TabGroupChangeEvent.t Event.t
      [@@js.get "onDidChangeTabGroups"]

      val onDidChangeTabs : t -> TabChangeEvent.t Event.t [@@js.get "onDidChangeTabs"]]

  let close this ~tab ?preserveFocus () =
    (Promise.t_of_js Ojs.bool_of_js)
      (Ojs.call
         (t_to_js this)
         "close"
         (binding_arguments
            [| close_tab_to_js tab; (or_undefined_to_js Ojs.bool_to_js) preserveFocus |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let closeGroups this ~tabGroup ?preserveFocus () =
    (Promise.t_of_js Ojs.bool_of_js)
      (Ojs.call
         (t_to_js this)
         "close"
         (binding_arguments
            [| close_groups_tab_group_to_js tabGroup
             ; (or_undefined_to_js Ojs.bool_to_js) preserveFocus
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module TextEditorVisibleRangesChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val textEditor : t -> TextEditor.t [@@js.get "textEditor"]
      val visibleRanges : t -> Range.t list [@@js.get "visibleRanges"]]

  let create ~textEditor ~visibleRanges () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "textEditor" (TextEditor.t_to_js textEditor);
    Ojs.set_prop_ascii obj "visibleRanges" ((Ojs.list_to_js Range.t_to_js) visibleRanges);
    t_of_js obj
  ;;
end

module TextEditorOptionsChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val textEditor : t -> TextEditor.t [@@js.get "textEditor"]
      val options : t -> TextEditorOptions.t [@@js.get "options"]]

  let create ~textEditor ~options () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "textEditor" (TextEditor.t_to_js textEditor);
    Ojs.set_prop_ascii obj "options" (TextEditorOptions.t_to_js options);
    t_of_js obj
  ;;
end

module TextEditorViewColumnChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val textEditor : t -> TextEditor.t [@@js.get "textEditor"]
      val viewColumn : t -> ViewColumn.t [@@js.get "viewColumn"]]

  let create ~textEditor ~viewColumn () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "textEditor" (TextEditor.t_to_js textEditor);
    Ojs.set_prop_ascii obj "viewColumn" (ViewColumn.t_to_js viewColumn);
    t_of_js obj
  ;;
end

module NotebookEditorRevealType = struct
  type t =
    | Default [@js 0]
    | InCenter [@js 1]
    | InCenterIfOutsideViewport [@js 2]
    | AtTop [@js 3]
  [@@js.enum] [@@js]
end

module NotebookEditor = struct
  include Interface.Make ()

  include
    [%js:
      val notebook : t -> NotebookDocument.t [@@js.get "notebook"]
      val selection : t -> NotebookRange.t [@@js.get "selection"]
      val set_selection : t -> NotebookRange.t -> unit [@@js.set "selection"]
      val selections : t -> NotebookRange.t list [@@js.get "selections"]
      val set_selections : t -> NotebookRange.t list -> unit [@@js.set "selections"]
      val visibleRanges : t -> NotebookRange.t list [@@js.get "visibleRanges"]
      val viewColumn : t -> ViewColumn.t or_undefined [@@js.get "viewColumn"]]

  let revealRange this ~range ?revealType () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "revealRange"
         (binding_arguments
            [| NotebookRange.t_to_js range
             ; (or_undefined_to_js NotebookEditorRevealType.t_to_js) revealType
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module NotebookEditorSelectionChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val notebookEditor : t -> NotebookEditor.t [@@js.get "notebookEditor"]
      val selections : t -> NotebookRange.t list [@@js.get "selections"]]

  let create ~notebookEditor ~selections () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "notebookEditor" (NotebookEditor.t_to_js notebookEditor);
    Ojs.set_prop_ascii
      obj
      "selections"
      ((Ojs.list_to_js NotebookRange.t_to_js) selections);
    t_of_js obj
  ;;
end

module NotebookEditorVisibleRangesChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val notebookEditor : t -> NotebookEditor.t [@@js.get "notebookEditor"]
      val visibleRanges : t -> NotebookRange.t list [@@js.get "visibleRanges"]]

  let create ~notebookEditor ~visibleRanges () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "notebookEditor" (NotebookEditor.t_to_js notebookEditor);
    Ojs.set_prop_ascii
      obj
      "visibleRanges"
      ((Ojs.list_to_js NotebookRange.t_to_js) visibleRanges);
    t_of_js obj
  ;;
end

module WindowState = struct
  include Interface.Make ()

  include
    [%js:
      val focused : t -> bool [@@js.get "focused"]
      val active : t -> bool [@@js.get "active"]]

  let create ~focused ~active () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "focused" (Ojs.bool_to_js focused);
    Ojs.set_prop_ascii obj "active" (Ojs.bool_to_js active);
    t_of_js obj
  ;;
end

module NotebookDocumentShowOptions = struct
  include Interface.Make ()

  include
    [%js:
      val viewColumn : t -> ViewColumn.t or_undefined [@@js.get "viewColumn"]
      val preserveFocus : t -> bool or_undefined [@@js.get "preserveFocus"]
      val preview : t -> bool or_undefined [@@js.get "preview"]
      val selections : t -> NotebookRange.t list or_undefined [@@js.get "selections"]]

  let create ?viewColumn ?preserveFocus ?preview ?selections () =
    let obj = Ojs.obj [||] in
    iter_set obj "viewColumn" ViewColumn.t_to_js viewColumn;
    iter_set obj "preserveFocus" Ojs.bool_to_js preserveFocus;
    iter_set obj "preview" Ojs.bool_to_js preview;
    iter_set obj "selections" (Ojs.list_to_js NotebookRange.t_to_js) selections;
    t_of_js obj
  ;;
end

module WorkspaceFolderPickOptions = struct
  include Interface.Make ()

  include
    [%js:
      val placeHolder : t -> string or_undefined [@@js.get "placeHolder"]
      val set_placeHolder : t -> string or_undefined -> unit [@@js.set "placeHolder"]
      val ignoreFocusOut : t -> bool or_undefined [@@js.get "ignoreFocusOut"]
      val set_ignoreFocusOut : t -> bool or_undefined -> unit [@@js.set "ignoreFocusOut"]]

  let create ?placeHolder ?ignoreFocusOut () =
    let obj = Ojs.obj [||] in
    iter_set obj "placeHolder" Ojs.string_to_js placeHolder;
    iter_set obj "ignoreFocusOut" Ojs.bool_to_js ignoreFocusOut;
    t_of_js obj
  ;;
end

module SaveDialogOptions = struct
  include Interface.Make ()

  include
    [%js:
      val defaultUri : t -> Uri.t or_undefined [@@js.get "defaultUri"]
      val set_defaultUri : t -> Uri.t or_undefined -> unit [@@js.set "defaultUri"]
      val saveLabel : t -> string or_undefined [@@js.get "saveLabel"]
      val set_saveLabel : t -> string or_undefined -> unit [@@js.set "saveLabel"]
      val filters : t -> string list Dict.t or_undefined [@@js.get "filters"]
      val set_filters : t -> string list Dict.t or_undefined -> unit [@@js.set "filters"]
      val title : t -> string or_undefined [@@js.get "title"]
      val set_title : t -> string or_undefined -> unit [@@js.set "title"]]

  let create ?defaultUri ?saveLabel ?filters ?title () =
    let obj = Ojs.obj [||] in
    iter_set obj "defaultUri" Uri.t_to_js defaultUri;
    iter_set obj "saveLabel" Ojs.string_to_js saveLabel;
    iter_set obj "filters" (Dict.t_to_js (Ojs.list_to_js Ojs.string_to_js)) filters;
    iter_set obj "title" Ojs.string_to_js title;
    t_of_js obj
  ;;
end

module UriHandler = struct
  include Interface.Make ()

  include
    [%js: val handleUri : t -> uri:Uri.t -> unit ProviderResult.t [@@js.call "handleUri"]]

  let create ~handleUri () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "handleUri"
      ([%js.of: uri:Uri.t -> unit ProviderResult.t] handleUri);
    t_of_js obj
  ;;
end

module WebviewPanelSerializer = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val deserializeWebviewPanel
          :  t
          -> webviewPanel:WebviewPanel.t
          -> state:T.t
          -> unit Promise.t
        [@@js.call "deserializeWebviewPanel"]]

    let create ~deserializeWebviewPanel () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "deserializeWebviewPanel"
        ([%js.of: webviewPanel:WebviewPanel.t -> state:T.t -> unit Promise.t]
           deserializeWebviewPanel);
      t_of_js obj
    ;;
  end
end

module WebviewView = struct
  include Interface.Make ()

  include
    [%js:
      val viewType : t -> string [@@js.get "viewType"]
      val webview : t -> WebView.t [@@js.get "webview"]
      val title : t -> string or_undefined [@@js.get "title"]
      val set_title : t -> string or_undefined -> unit [@@js.set "title"]
      val description : t -> string or_undefined [@@js.get "description"]
      val set_description : t -> string or_undefined -> unit [@@js.set "description"]
      val badge : t -> ViewBadge.t or_undefined [@@js.get "badge"]
      val set_badge : t -> ViewBadge.t or_undefined -> unit [@@js.set "badge"]
      val onDidDispose : t -> unit Event.t [@@js.get "onDidDispose"]
      val visible : t -> bool [@@js.get "visible"]
      val onDidChangeVisibility : t -> unit Event.t [@@js.get "onDidChangeVisibility"]]

  let show this ?preserveFocus () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "show"
         (binding_arguments
            [| (or_undefined_to_js Ojs.bool_to_js) preserveFocus |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module WebviewViewResolveContext = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include [%js: val state : t -> T.t or_undefined [@@js.get "state"]]

    let create ~state () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii obj "state" ((or_undefined_to_js T.t_to_js) state);
      t_of_js obj
    ;;
  end
end

module WebviewViewProvider = struct
  include Interface.Make ()

  type resolve_webview_view_result =
    [ `Promise of unit Promise.t
    | `Unit of unit
    ]

  let resolve_webview_view_result_to_js = function
    | `Promise value ->
      (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
    | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
  ;;

  let resolve_webview_view_result_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
    else if Ojs.is_null js_val
    then `Unit ((fun _ -> ()) js_val)
    else
      invalid_arg
        "WebviewViewProvider.resolve_webview_view_result: unexpected JavaScript value"
  ;;

  include
    [%js:
      val resolveWebviewView
        :  t
        -> webviewView:WebviewView.t
        -> context:Ojs.t WebviewViewResolveContext.t
        -> token:CancellationToken.t
        -> resolve_webview_view_result
      [@@js.call "resolveWebviewView"]]

  let create ~resolveWebviewView () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "resolveWebviewView"
      ([%js.of:
         webviewView:WebviewView.t
         -> context:Ojs.t WebviewViewResolveContext.t
         -> token:CancellationToken.t
         -> resolve_webview_view_result]
         resolveWebviewView);
    t_of_js obj
  ;;
end

module TerminalLink = struct
  include Class.Make ()

  include
    [%js:
      val startIndex : t -> int [@@js.get "startIndex"]
      val set_startIndex : t -> int -> unit [@@js.set "startIndex"]
      val length : t -> int [@@js.get "length"]
      val set_length : t -> int -> unit [@@js.set "length"]
      val tooltip : t -> string or_undefined [@@js.get "tooltip"]
      val set_tooltip : t -> string or_undefined -> unit [@@js.set "tooltip"]]

  let make ~startIndex ~length ?tooltip () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "TerminalLink")
         (binding_arguments
            [| Ojs.int_to_js startIndex
             ; Ojs.int_to_js length
             ; (or_undefined_to_js Ojs.string_to_js) tooltip
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module TerminalLinkContext = struct
  include Interface.Make ()

  include
    [%js:
      val line : t -> string [@@js.get "line"]
      val set_line : t -> string -> unit [@@js.set "line"]
      val terminal : t -> Terminal.t [@@js.get "terminal"]
      val set_terminal : t -> Terminal.t -> unit [@@js.set "terminal"]]

  let create ~line ~terminal () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "line" (Ojs.string_to_js line);
    Ojs.set_prop_ascii obj "terminal" (Terminal.t_to_js terminal);
    t_of_js obj
  ;;
end

module TerminalLinkProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val provideTerminalLinks
          :  t
          -> context:TerminalLinkContext.t
          -> token:CancellationToken.t
          -> T.t list ProviderResult.t
        [@@js.call "provideTerminalLinks"]

        val handleTerminalLink : t -> link:T.t -> unit ProviderResult.t
        [@@js.call "handleTerminalLink"]]

    let create ~provideTerminalLinks ~handleTerminalLink () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "provideTerminalLinks"
        ([%js.of:
           context:TerminalLinkContext.t
           -> token:CancellationToken.t
           -> T.t list ProviderResult.t]
           provideTerminalLinks);
      Ojs.set_prop_ascii
        obj
        "handleTerminalLink"
        ([%js.of: link:T.t -> unit ProviderResult.t] handleTerminalLink);
      t_of_js obj
    ;;
  end
end

module TerminalProfile = struct
  include Class.Make ()

  type options =
    [ `TerminalOptions of TerminalOptions.t
    | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
    ]

  let options_to_js = function
    | `TerminalOptions value -> TerminalOptions.t_to_js value
    | `ExtensionTerminalOptions value -> ExtensionTerminalOptions.t_to_js value
  ;;

  let options_of_js js_val =
    if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then `TerminalOptions (TerminalOptions.t_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "name"
      && binding_has_member js_val "pty"
    then `ExtensionTerminalOptions (ExtensionTerminalOptions.t_of_js js_val)
    else invalid_arg "TerminalProfile.options: unexpected JavaScript value"
  ;;

  include
    [%js:
      val options : t -> options [@@js.get "options"]
      val set_options : t -> options -> unit [@@js.set "options"]
      val make : options:options -> t [@@js.new "@vscode.TerminalProfile"]]
end

module TerminalProfileProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideTerminalProfile
        :  t
        -> token:CancellationToken.t
        -> TerminalProfile.t ProviderResult.t
      [@@js.call "provideTerminalProfile"]]

  let create ~provideTerminalProfile () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideTerminalProfile"
      ([%js.of: token:CancellationToken.t -> TerminalProfile.t ProviderResult.t]
         provideTerminalProfile);
    t_of_js obj
  ;;
end

module FileDecoration = struct
  include Class.Make ()

  include
    [%js:
      val badge : t -> string or_undefined [@@js.get "badge"]
      val set_badge : t -> string or_undefined -> unit [@@js.set "badge"]
      val tooltip : t -> string or_undefined [@@js.get "tooltip"]
      val set_tooltip : t -> string or_undefined -> unit [@@js.set "tooltip"]
      val color : t -> ThemeColor.t or_undefined [@@js.get "color"]
      val set_color : t -> ThemeColor.t or_undefined -> unit [@@js.set "color"]
      val propagate : t -> bool or_undefined [@@js.get "propagate"]
      val set_propagate : t -> bool or_undefined -> unit [@@js.set "propagate"]]

  let make ?badge ?tooltip ?color () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "FileDecoration")
         (binding_arguments
            [| (or_undefined_to_js Ojs.string_to_js) badge
             ; (or_undefined_to_js Ojs.string_to_js) tooltip
             ; (or_undefined_to_js ThemeColor.t_to_js) color
            |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module FileDecorationProvider = struct
  include Interface.Make ()

  type on_did_change_file_decorations_t =
    [ `Uri of Uri.t
    | `Items of Uri.t list
    ]

  let on_did_change_file_decorations_t_to_js = function
    | `Uri value -> Uri.t_to_js value
    | `Items value -> (Ojs.list_to_js Uri.t_to_js) value
  ;;

  let on_did_change_file_decorations_t_of_js js_val =
    match binding_constructor js_val [ "Uri" ] with
    | Some "Uri" -> `Uri (Uri.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "scheme"
        && binding_has_member js_val "authority"
        && binding_has_member js_val "path"
        && binding_has_member js_val "query"
        && binding_has_member js_val "fragment"
        && binding_has_member js_val "fsPath"
        && binding_has_member js_val "with"
        && binding_has_member js_val "toString"
        && binding_has_member js_val "toJSON"
      then `Uri (Uri.t_of_js js_val)
      else if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            Ojs.type_of js_val = "object"
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "scheme"
            && binding_has_member js_val "authority"
            && binding_has_member js_val "path"
            && binding_has_member js_val "query"
            && binding_has_member js_val "fragment"
            && binding_has_member js_val "fsPath"
            && binding_has_member js_val "with"
            && binding_has_member js_val "toString"
            && binding_has_member js_val "toJSON")
      then `Items ((Ojs.list_of_js Uri.t_of_js) js_val)
      else
        invalid_arg
          "FileDecorationProvider.on_did_change_file_decorations_t: unexpected \
           JavaScript value"
  ;;

  include
    [%js:
      val onDidChangeFileDecorations
        :  t
        -> on_did_change_file_decorations_t or_undefined Event.t or_undefined
      [@@js.get "onDidChangeFileDecorations"]

      val set_onDidChangeFileDecorations
        :  t
        -> on_did_change_file_decorations_t or_undefined Event.t or_undefined
        -> unit
      [@@js.set "onDidChangeFileDecorations"]

      val provideFileDecoration
        :  t
        -> uri:Uri.t
        -> token:CancellationToken.t
        -> FileDecoration.t ProviderResult.t
      [@@js.call "provideFileDecoration"]]

  let create ?onDidChangeFileDecorations ~provideFileDecoration () =
    let obj = Ojs.obj [||] in
    iter_set
      obj
      "onDidChangeFileDecorations"
      (Event.t_to_js (or_undefined_to_js on_did_change_file_decorations_t_to_js))
      onDidChangeFileDecorations;
    Ojs.set_prop_ascii
      obj
      "provideFileDecoration"
      ([%js.of:
         uri:Uri.t -> token:CancellationToken.t -> FileDecoration.t ProviderResult.t]
         provideFileDecoration);
    t_of_js obj
  ;;
end

module ColorThemeKind = struct
  type t =
    | Light [@js 1]
    | Dark [@js 2]
    | HighContrast [@js 3]
    | HighContrastLight [@js 4]
  [@@js.enum] [@@js]
end

module ColorTheme = struct
  include Interface.Make ()
  include [%js: val kind : t -> ColorThemeKind.t [@@js.get "kind"]]

  let create ~kind () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "kind" (ColorThemeKind.t_to_js kind);
    t_of_js obj
  ;;
end

module Window = struct
  type show_quick_pick_many_items =
    [ `Value of string list
    | `Promise of string list Promise.t
    ]

  let show_quick_pick_many_items_to_js = function
    | `Value value -> (Ojs.list_to_js Ojs.string_to_js) value
    | `Promise value -> (Promise.t_to_js (Ojs.list_to_js Ojs.string_to_js)) value
  ;;

  let show_quick_pick_many_items_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js (Ojs.list_of_js Ojs.string_of_js)) js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "string")
    then `Value ((Ojs.list_of_js Ojs.string_of_js) js_val)
    else invalid_arg "Window.show_quick_pick_many_items: unexpected JavaScript value"
  ;;

  type show_quick_pick_many_options_can_pick_many = [ `True ]

  let show_quick_pick_many_options_can_pick_many_to_js = function
    | `True -> Ojs.bool_to_js true
  ;;

  let show_quick_pick_many_options_can_pick_many_of_js js_val =
    if Ojs.type_of js_val = "boolean" && Ojs.bool_of_js js_val
    then `True
    else
      invalid_arg
        "Window.show_quick_pick_many_options_can_pick_many: unexpected JavaScript value"
  ;;

  type show_quick_pick_many_options_on_did_select_item_arg0 =
    [ `QuickPickItem of QuickPickItem.t
    | `String of string
    ]

  let show_quick_pick_many_options_on_did_select_item_arg0_to_js = function
    | `QuickPickItem value -> QuickPickItem.t_to_js value
    | `String value -> Ojs.string_to_js value
  ;;

  let show_quick_pick_many_options_on_did_select_item_arg0_of_js js_val =
    if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "label"
    then `QuickPickItem (QuickPickItem.t_of_js js_val)
    else if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else
      invalid_arg
        "Window.show_quick_pick_many_options_on_did_select_item_arg0: unexpected \
         JavaScript value"
  ;;

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

  let show_quick_pick_many_options_to_js (value : show_quick_pick_many_options) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "title" Ojs.string_to_js value.title;
    iter_set js_val "matchOnDescription" Ojs.bool_to_js value.matchOnDescription;
    iter_set js_val "matchOnDetail" Ojs.bool_to_js value.matchOnDetail;
    iter_set js_val "placeHolder" Ojs.string_to_js value.placeHolder;
    iter_set js_val "prompt" Ojs.string_to_js value.prompt;
    iter_set js_val "ignoreFocusOut" Ojs.bool_to_js value.ignoreFocusOut;
    Ojs.set_prop_ascii
      js_val
      "canPickMany"
      (show_quick_pick_many_options_can_pick_many_to_js value.canPickMany);
    iter_set
      js_val
      "onDidSelectItem"
      [%js.of: item:show_quick_pick_many_options_on_did_select_item_arg0 -> Ojs.t]
      value.onDidSelectItem;
    js_val
  ;;

  let show_quick_pick_many_options_of_js js_val : show_quick_pick_many_options =
    { title = (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "title")
    ; matchOnDescription =
        (or_undefined_of_js Ojs.bool_of_js)
          (Ojs.get_prop_ascii js_val "matchOnDescription")
    ; matchOnDetail =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "matchOnDetail")
    ; placeHolder =
        (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "placeHolder")
    ; prompt = (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "prompt")
    ; ignoreFocusOut =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "ignoreFocusOut")
    ; canPickMany =
        show_quick_pick_many_options_can_pick_many_of_js
          (Ojs.get_prop_ascii js_val "canPickMany")
    ; onDidSelectItem =
        (or_undefined_of_js
           [%js.to: item:show_quick_pick_many_options_on_did_select_item_arg0 -> Ojs.t])
          (Ojs.get_prop_ascii js_val "onDidSelectItem")
    }
  ;;

  type 'p_t show_quick_pick_items_many_items =
    [ `Value of 'p_t list
    | `Promise of 'p_t list Promise.t
    ]

  let show_quick_pick_items_many_items_to_js (type p_t) (p_t_to_js : p_t -> Ojs.t)
    = function
    | `Value value -> (Ojs.list_to_js p_t_to_js) value
    | `Promise value -> (Promise.t_to_js (Ojs.list_to_js p_t_to_js)) value
  ;;

  let show_quick_pick_items_many_items_of_js (type p_t) (p_t_of_js : Ojs.t -> p_t) js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js (Ojs.list_of_js p_t_of_js)) js_val)
    else if binding_is_array js_val
    then `Value ((Ojs.list_of_js p_t_of_js) js_val)
    else
      invalid_arg "Window.show_quick_pick_items_many_items: unexpected JavaScript value"
  ;;

  type show_quick_pick_items_many_options_can_pick_many = [ `True ]

  let show_quick_pick_items_many_options_can_pick_many_to_js = function
    | `True -> Ojs.bool_to_js true
  ;;

  let show_quick_pick_items_many_options_can_pick_many_of_js js_val =
    if Ojs.type_of js_val = "boolean" && Ojs.bool_of_js js_val
    then `True
    else
      invalid_arg
        "Window.show_quick_pick_items_many_options_can_pick_many: unexpected JavaScript \
         value"
  ;;

  type show_quick_pick_items_many_options_on_did_select_item_arg0 =
    [ `QuickPickItem of QuickPickItem.t
    | `String of string
    ]

  let show_quick_pick_items_many_options_on_did_select_item_arg0_to_js = function
    | `QuickPickItem value -> QuickPickItem.t_to_js value
    | `String value -> Ojs.string_to_js value
  ;;

  let show_quick_pick_items_many_options_on_did_select_item_arg0_of_js js_val =
    if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "label"
    then `QuickPickItem (QuickPickItem.t_of_js js_val)
    else if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else
      invalid_arg
        "Window.show_quick_pick_items_many_options_on_did_select_item_arg0: unexpected \
         JavaScript value"
  ;;

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

  let show_quick_pick_items_many_options_to_js
        (value : show_quick_pick_items_many_options)
    =
    let js_val = Ojs.obj [||] in
    iter_set js_val "title" Ojs.string_to_js value.title;
    iter_set js_val "matchOnDescription" Ojs.bool_to_js value.matchOnDescription;
    iter_set js_val "matchOnDetail" Ojs.bool_to_js value.matchOnDetail;
    iter_set js_val "placeHolder" Ojs.string_to_js value.placeHolder;
    iter_set js_val "prompt" Ojs.string_to_js value.prompt;
    iter_set js_val "ignoreFocusOut" Ojs.bool_to_js value.ignoreFocusOut;
    Ojs.set_prop_ascii
      js_val
      "canPickMany"
      (show_quick_pick_items_many_options_can_pick_many_to_js value.canPickMany);
    iter_set
      js_val
      "onDidSelectItem"
      [%js.of: item:show_quick_pick_items_many_options_on_did_select_item_arg0 -> Ojs.t]
      value.onDidSelectItem;
    js_val
  ;;

  let show_quick_pick_items_many_options_of_js js_val : show_quick_pick_items_many_options
    =
    { title = (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "title")
    ; matchOnDescription =
        (or_undefined_of_js Ojs.bool_of_js)
          (Ojs.get_prop_ascii js_val "matchOnDescription")
    ; matchOnDetail =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "matchOnDetail")
    ; placeHolder =
        (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "placeHolder")
    ; prompt = (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "prompt")
    ; ignoreFocusOut =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "ignoreFocusOut")
    ; canPickMany =
        show_quick_pick_items_many_options_can_pick_many_of_js
          (Ojs.get_prop_ascii js_val "canPickMany")
    ; onDidSelectItem =
        (or_undefined_of_js
           [%js.to:
             item:show_quick_pick_items_many_options_on_did_select_item_arg0 -> Ojs.t])
          (Ojs.get_prop_ascii js_val "onDidSelectItem")
    }
  ;;

  type create_webview_panel_with_options_show_options_item =
    { viewColumn : ViewColumn.t
    ; preserveFocus : bool or_undefined
    }

  let create_webview_panel_with_options_show_options_item_to_js
        (value : create_webview_panel_with_options_show_options_item)
    =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "viewColumn" (ViewColumn.t_to_js value.viewColumn);
    iter_set js_val "preserveFocus" Ojs.bool_to_js value.preserveFocus;
    js_val
  ;;

  let create_webview_panel_with_options_show_options_item_of_js js_val
    : create_webview_panel_with_options_show_options_item
    =
    { viewColumn = ViewColumn.t_of_js (Ojs.get_prop_ascii js_val "viewColumn")
    ; preserveFocus =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "preserveFocus")
    }
  ;;

  type create_webview_panel_with_options_show_options =
    [ `ViewColumn of ViewColumn.t
    | `Options of create_webview_panel_with_options_show_options_item
    ]

  let create_webview_panel_with_options_show_options_to_js = function
    | `ViewColumn value -> ViewColumn.t_to_js value
    | `Options value -> create_webview_panel_with_options_show_options_item_to_js value
  ;;

  let create_webview_panel_with_options_show_options_of_js js_val =
    if Ojs.type_of js_val = "number"
    then `ViewColumn (ViewColumn.t_of_js js_val)
    else if
      (Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "viewColumn"
    then `Options (create_webview_panel_with_options_show_options_item_of_js js_val)
    else
      invalid_arg
        "Window.create_webview_panel_with_options_show_options: unexpected JavaScript \
         value"
  ;;

  type create_webview_panel_with_options_enable_command_uris =
    [ `Bool of bool
    | `Items of string list
    ]

  let create_webview_panel_with_options_enable_command_uris_to_js = function
    | `Bool value -> Ojs.bool_to_js value
    | `Items value -> (Ojs.list_to_js Ojs.string_to_js) value
  ;;

  let create_webview_panel_with_options_enable_command_uris_of_js js_val =
    if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "string")
    then `Items ((Ojs.list_of_js Ojs.string_of_js) js_val)
    else
      invalid_arg
        "Window.create_webview_panel_with_options_enable_command_uris: unexpected \
         JavaScript value"
  ;;

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

  let create_webview_panel_with_options_to_js (value : create_webview_panel_with_options) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "enableFindWidget" Ojs.bool_to_js value.enableFindWidget;
    iter_set js_val "retainContextWhenHidden" Ojs.bool_to_js value.retainContextWhenHidden;
    iter_set js_val "enableScripts" Ojs.bool_to_js value.enableScripts;
    iter_set js_val "enableForms" Ojs.bool_to_js value.enableForms;
    iter_set
      js_val
      "enableCommandUris"
      create_webview_panel_with_options_enable_command_uris_to_js
      value.enableCommandUris;
    iter_set
      js_val
      "localResourceRoots"
      (Ojs.list_to_js Uri.t_to_js)
      value.localResourceRoots;
    iter_set
      js_val
      "portMapping"
      (Ojs.list_to_js WebviewPortMapping.t_to_js)
      value.portMapping;
    js_val
  ;;

  let create_webview_panel_with_options_of_js js_val : create_webview_panel_with_options =
    { enableFindWidget =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "enableFindWidget")
    ; retainContextWhenHidden =
        (or_undefined_of_js Ojs.bool_of_js)
          (Ojs.get_prop_ascii js_val "retainContextWhenHidden")
    ; enableScripts =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "enableScripts")
    ; enableForms =
        (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "enableForms")
    ; enableCommandUris =
        (or_undefined_of_js create_webview_panel_with_options_enable_command_uris_of_js)
          (Ojs.get_prop_ascii js_val "enableCommandUris")
    ; localResourceRoots =
        (or_undefined_of_js (Ojs.list_of_js Uri.t_of_js))
          (Ojs.get_prop_ascii js_val "localResourceRoots")
    ; portMapping =
        (or_undefined_of_js (Ojs.list_of_js WebviewPortMapping.t_of_js))
          (Ojs.get_prop_ascii js_val "portMapping")
    }
  ;;

  type register_webview_view_provider_options_webview_options =
    { retainContextWhenHidden : bool or_undefined }

  let register_webview_view_provider_options_webview_options_to_js
        (value : register_webview_view_provider_options_webview_options)
    =
    let js_val = Ojs.obj [||] in
    iter_set js_val "retainContextWhenHidden" Ojs.bool_to_js value.retainContextWhenHidden;
    js_val
  ;;

  let register_webview_view_provider_options_webview_options_of_js js_val
    : register_webview_view_provider_options_webview_options
    =
    { retainContextWhenHidden =
        (or_undefined_of_js Ojs.bool_of_js)
          (Ojs.get_prop_ascii js_val "retainContextWhenHidden")
    }
  ;;

  type register_webview_view_provider_options =
    { webviewOptions : register_webview_view_provider_options_webview_options or_undefined
    }

  let register_webview_view_provider_options_to_js
        (value : register_webview_view_provider_options)
    =
    let js_val = Ojs.obj [||] in
    iter_set
      js_val
      "webviewOptions"
      register_webview_view_provider_options_webview_options_to_js
      value.webviewOptions;
    js_val
  ;;

  let register_webview_view_provider_options_of_js js_val
    : register_webview_view_provider_options
    =
    { webviewOptions =
        (or_undefined_of_js register_webview_view_provider_options_webview_options_of_js)
          (Ojs.get_prop_ascii js_val "webviewOptions")
    }
  ;;

  type register_custom_editor_provider =
    [ `CustomTextEditorProvider of CustomTextEditorProvider.t
    | `CustomReadonlyEditorProvider of CustomDocument.t CustomReadonlyEditorProvider.t
    | `CustomEditorProvider of CustomDocument.t CustomEditorProvider.t
    ]

  let register_custom_editor_provider_to_js = function
    | `CustomTextEditorProvider value -> CustomTextEditorProvider.t_to_js value
    | `CustomReadonlyEditorProvider value ->
      (CustomReadonlyEditorProvider.t_to_js CustomDocument.t_to_js) value
    | `CustomEditorProvider value ->
      (CustomEditorProvider.t_to_js CustomDocument.t_to_js) value
  ;;

  let register_custom_editor_provider_of_js js_val =
    if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "resolveCustomTextEditor"
    then `CustomTextEditorProvider (CustomTextEditorProvider.t_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "openCustomDocument"
      && binding_has_member js_val "resolveCustomEditor"
    then
      `CustomReadonlyEditorProvider
        ((CustomReadonlyEditorProvider.t_of_js CustomDocument.t_of_js) js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "openCustomDocument"
      && binding_has_member js_val "resolveCustomEditor"
      && binding_has_member js_val "onDidChangeCustomDocument"
      && binding_has_member js_val "saveCustomDocument"
      && binding_has_member js_val "saveCustomDocumentAs"
      && binding_has_member js_val "revertCustomDocument"
      && binding_has_member js_val "backupCustomDocument"
    then
      `CustomEditorProvider ((CustomEditorProvider.t_of_js CustomDocument.t_of_js) js_val)
    else invalid_arg "Window.register_custom_editor_provider: unexpected JavaScript value"
  ;;

  type register_custom_editor_provider_options =
    { webviewOptions : WebviewPanelOptions.t or_undefined
    ; supportsMultipleEditorsPerDocument : bool or_undefined
    }

  let register_custom_editor_provider_options_to_js
        (value : register_custom_editor_provider_options)
    =
    let js_val = Ojs.obj [||] in
    iter_set js_val "webviewOptions" WebviewPanelOptions.t_to_js value.webviewOptions;
    iter_set
      js_val
      "supportsMultipleEditorsPerDocument"
      Ojs.bool_to_js
      value.supportsMultipleEditorsPerDocument;
    js_val
  ;;

  let register_custom_editor_provider_options_of_js js_val
    : register_custom_editor_provider_options
    =
    { webviewOptions =
        (or_undefined_of_js WebviewPanelOptions.t_of_js)
          (Ojs.get_prop_ascii js_val "webviewOptions")
    ; supportsMultipleEditorsPerDocument =
        (or_undefined_of_js Ojs.bool_of_js)
          (Ojs.get_prop_ascii js_val "supportsMultipleEditorsPerDocument")
    }
  ;;

  include
    [%js:
      val activeTextEditor : unit -> TextEditor.t or_undefined
      [@@js.get "@vscode.window.activeTextEditor"]

      val visibleTextEditors : unit -> TextEditor.t list
      [@@js.get "@vscode.window.visibleTextEditors"]

      val onDidChangeActiveTextEditor : unit -> TextEditor.t or_undefined Event.t
      [@@js.get "@vscode.window.onDidChangeActiveTextEditor"]

      val onDidChangeVisibleTextEditors : unit -> TextEditor.t list Event.t
      [@@js.get "@vscode.window.onDidChangeVisibleTextEditors"]

      val onDidChangeTextEditorSelection
        :  unit
        -> TextEditorSelectionChangeEvent.t Event.t
      [@@js.get "@vscode.window.onDidChangeTextEditorSelection"]

      val onDidChangeTerminalState : unit -> Terminal.t Event.t
      [@@js.get "@vscode.window.onDidChangeTerminalState"]

      val onDidChangeTerminalShellIntegration
        :  unit
        -> TerminalShellIntegrationChangeEvent.t Event.t
      [@@js.get "@vscode.window.onDidChangeTerminalShellIntegration"]

      val onDidStartTerminalShellExecution
        :  unit
        -> TerminalShellExecutionStartEvent.t Event.t
      [@@js.get "@vscode.window.onDidStartTerminalShellExecution"]

      val onDidEndTerminalShellExecution
        :  unit
        -> TerminalShellExecutionEndEvent.t Event.t
      [@@js.get "@vscode.window.onDidEndTerminalShellExecution"]

      val terminals : unit -> Terminal.t list [@@js.get "@vscode.window.terminals"]

      val activeTerminal : unit -> Terminal.t or_undefined
      [@@js.get "@vscode.window.activeTerminal"]

      val onDidChangeActiveTerminal : unit -> Terminal.t or_undefined Event.t
      [@@js.get "@vscode.window.onDidChangeActiveTerminal"]

      val onDidOpenTerminal : unit -> Terminal.t Event.t
      [@@js.get "@vscode.window.onDidOpenTerminal"]

      val onDidCloseTerminal : unit -> Terminal.t Event.t
      [@@js.get "@vscode.window.onDidCloseTerminal"]

      val showTextDocument
        :  document:TextDocument.t
        -> ?column:ViewColumn.t
        -> ?preserveFocus:bool
        -> unit
        -> TextEditor.t Promise.t
      [@@js.global "@vscode.window.showTextDocument"]

      val showTextDocument'
        :  document:([ `TextDocument of TextDocument.t | `Uri of Uri.t ][@js.union])
        -> ?options:TextDocumentShowOptions.t
        -> unit
        -> TextEditor.t Promise.t
      [@@js.global "@vscode.window.showTextDocument"]

      val createTextEditorDecorationType
        :  options:DecorationRenderOptions.t
        -> TextEditorDecorationType.t
      [@@js.global "@vscode.window.createTextEditorDecorationType"]

      val informationMessage
        :  message:string
        -> ?options:MessageOptions.t
        -> items:(MessageItem.t list[@js.variadic])
        -> unit
        -> MessageItem.t or_undefined Promise.t
      [@@js.global "@vscode.window.showInformationMessage"]

      val showWarningMessage
        :  message:string
        -> ?options:MessageOptions.t
        -> items:(MessageItem.t list[@js.variadic])
        -> unit
        -> MessageItem.t or_undefined Promise.t
      [@@js.global "@vscode.window.showWarningMessage"]

      val showErrorMessage
        :  message:string
        -> ?options:MessageOptions.t
        -> items:(MessageItem.t list[@js.variadic])
        -> unit
        -> MessageItem.t or_undefined Promise.t
      [@@js.global "@vscode.window.showErrorMessage"]

      val createQuickPick
        :  ((module Ojs.T with type t = 'a)[@js])
        -> unit
        -> 'a QuickPick.t
      [@@js.global "@vscode.window.createQuickPick"]

      val showQuickPickItems
        :  choices:QuickPickItem.t list
        -> ?options:QuickPickOptions.t
        -> ?token:CancellationToken.t
        -> unit
        -> QuickPickItem.t or_undefined Promise.t
      [@@js.global "@vscode.window.showQuickPick"]

      val showQuickPick
        :  items:string list
        -> ?options:QuickPickOptions.t
        -> ?token:CancellationToken.t
        -> unit
        -> string or_undefined Promise.t
      [@@js.global "@vscode.window.showQuickPick"]

      val quickInputButtonBack : QuickInputButton.t
      [@@js.global "@vscode.QuickInputButtons.Back"]

      val showInputBox
        :  ?options:InputBoxOptions.t
        -> ?token:CancellationToken.t
        -> unit
        -> string or_undefined Promise.t
      [@@js.global "@vscode.window.showInputBox"]

      val createOutputChannel
        :  name:string
        -> ?languageId:string
        -> unit
        -> OutputChannel.t
      [@@js.global "@vscode.window.createOutputChannel"]

      val createOutputChannelWithOptions
        :  name:string
        -> options:OutputChannelOptions.t
        -> LogOutputChannel.t
      [@@js.global "@vscode.window.createOutputChannel"]

      val createInputBox : unit -> InputBox.t
      [@@js.global "@vscode.window.createInputBox"]

      val showOpenDialog
        :  ?options:OpenDialogOptions.t
        -> unit
        -> Uri.t list or_undefined Promise.t
      [@@js.global "@vscode.window.showOpenDialog"]

      val setStatusBarMessage
        :  text:string
        -> ?hide:([ `AfterTimeout of int ][@js.union])
        -> unit
        -> Disposable.t
      [@@js.global "@vscode.window.setStatusBarMessage"]

      val withProgress
        :  ((module Ojs.T with type t = 'a)[@js])
        -> options:ProgressOptions.t
        -> task:
             (progress:Progress.value Progress.t
              -> token:CancellationToken.t
              -> 'a Promise.t)
        -> 'a Promise.t
      [@@js.global "@vscode.window.withProgress"]

      val createStatusBarItem
        :  ?alignment:StatusBarAlignment.t
        -> ?priority:float
        -> unit
        -> StatusBarItem.t
      [@@js.global "@vscode.window.createStatusBarItem"]

      val createTerminal
        :  ?name:string
        -> ?shellPath:string
        -> ?shellArgs:([ `String of string | `Strings of string list ][@js.union])
        -> unit
        -> Terminal.t
      [@@js.global "@vscode.window.createTerminal"]

      val createTerminalFromOptions
        :  options:
             ([ `TerminalOptions of TerminalOptions.t
              | `ExtensionTerminalOptions of ExtensionTerminalOptions.t
              ]
             [@js.union])
        -> Terminal.t
      [@@js.global "@vscode.window.createTerminal"]

      val registerTreeDataProvider
        :  ((module Ojs.T with type t = 'a)[@js])
        -> viewId:string
        -> treeDataProvider:'a TreeDataProvider.t
        -> Disposable.t
      [@@js.global "@vscode.window.registerTreeDataProvider"]

      val createTreeView
        :  ((module Ojs.T with type t = 'a)[@js])
        -> viewId:string
        -> options:'a TreeViewOptions.t
        -> 'a TreeView.t
      [@@js.global "@vscode.window.createTreeView"]

      val createWebviewPanel
        :  viewType:string
        -> title:string
        -> showOptions:ViewColumn.t
        -> WebviewPanel.t
      [@@js.global "@vscode.window.createWebviewPanel"]

      val registerCustomTextEditorProvider
        :  viewType:string
        -> provider:CustomTextEditorProvider.t
        -> ?options:RegisterCustomEditorProviderOptions.t
        -> unit
        -> Disposable.t
      [@@js.global "@vscode.window.registerCustomEditorProvider"]

      val registerCustomReadonlyEditorProvider
        :  ((module Ojs.T with type t = 'a)[@js])
        -> viewType:string
        -> provider:'a CustomReadonlyEditorProvider.t
        -> ?options:RegisterCustomEditorProviderOptions.t
        -> unit
        -> Disposable.t
      [@@js.global "@vscode.window.registerCustomEditorProvider"]]

  let getChoices choices =
    choices |> List.map (fun (title, choice) -> MessageItem.create ~title (), choice)
  ;;

  let showInformationMessage ~message ?options ?(choices = []) () =
    let choices = getChoices choices in
    let open Promise.Option.Syntax in
    let+ item = informationMessage ~message ?options ~items:(List.map fst choices) () in
    List.assoc item choices
  ;;

  let showWarningMessage ~message ?options ?(choices = []) () =
    let choices = getChoices choices in
    let open Promise.Option.Syntax in
    let+ item = showWarningMessage ~message ?options ~items:(List.map fst choices) () in
    List.assoc item choices
  ;;

  let showErrorMessage ~message ?options ?(choices = []) () =
    let choices = getChoices choices in
    let open Promise.Option.Syntax in
    let+ item = showErrorMessage ~message ?options ~items:(List.map fst choices) () in
    List.assoc item choices
  ;;

  let showQuickPickItems ~choices ?options ?token () =
    let open Promise.Option.Syntax in
    let+ item = showQuickPickItems ~choices:(List.map fst choices) ?options ?token () in
    List.assoc item choices
  ;;

  let registerCustomReadonlyEditorProvider
        (type a)
        (module T : CustomDocument.T with type t = a)
        ~viewType
        ~(provider : a CustomReadonlyEditorProvider.t)
        ?options
        ()
    =
    registerCustomReadonlyEditorProvider (module T) ~viewType ~provider ?options ()
  ;;

  include
    [%js:
      val tabGroups : unit -> TabGroups.t [@@js.get "@vscode.window.tabGroups"]

      val onDidChangeTextEditorVisibleRanges
        :  unit
        -> TextEditorVisibleRangesChangeEvent.t Event.t
      [@@js.get "@vscode.window.onDidChangeTextEditorVisibleRanges"]

      val onDidChangeTextEditorOptions : unit -> TextEditorOptionsChangeEvent.t Event.t
      [@@js.get "@vscode.window.onDidChangeTextEditorOptions"]

      val onDidChangeTextEditorViewColumn
        :  unit
        -> TextEditorViewColumnChangeEvent.t Event.t
      [@@js.get "@vscode.window.onDidChangeTextEditorViewColumn"]

      val visibleNotebookEditors : unit -> NotebookEditor.t list
      [@@js.get "@vscode.window.visibleNotebookEditors"]

      val onDidChangeVisibleNotebookEditors : unit -> NotebookEditor.t list Event.t
      [@@js.get "@vscode.window.onDidChangeVisibleNotebookEditors"]

      val activeNotebookEditor : unit -> NotebookEditor.t or_undefined
      [@@js.get "@vscode.window.activeNotebookEditor"]

      val onDidChangeActiveNotebookEditor : unit -> NotebookEditor.t or_undefined Event.t
      [@@js.get "@vscode.window.onDidChangeActiveNotebookEditor"]

      val onDidChangeNotebookEditorSelection
        :  unit
        -> NotebookEditorSelectionChangeEvent.t Event.t
      [@@js.get "@vscode.window.onDidChangeNotebookEditorSelection"]

      val onDidChangeNotebookEditorVisibleRanges
        :  unit
        -> NotebookEditorVisibleRangesChangeEvent.t Event.t
      [@@js.get "@vscode.window.onDidChangeNotebookEditorVisibleRanges"]

      val state : unit -> WindowState.t [@@js.get "@vscode.window.state"]

      val onDidChangeWindowState : unit -> WindowState.t Event.t
      [@@js.get "@vscode.window.onDidChangeWindowState"]]

  let showNotebookDocument ~document ?options () =
    (Promise.t_of_js NotebookEditor.t_of_js)
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "window")
         "showNotebookDocument"
         (binding_arguments
            [| NotebookDocument.t_to_js document
             ; (or_undefined_to_js NotebookDocumentShowOptions.t_to_js) options
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val showInformationMessageStrings
        :  message:string
        -> items:(string list[@js.variadic])
        -> string or_undefined Promise.t
      [@@js.global "@vscode.window.showInformationMessage"]

      val showInformationMessageStringsWithOptions
        :  message:string
        -> options:MessageOptions.t
        -> items:(string list[@js.variadic])
        -> string or_undefined Promise.t
      [@@js.global "@vscode.window.showInformationMessage"]

      val showInformationMessageItems
        :  ((module Ojs.T with type t = 'p_t)[@js])
        -> message:string
        -> items:('p_t list[@js.variadic])
        -> 'p_t or_undefined Promise.t
      [@@js.global "@vscode.window.showInformationMessage"]

      val showInformationMessageItemsWithOptions
        :  ((module Ojs.T with type t = 'p_t)[@js])
        -> message:string
        -> options:MessageOptions.t
        -> items:('p_t list[@js.variadic])
        -> 'p_t or_undefined Promise.t
      [@@js.global "@vscode.window.showInformationMessage"]

      val showWarningMessageStrings
        :  message:string
        -> items:(string list[@js.variadic])
        -> string or_undefined Promise.t
      [@@js.global "@vscode.window.showWarningMessage"]

      val showWarningMessageStringsWithOptions
        :  message:string
        -> options:MessageOptions.t
        -> items:(string list[@js.variadic])
        -> string or_undefined Promise.t
      [@@js.global "@vscode.window.showWarningMessage"]

      val showWarningMessageItems
        :  ((module Ojs.T with type t = 'p_t)[@js])
        -> message:string
        -> items:('p_t list[@js.variadic])
        -> 'p_t or_undefined Promise.t
      [@@js.global "@vscode.window.showWarningMessage"]

      val showWarningMessageItemsWithOptions
        :  ((module Ojs.T with type t = 'p_t)[@js])
        -> message:string
        -> options:MessageOptions.t
        -> items:('p_t list[@js.variadic])
        -> 'p_t or_undefined Promise.t
      [@@js.global "@vscode.window.showWarningMessage"]

      val showErrorMessageStrings
        :  message:string
        -> items:(string list[@js.variadic])
        -> string or_undefined Promise.t
      [@@js.global "@vscode.window.showErrorMessage"]

      val showErrorMessageStringsWithOptions
        :  message:string
        -> options:MessageOptions.t
        -> items:(string list[@js.variadic])
        -> string or_undefined Promise.t
      [@@js.global "@vscode.window.showErrorMessage"]

      val showErrorMessageItems
        :  ((module Ojs.T with type t = 'p_t)[@js])
        -> message:string
        -> items:('p_t list[@js.variadic])
        -> 'p_t or_undefined Promise.t
      [@@js.global "@vscode.window.showErrorMessage"]

      val showErrorMessageItemsWithOptions
        :  ((module Ojs.T with type t = 'p_t)[@js])
        -> message:string
        -> options:MessageOptions.t
        -> items:('p_t list[@js.variadic])
        -> 'p_t or_undefined Promise.t
      [@@js.global "@vscode.window.showErrorMessage"]]

  let showQuickPickMany ~items ~options ?token () =
    (Promise.t_of_js (or_undefined_of_js (Ojs.list_of_js Ojs.string_of_js)))
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "window")
         "showQuickPick"
         (binding_arguments
            [| show_quick_pick_many_items_to_js items
             ; show_quick_pick_many_options_to_js options
             ; (or_undefined_to_js CancellationToken.t_to_js) token
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let showQuickPickStrings ~items ?options ?token () =
    (Promise.t_of_js (or_undefined_of_js Ojs.string_of_js))
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "window")
         "showQuickPick"
         (binding_arguments
            [| show_quick_pick_many_items_to_js items
             ; (or_undefined_to_js QuickPickOptions.t_to_js) options
             ; (or_undefined_to_js CancellationToken.t_to_js) token
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let showQuickPickItemsMany
        (type p_t)
        (module P_t : Ojs.T with type t = p_t)
        ~items
        ~options
        ?token
        ()
    =
    (Promise.t_of_js (or_undefined_of_js (Ojs.list_of_js P_t.t_of_js)))
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "window")
         "showQuickPick"
         (binding_arguments
            [| (show_quick_pick_items_many_items_to_js P_t.t_to_js) items
             ; show_quick_pick_items_many_options_to_js options
             ; (or_undefined_to_js CancellationToken.t_to_js) token
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let showQuickPickItemsSingle
        (type p_t)
        (module P_t : Ojs.T with type t = p_t)
        ~items
        ?options
        ?token
        ()
    =
    (Promise.t_of_js (or_undefined_of_js P_t.t_of_js))
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "window")
         "showQuickPick"
         (binding_arguments
            [| (show_quick_pick_items_many_items_to_js P_t.t_to_js) items
             ; (or_undefined_to_js QuickPickOptions.t_to_js) options
             ; (or_undefined_to_js CancellationToken.t_to_js) token
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let showWorkspaceFolderPick ?options () =
    (Promise.t_of_js (or_undefined_of_js WorkspaceFolder.t_of_js))
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "window")
         "showWorkspaceFolderPick"
         (binding_arguments
            [| (or_undefined_to_js WorkspaceFolderPickOptions.t_to_js) options |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let showSaveDialog ?options () =
    (Promise.t_of_js (or_undefined_of_js Uri.t_of_js))
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "window")
         "showSaveDialog"
         (binding_arguments
            [| (or_undefined_to_js SaveDialogOptions.t_to_js) options |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let createWebviewPanelWithOptions ~viewType ~title ~showOptions ?options () =
    WebviewPanel.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "window")
         "createWebviewPanel"
         (binding_arguments
            [| Ojs.string_to_js viewType
             ; Ojs.string_to_js title
             ; create_webview_panel_with_options_show_options_to_js showOptions
             ; (or_undefined_to_js create_webview_panel_with_options_to_js) options
            |]
            3
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val setStatusBarMessageUntil
        :  text:string
        -> hideWhenDone:Ojs.t Promise.t
        -> Disposable.t
      [@@js.global "@vscode.window.setStatusBarMessage"]

      val withScmProgress
        :  ((module Ojs.T with type t = 'p_r)[@js])
        -> task:(progress:int Progress.t -> 'p_r Promise.t)
        -> 'p_r Promise.t
      [@@js.global "@vscode.window.withScmProgress"]]

  let createStatusBarItemWithId ~id ?alignment ?priority () =
    StatusBarItem.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "window")
         "createStatusBarItem"
         (binding_arguments
            [| Ojs.string_to_js id
             ; (or_undefined_to_js StatusBarAlignment.t_to_js) alignment
             ; (or_undefined_to_js Ojs.float_to_js) priority
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val registerUriHandler : handler:UriHandler.t -> Disposable.t
      [@@js.global "@vscode.window.registerUriHandler"]

      val registerWebviewPanelSerializer
        :  viewType:string
        -> serializer:Ojs.t WebviewPanelSerializer.t
        -> Disposable.t
      [@@js.global "@vscode.window.registerWebviewPanelSerializer"]]

  let registerWebviewViewProvider ~viewId ~provider ?options () =
    Disposable.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "window")
         "registerWebviewViewProvider"
         (binding_arguments
            [| Ojs.string_to_js viewId
             ; WebviewViewProvider.t_to_js provider
             ; (or_undefined_to_js register_webview_view_provider_options_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let registerCustomEditorProvider ~viewType ~provider ?options () =
    Disposable.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "window")
         "registerCustomEditorProvider"
         (binding_arguments
            [| Ojs.string_to_js viewType
             ; register_custom_editor_provider_to_js provider
             ; (or_undefined_to_js register_custom_editor_provider_options_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val registerTerminalLinkProvider
        :  provider:TerminalLink.t TerminalLinkProvider.t
        -> Disposable.t
      [@@js.global "@vscode.window.registerTerminalLinkProvider"]

      val registerTerminalProfileProvider
        :  id:string
        -> provider:TerminalProfileProvider.t
        -> Disposable.t
      [@@js.global "@vscode.window.registerTerminalProfileProvider"]

      val registerFileDecorationProvider
        :  provider:FileDecorationProvider.t
        -> Disposable.t
      [@@js.global "@vscode.window.registerFileDecorationProvider"]

      val activeColorTheme : unit -> ColorTheme.t
      [@@js.get "@vscode.window.activeColorTheme"]

      val onDidChangeActiveColorTheme : unit -> ColorTheme.t Event.t
      [@@js.get "@vscode.window.onDidChangeActiveColorTheme"]]
end

module Commands = struct
  include
    [%js:
      val registerCommand
        :  command:string
        -> callback:(args:(Ojs.t list[@js.variadic]) -> Ojs.t)
        -> Disposable.t
      [@@js.global "@vscode.commands.registerCommand"]

      val registerTextEditorCommand
        :  command:string
        -> callback:
             (textEditor:TextEditor.t
              -> edit:TextEditorEdit.t
              -> args:(Ojs.t list[@js.variadic])
              -> unit)
        -> Disposable.t
      [@@js.global "@vscode.commands.registerTextEditorCommand"]

      val executeCommand
        :  command:string
        -> args:(Ojs.t list[@js.variadic])
        -> Ojs.t Promise.t
      [@@js.global "@vscode.commands.executeCommand"]

      val getCommands : ?filterInternal:bool -> unit -> string list Promise.t
      [@@js.global "@vscode.commands.getCommands"]]

  let registerCommandWithThisArgs ~command ~callback ?thisArg () =
    Disposable.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "commands")
         "registerCommand"
         (binding_arguments
            [| Ojs.string_to_js command
             ; [%js.of: args:(Ojs.t list[@js.variadic]) -> Ojs.t] callback
             ; (or_undefined_to_js Ojs.t_to_js) thisArg
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let registerTextEditorCommandWithThisArgs ~command ~callback ?thisArg () =
    Disposable.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "commands")
         "registerTextEditorCommand"
         (binding_arguments
            [| Ojs.string_to_js command
             ; [%js.of:
                 textEditor:TextEditor.t
                 -> edit:TextEditorEdit.t
                 -> args:(Ojs.t list[@js.variadic])
                 -> unit]
                 callback
             ; (or_undefined_to_js Ojs.t_to_js) thisArg
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val executeCommandTyped
        :  ((module Ojs.T with type t = 'p_t)[@js])
        -> command:string
        -> rest:(Ojs.t list[@js.variadic])
        -> 'p_t Promise.t
      [@@js.global "@vscode.commands.executeCommand"]]
end

module DiagnosticChangeEvent = struct
  include Interface.Make ()
  include [%js: val uris : t -> Uri.t list [@@js.get "uris"]]

  let create ~uris () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "uris" ((Ojs.list_to_js Uri.t_to_js) uris);
    t_of_js obj
  ;;
end

module DiagnosticCollection = struct
  include Interface.Make ()

  include
    [%js:
      val name : t -> string [@@js.get "name"]

      val set : t -> uri:Uri.t -> diagnostics:Diagnostic.t list or_undefined -> unit
      [@@js.call "set"]

      val setEntries : t -> entries:(Uri.t * Diagnostic.t list or_undefined) list -> unit
      [@@js.call "set"]

      val delete : t -> uri:Uri.t -> unit [@@js.call "delete"]
      val clear : t -> unit [@@js.call "clear"]]

  let forEach this ~callback ?thisArg () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "forEach"
         (binding_arguments
            [| [%js.of:
                 uri:Uri.t -> diagnostics:Diagnostic.t list -> collection:t -> Ojs.t]
                 callback
             ; (or_undefined_to_js Ojs.t_to_js) thisArg
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val get : t -> uri:Uri.t -> Diagnostic.t list or_undefined [@@js.call "get"]
      val has : t -> uri:Uri.t -> bool [@@js.call "has"]
      val dispose : t -> unit [@@js.call "dispose"]]

  let iterator this =
    let this = t_to_js this in
    let symbol = Ojs.get_prop_ascii (Ojs.get_prop_ascii Ojs.global "Symbol") "iterator" in
    IterableIterator.t_of_js
      (fun js_val ->
         ( Uri.t_of_js (Ojs.array_get js_val 0)
         , (Ojs.list_of_js Diagnostic.t_of_js) (Ojs.array_get js_val 1) ))
      (Ojs.call (Ojs.get_prop this symbol) "call" [| this |])
  ;;
end

module LanguageStatusSeverity = struct
  type t =
    | Information [@js 0]
    | Warning [@js 1]
    | Error [@js 2]
  [@@js.enum] [@@js]
end

module LanguageStatusItem = struct
  include Interface.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val name : t -> string or_undefined [@@js.get "name"]
      val set_name : t -> string or_undefined -> unit [@@js.set "name"]
      val selector : t -> DocumentSelector.t [@@js.get "selector"]
      val set_selector : t -> DocumentSelector.t -> unit [@@js.set "selector"]
      val severity : t -> LanguageStatusSeverity.t [@@js.get "severity"]
      val set_severity : t -> LanguageStatusSeverity.t -> unit [@@js.set "severity"]
      val text : t -> string [@@js.get "text"]
      val set_text : t -> string -> unit [@@js.set "text"]
      val detail : t -> string or_undefined [@@js.get "detail"]
      val set_detail : t -> string or_undefined -> unit [@@js.set "detail"]
      val busy : t -> bool [@@js.get "busy"]
      val set_busy : t -> bool -> unit [@@js.set "busy"]
      val command : t -> Command.t or_undefined [@@js.get "command"]
      val set_command : t -> Command.t or_undefined -> unit [@@js.set "command"]

      val accessibilityInformation : t -> AccessibilityInformation.t or_undefined
      [@@js.get "accessibilityInformation"]

      val set_accessibilityInformation
        :  t
        -> AccessibilityInformation.t or_undefined
        -> unit
      [@@js.set "accessibilityInformation"]

      val dispose : t -> unit [@@js.call "dispose"]]

  let create
        ~id
        ~name
        ~selector
        ~severity
        ~text
        ?detail
        ~busy
        ~command
        ?accessibilityInformation
        ~dispose
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "id" (Ojs.string_to_js id);
    Ojs.set_prop_ascii obj "name" ((or_undefined_to_js Ojs.string_to_js) name);
    Ojs.set_prop_ascii obj "selector" (DocumentSelector.t_to_js selector);
    Ojs.set_prop_ascii obj "severity" (LanguageStatusSeverity.t_to_js severity);
    Ojs.set_prop_ascii obj "text" (Ojs.string_to_js text);
    iter_set obj "detail" Ojs.string_to_js detail;
    Ojs.set_prop_ascii obj "busy" (Ojs.bool_to_js busy);
    Ojs.set_prop_ascii obj "command" ((or_undefined_to_js Command.t_to_js) command);
    iter_set
      obj
      "accessibilityInformation"
      AccessibilityInformation.t_to_js
      accessibilityInformation;
    Ojs.set_prop_ascii obj "dispose" ([%js.of: unit -> unit] dispose);
    t_of_js obj
  ;;
end

module CompletionItemLabel = struct
  include Interface.Make ()

  include
    [%js:
      val label : t -> string [@@js.get "label"]
      val set_label : t -> string -> unit [@@js.set "label"]
      val detail : t -> string or_undefined [@@js.get "detail"]
      val set_detail : t -> string or_undefined -> unit [@@js.set "detail"]
      val description : t -> string or_undefined [@@js.get "description"]
      val set_description : t -> string or_undefined -> unit [@@js.set "description"]]

  let create ~label ?detail ?description () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "label" (Ojs.string_to_js label);
    iter_set obj "detail" Ojs.string_to_js detail;
    iter_set obj "description" Ojs.string_to_js description;
    t_of_js obj
  ;;
end

module CompletionItemKind = struct
  type t =
    | Text [@js 0]
    | Method [@js 1]
    | Function [@js 2]
    | Constructor [@js 3]
    | Field [@js 4]
    | Variable [@js 5]
    | Class [@js 6]
    | Interface [@js 7]
    | Module [@js 8]
    | Property [@js 9]
    | Unit [@js 10]
    | Value [@js 11]
    | Enum [@js 12]
    | Keyword [@js 13]
    | Snippet [@js 14]
    | Color [@js 15]
    | File [@js 16]
    | Reference [@js 17]
    | Folder [@js 18]
    | EnumMember [@js 19]
    | Constant [@js 20]
    | Struct [@js 21]
    | Event [@js 22]
    | Operator [@js 23]
    | TypeParameter [@js 24]
    | User [@js 25]
    | Issue [@js 26]
  [@@js.enum] [@@js]
end

module CompletionItemTag = struct
  type t = Deprecated [@js 1] [@@js.enum] [@@js]
end

module CompletionItem = struct
  include Class.Make ()

  type label =
    [ `String of string
    | `CompletionItemLabel of CompletionItemLabel.t
    ]

  let label_to_js = function
    | `String value -> Ojs.string_to_js value
    | `CompletionItemLabel value -> CompletionItemLabel.t_to_js value
  ;;

  let label_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "label"
    then `CompletionItemLabel (CompletionItemLabel.t_of_js js_val)
    else invalid_arg "CompletionItem.label: unexpected JavaScript value"
  ;;

  type documentation =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let documentation_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let documentation_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else invalid_arg "CompletionItem.documentation: unexpected JavaScript value"
  ;;

  type insert_text =
    [ `String of string
    | `SnippetString of SnippetString.t
    ]

  let insert_text_to_js = function
    | `String value -> Ojs.string_to_js value
    | `SnippetString value -> SnippetString.t_to_js value
  ;;

  let insert_text_of_js js_val =
    match binding_constructor js_val [ "SnippetString" ] with
    | Some "SnippetString" -> `SnippetString (SnippetString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendTabstop"
        && binding_has_member js_val "appendPlaceholder"
        && binding_has_member js_val "appendChoice"
        && binding_has_member js_val "appendVariable"
      then `SnippetString (SnippetString.t_of_js js_val)
      else invalid_arg "CompletionItem.insert_text: unexpected JavaScript value"
  ;;

  type range_item =
    { inserting : Range.t
    ; replacing : Range.t
    }

  let range_item_to_js (value : range_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "inserting" (Range.t_to_js value.inserting);
    Ojs.set_prop_ascii js_val "replacing" (Range.t_to_js value.replacing);
    js_val
  ;;

  let range_item_of_js js_val : range_item =
    { inserting = Range.t_of_js (Ojs.get_prop_ascii js_val "inserting")
    ; replacing = Range.t_of_js (Ojs.get_prop_ascii js_val "replacing")
    }
  ;;

  type range =
    [ `Range of Range.t
    | `Options of range_item
    ]

  let range_to_js = function
    | `Range value -> Range.t_to_js value
    | `Options value -> range_item_to_js value
  ;;

  let range_of_js js_val =
    match binding_constructor js_val [ "Range" ] with
    | Some "Range" -> `Range (Range.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "start"
        && binding_has_member js_val "end"
        && binding_has_member js_val "isEmpty"
        && binding_has_member js_val "isSingleLine"
        && binding_has_member js_val "contains"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "intersection"
        && binding_has_member js_val "union"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
      then `Range (Range.t_of_js js_val)
      else if
        (Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "inserting"
        && binding_has_member js_val "replacing"
      then `Options (range_item_of_js js_val)
      else invalid_arg "CompletionItem.range: unexpected JavaScript value"
  ;;

  include
    [%js:
      val label : t -> label [@@js.get "label"]
      val set_label : t -> label -> unit [@@js.set "label"]
      val kind : t -> CompletionItemKind.t or_undefined [@@js.get "kind"]
      val set_kind : t -> CompletionItemKind.t or_undefined -> unit [@@js.set "kind"]
      val tags : t -> CompletionItemTag.t list or_undefined [@@js.get "tags"]
      val set_tags : t -> CompletionItemTag.t list or_undefined -> unit [@@js.set "tags"]
      val detail : t -> string or_undefined [@@js.get "detail"]
      val set_detail : t -> string or_undefined -> unit [@@js.set "detail"]
      val documentation : t -> documentation or_undefined [@@js.get "documentation"]

      val set_documentation : t -> documentation or_undefined -> unit
      [@@js.set "documentation"]

      val sortText : t -> string or_undefined [@@js.get "sortText"]
      val set_sortText : t -> string or_undefined -> unit [@@js.set "sortText"]
      val filterText : t -> string or_undefined [@@js.get "filterText"]
      val set_filterText : t -> string or_undefined -> unit [@@js.set "filterText"]
      val preselect : t -> bool or_undefined [@@js.get "preselect"]
      val set_preselect : t -> bool or_undefined -> unit [@@js.set "preselect"]
      val insertText : t -> insert_text or_undefined [@@js.get "insertText"]
      val set_insertText : t -> insert_text or_undefined -> unit [@@js.set "insertText"]
      val range : t -> range or_undefined [@@js.get "range"]
      val set_range : t -> range or_undefined -> unit [@@js.set "range"]
      val commitCharacters : t -> string list or_undefined [@@js.get "commitCharacters"]

      val set_commitCharacters : t -> string list or_undefined -> unit
      [@@js.set "commitCharacters"]

      val keepWhitespace : t -> bool or_undefined [@@js.get "keepWhitespace"]
      val set_keepWhitespace : t -> bool or_undefined -> unit [@@js.set "keepWhitespace"]
      val textEdit : t -> TextEdit.t or_undefined [@@js.get "textEdit"]
      val set_textEdit : t -> TextEdit.t or_undefined -> unit [@@js.set "textEdit"]

      val additionalTextEdits : t -> TextEdit.t list or_undefined
      [@@js.get "additionalTextEdits"]

      val set_additionalTextEdits : t -> TextEdit.t list or_undefined -> unit
      [@@js.set "additionalTextEdits"]

      val command : t -> Command.t or_undefined [@@js.get "command"]
      val set_command : t -> Command.t or_undefined -> unit [@@js.set "command"]]

  let make ~label ?kind () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "CompletionItem")
         (binding_arguments
            [| label_to_js label; (or_undefined_to_js CompletionItemKind.t_to_js) kind |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module CompletionList = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val isIncomplete : t -> bool or_undefined [@@js.get "isIncomplete"]
        val set_isIncomplete : t -> bool or_undefined -> unit [@@js.set "isIncomplete"]
        val items : t -> T.t list [@@js.get "items"]
        val set_items : t -> T.t list -> unit [@@js.set "items"]]

    let make ?items ?isIncomplete () =
      t_of_js
        (Ojs.new_obj
           (Ojs.get_prop_ascii vscode_module "CompletionList")
           (binding_arguments
              [| (or_undefined_to_js (Ojs.list_to_js T.t_to_js)) items
               ; (or_undefined_to_js Ojs.bool_to_js) isIncomplete
              |]
              0
              (Ojs.array_to_js Ojs.t_to_js [||])))
    ;;
  end
end

module CompletionTriggerKind = struct
  type t =
    | Invoke [@js 0]
    | TriggerCharacter [@js 1]
    | TriggerForIncompleteCompletions [@js 2]
  [@@js.enum] [@@js]
end

module CompletionContext = struct
  include Interface.Make ()

  include
    [%js:
      val triggerKind : t -> CompletionTriggerKind.t [@@js.get "triggerKind"]
      val triggerCharacter : t -> string or_undefined [@@js.get "triggerCharacter"]]

  let create ~triggerKind ~triggerCharacter () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "triggerKind" (CompletionTriggerKind.t_to_js triggerKind);
    Ojs.set_prop_ascii
      obj
      "triggerCharacter"
      ((or_undefined_to_js Ojs.string_to_js) triggerCharacter);
    t_of_js obj
  ;;
end

module CompletionItemProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    type provide_completion_items_result_t =
      [ `Items of T.t list
      | `CompletionList of T.t CompletionList.t
      ]

    let provide_completion_items_result_t_to_js = function
      | `Items value -> (Ojs.list_to_js T.t_to_js) value
      | `CompletionList value -> (CompletionList.t_to_js T.t_to_js) value
    ;;

    let provide_completion_items_result_t_of_js js_val =
      match binding_constructor js_val [ "CompletionList" ] with
      | Some "CompletionList" ->
        `CompletionList ((CompletionList.t_of_js T.t_of_js) js_val)
      | _ ->
        if binding_is_array js_val
        then `Items ((Ojs.list_of_js T.t_of_js) js_val)
        else if
          Ojs.type_of js_val = "object"
          && (not (Ojs.is_null js_val))
          && binding_has_member js_val "items"
        then `CompletionList ((CompletionList.t_of_js T.t_of_js) js_val)
        else
          invalid_arg
            "CompletionItemProvider.provide_completion_items_result_t: unexpected \
             JavaScript value"
    ;;

    include
      [%js:
        val provideCompletionItems
          :  t
          -> document:TextDocument.t
          -> position:Position.t
          -> token:CancellationToken.t
          -> context:CompletionContext.t
          -> provide_completion_items_result_t ProviderResult.t
        [@@js.call "provideCompletionItems"]]

    let resolveCompletionItem this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "resolveCompletionItem" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to: item:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create ~provideCompletionItems ?resolveCompletionItem () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "provideCompletionItems"
        ([%js.of:
           document:TextDocument.t
           -> position:Position.t
           -> token:CancellationToken.t
           -> context:CompletionContext.t
           -> provide_completion_items_result_t ProviderResult.t]
           provideCompletionItems);
      iter_set
        obj
        "resolveCompletionItem"
        [%js.of: item:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
        resolveCompletionItem;
      t_of_js obj
    ;;
  end
end

module InlineCompletionItem = struct
  include Class.Make ()

  type insert_text =
    [ `String of string
    | `SnippetString of SnippetString.t
    ]

  let insert_text_to_js = function
    | `String value -> Ojs.string_to_js value
    | `SnippetString value -> SnippetString.t_to_js value
  ;;

  let insert_text_of_js js_val =
    match binding_constructor js_val [ "SnippetString" ] with
    | Some "SnippetString" -> `SnippetString (SnippetString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendTabstop"
        && binding_has_member js_val "appendPlaceholder"
        && binding_has_member js_val "appendChoice"
        && binding_has_member js_val "appendVariable"
      then `SnippetString (SnippetString.t_of_js js_val)
      else invalid_arg "InlineCompletionItem.insert_text: unexpected JavaScript value"
  ;;

  include
    [%js:
      val insertText : t -> insert_text [@@js.get "insertText"]
      val set_insertText : t -> insert_text -> unit [@@js.set "insertText"]
      val filterText : t -> string or_undefined [@@js.get "filterText"]
      val set_filterText : t -> string or_undefined -> unit [@@js.set "filterText"]
      val range : t -> Range.t or_undefined [@@js.get "range"]
      val set_range : t -> Range.t or_undefined -> unit [@@js.set "range"]
      val command : t -> Command.t or_undefined [@@js.get "command"]
      val set_command : t -> Command.t or_undefined -> unit [@@js.set "command"]]

  let make ~insertText ?range ?command () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "InlineCompletionItem")
         (binding_arguments
            [| insert_text_to_js insertText
             ; (or_undefined_to_js Range.t_to_js) range
             ; (or_undefined_to_js Command.t_to_js) command
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module InlineCompletionList = struct
  include Class.Make ()

  include
    [%js:
      val items : t -> InlineCompletionItem.t list [@@js.get "items"]
      val set_items : t -> InlineCompletionItem.t list -> unit [@@js.set "items"]

      val make : items:InlineCompletionItem.t list -> t
      [@@js.new "@vscode.InlineCompletionList"]]
end

module InlineCompletionTriggerKind = struct
  type t =
    | Invoke [@js 0]
    | Automatic [@js 1]
  [@@js.enum] [@@js]
end

module SelectedCompletionInfo = struct
  include Interface.Make ()

  include
    [%js:
      val range : t -> Range.t [@@js.get "range"]
      val text : t -> string [@@js.get "text"]]

  let create ~range ~text () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "range" (Range.t_to_js range);
    Ojs.set_prop_ascii obj "text" (Ojs.string_to_js text);
    t_of_js obj
  ;;
end

module InlineCompletionContext = struct
  include Interface.Make ()

  include
    [%js:
      val triggerKind : t -> InlineCompletionTriggerKind.t [@@js.get "triggerKind"]

      val selectedCompletionInfo : t -> SelectedCompletionInfo.t or_undefined
      [@@js.get "selectedCompletionInfo"]]

  let create ~triggerKind ~selectedCompletionInfo () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "triggerKind" (InlineCompletionTriggerKind.t_to_js triggerKind);
    Ojs.set_prop_ascii
      obj
      "selectedCompletionInfo"
      ((or_undefined_to_js SelectedCompletionInfo.t_to_js) selectedCompletionInfo);
    t_of_js obj
  ;;
end

module InlineCompletionItemProvider = struct
  include Interface.Make ()

  type provide_inline_completion_items_result_t =
    [ `Items of InlineCompletionItem.t list
    | `InlineCompletionList of InlineCompletionList.t
    ]

  let provide_inline_completion_items_result_t_to_js = function
    | `Items value -> (Ojs.list_to_js InlineCompletionItem.t_to_js) value
    | `InlineCompletionList value -> InlineCompletionList.t_to_js value
  ;;

  let provide_inline_completion_items_result_t_of_js js_val =
    match binding_constructor js_val [ "InlineCompletionList" ] with
    | Some "InlineCompletionList" ->
      `InlineCompletionList (InlineCompletionList.t_of_js js_val)
    | _ ->
      if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            Ojs.type_of js_val = "object"
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "insertText")
      then `Items ((Ojs.list_of_js InlineCompletionItem.t_of_js) js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "items"
      then `InlineCompletionList (InlineCompletionList.t_of_js js_val)
      else
        invalid_arg
          "InlineCompletionItemProvider.provide_inline_completion_items_result_t: \
           unexpected JavaScript value"
  ;;

  include
    [%js:
      val provideInlineCompletionItems
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> context:InlineCompletionContext.t
        -> token:CancellationToken.t
        -> provide_inline_completion_items_result_t ProviderResult.t
      [@@js.call "provideInlineCompletionItems"]]

  let create ~provideInlineCompletionItems () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideInlineCompletionItems"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> context:InlineCompletionContext.t
         -> token:CancellationToken.t
         -> provide_inline_completion_items_result_t ProviderResult.t]
         provideInlineCompletionItems);
    t_of_js obj
  ;;
end

module CodeActionTriggerKind = struct
  type t =
    | Invoke [@js 1]
    | Automatic [@js 2]
  [@@js.enum] [@@js]
end

module CodeActionKind = struct
  include Class.Make ()

  include
    [%js:
      val empty : unit -> t [@@js.get "@vscode.CodeActionKind.Empty"]
      val quickFix : unit -> t [@@js.get "@vscode.CodeActionKind.QuickFix"]
      val refactor : unit -> t [@@js.get "@vscode.CodeActionKind.Refactor"]
      val refactorExtract : unit -> t [@@js.get "@vscode.CodeActionKind.RefactorExtract"]
      val refactorInline : unit -> t [@@js.get "@vscode.CodeActionKind.RefactorInline"]
      val refactorMove : unit -> t [@@js.get "@vscode.CodeActionKind.RefactorMove"]
      val refactorRewrite : unit -> t [@@js.get "@vscode.CodeActionKind.RefactorRewrite"]
      val source : unit -> t [@@js.get "@vscode.CodeActionKind.Source"]

      val sourceOrganizeImports : unit -> t
      [@@js.get "@vscode.CodeActionKind.SourceOrganizeImports"]

      val sourceFixAll : unit -> t [@@js.get "@vscode.CodeActionKind.SourceFixAll"]
      val notebook : unit -> t [@@js.get "@vscode.CodeActionKind.Notebook"]
      val value : t -> string [@@js.get "value"]
      val append : t -> parts:string -> t [@@js.call "append"]
      val intersects : t -> other:t -> bool [@@js.call "intersects"]
      val contains : t -> other:t -> bool [@@js.call "contains"]]
end

module CodeActionContext = struct
  include Interface.Make ()

  include
    [%js:
      val triggerKind : t -> CodeActionTriggerKind.t [@@js.get "triggerKind"]
      val diagnostics : t -> Diagnostic.t list [@@js.get "diagnostics"]
      val only : t -> CodeActionKind.t or_undefined [@@js.get "only"]]

  let create ~triggerKind ~diagnostics ~only () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "triggerKind" (CodeActionTriggerKind.t_to_js triggerKind);
    Ojs.set_prop_ascii obj "diagnostics" ((Ojs.list_to_js Diagnostic.t_to_js) diagnostics);
    Ojs.set_prop_ascii obj "only" ((or_undefined_to_js CodeActionKind.t_to_js) only);
    t_of_js obj
  ;;
end

module CodeActionProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    type provide_code_actions_range =
      [ `Range of Range.t
      | `Selection of Selection.t
      ]

    let provide_code_actions_range_to_js = function
      | `Range value -> Range.t_to_js value
      | `Selection value -> Selection.t_to_js value
    ;;

    let provide_code_actions_range_of_js js_val =
      match binding_constructor js_val [ "Range"; "Selection" ] with
      | Some "Range" -> `Range (Range.t_of_js js_val)
      | Some "Selection" -> `Selection (Selection.t_of_js js_val)
      | _ ->
        if
          Ojs.type_of js_val = "object"
          && (not (Ojs.is_null js_val))
          && binding_has_member js_val "start"
          && binding_has_member js_val "end"
          && binding_has_member js_val "isEmpty"
          && binding_has_member js_val "isSingleLine"
          && binding_has_member js_val "contains"
          && binding_has_member js_val "isEqual"
          && binding_has_member js_val "intersection"
          && binding_has_member js_val "union"
          && binding_has_member js_val "with"
          && binding_has_member js_val "with"
        then `Range (Range.t_of_js js_val)
        else if
          Ojs.type_of js_val = "object"
          && (not (Ojs.is_null js_val))
          && binding_has_member js_val "start"
          && binding_has_member js_val "end"
          && binding_has_member js_val "isEmpty"
          && binding_has_member js_val "isSingleLine"
          && binding_has_member js_val "contains"
          && binding_has_member js_val "isEqual"
          && binding_has_member js_val "intersection"
          && binding_has_member js_val "union"
          && binding_has_member js_val "with"
          && binding_has_member js_val "with"
          && binding_has_member js_val "anchor"
          && binding_has_member js_val "active"
          && binding_has_member js_val "isReversed"
        then `Selection (Selection.t_of_js js_val)
        else
          invalid_arg
            "CodeActionProvider.provide_code_actions_range: unexpected JavaScript value"
    ;;

    type provide_code_actions_result_t_item =
      [ `Command of Command.t
      | `T of T.t
      ]

    let provide_code_actions_result_t_item_to_js = function
      | `Command value -> Command.t_to_js value
      | `T value -> T.t_to_js value
    ;;

    let provide_code_actions_result_t_item_of_js js_val =
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "title"
        && binding_has_member js_val "command"
      then `Command (Command.t_of_js js_val)
      else if true
      then `T (T.t_of_js js_val)
      else
        invalid_arg
          "CodeActionProvider.provide_code_actions_result_t_item: unexpected JavaScript \
           value"
    ;;

    include
      [%js:
        val provideCodeActions
          :  t
          -> document:TextDocument.t
          -> range:provide_code_actions_range
          -> context:CodeActionContext.t
          -> token:CancellationToken.t
          -> provide_code_actions_result_t_item list ProviderResult.t
        [@@js.call "provideCodeActions"]]

    let resolveCodeAction this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "resolveCodeAction" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to: codeAction:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create ~provideCodeActions ?resolveCodeAction () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "provideCodeActions"
        ([%js.of:
           document:TextDocument.t
           -> range:provide_code_actions_range
           -> context:CodeActionContext.t
           -> token:CancellationToken.t
           -> provide_code_actions_result_t_item list ProviderResult.t]
           provideCodeActions);
      iter_set
        obj
        "resolveCodeAction"
        [%js.of: codeAction:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
        resolveCodeAction;
      t_of_js obj
    ;;
  end
end

module CodeAction = struct
  include Class.Make ()

  type disabled = { reason : string }

  let disabled_to_js (value : disabled) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "reason" (Ojs.string_to_js value.reason);
    js_val
  ;;

  let disabled_of_js js_val : disabled =
    { reason = Ojs.string_of_js (Ojs.get_prop_ascii js_val "reason") }
  ;;

  include
    [%js:
      val title : t -> string [@@js.get "title"]
      val set_title : t -> string -> unit [@@js.set "title"]
      val edit : t -> WorkspaceEdit.t or_undefined [@@js.get "edit"]
      val set_edit : t -> WorkspaceEdit.t or_undefined -> unit [@@js.set "edit"]
      val diagnostics : t -> Diagnostic.t list or_undefined [@@js.get "diagnostics"]

      val set_diagnostics : t -> Diagnostic.t list or_undefined -> unit
      [@@js.set "diagnostics"]

      val command : t -> Command.t or_undefined [@@js.get "command"]
      val set_command : t -> Command.t or_undefined -> unit [@@js.set "command"]
      val kind : t -> CodeActionKind.t or_undefined [@@js.get "kind"]
      val set_kind : t -> CodeActionKind.t or_undefined -> unit [@@js.set "kind"]
      val isPreferred : t -> bool or_undefined [@@js.get "isPreferred"]
      val set_isPreferred : t -> bool or_undefined -> unit [@@js.set "isPreferred"]
      val disabled : t -> disabled or_undefined [@@js.get "disabled"]
      val set_disabled : t -> disabled or_undefined -> unit [@@js.set "disabled"]]

  let make ~title ?kind () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "CodeAction")
         (binding_arguments
            [| Ojs.string_to_js title; (or_undefined_to_js CodeActionKind.t_to_js) kind |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module CodeActionProviderMetadata = struct
  include Interface.Make ()

  type documentation_item =
    { kind : CodeActionKind.t
    ; command : Command.t
    }

  let documentation_item_to_js (value : documentation_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "kind" (CodeActionKind.t_to_js value.kind);
    Ojs.set_prop_ascii js_val "command" (Command.t_to_js value.command);
    js_val
  ;;

  let documentation_item_of_js js_val : documentation_item =
    { kind = CodeActionKind.t_of_js (Ojs.get_prop_ascii js_val "kind")
    ; command = Command.t_of_js (Ojs.get_prop_ascii js_val "command")
    }
  ;;

  include
    [%js:
      val providedCodeActionKinds : t -> CodeActionKind.t list or_undefined
      [@@js.get "providedCodeActionKinds"]

      val documentation : t -> documentation_item list or_undefined
      [@@js.get "documentation"]]

  let create ?providedCodeActionKinds ?documentation () =
    let obj = Ojs.obj [||] in
    iter_set
      obj
      "providedCodeActionKinds"
      (Ojs.list_to_js CodeActionKind.t_to_js)
      providedCodeActionKinds;
    iter_set obj "documentation" (Ojs.list_to_js documentation_item_to_js) documentation;
    t_of_js obj
  ;;
end

module CodeLens = struct
  include Class.Make ()

  include
    [%js:
      val range : t -> Range.t [@@js.get "range"]
      val set_range : t -> Range.t -> unit [@@js.set "range"]
      val command : t -> Command.t or_undefined [@@js.get "command"]
      val set_command : t -> Command.t or_undefined -> unit [@@js.set "command"]
      val isResolved : t -> bool [@@js.get "isResolved"]]

  let make ~range ?command () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "CodeLens")
         (binding_arguments
            [| Range.t_to_js range; (or_undefined_to_js Command.t_to_js) command |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module CodeLensProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val onDidChangeCodeLenses : t -> unit Event.t or_undefined
        [@@js.get "onDidChangeCodeLenses"]

        val set_onDidChangeCodeLenses : t -> unit Event.t or_undefined -> unit
        [@@js.set "onDidChangeCodeLenses"]

        val provideCodeLenses
          :  t
          -> document:TextDocument.t
          -> token:CancellationToken.t
          -> T.t list ProviderResult.t
        [@@js.call "provideCodeLenses"]]

    let resolveCodeLens this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "resolveCodeLens" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to: codeLens:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create ?onDidChangeCodeLenses ~provideCodeLenses ?resolveCodeLens () =
      let obj = Ojs.obj [||] in
      iter_set
        obj
        "onDidChangeCodeLenses"
        (Event.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None))
        onDidChangeCodeLenses;
      Ojs.set_prop_ascii
        obj
        "provideCodeLenses"
        ([%js.of:
           document:TextDocument.t
           -> token:CancellationToken.t
           -> T.t list ProviderResult.t]
           provideCodeLenses);
      iter_set
        obj
        "resolveCodeLens"
        [%js.of: codeLens:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
        resolveCodeLens;
      t_of_js obj
    ;;
  end
end

module Definition = struct
  type value =
    [ `Location of Location.t
    | `Items of Location.t list
    ]

  let value_to_js = function
    | `Location value -> Location.t_to_js value
    | `Items value -> (Ojs.list_to_js Location.t_to_js) value
  ;;

  let value_of_js js_val =
    match binding_constructor js_val [ "Location" ] with
    | Some "Location" -> `Location (Location.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "uri"
        && binding_has_member js_val "range"
      then `Location (Location.t_of_js js_val)
      else if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            Ojs.type_of js_val = "object"
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "uri"
            && binding_has_member js_val "range")
      then `Items ((Ojs.list_of_js Location.t_of_js) js_val)
      else invalid_arg "Definition.value: unexpected JavaScript value"
  ;;

  type t = value

  let t_to_js = value_to_js
  let t_of_js = value_of_js
end

module LocationLink = struct
  include Interface.Make ()

  include
    [%js:
      val originSelectionRange : t -> Range.t or_undefined
      [@@js.get "originSelectionRange"]

      val set_originSelectionRange : t -> Range.t or_undefined -> unit
      [@@js.set "originSelectionRange"]

      val targetUri : t -> Uri.t [@@js.get "targetUri"]
      val set_targetUri : t -> Uri.t -> unit [@@js.set "targetUri"]
      val targetRange : t -> Range.t [@@js.get "targetRange"]
      val set_targetRange : t -> Range.t -> unit [@@js.set "targetRange"]

      val targetSelectionRange : t -> Range.t or_undefined
      [@@js.get "targetSelectionRange"]

      val set_targetSelectionRange : t -> Range.t or_undefined -> unit
      [@@js.set "targetSelectionRange"]]

  let create ?originSelectionRange ~targetUri ~targetRange ?targetSelectionRange () =
    let obj = Ojs.obj [||] in
    iter_set obj "originSelectionRange" Range.t_to_js originSelectionRange;
    Ojs.set_prop_ascii obj "targetUri" (Uri.t_to_js targetUri);
    Ojs.set_prop_ascii obj "targetRange" (Range.t_to_js targetRange);
    iter_set obj "targetSelectionRange" Range.t_to_js targetSelectionRange;
    t_of_js obj
  ;;
end

module DefinitionLink = struct
  type t = LocationLink.t

  let t_to_js = LocationLink.t_to_js
  let t_of_js = LocationLink.t_of_js
end

module DefinitionProvider = struct
  include Interface.Make ()

  type provide_definition_result_t =
    [ `Definition of Definition.t
    | `Items of DefinitionLink.t list
    ]

  let provide_definition_result_t_to_js = function
    | `Definition value -> Definition.t_to_js value
    | `Items value -> (Ojs.list_to_js DefinitionLink.t_to_js) value
  ;;

  let provide_definition_result_t_of_js js_val =
    if
      ((not (Ojs.is_null js_val))
       && binding_has_member js_val "uri"
       && binding_has_member js_val "range")
      || (binding_is_array js_val
          && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
              ||
              let js_val = Ojs.array_get js_val 0 in
              (not (Ojs.is_null js_val))
              && binding_has_member js_val "uri"
              && binding_has_member js_val "range"))
    then `Definition (Definition.t_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          (not (Ojs.is_null js_val))
          && binding_has_member js_val "targetUri"
          && binding_has_member js_val "targetRange")
    then `Items ((Ojs.list_of_js DefinitionLink.t_of_js) js_val)
    else
      invalid_arg
        "DefinitionProvider.provide_definition_result_t: unexpected JavaScript value"
  ;;

  include
    [%js:
      val provideDefinition
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> provide_definition_result_t ProviderResult.t
      [@@js.call "provideDefinition"]]

  let create ~provideDefinition () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideDefinition"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> token:CancellationToken.t
         -> provide_definition_result_t ProviderResult.t]
         provideDefinition);
    t_of_js obj
  ;;
end

module ImplementationProvider = struct
  include Interface.Make ()

  type provide_implementation_result_t =
    [ `Definition of Definition.t
    | `Items of DefinitionLink.t list
    ]

  let provide_implementation_result_t_to_js = function
    | `Definition value -> Definition.t_to_js value
    | `Items value -> (Ojs.list_to_js DefinitionLink.t_to_js) value
  ;;

  let provide_implementation_result_t_of_js js_val =
    if
      ((not (Ojs.is_null js_val))
       && binding_has_member js_val "uri"
       && binding_has_member js_val "range")
      || (binding_is_array js_val
          && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
              ||
              let js_val = Ojs.array_get js_val 0 in
              (not (Ojs.is_null js_val))
              && binding_has_member js_val "uri"
              && binding_has_member js_val "range"))
    then `Definition (Definition.t_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          (not (Ojs.is_null js_val))
          && binding_has_member js_val "targetUri"
          && binding_has_member js_val "targetRange")
    then `Items ((Ojs.list_of_js DefinitionLink.t_of_js) js_val)
    else
      invalid_arg
        "ImplementationProvider.provide_implementation_result_t: unexpected JavaScript \
         value"
  ;;

  include
    [%js:
      val provideImplementation
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> provide_implementation_result_t ProviderResult.t
      [@@js.call "provideImplementation"]]

  let create ~provideImplementation () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideImplementation"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> token:CancellationToken.t
         -> provide_implementation_result_t ProviderResult.t]
         provideImplementation);
    t_of_js obj
  ;;
end

module TypeDefinitionProvider = struct
  include Interface.Make ()

  type provide_type_definition_result_t =
    [ `Definition of Definition.t
    | `Items of DefinitionLink.t list
    ]

  let provide_type_definition_result_t_to_js = function
    | `Definition value -> Definition.t_to_js value
    | `Items value -> (Ojs.list_to_js DefinitionLink.t_to_js) value
  ;;

  let provide_type_definition_result_t_of_js js_val =
    if
      ((not (Ojs.is_null js_val))
       && binding_has_member js_val "uri"
       && binding_has_member js_val "range")
      || (binding_is_array js_val
          && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
              ||
              let js_val = Ojs.array_get js_val 0 in
              (not (Ojs.is_null js_val))
              && binding_has_member js_val "uri"
              && binding_has_member js_val "range"))
    then `Definition (Definition.t_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          (not (Ojs.is_null js_val))
          && binding_has_member js_val "targetUri"
          && binding_has_member js_val "targetRange")
    then `Items ((Ojs.list_of_js DefinitionLink.t_of_js) js_val)
    else
      invalid_arg
        "TypeDefinitionProvider.provide_type_definition_result_t: unexpected JavaScript \
         value"
  ;;

  include
    [%js:
      val provideTypeDefinition
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> provide_type_definition_result_t ProviderResult.t
      [@@js.call "provideTypeDefinition"]]

  let create ~provideTypeDefinition () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideTypeDefinition"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> token:CancellationToken.t
         -> provide_type_definition_result_t ProviderResult.t]
         provideTypeDefinition);
    t_of_js obj
  ;;
end

module Declaration = struct
  type value =
    [ `Location of Location.t
    | `Items of Location.t list
    | `ItemsValue of LocationLink.t list
    ]

  let value_to_js = function
    | `Location value -> Location.t_to_js value
    | `Items value -> (Ojs.list_to_js Location.t_to_js) value
    | `ItemsValue value -> (Ojs.list_to_js LocationLink.t_to_js) value
  ;;

  let value_of_js js_val =
    match binding_constructor js_val [ "Location" ] with
    | Some "Location" -> `Location (Location.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "uri"
        && binding_has_member js_val "range"
      then `Location (Location.t_of_js js_val)
      else if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            Ojs.type_of js_val = "object"
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "uri"
            && binding_has_member js_val "range")
      then `Items ((Ojs.list_of_js Location.t_of_js) js_val)
      else if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            Ojs.type_of js_val = "object"
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "targetUri"
            && binding_has_member js_val "targetRange")
      then `ItemsValue ((Ojs.list_of_js LocationLink.t_of_js) js_val)
      else invalid_arg "Declaration.value: unexpected JavaScript value"
  ;;

  type t = value

  let t_to_js = value_to_js
  let t_of_js = value_of_js
end

module DeclarationProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideDeclaration
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> Declaration.t ProviderResult.t
      [@@js.call "provideDeclaration"]]

  let create ~provideDeclaration () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideDeclaration"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> token:CancellationToken.t
         -> Declaration.t ProviderResult.t]
         provideDeclaration);
    t_of_js obj
  ;;
end

module EvaluatableExpression = struct
  include Class.Make ()

  include
    [%js:
      val range : t -> Range.t [@@js.get "range"]
      val expression : t -> string or_undefined [@@js.get "expression"]]

  let make ~range ?expression () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "EvaluatableExpression")
         (binding_arguments
            [| Range.t_to_js range; (or_undefined_to_js Ojs.string_to_js) expression |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module EvaluatableExpressionProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideEvaluatableExpression
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> EvaluatableExpression.t ProviderResult.t
      [@@js.call "provideEvaluatableExpression"]]

  let create ~provideEvaluatableExpression () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideEvaluatableExpression"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> token:CancellationToken.t
         -> EvaluatableExpression.t ProviderResult.t]
         provideEvaluatableExpression);
    t_of_js obj
  ;;
end

module InlineValueContext = struct
  include Interface.Make ()

  include
    [%js:
      val frameId : t -> int [@@js.get "frameId"]
      val stoppedLocation : t -> Range.t [@@js.get "stoppedLocation"]]

  let create ~frameId ~stoppedLocation () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "frameId" (Ojs.int_to_js frameId);
    Ojs.set_prop_ascii obj "stoppedLocation" (Range.t_to_js stoppedLocation);
    t_of_js obj
  ;;
end

module InlineValueText = struct
  include Class.Make ()

  include
    [%js:
      val range : t -> Range.t [@@js.get "range"]
      val text : t -> string [@@js.get "text"]
      val make : range:Range.t -> text:string -> t [@@js.new "@vscode.InlineValueText"]]
end

module InlineValueVariableLookup = struct
  include Class.Make ()

  include
    [%js:
      val range : t -> Range.t [@@js.get "range"]
      val variableName : t -> string or_undefined [@@js.get "variableName"]
      val caseSensitiveLookup : t -> bool [@@js.get "caseSensitiveLookup"]]

  let make ~range ?variableName ?caseSensitiveLookup () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "InlineValueVariableLookup")
         (binding_arguments
            [| Range.t_to_js range
             ; (or_undefined_to_js Ojs.string_to_js) variableName
             ; (or_undefined_to_js Ojs.bool_to_js) caseSensitiveLookup
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module InlineValueEvaluatableExpression = struct
  include Class.Make ()

  include
    [%js:
      val range : t -> Range.t [@@js.get "range"]
      val expression : t -> string or_undefined [@@js.get "expression"]]

  let make ~range ?expression () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "InlineValueEvaluatableExpression")
         (binding_arguments
            [| Range.t_to_js range; (or_undefined_to_js Ojs.string_to_js) expression |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module InlineValue = struct
  type value =
    [ `InlineValueText of InlineValueText.t
    | `InlineValueVariableLookup of InlineValueVariableLookup.t
    | `InlineValueEvaluatableExpression of InlineValueEvaluatableExpression.t
    ]

  let value_to_js = function
    | `InlineValueText value -> InlineValueText.t_to_js value
    | `InlineValueVariableLookup value -> InlineValueVariableLookup.t_to_js value
    | `InlineValueEvaluatableExpression value ->
      InlineValueEvaluatableExpression.t_to_js value
  ;;

  let value_of_js js_val =
    match
      binding_constructor
        js_val
        [ "InlineValueText"
        ; "InlineValueVariableLookup"
        ; "InlineValueEvaluatableExpression"
        ]
    with
    | Some "InlineValueText" -> `InlineValueText (InlineValueText.t_of_js js_val)
    | Some "InlineValueVariableLookup" ->
      `InlineValueVariableLookup (InlineValueVariableLookup.t_of_js js_val)
    | Some "InlineValueEvaluatableExpression" ->
      `InlineValueEvaluatableExpression (InlineValueEvaluatableExpression.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "range"
        && binding_has_member js_val "text"
      then `InlineValueText (InlineValueText.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "range"
        && binding_has_member js_val "caseSensitiveLookup"
      then `InlineValueVariableLookup (InlineValueVariableLookup.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "range"
      then
        `InlineValueEvaluatableExpression
          (InlineValueEvaluatableExpression.t_of_js js_val)
      else invalid_arg "InlineValue.value: unexpected JavaScript value"
  ;;

  type t = value

  let t_to_js = value_to_js
  let t_of_js = value_of_js
end

module InlineValuesProvider = struct
  include Interface.Make ()

  include
    [%js:
      val onDidChangeInlineValues : t -> unit Event.t or_undefined
      [@@js.get "onDidChangeInlineValues"]

      val set_onDidChangeInlineValues : t -> unit Event.t or_undefined -> unit
      [@@js.set "onDidChangeInlineValues"]

      val provideInlineValues
        :  t
        -> document:TextDocument.t
        -> viewPort:Range.t
        -> context:InlineValueContext.t
        -> token:CancellationToken.t
        -> InlineValue.t list ProviderResult.t
      [@@js.call "provideInlineValues"]]

  let create ?onDidChangeInlineValues ~provideInlineValues () =
    let obj = Ojs.obj [||] in
    iter_set
      obj
      "onDidChangeInlineValues"
      (Event.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None))
      onDidChangeInlineValues;
    Ojs.set_prop_ascii
      obj
      "provideInlineValues"
      ([%js.of:
         document:TextDocument.t
         -> viewPort:Range.t
         -> context:InlineValueContext.t
         -> token:CancellationToken.t
         -> InlineValue.t list ProviderResult.t]
         provideInlineValues);
    t_of_js obj
  ;;
end

module DocumentHighlightKind = struct
  type t =
    | Text [@js 0]
    | Read [@js 1]
    | Write [@js 2]
  [@@js.enum] [@@js]
end

module DocumentHighlight = struct
  include Class.Make ()

  include
    [%js:
      val range : t -> Range.t [@@js.get "range"]
      val set_range : t -> Range.t -> unit [@@js.set "range"]
      val kind : t -> DocumentHighlightKind.t or_undefined [@@js.get "kind"]
      val set_kind : t -> DocumentHighlightKind.t or_undefined -> unit [@@js.set "kind"]]

  let make ~range ?kind () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "DocumentHighlight")
         (binding_arguments
            [| Range.t_to_js range
             ; (or_undefined_to_js DocumentHighlightKind.t_to_js) kind
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module DocumentHighlightProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideDocumentHighlights
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> DocumentHighlight.t list ProviderResult.t
      [@@js.call "provideDocumentHighlights"]]

  let create ~provideDocumentHighlights () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideDocumentHighlights"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> token:CancellationToken.t
         -> DocumentHighlight.t list ProviderResult.t]
         provideDocumentHighlights);
    t_of_js obj
  ;;
end

module SymbolKind = struct
  type t =
    | File [@js 0]
    | Module [@js 1]
    | Namespace [@js 2]
    | Package [@js 3]
    | Class [@js 4]
    | Method [@js 5]
    | Property [@js 6]
    | Field [@js 7]
    | Constructor [@js 8]
    | Enum [@js 9]
    | Interface [@js 10]
    | Function [@js 11]
    | Variable [@js 12]
    | Constant [@js 13]
    | String [@js 14]
    | Number [@js 15]
    | Boolean [@js 16]
    | Array [@js 17]
    | Object [@js 18]
    | Key [@js 19]
    | Null [@js 20]
    | EnumMember [@js 21]
    | Struct [@js 22]
    | Event [@js 23]
    | Operator [@js 24]
    | TypeParameter [@js 25]
  [@@js.enum] [@@js]
end

module SymbolTag = struct
  type t = Deprecated [@js 1] [@@js.enum] [@@js]
end

module SymbolInformation = struct
  include Class.Make ()

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val containerName : t -> string [@@js.get "containerName"]
      val set_containerName : t -> string -> unit [@@js.set "containerName"]
      val kind : t -> SymbolKind.t [@@js.get "kind"]
      val set_kind : t -> SymbolKind.t -> unit [@@js.set "kind"]
      val tags : t -> SymbolTag.t list or_undefined [@@js.get "tags"]
      val set_tags : t -> SymbolTag.t list or_undefined -> unit [@@js.set "tags"]
      val location : t -> Location.t [@@js.get "location"]
      val set_location : t -> Location.t -> unit [@@js.set "location"]

      val make
        :  name:string
        -> kind:SymbolKind.t
        -> containerName:string
        -> location:Location.t
        -> t
      [@@js.new "@vscode.SymbolInformation"]]

  let makeRange ~name ~kind ~range ?uri ?containerName () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "SymbolInformation")
         (binding_arguments
            [| Ojs.string_to_js name
             ; SymbolKind.t_to_js kind
             ; Range.t_to_js range
             ; (or_undefined_to_js Uri.t_to_js) uri
             ; (or_undefined_to_js Ojs.string_to_js) containerName
            |]
            3
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module DocumentSymbol = struct
  include Class.Make ()

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val detail : t -> string [@@js.get "detail"]
      val set_detail : t -> string -> unit [@@js.set "detail"]
      val kind : t -> SymbolKind.t [@@js.get "kind"]
      val set_kind : t -> SymbolKind.t -> unit [@@js.set "kind"]
      val tags : t -> SymbolTag.t list or_undefined [@@js.get "tags"]
      val set_tags : t -> SymbolTag.t list or_undefined -> unit [@@js.set "tags"]
      val range : t -> Range.t [@@js.get "range"]
      val set_range : t -> Range.t -> unit [@@js.set "range"]
      val selectionRange : t -> Range.t [@@js.get "selectionRange"]
      val set_selectionRange : t -> Range.t -> unit [@@js.set "selectionRange"]
      val children : t -> t list [@@js.get "children"]
      val set_children : t -> t list -> unit [@@js.set "children"]

      val make
        :  name:string
        -> detail:string
        -> kind:SymbolKind.t
        -> range:Range.t
        -> selectionRange:Range.t
        -> t
      [@@js.new "@vscode.DocumentSymbol"]]
end

module DocumentSymbolProvider = struct
  include Interface.Make ()

  type provide_document_symbols_result_t =
    [ `Items of SymbolInformation.t list
    | `ItemsValue of DocumentSymbol.t list
    ]

  let provide_document_symbols_result_t_to_js = function
    | `Items value -> (Ojs.list_to_js SymbolInformation.t_to_js) value
    | `ItemsValue value -> (Ojs.list_to_js DocumentSymbol.t_to_js) value
  ;;

  let provide_document_symbols_result_t_of_js js_val =
    if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "object"
          && (not (Ojs.is_null js_val))
          && binding_has_member js_val "name"
          && binding_has_member js_val "containerName"
          && binding_has_member js_val "kind"
          && binding_has_member js_val "location")
    then `Items ((Ojs.list_of_js SymbolInformation.t_of_js) js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "object"
          && (not (Ojs.is_null js_val))
          && binding_has_member js_val "name"
          && binding_has_member js_val "detail"
          && binding_has_member js_val "kind"
          && binding_has_member js_val "range"
          && binding_has_member js_val "selectionRange"
          && binding_has_member js_val "children")
    then `ItemsValue ((Ojs.list_of_js DocumentSymbol.t_of_js) js_val)
    else
      invalid_arg
        "DocumentSymbolProvider.provide_document_symbols_result_t: unexpected JavaScript \
         value"
  ;;

  include
    [%js:
      val provideDocumentSymbols
        :  t
        -> document:TextDocument.t
        -> token:CancellationToken.t
        -> provide_document_symbols_result_t ProviderResult.t
      [@@js.call "provideDocumentSymbols"]]

  let create ~provideDocumentSymbols () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideDocumentSymbols"
      ([%js.of:
         document:TextDocument.t
         -> token:CancellationToken.t
         -> provide_document_symbols_result_t ProviderResult.t]
         provideDocumentSymbols);
    t_of_js obj
  ;;
end

module DocumentSymbolProviderMetadata = struct
  include Interface.Make ()

  include
    [%js:
      val label : t -> string or_undefined [@@js.get "label"]
      val set_label : t -> string or_undefined -> unit [@@js.set "label"]]

  let create ?label () =
    let obj = Ojs.obj [||] in
    iter_set obj "label" Ojs.string_to_js label;
    t_of_js obj
  ;;
end

module WorkspaceSymbolProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val provideWorkspaceSymbols
          :  t
          -> query:string
          -> token:CancellationToken.t
          -> T.t list ProviderResult.t
        [@@js.call "provideWorkspaceSymbols"]]

    let resolveWorkspaceSymbol this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "resolveWorkspaceSymbol" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to: symbol:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create ~provideWorkspaceSymbols ?resolveWorkspaceSymbol () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "provideWorkspaceSymbols"
        ([%js.of: query:string -> token:CancellationToken.t -> T.t list ProviderResult.t]
           provideWorkspaceSymbols);
      iter_set
        obj
        "resolveWorkspaceSymbol"
        [%js.of: symbol:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
        resolveWorkspaceSymbol;
      t_of_js obj
    ;;
  end
end

module ReferenceContext = struct
  include Interface.Make ()
  include [%js: val includeDeclaration : t -> bool [@@js.get "includeDeclaration"]]

  let create ~includeDeclaration () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "includeDeclaration" (Ojs.bool_to_js includeDeclaration);
    t_of_js obj
  ;;
end

module ReferenceProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideReferences
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> context:ReferenceContext.t
        -> token:CancellationToken.t
        -> Location.t list ProviderResult.t
      [@@js.call "provideReferences"]]

  let create ~provideReferences () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideReferences"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> context:ReferenceContext.t
         -> token:CancellationToken.t
         -> Location.t list ProviderResult.t]
         provideReferences);
    t_of_js obj
  ;;
end

module RenameProvider = struct
  include Interface.Make ()

  type prepare_rename_result_t_item =
    { range : Range.t
    ; placeholder : string
    }

  let prepare_rename_result_t_item_to_js (value : prepare_rename_result_t_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "range" (Range.t_to_js value.range);
    Ojs.set_prop_ascii js_val "placeholder" (Ojs.string_to_js value.placeholder);
    js_val
  ;;

  let prepare_rename_result_t_item_of_js js_val : prepare_rename_result_t_item =
    { range = Range.t_of_js (Ojs.get_prop_ascii js_val "range")
    ; placeholder = Ojs.string_of_js (Ojs.get_prop_ascii js_val "placeholder")
    }
  ;;

  type prepare_rename_result_t =
    [ `Range of Range.t
    | `Options of prepare_rename_result_t_item
    ]

  let prepare_rename_result_t_to_js = function
    | `Range value -> Range.t_to_js value
    | `Options value -> prepare_rename_result_t_item_to_js value
  ;;

  let prepare_rename_result_t_of_js js_val =
    match binding_constructor js_val [ "Range" ] with
    | Some "Range" -> `Range (Range.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "start"
        && binding_has_member js_val "end"
        && binding_has_member js_val "isEmpty"
        && binding_has_member js_val "isSingleLine"
        && binding_has_member js_val "contains"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "intersection"
        && binding_has_member js_val "union"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
      then `Range (Range.t_of_js js_val)
      else if
        (Ojs.type_of js_val = "object" || Ojs.type_of js_val = "function")
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "range"
        && binding_has_member js_val "placeholder"
      then `Options (prepare_rename_result_t_item_of_js js_val)
      else
        invalid_arg "RenameProvider.prepare_rename_result_t: unexpected JavaScript value"
  ;;

  include
    [%js:
      val provideRenameEdits
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> newName:string
        -> token:CancellationToken.t
        -> WorkspaceEdit.t ProviderResult.t
      [@@js.call "provideRenameEdits"]]

  let prepareRename this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "prepareRename" in
    if Ojs.is_null callback
    then None
    else
      Some
        ([%js.to:
           document:TextDocument.t
           -> position:Position.t
           -> token:CancellationToken.t
           -> prepare_rename_result_t ProviderResult.t]
           (Ojs.call callback "bind" [| this |]))
  ;;

  let create ~provideRenameEdits ?prepareRename () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideRenameEdits"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> newName:string
         -> token:CancellationToken.t
         -> WorkspaceEdit.t ProviderResult.t]
         provideRenameEdits);
    iter_set
      obj
      "prepareRename"
      [%js.of:
        document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> prepare_rename_result_t ProviderResult.t]
      prepareRename;
    t_of_js obj
  ;;
end

module Uint32Array = struct
  include Class.Make ()

  include
    [%js:
      val of_array : int array -> t [@@js.new "Uint32Array"]
      val to_array : t -> int array [@@js.global "Array.from"]]
end

module SemanticTokens = struct
  include Class.Make ()

  include
    [%js:
      val resultId : t -> string or_undefined [@@js.get "resultId"]
      val data : t -> Uint32Array.t [@@js.get "data"]]

  let make ~data ?resultId () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "SemanticTokens")
         (binding_arguments
            [| Uint32Array.t_to_js data; (or_undefined_to_js Ojs.string_to_js) resultId |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module SemanticTokensEdit = struct
  include Class.Make ()

  include
    [%js:
      val start : t -> int [@@js.get "start"]
      val deleteCount : t -> int [@@js.get "deleteCount"]
      val data : t -> Uint32Array.t or_undefined [@@js.get "data"]]

  let make ~start ~deleteCount ?data () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "SemanticTokensEdit")
         (binding_arguments
            [| Ojs.int_to_js start
             ; Ojs.int_to_js deleteCount
             ; (or_undefined_to_js Uint32Array.t_to_js) data
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module SemanticTokensEdits = struct
  include Class.Make ()

  include
    [%js:
      val resultId : t -> string or_undefined [@@js.get "resultId"]
      val edits : t -> SemanticTokensEdit.t list [@@js.get "edits"]]

  let make ~edits ?resultId () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "SemanticTokensEdits")
         (binding_arguments
            [| (Ojs.list_to_js SemanticTokensEdit.t_to_js) edits
             ; (or_undefined_to_js Ojs.string_to_js) resultId
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module DocumentSemanticTokensProvider = struct
  include Interface.Make ()

  type provide_document_semantic_tokens_edits_result_t =
    [ `SemanticTokens of SemanticTokens.t
    | `SemanticTokensEdits of SemanticTokensEdits.t
    ]

  let provide_document_semantic_tokens_edits_result_t_to_js = function
    | `SemanticTokens value -> SemanticTokens.t_to_js value
    | `SemanticTokensEdits value -> SemanticTokensEdits.t_to_js value
  ;;

  let provide_document_semantic_tokens_edits_result_t_of_js js_val =
    match binding_constructor js_val [ "SemanticTokens"; "SemanticTokensEdits" ] with
    | Some "SemanticTokens" -> `SemanticTokens (SemanticTokens.t_of_js js_val)
    | Some "SemanticTokensEdits" ->
      `SemanticTokensEdits (SemanticTokensEdits.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "resultId"
        && binding_has_member js_val "data"
      then `SemanticTokens (SemanticTokens.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "resultId"
        && binding_has_member js_val "edits"
      then `SemanticTokensEdits (SemanticTokensEdits.t_of_js js_val)
      else
        invalid_arg
          "DocumentSemanticTokensProvider.provide_document_semantic_tokens_edits_result_t: \
           unexpected JavaScript value"
  ;;

  include
    [%js:
      val onDidChangeSemanticTokens : t -> unit Event.t or_undefined
      [@@js.get "onDidChangeSemanticTokens"]

      val set_onDidChangeSemanticTokens : t -> unit Event.t or_undefined -> unit
      [@@js.set "onDidChangeSemanticTokens"]

      val provideDocumentSemanticTokens
        :  t
        -> document:TextDocument.t
        -> token:CancellationToken.t
        -> SemanticTokens.t ProviderResult.t
      [@@js.call "provideDocumentSemanticTokens"]]

  let provideDocumentSemanticTokensEdits this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "provideDocumentSemanticTokensEdits" in
    if Ojs.is_null callback
    then None
    else
      Some
        ([%js.to:
           document:TextDocument.t
           -> previousResultId:string
           -> token:CancellationToken.t
           -> provide_document_semantic_tokens_edits_result_t ProviderResult.t]
           (Ojs.call callback "bind" [| this |]))
  ;;

  let create
        ?onDidChangeSemanticTokens
        ~provideDocumentSemanticTokens
        ?provideDocumentSemanticTokensEdits
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set
      obj
      "onDidChangeSemanticTokens"
      (Event.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None))
      onDidChangeSemanticTokens;
    Ojs.set_prop_ascii
      obj
      "provideDocumentSemanticTokens"
      ([%js.of:
         document:TextDocument.t
         -> token:CancellationToken.t
         -> SemanticTokens.t ProviderResult.t]
         provideDocumentSemanticTokens);
    iter_set
      obj
      "provideDocumentSemanticTokensEdits"
      [%js.of:
        document:TextDocument.t
        -> previousResultId:string
        -> token:CancellationToken.t
        -> provide_document_semantic_tokens_edits_result_t ProviderResult.t]
      provideDocumentSemanticTokensEdits;
    t_of_js obj
  ;;
end

module SemanticTokensLegend = struct
  include Class.Make ()

  include
    [%js:
      val tokenTypes : t -> string list [@@js.get "tokenTypes"]
      val tokenModifiers : t -> string list [@@js.get "tokenModifiers"]]

  let make ~tokenTypes ?tokenModifiers () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "SemanticTokensLegend")
         (binding_arguments
            [| (Ojs.list_to_js Ojs.string_to_js) tokenTypes
             ; (or_undefined_to_js (Ojs.list_to_js Ojs.string_to_js)) tokenModifiers
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module DocumentRangeSemanticTokensProvider = struct
  include Interface.Make ()

  include
    [%js:
      val onDidChangeSemanticTokens : t -> unit Event.t or_undefined
      [@@js.get "onDidChangeSemanticTokens"]

      val set_onDidChangeSemanticTokens : t -> unit Event.t or_undefined -> unit
      [@@js.set "onDidChangeSemanticTokens"]

      val provideDocumentRangeSemanticTokens
        :  t
        -> document:TextDocument.t
        -> range:Range.t
        -> token:CancellationToken.t
        -> SemanticTokens.t ProviderResult.t
      [@@js.call "provideDocumentRangeSemanticTokens"]]

  let create ?onDidChangeSemanticTokens ~provideDocumentRangeSemanticTokens () =
    let obj = Ojs.obj [||] in
    iter_set
      obj
      "onDidChangeSemanticTokens"
      (Event.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None))
      onDidChangeSemanticTokens;
    Ojs.set_prop_ascii
      obj
      "provideDocumentRangeSemanticTokens"
      ([%js.of:
         document:TextDocument.t
         -> range:Range.t
         -> token:CancellationToken.t
         -> SemanticTokens.t ProviderResult.t]
         provideDocumentRangeSemanticTokens);
    t_of_js obj
  ;;
end

module DocumentRangeFormattingEditProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideDocumentRangeFormattingEdits
        :  t
        -> document:TextDocument.t
        -> range:Range.t
        -> options:FormattingOptions.t
        -> token:CancellationToken.t
        -> TextEdit.t list ProviderResult.t
      [@@js.call "provideDocumentRangeFormattingEdits"]]

  let provideDocumentRangesFormattingEdits this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "provideDocumentRangesFormattingEdits" in
    if Ojs.is_null callback
    then None
    else
      Some
        ([%js.to:
           document:TextDocument.t
           -> ranges:Range.t list
           -> options:FormattingOptions.t
           -> token:CancellationToken.t
           -> TextEdit.t list ProviderResult.t]
           (Ojs.call callback "bind" [| this |]))
  ;;

  let create ~provideDocumentRangeFormattingEdits ?provideDocumentRangesFormattingEdits ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideDocumentRangeFormattingEdits"
      ([%js.of:
         document:TextDocument.t
         -> range:Range.t
         -> options:FormattingOptions.t
         -> token:CancellationToken.t
         -> TextEdit.t list ProviderResult.t]
         provideDocumentRangeFormattingEdits);
    iter_set
      obj
      "provideDocumentRangesFormattingEdits"
      [%js.of:
        document:TextDocument.t
        -> ranges:Range.t list
        -> options:FormattingOptions.t
        -> token:CancellationToken.t
        -> TextEdit.t list ProviderResult.t]
      provideDocumentRangesFormattingEdits;
    t_of_js obj
  ;;
end

module OnTypeFormattingEditProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideOnTypeFormattingEdits
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> ch:string
        -> options:FormattingOptions.t
        -> token:CancellationToken.t
        -> TextEdit.t list ProviderResult.t
      [@@js.call "provideOnTypeFormattingEdits"]]

  let create ~provideOnTypeFormattingEdits () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideOnTypeFormattingEdits"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> ch:string
         -> options:FormattingOptions.t
         -> token:CancellationToken.t
         -> TextEdit.t list ProviderResult.t]
         provideOnTypeFormattingEdits);
    t_of_js obj
  ;;
end

module SignatureHelpTriggerKind = struct
  type t =
    | Invoke [@js 1]
    | TriggerCharacter [@js 2]
    | ContentChange [@js 3]
  [@@js.enum] [@@js]
end

module ParameterInformation = struct
  include Class.Make ()

  type label =
    [ `String of string
    | `Options of int * int
    ]

  let label_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Options value ->
      (fun (v0, v1) ->
         Ojs.array_to_js Ojs.t_to_js [| Ojs.int_to_js v0; Ojs.int_to_js v1 |])
        value
  ;;

  let label_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if binding_is_array js_val
    then
      `Options
        ((fun js_val ->
            Ojs.int_of_js (Ojs.array_get js_val 0), Ojs.int_of_js (Ojs.array_get js_val 1))
           js_val)
    else invalid_arg "ParameterInformation.label: unexpected JavaScript value"
  ;;

  type documentation =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let documentation_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let documentation_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else invalid_arg "ParameterInformation.documentation: unexpected JavaScript value"
  ;;

  include
    [%js:
      val label : t -> label [@@js.get "label"]
      val set_label : t -> label -> unit [@@js.set "label"]
      val documentation : t -> documentation or_undefined [@@js.get "documentation"]

      val set_documentation : t -> documentation or_undefined -> unit
      [@@js.set "documentation"]]

  let make ~label ?documentation () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "ParameterInformation")
         (binding_arguments
            [| label_to_js label
             ; (or_undefined_to_js documentation_to_js) documentation
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module SignatureInformation = struct
  include Class.Make ()

  type documentation =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let documentation_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let documentation_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else invalid_arg "SignatureInformation.documentation: unexpected JavaScript value"
  ;;

  include
    [%js:
      val label : t -> string [@@js.get "label"]
      val set_label : t -> string -> unit [@@js.set "label"]
      val documentation : t -> documentation or_undefined [@@js.get "documentation"]

      val set_documentation : t -> documentation or_undefined -> unit
      [@@js.set "documentation"]

      val parameters : t -> ParameterInformation.t list [@@js.get "parameters"]

      val set_parameters : t -> ParameterInformation.t list -> unit
      [@@js.set "parameters"]

      val activeParameter : t -> int or_undefined [@@js.get "activeParameter"]
      val set_activeParameter : t -> int or_undefined -> unit [@@js.set "activeParameter"]]

  let make ~label ?documentation () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "SignatureInformation")
         (binding_arguments
            [| Ojs.string_to_js label
             ; (or_undefined_to_js documentation_to_js) documentation
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module SignatureHelp = struct
  include Class.Make ()

  include
    [%js:
      val signatures : t -> SignatureInformation.t list [@@js.get "signatures"]

      val set_signatures : t -> SignatureInformation.t list -> unit
      [@@js.set "signatures"]

      val activeSignature : t -> int [@@js.get "activeSignature"]
      val set_activeSignature : t -> int -> unit [@@js.set "activeSignature"]
      val activeParameter : t -> int [@@js.get "activeParameter"]
      val set_activeParameter : t -> int -> unit [@@js.set "activeParameter"]
      val make : unit -> t [@@js.new "@vscode.SignatureHelp"]]
end

module SignatureHelpContext = struct
  include Interface.Make ()

  include
    [%js:
      val triggerKind : t -> SignatureHelpTriggerKind.t [@@js.get "triggerKind"]
      val triggerCharacter : t -> string or_undefined [@@js.get "triggerCharacter"]
      val isRetrigger : t -> bool [@@js.get "isRetrigger"]

      val activeSignatureHelp : t -> SignatureHelp.t or_undefined
      [@@js.get "activeSignatureHelp"]]

  let create ~triggerKind ~triggerCharacter ~isRetrigger ~activeSignatureHelp () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "triggerKind" (SignatureHelpTriggerKind.t_to_js triggerKind);
    Ojs.set_prop_ascii
      obj
      "triggerCharacter"
      ((or_undefined_to_js Ojs.string_to_js) triggerCharacter);
    Ojs.set_prop_ascii obj "isRetrigger" (Ojs.bool_to_js isRetrigger);
    Ojs.set_prop_ascii
      obj
      "activeSignatureHelp"
      ((or_undefined_to_js SignatureHelp.t_to_js) activeSignatureHelp);
    t_of_js obj
  ;;
end

module SignatureHelpProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideSignatureHelp
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> context:SignatureHelpContext.t
        -> SignatureHelp.t ProviderResult.t
      [@@js.call "provideSignatureHelp"]]

  let create ~provideSignatureHelp () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideSignatureHelp"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> token:CancellationToken.t
         -> context:SignatureHelpContext.t
         -> SignatureHelp.t ProviderResult.t]
         provideSignatureHelp);
    t_of_js obj
  ;;
end

module SignatureHelpProviderMetadata = struct
  include Interface.Make ()

  include
    [%js:
      val triggerCharacters : t -> string list [@@js.get "triggerCharacters"]
      val retriggerCharacters : t -> string list [@@js.get "retriggerCharacters"]]

  let create ~triggerCharacters ~retriggerCharacters () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "triggerCharacters"
      ((Ojs.list_to_js Ojs.string_to_js) triggerCharacters);
    Ojs.set_prop_ascii
      obj
      "retriggerCharacters"
      ((Ojs.list_to_js Ojs.string_to_js) retriggerCharacters);
    t_of_js obj
  ;;
end

module DocumentLink = struct
  include Class.Make ()

  include
    [%js:
      val range : t -> Range.t [@@js.get "range"]
      val set_range : t -> Range.t -> unit [@@js.set "range"]
      val target : t -> Uri.t or_undefined [@@js.get "target"]
      val set_target : t -> Uri.t or_undefined -> unit [@@js.set "target"]
      val tooltip : t -> string or_undefined [@@js.get "tooltip"]
      val set_tooltip : t -> string or_undefined -> unit [@@js.set "tooltip"]]

  let make ~range ?target () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "DocumentLink")
         (binding_arguments
            [| Range.t_to_js range; (or_undefined_to_js Uri.t_to_js) target |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module DocumentLinkProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val provideDocumentLinks
          :  t
          -> document:TextDocument.t
          -> token:CancellationToken.t
          -> T.t list ProviderResult.t
        [@@js.call "provideDocumentLinks"]]

    let resolveDocumentLink this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "resolveDocumentLink" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to: link:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create ~provideDocumentLinks ?resolveDocumentLink () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "provideDocumentLinks"
        ([%js.of:
           document:TextDocument.t
           -> token:CancellationToken.t
           -> T.t list ProviderResult.t]
           provideDocumentLinks);
      iter_set
        obj
        "resolveDocumentLink"
        [%js.of: link:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
        resolveDocumentLink;
      t_of_js obj
    ;;
  end
end

module Color = struct
  include Class.Make ()

  include
    [%js:
      val red : t -> int [@@js.get "red"]
      val green : t -> int [@@js.get "green"]
      val blue : t -> int [@@js.get "blue"]
      val alpha : t -> int [@@js.get "alpha"]

      val make : red:int -> green:int -> blue:int -> alpha:int -> t
      [@@js.new "@vscode.Color"]]
end

module ColorInformation = struct
  include Class.Make ()

  include
    [%js:
      val range : t -> Range.t [@@js.get "range"]
      val set_range : t -> Range.t -> unit [@@js.set "range"]
      val color : t -> Color.t [@@js.get "color"]
      val set_color : t -> Color.t -> unit [@@js.set "color"]
      val make : range:Range.t -> color:Color.t -> t [@@js.new "@vscode.ColorInformation"]]
end

module ColorPresentation = struct
  include Class.Make ()

  include
    [%js:
      val label : t -> string [@@js.get "label"]
      val set_label : t -> string -> unit [@@js.set "label"]
      val textEdit : t -> TextEdit.t or_undefined [@@js.get "textEdit"]
      val set_textEdit : t -> TextEdit.t or_undefined -> unit [@@js.set "textEdit"]

      val additionalTextEdits : t -> TextEdit.t list or_undefined
      [@@js.get "additionalTextEdits"]

      val set_additionalTextEdits : t -> TextEdit.t list or_undefined -> unit
      [@@js.set "additionalTextEdits"]

      val make : label:string -> t [@@js.new "@vscode.ColorPresentation"]]
end

module DocumentColorProvider = struct
  include Interface.Make ()

  type provide_color_presentations_context =
    { document : TextDocument.t
    ; range : Range.t
    }

  let provide_color_presentations_context_to_js
        (value : provide_color_presentations_context)
    =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "document" (TextDocument.t_to_js value.document);
    Ojs.set_prop_ascii js_val "range" (Range.t_to_js value.range);
    js_val
  ;;

  let provide_color_presentations_context_of_js js_val
    : provide_color_presentations_context
    =
    { document = TextDocument.t_of_js (Ojs.get_prop_ascii js_val "document")
    ; range = Range.t_of_js (Ojs.get_prop_ascii js_val "range")
    }
  ;;

  include
    [%js:
      val provideDocumentColors
        :  t
        -> document:TextDocument.t
        -> token:CancellationToken.t
        -> ColorInformation.t list ProviderResult.t
      [@@js.call "provideDocumentColors"]

      val provideColorPresentations
        :  t
        -> color:Color.t
        -> context:provide_color_presentations_context
        -> token:CancellationToken.t
        -> ColorPresentation.t list ProviderResult.t
      [@@js.call "provideColorPresentations"]]

  let create ~provideDocumentColors ~provideColorPresentations () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideDocumentColors"
      ([%js.of:
         document:TextDocument.t
         -> token:CancellationToken.t
         -> ColorInformation.t list ProviderResult.t]
         provideDocumentColors);
    Ojs.set_prop_ascii
      obj
      "provideColorPresentations"
      ([%js.of:
         color:Color.t
         -> context:provide_color_presentations_context
         -> token:CancellationToken.t
         -> ColorPresentation.t list ProviderResult.t]
         provideColorPresentations);
    t_of_js obj
  ;;
end

module InlayHintLabelPart = struct
  include Class.Make ()

  type tooltip =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let tooltip_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let tooltip_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else invalid_arg "InlayHintLabelPart.tooltip: unexpected JavaScript value"
  ;;

  include
    [%js:
      val value : t -> string [@@js.get "value"]
      val set_value : t -> string -> unit [@@js.set "value"]
      val tooltip : t -> tooltip or_undefined [@@js.get "tooltip"]
      val set_tooltip : t -> tooltip or_undefined -> unit [@@js.set "tooltip"]
      val location : t -> Location.t or_undefined [@@js.get "location"]
      val set_location : t -> Location.t or_undefined -> unit [@@js.set "location"]
      val command : t -> Command.t or_undefined [@@js.get "command"]
      val set_command : t -> Command.t or_undefined -> unit [@@js.set "command"]
      val make : value:string -> t [@@js.new "@vscode.InlayHintLabelPart"]]
end

module InlayHintKind = struct
  type t =
    | Type [@js 1]
    | Parameter [@js 2]
  [@@js.enum] [@@js]
end

module InlayHint = struct
  include Class.Make ()

  type label =
    [ `String of string
    | `Items of InlayHintLabelPart.t list
    ]

  let label_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Items value -> (Ojs.list_to_js InlayHintLabelPart.t_to_js) value
  ;;

  let label_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "object"
          && (not (Ojs.is_null js_val))
          && binding_has_member js_val "value")
    then `Items ((Ojs.list_of_js InlayHintLabelPart.t_of_js) js_val)
    else invalid_arg "InlayHint.label: unexpected JavaScript value"
  ;;

  type tooltip =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let tooltip_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let tooltip_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else invalid_arg "InlayHint.tooltip: unexpected JavaScript value"
  ;;

  include
    [%js:
      val position : t -> Position.t [@@js.get "position"]
      val set_position : t -> Position.t -> unit [@@js.set "position"]
      val label : t -> label [@@js.get "label"]
      val set_label : t -> label -> unit [@@js.set "label"]
      val tooltip : t -> tooltip or_undefined [@@js.get "tooltip"]
      val set_tooltip : t -> tooltip or_undefined -> unit [@@js.set "tooltip"]
      val kind : t -> InlayHintKind.t or_undefined [@@js.get "kind"]
      val set_kind : t -> InlayHintKind.t or_undefined -> unit [@@js.set "kind"]
      val textEdits : t -> TextEdit.t list or_undefined [@@js.get "textEdits"]
      val set_textEdits : t -> TextEdit.t list or_undefined -> unit [@@js.set "textEdits"]
      val paddingLeft : t -> bool or_undefined [@@js.get "paddingLeft"]
      val set_paddingLeft : t -> bool or_undefined -> unit [@@js.set "paddingLeft"]
      val paddingRight : t -> bool or_undefined [@@js.get "paddingRight"]
      val set_paddingRight : t -> bool or_undefined -> unit [@@js.set "paddingRight"]]

  let make ~position ~label ?kind () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "InlayHint")
         (binding_arguments
            [| Position.t_to_js position
             ; label_to_js label
             ; (or_undefined_to_js InlayHintKind.t_to_js) kind
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module InlayHintsProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val onDidChangeInlayHints : t -> unit Event.t or_undefined
        [@@js.get "onDidChangeInlayHints"]

        val set_onDidChangeInlayHints : t -> unit Event.t or_undefined -> unit
        [@@js.set "onDidChangeInlayHints"]

        val provideInlayHints
          :  t
          -> document:TextDocument.t
          -> range:Range.t
          -> token:CancellationToken.t
          -> T.t list ProviderResult.t
        [@@js.call "provideInlayHints"]]

    let resolveInlayHint this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "resolveInlayHint" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to: hint:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create ?onDidChangeInlayHints ~provideInlayHints ?resolveInlayHint () =
      let obj = Ojs.obj [||] in
      iter_set
        obj
        "onDidChangeInlayHints"
        (Event.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None))
        onDidChangeInlayHints;
      Ojs.set_prop_ascii
        obj
        "provideInlayHints"
        ([%js.of:
           document:TextDocument.t
           -> range:Range.t
           -> token:CancellationToken.t
           -> T.t list ProviderResult.t]
           provideInlayHints);
      iter_set
        obj
        "resolveInlayHint"
        [%js.of: hint:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
        resolveInlayHint;
      t_of_js obj
    ;;
  end
end

module FoldingContext = struct
  include Interface.Make ()
end

module FoldingRangeKind = struct
  type t =
    | Comment [@js 1]
    | Imports [@js 2]
    | Region [@js 3]
  [@@js.enum] [@@js]
end

module FoldingRange = struct
  include Class.Make ()

  include
    [%js:
      val start : t -> int [@@js.get "start"]
      val set_start : t -> int -> unit [@@js.set "start"]
      val end_ : t -> int [@@js.get "end"]
      val set_end_ : t -> int -> unit [@@js.set "end"]
      val kind : t -> FoldingRangeKind.t or_undefined [@@js.get "kind"]
      val set_kind : t -> FoldingRangeKind.t or_undefined -> unit [@@js.set "kind"]]

  let make ~start ~end_ ?kind () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "FoldingRange")
         (binding_arguments
            [| Ojs.int_to_js start
             ; Ojs.int_to_js end_
             ; (or_undefined_to_js FoldingRangeKind.t_to_js) kind
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module FoldingRangeProvider = struct
  include Interface.Make ()

  include
    [%js:
      val onDidChangeFoldingRanges : t -> unit Event.t or_undefined
      [@@js.get "onDidChangeFoldingRanges"]

      val set_onDidChangeFoldingRanges : t -> unit Event.t or_undefined -> unit
      [@@js.set "onDidChangeFoldingRanges"]

      val provideFoldingRanges
        :  t
        -> document:TextDocument.t
        -> context:FoldingContext.t
        -> token:CancellationToken.t
        -> FoldingRange.t list ProviderResult.t
      [@@js.call "provideFoldingRanges"]]

  let create ?onDidChangeFoldingRanges ~provideFoldingRanges () =
    let obj = Ojs.obj [||] in
    iter_set
      obj
      "onDidChangeFoldingRanges"
      (Event.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None))
      onDidChangeFoldingRanges;
    Ojs.set_prop_ascii
      obj
      "provideFoldingRanges"
      ([%js.of:
         document:TextDocument.t
         -> context:FoldingContext.t
         -> token:CancellationToken.t
         -> FoldingRange.t list ProviderResult.t]
         provideFoldingRanges);
    t_of_js obj
  ;;
end

module SelectionRange = struct
  include Class.Make ()

  include
    [%js:
      val range : t -> Range.t [@@js.get "range"]
      val set_range : t -> Range.t -> unit [@@js.set "range"]
      val parent : t -> t or_undefined [@@js.get "parent"]
      val set_parent : t -> t or_undefined -> unit [@@js.set "parent"]]

  let make ~range ?parent () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "SelectionRange")
         (binding_arguments
            [| Range.t_to_js range; (or_undefined_to_js t_to_js) parent |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module SelectionRangeProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideSelectionRanges
        :  t
        -> document:TextDocument.t
        -> positions:Position.t list
        -> token:CancellationToken.t
        -> SelectionRange.t list ProviderResult.t
      [@@js.call "provideSelectionRanges"]]

  let create ~provideSelectionRanges () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideSelectionRanges"
      ([%js.of:
         document:TextDocument.t
         -> positions:Position.t list
         -> token:CancellationToken.t
         -> SelectionRange.t list ProviderResult.t]
         provideSelectionRanges);
    t_of_js obj
  ;;
end

module CallHierarchyItem = struct
  include Class.Make ()

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val kind : t -> SymbolKind.t [@@js.get "kind"]
      val set_kind : t -> SymbolKind.t -> unit [@@js.set "kind"]
      val tags : t -> SymbolTag.t list or_undefined [@@js.get "tags"]
      val set_tags : t -> SymbolTag.t list or_undefined -> unit [@@js.set "tags"]
      val detail : t -> string or_undefined [@@js.get "detail"]
      val set_detail : t -> string or_undefined -> unit [@@js.set "detail"]
      val uri : t -> Uri.t [@@js.get "uri"]
      val set_uri : t -> Uri.t -> unit [@@js.set "uri"]
      val range : t -> Range.t [@@js.get "range"]
      val set_range : t -> Range.t -> unit [@@js.set "range"]
      val selectionRange : t -> Range.t [@@js.get "selectionRange"]
      val set_selectionRange : t -> Range.t -> unit [@@js.set "selectionRange"]

      val make
        :  kind:SymbolKind.t
        -> name:string
        -> detail:string
        -> uri:Uri.t
        -> range:Range.t
        -> selectionRange:Range.t
        -> t
      [@@js.new "@vscode.CallHierarchyItem"]]
end

module CallHierarchyIncomingCall = struct
  include Class.Make ()

  include
    [%js:
      val from : t -> CallHierarchyItem.t [@@js.get "from"]
      val set_from : t -> CallHierarchyItem.t -> unit [@@js.set "from"]
      val fromRanges : t -> Range.t list [@@js.get "fromRanges"]
      val set_fromRanges : t -> Range.t list -> unit [@@js.set "fromRanges"]

      val make : item:CallHierarchyItem.t -> fromRanges:Range.t list -> t
      [@@js.new "@vscode.CallHierarchyIncomingCall"]]
end

module CallHierarchyOutgoingCall = struct
  include Class.Make ()

  include
    [%js:
      val to_ : t -> CallHierarchyItem.t [@@js.get "to"]
      val set_to_ : t -> CallHierarchyItem.t -> unit [@@js.set "to"]
      val fromRanges : t -> Range.t list [@@js.get "fromRanges"]
      val set_fromRanges : t -> Range.t list -> unit [@@js.set "fromRanges"]

      val make : item:CallHierarchyItem.t -> fromRanges:Range.t list -> t
      [@@js.new "@vscode.CallHierarchyOutgoingCall"]]
end

module CallHierarchyProvider = struct
  include Interface.Make ()

  type prepare_call_hierarchy_result_t =
    [ `CallHierarchyItem of CallHierarchyItem.t
    | `Items of CallHierarchyItem.t list
    ]

  let prepare_call_hierarchy_result_t_to_js = function
    | `CallHierarchyItem value -> CallHierarchyItem.t_to_js value
    | `Items value -> (Ojs.list_to_js CallHierarchyItem.t_to_js) value
  ;;

  let prepare_call_hierarchy_result_t_of_js js_val =
    match binding_constructor js_val [ "CallHierarchyItem" ] with
    | Some "CallHierarchyItem" -> `CallHierarchyItem (CallHierarchyItem.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "name"
        && binding_has_member js_val "kind"
        && binding_has_member js_val "uri"
        && binding_has_member js_val "range"
        && binding_has_member js_val "selectionRange"
      then `CallHierarchyItem (CallHierarchyItem.t_of_js js_val)
      else if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            Ojs.type_of js_val = "object"
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "name"
            && binding_has_member js_val "kind"
            && binding_has_member js_val "uri"
            && binding_has_member js_val "range"
            && binding_has_member js_val "selectionRange")
      then `Items ((Ojs.list_of_js CallHierarchyItem.t_of_js) js_val)
      else
        invalid_arg
          "CallHierarchyProvider.prepare_call_hierarchy_result_t: unexpected JavaScript \
           value"
  ;;

  include
    [%js:
      val prepareCallHierarchy
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> prepare_call_hierarchy_result_t ProviderResult.t
      [@@js.call "prepareCallHierarchy"]

      val provideCallHierarchyIncomingCalls
        :  t
        -> item:CallHierarchyItem.t
        -> token:CancellationToken.t
        -> CallHierarchyIncomingCall.t list ProviderResult.t
      [@@js.call "provideCallHierarchyIncomingCalls"]

      val provideCallHierarchyOutgoingCalls
        :  t
        -> item:CallHierarchyItem.t
        -> token:CancellationToken.t
        -> CallHierarchyOutgoingCall.t list ProviderResult.t
      [@@js.call "provideCallHierarchyOutgoingCalls"]]

  let create
        ~prepareCallHierarchy
        ~provideCallHierarchyIncomingCalls
        ~provideCallHierarchyOutgoingCalls
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "prepareCallHierarchy"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> token:CancellationToken.t
         -> prepare_call_hierarchy_result_t ProviderResult.t]
         prepareCallHierarchy);
    Ojs.set_prop_ascii
      obj
      "provideCallHierarchyIncomingCalls"
      ([%js.of:
         item:CallHierarchyItem.t
         -> token:CancellationToken.t
         -> CallHierarchyIncomingCall.t list ProviderResult.t]
         provideCallHierarchyIncomingCalls);
    Ojs.set_prop_ascii
      obj
      "provideCallHierarchyOutgoingCalls"
      ([%js.of:
         item:CallHierarchyItem.t
         -> token:CancellationToken.t
         -> CallHierarchyOutgoingCall.t list ProviderResult.t]
         provideCallHierarchyOutgoingCalls);
    t_of_js obj
  ;;
end

module TypeHierarchyItem = struct
  include Class.Make ()

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val kind : t -> SymbolKind.t [@@js.get "kind"]
      val set_kind : t -> SymbolKind.t -> unit [@@js.set "kind"]
      val tags : t -> SymbolTag.t list or_undefined [@@js.get "tags"]
      val set_tags : t -> SymbolTag.t list or_undefined -> unit [@@js.set "tags"]
      val detail : t -> string or_undefined [@@js.get "detail"]
      val set_detail : t -> string or_undefined -> unit [@@js.set "detail"]
      val uri : t -> Uri.t [@@js.get "uri"]
      val set_uri : t -> Uri.t -> unit [@@js.set "uri"]
      val range : t -> Range.t [@@js.get "range"]
      val set_range : t -> Range.t -> unit [@@js.set "range"]
      val selectionRange : t -> Range.t [@@js.get "selectionRange"]
      val set_selectionRange : t -> Range.t -> unit [@@js.set "selectionRange"]

      val make
        :  kind:SymbolKind.t
        -> name:string
        -> detail:string
        -> uri:Uri.t
        -> range:Range.t
        -> selectionRange:Range.t
        -> t
      [@@js.new "@vscode.TypeHierarchyItem"]]
end

module TypeHierarchyProvider = struct
  include Interface.Make ()

  type prepare_type_hierarchy_result_t =
    [ `TypeHierarchyItem of TypeHierarchyItem.t
    | `Items of TypeHierarchyItem.t list
    ]

  let prepare_type_hierarchy_result_t_to_js = function
    | `TypeHierarchyItem value -> TypeHierarchyItem.t_to_js value
    | `Items value -> (Ojs.list_to_js TypeHierarchyItem.t_to_js) value
  ;;

  let prepare_type_hierarchy_result_t_of_js js_val =
    match binding_constructor js_val [ "TypeHierarchyItem" ] with
    | Some "TypeHierarchyItem" -> `TypeHierarchyItem (TypeHierarchyItem.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "name"
        && binding_has_member js_val "kind"
        && binding_has_member js_val "uri"
        && binding_has_member js_val "range"
        && binding_has_member js_val "selectionRange"
      then `TypeHierarchyItem (TypeHierarchyItem.t_of_js js_val)
      else if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            Ojs.type_of js_val = "object"
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "name"
            && binding_has_member js_val "kind"
            && binding_has_member js_val "uri"
            && binding_has_member js_val "range"
            && binding_has_member js_val "selectionRange")
      then `Items ((Ojs.list_of_js TypeHierarchyItem.t_of_js) js_val)
      else
        invalid_arg
          "TypeHierarchyProvider.prepare_type_hierarchy_result_t: unexpected JavaScript \
           value"
  ;;

  include
    [%js:
      val prepareTypeHierarchy
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> prepare_type_hierarchy_result_t ProviderResult.t
      [@@js.call "prepareTypeHierarchy"]

      val provideTypeHierarchySupertypes
        :  t
        -> item:TypeHierarchyItem.t
        -> token:CancellationToken.t
        -> TypeHierarchyItem.t list ProviderResult.t
      [@@js.call "provideTypeHierarchySupertypes"]

      val provideTypeHierarchySubtypes
        :  t
        -> item:TypeHierarchyItem.t
        -> token:CancellationToken.t
        -> TypeHierarchyItem.t list ProviderResult.t
      [@@js.call "provideTypeHierarchySubtypes"]]

  let create
        ~prepareTypeHierarchy
        ~provideTypeHierarchySupertypes
        ~provideTypeHierarchySubtypes
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "prepareTypeHierarchy"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> token:CancellationToken.t
         -> prepare_type_hierarchy_result_t ProviderResult.t]
         prepareTypeHierarchy);
    Ojs.set_prop_ascii
      obj
      "provideTypeHierarchySupertypes"
      ([%js.of:
         item:TypeHierarchyItem.t
         -> token:CancellationToken.t
         -> TypeHierarchyItem.t list ProviderResult.t]
         provideTypeHierarchySupertypes);
    Ojs.set_prop_ascii
      obj
      "provideTypeHierarchySubtypes"
      ([%js.of:
         item:TypeHierarchyItem.t
         -> token:CancellationToken.t
         -> TypeHierarchyItem.t list ProviderResult.t]
         provideTypeHierarchySubtypes);
    t_of_js obj
  ;;
end

module LinkedEditingRanges = struct
  include Class.Make ()

  let make ~ranges ?wordPattern () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "LinkedEditingRanges")
         (binding_arguments
            [| (Ojs.list_to_js Range.t_to_js) ranges
             ; (or_undefined_to_js Regexp.t_to_js) wordPattern
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val ranges : t -> Range.t list [@@js.get "ranges"]
      val wordPattern : t -> Regexp.t or_undefined [@@js.get "wordPattern"]]
end

module LinkedEditingRangeProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideLinkedEditingRanges
        :  t
        -> document:TextDocument.t
        -> position:Position.t
        -> token:CancellationToken.t
        -> LinkedEditingRanges.t ProviderResult.t
      [@@js.call "provideLinkedEditingRanges"]]

  let create ~provideLinkedEditingRanges () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideLinkedEditingRanges"
      ([%js.of:
         document:TextDocument.t
         -> position:Position.t
         -> token:CancellationToken.t
         -> LinkedEditingRanges.t ProviderResult.t]
         provideLinkedEditingRanges);
    t_of_js obj
  ;;
end

module DocumentDropEditProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    type provide_document_drop_edits_result_t =
      [ `T of T.t
      | `Items of T.t list
      ]

    let provide_document_drop_edits_result_t_to_js = function
      | `T value -> T.t_to_js value
      | `Items value -> (Ojs.list_to_js T.t_to_js) value
    ;;

    let provide_document_drop_edits_result_t_of_js js_val =
      if binding_is_array js_val
      then `Items ((Ojs.list_of_js T.t_of_js) js_val)
      else if true
      then `T (T.t_of_js js_val)
      else
        invalid_arg
          "DocumentDropEditProvider.provide_document_drop_edits_result_t: unexpected \
           JavaScript value"
    ;;

    include
      [%js:
        val provideDocumentDropEdits
          :  t
          -> document:TextDocument.t
          -> position:Position.t
          -> dataTransfer:DataTransfer.t
          -> token:CancellationToken.t
          -> provide_document_drop_edits_result_t ProviderResult.t
        [@@js.call "provideDocumentDropEdits"]]

    let resolveDocumentDropEdit this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "resolveDocumentDropEdit" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to: edit:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create ~provideDocumentDropEdits ?resolveDocumentDropEdit () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "provideDocumentDropEdits"
        ([%js.of:
           document:TextDocument.t
           -> position:Position.t
           -> dataTransfer:DataTransfer.t
           -> token:CancellationToken.t
           -> provide_document_drop_edits_result_t ProviderResult.t]
           provideDocumentDropEdits);
      iter_set
        obj
        "resolveDocumentDropEdit"
        [%js.of: edit:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
        resolveDocumentDropEdit;
      t_of_js obj
    ;;
  end
end

module DocumentDropOrPasteEditKind = struct
  include Class.Make ()

  include
    [%js:
      val empty : unit -> t [@@js.get "@vscode.DocumentDropOrPasteEditKind.Empty"]
      val text : unit -> t [@@js.get "@vscode.DocumentDropOrPasteEditKind.Text"]

      val textUpdateImports : unit -> t
      [@@js.get "@vscode.DocumentDropOrPasteEditKind.TextUpdateImports"]

      val value : t -> string [@@js.get "value"]
      val append : t -> parts:(string list[@js.variadic]) -> t [@@js.call "append"]
      val intersects : t -> other:t -> bool [@@js.call "intersects"]
      val contains : t -> other:t -> bool [@@js.call "contains"]]
end

module DocumentDropEdit = struct
  include Class.Make ()

  type insert_text =
    [ `String of string
    | `SnippetString of SnippetString.t
    ]

  let insert_text_to_js = function
    | `String value -> Ojs.string_to_js value
    | `SnippetString value -> SnippetString.t_to_js value
  ;;

  let insert_text_of_js js_val =
    match binding_constructor js_val [ "SnippetString" ] with
    | Some "SnippetString" -> `SnippetString (SnippetString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendTabstop"
        && binding_has_member js_val "appendPlaceholder"
        && binding_has_member js_val "appendChoice"
        && binding_has_member js_val "appendVariable"
      then `SnippetString (SnippetString.t_of_js js_val)
      else invalid_arg "DocumentDropEdit.insert_text: unexpected JavaScript value"
  ;;

  include
    [%js:
      val title : t -> string or_undefined [@@js.get "title"]
      val set_title : t -> string or_undefined -> unit [@@js.set "title"]
      val kind : t -> DocumentDropOrPasteEditKind.t or_undefined [@@js.get "kind"]

      val set_kind : t -> DocumentDropOrPasteEditKind.t or_undefined -> unit
      [@@js.set "kind"]

      val yieldTo : t -> DocumentDropOrPasteEditKind.t list or_undefined
      [@@js.get "yieldTo"]

      val set_yieldTo : t -> DocumentDropOrPasteEditKind.t list or_undefined -> unit
      [@@js.set "yieldTo"]

      val insertText : t -> insert_text [@@js.get "insertText"]
      val set_insertText : t -> insert_text -> unit [@@js.set "insertText"]
      val additionalEdit : t -> WorkspaceEdit.t or_undefined [@@js.get "additionalEdit"]

      val set_additionalEdit : t -> WorkspaceEdit.t or_undefined -> unit
      [@@js.set "additionalEdit"]]

  let make ~insertText ?title ?kind () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "DocumentDropEdit")
         (binding_arguments
            [| insert_text_to_js insertText
             ; (or_undefined_to_js Ojs.string_to_js) title
             ; (or_undefined_to_js DocumentDropOrPasteEditKind.t_to_js) kind
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module DocumentDropEditProviderMetadata = struct
  include Interface.Make ()

  include
    [%js:
      val providedDropEditKinds : t -> DocumentDropOrPasteEditKind.t list or_undefined
      [@@js.get "providedDropEditKinds"]

      val dropMimeTypes : t -> string list [@@js.get "dropMimeTypes"]]

  let create ?providedDropEditKinds ~dropMimeTypes () =
    let obj = Ojs.obj [||] in
    iter_set
      obj
      "providedDropEditKinds"
      (Ojs.list_to_js DocumentDropOrPasteEditKind.t_to_js)
      providedDropEditKinds;
    Ojs.set_prop_ascii
      obj
      "dropMimeTypes"
      ((Ojs.list_to_js Ojs.string_to_js) dropMimeTypes);
    t_of_js obj
  ;;
end

module DocumentPasteEdit = struct
  include Class.Make ()

  type insert_text =
    [ `String of string
    | `SnippetString of SnippetString.t
    ]

  let insert_text_to_js = function
    | `String value -> Ojs.string_to_js value
    | `SnippetString value -> SnippetString.t_to_js value
  ;;

  let insert_text_of_js js_val =
    match binding_constructor js_val [ "SnippetString" ] with
    | Some "SnippetString" -> `SnippetString (SnippetString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendTabstop"
        && binding_has_member js_val "appendPlaceholder"
        && binding_has_member js_val "appendChoice"
        && binding_has_member js_val "appendVariable"
      then `SnippetString (SnippetString.t_of_js js_val)
      else invalid_arg "DocumentPasteEdit.insert_text: unexpected JavaScript value"
  ;;

  include
    [%js:
      val title : t -> string [@@js.get "title"]
      val set_title : t -> string -> unit [@@js.set "title"]
      val kind : t -> DocumentDropOrPasteEditKind.t [@@js.get "kind"]
      val set_kind : t -> DocumentDropOrPasteEditKind.t -> unit [@@js.set "kind"]
      val insertText : t -> insert_text [@@js.get "insertText"]
      val set_insertText : t -> insert_text -> unit [@@js.set "insertText"]
      val additionalEdit : t -> WorkspaceEdit.t or_undefined [@@js.get "additionalEdit"]

      val set_additionalEdit : t -> WorkspaceEdit.t or_undefined -> unit
      [@@js.set "additionalEdit"]

      val yieldTo : t -> DocumentDropOrPasteEditKind.t list or_undefined
      [@@js.get "yieldTo"]

      val set_yieldTo : t -> DocumentDropOrPasteEditKind.t list or_undefined -> unit
      [@@js.set "yieldTo"]

      val make
        :  insertText:insert_text
        -> title:string
        -> kind:DocumentDropOrPasteEditKind.t
        -> t
      [@@js.new "@vscode.DocumentPasteEdit"]]
end

module DocumentPasteTriggerKind = struct
  type t =
    | Automatic [@js 0]
    | PasteAs [@js 1]
  [@@js.enum] [@@js]
end

module DocumentPasteEditContext = struct
  include Interface.Make ()

  include
    [%js:
      val only : t -> DocumentDropOrPasteEditKind.t or_undefined [@@js.get "only"]
      val triggerKind : t -> DocumentPasteTriggerKind.t [@@js.get "triggerKind"]]

  let create ~only ~triggerKind () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "only"
      ((or_undefined_to_js DocumentDropOrPasteEditKind.t_to_js) only);
    Ojs.set_prop_ascii obj "triggerKind" (DocumentPasteTriggerKind.t_to_js triggerKind);
    t_of_js obj
  ;;
end

module DocumentPasteEditProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    type prepare_document_paste_result =
      [ `Unit of unit
      | `Promise of unit Promise.t
      ]

    let prepare_document_paste_result_to_js = function
      | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
      | `Promise value ->
        (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
    ;;

    let prepare_document_paste_result_of_js js_val =
      if binding_is_thenable js_val
      then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
      else if Ojs.is_null js_val
      then `Unit ((fun _ -> ()) js_val)
      else
        invalid_arg
          "DocumentPasteEditProvider.prepare_document_paste_result: unexpected \
           JavaScript value"
    ;;

    let prepareDocumentPaste this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "prepareDocumentPaste" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to:
             document:TextDocument.t
             -> ranges:Range.t list
             -> dataTransfer:DataTransfer.t
             -> token:CancellationToken.t
             -> prepare_document_paste_result]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let provideDocumentPasteEdits this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "provideDocumentPasteEdits" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to:
             document:TextDocument.t
             -> ranges:Range.t list
             -> dataTransfer:DataTransfer.t
             -> context:DocumentPasteEditContext.t
             -> token:CancellationToken.t
             -> T.t list ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let resolveDocumentPasteEdit this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "resolveDocumentPasteEdit" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to: pasteEdit:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create
          ?prepareDocumentPaste
          ?provideDocumentPasteEdits
          ?resolveDocumentPasteEdit
          ()
      =
      let obj = Ojs.obj [||] in
      iter_set
        obj
        "prepareDocumentPaste"
        [%js.of:
          document:TextDocument.t
          -> ranges:Range.t list
          -> dataTransfer:DataTransfer.t
          -> token:CancellationToken.t
          -> prepare_document_paste_result]
        prepareDocumentPaste;
      iter_set
        obj
        "provideDocumentPasteEdits"
        [%js.of:
          document:TextDocument.t
          -> ranges:Range.t list
          -> dataTransfer:DataTransfer.t
          -> context:DocumentPasteEditContext.t
          -> token:CancellationToken.t
          -> T.t list ProviderResult.t]
        provideDocumentPasteEdits;
      iter_set
        obj
        "resolveDocumentPasteEdit"
        [%js.of: pasteEdit:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
        resolveDocumentPasteEdit;
      t_of_js obj
    ;;
  end
end

module DocumentPasteProviderMetadata = struct
  include Interface.Make ()

  include
    [%js:
      val providedPasteEditKinds : t -> DocumentDropOrPasteEditKind.t list
      [@@js.get "providedPasteEditKinds"]

      val copyMimeTypes : t -> string list or_undefined [@@js.get "copyMimeTypes"]
      val pasteMimeTypes : t -> string list or_undefined [@@js.get "pasteMimeTypes"]]

  let create ~providedPasteEditKinds ?copyMimeTypes ?pasteMimeTypes () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "providedPasteEditKinds"
      ((Ojs.list_to_js DocumentDropOrPasteEditKind.t_to_js) providedPasteEditKinds);
    iter_set obj "copyMimeTypes" (Ojs.list_to_js Ojs.string_to_js) copyMimeTypes;
    iter_set obj "pasteMimeTypes" (Ojs.list_to_js Ojs.string_to_js) pasteMimeTypes;
    t_of_js obj
  ;;
end

module LineCommentRule = struct
  include Interface.Make ()

  include
    [%js:
      val comment : t -> string [@@js.get "comment"]
      val set_comment : t -> string -> unit [@@js.set "comment"]
      val noIndent : t -> bool or_undefined [@@js.get "noIndent"]
      val set_noIndent : t -> bool or_undefined -> unit [@@js.set "noIndent"]]

  let create ~comment ?noIndent () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "comment" (Ojs.string_to_js comment);
    iter_set obj "noIndent" Ojs.bool_to_js noIndent;
    t_of_js obj
  ;;
end

module CharacterPair = struct
  type t = string * string

  let t_to_js =
    fun (v0, v1) ->
    Ojs.array_to_js Ojs.t_to_js [| Ojs.string_to_js v0; Ojs.string_to_js v1 |]
  ;;

  let t_of_js =
    fun js_val ->
    Ojs.string_of_js (Ojs.array_get js_val 0), Ojs.string_of_js (Ojs.array_get js_val 1)
  ;;
end

module CommentRule = struct
  include Interface.Make ()

  type line_comment =
    [ `String of string
    | `LineCommentRule of LineCommentRule.t
    ]

  let line_comment_to_js = function
    | `String value -> Ojs.string_to_js value
    | `LineCommentRule value -> LineCommentRule.t_to_js value
  ;;

  let line_comment_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "comment"
    then `LineCommentRule (LineCommentRule.t_of_js js_val)
    else invalid_arg "CommentRule.line_comment: unexpected JavaScript value"
  ;;

  include
    [%js:
      val lineComment : t -> line_comment or_undefined [@@js.get "lineComment"]

      val set_lineComment : t -> line_comment or_undefined -> unit
      [@@js.set "lineComment"]

      val blockComment : t -> CharacterPair.t or_undefined [@@js.get "blockComment"]

      val set_blockComment : t -> CharacterPair.t or_undefined -> unit
      [@@js.set "blockComment"]]

  let create ?lineComment ?blockComment () =
    let obj = Ojs.obj [||] in
    iter_set obj "lineComment" line_comment_to_js lineComment;
    iter_set obj "blockComment" CharacterPair.t_to_js blockComment;
    t_of_js obj
  ;;
end

module IndentationRule = struct
  include Interface.Make ()

  include
    [%js:
      val decreaseIndentPattern : t -> Regexp.t [@@js.get "decreaseIndentPattern"]

      val set_decreaseIndentPattern : t -> Regexp.t -> unit
      [@@js.set "decreaseIndentPattern"]

      val increaseIndentPattern : t -> Regexp.t [@@js.get "increaseIndentPattern"]

      val set_increaseIndentPattern : t -> Regexp.t -> unit
      [@@js.set "increaseIndentPattern"]

      val indentNextLinePattern : t -> Regexp.t or_undefined
      [@@js.get "indentNextLinePattern"]

      val set_indentNextLinePattern : t -> Regexp.t or_undefined -> unit
      [@@js.set "indentNextLinePattern"]

      val unIndentedLinePattern : t -> Regexp.t or_undefined
      [@@js.get "unIndentedLinePattern"]

      val set_unIndentedLinePattern : t -> Regexp.t or_undefined -> unit
      [@@js.set "unIndentedLinePattern"]]

  let create
        ~decreaseIndentPattern
        ~increaseIndentPattern
        ?indentNextLinePattern
        ?unIndentedLinePattern
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "decreaseIndentPattern" (Regexp.t_to_js decreaseIndentPattern);
    Ojs.set_prop_ascii obj "increaseIndentPattern" (Regexp.t_to_js increaseIndentPattern);
    iter_set obj "indentNextLinePattern" Regexp.t_to_js indentNextLinePattern;
    iter_set obj "unIndentedLinePattern" Regexp.t_to_js unIndentedLinePattern;
    t_of_js obj
  ;;
end

module IndentAction = struct
  type t =
    | None [@js 0]
    | Indent [@js 1]
    | IndentOutdent [@js 2]
    | Outdent [@js 3]
  [@@js.enum] [@@js]
end

module EnterAction = struct
  include Interface.Make ()

  include
    [%js:
      val indentAction : t -> IndentAction.t [@@js.get "indentAction"]
      val set_indentAction : t -> IndentAction.t -> unit [@@js.set "indentAction"]
      val appendText : t -> string or_undefined [@@js.get "appendText"]
      val set_appendText : t -> string or_undefined -> unit [@@js.set "appendText"]
      val removeText : t -> int or_undefined [@@js.get "removeText"]
      val set_removeText : t -> int or_undefined -> unit [@@js.set "removeText"]]

  let create ~indentAction ?appendText ?removeText () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "indentAction" (IndentAction.t_to_js indentAction);
    iter_set obj "appendText" Ojs.string_to_js appendText;
    iter_set obj "removeText" Ojs.int_to_js removeText;
    t_of_js obj
  ;;
end

module OnEnterRule = struct
  include Interface.Make ()

  include
    [%js:
      val beforeText : t -> Regexp.t [@@js.get "beforeText"]
      val set_beforeText : t -> Regexp.t -> unit [@@js.set "beforeText"]
      val afterText : t -> Regexp.t or_undefined [@@js.get "afterText"]
      val set_afterText : t -> Regexp.t or_undefined -> unit [@@js.set "afterText"]
      val previousLineText : t -> Regexp.t or_undefined [@@js.get "previousLineText"]

      val set_previousLineText : t -> Regexp.t or_undefined -> unit
      [@@js.set "previousLineText"]

      val action : t -> EnterAction.t [@@js.get "action"]
      val set_action : t -> EnterAction.t -> unit [@@js.set "action"]]

  let create ~beforeText ?afterText ?previousLineText ~action () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "beforeText" (Regexp.t_to_js beforeText);
    iter_set obj "afterText" Regexp.t_to_js afterText;
    iter_set obj "previousLineText" Regexp.t_to_js previousLineText;
    Ojs.set_prop_ascii obj "action" (EnterAction.t_to_js action);
    t_of_js obj
  ;;
end

module SyntaxTokenType = struct
  type t =
    | Other [@js 0]
    | Comment [@js 1]
    | String [@js 2]
    | RegEx [@js 3]
  [@@js.enum] [@@js]
end

module AutoClosingPair = struct
  include Interface.Make ()

  include
    [%js:
      val open_ : t -> string [@@js.get "open"]
      val set_open_ : t -> string -> unit [@@js.set "open"]
      val close : t -> string [@@js.get "close"]
      val set_close : t -> string -> unit [@@js.set "close"]
      val notIn : t -> SyntaxTokenType.t list or_undefined [@@js.get "notIn"]
      val set_notIn : t -> SyntaxTokenType.t list or_undefined -> unit [@@js.set "notIn"]]

  let create ~open_ ~close ?notIn () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "open" (Ojs.string_to_js open_);
    Ojs.set_prop_ascii obj "close" (Ojs.string_to_js close);
    iter_set obj "notIn" (Ojs.list_to_js SyntaxTokenType.t_to_js) notIn;
    t_of_js obj
  ;;
end

module LanguageConfiguration = struct
  include Interface.Make ()

  type _electric_character_support_doc_comment =
    { scope : string
    ; open_ : string
    ; lineStart : string
    ; close : string or_undefined
    }

  let _electric_character_support_doc_comment_to_js
        (value : _electric_character_support_doc_comment)
    =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "scope" (Ojs.string_to_js value.scope);
    Ojs.set_prop_ascii js_val "open" (Ojs.string_to_js value.open_);
    Ojs.set_prop_ascii js_val "lineStart" (Ojs.string_to_js value.lineStart);
    iter_set js_val "close" Ojs.string_to_js value.close;
    js_val
  ;;

  let _electric_character_support_doc_comment_of_js js_val
    : _electric_character_support_doc_comment
    =
    { scope = Ojs.string_of_js (Ojs.get_prop_ascii js_val "scope")
    ; open_ = Ojs.string_of_js (Ojs.get_prop_ascii js_val "open")
    ; lineStart = Ojs.string_of_js (Ojs.get_prop_ascii js_val "lineStart")
    ; close = (or_undefined_of_js Ojs.string_of_js) (Ojs.get_prop_ascii js_val "close")
    }
  ;;

  type _electric_character_support =
    { brackets : Ojs.t or_undefined
    ; docComment : _electric_character_support_doc_comment or_undefined
    }

  let _electric_character_support_to_js (value : _electric_character_support) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "brackets" Ojs.t_to_js value.brackets;
    iter_set
      js_val
      "docComment"
      _electric_character_support_doc_comment_to_js
      value.docComment;
    js_val
  ;;

  let _electric_character_support_of_js js_val : _electric_character_support =
    { brackets = (or_undefined_of_js Ojs.t_of_js) (Ojs.get_prop_ascii js_val "brackets")
    ; docComment =
        (or_undefined_of_js _electric_character_support_doc_comment_of_js)
          (Ojs.get_prop_ascii js_val "docComment")
    }
  ;;

  type _character_pair_support_auto_closing_pairs_item =
    { open_ : string
    ; close : string
    ; notIn : string list or_undefined
    }

  let _character_pair_support_auto_closing_pairs_item_to_js
        (value : _character_pair_support_auto_closing_pairs_item)
    =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "open" (Ojs.string_to_js value.open_);
    Ojs.set_prop_ascii js_val "close" (Ojs.string_to_js value.close);
    iter_set js_val "notIn" (Ojs.list_to_js Ojs.string_to_js) value.notIn;
    js_val
  ;;

  let _character_pair_support_auto_closing_pairs_item_of_js js_val
    : _character_pair_support_auto_closing_pairs_item
    =
    { open_ = Ojs.string_of_js (Ojs.get_prop_ascii js_val "open")
    ; close = Ojs.string_of_js (Ojs.get_prop_ascii js_val "close")
    ; notIn =
        (or_undefined_of_js (Ojs.list_of_js Ojs.string_of_js))
          (Ojs.get_prop_ascii js_val "notIn")
    }
  ;;

  type _character_pair_support =
    { autoClosingPairs : _character_pair_support_auto_closing_pairs_item list }

  let _character_pair_support_to_js (value : _character_pair_support) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii
      js_val
      "autoClosingPairs"
      ((Ojs.list_to_js _character_pair_support_auto_closing_pairs_item_to_js)
         value.autoClosingPairs);
    js_val
  ;;

  let _character_pair_support_of_js js_val : _character_pair_support =
    { autoClosingPairs =
        (Ojs.list_of_js _character_pair_support_auto_closing_pairs_item_of_js)
          (Ojs.get_prop_ascii js_val "autoClosingPairs")
    }
  ;;

  include
    [%js:
      val comments : t -> CommentRule.t or_undefined [@@js.get "comments"]
      val set_comments : t -> CommentRule.t or_undefined -> unit [@@js.set "comments"]
      val brackets : t -> CharacterPair.t list or_undefined [@@js.get "brackets"]

      val set_brackets : t -> CharacterPair.t list or_undefined -> unit
      [@@js.set "brackets"]

      val wordPattern : t -> Regexp.t or_undefined [@@js.get "wordPattern"]
      val set_wordPattern : t -> Regexp.t or_undefined -> unit [@@js.set "wordPattern"]

      val indentationRules : t -> IndentationRule.t or_undefined
      [@@js.get "indentationRules"]

      val set_indentationRules : t -> IndentationRule.t or_undefined -> unit
      [@@js.set "indentationRules"]

      val onEnterRules : t -> OnEnterRule.t list or_undefined [@@js.get "onEnterRules"]

      val set_onEnterRules : t -> OnEnterRule.t list or_undefined -> unit
      [@@js.set "onEnterRules"]

      val autoClosingPairs : t -> AutoClosingPair.t list or_undefined
      [@@js.get "autoClosingPairs"]

      val set_autoClosingPairs : t -> AutoClosingPair.t list or_undefined -> unit
      [@@js.set "autoClosingPairs"]

      val __electricCharacterSupport : t -> _electric_character_support or_undefined
      [@@js.get "__electricCharacterSupport"]

      val set___electricCharacterSupport
        :  t
        -> _electric_character_support or_undefined
        -> unit
      [@@js.set "__electricCharacterSupport"]

      val __characterPairSupport : t -> _character_pair_support or_undefined
      [@@js.get "__characterPairSupport"]

      val set___characterPairSupport : t -> _character_pair_support or_undefined -> unit
      [@@js.set "__characterPairSupport"]]

  let create
        ?comments
        ?brackets
        ?wordPattern
        ?indentationRules
        ?onEnterRules
        ?autoClosingPairs
        ?__electricCharacterSupport
        ?__characterPairSupport
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set obj "comments" CommentRule.t_to_js comments;
    iter_set obj "brackets" (Ojs.list_to_js CharacterPair.t_to_js) brackets;
    iter_set obj "wordPattern" Regexp.t_to_js wordPattern;
    iter_set obj "indentationRules" IndentationRule.t_to_js indentationRules;
    iter_set obj "onEnterRules" (Ojs.list_to_js OnEnterRule.t_to_js) onEnterRules;
    iter_set
      obj
      "autoClosingPairs"
      (Ojs.list_to_js AutoClosingPair.t_to_js)
      autoClosingPairs;
    iter_set
      obj
      "__electricCharacterSupport"
      _electric_character_support_to_js
      __electricCharacterSupport;
    iter_set
      obj
      "__characterPairSupport"
      _character_pair_support_to_js
      __characterPairSupport;
    t_of_js obj
  ;;
end

module Languages = struct
  include
    [%js:
      val registerDocumentFormattingEditProvider
        :  selector:DocumentSelector.t
        -> provider:DocumentFormattingEditProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerDocumentFormattingEditProvider"]

      val registerHoverProvider
        :  selector:DocumentSelector.t
        -> provider:HoverProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerHoverProvider"]

      val getDiagnostics : Uri.t -> Diagnostic.t list
      [@@js.global "@vscode.languages.getDiagnostics"]

      val getDiagnostics_all : unit -> (Uri.t * Diagnostic.t list) list
      [@@js.global "@vscode.languages.getDiagnostics"]

      val getLanguages : unit -> string list Promise.t
      [@@js.global "@vscode.languages.getLanguages"]

      val setTextDocumentLanguage
        :  document:TextDocument.t
        -> languageId:string
        -> TextDocument.t Promise.t
      [@@js.global "@vscode.languages.setTextDocumentLanguage"]

      val match_ : selector:DocumentSelector.t -> document:TextDocument.t -> int
      [@@js.global "@vscode.languages.match"]

      val onDidChangeDiagnostics : unit -> DiagnosticChangeEvent.t Event.t
      [@@js.get "@vscode.languages.onDidChangeDiagnostics"]]

  let createDiagnosticCollection ?name () =
    DiagnosticCollection.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "languages")
         "createDiagnosticCollection"
         (binding_arguments
            [| (or_undefined_to_js Ojs.string_to_js) name |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val createLanguageStatusItem
        :  id:string
        -> selector:DocumentSelector.t
        -> LanguageStatusItem.t
      [@@js.global "@vscode.languages.createLanguageStatusItem"]

      val registerCompletionItemProvider
        :  selector:DocumentSelector.t
        -> provider:CompletionItem.t CompletionItemProvider.t
        -> triggerCharacters:(string list[@js.variadic])
        -> Disposable.t
      [@@js.global "@vscode.languages.registerCompletionItemProvider"]

      val registerInlineCompletionItemProvider
        :  selector:DocumentSelector.t
        -> provider:InlineCompletionItemProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerInlineCompletionItemProvider"]]

  let registerCodeActionsProvider ~selector ~provider ?metadata () =
    Disposable.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "languages")
         "registerCodeActionsProvider"
         (binding_arguments
            [| DocumentSelector.t_to_js selector
             ; (CodeActionProvider.t_to_js CodeAction.t_to_js) provider
             ; (or_undefined_to_js CodeActionProviderMetadata.t_to_js) metadata
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val registerCodeLensProvider
        :  selector:DocumentSelector.t
        -> provider:CodeLens.t CodeLensProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerCodeLensProvider"]

      val registerDefinitionProvider
        :  selector:DocumentSelector.t
        -> provider:DefinitionProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerDefinitionProvider"]

      val registerImplementationProvider
        :  selector:DocumentSelector.t
        -> provider:ImplementationProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerImplementationProvider"]

      val registerTypeDefinitionProvider
        :  selector:DocumentSelector.t
        -> provider:TypeDefinitionProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerTypeDefinitionProvider"]

      val registerDeclarationProvider
        :  selector:DocumentSelector.t
        -> provider:DeclarationProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerDeclarationProvider"]

      val registerEvaluatableExpressionProvider
        :  selector:DocumentSelector.t
        -> provider:EvaluatableExpressionProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerEvaluatableExpressionProvider"]

      val registerInlineValuesProvider
        :  selector:DocumentSelector.t
        -> provider:InlineValuesProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerInlineValuesProvider"]

      val registerDocumentHighlightProvider
        :  selector:DocumentSelector.t
        -> provider:DocumentHighlightProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerDocumentHighlightProvider"]]

  let registerDocumentSymbolProvider ~selector ~provider ?metaData () =
    Disposable.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "languages")
         "registerDocumentSymbolProvider"
         (binding_arguments
            [| DocumentSelector.t_to_js selector
             ; DocumentSymbolProvider.t_to_js provider
             ; (or_undefined_to_js DocumentSymbolProviderMetadata.t_to_js) metaData
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val registerWorkspaceSymbolProvider
        :  provider:SymbolInformation.t WorkspaceSymbolProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerWorkspaceSymbolProvider"]

      val registerReferenceProvider
        :  selector:DocumentSelector.t
        -> provider:ReferenceProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerReferenceProvider"]

      val registerRenameProvider
        :  selector:DocumentSelector.t
        -> provider:RenameProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerRenameProvider"]

      val registerDocumentSemanticTokensProvider
        :  selector:DocumentSelector.t
        -> provider:DocumentSemanticTokensProvider.t
        -> legend:SemanticTokensLegend.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerDocumentSemanticTokensProvider"]

      val registerDocumentRangeSemanticTokensProvider
        :  selector:DocumentSelector.t
        -> provider:DocumentRangeSemanticTokensProvider.t
        -> legend:SemanticTokensLegend.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerDocumentRangeSemanticTokensProvider"]

      val registerDocumentRangeFormattingEditProvider
        :  selector:DocumentSelector.t
        -> provider:DocumentRangeFormattingEditProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerDocumentRangeFormattingEditProvider"]

      val registerOnTypeFormattingEditProvider
        :  selector:DocumentSelector.t
        -> provider:OnTypeFormattingEditProvider.t
        -> firstTriggerCharacter:string
        -> moreTriggerCharacter:(string list[@js.variadic])
        -> Disposable.t
      [@@js.global "@vscode.languages.registerOnTypeFormattingEditProvider"]

      val registerSignatureHelpProvider
        :  selector:DocumentSelector.t
        -> provider:SignatureHelpProvider.t
        -> triggerCharacters:(string list[@js.variadic])
        -> Disposable.t
      [@@js.global "@vscode.languages.registerSignatureHelpProvider"]

      val registerSignatureHelpProviderWithMetadata
        :  selector:DocumentSelector.t
        -> provider:SignatureHelpProvider.t
        -> metadata:SignatureHelpProviderMetadata.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerSignatureHelpProvider"]

      val registerDocumentLinkProvider
        :  selector:DocumentSelector.t
        -> provider:DocumentLink.t DocumentLinkProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerDocumentLinkProvider"]

      val registerColorProvider
        :  selector:DocumentSelector.t
        -> provider:DocumentColorProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerColorProvider"]

      val registerInlayHintsProvider
        :  selector:DocumentSelector.t
        -> provider:InlayHint.t InlayHintsProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerInlayHintsProvider"]

      val registerFoldingRangeProvider
        :  selector:DocumentSelector.t
        -> provider:FoldingRangeProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerFoldingRangeProvider"]

      val registerSelectionRangeProvider
        :  selector:DocumentSelector.t
        -> provider:SelectionRangeProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerSelectionRangeProvider"]

      val registerCallHierarchyProvider
        :  selector:DocumentSelector.t
        -> provider:CallHierarchyProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerCallHierarchyProvider"]

      val registerTypeHierarchyProvider
        :  selector:DocumentSelector.t
        -> provider:TypeHierarchyProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerTypeHierarchyProvider"]

      val registerLinkedEditingRangeProvider
        :  selector:DocumentSelector.t
        -> provider:LinkedEditingRangeProvider.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerLinkedEditingRangeProvider"]]

  let registerDocumentDropEditProvider ~selector ~provider ?metadata () =
    Disposable.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "languages")
         "registerDocumentDropEditProvider"
         (binding_arguments
            [| DocumentSelector.t_to_js selector
             ; (DocumentDropEditProvider.t_to_js DocumentDropEdit.t_to_js) provider
             ; (or_undefined_to_js DocumentDropEditProviderMetadata.t_to_js) metadata
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val registerDocumentPasteEditProvider
        :  selector:DocumentSelector.t
        -> provider:DocumentPasteEdit.t DocumentPasteEditProvider.t
        -> metadata:DocumentPasteProviderMetadata.t
        -> Disposable.t
      [@@js.global "@vscode.languages.registerDocumentPasteEditProvider"]

      val setLanguageConfiguration
        :  language:string
        -> configuration:LanguageConfiguration.t
        -> Disposable.t
      [@@js.global "@vscode.languages.setLanguageConfiguration"]]
end

module TaskFilter = struct
  include Interface.Make ()

  include
    [%js:
      val version : t -> string or_undefined [@@js.get "version"]
      val set_version : t -> string or_undefined -> unit [@@js.set "version"]
      val type_ : t -> string or_undefined [@@js.get "type"]
      val set_type_ : t -> string or_undefined -> unit [@@js.set "type"]]

  let create ?version ?type_ () =
    let obj = Ojs.obj [||] in
    iter_set obj "version" Ojs.string_to_js version;
    iter_set obj "type" Ojs.string_to_js type_;
    t_of_js obj
  ;;
end

module TaskExecution = struct
  include Interface.Make ()

  include
    [%js:
      val task : t -> Task.t [@@js.get "task"]
      val set_task : t -> Task.t -> unit [@@js.set "task"]
      val terminate : t -> unit [@@js.call "terminate"]]

  let create ~task ~terminate () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "task" (Task.t_to_js task);
    Ojs.set_prop_ascii obj "terminate" ([%js.of: unit -> unit] terminate);
    t_of_js obj
  ;;
end

module TaskStartEvent = struct
  include Interface.Make ()
  include [%js: val execution : t -> TaskExecution.t [@@js.get "execution"]]

  let create ~execution () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "execution" (TaskExecution.t_to_js execution);
    t_of_js obj
  ;;
end

module TaskEndEvent = struct
  include Interface.Make ()
  include [%js: val execution : t -> TaskExecution.t [@@js.get "execution"]]

  let create ~execution () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "execution" (TaskExecution.t_to_js execution);
    t_of_js obj
  ;;
end

module TaskProcessStartEvent = struct
  include Interface.Make ()

  include
    [%js:
      val execution : t -> TaskExecution.t [@@js.get "execution"]
      val processId : t -> int [@@js.get "processId"]]

  let create ~execution ~processId () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "execution" (TaskExecution.t_to_js execution);
    Ojs.set_prop_ascii obj "processId" (Ojs.int_to_js processId);
    t_of_js obj
  ;;
end

module TaskProcessEndEvent = struct
  include Interface.Make ()

  include
    [%js:
      val execution : t -> TaskExecution.t [@@js.get "execution"]
      val exitCode : t -> int or_undefined [@@js.get "exitCode"]]

  let create ~execution ~exitCode () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "execution" (TaskExecution.t_to_js execution);
    Ojs.set_prop_ascii obj "exitCode" ((or_undefined_to_js Ojs.int_to_js) exitCode);
    t_of_js obj
  ;;
end

module Tasks = struct
  include
    [%js:
      val registerTaskProvider
        :  type_:string
        -> provider:TaskProvider.Default.t
        -> Disposable.t
      [@@js.global "@vscode.tasks.registerTaskProvider"]

      val registerTaskProviderTyped
        :  type_:string
        -> provider:Task.t TaskProvider.t
        -> Disposable.t
      [@@js.global "@vscode.tasks.registerTaskProvider"]]

  let fetchTasks ?filter () =
    (Promise.t_of_js (Ojs.list_of_js Task.t_of_js))
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "tasks")
         "fetchTasks"
         (binding_arguments
            [| (or_undefined_to_js TaskFilter.t_to_js) filter |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val executeTask : task:Task.t -> TaskExecution.t Promise.t
      [@@js.global "@vscode.tasks.executeTask"]

      val taskExecutions : unit -> TaskExecution.t list
      [@@js.get "@vscode.tasks.taskExecutions"]

      val onDidStartTask : unit -> TaskStartEvent.t Event.t
      [@@js.get "@vscode.tasks.onDidStartTask"]

      val onDidEndTask : unit -> TaskEndEvent.t Event.t
      [@@js.get "@vscode.tasks.onDidEndTask"]

      val onDidStartTaskProcess : unit -> TaskProcessStartEvent.t Event.t
      [@@js.get "@vscode.tasks.onDidStartTaskProcess"]

      val onDidEndTaskProcess : unit -> TaskProcessEndEvent.t Event.t
      [@@js.get "@vscode.tasks.onDidEndTaskProcess"]]
end

module TelemetryLogger = struct
  include Interface.Make ()

  include
    [%js:
      val onDidChangeEnableStates : t -> t Event.t [@@js.get "onDidChangeEnableStates"]
      val isUsageEnabled : t -> bool [@@js.get "isUsageEnabled"]
      val isErrorsEnabled : t -> bool [@@js.get "isErrorsEnabled"]]

  let logUsage this ~eventName ?data () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "logUsage"
         (binding_arguments
            [| Ojs.string_to_js eventName
             ; (or_undefined_to_js (Dict.t_to_js Ojs.t_to_js)) data
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let logError this ~eventName ?data () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "logError"
         (binding_arguments
            [| Ojs.string_to_js eventName
             ; (or_undefined_to_js (Dict.t_to_js Ojs.t_to_js)) data
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let logException this ~error ?data () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "logError"
         (binding_arguments
            [| JsError.t_to_js error
             ; (or_undefined_to_js (Dict.t_to_js Ojs.t_to_js)) data
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include [%js: val dispose : t -> unit [@@js.call "dispose"]]
end

module TelemetrySender = struct
  include Interface.Make ()

  type flush_result =
    [ `Unit of unit
    | `Promise of unit Promise.t
    ]

  let flush_result_to_js = function
    | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
    | `Promise value ->
      (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
  ;;

  let flush_result_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
    else if Ojs.is_null js_val
    then `Unit ((fun _ -> ()) js_val)
    else invalid_arg "TelemetrySender.flush_result: unexpected JavaScript value"
  ;;

  let sendEventData this ~eventName ?data () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "sendEventData"
         (binding_arguments
            [| Ojs.string_to_js eventName
             ; (or_undefined_to_js (Dict.t_to_js Ojs.t_to_js)) data
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let sendErrorData this ~error ?data () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "sendErrorData"
         (binding_arguments
            [| JsError.t_to_js error
             ; (or_undefined_to_js (Dict.t_to_js Ojs.t_to_js)) data
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let flush this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "flush" in
    if Ojs.is_null callback
    then None
    else Some ([%js.to: unit -> flush_result] (Ojs.call callback "bind" [| this |]))
  ;;

  let create ~sendEventData ~sendErrorData ?flush () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "sendEventData"
      ([%js.of: eventName:string -> ?data:Ojs.t Dict.t -> unit -> unit] sendEventData);
    Ojs.set_prop_ascii
      obj
      "sendErrorData"
      ([%js.of: error:JsError.t -> ?data:Ojs.t Dict.t -> unit -> unit] sendErrorData);
    iter_set obj "flush" [%js.of: unit -> flush_result] flush;
    t_of_js obj
  ;;
end

module TelemetryLoggerOptions = struct
  include Interface.Make ()

  include
    [%js:
      val ignoreBuiltInCommonProperties : t -> bool or_undefined
      [@@js.get "ignoreBuiltInCommonProperties"]

      val ignoreUnhandledErrors : t -> bool or_undefined
      [@@js.get "ignoreUnhandledErrors"]

      val additionalCommonProperties : t -> Ojs.t Dict.t or_undefined
      [@@js.get "additionalCommonProperties"]]

  let create
        ?ignoreBuiltInCommonProperties
        ?ignoreUnhandledErrors
        ?additionalCommonProperties
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set
      obj
      "ignoreBuiltInCommonProperties"
      Ojs.bool_to_js
      ignoreBuiltInCommonProperties;
    iter_set obj "ignoreUnhandledErrors" Ojs.bool_to_js ignoreUnhandledErrors;
    iter_set
      obj
      "additionalCommonProperties"
      (Dict.t_to_js Ojs.t_to_js)
      additionalCommonProperties;
    t_of_js obj
  ;;
end

module UIKind = struct
  type t =
    | Desktop [@js 1]
    | Web [@js 2]
  [@@js.enum] [@@js]
end

module Env = struct
  include
    [%js:
      val isAppPortable : unit -> bool [@@js.get "@vscode.env.isAppPortable"]
      val shell : unit -> string [@@js.get "@vscode.env.shell"]
      val clipboard : unit -> Clipboard.t [@@js.get "@vscode.env.clipboard"]
      val appName : unit -> string [@@js.get "@vscode.env.appName"]
      val appRoot : unit -> string [@@js.get "@vscode.env.appRoot"]
      val appHost : unit -> string [@@js.get "@vscode.env.appHost"]
      val uriScheme : unit -> string [@@js.get "@vscode.env.uriScheme"]
      val language : unit -> string [@@js.get "@vscode.env.language"]
      val machineId : unit -> string [@@js.get "@vscode.env.machineId"]
      val sessionId : unit -> string [@@js.get "@vscode.env.sessionId"]
      val isNewAppInstall : unit -> bool [@@js.get "@vscode.env.isNewAppInstall"]
      val isTelemetryEnabled : unit -> bool [@@js.get "@vscode.env.isTelemetryEnabled"]

      val onDidChangeTelemetryEnabled : unit -> bool Event.t
      [@@js.get "@vscode.env.onDidChangeTelemetryEnabled"]

      val onDidChangeShell : unit -> string Event.t
      [@@js.get "@vscode.env.onDidChangeShell"]]

  let createTelemetryLogger ~sender ?options () =
    TelemetryLogger.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "env")
         "createTelemetryLogger"
         (binding_arguments
            [| TelemetrySender.t_to_js sender
             ; (or_undefined_to_js TelemetryLoggerOptions.t_to_js) options
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val remoteName : unit -> string or_undefined [@@js.get "@vscode.env.remoteName"]
      val uiKind : unit -> UIKind.t [@@js.get "@vscode.env.uiKind"]

      val openExternal : target:Uri.t -> bool Promise.t
      [@@js.global "@vscode.env.openExternal"]

      val asExternalUri : target:Uri.t -> Uri.t Promise.t
      [@@js.global "@vscode.env.asExternalUri"]

      val logLevel : unit -> LogLevel.t [@@js.get "@vscode.env.logLevel"]

      val onDidChangeLogLevel : unit -> LogLevel.t Event.t
      [@@js.get "@vscode.env.onDidChangeLogLevel"]]
end

module DebugAdapterExecutableOptions = struct
  include Interface.Make ()

  include
    [%js:
      val cwd : t -> string or_undefined [@@js.get "cwd"]
      val env : t -> string Dict.t or_undefined [@@js.get "env"]]

  include
    [%js:
      val set_env : t -> string Dict.t or_undefined -> unit [@@js.set "env"]
      val set_cwd : t -> string or_undefined -> unit [@@js.set "cwd"]]

  let create ?env ?cwd () =
    let obj = Ojs.obj [||] in
    iter_set obj "env" (Dict.t_to_js Ojs.string_to_js) env;
    iter_set obj "cwd" Ojs.string_to_js cwd;
    t_of_js obj
  ;;
end

module DebugAdapterExecutable = struct
  include Class.Make ()

  include
    [%js:
      val make
        :  command:string
        -> ?args:string list
        -> ?options:DebugAdapterExecutableOptions.t
        -> unit
        -> t
      [@@js.new "@vscode.DebugAdapterExecutable"]

      val command : t -> string [@@js.get "command"]
      val args : t -> string list [@@js.get "args"]
      val options : t -> DebugAdapterExecutableOptions.t or_undefined [@@js.get "options"]]
end

module DebugAdapterServer = struct
  include Class.Make ()

  include
    [%js:
      val port : t -> int [@@js.get "port"]
      val host : t -> string or_undefined [@@js.get "host"]]

  let make ~port ?host () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "DebugAdapterServer")
         (binding_arguments
            [| Ojs.int_to_js port; (or_undefined_to_js Ojs.string_to_js) host |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module DebugAdapterNamedPipeServer = struct
  include Class.Make ()

  include
    [%js:
      val path : t -> string [@@js.get "path"]
      val make : path:string -> t [@@js.new "@vscode.DebugAdapterNamedPipeServer"]]
end

module DebugProtocolMessage = struct
  include Interface.Make ()
end

module DebugAdapter = struct
  include Interface.Extend (Disposable) ()

  type from_disposable_likes_item = { dispose : unit -> Ojs.t }

  let from_disposable_likes_item_to_js (value : from_disposable_likes_item) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "dispose" ([%js.of: unit -> Ojs.t] value.dispose);
    js_val
  ;;

  let from_disposable_likes_item_of_js js_val : from_disposable_likes_item =
    { dispose = [%js.to: unit -> Ojs.t] (Ojs.get_prop_ascii js_val "dispose") }
  ;;

  let to_disposable (value : t) = (value :> Disposable.t)

  include
    [%js:
      val from
        :  disposableLikes:(from_disposable_likes_item list[@js.variadic])
        -> Disposable.t
      [@@js.global "@vscode.DebugAdapter.from"]

      val dispose : t -> Ojs.t [@@js.call "dispose"]

      val onDidSendMessage : t -> DebugProtocolMessage.t Event.t
      [@@js.get "onDidSendMessage"]

      val handleMessage : t -> message:DebugProtocolMessage.t -> unit
      [@@js.call "handleMessage"]]

  let create ~from ~dispose ~onDidSendMessage ~handleMessage () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "from" (Disposable.t_to_js from);
    Ojs.set_prop_ascii obj "dispose" (Ojs.t_to_js dispose);
    Ojs.set_prop_ascii
      obj
      "onDidSendMessage"
      ((Event.t_to_js DebugProtocolMessage.t_to_js) onDidSendMessage);
    Ojs.set_prop_ascii
      obj
      "handleMessage"
      ([%js.of: message:DebugProtocolMessage.t -> unit] handleMessage);
    t_of_js obj
  ;;
end

module DebugAdapterInlineImplementation = struct
  include Class.Make ()

  include
    [%js:
      val make : implementation:DebugAdapter.t -> t
      [@@js.new "@vscode.DebugAdapterInlineImplementation"]]
end

module DebugAdapterDescriptor = struct
  type t =
    ([ `Executable of DebugAdapterExecutable.t
     | `Server of DebugAdapterServer.t
     | `NamedPipeServer of DebugAdapterNamedPipeServer.t
     | `InlineImplementation of DebugAdapterInlineImplementation.t
     ]
    [@js.union])
  [@@js]

  let t_of_js js_val : t =
    let constructor_name =
      [%js.to: string]
      @@ Ojs.get_prop_ascii (Ojs.get_prop_ascii js_val "constructor") "name"
    in
    match constructor_name with
    | "DebugAdapterExecutable" -> `Executable ([%js.to: DebugAdapterExecutable.t] js_val)
    | "DebugAdapterServer" -> `Server ([%js.to: DebugAdapterServer.t] js_val)
    | "DebugAdapterNamedPipeServer" ->
      `NamedPipeServer ([%js.to: DebugAdapterNamedPipeServer.t] js_val)
    | "DebugAdapterInlineImplementation" ->
      `InlineImplementation ([%js.to: DebugAdapterInlineImplementation.t] js_val)
    | _ -> assert false
  ;;
end

module DebugConfiguration = struct
  include Interface.Make ()

  include
    [%js:
      val create : name:string -> request:string -> type_:string -> t [@@js.builder]
      val set : t -> string -> Ojs.t -> unit [@@js.index_set]
      val type_ : t -> string [@@js.get "type"]
      val set_type_ : t -> string -> unit [@@js.set "type"]
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val request : t -> string [@@js.get "request"]
      val set_request : t -> string -> unit [@@js.set "request"]]

  let getProperty this ~key =
    (or_undefined_of_js Ojs.t_of_js) (Ojs.get_prop (t_to_js this) (Ojs.string_to_js key))
  ;;

  let setProperty this ~key ~value =
    Ojs.set_prop (t_to_js this) (Ojs.string_to_js key) (Ojs.t_to_js value)
  ;;
end

module Breakpoint = struct
  include Class.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val enabled : t -> bool [@@js.get "enabled"]
      val condition : t -> string or_undefined [@@js.get "condition"]
      val hitCondition : t -> string or_undefined [@@js.get "hitCondition"]
      val logMessage : t -> string or_undefined [@@js.get "logMessage"]]
end

module DebugProtocolBreakpoint = struct
  include Interface.Make ()
end

module DebugSession = struct
  include Class.Make ()

  include
    [%js:
      val customRequest : t -> command:string -> ?args:Ojs.t -> unit -> Ojs.t Promise.t
      [@@js.call]

      val id : t -> string [@@js.get "id"]
      val type_ : t -> string [@@js.get "type"]
      val parentSession : t -> t or_undefined [@@js.get "parentSession"]
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]

      val workspaceFolder : t -> WorkspaceFolder.t or_undefined
      [@@js.get "workspaceFolder"]

      val configuration : t -> DebugConfiguration.t [@@js.get "configuration"]

      val getDebugProtocolBreakpoint
        :  t
        -> breakpoint:Breakpoint.t
        -> DebugProtocolBreakpoint.t or_undefined Promise.t
      [@@js.call "getDebugProtocolBreakpoint"]]

  let create
        ~id
        ~type_
        ?parentSession
        ~name
        ~workspaceFolder
        ~configuration
        ~customRequest
        ~getDebugProtocolBreakpoint
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "id" (Ojs.string_to_js id);
    Ojs.set_prop_ascii obj "type" (Ojs.string_to_js type_);
    iter_set obj "parentSession" t_to_js parentSession;
    Ojs.set_prop_ascii obj "name" (Ojs.string_to_js name);
    Ojs.set_prop_ascii
      obj
      "workspaceFolder"
      ((or_undefined_to_js WorkspaceFolder.t_to_js) workspaceFolder);
    Ojs.set_prop_ascii obj "configuration" (DebugConfiguration.t_to_js configuration);
    Ojs.set_prop_ascii
      obj
      "customRequest"
      ([%js.of: command:string -> ?args:Ojs.t -> unit -> Ojs.t Promise.t] customRequest);
    Ojs.set_prop_ascii
      obj
      "getDebugProtocolBreakpoint"
      ([%js.of:
         breakpoint:Breakpoint.t -> DebugProtocolBreakpoint.t or_undefined Promise.t]
         getDebugProtocolBreakpoint);
    t_of_js obj
  ;;
end

module DebugThread = struct
  include Class.Make ()

  include
    [%js:
      val session : t -> DebugSession.t [@@js.get "session"]
      val threadId : t -> int [@@js.get "threadId"]]
end

module DebugStackFrame = struct
  include Class.Make ()

  include
    [%js:
      val session : t -> DebugSession.t [@@js.get "session"]
      val threadId : t -> int [@@js.get "threadId"]
      val frameId : t -> int [@@js.get "frameId"]]
end

module DebugAdapterDescriptorFactory = struct
  include Interface.Make ()

  include
    [%js:
      val createDebugAdapterDescriptor
        :  t
        -> session:DebugSession.t
        -> executable:DebugAdapterExecutable.t or_undefined
        -> DebugAdapterDescriptor.t ProviderResult.t
      [@@js.call]]

  let create ~createDebugAdapterDescriptor () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "createDebugAdapterDescriptor"
      ([%js.of:
         session:DebugSession.t
         -> executable:DebugAdapterExecutable.t or_undefined
         -> DebugAdapterDescriptor.t ProviderResult.t]
         createDebugAdapterDescriptor);
    t_of_js obj
  ;;
end

module DebugConfigurationProvider = struct
  include Interface.Make ()

  let provideDebugConfigurations this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "provideDebugConfigurations" in
    if Ojs.is_null callback
    then None
    else
      Some
        ([%js.to:
           folder:WorkspaceFolder.t or_undefined
           -> ?token:CancellationToken.t
           -> unit
           -> DebugConfiguration.t list ProviderResult.t]
           (Ojs.call callback "bind" [| this |]))
  ;;

  let resolveDebugConfiguration this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "resolveDebugConfiguration" in
    if Ojs.is_null callback
    then None
    else
      Some
        ([%js.to:
           folder:WorkspaceFolder.t or_undefined
           -> debugConfiguration:DebugConfiguration.t
           -> ?token:CancellationToken.t
           -> unit
           -> DebugConfiguration.t ProviderResult.t]
           (Ojs.call callback "bind" [| this |]))
  ;;

  let resolveDebugConfigurationWithSubstitutedVariables this =
    let this = t_to_js this in
    let callback =
      Ojs.get_prop_ascii this "resolveDebugConfigurationWithSubstitutedVariables"
    in
    if Ojs.is_null callback
    then None
    else
      Some
        ([%js.to:
           folder:WorkspaceFolder.t or_undefined
           -> debugConfiguration:DebugConfiguration.t
           -> ?token:CancellationToken.t
           -> unit
           -> DebugConfiguration.t ProviderResult.t]
           (Ojs.call callback "bind" [| this |]))
  ;;

  let create
        ?provideDebugConfigurations
        ?resolveDebugConfiguration
        ?resolveDebugConfigurationWithSubstitutedVariables
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set
      obj
      "provideDebugConfigurations"
      [%js.of:
        folder:WorkspaceFolder.t or_undefined
        -> ?token:CancellationToken.t
        -> unit
        -> DebugConfiguration.t list ProviderResult.t]
      provideDebugConfigurations;
    iter_set
      obj
      "resolveDebugConfiguration"
      [%js.of:
        folder:WorkspaceFolder.t or_undefined
        -> debugConfiguration:DebugConfiguration.t
        -> ?token:CancellationToken.t
        -> unit
        -> DebugConfiguration.t ProviderResult.t]
      resolveDebugConfiguration;
    iter_set
      obj
      "resolveDebugConfigurationWithSubstitutedVariables"
      [%js.of:
        folder:WorkspaceFolder.t or_undefined
        -> debugConfiguration:DebugConfiguration.t
        -> ?token:CancellationToken.t
        -> unit
        -> DebugConfiguration.t ProviderResult.t]
      resolveDebugConfigurationWithSubstitutedVariables;
    t_of_js obj
  ;;
end

module DebugConfigurationProviderTriggerKind = struct
  type t =
    | Initial [@js 1]
    | Dynamic [@js 2]
  [@@js.enum] [@@js]
end

module DebugConsoleMode = struct
  type t =
    | Separate [@js 0]
    | MergeWithParent [@js 1]
  [@@js.enum] [@@js]
end

module TestMessageStackFrame = struct
  include Class.Make ()

  include
    [%js:
      val uri : t -> Uri.t or_undefined [@@js.get "uri"]
      val set_uri : t -> Uri.t or_undefined -> unit [@@js.set "uri"]
      val position : t -> Position.t or_undefined [@@js.get "position"]
      val set_position : t -> Position.t or_undefined -> unit [@@js.set "position"]
      val label : t -> string [@@js.get "label"]
      val set_label : t -> string -> unit [@@js.set "label"]]

  let make ~label ?uri ?position () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "TestMessageStackFrame")
         (binding_arguments
            [| Ojs.string_to_js label
             ; (or_undefined_to_js Uri.t_to_js) uri
             ; (or_undefined_to_js Position.t_to_js) position
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module TestMessage = struct
  include Class.Make ()

  type message =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let message_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let message_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else invalid_arg "TestMessage.message: unexpected JavaScript value"
  ;;

  include
    [%js:
      val message : t -> message [@@js.get "message"]
      val set_message : t -> message -> unit [@@js.set "message"]
      val expectedOutput : t -> string or_undefined [@@js.get "expectedOutput"]

      val set_expectedOutput : t -> string or_undefined -> unit
      [@@js.set "expectedOutput"]

      val actualOutput : t -> string or_undefined [@@js.get "actualOutput"]
      val set_actualOutput : t -> string or_undefined -> unit [@@js.set "actualOutput"]
      val location : t -> Location.t or_undefined [@@js.get "location"]
      val set_location : t -> Location.t or_undefined -> unit [@@js.set "location"]
      val contextValue : t -> string or_undefined [@@js.get "contextValue"]
      val set_contextValue : t -> string or_undefined -> unit [@@js.set "contextValue"]

      val stackTrace : t -> TestMessageStackFrame.t list or_undefined
      [@@js.get "stackTrace"]

      val set_stackTrace : t -> TestMessageStackFrame.t list or_undefined -> unit
      [@@js.set "stackTrace"]

      val diff : message:message -> expected:string -> actual:string -> t
      [@@js.global "@vscode.TestMessage.diff"]

      val make : message:message -> t [@@js.new "@vscode.TestMessage"]]
end

module TestTag = struct
  include Class.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val make : id:string -> t [@@js.new "@vscode.TestTag"]]
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
end = struct
  include Interface.Make ()

  type error =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let error_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let error_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else invalid_arg "TestItem.error: unexpected JavaScript value"
  ;;

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val uri : t -> Uri.t or_undefined [@@js.get "uri"]
      val children : t -> TestItemCollection.t [@@js.get "children"]
      val parent : t -> t or_undefined [@@js.get "parent"]
      val tags : t -> TestTag.t list [@@js.get "tags"]
      val set_tags : t -> TestTag.t list -> unit [@@js.set "tags"]
      val canResolveChildren : t -> bool [@@js.get "canResolveChildren"]
      val set_canResolveChildren : t -> bool -> unit [@@js.set "canResolveChildren"]
      val busy : t -> bool [@@js.get "busy"]
      val set_busy : t -> bool -> unit [@@js.set "busy"]
      val label : t -> string [@@js.get "label"]
      val set_label : t -> string -> unit [@@js.set "label"]
      val description : t -> string or_undefined [@@js.get "description"]
      val set_description : t -> string or_undefined -> unit [@@js.set "description"]
      val sortText : t -> string or_undefined [@@js.get "sortText"]
      val set_sortText : t -> string or_undefined -> unit [@@js.set "sortText"]
      val range : t -> Range.t or_undefined [@@js.get "range"]
      val set_range : t -> Range.t or_undefined -> unit [@@js.set "range"]
      val error : t -> error or_undefined [@@js.get "error"]
      val set_error : t -> error or_undefined -> unit [@@js.set "error"]]
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
end = struct
  include Interface.Make ()

  include
    [%js:
      val size : t -> int [@@js.get "size"]
      val replace : t -> items:TestItem.t list -> unit [@@js.call "replace"]]

  let forEach this ~callback ?thisArg () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "forEach"
         (binding_arguments
            [| [%js.of: item:TestItem.t -> collection:t -> Ojs.t] callback
             ; (or_undefined_to_js Ojs.t_to_js) thisArg
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val add : t -> item:TestItem.t -> unit [@@js.call "add"]
      val delete : t -> itemId:string -> unit [@@js.call "delete"]
      val get : t -> itemId:string -> TestItem.t or_undefined [@@js.call "get"]]

  let iterator this =
    let this = t_to_js this in
    let symbol = Ojs.get_prop_ascii (Ojs.get_prop_ascii Ojs.global "Symbol") "iterator" in
    IterableIterator.t_of_js
      (fun js_val ->
         ( Ojs.string_of_js (Ojs.array_get js_val 0)
         , TestItem.t_of_js (Ojs.array_get js_val 1) ))
      (Ojs.call (Ojs.get_prop this symbol) "call" [| this |])
  ;;
end

module TestCoverageCount = struct
  include Class.Make ()

  include
    [%js:
      val covered : t -> int [@@js.get "covered"]
      val set_covered : t -> int -> unit [@@js.set "covered"]
      val total : t -> int [@@js.get "total"]
      val set_total : t -> int -> unit [@@js.set "total"]
      val make : covered:int -> total:int -> t [@@js.new "@vscode.TestCoverageCount"]]
end

module BranchCoverage = struct
  include Class.Make ()

  type executed =
    [ `Int of int
    | `Bool of bool
    ]

  let executed_to_js = function
    | `Int value -> Ojs.int_to_js value
    | `Bool value -> Ojs.bool_to_js value
  ;;

  let executed_of_js js_val =
    if Ojs.type_of js_val = "number"
    then `Int (Ojs.int_of_js js_val)
    else if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else invalid_arg "BranchCoverage.executed: unexpected JavaScript value"
  ;;

  type location =
    [ `Position of Position.t
    | `Range of Range.t
    ]

  let location_to_js = function
    | `Position value -> Position.t_to_js value
    | `Range value -> Range.t_to_js value
  ;;

  let location_of_js js_val =
    match binding_constructor js_val [ "Position"; "Range" ] with
    | Some "Position" -> `Position (Position.t_of_js js_val)
    | Some "Range" -> `Range (Range.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "line"
        && binding_has_member js_val "character"
        && binding_has_member js_val "isBefore"
        && binding_has_member js_val "isBeforeOrEqual"
        && binding_has_member js_val "isAfter"
        && binding_has_member js_val "isAfterOrEqual"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "compareTo"
        && binding_has_member js_val "translate"
        && binding_has_member js_val "translate"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
      then `Position (Position.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "start"
        && binding_has_member js_val "end"
        && binding_has_member js_val "isEmpty"
        && binding_has_member js_val "isSingleLine"
        && binding_has_member js_val "contains"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "intersection"
        && binding_has_member js_val "union"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
      then `Range (Range.t_of_js js_val)
      else invalid_arg "BranchCoverage.location: unexpected JavaScript value"
  ;;

  include
    [%js:
      val executed : t -> executed [@@js.get "executed"]
      val set_executed : t -> executed -> unit [@@js.set "executed"]
      val location : t -> location or_undefined [@@js.get "location"]
      val set_location : t -> location or_undefined -> unit [@@js.set "location"]
      val label : t -> string or_undefined [@@js.get "label"]
      val set_label : t -> string or_undefined -> unit [@@js.set "label"]]

  let make ~executed ?location ?label () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "BranchCoverage")
         (binding_arguments
            [| executed_to_js executed
             ; (or_undefined_to_js location_to_js) location
             ; (or_undefined_to_js Ojs.string_to_js) label
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module StatementCoverage = struct
  include Class.Make ()

  type executed =
    [ `Int of int
    | `Bool of bool
    ]

  let executed_to_js = function
    | `Int value -> Ojs.int_to_js value
    | `Bool value -> Ojs.bool_to_js value
  ;;

  let executed_of_js js_val =
    if Ojs.type_of js_val = "number"
    then `Int (Ojs.int_of_js js_val)
    else if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else invalid_arg "StatementCoverage.executed: unexpected JavaScript value"
  ;;

  type location =
    [ `Position of Position.t
    | `Range of Range.t
    ]

  let location_to_js = function
    | `Position value -> Position.t_to_js value
    | `Range value -> Range.t_to_js value
  ;;

  let location_of_js js_val =
    match binding_constructor js_val [ "Position"; "Range" ] with
    | Some "Position" -> `Position (Position.t_of_js js_val)
    | Some "Range" -> `Range (Range.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "line"
        && binding_has_member js_val "character"
        && binding_has_member js_val "isBefore"
        && binding_has_member js_val "isBeforeOrEqual"
        && binding_has_member js_val "isAfter"
        && binding_has_member js_val "isAfterOrEqual"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "compareTo"
        && binding_has_member js_val "translate"
        && binding_has_member js_val "translate"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
      then `Position (Position.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "start"
        && binding_has_member js_val "end"
        && binding_has_member js_val "isEmpty"
        && binding_has_member js_val "isSingleLine"
        && binding_has_member js_val "contains"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "intersection"
        && binding_has_member js_val "union"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
      then `Range (Range.t_of_js js_val)
      else invalid_arg "StatementCoverage.location: unexpected JavaScript value"
  ;;

  include
    [%js:
      val executed : t -> executed [@@js.get "executed"]
      val set_executed : t -> executed -> unit [@@js.set "executed"]
      val location : t -> location [@@js.get "location"]
      val set_location : t -> location -> unit [@@js.set "location"]
      val branches : t -> BranchCoverage.t list [@@js.get "branches"]
      val set_branches : t -> BranchCoverage.t list -> unit [@@js.set "branches"]]

  let make ~executed ~location ?branches () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "StatementCoverage")
         (binding_arguments
            [| executed_to_js executed
             ; location_to_js location
             ; (or_undefined_to_js (Ojs.list_to_js BranchCoverage.t_to_js)) branches
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module DeclarationCoverage = struct
  include Class.Make ()

  type executed =
    [ `Int of int
    | `Bool of bool
    ]

  let executed_to_js = function
    | `Int value -> Ojs.int_to_js value
    | `Bool value -> Ojs.bool_to_js value
  ;;

  let executed_of_js js_val =
    if Ojs.type_of js_val = "number"
    then `Int (Ojs.int_of_js js_val)
    else if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else invalid_arg "DeclarationCoverage.executed: unexpected JavaScript value"
  ;;

  type location =
    [ `Position of Position.t
    | `Range of Range.t
    ]

  let location_to_js = function
    | `Position value -> Position.t_to_js value
    | `Range value -> Range.t_to_js value
  ;;

  let location_of_js js_val =
    match binding_constructor js_val [ "Position"; "Range" ] with
    | Some "Position" -> `Position (Position.t_of_js js_val)
    | Some "Range" -> `Range (Range.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "line"
        && binding_has_member js_val "character"
        && binding_has_member js_val "isBefore"
        && binding_has_member js_val "isBeforeOrEqual"
        && binding_has_member js_val "isAfter"
        && binding_has_member js_val "isAfterOrEqual"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "compareTo"
        && binding_has_member js_val "translate"
        && binding_has_member js_val "translate"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
      then `Position (Position.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "start"
        && binding_has_member js_val "end"
        && binding_has_member js_val "isEmpty"
        && binding_has_member js_val "isSingleLine"
        && binding_has_member js_val "contains"
        && binding_has_member js_val "isEqual"
        && binding_has_member js_val "intersection"
        && binding_has_member js_val "union"
        && binding_has_member js_val "with"
        && binding_has_member js_val "with"
      then `Range (Range.t_of_js js_val)
      else invalid_arg "DeclarationCoverage.location: unexpected JavaScript value"
  ;;

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val executed : t -> executed [@@js.get "executed"]
      val set_executed : t -> executed -> unit [@@js.set "executed"]
      val location : t -> location [@@js.get "location"]
      val set_location : t -> location -> unit [@@js.set "location"]

      val make : name:string -> executed:executed -> location:location -> t
      [@@js.new "@vscode.DeclarationCoverage"]]
end

module FileCoverageDetail = struct
  type value =
    [ `StatementCoverage of StatementCoverage.t
    | `DeclarationCoverage of DeclarationCoverage.t
    ]

  let value_to_js = function
    | `StatementCoverage value -> StatementCoverage.t_to_js value
    | `DeclarationCoverage value -> DeclarationCoverage.t_to_js value
  ;;

  let value_of_js js_val =
    match binding_constructor js_val [ "StatementCoverage"; "DeclarationCoverage" ] with
    | Some "StatementCoverage" -> `StatementCoverage (StatementCoverage.t_of_js js_val)
    | Some "DeclarationCoverage" ->
      `DeclarationCoverage (DeclarationCoverage.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "executed"
        && binding_has_member js_val "location"
        && binding_has_member js_val "branches"
      then `StatementCoverage (StatementCoverage.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "name"
        && binding_has_member js_val "executed"
        && binding_has_member js_val "location"
      then `DeclarationCoverage (DeclarationCoverage.t_of_js js_val)
      else invalid_arg "FileCoverageDetail.value: unexpected JavaScript value"
  ;;

  type t = value

  let t_to_js = value_to_js
  let t_of_js = value_of_js
end

module FileCoverage = struct
  include Class.Make ()

  include
    [%js:
      val uri : t -> Uri.t [@@js.get "uri"]
      val statementCoverage : t -> TestCoverageCount.t [@@js.get "statementCoverage"]

      val set_statementCoverage : t -> TestCoverageCount.t -> unit
      [@@js.set "statementCoverage"]

      val branchCoverage : t -> TestCoverageCount.t or_undefined
      [@@js.get "branchCoverage"]

      val set_branchCoverage : t -> TestCoverageCount.t or_undefined -> unit
      [@@js.set "branchCoverage"]

      val declarationCoverage : t -> TestCoverageCount.t or_undefined
      [@@js.get "declarationCoverage"]

      val set_declarationCoverage : t -> TestCoverageCount.t or_undefined -> unit
      [@@js.set "declarationCoverage"]

      val includesTests : t -> TestItem.t list or_undefined [@@js.get "includesTests"]

      val set_includesTests : t -> TestItem.t list or_undefined -> unit
      [@@js.set "includesTests"]

      val fromDetails : uri:Uri.t -> details:FileCoverageDetail.t list -> t
      [@@js.global "@vscode.FileCoverage.fromDetails"]]

  let make ~uri ~statementCoverage ?branchCoverage ?declarationCoverage ?includesTests () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "FileCoverage")
         (binding_arguments
            [| Uri.t_to_js uri
             ; TestCoverageCount.t_to_js statementCoverage
             ; (or_undefined_to_js TestCoverageCount.t_to_js) branchCoverage
             ; (or_undefined_to_js TestCoverageCount.t_to_js) declarationCoverage
             ; (or_undefined_to_js (Ojs.list_to_js TestItem.t_to_js)) includesTests
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module TestRun = struct
  include Interface.Make ()

  type failed_message =
    [ `TestMessage of TestMessage.t
    | `Items of TestMessage.t list
    ]

  let failed_message_to_js = function
    | `TestMessage value -> TestMessage.t_to_js value
    | `Items value -> (Ojs.list_to_js TestMessage.t_to_js) value
  ;;

  let failed_message_of_js js_val =
    match binding_constructor js_val [ "TestMessage" ] with
    | Some "TestMessage" -> `TestMessage (TestMessage.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "message"
      then `TestMessage (TestMessage.t_of_js js_val)
      else if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            Ojs.type_of js_val = "object"
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "message")
      then `Items ((Ojs.list_of_js TestMessage.t_of_js) js_val)
      else invalid_arg "TestRun.failed_message: unexpected JavaScript value"
  ;;

  include
    [%js:
      val name : t -> string or_undefined [@@js.get "name"]
      val token : t -> CancellationToken.t [@@js.get "token"]
      val isPersisted : t -> bool [@@js.get "isPersisted"]
      val enqueued : t -> test:TestItem.t -> unit [@@js.call "enqueued"]
      val started : t -> test:TestItem.t -> unit [@@js.call "started"]
      val skipped : t -> test:TestItem.t -> unit [@@js.call "skipped"]]

  let failed this ~test ~message ?duration () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "failed"
         (binding_arguments
            [| TestItem.t_to_js test
             ; failed_message_to_js message
             ; (or_undefined_to_js Ojs.float_to_js) duration
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let errored this ~test ~message ?duration () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "errored"
         (binding_arguments
            [| TestItem.t_to_js test
             ; failed_message_to_js message
             ; (or_undefined_to_js Ojs.float_to_js) duration
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let passed this ~test ?duration () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "passed"
         (binding_arguments
            [| TestItem.t_to_js test; (or_undefined_to_js Ojs.float_to_js) duration |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let appendOutput this ~output ?location ?test () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "appendOutput"
         (binding_arguments
            [| Ojs.string_to_js output
             ; (or_undefined_to_js Location.t_to_js) location
             ; (or_undefined_to_js TestItem.t_to_js) test
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val addCoverage : t -> fileCoverage:FileCoverage.t -> unit [@@js.call "addCoverage"]
      val end_ : t -> unit [@@js.call "end"]
      val onDidDispose : t -> unit Event.t [@@js.get "onDidDispose"]]
end

module DebugSessionOptions = struct
  include Interface.Make ()

  include
    [%js:
      val parentSession : t -> DebugSession.t or_undefined [@@js.get "parentSession"]

      val set_parentSession : t -> DebugSession.t or_undefined -> unit
      [@@js.set "parentSession"]

      val lifecycleManagedByParent : t -> bool or_undefined
      [@@js.get "lifecycleManagedByParent"]

      val set_lifecycleManagedByParent : t -> bool or_undefined -> unit
      [@@js.set "lifecycleManagedByParent"]

      val consoleMode : t -> DebugConsoleMode.t or_undefined [@@js.get "consoleMode"]

      val set_consoleMode : t -> DebugConsoleMode.t or_undefined -> unit
      [@@js.set "consoleMode"]

      val noDebug : t -> bool or_undefined [@@js.get "noDebug"]
      val set_noDebug : t -> bool or_undefined -> unit [@@js.set "noDebug"]
      val compact : t -> bool or_undefined [@@js.get "compact"]
      val set_compact : t -> bool or_undefined -> unit [@@js.set "compact"]

      val suppressSaveBeforeStart : t -> bool or_undefined
      [@@js.get "suppressSaveBeforeStart"]

      val set_suppressSaveBeforeStart : t -> bool or_undefined -> unit
      [@@js.set "suppressSaveBeforeStart"]

      val suppressDebugToolbar : t -> bool or_undefined [@@js.get "suppressDebugToolbar"]

      val set_suppressDebugToolbar : t -> bool or_undefined -> unit
      [@@js.set "suppressDebugToolbar"]

      val suppressDebugStatusbar : t -> bool or_undefined
      [@@js.get "suppressDebugStatusbar"]

      val set_suppressDebugStatusbar : t -> bool or_undefined -> unit
      [@@js.set "suppressDebugStatusbar"]

      val suppressDebugView : t -> bool or_undefined [@@js.get "suppressDebugView"]

      val set_suppressDebugView : t -> bool or_undefined -> unit
      [@@js.set "suppressDebugView"]

      val testRun : t -> TestRun.t or_undefined [@@js.get "testRun"]
      val set_testRun : t -> TestRun.t or_undefined -> unit [@@js.set "testRun"]]

  let create
        ?parentSession
        ?lifecycleManagedByParent
        ?consoleMode
        ?noDebug
        ?compact
        ?suppressSaveBeforeStart
        ?suppressDebugToolbar
        ?suppressDebugStatusbar
        ?suppressDebugView
        ?testRun
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set obj "parentSession" DebugSession.t_to_js parentSession;
    iter_set obj "lifecycleManagedByParent" Ojs.bool_to_js lifecycleManagedByParent;
    iter_set obj "consoleMode" DebugConsoleMode.t_to_js consoleMode;
    iter_set obj "noDebug" Ojs.bool_to_js noDebug;
    iter_set obj "compact" Ojs.bool_to_js compact;
    iter_set obj "suppressSaveBeforeStart" Ojs.bool_to_js suppressSaveBeforeStart;
    iter_set obj "suppressDebugToolbar" Ojs.bool_to_js suppressDebugToolbar;
    iter_set obj "suppressDebugStatusbar" Ojs.bool_to_js suppressDebugStatusbar;
    iter_set obj "suppressDebugView" Ojs.bool_to_js suppressDebugView;
    iter_set obj "testRun" TestRun.t_to_js testRun;
    t_of_js obj
  ;;
end

module DebugConsole = struct
  include Interface.Make ()

  include
    [%js:
      val append : t -> value:string -> unit [@@js.call "append"]
      val appendLine : t -> value:string -> unit [@@js.call "appendLine"]]

  let create ~append ~appendLine () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "append" ([%js.of: value:string -> unit] append);
    Ojs.set_prop_ascii obj "appendLine" ([%js.of: value:string -> unit] appendLine);
    t_of_js obj
  ;;
end

module DebugSessionCustomEvent = struct
  include Interface.Make ()

  include
    [%js:
      val session : t -> DebugSession.t [@@js.get "session"]
      val event : t -> string [@@js.get "event"]
      val body : t -> Ojs.t [@@js.get "body"]]

  let create ~session ~event ~body () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "session" (DebugSession.t_to_js session);
    Ojs.set_prop_ascii obj "event" (Ojs.string_to_js event);
    Ojs.set_prop_ascii obj "body" (Ojs.t_to_js body);
    t_of_js obj
  ;;
end

module BreakpointsChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val added : t -> Breakpoint.t list [@@js.get "added"]
      val removed : t -> Breakpoint.t list [@@js.get "removed"]
      val changed : t -> Breakpoint.t list [@@js.get "changed"]]

  let create ~added ~removed ~changed () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "added" ((Ojs.list_to_js Breakpoint.t_to_js) added);
    Ojs.set_prop_ascii obj "removed" ((Ojs.list_to_js Breakpoint.t_to_js) removed);
    Ojs.set_prop_ascii obj "changed" ((Ojs.list_to_js Breakpoint.t_to_js) changed);
    t_of_js obj
  ;;
end

module DebugAdapterTracker = struct
  include Interface.Make ()

  let onWillStartSession this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "onWillStartSession" in
    if Ojs.is_null callback
    then None
    else Some ([%js.to: unit -> unit] (Ojs.call callback "bind" [| this |]))
  ;;

  let onWillReceiveMessage this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "onWillReceiveMessage" in
    if Ojs.is_null callback
    then None
    else Some ([%js.to: message:Ojs.t -> unit] (Ojs.call callback "bind" [| this |]))
  ;;

  let onDidSendMessage this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "onDidSendMessage" in
    if Ojs.is_null callback
    then None
    else Some ([%js.to: message:Ojs.t -> unit] (Ojs.call callback "bind" [| this |]))
  ;;

  let onWillStopSession this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "onWillStopSession" in
    if Ojs.is_null callback
    then None
    else Some ([%js.to: unit -> unit] (Ojs.call callback "bind" [| this |]))
  ;;

  let onError this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "onError" in
    if Ojs.is_null callback
    then None
    else Some ([%js.to: error:JsError.t -> unit] (Ojs.call callback "bind" [| this |]))
  ;;

  let onExit this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "onExit" in
    if Ojs.is_null callback
    then None
    else
      Some
        ([%js.to: code:int or_undefined -> signal:string or_undefined -> unit]
           (Ojs.call callback "bind" [| this |]))
  ;;

  let create
        ?onWillStartSession
        ?onWillReceiveMessage
        ?onDidSendMessage
        ?onWillStopSession
        ?onError
        ?onExit
        ()
    =
    let obj = Ojs.obj [||] in
    iter_set obj "onWillStartSession" [%js.of: unit -> unit] onWillStartSession;
    iter_set
      obj
      "onWillReceiveMessage"
      [%js.of: message:Ojs.t -> unit]
      onWillReceiveMessage;
    iter_set obj "onDidSendMessage" [%js.of: message:Ojs.t -> unit] onDidSendMessage;
    iter_set obj "onWillStopSession" [%js.of: unit -> unit] onWillStopSession;
    iter_set obj "onError" [%js.of: error:JsError.t -> unit] onError;
    iter_set
      obj
      "onExit"
      [%js.of: code:int or_undefined -> signal:string or_undefined -> unit]
      onExit;
    t_of_js obj
  ;;
end

module DebugAdapterTrackerFactory = struct
  include Interface.Make ()

  include
    [%js:
      val createDebugAdapterTracker
        :  t
        -> session:DebugSession.t
        -> DebugAdapterTracker.t ProviderResult.t
      [@@js.call "createDebugAdapterTracker"]]

  let create ~createDebugAdapterTracker () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "createDebugAdapterTracker"
      ([%js.of: session:DebugSession.t -> DebugAdapterTracker.t ProviderResult.t]
         createDebugAdapterTracker);
    t_of_js obj
  ;;
end

module DebugProtocolSource = struct
  include Interface.Make ()
end

module Debug = struct
  type active_stack_item =
    [ `DebugThread of DebugThread.t
    | `DebugStackFrame of DebugStackFrame.t
    ]

  let active_stack_item_to_js = function
    | `DebugThread value -> DebugThread.t_to_js value
    | `DebugStackFrame value -> DebugStackFrame.t_to_js value
  ;;

  let active_stack_item_of_js js_val =
    match binding_constructor js_val [ "DebugThread"; "DebugStackFrame" ] with
    | Some "DebugThread" -> `DebugThread (DebugThread.t_of_js js_val)
    | Some "DebugStackFrame" -> `DebugStackFrame (DebugStackFrame.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "session"
        && binding_has_member js_val "threadId"
      then `DebugThread (DebugThread.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "session"
        && binding_has_member js_val "threadId"
        && binding_has_member js_val "frameId"
      then `DebugStackFrame (DebugStackFrame.t_of_js js_val)
      else invalid_arg "Debug.active_stack_item: unexpected JavaScript value"
  ;;

  type start_debugging_with_options_name_or_configuration =
    [ `String of string
    | `DebugConfiguration of DebugConfiguration.t
    ]

  let start_debugging_with_options_name_or_configuration_to_js = function
    | `String value -> Ojs.string_to_js value
    | `DebugConfiguration value -> DebugConfiguration.t_to_js value
  ;;

  let start_debugging_with_options_name_or_configuration_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "type"
      && binding_has_member js_val "name"
      && binding_has_member js_val "request"
    then `DebugConfiguration (DebugConfiguration.t_of_js js_val)
    else
      invalid_arg
        "Debug.start_debugging_with_options_name_or_configuration: unexpected JavaScript \
         value"
  ;;

  type start_debugging_with_options_parent_session_or_options =
    [ `DebugSession of DebugSession.t
    | `DebugSessionOptions of DebugSessionOptions.t
    ]

  let start_debugging_with_options_parent_session_or_options_to_js = function
    | `DebugSession value -> DebugSession.t_to_js value
    | `DebugSessionOptions value -> DebugSessionOptions.t_to_js value
  ;;

  let start_debugging_with_options_parent_session_or_options_of_js js_val =
    if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "id"
      && binding_has_member js_val "type"
      && binding_has_member js_val "name"
      && binding_has_member js_val "workspaceFolder"
      && binding_has_member js_val "configuration"
      && binding_has_member js_val "customRequest"
      && binding_has_member js_val "getDebugProtocolBreakpoint"
    then `DebugSession (DebugSession.t_of_js js_val)
    else if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then `DebugSessionOptions (DebugSessionOptions.t_of_js js_val)
    else
      invalid_arg
        "Debug.start_debugging_with_options_parent_session_or_options: unexpected \
         JavaScript value"
  ;;

  type stackItem =
    ([ `Thread of DebugThread.t
     | `StackFrame of DebugStackFrame.t
     ]
    [@js.union])
  [@@js]

  let stackItem_of_js js_val =
    if binding_has_member js_val "frameId"
    then `StackFrame (DebugStackFrame.t_of_js js_val)
    else `Thread (DebugThread.t_of_js js_val)
  ;;

  include
    [%js:
      val activeStackItem : unit -> active_stack_item or_undefined
      [@@js.get "@vscode.debug.activeStackItem"]

      val onDidChangeActiveStackItem : unit -> active_stack_item or_undefined Event.t
      [@@js.get "@vscode.debug.onDidChangeActiveStackItem"]

      val activeDebugSession : unit -> DebugSession.t or_undefined
      [@@js.get "@vscode.debug.activeDebugSession"]

      val registerDebugAdapterDescriptorFactory
        :  debugType:string
        -> factory:DebugAdapterDescriptorFactory.t
        -> Disposable.t
      [@@js.global "@vscode.debug.registerDebugAdapterDescriptorFactory"]

      val registerDebugConfigurationProvider
        :  debugType:string
        -> provider:DebugConfigurationProvider.t
        -> ?triggerKind:DebugConfigurationProviderTriggerKind.t
        -> unit
        -> Disposable.t
      [@@js.global "@vscode.debug.registerDebugConfigurationProvider"]

      val startDebugging
        :  folder:WorkspaceFolder.t or_undefined
        -> nameOrConfiguration:
             ([ `Name of string | `Configuration of DebugConfiguration.t ][@js.union])
        -> ?parentSessionOrOptions:Ojs.t
        -> unit
        -> bool Promise.t
      [@@js.global "@vscode.debug.startDebugging"]

      val activeDebugConsole : unit -> DebugConsole.t
      [@@js.get "@vscode.debug.activeDebugConsole"]

      val breakpoints : unit -> Breakpoint.t list [@@js.get "@vscode.debug.breakpoints"]

      val onDidChangeActiveDebugSession : unit -> DebugSession.t or_undefined Event.t
      [@@js.get "@vscode.debug.onDidChangeActiveDebugSession"]

      val onDidStartDebugSession : unit -> DebugSession.t Event.t
      [@@js.get "@vscode.debug.onDidStartDebugSession"]

      val onDidReceiveDebugSessionCustomEvent : unit -> DebugSessionCustomEvent.t Event.t
      [@@js.get "@vscode.debug.onDidReceiveDebugSessionCustomEvent"]

      val onDidTerminateDebugSession : unit -> DebugSession.t Event.t
      [@@js.get "@vscode.debug.onDidTerminateDebugSession"]

      val onDidChangeBreakpoints : unit -> BreakpointsChangeEvent.t Event.t
      [@@js.get "@vscode.debug.onDidChangeBreakpoints"]

      val registerDebugAdapterTrackerFactory
        :  debugType:string
        -> factory:DebugAdapterTrackerFactory.t
        -> Disposable.t
      [@@js.global "@vscode.debug.registerDebugAdapterTrackerFactory"]]

  let startDebuggingWithOptions ~folder ~nameOrConfiguration ?parentSessionOrOptions () =
    (Promise.t_of_js Ojs.bool_of_js)
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "debug")
         "startDebugging"
         (binding_arguments
            [| (or_undefined_to_js WorkspaceFolder.t_to_js) folder
             ; start_debugging_with_options_name_or_configuration_to_js
                 nameOrConfiguration
             ; (or_undefined_to_js
                  start_debugging_with_options_parent_session_or_options_to_js)
                 parentSessionOrOptions
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let stopDebugging ?session () =
    (Promise.t_of_js (fun _ -> ()))
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "debug")
         "stopDebugging"
         (binding_arguments
            [| (or_undefined_to_js DebugSession.t_to_js) session |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val addBreakpoints : breakpoints:Breakpoint.t list -> unit
      [@@js.global "@vscode.debug.addBreakpoints"]

      val removeBreakpoints : breakpoints:Breakpoint.t list -> unit
      [@@js.global "@vscode.debug.removeBreakpoints"]]

  let asDebugSourceUri ~source ?session () =
    Uri.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "debug")
         "asDebugSourceUri"
         (binding_arguments
            [| DebugProtocolSource.t_to_js source
             ; (or_undefined_to_js DebugSession.t_to_js) session
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module CancellationTokenSource = struct
  include Class.Make ()

  include
    [%js:
      val token : t -> CancellationToken.t [@@js.get "token"]
      val set_token : t -> CancellationToken.t -> unit [@@js.set "token"]
      val cancel : t -> unit [@@js.call "cancel"]
      val dispose : t -> unit [@@js.call "dispose"]
      val make : unit -> t [@@js.new "@vscode.CancellationTokenSource"]]
end

module CancellationError = struct
  include Interface.Extend (JsError) ()

  let to_js_error (value : t) = (value :> JsError.t)

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val message : t -> string [@@js.get "message"]
      val set_message : t -> string -> unit [@@js.set "message"]
      val stack : t -> string or_undefined [@@js.get "stack"]
      val set_stack : t -> string or_undefined -> unit [@@js.set "stack"]
      val cause : t -> Ojs.t or_undefined [@@js.get "cause"]
      val set_cause : t -> Ojs.t or_undefined -> unit [@@js.set "cause"]
      val make : unit -> t [@@js.new "@vscode.CancellationError"]]
end

module SemanticTokensBuilder = struct
  include Class.Make ()

  let make ?legend () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "SemanticTokensBuilder")
         (binding_arguments
            [| (or_undefined_to_js SemanticTokensLegend.t_to_js) legend |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let push this ~line ~char ~length ~tokenType ?tokenModifiers () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "push"
         (binding_arguments
            [| Ojs.int_to_js line
             ; Ojs.int_to_js char
             ; Ojs.int_to_js length
             ; Ojs.int_to_js tokenType
             ; (or_undefined_to_js Ojs.int_to_js) tokenModifiers
            |]
            4
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let pushRange this ~range ~tokenType ?tokenModifiers () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "push"
         (binding_arguments
            [| Range.t_to_js range
             ; Ojs.string_to_js tokenType
             ; (or_undefined_to_js (Ojs.list_to_js Ojs.string_to_js)) tokenModifiers
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let build this ?resultId () =
    SemanticTokens.t_of_js
      (Ojs.call
         (t_to_js this)
         "build"
         (binding_arguments
            [| (or_undefined_to_js Ojs.string_to_js) resultId |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module FileSystemError = struct
  include Interface.Extend (JsError) ()

  type file_not_found_message_or_uri =
    [ `String of string
    | `Uri of Uri.t
    ]

  let file_not_found_message_or_uri_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Uri value -> Uri.t_to_js value
  ;;

  let file_not_found_message_or_uri_of_js js_val =
    match binding_constructor js_val [ "Uri" ] with
    | Some "Uri" -> `Uri (Uri.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "scheme"
        && binding_has_member js_val "authority"
        && binding_has_member js_val "path"
        && binding_has_member js_val "query"
        && binding_has_member js_val "fragment"
        && binding_has_member js_val "fsPath"
        && binding_has_member js_val "with"
        && binding_has_member js_val "toString"
        && binding_has_member js_val "toJSON"
      then `Uri (Uri.t_of_js js_val)
      else
        invalid_arg
          "FileSystemError.file_not_found_message_or_uri: unexpected JavaScript value"
  ;;

  let to_js_error (value : t) = (value :> JsError.t)

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val message : t -> string [@@js.get "message"]
      val set_message : t -> string -> unit [@@js.set "message"]
      val stack : t -> string or_undefined [@@js.get "stack"]
      val set_stack : t -> string or_undefined -> unit [@@js.set "stack"]
      val cause : t -> Ojs.t or_undefined [@@js.get "cause"]
      val set_cause : t -> Ojs.t or_undefined -> unit [@@js.set "cause"]]

  let fileNotFound ?messageOrUri () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "FileSystemError")
         "FileNotFound"
         (binding_arguments
            [| (or_undefined_to_js file_not_found_message_or_uri_to_js) messageOrUri |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let fileExists ?messageOrUri () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "FileSystemError")
         "FileExists"
         (binding_arguments
            [| (or_undefined_to_js file_not_found_message_or_uri_to_js) messageOrUri |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let fileNotADirectory ?messageOrUri () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "FileSystemError")
         "FileNotADirectory"
         (binding_arguments
            [| (or_undefined_to_js file_not_found_message_or_uri_to_js) messageOrUri |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let fileIsADirectory ?messageOrUri () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "FileSystemError")
         "FileIsADirectory"
         (binding_arguments
            [| (or_undefined_to_js file_not_found_message_or_uri_to_js) messageOrUri |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let noPermissions ?messageOrUri () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "FileSystemError")
         "NoPermissions"
         (binding_arguments
            [| (or_undefined_to_js file_not_found_message_or_uri_to_js) messageOrUri |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let unavailable ?messageOrUri () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "FileSystemError")
         "Unavailable"
         (binding_arguments
            [| (or_undefined_to_js file_not_found_message_or_uri_to_js) messageOrUri |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let make ?messageOrUri () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "FileSystemError")
         (binding_arguments
            [| (or_undefined_to_js file_not_found_message_or_uri_to_js) messageOrUri |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include [%js: val code : t -> string [@@js.get "code"]]
end

module NotebookRendererMessaging = struct
  include Interface.Make ()

  type on_did_receive_message_t =
    { editor : NotebookEditor.t
    ; message : Ojs.t
    }

  let on_did_receive_message_t_to_js (value : on_did_receive_message_t) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "editor" (NotebookEditor.t_to_js value.editor);
    Ojs.set_prop_ascii js_val "message" (Ojs.t_to_js value.message);
    js_val
  ;;

  let on_did_receive_message_t_of_js js_val : on_did_receive_message_t =
    { editor = NotebookEditor.t_of_js (Ojs.get_prop_ascii js_val "editor")
    ; message = Ojs.t_of_js (Ojs.get_prop_ascii js_val "message")
    }
  ;;

  include
    [%js:
      val onDidReceiveMessage : t -> on_did_receive_message_t Event.t
      [@@js.get "onDidReceiveMessage"]]

  let postMessage this ~message ?editor () =
    (Promise.t_of_js Ojs.bool_of_js)
      (Ojs.call
         (t_to_js this)
         "postMessage"
         (binding_arguments
            [| Ojs.t_to_js message; (or_undefined_to_js NotebookEditor.t_to_js) editor |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let create ~onDidReceiveMessage ~postMessage () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "onDidReceiveMessage"
      ((Event.t_to_js on_did_receive_message_t_to_js) onDidReceiveMessage);
    Ojs.set_prop_ascii
      obj
      "postMessage"
      ([%js.of: message:Ojs.t -> ?editor:NotebookEditor.t -> unit -> bool Promise.t]
         postMessage);
    t_of_js obj
  ;;
end

module NotebookControllerAffinity = struct
  type t =
    | Default [@js 1]
    | Preferred [@js 2]
  [@@js.enum] [@@js]
end

module NotebookCellExecution = struct
  include Interface.Make ()

  type replace_output_out =
    [ `NotebookCellOutput of NotebookCellOutput.t
    | `Items of NotebookCellOutput.t list
    ]

  let replace_output_out_to_js = function
    | `NotebookCellOutput value -> NotebookCellOutput.t_to_js value
    | `Items value -> (Ojs.list_to_js NotebookCellOutput.t_to_js) value
  ;;

  let replace_output_out_of_js js_val =
    match binding_constructor js_val [ "NotebookCellOutput" ] with
    | Some "NotebookCellOutput" -> `NotebookCellOutput (NotebookCellOutput.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "items"
      then `NotebookCellOutput (NotebookCellOutput.t_of_js js_val)
      else if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            Ojs.type_of js_val = "object"
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "items")
      then `Items ((Ojs.list_of_js NotebookCellOutput.t_of_js) js_val)
      else
        invalid_arg
          "NotebookCellExecution.replace_output_out: unexpected JavaScript value"
  ;;

  type replace_output_items =
    [ `NotebookCellOutputItem of NotebookCellOutputItem.t
    | `Items of NotebookCellOutputItem.t list
    ]

  let replace_output_items_to_js = function
    | `NotebookCellOutputItem value -> NotebookCellOutputItem.t_to_js value
    | `Items value -> (Ojs.list_to_js NotebookCellOutputItem.t_to_js) value
  ;;

  let replace_output_items_of_js js_val =
    match binding_constructor js_val [ "NotebookCellOutputItem" ] with
    | Some "NotebookCellOutputItem" ->
      `NotebookCellOutputItem (NotebookCellOutputItem.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "mime"
        && binding_has_member js_val "data"
      then `NotebookCellOutputItem (NotebookCellOutputItem.t_of_js js_val)
      else if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            Ojs.type_of js_val = "object"
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "mime"
            && binding_has_member js_val "data")
      then `Items ((Ojs.list_of_js NotebookCellOutputItem.t_of_js) js_val)
      else
        invalid_arg
          "NotebookCellExecution.replace_output_items: unexpected JavaScript value"
  ;;

  include
    [%js:
      val cell : t -> NotebookCell.t [@@js.get "cell"]
      val token : t -> CancellationToken.t [@@js.get "token"]
      val executionOrder : t -> int or_undefined [@@js.get "executionOrder"]
      val set_executionOrder : t -> int or_undefined -> unit [@@js.set "executionOrder"]]

  let start this ?startTime () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "start"
         (binding_arguments
            [| (or_undefined_to_js Ojs.float_to_js) startTime |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let end_ this ~success ?endTime () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "end"
         (binding_arguments
            [| (or_undefined_to_js Ojs.bool_to_js) success
             ; (or_undefined_to_js Ojs.float_to_js) endTime
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let clearOutput this ?cell () =
    (Promise.t_of_js (fun _ -> ()))
      (Ojs.call
         (t_to_js this)
         "clearOutput"
         (binding_arguments
            [| (or_undefined_to_js NotebookCell.t_to_js) cell |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let replaceOutput this ~out ?cell () =
    (Promise.t_of_js (fun _ -> ()))
      (Ojs.call
         (t_to_js this)
         "replaceOutput"
         (binding_arguments
            [| replace_output_out_to_js out
             ; (or_undefined_to_js NotebookCell.t_to_js) cell
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let appendOutput this ~out ?cell () =
    (Promise.t_of_js (fun _ -> ()))
      (Ojs.call
         (t_to_js this)
         "appendOutput"
         (binding_arguments
            [| replace_output_out_to_js out
             ; (or_undefined_to_js NotebookCell.t_to_js) cell
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val replaceOutputItems
        :  t
        -> items:replace_output_items
        -> output:NotebookCellOutput.t
        -> unit Promise.t
      [@@js.call "replaceOutputItems"]

      val appendOutputItems
        :  t
        -> items:replace_output_items
        -> output:NotebookCellOutput.t
        -> unit Promise.t
      [@@js.call "appendOutputItems"]]
end

module NotebookController = struct
  include Interface.Make ()

  type execute_handler_result =
    [ `Unit of unit
    | `Promise of unit Promise.t
    ]

  let execute_handler_result_to_js = function
    | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
    | `Promise value ->
      (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
  ;;

  let execute_handler_result_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
    else if Ojs.is_null js_val
    then `Unit ((fun _ -> ()) js_val)
    else
      invalid_arg "NotebookController.execute_handler_result: unexpected JavaScript value"
  ;;

  type on_did_change_selected_notebooks_t =
    { notebook : NotebookDocument.t
    ; selected : bool
    }

  let on_did_change_selected_notebooks_t_to_js
        (value : on_did_change_selected_notebooks_t)
    =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "notebook" (NotebookDocument.t_to_js value.notebook);
    Ojs.set_prop_ascii js_val "selected" (Ojs.bool_to_js value.selected);
    js_val
  ;;

  let on_did_change_selected_notebooks_t_of_js js_val : on_did_change_selected_notebooks_t
    =
    { notebook = NotebookDocument.t_of_js (Ojs.get_prop_ascii js_val "notebook")
    ; selected = Ojs.bool_of_js (Ojs.get_prop_ascii js_val "selected")
    }
  ;;

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val notebookType : t -> string [@@js.get "notebookType"]

      val supportedLanguages : t -> string list or_undefined
      [@@js.get "supportedLanguages"]

      val set_supportedLanguages : t -> string list or_undefined -> unit
      [@@js.set "supportedLanguages"]

      val label : t -> string [@@js.get "label"]
      val set_label : t -> string -> unit [@@js.set "label"]
      val description : t -> string or_undefined [@@js.get "description"]
      val set_description : t -> string or_undefined -> unit [@@js.set "description"]
      val detail : t -> string or_undefined [@@js.get "detail"]
      val set_detail : t -> string or_undefined -> unit [@@js.set "detail"]

      val supportsExecutionOrder : t -> bool or_undefined
      [@@js.get "supportsExecutionOrder"]

      val set_supportsExecutionOrder : t -> bool or_undefined -> unit
      [@@js.set "supportsExecutionOrder"]

      val createNotebookCellExecution
        :  t
        -> cell:NotebookCell.t
        -> NotebookCellExecution.t
      [@@js.call "createNotebookCellExecution"]]

  let executeHandler this =
    [%js.to:
      cells:NotebookCell.t list
      -> notebook:NotebookDocument.t
      -> controller:t
      -> execute_handler_result]
      (Ojs.get_prop_ascii (t_to_js this) "executeHandler")
  ;;

  include
    [%js:
      val set_executeHandler
        :  t
        -> (cells:NotebookCell.t list
            -> notebook:NotebookDocument.t
            -> controller:t
            -> execute_handler_result)
        -> unit
      [@@js.set "executeHandler"]]

  let interruptHandler this =
    (or_undefined_of_js [%js.to: notebook:NotebookDocument.t -> execute_handler_result])
      (Ojs.get_prop_ascii (t_to_js this) "interruptHandler")
  ;;

  include
    [%js:
      val set_interruptHandler
        :  t
        -> (notebook:NotebookDocument.t -> execute_handler_result) or_undefined
        -> unit
      [@@js.set "interruptHandler"]

      val onDidChangeSelectedNotebooks : t -> on_did_change_selected_notebooks_t Event.t
      [@@js.get "onDidChangeSelectedNotebooks"]

      val updateNotebookAffinity
        :  t
        -> notebook:NotebookDocument.t
        -> affinity:NotebookControllerAffinity.t
        -> unit
      [@@js.call "updateNotebookAffinity"]

      val dispose : t -> unit [@@js.call "dispose"]]
end

module NotebookCellStatusBarAlignment = struct
  type t =
    | Left [@js 1]
    | Right [@js 2]
  [@@js.enum] [@@js]
end

module NotebookCellStatusBarItem = struct
  include Class.Make ()

  type command =
    [ `String of string
    | `Command of Command.t
    ]

  let command_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Command value -> Command.t_to_js value
  ;;

  let command_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "title"
      && binding_has_member js_val "command"
    then `Command (Command.t_of_js js_val)
    else invalid_arg "NotebookCellStatusBarItem.command: unexpected JavaScript value"
  ;;

  include
    [%js:
      val text : t -> string [@@js.get "text"]
      val set_text : t -> string -> unit [@@js.set "text"]
      val alignment : t -> NotebookCellStatusBarAlignment.t [@@js.get "alignment"]

      val set_alignment : t -> NotebookCellStatusBarAlignment.t -> unit
      [@@js.set "alignment"]

      val command : t -> command or_undefined [@@js.get "command"]
      val set_command : t -> command or_undefined -> unit [@@js.set "command"]
      val tooltip : t -> string or_undefined [@@js.get "tooltip"]
      val set_tooltip : t -> string or_undefined -> unit [@@js.set "tooltip"]
      val priority : t -> float or_undefined [@@js.get "priority"]
      val set_priority : t -> float or_undefined -> unit [@@js.set "priority"]

      val accessibilityInformation : t -> AccessibilityInformation.t or_undefined
      [@@js.get "accessibilityInformation"]

      val set_accessibilityInformation
        :  t
        -> AccessibilityInformation.t or_undefined
        -> unit
      [@@js.set "accessibilityInformation"]

      val make : text:string -> alignment:NotebookCellStatusBarAlignment.t -> t
      [@@js.new "@vscode.NotebookCellStatusBarItem"]]
end

module NotebookCellStatusBarItemProvider = struct
  include Interface.Make ()

  type provide_cell_status_bar_items_result_t =
    [ `NotebookCellStatusBarItem of NotebookCellStatusBarItem.t
    | `Items of NotebookCellStatusBarItem.t list
    ]

  let provide_cell_status_bar_items_result_t_to_js = function
    | `NotebookCellStatusBarItem value -> NotebookCellStatusBarItem.t_to_js value
    | `Items value -> (Ojs.list_to_js NotebookCellStatusBarItem.t_to_js) value
  ;;

  let provide_cell_status_bar_items_result_t_of_js js_val =
    match binding_constructor js_val [ "NotebookCellStatusBarItem" ] with
    | Some "NotebookCellStatusBarItem" ->
      `NotebookCellStatusBarItem (NotebookCellStatusBarItem.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "text"
        && binding_has_member js_val "alignment"
      then `NotebookCellStatusBarItem (NotebookCellStatusBarItem.t_of_js js_val)
      else if
        binding_is_array js_val
        && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
            ||
            let js_val = Ojs.array_get js_val 0 in
            Ojs.type_of js_val = "object"
            && (not (Ojs.is_null js_val))
            && binding_has_member js_val "text"
            && binding_has_member js_val "alignment")
      then `Items ((Ojs.list_of_js NotebookCellStatusBarItem.t_of_js) js_val)
      else
        invalid_arg
          "NotebookCellStatusBarItemProvider.provide_cell_status_bar_items_result_t: \
           unexpected JavaScript value"
  ;;

  include
    [%js:
      val onDidChangeCellStatusBarItems : t -> unit Event.t or_undefined
      [@@js.get "onDidChangeCellStatusBarItems"]

      val set_onDidChangeCellStatusBarItems : t -> unit Event.t or_undefined -> unit
      [@@js.set "onDidChangeCellStatusBarItems"]

      val provideCellStatusBarItems
        :  t
        -> cell:NotebookCell.t
        -> token:CancellationToken.t
        -> provide_cell_status_bar_items_result_t ProviderResult.t
      [@@js.call "provideCellStatusBarItems"]]

  let create ?onDidChangeCellStatusBarItems ~provideCellStatusBarItems () =
    let obj = Ojs.obj [||] in
    iter_set
      obj
      "onDidChangeCellStatusBarItems"
      (Event.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None))
      onDidChangeCellStatusBarItems;
    Ojs.set_prop_ascii
      obj
      "provideCellStatusBarItems"
      ([%js.of:
         cell:NotebookCell.t
         -> token:CancellationToken.t
         -> provide_cell_status_bar_items_result_t ProviderResult.t]
         provideCellStatusBarItems);
    t_of_js obj
  ;;
end

module Notebooks = struct
  type create_notebook_controller_handler_result =
    [ `Unit of unit
    | `Promise of unit Promise.t
    ]

  let create_notebook_controller_handler_result_to_js = function
    | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
    | `Promise value ->
      (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
  ;;

  let create_notebook_controller_handler_result_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
    else if Ojs.is_null js_val
    then `Unit ((fun _ -> ()) js_val)
    else
      invalid_arg
        "Notebooks.create_notebook_controller_handler_result: unexpected JavaScript value"
  ;;

  let createNotebookController ~id ~notebookType ~label ?handler () =
    NotebookController.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "notebooks")
         "createNotebookController"
         (binding_arguments
            [| Ojs.string_to_js id
             ; Ojs.string_to_js notebookType
             ; Ojs.string_to_js label
             ; (or_undefined_to_js
                  [%js.of:
                    cells:NotebookCell.t list
                    -> notebook:NotebookDocument.t
                    -> controller:NotebookController.t
                    -> create_notebook_controller_handler_result])
                 handler
            |]
            3
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val registerNotebookCellStatusBarItemProvider
        :  notebookType:string
        -> provider:NotebookCellStatusBarItemProvider.t
        -> Disposable.t
      [@@js.global "@vscode.notebooks.registerNotebookCellStatusBarItemProvider"]

      val createRendererMessaging : rendererId:string -> NotebookRendererMessaging.t
      [@@js.global "@vscode.notebooks.createRendererMessaging"]]
end

module SourceControlInputBox = struct
  include Interface.Make ()

  include
    [%js:
      val value : t -> string [@@js.get "value"]
      val set_value : t -> string -> unit [@@js.set "value"]
      val placeholder : t -> string [@@js.get "placeholder"]
      val set_placeholder : t -> string -> unit [@@js.set "placeholder"]
      val enabled : t -> bool [@@js.get "enabled"]
      val set_enabled : t -> bool -> unit [@@js.set "enabled"]
      val visible : t -> bool [@@js.get "visible"]
      val set_visible : t -> bool -> unit [@@js.set "visible"]]
end

module QuickDiffProvider = struct
  include Interface.Make ()

  let provideOriginalResource this =
    let this = t_to_js this in
    let callback = Ojs.get_prop_ascii this "provideOriginalResource" in
    if Ojs.is_null callback
    then None
    else
      Some
        ([%js.to: uri:Uri.t -> token:CancellationToken.t -> Uri.t ProviderResult.t]
           (Ojs.call callback "bind" [| this |]))
  ;;

  let create ?provideOriginalResource () =
    let obj = Ojs.obj [||] in
    iter_set
      obj
      "provideOriginalResource"
      [%js.of: uri:Uri.t -> token:CancellationToken.t -> Uri.t ProviderResult.t]
      provideOriginalResource;
    t_of_js obj
  ;;
end

module SourceControlResourceThemableDecorations = struct
  include Interface.Make ()

  type icon_path =
    [ `String of string
    | `Uri of Uri.t
    | `ThemeIcon of ThemeIcon.t
    ]

  let icon_path_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Uri value -> Uri.t_to_js value
    | `ThemeIcon value -> ThemeIcon.t_to_js value
  ;;

  let icon_path_of_js js_val =
    match binding_constructor js_val [ "Uri"; "ThemeIcon" ] with
    | Some "Uri" -> `Uri (Uri.t_of_js js_val)
    | Some "ThemeIcon" -> `ThemeIcon (ThemeIcon.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "scheme"
        && binding_has_member js_val "authority"
        && binding_has_member js_val "path"
        && binding_has_member js_val "query"
        && binding_has_member js_val "fragment"
        && binding_has_member js_val "fsPath"
        && binding_has_member js_val "with"
        && binding_has_member js_val "toString"
        && binding_has_member js_val "toJSON"
      then `Uri (Uri.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "id"
      then `ThemeIcon (ThemeIcon.t_of_js js_val)
      else
        invalid_arg
          "SourceControlResourceThemableDecorations.icon_path: unexpected JavaScript \
           value"
  ;;

  include [%js: val iconPath : t -> icon_path or_undefined [@@js.get "iconPath"]]

  let create ?iconPath () =
    let obj = Ojs.obj [||] in
    iter_set obj "iconPath" icon_path_to_js iconPath;
    t_of_js obj
  ;;
end

module SourceControlResourceDecorations = struct
  include Interface.Extend (SourceControlResourceThemableDecorations) ()

  type icon_path =
    [ `String of string
    | `Uri of Uri.t
    | `ThemeIcon of ThemeIcon.t
    ]

  let icon_path_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Uri value -> Uri.t_to_js value
    | `ThemeIcon value -> ThemeIcon.t_to_js value
  ;;

  let icon_path_of_js js_val =
    match binding_constructor js_val [ "Uri"; "ThemeIcon" ] with
    | Some "Uri" -> `Uri (Uri.t_of_js js_val)
    | Some "ThemeIcon" -> `ThemeIcon (ThemeIcon.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "scheme"
        && binding_has_member js_val "authority"
        && binding_has_member js_val "path"
        && binding_has_member js_val "query"
        && binding_has_member js_val "fragment"
        && binding_has_member js_val "fsPath"
        && binding_has_member js_val "with"
        && binding_has_member js_val "toString"
        && binding_has_member js_val "toJSON"
      then `Uri (Uri.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "id"
      then `ThemeIcon (ThemeIcon.t_of_js js_val)
      else
        invalid_arg
          "SourceControlResourceDecorations.icon_path: unexpected JavaScript value"
  ;;

  let to_source_control_resource_themable_decorations (value : t) =
    (value :> SourceControlResourceThemableDecorations.t)
  ;;

  include
    [%js:
      val iconPath : t -> icon_path or_undefined [@@js.get "iconPath"]
      val strikeThrough : t -> bool or_undefined [@@js.get "strikeThrough"]
      val faded : t -> bool or_undefined [@@js.get "faded"]
      val tooltip : t -> string or_undefined [@@js.get "tooltip"]

      val light : t -> SourceControlResourceThemableDecorations.t or_undefined
      [@@js.get "light"]

      val dark : t -> SourceControlResourceThemableDecorations.t or_undefined
      [@@js.get "dark"]]

  let create ?iconPath ?strikeThrough ?faded ?tooltip ?light ?dark () =
    let obj = Ojs.obj [||] in
    iter_set obj "iconPath" icon_path_to_js iconPath;
    iter_set obj "strikeThrough" Ojs.bool_to_js strikeThrough;
    iter_set obj "faded" Ojs.bool_to_js faded;
    iter_set obj "tooltip" Ojs.string_to_js tooltip;
    iter_set obj "light" SourceControlResourceThemableDecorations.t_to_js light;
    iter_set obj "dark" SourceControlResourceThemableDecorations.t_to_js dark;
    t_of_js obj
  ;;
end

module SourceControlResourceState = struct
  include Interface.Make ()

  include
    [%js:
      val resourceUri : t -> Uri.t [@@js.get "resourceUri"]
      val command : t -> Command.t or_undefined [@@js.get "command"]

      val decorations : t -> SourceControlResourceDecorations.t or_undefined
      [@@js.get "decorations"]

      val contextValue : t -> string or_undefined [@@js.get "contextValue"]]

  let create ~resourceUri ?command ?decorations ?contextValue () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "resourceUri" (Uri.t_to_js resourceUri);
    iter_set obj "command" Command.t_to_js command;
    iter_set obj "decorations" SourceControlResourceDecorations.t_to_js decorations;
    iter_set obj "contextValue" Ojs.string_to_js contextValue;
    t_of_js obj
  ;;
end

module SourceControlResourceGroup = struct
  include Interface.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val label : t -> string [@@js.get "label"]
      val set_label : t -> string -> unit [@@js.set "label"]
      val hideWhenEmpty : t -> bool or_undefined [@@js.get "hideWhenEmpty"]
      val set_hideWhenEmpty : t -> bool or_undefined -> unit [@@js.set "hideWhenEmpty"]
      val contextValue : t -> string or_undefined [@@js.get "contextValue"]
      val set_contextValue : t -> string or_undefined -> unit [@@js.set "contextValue"]

      val resourceStates : t -> SourceControlResourceState.t list
      [@@js.get "resourceStates"]

      val set_resourceStates : t -> SourceControlResourceState.t list -> unit
      [@@js.set "resourceStates"]

      val dispose : t -> unit [@@js.call "dispose"]]
end

module SourceControl = struct
  include Interface.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val label : t -> string [@@js.get "label"]
      val rootUri : t -> Uri.t or_undefined [@@js.get "rootUri"]
      val inputBox : t -> SourceControlInputBox.t [@@js.get "inputBox"]
      val count : t -> int or_undefined [@@js.get "count"]
      val set_count : t -> int or_undefined -> unit [@@js.set "count"]

      val quickDiffProvider : t -> QuickDiffProvider.t or_undefined
      [@@js.get "quickDiffProvider"]

      val set_quickDiffProvider : t -> QuickDiffProvider.t or_undefined -> unit
      [@@js.set "quickDiffProvider"]

      val commitTemplate : t -> string or_undefined [@@js.get "commitTemplate"]

      val set_commitTemplate : t -> string or_undefined -> unit
      [@@js.set "commitTemplate"]

      val acceptInputCommand : t -> Command.t or_undefined [@@js.get "acceptInputCommand"]

      val set_acceptInputCommand : t -> Command.t or_undefined -> unit
      [@@js.set "acceptInputCommand"]

      val statusBarCommands : t -> Command.t list or_undefined
      [@@js.get "statusBarCommands"]

      val set_statusBarCommands : t -> Command.t list or_undefined -> unit
      [@@js.set "statusBarCommands"]

      val createResourceGroup
        :  t
        -> id:string
        -> label:string
        -> SourceControlResourceGroup.t
      [@@js.call "createResourceGroup"]

      val dispose : t -> unit [@@js.call "dispose"]]
end

module Scm = struct
  include
    [%js:
      val inputBox : unit -> SourceControlInputBox.t [@@js.get "@vscode.scm.inputBox"]]

  let createSourceControl ~id ~label ?rootUri () =
    SourceControl.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "scm")
         "createSourceControl"
         (binding_arguments
            [| Ojs.string_to_js id
             ; Ojs.string_to_js label
             ; (or_undefined_to_js Uri.t_to_js) rootUri
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module SourceBreakpoint = struct
  include Interface.Extend (Breakpoint) ()

  let to_breakpoint (value : t) = (value :> Breakpoint.t)

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val enabled : t -> bool [@@js.get "enabled"]
      val condition : t -> string or_undefined [@@js.get "condition"]
      val hitCondition : t -> string or_undefined [@@js.get "hitCondition"]
      val logMessage : t -> string or_undefined [@@js.get "logMessage"]
      val location : t -> Location.t [@@js.get "location"]]

  let make ~location ?enabled ?condition ?hitCondition ?logMessage () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "SourceBreakpoint")
         (binding_arguments
            [| Location.t_to_js location
             ; (or_undefined_to_js Ojs.bool_to_js) enabled
             ; (or_undefined_to_js Ojs.string_to_js) condition
             ; (or_undefined_to_js Ojs.string_to_js) hitCondition
             ; (or_undefined_to_js Ojs.string_to_js) logMessage
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module FunctionBreakpoint = struct
  include Interface.Extend (Breakpoint) ()

  let to_breakpoint (value : t) = (value :> Breakpoint.t)

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val enabled : t -> bool [@@js.get "enabled"]
      val condition : t -> string or_undefined [@@js.get "condition"]
      val hitCondition : t -> string or_undefined [@@js.get "hitCondition"]
      val logMessage : t -> string or_undefined [@@js.get "logMessage"]
      val functionName : t -> string [@@js.get "functionName"]]

  let make ~functionName ?enabled ?condition ?hitCondition ?logMessage () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "FunctionBreakpoint")
         (binding_arguments
            [| Ojs.string_to_js functionName
             ; (or_undefined_to_js Ojs.bool_to_js) enabled
             ; (or_undefined_to_js Ojs.string_to_js) condition
             ; (or_undefined_to_js Ojs.string_to_js) hitCondition
             ; (or_undefined_to_js Ojs.string_to_js) logMessage
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module CommentThreadCollapsibleState = struct
  type t =
    | Collapsed [@js 0]
    | Expanded [@js 1]
  [@@js.enum] [@@js]
end

module CommentMode = struct
  type t =
    | Editing [@js 0]
    | Preview [@js 1]
  [@@js.enum] [@@js]
end

module CommentThreadState = struct
  type t =
    | Unresolved [@js 0]
    | Resolved [@js 1]
  [@@js.enum] [@@js]
end

module CommentAuthorInformation = struct
  include Interface.Make ()

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val iconPath : t -> Uri.t or_undefined [@@js.get "iconPath"]
      val set_iconPath : t -> Uri.t or_undefined -> unit [@@js.set "iconPath"]]

  let create ~name ?iconPath () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "name" (Ojs.string_to_js name);
    iter_set obj "iconPath" Uri.t_to_js iconPath;
    t_of_js obj
  ;;
end

module CommentReaction = struct
  include Interface.Make ()

  type icon_path =
    [ `String of string
    | `Uri of Uri.t
    ]

  let icon_path_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Uri value -> Uri.t_to_js value
  ;;

  let icon_path_of_js js_val =
    match binding_constructor js_val [ "Uri" ] with
    | Some "Uri" -> `Uri (Uri.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "scheme"
        && binding_has_member js_val "authority"
        && binding_has_member js_val "path"
        && binding_has_member js_val "query"
        && binding_has_member js_val "fragment"
        && binding_has_member js_val "fsPath"
        && binding_has_member js_val "with"
        && binding_has_member js_val "toString"
        && binding_has_member js_val "toJSON"
      then `Uri (Uri.t_of_js js_val)
      else invalid_arg "CommentReaction.icon_path: unexpected JavaScript value"
  ;;

  include
    [%js:
      val label : t -> string [@@js.get "label"]
      val iconPath : t -> icon_path [@@js.get "iconPath"]
      val count : t -> int [@@js.get "count"]
      val authorHasReacted : t -> bool [@@js.get "authorHasReacted"]]

  let create ~label ~iconPath ~count ~authorHasReacted () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "label" (Ojs.string_to_js label);
    Ojs.set_prop_ascii obj "iconPath" (icon_path_to_js iconPath);
    Ojs.set_prop_ascii obj "count" (Ojs.int_to_js count);
    Ojs.set_prop_ascii obj "authorHasReacted" (Ojs.bool_to_js authorHasReacted);
    t_of_js obj
  ;;
end

module JsDate = struct
  include Class.Make ()

  include
    [%js:
      val make : ?milliseconds:float -> unit -> t [@@js.new "Date"]
      val getTime : t -> float [@@js.call]
      val toISOString : t -> string [@@js.call]]
end

module Comment = struct
  include Interface.Make ()

  type body =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let body_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let body_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else invalid_arg "Comment.body: unexpected JavaScript value"
  ;;

  include
    [%js:
      val body : t -> body [@@js.get "body"]
      val set_body : t -> body -> unit [@@js.set "body"]
      val mode : t -> CommentMode.t [@@js.get "mode"]
      val set_mode : t -> CommentMode.t -> unit [@@js.set "mode"]
      val author : t -> CommentAuthorInformation.t [@@js.get "author"]
      val set_author : t -> CommentAuthorInformation.t -> unit [@@js.set "author"]
      val contextValue : t -> string or_undefined [@@js.get "contextValue"]
      val set_contextValue : t -> string or_undefined -> unit [@@js.set "contextValue"]
      val reactions : t -> CommentReaction.t list or_undefined [@@js.get "reactions"]

      val set_reactions : t -> CommentReaction.t list or_undefined -> unit
      [@@js.set "reactions"]

      val label : t -> string or_undefined [@@js.get "label"]
      val set_label : t -> string or_undefined -> unit [@@js.set "label"]
      val timestamp : t -> JsDate.t or_undefined [@@js.get "timestamp"]
      val set_timestamp : t -> JsDate.t or_undefined -> unit [@@js.set "timestamp"]]

  let create ~body ~mode ~author ?contextValue ?reactions ?label ?timestamp () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "body" (body_to_js body);
    Ojs.set_prop_ascii obj "mode" (CommentMode.t_to_js mode);
    Ojs.set_prop_ascii obj "author" (CommentAuthorInformation.t_to_js author);
    iter_set obj "contextValue" Ojs.string_to_js contextValue;
    iter_set obj "reactions" (Ojs.list_to_js CommentReaction.t_to_js) reactions;
    iter_set obj "label" Ojs.string_to_js label;
    iter_set obj "timestamp" JsDate.t_to_js timestamp;
    t_of_js obj
  ;;
end

module CommentThread = struct
  include Interface.Make ()

  type can_reply =
    [ `Bool of bool
    | `CommentAuthorInformation of CommentAuthorInformation.t
    ]

  let can_reply_to_js = function
    | `Bool value -> Ojs.bool_to_js value
    | `CommentAuthorInformation value -> CommentAuthorInformation.t_to_js value
  ;;

  let can_reply_of_js js_val =
    if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "name"
    then `CommentAuthorInformation (CommentAuthorInformation.t_of_js js_val)
    else invalid_arg "CommentThread.can_reply: unexpected JavaScript value"
  ;;

  include
    [%js:
      val uri : t -> Uri.t [@@js.get "uri"]
      val range : t -> Range.t or_undefined [@@js.get "range"]
      val set_range : t -> Range.t or_undefined -> unit [@@js.set "range"]
      val comments : t -> Comment.t list [@@js.get "comments"]
      val set_comments : t -> Comment.t list -> unit [@@js.set "comments"]

      val collapsibleState : t -> CommentThreadCollapsibleState.t
      [@@js.get "collapsibleState"]

      val set_collapsibleState : t -> CommentThreadCollapsibleState.t -> unit
      [@@js.set "collapsibleState"]

      val canReply : t -> can_reply [@@js.get "canReply"]
      val set_canReply : t -> can_reply -> unit [@@js.set "canReply"]
      val contextValue : t -> string or_undefined [@@js.get "contextValue"]
      val set_contextValue : t -> string or_undefined -> unit [@@js.set "contextValue"]
      val label : t -> string or_undefined [@@js.get "label"]
      val set_label : t -> string or_undefined -> unit [@@js.set "label"]
      val state : t -> CommentThreadState.t or_undefined [@@js.get "state"]
      val set_state : t -> CommentThreadState.t or_undefined -> unit [@@js.set "state"]
      val dispose : t -> unit [@@js.call "dispose"]]
end

module CommentReply = struct
  include Interface.Make ()

  include
    [%js:
      val thread : t -> CommentThread.t [@@js.get "thread"]
      val set_thread : t -> CommentThread.t -> unit [@@js.set "thread"]
      val text : t -> string [@@js.get "text"]
      val set_text : t -> string -> unit [@@js.set "text"]]

  let create ~thread ~text () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "thread" (CommentThread.t_to_js thread);
    Ojs.set_prop_ascii obj "text" (Ojs.string_to_js text);
    t_of_js obj
  ;;
end

module CommentingRanges = struct
  include Interface.Make ()

  include
    [%js:
      val enableFileComments : t -> bool [@@js.get "enableFileComments"]
      val set_enableFileComments : t -> bool -> unit [@@js.set "enableFileComments"]
      val ranges : t -> Range.t list or_undefined [@@js.get "ranges"]
      val set_ranges : t -> Range.t list or_undefined -> unit [@@js.set "ranges"]]

  let create ~enableFileComments ?ranges () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "enableFileComments" (Ojs.bool_to_js enableFileComments);
    iter_set obj "ranges" (Ojs.list_to_js Range.t_to_js) ranges;
    t_of_js obj
  ;;
end

module CommentingRangeProvider = struct
  include Interface.Make ()

  type provide_commenting_ranges_result_t =
    [ `Items of Range.t list
    | `CommentingRanges of CommentingRanges.t
    ]

  let provide_commenting_ranges_result_t_to_js = function
    | `Items value -> (Ojs.list_to_js Range.t_to_js) value
    | `CommentingRanges value -> CommentingRanges.t_to_js value
  ;;

  let provide_commenting_ranges_result_t_of_js js_val =
    if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "object"
          && (not (Ojs.is_null js_val))
          && binding_has_member js_val "start"
          && binding_has_member js_val "end"
          && binding_has_member js_val "isEmpty"
          && binding_has_member js_val "isSingleLine"
          && binding_has_member js_val "contains"
          && binding_has_member js_val "isEqual"
          && binding_has_member js_val "intersection"
          && binding_has_member js_val "union"
          && binding_has_member js_val "with"
          && binding_has_member js_val "with")
    then `Items ((Ojs.list_of_js Range.t_of_js) js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "enableFileComments"
    then `CommentingRanges (CommentingRanges.t_of_js js_val)
    else
      invalid_arg
        "CommentingRangeProvider.provide_commenting_ranges_result_t: unexpected \
         JavaScript value"
  ;;

  include
    [%js:
      val provideCommentingRanges
        :  t
        -> document:TextDocument.t
        -> token:CancellationToken.t
        -> provide_commenting_ranges_result_t ProviderResult.t
      [@@js.call "provideCommentingRanges"]]

  let create ~provideCommentingRanges () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideCommentingRanges"
      ([%js.of:
         document:TextDocument.t
         -> token:CancellationToken.t
         -> provide_commenting_ranges_result_t ProviderResult.t]
         provideCommentingRanges);
    t_of_js obj
  ;;
end

module CommentOptions = struct
  include Interface.Make ()

  include
    [%js:
      val prompt : t -> string or_undefined [@@js.get "prompt"]
      val set_prompt : t -> string or_undefined -> unit [@@js.set "prompt"]
      val placeHolder : t -> string or_undefined [@@js.get "placeHolder"]
      val set_placeHolder : t -> string or_undefined -> unit [@@js.set "placeHolder"]]

  let create ?prompt ?placeHolder () =
    let obj = Ojs.obj [||] in
    iter_set obj "prompt" Ojs.string_to_js prompt;
    iter_set obj "placeHolder" Ojs.string_to_js placeHolder;
    t_of_js obj
  ;;
end

module CommentController = struct
  include Interface.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val label : t -> string [@@js.get "label"]
      val options : t -> CommentOptions.t or_undefined [@@js.get "options"]
      val set_options : t -> CommentOptions.t or_undefined -> unit [@@js.set "options"]

      val commentingRangeProvider : t -> CommentingRangeProvider.t or_undefined
      [@@js.get "commentingRangeProvider"]

      val set_commentingRangeProvider
        :  t
        -> CommentingRangeProvider.t or_undefined
        -> unit
      [@@js.set "commentingRangeProvider"]

      val createCommentThread
        :  t
        -> uri:Uri.t
        -> range:Range.t
        -> comments:Comment.t list
        -> CommentThread.t
      [@@js.call "createCommentThread"]]

  let reactionHandler this =
    (or_undefined_of_js
       [%js.to: comment:Comment.t -> reaction:CommentReaction.t -> unit Promise.t])
      (Ojs.get_prop_ascii (t_to_js this) "reactionHandler")
  ;;

  include
    [%js:
      val set_reactionHandler
        :  t
        -> (comment:Comment.t -> reaction:CommentReaction.t -> unit Promise.t)
             or_undefined
        -> unit
      [@@js.set "reactionHandler"]

      val dispose : t -> unit [@@js.call "dispose"]]
end

module Comments = struct
  include
    [%js:
      val createCommentController : id:string -> label:string -> CommentController.t
      [@@js.global "@vscode.comments.createCommentController"]]
end

module AuthenticationSessionAccountInformation = struct
  include Interface.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val label : t -> string [@@js.get "label"]]

  let create ~id ~label () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "id" (Ojs.string_to_js id);
    Ojs.set_prop_ascii obj "label" (Ojs.string_to_js label);
    t_of_js obj
  ;;
end

module AuthenticationSession = struct
  include Interface.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val accessToken : t -> string [@@js.get "accessToken"]
      val idToken : t -> string or_undefined [@@js.get "idToken"]
      val account : t -> AuthenticationSessionAccountInformation.t [@@js.get "account"]
      val scopes : t -> string list [@@js.get "scopes"]]

  let create ~id ~accessToken ?idToken ~account ~scopes () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "id" (Ojs.string_to_js id);
    Ojs.set_prop_ascii obj "accessToken" (Ojs.string_to_js accessToken);
    iter_set obj "idToken" Ojs.string_to_js idToken;
    Ojs.set_prop_ascii
      obj
      "account"
      (AuthenticationSessionAccountInformation.t_to_js account);
    Ojs.set_prop_ascii obj "scopes" ((Ojs.list_to_js Ojs.string_to_js) scopes);
    t_of_js obj
  ;;
end

module AuthenticationGetSessionPresentationOptions = struct
  include Interface.Make ()

  include
    [%js:
      val detail : t -> string or_undefined [@@js.get "detail"]
      val set_detail : t -> string or_undefined -> unit [@@js.set "detail"]]

  let create ?detail () =
    let obj = Ojs.obj [||] in
    iter_set obj "detail" Ojs.string_to_js detail;
    t_of_js obj
  ;;
end

module AuthenticationForceNewSessionOptions = struct
  type t = AuthenticationGetSessionPresentationOptions.t

  let t_to_js = AuthenticationGetSessionPresentationOptions.t_to_js
  let t_of_js = AuthenticationGetSessionPresentationOptions.t_of_js
end

module AuthenticationGetSessionOptions = struct
  include Interface.Make ()

  type create_if_none =
    [ `Bool of bool
    | `AuthenticationGetSessionPresentationOptions of
        AuthenticationGetSessionPresentationOptions.t
    ]

  let create_if_none_to_js = function
    | `Bool value -> Ojs.bool_to_js value
    | `AuthenticationGetSessionPresentationOptions value ->
      AuthenticationGetSessionPresentationOptions.t_to_js value
  ;;

  let create_if_none_of_js js_val =
    if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then
      `AuthenticationGetSessionPresentationOptions
        (AuthenticationGetSessionPresentationOptions.t_of_js js_val)
    else
      invalid_arg
        "AuthenticationGetSessionOptions.create_if_none: unexpected JavaScript value"
  ;;

  type force_new_session =
    [ `Bool of bool
    | `AuthenticationGetSessionPresentationOptions of
        AuthenticationGetSessionPresentationOptions.t
    | `AuthenticationForceNewSessionOptions of AuthenticationForceNewSessionOptions.t
    ]

  let force_new_session_to_js = function
    | `Bool value -> Ojs.bool_to_js value
    | `AuthenticationGetSessionPresentationOptions value ->
      AuthenticationGetSessionPresentationOptions.t_to_js value
    | `AuthenticationForceNewSessionOptions value ->
      AuthenticationForceNewSessionOptions.t_to_js value
  ;;

  let force_new_session_of_js js_val =
    if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then
      `AuthenticationGetSessionPresentationOptions
        (AuthenticationGetSessionPresentationOptions.t_of_js js_val)
    else if not (Ojs.is_null js_val)
    then
      `AuthenticationForceNewSessionOptions
        (AuthenticationForceNewSessionOptions.t_of_js js_val)
    else
      invalid_arg
        "AuthenticationGetSessionOptions.force_new_session: unexpected JavaScript value"
  ;;

  include
    [%js:
      val clearSessionPreference : t -> bool or_undefined
      [@@js.get "clearSessionPreference"]

      val set_clearSessionPreference : t -> bool or_undefined -> unit
      [@@js.set "clearSessionPreference"]

      val createIfNone : t -> create_if_none or_undefined [@@js.get "createIfNone"]

      val set_createIfNone : t -> create_if_none or_undefined -> unit
      [@@js.set "createIfNone"]

      val forceNewSession : t -> force_new_session or_undefined
      [@@js.get "forceNewSession"]

      val set_forceNewSession : t -> force_new_session or_undefined -> unit
      [@@js.set "forceNewSession"]

      val silent : t -> bool or_undefined [@@js.get "silent"]
      val set_silent : t -> bool or_undefined -> unit [@@js.set "silent"]

      val account : t -> AuthenticationSessionAccountInformation.t or_undefined
      [@@js.get "account"]

      val set_account
        :  t
        -> AuthenticationSessionAccountInformation.t or_undefined
        -> unit
      [@@js.set "account"]]

  let create ?clearSessionPreference ?createIfNone ?forceNewSession ?silent ?account () =
    let obj = Ojs.obj [||] in
    iter_set obj "clearSessionPreference" Ojs.bool_to_js clearSessionPreference;
    iter_set obj "createIfNone" create_if_none_to_js createIfNone;
    iter_set obj "forceNewSession" force_new_session_to_js forceNewSession;
    iter_set obj "silent" Ojs.bool_to_js silent;
    iter_set obj "account" AuthenticationSessionAccountInformation.t_to_js account;
    t_of_js obj
  ;;
end

module AuthenticationWwwAuthenticateRequest = struct
  include Interface.Make ()

  include
    [%js:
      val wwwAuthenticate : t -> string [@@js.get "wwwAuthenticate"]
      val fallbackScopes : t -> string list or_undefined [@@js.get "fallbackScopes"]]

  let create ~wwwAuthenticate ?fallbackScopes () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "wwwAuthenticate" (Ojs.string_to_js wwwAuthenticate);
    iter_set obj "fallbackScopes" (Ojs.list_to_js Ojs.string_to_js) fallbackScopes;
    t_of_js obj
  ;;
end

module AuthenticationProviderInformation = struct
  include Interface.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val label : t -> string [@@js.get "label"]]

  let create ~id ~label () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "id" (Ojs.string_to_js id);
    Ojs.set_prop_ascii obj "label" (Ojs.string_to_js label);
    t_of_js obj
  ;;
end

module AuthenticationSessionsChangeEvent = struct
  include Interface.Make ()

  include
    [%js: val provider : t -> AuthenticationProviderInformation.t [@@js.get "provider"]]

  let create ~provider () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "provider" (AuthenticationProviderInformation.t_to_js provider);
    t_of_js obj
  ;;
end

module AuthenticationProviderOptions = struct
  include Interface.Make ()

  include
    [%js:
      val supportsMultipleAccounts : t -> bool or_undefined
      [@@js.get "supportsMultipleAccounts"]]

  let create ?supportsMultipleAccounts () =
    let obj = Ojs.obj [||] in
    iter_set obj "supportsMultipleAccounts" Ojs.bool_to_js supportsMultipleAccounts;
    t_of_js obj
  ;;
end

module AuthenticationProviderAuthenticationSessionsChangeEvent = struct
  include Interface.Make ()

  include
    [%js:
      val added : t -> AuthenticationSession.t list or_undefined [@@js.get "added"]
      val removed : t -> AuthenticationSession.t list or_undefined [@@js.get "removed"]
      val changed : t -> AuthenticationSession.t list or_undefined [@@js.get "changed"]]

  let create ~added ~removed ~changed () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "added"
      ((or_undefined_to_js (Ojs.list_to_js AuthenticationSession.t_to_js)) added);
    Ojs.set_prop_ascii
      obj
      "removed"
      ((or_undefined_to_js (Ojs.list_to_js AuthenticationSession.t_to_js)) removed);
    Ojs.set_prop_ascii
      obj
      "changed"
      ((or_undefined_to_js (Ojs.list_to_js AuthenticationSession.t_to_js)) changed);
    t_of_js obj
  ;;
end

module AuthenticationProviderSessionOptions = struct
  include Interface.Make ()

  include
    [%js:
      val account : t -> AuthenticationSessionAccountInformation.t or_undefined
      [@@js.get "account"]

      val set_account
        :  t
        -> AuthenticationSessionAccountInformation.t or_undefined
        -> unit
      [@@js.set "account"]]

  let create ?account () =
    let obj = Ojs.obj [||] in
    iter_set obj "account" AuthenticationSessionAccountInformation.t_to_js account;
    t_of_js obj
  ;;
end

module AuthenticationProvider = struct
  include Interface.Make ()

  include
    [%js:
      val onDidChangeSessions
        :  t
        -> AuthenticationProviderAuthenticationSessionsChangeEvent.t Event.t
      [@@js.get "onDidChangeSessions"]

      val getSessions
        :  t
        -> scopes:string list or_undefined
        -> options:AuthenticationProviderSessionOptions.t
        -> AuthenticationSession.t list Promise.t
      [@@js.call "getSessions"]

      val createSession
        :  t
        -> scopes:string list
        -> options:AuthenticationProviderSessionOptions.t
        -> AuthenticationSession.t Promise.t
      [@@js.call "createSession"]

      val removeSession : t -> sessionId:string -> unit Promise.t
      [@@js.call "removeSession"]]

  let create ~onDidChangeSessions ~getSessions ~createSession ~removeSession () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "onDidChangeSessions"
      ((Event.t_to_js AuthenticationProviderAuthenticationSessionsChangeEvent.t_to_js)
         onDidChangeSessions);
    Ojs.set_prop_ascii
      obj
      "getSessions"
      ([%js.of:
         scopes:string list or_undefined
         -> options:AuthenticationProviderSessionOptions.t
         -> AuthenticationSession.t list Promise.t]
         getSessions);
    Ojs.set_prop_ascii
      obj
      "createSession"
      ([%js.of:
         scopes:string list
         -> options:AuthenticationProviderSessionOptions.t
         -> AuthenticationSession.t Promise.t]
         createSession);
    Ojs.set_prop_ascii
      obj
      "removeSession"
      ([%js.of: sessionId:string -> unit Promise.t] removeSession);
    t_of_js obj
  ;;
end

module Authentication = struct
  type get_session_creating_scope_list_or_request =
    [ `ReadonlyArray of string list
    | `AuthenticationWwwAuthenticateRequest of AuthenticationWwwAuthenticateRequest.t
    ]

  let get_session_creating_scope_list_or_request_to_js = function
    | `ReadonlyArray value -> (Ojs.list_to_js Ojs.string_to_js) value
    | `AuthenticationWwwAuthenticateRequest value ->
      AuthenticationWwwAuthenticateRequest.t_to_js value
  ;;

  let get_session_creating_scope_list_or_request_of_js js_val =
    if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "string")
    then `ReadonlyArray ((Ojs.list_of_js Ojs.string_of_js) js_val)
    else if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "wwwAuthenticate"
    then
      `AuthenticationWwwAuthenticateRequest
        (AuthenticationWwwAuthenticateRequest.t_of_js js_val)
    else
      invalid_arg
        "Authentication.get_session_creating_scope_list_or_request: unexpected \
         JavaScript value"
  ;;

  type get_session_creating_options_create_if_none =
    [ `True
    | `AuthenticationGetSessionPresentationOptions of
        AuthenticationGetSessionPresentationOptions.t
    ]

  let get_session_creating_options_create_if_none_to_js = function
    | `True -> Ojs.bool_to_js true
    | `AuthenticationGetSessionPresentationOptions value ->
      AuthenticationGetSessionPresentationOptions.t_to_js value
  ;;

  let get_session_creating_options_create_if_none_of_js js_val =
    if Ojs.type_of js_val = "boolean" && Ojs.bool_of_js js_val
    then `True
    else if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then
      `AuthenticationGetSessionPresentationOptions
        (AuthenticationGetSessionPresentationOptions.t_of_js js_val)
    else
      invalid_arg
        "Authentication.get_session_creating_options_create_if_none: unexpected \
         JavaScript value"
  ;;

  type get_session_creating_options_force_new_session =
    [ `Bool of bool
    | `AuthenticationGetSessionPresentationOptions of
        AuthenticationGetSessionPresentationOptions.t
    | `AuthenticationForceNewSessionOptions of AuthenticationForceNewSessionOptions.t
    ]

  let get_session_creating_options_force_new_session_to_js = function
    | `Bool value -> Ojs.bool_to_js value
    | `AuthenticationGetSessionPresentationOptions value ->
      AuthenticationGetSessionPresentationOptions.t_to_js value
    | `AuthenticationForceNewSessionOptions value ->
      AuthenticationForceNewSessionOptions.t_to_js value
  ;;

  let get_session_creating_options_force_new_session_of_js js_val =
    if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then
      `AuthenticationGetSessionPresentationOptions
        (AuthenticationGetSessionPresentationOptions.t_of_js js_val)
    else if not (Ojs.is_null js_val)
    then
      `AuthenticationForceNewSessionOptions
        (AuthenticationForceNewSessionOptions.t_of_js js_val)
    else
      invalid_arg
        "Authentication.get_session_creating_options_force_new_session: unexpected \
         JavaScript value"
  ;;

  type get_session_creating_options =
    { clearSessionPreference : bool or_undefined
    ; createIfNone : get_session_creating_options_create_if_none
    ; forceNewSession : get_session_creating_options_force_new_session or_undefined
    ; silent : bool or_undefined
    ; account : AuthenticationSessionAccountInformation.t or_undefined
    }

  let get_session_creating_options_to_js (value : get_session_creating_options) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "clearSessionPreference" Ojs.bool_to_js value.clearSessionPreference;
    Ojs.set_prop_ascii
      js_val
      "createIfNone"
      (get_session_creating_options_create_if_none_to_js value.createIfNone);
    iter_set
      js_val
      "forceNewSession"
      get_session_creating_options_force_new_session_to_js
      value.forceNewSession;
    iter_set js_val "silent" Ojs.bool_to_js value.silent;
    iter_set
      js_val
      "account"
      AuthenticationSessionAccountInformation.t_to_js
      value.account;
    js_val
  ;;

  let get_session_creating_options_of_js js_val : get_session_creating_options =
    { clearSessionPreference =
        (or_undefined_of_js Ojs.bool_of_js)
          (Ojs.get_prop_ascii js_val "clearSessionPreference")
    ; createIfNone =
        get_session_creating_options_create_if_none_of_js
          (Ojs.get_prop_ascii js_val "createIfNone")
    ; forceNewSession =
        (or_undefined_of_js get_session_creating_options_force_new_session_of_js)
          (Ojs.get_prop_ascii js_val "forceNewSession")
    ; silent = (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "silent")
    ; account =
        (or_undefined_of_js AuthenticationSessionAccountInformation.t_of_js)
          (Ojs.get_prop_ascii js_val "account")
    }
  ;;

  type get_session_forcing_new_options_create_if_none =
    [ `Bool of bool
    | `AuthenticationGetSessionPresentationOptions of
        AuthenticationGetSessionPresentationOptions.t
    ]

  let get_session_forcing_new_options_create_if_none_to_js = function
    | `Bool value -> Ojs.bool_to_js value
    | `AuthenticationGetSessionPresentationOptions value ->
      AuthenticationGetSessionPresentationOptions.t_to_js value
  ;;

  let get_session_forcing_new_options_create_if_none_of_js js_val =
    if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then
      `AuthenticationGetSessionPresentationOptions
        (AuthenticationGetSessionPresentationOptions.t_of_js js_val)
    else
      invalid_arg
        "Authentication.get_session_forcing_new_options_create_if_none: unexpected \
         JavaScript value"
  ;;

  type get_session_forcing_new_options_force_new_session =
    [ `True
    | `AuthenticationGetSessionPresentationOptions of
        AuthenticationGetSessionPresentationOptions.t
    | `AuthenticationForceNewSessionOptions of AuthenticationForceNewSessionOptions.t
    ]

  let get_session_forcing_new_options_force_new_session_to_js = function
    | `True -> Ojs.bool_to_js true
    | `AuthenticationGetSessionPresentationOptions value ->
      AuthenticationGetSessionPresentationOptions.t_to_js value
    | `AuthenticationForceNewSessionOptions value ->
      AuthenticationForceNewSessionOptions.t_to_js value
  ;;

  let get_session_forcing_new_options_force_new_session_of_js js_val =
    if Ojs.type_of js_val = "boolean" && Ojs.bool_of_js js_val
    then `True
    else if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then
      `AuthenticationGetSessionPresentationOptions
        (AuthenticationGetSessionPresentationOptions.t_of_js js_val)
    else if not (Ojs.is_null js_val)
    then
      `AuthenticationForceNewSessionOptions
        (AuthenticationForceNewSessionOptions.t_of_js js_val)
    else
      invalid_arg
        "Authentication.get_session_forcing_new_options_force_new_session: unexpected \
         JavaScript value"
  ;;

  type get_session_forcing_new_options =
    { clearSessionPreference : bool or_undefined
    ; createIfNone : get_session_forcing_new_options_create_if_none or_undefined
    ; forceNewSession : get_session_forcing_new_options_force_new_session
    ; silent : bool or_undefined
    ; account : AuthenticationSessionAccountInformation.t or_undefined
    }

  let get_session_forcing_new_options_to_js (value : get_session_forcing_new_options) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "clearSessionPreference" Ojs.bool_to_js value.clearSessionPreference;
    iter_set
      js_val
      "createIfNone"
      get_session_forcing_new_options_create_if_none_to_js
      value.createIfNone;
    Ojs.set_prop_ascii
      js_val
      "forceNewSession"
      (get_session_forcing_new_options_force_new_session_to_js value.forceNewSession);
    iter_set js_val "silent" Ojs.bool_to_js value.silent;
    iter_set
      js_val
      "account"
      AuthenticationSessionAccountInformation.t_to_js
      value.account;
    js_val
  ;;

  let get_session_forcing_new_options_of_js js_val : get_session_forcing_new_options =
    { clearSessionPreference =
        (or_undefined_of_js Ojs.bool_of_js)
          (Ojs.get_prop_ascii js_val "clearSessionPreference")
    ; createIfNone =
        (or_undefined_of_js get_session_forcing_new_options_create_if_none_of_js)
          (Ojs.get_prop_ascii js_val "createIfNone")
    ; forceNewSession =
        get_session_forcing_new_options_force_new_session_of_js
          (Ojs.get_prop_ascii js_val "forceNewSession")
    ; silent = (or_undefined_of_js Ojs.bool_of_js) (Ojs.get_prop_ascii js_val "silent")
    ; account =
        (or_undefined_of_js AuthenticationSessionAccountInformation.t_of_js)
          (Ojs.get_prop_ascii js_val "account")
    }
  ;;

  include
    [%js:
      val getSessionCreating
        :  providerId:string
        -> scopeListOrRequest:get_session_creating_scope_list_or_request
        -> options:get_session_creating_options
        -> AuthenticationSession.t Promise.t
      [@@js.global "@vscode.authentication.getSession"]

      val getSessionForcingNew
        :  providerId:string
        -> scopeListOrRequest:get_session_creating_scope_list_or_request
        -> options:get_session_forcing_new_options
        -> AuthenticationSession.t Promise.t
      [@@js.global "@vscode.authentication.getSession"]]

  let getSession ~providerId ~scopeListOrRequest ?options () =
    (Promise.t_of_js (or_undefined_of_js AuthenticationSession.t_of_js))
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "authentication")
         "getSession"
         (binding_arguments
            [| Ojs.string_to_js providerId
             ; get_session_creating_scope_list_or_request_to_js scopeListOrRequest
             ; (or_undefined_to_js AuthenticationGetSessionOptions.t_to_js) options
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val getAccounts
        :  providerId:string
        -> AuthenticationSessionAccountInformation.t list Promise.t
      [@@js.global "@vscode.authentication.getAccounts"]

      val onDidChangeSessions : unit -> AuthenticationSessionsChangeEvent.t Event.t
      [@@js.get "@vscode.authentication.onDidChangeSessions"]]

  let registerAuthenticationProvider ~id ~label ~provider ?options () =
    Disposable.t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "authentication")
         "registerAuthenticationProvider"
         (binding_arguments
            [| Ojs.string_to_js id
             ; Ojs.string_to_js label
             ; AuthenticationProvider.t_to_js provider
             ; (or_undefined_to_js AuthenticationProviderOptions.t_to_js) options
            |]
            3
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module L10n = struct
  type t_args_item =
    [ `String of string
    | `Float of float
    | `Bool of bool
    ]

  let t_args_item_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Float value -> Ojs.float_to_js value
    | `Bool value -> Ojs.bool_to_js value
  ;;

  let t_args_item_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if Ojs.type_of js_val = "number"
    then `Float (Ojs.float_of_js js_val)
    else if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else invalid_arg "L10n.t_args_item: unexpected JavaScript value"
  ;;

  type t_with_options_args =
    [ `Array of t_args_item list
    | `Record of t_args_item Dict.t
    ]

  let t_with_options_args_to_js = function
    | `Array value -> (Ojs.list_to_js t_args_item_to_js) value
    | `Record value -> (Dict.t_to_js t_args_item_to_js) value
  ;;

  let t_with_options_args_of_js js_val =
    if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "string"
          || Ojs.type_of js_val = "number"
          || Ojs.type_of js_val = "boolean")
    then `Array ((Ojs.list_of_js t_args_item_of_js) js_val)
    else if Ojs.type_of js_val = "object"
    then `Record ((Dict.t_of_js t_args_item_of_js) js_val)
    else invalid_arg "L10n.t_with_options_args: unexpected JavaScript value"
  ;;

  type t_with_options_comment =
    [ `String of string
    | `Items of string list
    ]

  let t_with_options_comment_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Items value -> (Ojs.list_to_js Ojs.string_to_js) value
  ;;

  let t_with_options_comment_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "string")
    then `Items ((Ojs.list_of_js Ojs.string_of_js) js_val)
    else invalid_arg "L10n.t_with_options_comment: unexpected JavaScript value"
  ;;

  type t_with_options =
    { message : string
    ; args : t_with_options_args or_undefined
    ; comment : t_with_options_comment
    }

  let t_with_options_to_js (value : t_with_options) =
    let js_val = Ojs.obj [||] in
    Ojs.set_prop_ascii js_val "message" (Ojs.string_to_js value.message);
    iter_set js_val "args" t_with_options_args_to_js value.args;
    Ojs.set_prop_ascii js_val "comment" (t_with_options_comment_to_js value.comment);
    js_val
  ;;

  let t_with_options_of_js js_val : t_with_options =
    { message = Ojs.string_of_js (Ojs.get_prop_ascii js_val "message")
    ; args =
        (or_undefined_of_js t_with_options_args_of_js) (Ojs.get_prop_ascii js_val "args")
    ; comment = t_with_options_comment_of_js (Ojs.get_prop_ascii js_val "comment")
    }
  ;;

  include
    [%js:
      val t : message:string -> args:(t_args_item list[@js.variadic]) -> string
      [@@js.global "@vscode.l10n.t"]

      val tNamed : message:string -> args:t_args_item Dict.t -> string
      [@@js.global "@vscode.l10n.t"]

      val tWithOptions : options:t_with_options -> string [@@js.global "@vscode.l10n.t"]
      val bundle : unit -> string Dict.t or_undefined [@@js.get "@vscode.l10n.bundle"]
      val uri : unit -> Uri.t or_undefined [@@js.get "@vscode.l10n.uri"]]
end

module TestRunProfileKind = struct
  type t =
    | Run [@js 1]
    | Debug [@js 2]
    | Coverage [@js 3]
  [@@js.enum] [@@js]
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
end = struct
  include Interface.Make ()

  type run_handler_result =
    [ `Promise of unit Promise.t
    | `Unit of unit
    ]

  let run_handler_result_to_js = function
    | `Promise value ->
      (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
    | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
  ;;

  let run_handler_result_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
    else if Ojs.is_null js_val
    then `Unit ((fun _ -> ()) js_val)
    else invalid_arg "TestRunProfile.run_handler_result: unexpected JavaScript value"
  ;;

  include
    [%js:
      val label : t -> string [@@js.get "label"]
      val set_label : t -> string -> unit [@@js.set "label"]
      val kind : t -> TestRunProfileKind.t [@@js.get "kind"]
      val isDefault : t -> bool [@@js.get "isDefault"]
      val set_isDefault : t -> bool -> unit [@@js.set "isDefault"]
      val onDidChangeDefault : t -> bool Event.t [@@js.get "onDidChangeDefault"]
      val supportsContinuousRun : t -> bool [@@js.get "supportsContinuousRun"]
      val set_supportsContinuousRun : t -> bool -> unit [@@js.set "supportsContinuousRun"]
      val tag : t -> TestTag.t or_undefined [@@js.get "tag"]
      val set_tag : t -> TestTag.t or_undefined -> unit [@@js.set "tag"]]

  let configureHandler this =
    (or_undefined_of_js [%js.to: unit -> unit])
      (Ojs.get_prop_ascii (t_to_js this) "configureHandler")
  ;;

  include
    [%js:
      val set_configureHandler : t -> (unit -> unit) or_undefined -> unit
      [@@js.set "configureHandler"]]

  let runHandler this =
    [%js.to: request:TestRunRequest.t -> token:CancellationToken.t -> run_handler_result]
      (Ojs.get_prop_ascii (t_to_js this) "runHandler")
  ;;

  include
    [%js:
      val set_runHandler
        :  t
        -> (request:TestRunRequest.t -> token:CancellationToken.t -> run_handler_result)
        -> unit
      [@@js.set "runHandler"]]

  let loadDetailedCoverage this =
    (or_undefined_of_js
       [%js.to:
         testRun:TestRun.t
         -> fileCoverage:FileCoverage.t
         -> token:CancellationToken.t
         -> FileCoverageDetail.t list Promise.t])
      (Ojs.get_prop_ascii (t_to_js this) "loadDetailedCoverage")
  ;;

  include
    [%js:
      val set_loadDetailedCoverage
        :  t
        -> (testRun:TestRun.t
            -> fileCoverage:FileCoverage.t
            -> token:CancellationToken.t
            -> FileCoverageDetail.t list Promise.t)
             or_undefined
        -> unit
      [@@js.set "loadDetailedCoverage"]]

  let loadDetailedCoverageForTest this =
    (or_undefined_of_js
       [%js.to:
         testRun:TestRun.t
         -> fileCoverage:FileCoverage.t
         -> fromTestItem:TestItem.t
         -> token:CancellationToken.t
         -> FileCoverageDetail.t list Promise.t])
      (Ojs.get_prop_ascii (t_to_js this) "loadDetailedCoverageForTest")
  ;;

  include
    [%js:
      val set_loadDetailedCoverageForTest
        :  t
        -> (testRun:TestRun.t
            -> fileCoverage:FileCoverage.t
            -> fromTestItem:TestItem.t
            -> token:CancellationToken.t
            -> FileCoverageDetail.t list Promise.t)
             or_undefined
        -> unit
      [@@js.set "loadDetailedCoverageForTest"]

      val dispose : t -> unit [@@js.call "dispose"]]

  let create
        ~label
        ~kind
        ~isDefault
        ~onDidChangeDefault
        ~supportsContinuousRun
        ~tag
        ~configureHandler
        ~runHandler
        ?loadDetailedCoverage
        ?loadDetailedCoverageForTest
        ~dispose
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "label" (Ojs.string_to_js label);
    Ojs.set_prop_ascii obj "kind" (TestRunProfileKind.t_to_js kind);
    Ojs.set_prop_ascii obj "isDefault" (Ojs.bool_to_js isDefault);
    Ojs.set_prop_ascii
      obj
      "onDidChangeDefault"
      ((Event.t_to_js Ojs.bool_to_js) onDidChangeDefault);
    Ojs.set_prop_ascii obj "supportsContinuousRun" (Ojs.bool_to_js supportsContinuousRun);
    Ojs.set_prop_ascii obj "tag" ((or_undefined_to_js TestTag.t_to_js) tag);
    Ojs.set_prop_ascii
      obj
      "configureHandler"
      ((or_undefined_to_js [%js.of: unit -> unit]) configureHandler);
    Ojs.set_prop_ascii
      obj
      "runHandler"
      ([%js.of:
         request:TestRunRequest.t -> token:CancellationToken.t -> run_handler_result]
         runHandler);
    iter_set
      obj
      "loadDetailedCoverage"
      [%js.of:
        testRun:TestRun.t
        -> fileCoverage:FileCoverage.t
        -> token:CancellationToken.t
        -> FileCoverageDetail.t list Promise.t]
      loadDetailedCoverage;
    iter_set
      obj
      "loadDetailedCoverageForTest"
      [%js.of:
        testRun:TestRun.t
        -> fileCoverage:FileCoverage.t
        -> fromTestItem:TestItem.t
        -> token:CancellationToken.t
        -> FileCoverageDetail.t list Promise.t]
      loadDetailedCoverageForTest;
    Ojs.set_prop_ascii obj "dispose" ([%js.of: unit -> unit] dispose);
    t_of_js obj
  ;;
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
end = struct
  include Class.Make ()

  include
    [%js:
      val include_ : t -> TestItem.t list or_undefined [@@js.get "include"]
      val exclude : t -> TestItem.t list or_undefined [@@js.get "exclude"]
      val profile : t -> TestRunProfile.t or_undefined [@@js.get "profile"]
      val continuous : t -> bool or_undefined [@@js.get "continuous"]
      val preserveFocus : t -> bool [@@js.get "preserveFocus"]]

  let make ?include_ ?exclude ?profile ?continuous ?preserveFocus () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "TestRunRequest")
         (binding_arguments
            [| (or_undefined_to_js (Ojs.list_to_js TestItem.t_to_js)) include_
             ; (or_undefined_to_js (Ojs.list_to_js TestItem.t_to_js)) exclude
             ; (or_undefined_to_js TestRunProfile.t_to_js) profile
             ; (or_undefined_to_js Ojs.bool_to_js) continuous
             ; (or_undefined_to_js Ojs.bool_to_js) preserveFocus
            |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module TestController = struct
  include Interface.Make ()

  type create_run_profile_run_handler_result =
    [ `Promise of unit Promise.t
    | `Unit of unit
    ]

  let create_run_profile_run_handler_result_to_js = function
    | `Promise value ->
      (Promise.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None)) value
    | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
  ;;

  let create_run_profile_run_handler_result_of_js js_val =
    if binding_is_thenable js_val
    then `Promise ((Promise.t_of_js (fun _ -> ())) js_val)
    else if Ojs.is_null js_val
    then `Unit ((fun _ -> ()) js_val)
    else
      invalid_arg
        "TestController.create_run_profile_run_handler_result: unexpected JavaScript \
         value"
  ;;

  type invalidate_test_results_items =
    [ `TestItem of TestItem.t
    | `Items of TestItem.t list
    ]

  let invalidate_test_results_items_to_js = function
    | `TestItem value -> TestItem.t_to_js value
    | `Items value -> (Ojs.list_to_js TestItem.t_to_js) value
  ;;

  let invalidate_test_results_items_of_js js_val =
    if
      Ojs.type_of js_val = "object"
      && (not (Ojs.is_null js_val))
      && binding_has_member js_val "id"
      && binding_has_member js_val "uri"
      && binding_has_member js_val "children"
      && binding_has_member js_val "parent"
      && binding_has_member js_val "tags"
      && binding_has_member js_val "canResolveChildren"
      && binding_has_member js_val "busy"
      && binding_has_member js_val "label"
      && binding_has_member js_val "range"
      && binding_has_member js_val "error"
    then `TestItem (TestItem.t_of_js js_val)
    else if
      binding_is_array js_val
      && (Ojs.int_of_js (Ojs.get_prop_ascii js_val "length") = 0
          ||
          let js_val = Ojs.array_get js_val 0 in
          Ojs.type_of js_val = "object"
          && (not (Ojs.is_null js_val))
          && binding_has_member js_val "id"
          && binding_has_member js_val "uri"
          && binding_has_member js_val "children"
          && binding_has_member js_val "parent"
          && binding_has_member js_val "tags"
          && binding_has_member js_val "canResolveChildren"
          && binding_has_member js_val "busy"
          && binding_has_member js_val "label"
          && binding_has_member js_val "range"
          && binding_has_member js_val "error")
    then `Items ((Ojs.list_of_js TestItem.t_of_js) js_val)
    else
      invalid_arg
        "TestController.invalidate_test_results_items: unexpected JavaScript value"
  ;;

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val label : t -> string [@@js.get "label"]
      val set_label : t -> string -> unit [@@js.set "label"]
      val items : t -> TestItemCollection.t [@@js.get "items"]]

  let createRunProfile
        this
        ~label
        ~kind
        ~runHandler
        ?isDefault
        ?tag
        ?supportsContinuousRun
        ()
    =
    TestRunProfile.t_of_js
      (Ojs.call
         (t_to_js this)
         "createRunProfile"
         (binding_arguments
            [| Ojs.string_to_js label
             ; TestRunProfileKind.t_to_js kind
             ; [%js.of:
                 request:TestRunRequest.t
                 -> token:CancellationToken.t
                 -> create_run_profile_run_handler_result]
                 runHandler
             ; (or_undefined_to_js Ojs.bool_to_js) isDefault
             ; (or_undefined_to_js TestTag.t_to_js) tag
             ; (or_undefined_to_js Ojs.bool_to_js) supportsContinuousRun
            |]
            3
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let resolveHandler this =
    (or_undefined_of_js
       [%js.to: item:TestItem.t or_undefined -> create_run_profile_run_handler_result])
      (Ojs.get_prop_ascii (t_to_js this) "resolveHandler")
  ;;

  include
    [%js:
      val set_resolveHandler
        :  t
        -> (item:TestItem.t or_undefined -> create_run_profile_run_handler_result)
             or_undefined
        -> unit
      [@@js.set "resolveHandler"]]

  let refreshHandler this =
    (or_undefined_of_js
       [%js.to: token:CancellationToken.t -> create_run_profile_run_handler_result])
      (Ojs.get_prop_ascii (t_to_js this) "refreshHandler")
  ;;

  include
    [%js:
      val set_refreshHandler
        :  t
        -> (token:CancellationToken.t -> create_run_profile_run_handler_result)
             or_undefined
        -> unit
      [@@js.set "refreshHandler"]]

  let createTestRun this ~request ?name ?persist () =
    TestRun.t_of_js
      (Ojs.call
         (t_to_js this)
         "createTestRun"
         (binding_arguments
            [| TestRunRequest.t_to_js request
             ; (or_undefined_to_js Ojs.string_to_js) name
             ; (or_undefined_to_js Ojs.bool_to_js) persist
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let createTestItem this ~id ~label ?uri () =
    TestItem.t_of_js
      (Ojs.call
         (t_to_js this)
         "createTestItem"
         (binding_arguments
            [| Ojs.string_to_js id
             ; Ojs.string_to_js label
             ; (or_undefined_to_js Uri.t_to_js) uri
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let invalidateTestResults this ?items () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "invalidateTestResults"
         (binding_arguments
            [| (or_undefined_to_js invalidate_test_results_items_to_js) items |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include [%js: val dispose : t -> unit [@@js.call "dispose"]]
end

module Tests = struct
  include
    [%js:
      val createTestController : id:string -> label:string -> TestController.t
      [@@js.global "@vscode.tests.createTestController"]]
end

module TabInputText = struct
  include Class.Make ()

  include
    [%js:
      val uri : t -> Uri.t [@@js.get "uri"]
      val make : uri:Uri.t -> t [@@js.new "@vscode.TabInputText"]]
end

module TabInputTextDiff = struct
  include Class.Make ()

  include
    [%js:
      val original : t -> Uri.t [@@js.get "original"]
      val modified : t -> Uri.t [@@js.get "modified"]

      val make : original:Uri.t -> modified:Uri.t -> t
      [@@js.new "@vscode.TabInputTextDiff"]]
end

module TabInputCustom = struct
  include Class.Make ()

  include
    [%js:
      val uri : t -> Uri.t [@@js.get "uri"]
      val viewType : t -> string [@@js.get "viewType"]
      val make : uri:Uri.t -> viewType:string -> t [@@js.new "@vscode.TabInputCustom"]]
end

module TabInputWebview = struct
  include Class.Make ()

  include
    [%js:
      val viewType : t -> string [@@js.get "viewType"]
      val make : viewType:string -> t [@@js.new "@vscode.TabInputWebview"]]
end

module TabInputNotebook = struct
  include Class.Make ()

  include
    [%js:
      val uri : t -> Uri.t [@@js.get "uri"]
      val notebookType : t -> string [@@js.get "notebookType"]

      val make : uri:Uri.t -> notebookType:string -> t
      [@@js.new "@vscode.TabInputNotebook"]]
end

module TabInputNotebookDiff = struct
  include Class.Make ()

  include
    [%js:
      val original : t -> Uri.t [@@js.get "original"]
      val modified : t -> Uri.t [@@js.get "modified"]
      val notebookType : t -> string [@@js.get "notebookType"]

      val make : original:Uri.t -> modified:Uri.t -> notebookType:string -> t
      [@@js.new "@vscode.TabInputNotebookDiff"]]
end

module TabInputTerminal = struct
  include Class.Make ()
  include [%js: val make : unit -> t [@@js.new "@vscode.TabInputTerminal"]]
end

module TelemetryTrustedValue = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val value : t -> T.t [@@js.get "value"]
        val make : value:T.t -> t [@@js.new "@vscode.TelemetryTrustedValue"]]
  end
end

module ChatPromptReference = struct
  include Interface.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val range : t -> (int * int) or_undefined [@@js.get "range"]
      val modelDescription : t -> string or_undefined [@@js.get "modelDescription"]
      val value : t -> Ojs.t [@@js.get "value"]]

  let create ~id ?range ?modelDescription ~value () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "id" (Ojs.string_to_js id);
    iter_set
      obj
      "range"
      (fun (v0, v1) ->
         Ojs.array_to_js Ojs.t_to_js [| Ojs.int_to_js v0; Ojs.int_to_js v1 |])
      range;
    iter_set obj "modelDescription" Ojs.string_to_js modelDescription;
    Ojs.set_prop_ascii obj "value" (Ojs.t_to_js value);
    t_of_js obj
  ;;
end

module ChatLanguageModelToolReference = struct
  include Interface.Make ()

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val range : t -> (int * int) or_undefined [@@js.get "range"]]

  let create ~name ?range () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "name" (Ojs.string_to_js name);
    iter_set
      obj
      "range"
      (fun (v0, v1) ->
         Ojs.array_to_js Ojs.t_to_js [| Ojs.int_to_js v0; Ojs.int_to_js v1 |])
      range;
    t_of_js obj
  ;;
end

module ChatRequestTurn = struct
  include Class.Make ()

  include
    [%js:
      val prompt : t -> string [@@js.get "prompt"]
      val participant : t -> string [@@js.get "participant"]
      val command : t -> string or_undefined [@@js.get "command"]
      val references : t -> ChatPromptReference.t list [@@js.get "references"]

      val toolReferences : t -> ChatLanguageModelToolReference.t list
      [@@js.get "toolReferences"]]
end

module ChatResponseMarkdownPart = struct
  include Class.Make ()

  type make_value =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let make_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let make_value_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else invalid_arg "ChatResponseMarkdownPart.make_value: unexpected JavaScript value"
  ;;

  include
    [%js:
      val value : t -> MarkdownString.t [@@js.get "value"]
      val set_value : t -> MarkdownString.t -> unit [@@js.set "value"]
      val make : value:make_value -> t [@@js.new "@vscode.ChatResponseMarkdownPart"]]
end

module ChatResponseFileTree = struct
  include Interface.Make ()

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val children : t -> t list or_undefined [@@js.get "children"]
      val set_children : t -> t list or_undefined -> unit [@@js.set "children"]]

  let create ~name ?children () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "name" (Ojs.string_to_js name);
    iter_set obj "children" (Ojs.list_to_js t_to_js) children;
    t_of_js obj
  ;;
end

module ChatResponseFileTreePart = struct
  include Class.Make ()

  include
    [%js:
      val value : t -> ChatResponseFileTree.t list [@@js.get "value"]
      val set_value : t -> ChatResponseFileTree.t list -> unit [@@js.set "value"]
      val baseUri : t -> Uri.t [@@js.get "baseUri"]
      val set_baseUri : t -> Uri.t -> unit [@@js.set "baseUri"]

      val make : value:ChatResponseFileTree.t list -> baseUri:Uri.t -> t
      [@@js.new "@vscode.ChatResponseFileTreePart"]]
end

module ChatResponseAnchorPart = struct
  include Class.Make ()

  type value =
    [ `Uri of Uri.t
    | `Location of Location.t
    ]

  let value_to_js = function
    | `Uri value -> Uri.t_to_js value
    | `Location value -> Location.t_to_js value
  ;;

  let value_of_js js_val =
    match binding_constructor js_val [ "Uri"; "Location" ] with
    | Some "Uri" -> `Uri (Uri.t_of_js js_val)
    | Some "Location" -> `Location (Location.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "scheme"
        && binding_has_member js_val "authority"
        && binding_has_member js_val "path"
        && binding_has_member js_val "query"
        && binding_has_member js_val "fragment"
        && binding_has_member js_val "fsPath"
        && binding_has_member js_val "with"
        && binding_has_member js_val "toString"
        && binding_has_member js_val "toJSON"
      then `Uri (Uri.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "uri"
        && binding_has_member js_val "range"
      then `Location (Location.t_of_js js_val)
      else invalid_arg "ChatResponseAnchorPart.value: unexpected JavaScript value"
  ;;

  include
    [%js:
      val value : t -> value [@@js.get "value"]
      val set_value : t -> value -> unit [@@js.set "value"]
      val title : t -> string or_undefined [@@js.get "title"]
      val set_title : t -> string or_undefined -> unit [@@js.set "title"]]

  let make ~value ?title () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "ChatResponseAnchorPart")
         (binding_arguments
            [| value_to_js value; (or_undefined_to_js Ojs.string_to_js) title |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module ChatResponseCommandButtonPart = struct
  include Class.Make ()

  include
    [%js:
      val value : t -> Command.t [@@js.get "value"]
      val set_value : t -> Command.t -> unit [@@js.set "value"]
      val make : value:Command.t -> t [@@js.new "@vscode.ChatResponseCommandButtonPart"]]
end

module ChatErrorDetails = struct
  include Interface.Make ()

  include
    [%js:
      val message : t -> string [@@js.get "message"]
      val set_message : t -> string -> unit [@@js.set "message"]
      val responseIsFiltered : t -> bool or_undefined [@@js.get "responseIsFiltered"]

      val set_responseIsFiltered : t -> bool or_undefined -> unit
      [@@js.set "responseIsFiltered"]]

  let create ~message ?responseIsFiltered () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "message" (Ojs.string_to_js message);
    iter_set obj "responseIsFiltered" Ojs.bool_to_js responseIsFiltered;
    t_of_js obj
  ;;
end

module ChatResult = struct
  include Interface.Make ()

  include
    [%js:
      val errorDetails : t -> ChatErrorDetails.t or_undefined [@@js.get "errorDetails"]

      val set_errorDetails : t -> ChatErrorDetails.t or_undefined -> unit
      [@@js.set "errorDetails"]

      val metadata : t -> Ojs.t Dict.t or_undefined [@@js.get "metadata"]]

  let create ?errorDetails ?metadata () =
    let obj = Ojs.obj [||] in
    iter_set obj "errorDetails" ChatErrorDetails.t_to_js errorDetails;
    iter_set obj "metadata" (Dict.t_to_js Ojs.t_to_js) metadata;
    t_of_js obj
  ;;
end

module ChatResponseTurn = struct
  include Class.Make ()

  type response_item =
    [ `ChatResponseMarkdownPart of ChatResponseMarkdownPart.t
    | `ChatResponseFileTreePart of ChatResponseFileTreePart.t
    | `ChatResponseAnchorPart of ChatResponseAnchorPart.t
    | `ChatResponseCommandButtonPart of ChatResponseCommandButtonPart.t
    ]

  let response_item_to_js = function
    | `ChatResponseMarkdownPart value -> ChatResponseMarkdownPart.t_to_js value
    | `ChatResponseFileTreePart value -> ChatResponseFileTreePart.t_to_js value
    | `ChatResponseAnchorPart value -> ChatResponseAnchorPart.t_to_js value
    | `ChatResponseCommandButtonPart value -> ChatResponseCommandButtonPart.t_to_js value
  ;;

  let response_item_of_js js_val =
    match
      binding_constructor
        js_val
        [ "ChatResponseMarkdownPart"
        ; "ChatResponseFileTreePart"
        ; "ChatResponseAnchorPart"
        ; "ChatResponseCommandButtonPart"
        ]
    with
    | Some "ChatResponseMarkdownPart" ->
      `ChatResponseMarkdownPart (ChatResponseMarkdownPart.t_of_js js_val)
    | Some "ChatResponseFileTreePart" ->
      `ChatResponseFileTreePart (ChatResponseFileTreePart.t_of_js js_val)
    | Some "ChatResponseAnchorPart" ->
      `ChatResponseAnchorPart (ChatResponseAnchorPart.t_of_js js_val)
    | Some "ChatResponseCommandButtonPart" ->
      `ChatResponseCommandButtonPart (ChatResponseCommandButtonPart.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
      then `ChatResponseMarkdownPart (ChatResponseMarkdownPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "baseUri"
      then `ChatResponseFileTreePart (ChatResponseFileTreePart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
      then `ChatResponseAnchorPart (ChatResponseAnchorPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
      then `ChatResponseCommandButtonPart (ChatResponseCommandButtonPart.t_of_js js_val)
      else invalid_arg "ChatResponseTurn.response_item: unexpected JavaScript value"
  ;;

  include
    [%js:
      val response : t -> response_item list [@@js.get "response"]
      val result : t -> ChatResult.t [@@js.get "result"]
      val participant : t -> string [@@js.get "participant"]
      val command : t -> string or_undefined [@@js.get "command"]]
end

module ChatContext = struct
  include Interface.Make ()

  type history_item =
    [ `ChatRequestTurn of ChatRequestTurn.t
    | `ChatResponseTurn of ChatResponseTurn.t
    ]

  let history_item_to_js = function
    | `ChatRequestTurn value -> ChatRequestTurn.t_to_js value
    | `ChatResponseTurn value -> ChatResponseTurn.t_to_js value
  ;;

  let history_item_of_js js_val =
    match binding_constructor js_val [ "ChatRequestTurn"; "ChatResponseTurn" ] with
    | Some "ChatRequestTurn" -> `ChatRequestTurn (ChatRequestTurn.t_of_js js_val)
    | Some "ChatResponseTurn" -> `ChatResponseTurn (ChatResponseTurn.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "prompt"
        && binding_has_member js_val "participant"
        && binding_has_member js_val "references"
        && binding_has_member js_val "toolReferences"
      then `ChatRequestTurn (ChatRequestTurn.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "response"
        && binding_has_member js_val "result"
        && binding_has_member js_val "participant"
      then `ChatResponseTurn (ChatResponseTurn.t_of_js js_val)
      else invalid_arg "ChatContext.history_item: unexpected JavaScript value"
  ;;

  include [%js: val history : t -> history_item list [@@js.get "history"]]

  let create ~history () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "history" ((Ojs.list_to_js history_item_to_js) history);
    t_of_js obj
  ;;
end

module ChatResultFeedbackKind = struct
  type t =
    | Unhelpful [@js 0]
    | Helpful [@js 1]
  [@@js.enum] [@@js]
end

module ChatResultFeedback = struct
  include Interface.Make ()

  include
    [%js:
      val result : t -> ChatResult.t [@@js.get "result"]
      val kind : t -> ChatResultFeedbackKind.t [@@js.get "kind"]]

  let create ~result ~kind () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "result" (ChatResult.t_to_js result);
    Ojs.set_prop_ascii obj "kind" (ChatResultFeedbackKind.t_to_js kind);
    t_of_js obj
  ;;
end

module ChatFollowup = struct
  include Interface.Make ()

  include
    [%js:
      val prompt : t -> string [@@js.get "prompt"]
      val set_prompt : t -> string -> unit [@@js.set "prompt"]
      val label : t -> string or_undefined [@@js.get "label"]
      val set_label : t -> string or_undefined -> unit [@@js.set "label"]
      val participant : t -> string or_undefined [@@js.get "participant"]
      val set_participant : t -> string or_undefined -> unit [@@js.set "participant"]
      val command : t -> string or_undefined [@@js.get "command"]
      val set_command : t -> string or_undefined -> unit [@@js.set "command"]]

  let create ~prompt ?label ?participant ?command () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "prompt" (Ojs.string_to_js prompt);
    iter_set obj "label" Ojs.string_to_js label;
    iter_set obj "participant" Ojs.string_to_js participant;
    iter_set obj "command" Ojs.string_to_js command;
    t_of_js obj
  ;;
end

module ChatFollowupProvider = struct
  include Interface.Make ()

  include
    [%js:
      val provideFollowups
        :  t
        -> result:ChatResult.t
        -> context:ChatContext.t
        -> token:CancellationToken.t
        -> ChatFollowup.t list ProviderResult.t
      [@@js.call "provideFollowups"]]

  let create ~provideFollowups () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii
      obj
      "provideFollowups"
      ([%js.of:
         result:ChatResult.t
         -> context:ChatContext.t
         -> token:CancellationToken.t
         -> ChatFollowup.t list ProviderResult.t]
         provideFollowups);
    t_of_js obj
  ;;
end

module ChatParticipantToolToken = struct
  include Interface.Make ()
end

module ChatRequest = struct
  include Interface.Make ()

  include
    [%js:
      val prompt : t -> string [@@js.get "prompt"]
      val command : t -> string or_undefined [@@js.get "command"]
      val references : t -> ChatPromptReference.t list [@@js.get "references"]

      val toolReferences : t -> ChatLanguageModelToolReference.t list
      [@@js.get "toolReferences"]

      val toolInvocationToken : t -> ChatParticipantToolToken.t
      [@@js.get "toolInvocationToken"]

      val model : t -> LanguageModelChat.t [@@js.get "model"]]

  let create ~prompt ~command ~references ~toolReferences ~toolInvocationToken ~model () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "prompt" (Ojs.string_to_js prompt);
    Ojs.set_prop_ascii obj "command" ((or_undefined_to_js Ojs.string_to_js) command);
    Ojs.set_prop_ascii
      obj
      "references"
      ((Ojs.list_to_js ChatPromptReference.t_to_js) references);
    Ojs.set_prop_ascii
      obj
      "toolReferences"
      ((Ojs.list_to_js ChatLanguageModelToolReference.t_to_js) toolReferences);
    Ojs.set_prop_ascii
      obj
      "toolInvocationToken"
      (ChatParticipantToolToken.t_to_js toolInvocationToken);
    Ojs.set_prop_ascii obj "model" (LanguageModelChat.t_to_js model);
    t_of_js obj
  ;;
end

module ChatResponseProgressPart = struct
  include Class.Make ()

  include
    [%js:
      val value : t -> string [@@js.get "value"]
      val set_value : t -> string -> unit [@@js.set "value"]
      val make : value:string -> t [@@js.new "@vscode.ChatResponseProgressPart"]]
end

module ChatResponseReferencePart = struct
  include Class.Make ()

  type value =
    [ `Uri of Uri.t
    | `Location of Location.t
    ]

  let value_to_js = function
    | `Uri value -> Uri.t_to_js value
    | `Location value -> Location.t_to_js value
  ;;

  let value_of_js js_val =
    match binding_constructor js_val [ "Uri"; "Location" ] with
    | Some "Uri" -> `Uri (Uri.t_of_js js_val)
    | Some "Location" -> `Location (Location.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "scheme"
        && binding_has_member js_val "authority"
        && binding_has_member js_val "path"
        && binding_has_member js_val "query"
        && binding_has_member js_val "fragment"
        && binding_has_member js_val "fsPath"
        && binding_has_member js_val "with"
        && binding_has_member js_val "toString"
        && binding_has_member js_val "toJSON"
      then `Uri (Uri.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "uri"
        && binding_has_member js_val "range"
      then `Location (Location.t_of_js js_val)
      else invalid_arg "ChatResponseReferencePart.value: unexpected JavaScript value"
  ;;

  include
    [%js:
      val value : t -> value [@@js.get "value"]
      val set_value : t -> value -> unit [@@js.set "value"]
      val iconPath : t -> IconPath.t or_undefined [@@js.get "iconPath"]
      val set_iconPath : t -> IconPath.t or_undefined -> unit [@@js.set "iconPath"]]

  let make ~value ?iconPath () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "ChatResponseReferencePart")
         (binding_arguments
            [| value_to_js value; (or_undefined_to_js IconPath.t_to_js) iconPath |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module ChatResponsePart = struct
  type value =
    [ `ChatResponseMarkdownPart of ChatResponseMarkdownPart.t
    | `ChatResponseFileTreePart of ChatResponseFileTreePart.t
    | `ChatResponseAnchorPart of ChatResponseAnchorPart.t
    | `ChatResponseProgressPart of ChatResponseProgressPart.t
    | `ChatResponseReferencePart of ChatResponseReferencePart.t
    | `ChatResponseCommandButtonPart of ChatResponseCommandButtonPart.t
    ]

  let value_to_js = function
    | `ChatResponseMarkdownPart value -> ChatResponseMarkdownPart.t_to_js value
    | `ChatResponseFileTreePart value -> ChatResponseFileTreePart.t_to_js value
    | `ChatResponseAnchorPart value -> ChatResponseAnchorPart.t_to_js value
    | `ChatResponseProgressPart value -> ChatResponseProgressPart.t_to_js value
    | `ChatResponseReferencePart value -> ChatResponseReferencePart.t_to_js value
    | `ChatResponseCommandButtonPart value -> ChatResponseCommandButtonPart.t_to_js value
  ;;

  let value_of_js js_val =
    match
      binding_constructor
        js_val
        [ "ChatResponseMarkdownPart"
        ; "ChatResponseFileTreePart"
        ; "ChatResponseAnchorPart"
        ; "ChatResponseProgressPart"
        ; "ChatResponseReferencePart"
        ; "ChatResponseCommandButtonPart"
        ]
    with
    | Some "ChatResponseMarkdownPart" ->
      `ChatResponseMarkdownPart (ChatResponseMarkdownPart.t_of_js js_val)
    | Some "ChatResponseFileTreePart" ->
      `ChatResponseFileTreePart (ChatResponseFileTreePart.t_of_js js_val)
    | Some "ChatResponseAnchorPart" ->
      `ChatResponseAnchorPart (ChatResponseAnchorPart.t_of_js js_val)
    | Some "ChatResponseProgressPart" ->
      `ChatResponseProgressPart (ChatResponseProgressPart.t_of_js js_val)
    | Some "ChatResponseReferencePart" ->
      `ChatResponseReferencePart (ChatResponseReferencePart.t_of_js js_val)
    | Some "ChatResponseCommandButtonPart" ->
      `ChatResponseCommandButtonPart (ChatResponseCommandButtonPart.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
      then `ChatResponseMarkdownPart (ChatResponseMarkdownPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "baseUri"
      then `ChatResponseFileTreePart (ChatResponseFileTreePart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
      then `ChatResponseAnchorPart (ChatResponseAnchorPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
      then `ChatResponseProgressPart (ChatResponseProgressPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
      then `ChatResponseReferencePart (ChatResponseReferencePart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
      then `ChatResponseCommandButtonPart (ChatResponseCommandButtonPart.t_of_js js_val)
      else invalid_arg "ChatResponsePart.value: unexpected JavaScript value"
  ;;

  type t = value

  let t_to_js = value_to_js
  let t_of_js = value_of_js
end

module ChatResponseStream = struct
  include Interface.Make ()

  type markdown_value =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let markdown_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let markdown_value_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else invalid_arg "ChatResponseStream.markdown_value: unexpected JavaScript value"
  ;;

  type anchor_value =
    [ `Uri of Uri.t
    | `Location of Location.t
    ]

  let anchor_value_to_js = function
    | `Uri value -> Uri.t_to_js value
    | `Location value -> Location.t_to_js value
  ;;

  let anchor_value_of_js js_val =
    match binding_constructor js_val [ "Uri"; "Location" ] with
    | Some "Uri" -> `Uri (Uri.t_of_js js_val)
    | Some "Location" -> `Location (Location.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "scheme"
        && binding_has_member js_val "authority"
        && binding_has_member js_val "path"
        && binding_has_member js_val "query"
        && binding_has_member js_val "fragment"
        && binding_has_member js_val "fsPath"
        && binding_has_member js_val "with"
        && binding_has_member js_val "toString"
        && binding_has_member js_val "toJSON"
      then `Uri (Uri.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "uri"
        && binding_has_member js_val "range"
      then `Location (Location.t_of_js js_val)
      else invalid_arg "ChatResponseStream.anchor_value: unexpected JavaScript value"
  ;;

  include [%js: val markdown : t -> value:markdown_value -> unit [@@js.call "markdown"]]

  let anchor this ~value ?title () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "anchor"
         (binding_arguments
            [| anchor_value_to_js value; (or_undefined_to_js Ojs.string_to_js) title |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val button : t -> command:Command.t -> unit [@@js.call "button"]

      val filetree : t -> value:ChatResponseFileTree.t list -> baseUri:Uri.t -> unit
      [@@js.call "filetree"]

      val progress : t -> value:string -> unit [@@js.call "progress"]]

  let reference this ~value ?iconPath () =
    (fun _ -> ())
      (Ojs.call
         (t_to_js this)
         "reference"
         (binding_arguments
            [| anchor_value_to_js value; (or_undefined_to_js IconPath.t_to_js) iconPath |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include [%js: val push : t -> part:ChatResponsePart.t -> unit [@@js.call "push"]]

  let create ~markdown ~anchor ~button ~filetree ~progress ~reference ~push () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "markdown" ([%js.of: value:markdown_value -> unit] markdown);
    Ojs.set_prop_ascii
      obj
      "anchor"
      ([%js.of: value:anchor_value -> ?title:string -> unit -> unit] anchor);
    Ojs.set_prop_ascii obj "button" ([%js.of: command:Command.t -> unit] button);
    Ojs.set_prop_ascii
      obj
      "filetree"
      ([%js.of: value:ChatResponseFileTree.t list -> baseUri:Uri.t -> unit] filetree);
    Ojs.set_prop_ascii obj "progress" ([%js.of: value:string -> unit] progress);
    Ojs.set_prop_ascii
      obj
      "reference"
      ([%js.of: value:anchor_value -> ?iconPath:IconPath.t -> unit -> unit] reference);
    Ojs.set_prop_ascii obj "push" ([%js.of: part:ChatResponsePart.t -> unit] push);
    t_of_js obj
  ;;
end

module ChatRequestHandler = struct
  type value_result_t =
    [ `ChatResult of ChatResult.t
    | `Unit of unit
    ]

  let value_result_t_to_js = function
    | `ChatResult value -> ChatResult.t_to_js value
    | `Unit value -> (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None) value
  ;;

  let value_result_t_of_js js_val =
    if Ojs.type_of js_val = "object" && not (Ojs.is_null js_val)
    then `ChatResult (ChatResult.t_of_js js_val)
    else if Ojs.is_null js_val
    then `Unit ((fun _ -> ()) js_val)
    else invalid_arg "ChatRequestHandler.value_result_t: unexpected JavaScript value"
  ;;

  type t =
    request:ChatRequest.t
    -> context:ChatContext.t
    -> response:ChatResponseStream.t
    -> token:CancellationToken.t
    -> value_result_t ProviderResult.t

  let t_to_js =
    [%js.of:
      request:ChatRequest.t
      -> context:ChatContext.t
      -> response:ChatResponseStream.t
      -> token:CancellationToken.t
      -> value_result_t ProviderResult.t]
  ;;

  let t_of_js =
    [%js.to:
      request:ChatRequest.t
      -> context:ChatContext.t
      -> response:ChatResponseStream.t
      -> token:CancellationToken.t
      -> value_result_t ProviderResult.t]
  ;;
end

module ChatParticipant = struct
  include Interface.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val iconPath : t -> IconPath.t or_undefined [@@js.get "iconPath"]
      val set_iconPath : t -> IconPath.t or_undefined -> unit [@@js.set "iconPath"]
      val requestHandler : t -> ChatRequestHandler.t [@@js.get "requestHandler"]

      val set_requestHandler : t -> ChatRequestHandler.t -> unit
      [@@js.set "requestHandler"]

      val followupProvider : t -> ChatFollowupProvider.t or_undefined
      [@@js.get "followupProvider"]

      val set_followupProvider : t -> ChatFollowupProvider.t or_undefined -> unit
      [@@js.set "followupProvider"]

      val onDidReceiveFeedback : t -> ChatResultFeedback.t Event.t
      [@@js.get "onDidReceiveFeedback"]

      val dispose : t -> unit [@@js.call "dispose"]]
end

module Chat = struct
  include
    [%js:
      val createChatParticipant
        :  id:string
        -> handler:ChatRequestHandler.t
        -> ChatParticipant.t
      [@@js.global "@vscode.chat.createChatParticipant"]]
end

module LanguageModelChatSelector = struct
  include Interface.Make ()

  include
    [%js:
      val vendor : t -> string or_undefined [@@js.get "vendor"]
      val set_vendor : t -> string or_undefined -> unit [@@js.set "vendor"]
      val family : t -> string or_undefined [@@js.get "family"]
      val set_family : t -> string or_undefined -> unit [@@js.set "family"]
      val version : t -> string or_undefined [@@js.get "version"]
      val set_version : t -> string or_undefined -> unit [@@js.set "version"]
      val id : t -> string or_undefined [@@js.get "id"]
      val set_id : t -> string or_undefined -> unit [@@js.set "id"]]

  let create ?vendor ?family ?version ?id () =
    let obj = Ojs.obj [||] in
    iter_set obj "vendor" Ojs.string_to_js vendor;
    iter_set obj "family" Ojs.string_to_js family;
    iter_set obj "version" Ojs.string_to_js version;
    iter_set obj "id" Ojs.string_to_js id;
    t_of_js obj
  ;;
end

module LanguageModelError = struct
  include Interface.Extend (JsError) ()

  type make_options = { cause : Ojs.t or_undefined }

  let make_options_to_js (value : make_options) =
    let js_val = Ojs.obj [||] in
    iter_set js_val "cause" Ojs.t_to_js value.cause;
    js_val
  ;;

  let make_options_of_js js_val : make_options =
    { cause = (or_undefined_of_js Ojs.t_of_js) (Ojs.get_prop_ascii js_val "cause") }
  ;;

  let to_js_error (value : t) = (value :> JsError.t)

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val set_name : t -> string -> unit [@@js.set "name"]
      val message : t -> string [@@js.get "message"]
      val set_message : t -> string -> unit [@@js.set "message"]
      val stack : t -> string or_undefined [@@js.get "stack"]
      val set_stack : t -> string or_undefined -> unit [@@js.set "stack"]
      val cause : t -> Ojs.t or_undefined [@@js.get "cause"]
      val set_cause : t -> Ojs.t or_undefined -> unit [@@js.set "cause"]]

  let noPermissions ?message () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "LanguageModelError")
         "NoPermissions"
         (binding_arguments
            [| (or_undefined_to_js Ojs.string_to_js) message |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let blocked ?message () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "LanguageModelError")
         "Blocked"
         (binding_arguments
            [| (or_undefined_to_js Ojs.string_to_js) message |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let notFound ?message () =
    t_of_js
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "LanguageModelError")
         "NotFound"
         (binding_arguments
            [| (or_undefined_to_js Ojs.string_to_js) message |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include [%js: val code : t -> string [@@js.get "code"]]

  let make ?message ?options () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "LanguageModelError")
         (binding_arguments
            [| (or_undefined_to_js Ojs.string_to_js) message
             ; (or_undefined_to_js make_options_to_js) options
            |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module McpStdioServerDefinition = struct
  include Class.Make ()

  type env_value =
    [ `String of string
    | `Float of float
    | `Null
    ]

  let env_value_to_js = function
    | `String value -> Ojs.string_to_js value
    | `Float value -> Ojs.float_to_js value
    | `Null -> Ojs.null
  ;;

  let env_value_of_js js_val =
    if Ojs.type_of js_val = "string"
    then `String (Ojs.string_of_js js_val)
    else if Ojs.type_of js_val = "number"
    then `Float (Ojs.float_of_js js_val)
    else if Ojs.type_of js_val = "object" && Ojs.is_null js_val
    then `Null
    else invalid_arg "McpStdioServerDefinition.env_value: unexpected JavaScript value"
  ;;

  include
    [%js:
      val label : t -> string [@@js.get "label"]
      val cwd : t -> Uri.t or_undefined [@@js.get "cwd"]
      val set_cwd : t -> Uri.t or_undefined -> unit [@@js.set "cwd"]
      val command : t -> string [@@js.get "command"]
      val set_command : t -> string -> unit [@@js.set "command"]]

  let args this =
    (maybe_list_of_js Ojs.string_of_js) (Ojs.get_prop_ascii (t_to_js this) "args")
  ;;

  include [%js: val set_args : t -> string list -> unit [@@js.set "args"]]

  let env this =
    let value = Ojs.get_prop_ascii (t_to_js this) "env" in
    if Ojs.type_of value = "undefined"
    then Dict.empty
    else (Dict.t_of_js env_value_of_js) value
  ;;

  include
    [%js:
      val set_env : t -> env_value Dict.t -> unit [@@js.set "env"]
      val version : t -> string or_undefined [@@js.get "version"]
      val set_version : t -> string or_undefined -> unit [@@js.set "version"]]

  let make ~label ~command ?args ?env ?version () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "McpStdioServerDefinition")
         (binding_arguments
            [| Ojs.string_to_js label
             ; Ojs.string_to_js command
             ; (Ojs.list_to_js Ojs.string_to_js) (Option.value args ~default:[])
             ; (Dict.t_to_js env_value_to_js) (Option.value env ~default:Dict.empty)
             ; (or_undefined_to_js Ojs.string_to_js) version
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module McpHttpServerDefinition = struct
  include Class.Make ()

  include
    [%js:
      val label : t -> string [@@js.get "label"]
      val uri : t -> Uri.t [@@js.get "uri"]
      val set_uri : t -> Uri.t -> unit [@@js.set "uri"]]

  let headers this =
    let value = Ojs.get_prop_ascii (t_to_js this) "headers" in
    if Ojs.type_of value = "undefined"
    then Dict.empty
    else (Dict.t_of_js Ojs.string_of_js) value
  ;;

  include
    [%js:
      val set_headers : t -> string Dict.t -> unit [@@js.set "headers"]
      val version : t -> string or_undefined [@@js.get "version"]
      val set_version : t -> string or_undefined -> unit [@@js.set "version"]]

  let make ~label ~uri ?headers ?version () =
    t_of_js
      (Ojs.new_obj
         (Ojs.get_prop_ascii vscode_module "McpHttpServerDefinition")
         (binding_arguments
            [| Ojs.string_to_js label
             ; Uri.t_to_js uri
             ; (Dict.t_to_js Ojs.string_to_js) (Option.value headers ~default:Dict.empty)
             ; (or_undefined_to_js Ojs.string_to_js) version
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;
end

module McpServerDefinition = struct
  type value =
    [ `McpStdioServerDefinition of McpStdioServerDefinition.t
    | `McpHttpServerDefinition of McpHttpServerDefinition.t
    ]

  let value_to_js = function
    | `McpStdioServerDefinition value -> McpStdioServerDefinition.t_to_js value
    | `McpHttpServerDefinition value -> McpHttpServerDefinition.t_to_js value
  ;;

  let value_of_js js_val =
    match
      binding_constructor js_val [ "McpStdioServerDefinition"; "McpHttpServerDefinition" ]
    with
    | Some "McpStdioServerDefinition" ->
      `McpStdioServerDefinition (McpStdioServerDefinition.t_of_js js_val)
    | Some "McpHttpServerDefinition" ->
      `McpHttpServerDefinition (McpHttpServerDefinition.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "label"
        && binding_has_member js_val "command"
        && binding_has_member js_val "args"
        && binding_has_member js_val "env"
      then `McpStdioServerDefinition (McpStdioServerDefinition.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "label"
        && binding_has_member js_val "uri"
        && binding_has_member js_val "headers"
      then `McpHttpServerDefinition (McpHttpServerDefinition.t_of_js js_val)
      else invalid_arg "McpServerDefinition.value: unexpected JavaScript value"
  ;;

  type t = value

  let t_to_js = value_to_js
  let t_of_js = value_of_js
end

module McpServerDefinitionProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val onDidChangeMcpServerDefinitions : t -> unit Event.t or_undefined
        [@@js.get "onDidChangeMcpServerDefinitions"]

        val provideMcpServerDefinitions
          :  t
          -> token:CancellationToken.t
          -> T.t list ProviderResult.t
        [@@js.call "provideMcpServerDefinitions"]]

    let resolveMcpServerDefinition this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "resolveMcpServerDefinition" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to: server:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create
          ?onDidChangeMcpServerDefinitions
          ~provideMcpServerDefinitions
          ?resolveMcpServerDefinition
          ()
      =
      let obj = Ojs.obj [||] in
      iter_set
        obj
        "onDidChangeMcpServerDefinitions"
        (Event.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None))
        onDidChangeMcpServerDefinitions;
      Ojs.set_prop_ascii
        obj
        "provideMcpServerDefinitions"
        ([%js.of: token:CancellationToken.t -> T.t list ProviderResult.t]
           provideMcpServerDefinitions);
      iter_set
        obj
        "resolveMcpServerDefinition"
        [%js.of: server:T.t -> token:CancellationToken.t -> T.t ProviderResult.t]
        resolveMcpServerDefinition;
      t_of_js obj
    ;;
  end
end

module ProvideLanguageModelChatResponseOptions = struct
  include Interface.Make ()

  include
    [%js:
      val modelOptions : t -> Ojs.t Dict.t or_undefined [@@js.get "modelOptions"]
      val tools : t -> LanguageModelChatTool.t list or_undefined [@@js.get "tools"]
      val toolMode : t -> LanguageModelChatToolMode.t [@@js.get "toolMode"]]

  let create ?modelOptions ?tools ~toolMode () =
    let obj = Ojs.obj [||] in
    iter_set obj "modelOptions" (Dict.t_to_js Ojs.t_to_js) modelOptions;
    iter_set obj "tools" (Ojs.list_to_js LanguageModelChatTool.t_to_js) tools;
    Ojs.set_prop_ascii obj "toolMode" (LanguageModelChatToolMode.t_to_js toolMode);
    t_of_js obj
  ;;
end

module LanguageModelChatCapabilities = struct
  include Interface.Make ()

  type tool_calling =
    [ `Bool of bool
    | `Int of int
    ]

  let tool_calling_to_js = function
    | `Bool value -> Ojs.bool_to_js value
    | `Int value -> Ojs.int_to_js value
  ;;

  let tool_calling_of_js js_val =
    if Ojs.type_of js_val = "boolean"
    then `Bool (Ojs.bool_of_js js_val)
    else if Ojs.type_of js_val = "number"
    then `Int (Ojs.int_of_js js_val)
    else
      invalid_arg
        "LanguageModelChatCapabilities.tool_calling: unexpected JavaScript value"
  ;;

  include
    [%js:
      val imageInput : t -> bool or_undefined [@@js.get "imageInput"]
      val toolCalling : t -> tool_calling or_undefined [@@js.get "toolCalling"]]

  let create ?imageInput ?toolCalling () =
    let obj = Ojs.obj [||] in
    iter_set obj "imageInput" Ojs.bool_to_js imageInput;
    iter_set obj "toolCalling" tool_calling_to_js toolCalling;
    t_of_js obj
  ;;
end

module LanguageModelChatInformation = struct
  include Interface.Make ()

  include
    [%js:
      val id : t -> string [@@js.get "id"]
      val name : t -> string [@@js.get "name"]
      val family : t -> string [@@js.get "family"]
      val tooltip : t -> string or_undefined [@@js.get "tooltip"]
      val detail : t -> string or_undefined [@@js.get "detail"]
      val version : t -> string [@@js.get "version"]
      val maxInputTokens : t -> int [@@js.get "maxInputTokens"]
      val maxOutputTokens : t -> int [@@js.get "maxOutputTokens"]
      val capabilities : t -> LanguageModelChatCapabilities.t [@@js.get "capabilities"]]

  let create
        ~id
        ~name
        ~family
        ?tooltip
        ?detail
        ~version
        ~maxInputTokens
        ~maxOutputTokens
        ~capabilities
        ()
    =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "id" (Ojs.string_to_js id);
    Ojs.set_prop_ascii obj "name" (Ojs.string_to_js name);
    Ojs.set_prop_ascii obj "family" (Ojs.string_to_js family);
    iter_set obj "tooltip" Ojs.string_to_js tooltip;
    iter_set obj "detail" Ojs.string_to_js detail;
    Ojs.set_prop_ascii obj "version" (Ojs.string_to_js version);
    Ojs.set_prop_ascii obj "maxInputTokens" (Ojs.int_to_js maxInputTokens);
    Ojs.set_prop_ascii obj "maxOutputTokens" (Ojs.int_to_js maxOutputTokens);
    Ojs.set_prop_ascii
      obj
      "capabilities"
      (LanguageModelChatCapabilities.t_to_js capabilities);
    t_of_js obj
  ;;
end

module LanguageModelChatRequestMessage = struct
  include Interface.Make ()

  include
    [%js:
      val role : t -> LanguageModelChatMessageRole.t [@@js.get "role"]
      val content : t -> Ojs.t list [@@js.get "content"]
      val name : t -> string or_undefined [@@js.get "name"]]

  let create ~role ~content ~name () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "role" (LanguageModelChatMessageRole.t_to_js role);
    Ojs.set_prop_ascii obj "content" ((Ojs.list_to_js Ojs.t_to_js) content);
    Ojs.set_prop_ascii obj "name" ((or_undefined_to_js Ojs.string_to_js) name);
    t_of_js obj
  ;;
end

module LanguageModelResponsePart = struct
  type value =
    [ `LanguageModelTextPart of LanguageModelTextPart.t
    | `LanguageModelToolResultPart of LanguageModelToolResultPart.t
    | `LanguageModelToolCallPart of LanguageModelToolCallPart.t
    | `LanguageModelDataPart of LanguageModelDataPart.t
    ]

  let value_to_js = function
    | `LanguageModelTextPart value -> LanguageModelTextPart.t_to_js value
    | `LanguageModelToolResultPart value -> LanguageModelToolResultPart.t_to_js value
    | `LanguageModelToolCallPart value -> LanguageModelToolCallPart.t_to_js value
    | `LanguageModelDataPart value -> LanguageModelDataPart.t_to_js value
  ;;

  let value_of_js js_val =
    match
      binding_constructor
        js_val
        [ "LanguageModelTextPart"
        ; "LanguageModelToolResultPart"
        ; "LanguageModelToolCallPart"
        ; "LanguageModelDataPart"
        ]
    with
    | Some "LanguageModelTextPart" ->
      `LanguageModelTextPart (LanguageModelTextPart.t_of_js js_val)
    | Some "LanguageModelToolResultPart" ->
      `LanguageModelToolResultPart (LanguageModelToolResultPart.t_of_js js_val)
    | Some "LanguageModelToolCallPart" ->
      `LanguageModelToolCallPart (LanguageModelToolCallPart.t_of_js js_val)
    | Some "LanguageModelDataPart" ->
      `LanguageModelDataPart (LanguageModelDataPart.t_of_js js_val)
    | _ ->
      if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
      then `LanguageModelTextPart (LanguageModelTextPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "callId"
        && binding_has_member js_val "content"
      then `LanguageModelToolResultPart (LanguageModelToolResultPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "callId"
        && binding_has_member js_val "name"
        && binding_has_member js_val "input"
      then `LanguageModelToolCallPart (LanguageModelToolCallPart.t_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "mimeType"
        && binding_has_member js_val "data"
      then `LanguageModelDataPart (LanguageModelDataPart.t_of_js js_val)
      else invalid_arg "LanguageModelResponsePart.value: unexpected JavaScript value"
  ;;

  type t = value

  let t_to_js = value_to_js
  let t_of_js = value_of_js
end

module PrepareLanguageModelChatModelOptions = struct
  include Interface.Make ()
  include [%js: val silent : t -> bool [@@js.get "silent"]]

  let create ~silent () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "silent" (Ojs.bool_to_js silent);
    t_of_js obj
  ;;
end

module LanguageModelChatProvider = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    type provide_token_count_text =
      [ `String of string
      | `LanguageModelChatRequestMessage of LanguageModelChatRequestMessage.t
      ]

    let provide_token_count_text_to_js = function
      | `String value -> Ojs.string_to_js value
      | `LanguageModelChatRequestMessage value ->
        LanguageModelChatRequestMessage.t_to_js value
    ;;

    let provide_token_count_text_of_js js_val =
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "role"
        && binding_has_member js_val "content"
        && binding_has_member js_val "name"
      then
        `LanguageModelChatRequestMessage (LanguageModelChatRequestMessage.t_of_js js_val)
      else
        invalid_arg
          "LanguageModelChatProvider.provide_token_count_text: unexpected JavaScript \
           value"
    ;;

    include
      [%js:
        val onDidChangeLanguageModelChatInformation : t -> unit Event.t or_undefined
        [@@js.get "onDidChangeLanguageModelChatInformation"]

        val provideLanguageModelChatInformation
          :  t
          -> options:PrepareLanguageModelChatModelOptions.t
          -> token:CancellationToken.t
          -> T.t list ProviderResult.t
        [@@js.call "provideLanguageModelChatInformation"]

        val provideLanguageModelChatResponse
          :  t
          -> model:T.t
          -> messages:LanguageModelChatRequestMessage.t list
          -> options:ProvideLanguageModelChatResponseOptions.t
          -> progress:LanguageModelResponsePart.t Progress.t
          -> token:CancellationToken.t
          -> unit Promise.t
        [@@js.call "provideLanguageModelChatResponse"]

        val provideTokenCount
          :  t
          -> model:T.t
          -> text:provide_token_count_text
          -> token:CancellationToken.t
          -> int Promise.t
        [@@js.call "provideTokenCount"]]

    let create
          ?onDidChangeLanguageModelChatInformation
          ~provideLanguageModelChatInformation
          ~provideLanguageModelChatResponse
          ~provideTokenCount
          ()
      =
      let obj = Ojs.obj [||] in
      iter_set
        obj
        "onDidChangeLanguageModelChatInformation"
        (Event.t_to_js (fun () -> Interop.or_undefined_to_js Ojs.t_to_js None))
        onDidChangeLanguageModelChatInformation;
      Ojs.set_prop_ascii
        obj
        "provideLanguageModelChatInformation"
        ([%js.of:
           options:PrepareLanguageModelChatModelOptions.t
           -> token:CancellationToken.t
           -> T.t list ProviderResult.t]
           provideLanguageModelChatInformation);
      Ojs.set_prop_ascii
        obj
        "provideLanguageModelChatResponse"
        ([%js.of:
           model:T.t
           -> messages:LanguageModelChatRequestMessage.t list
           -> options:ProvideLanguageModelChatResponseOptions.t
           -> progress:LanguageModelResponsePart.t Progress.t
           -> token:CancellationToken.t
           -> unit Promise.t]
           provideLanguageModelChatResponse);
      Ojs.set_prop_ascii
        obj
        "provideTokenCount"
        ([%js.of:
           model:T.t
           -> text:provide_token_count_text
           -> token:CancellationToken.t
           -> int Promise.t]
           provideTokenCount);
      t_of_js obj
    ;;
  end
end

module LanguageModelToolTokenizationOptions = struct
  include Interface.Make ()

  include
    [%js:
      val tokenBudget : t -> int [@@js.get "tokenBudget"]
      val set_tokenBudget : t -> int -> unit [@@js.set "tokenBudget"]]

  let countTokens this ~text ?token () =
    (Promise.t_of_js Ojs.int_of_js)
      (Ojs.call
         (t_to_js this)
         "countTokens"
         (binding_arguments
            [| Ojs.string_to_js text
             ; (or_undefined_to_js CancellationToken.t_to_js) token
            |]
            1
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  let create ~tokenBudget ~countTokens () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "tokenBudget" (Ojs.int_to_js tokenBudget);
    Ojs.set_prop_ascii
      obj
      "countTokens"
      ([%js.of: text:string -> ?token:CancellationToken.t -> unit -> int Promise.t]
         countTokens);
    t_of_js obj
  ;;
end

module LanguageModelToolInvocationOptions = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val toolInvocationToken : t -> ChatParticipantToolToken.t or_undefined
        [@@js.get "toolInvocationToken"]

        val set_toolInvocationToken : t -> ChatParticipantToolToken.t or_undefined -> unit
        [@@js.set "toolInvocationToken"]

        val input : t -> T.t [@@js.get "input"]
        val set_input : t -> T.t -> unit [@@js.set "input"]

        val tokenizationOptions : t -> LanguageModelToolTokenizationOptions.t or_undefined
        [@@js.get "tokenizationOptions"]

        val set_tokenizationOptions
          :  t
          -> LanguageModelToolTokenizationOptions.t or_undefined
          -> unit
        [@@js.set "tokenizationOptions"]]

    let create ~toolInvocationToken ~input ?tokenizationOptions () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "toolInvocationToken"
        ((or_undefined_to_js ChatParticipantToolToken.t_to_js) toolInvocationToken);
      Ojs.set_prop_ascii obj "input" (T.t_to_js input);
      iter_set
        obj
        "tokenizationOptions"
        LanguageModelToolTokenizationOptions.t_to_js
        tokenizationOptions;
      t_of_js obj
    ;;
  end
end

module LanguageModelToolResult = struct
  include Class.Make ()

  include
    [%js:
      val content : t -> Ojs.t list [@@js.get "content"]
      val set_content : t -> Ojs.t list -> unit [@@js.set "content"]
      val make : content:Ojs.t list -> t [@@js.new "@vscode.LanguageModelToolResult"]]
end

module LanguageModelToolInvocationPrepareOptions = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val input : t -> T.t [@@js.get "input"]
        val set_input : t -> T.t -> unit [@@js.set "input"]]

    let create ~input () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii obj "input" (T.t_to_js input);
      t_of_js obj
    ;;
  end
end

module LanguageModelToolConfirmationMessages = struct
  include Interface.Make ()

  type message =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let message_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let message_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else
        invalid_arg
          "LanguageModelToolConfirmationMessages.message: unexpected JavaScript value"
  ;;

  include
    [%js:
      val title : t -> string [@@js.get "title"]
      val set_title : t -> string -> unit [@@js.set "title"]
      val message : t -> message [@@js.get "message"]
      val set_message : t -> message -> unit [@@js.set "message"]]

  let create ~title ~message () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "title" (Ojs.string_to_js title);
    Ojs.set_prop_ascii obj "message" (message_to_js message);
    t_of_js obj
  ;;
end

module PreparedToolInvocation = struct
  include Interface.Make ()

  type invocation_message =
    [ `String of string
    | `MarkdownString of MarkdownString.t
    ]

  let invocation_message_to_js = function
    | `String value -> Ojs.string_to_js value
    | `MarkdownString value -> MarkdownString.t_to_js value
  ;;

  let invocation_message_of_js js_val =
    match binding_constructor js_val [ "MarkdownString" ] with
    | Some "MarkdownString" -> `MarkdownString (MarkdownString.t_of_js js_val)
    | _ ->
      if Ojs.type_of js_val = "string"
      then `String (Ojs.string_of_js js_val)
      else if
        Ojs.type_of js_val = "object"
        && (not (Ojs.is_null js_val))
        && binding_has_member js_val "value"
        && binding_has_member js_val "appendText"
        && binding_has_member js_val "appendMarkdown"
        && binding_has_member js_val "appendCodeblock"
      then `MarkdownString (MarkdownString.t_of_js js_val)
      else
        invalid_arg
          "PreparedToolInvocation.invocation_message: unexpected JavaScript value"
  ;;

  include
    [%js:
      val invocationMessage : t -> invocation_message or_undefined
      [@@js.get "invocationMessage"]

      val set_invocationMessage : t -> invocation_message or_undefined -> unit
      [@@js.set "invocationMessage"]

      val confirmationMessages : t -> LanguageModelToolConfirmationMessages.t or_undefined
      [@@js.get "confirmationMessages"]

      val set_confirmationMessages
        :  t
        -> LanguageModelToolConfirmationMessages.t or_undefined
        -> unit
      [@@js.set "confirmationMessages"]]

  let create ?invocationMessage ?confirmationMessages () =
    let obj = Ojs.obj [||] in
    iter_set obj "invocationMessage" invocation_message_to_js invocationMessage;
    iter_set
      obj
      "confirmationMessages"
      LanguageModelToolConfirmationMessages.t_to_js
      confirmationMessages;
    t_of_js obj
  ;;
end

module LanguageModelTool = struct
  module G = Interface.Generic (Ojs) ()
  include G

  module Make (T : Ojs.T) = struct
    type t = T.t G.t [@@js]

    include
      [%js:
        val invoke
          :  t
          -> options:T.t LanguageModelToolInvocationOptions.t
          -> token:CancellationToken.t
          -> LanguageModelToolResult.t ProviderResult.t
        [@@js.call "invoke"]]

    let prepareInvocation this =
      let this = t_to_js this in
      let callback = Ojs.get_prop_ascii this "prepareInvocation" in
      if Ojs.is_null callback
      then None
      else
        Some
          ([%js.to:
             options:T.t LanguageModelToolInvocationPrepareOptions.t
             -> token:CancellationToken.t
             -> PreparedToolInvocation.t ProviderResult.t]
             (Ojs.call callback "bind" [| this |]))
    ;;

    let create ~invoke ?prepareInvocation () =
      let obj = Ojs.obj [||] in
      Ojs.set_prop_ascii
        obj
        "invoke"
        ([%js.of:
           options:T.t LanguageModelToolInvocationOptions.t
           -> token:CancellationToken.t
           -> LanguageModelToolResult.t ProviderResult.t]
           invoke);
      iter_set
        obj
        "prepareInvocation"
        [%js.of:
          options:T.t LanguageModelToolInvocationPrepareOptions.t
          -> token:CancellationToken.t
          -> PreparedToolInvocation.t ProviderResult.t]
        prepareInvocation;
      t_of_js obj
    ;;
  end
end

module LanguageModelToolInformation = struct
  include Interface.Make ()

  include
    [%js:
      val name : t -> string [@@js.get "name"]
      val description : t -> string [@@js.get "description"]
      val inputSchema : t -> Ojs.t or_undefined [@@js.get "inputSchema"]
      val tags : t -> string list [@@js.get "tags"]]

  let create ~name ~description ~inputSchema ~tags () =
    let obj = Ojs.obj [||] in
    Ojs.set_prop_ascii obj "name" (Ojs.string_to_js name);
    Ojs.set_prop_ascii obj "description" (Ojs.string_to_js description);
    Ojs.set_prop_ascii obj "inputSchema" ((or_undefined_to_js Ojs.t_to_js) inputSchema);
    Ojs.set_prop_ascii obj "tags" ((Ojs.list_to_js Ojs.string_to_js) tags);
    t_of_js obj
  ;;
end

module Lm = struct
  include
    [%js:
      val onDidChangeChatModels : unit -> unit Event.t
      [@@js.get "@vscode.lm.onDidChangeChatModels"]]

  let selectChatModels ?selector () =
    (Promise.t_of_js (Ojs.list_of_js LanguageModelChat.t_of_js))
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "lm")
         "selectChatModels"
         (binding_arguments
            [| (or_undefined_to_js LanguageModelChatSelector.t_to_js) selector |]
            0
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val registerTool
        :  ((module Ojs.T with type t = 'p_t)[@js])
        -> name:string
        -> tool:'p_t LanguageModelTool.t
        -> Disposable.t
      [@@js.global "@vscode.lm.registerTool"]

      val tools : unit -> LanguageModelToolInformation.t list
      [@@js.get "@vscode.lm.tools"]]

  let invokeTool ~name ~options ?token () =
    (Promise.t_of_js LanguageModelToolResult.t_of_js)
      (Ojs.call
         (Ojs.get_prop_ascii vscode_module "lm")
         "invokeTool"
         (binding_arguments
            [| Ojs.string_to_js name
             ; (LanguageModelToolInvocationOptions.t_to_js Ojs.t_to_js) options
             ; (or_undefined_to_js CancellationToken.t_to_js) token
            |]
            2
            (Ojs.array_to_js Ojs.t_to_js [||])))
  ;;

  include
    [%js:
      val registerMcpServerDefinitionProvider
        :  id:string
        -> provider:McpServerDefinition.t McpServerDefinitionProvider.t
        -> Disposable.t
      [@@js.global "@vscode.lm.registerMcpServerDefinitionProvider"]

      val registerLanguageModelChatProvider
        :  vendor:string
        -> provider:LanguageModelChatInformation.t LanguageModelChatProvider.t
        -> Disposable.t
      [@@js.global "@vscode.lm.registerLanguageModelChatProvider"]]
end

module LanguageModelPromptTsxPart = struct
  include Class.Make ()

  include
    [%js:
      val value : t -> Ojs.t [@@js.get "value"]
      val set_value : t -> Ojs.t -> unit [@@js.set "value"]
      val make : value:Ojs.t -> t [@@js.new "@vscode.LanguageModelPromptTsxPart"]]
end
