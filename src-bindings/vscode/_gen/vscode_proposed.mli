[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - AccessibilityInformation
  - AuthenticationProviderInformation
  - CancellationToken
  - Command
  - Disposable
  - DocumentSelector
  - Error
  - Event<T1>
  - GlobPattern
  - Iterable<T1>
  - Location
  - MarkdownString
  - Position
  - Progress<T1>
  - ProviderResult<T1>
  - QuickInput
  - QuickPickItem
  - Range
  - Readonly<T1>
  - Record<T1, T2>
  - StatusBarAlignment
  - StatusBarItem
  - TerminalDimensions
  - TextEditor
  - ThemableDecorationAttachmentRenderOptions
  - ThemeColor
  - ThemeIcon
  - Thenable<T1>
  - Uint8Array
  - Uri
  - ViewColumn
  - WebviewOptions
  - WebviewPanel
  - WorkspaceEditEntryMetadata
  - WorkspaceFolder
 *)
[@@@js.stop]
module type Missing = sig
  module AccessibilityInformation : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module AuthenticationProviderInformation : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module CancellationToken : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Command : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Disposable : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module DocumentSelector : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Error : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Event : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module GlobPattern : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Iterable : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module Location : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module MarkdownString : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Position : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Progress : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module ProviderResult : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module QuickInput : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module QuickPickItem : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Range : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Readonly : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module Record : sig
    type ('T1, 'T2) t_2
    val t_2_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t_2
  end
  module StatusBarAlignment : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module StatusBarItem : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module TerminalDimensions : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module TextEditor : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module ThemableDecorationAttachmentRenderOptions : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module ThemeColor : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module ThemeIcon : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Thenable : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module Uint8Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Uri : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module ViewColumn : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module WebviewOptions : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module WebviewPanel : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module WorkspaceEditEntryMetadata : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module WorkspaceFolder : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module AccessibilityInformation : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module AuthenticationProviderInformation : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module CancellationToken : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Command : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Disposable : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module DocumentSelector : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Error : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Event : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module GlobPattern : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Iterable : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module Location : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module MarkdownString : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Position : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Progress : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module ProviderResult : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module QuickInput : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module QuickPickItem : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Range : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Readonly : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module Record : sig
      type ('T1, 'T2) t_2
      val t_2_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t_2
    end
    module StatusBarAlignment : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module StatusBarItem : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module TerminalDimensions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module TextEditor : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ThemableDecorationAttachmentRenderOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ThemeColor : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ThemeIcon : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Thenable : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module Uint8Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Uri : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ViewColumn : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module WebviewOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module WebviewPanel : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module WorkspaceEditEntryMetadata : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module WorkspaceFolder : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
]
module Make (M: Missing) : sig
  open M
  module Internal : sig
    module AnonymousInterfaces : sig
      type anonymous_interface_0 = [`anonymous_interface_0] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_1 = [`anonymous_interface_1] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_2 = [`anonymous_interface_2] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_3 = [`anonymous_interface_3] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_4 = [`anonymous_interface_4] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_5 = [`anonymous_interface_5] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_6 = [`anonymous_interface_6] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_7 = [`anonymous_interface_7] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_8 = [`anonymous_interface_8] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_9 = [`anonymous_interface_9] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_10 = [`anonymous_interface_10] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_11 = [`anonymous_interface_11] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_12 = [`anonymous_interface_12] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_13 = [`anonymous_interface_13] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_14 = [`anonymous_interface_14] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_15 = [`anonymous_interface_15] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_16 = [`anonymous_interface_16] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_17 = [`anonymous_interface_17] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
    module Types : sig
      open AnonymousInterfaces
      type vscode_AuthenticationProvidersChangeEvent = [`Vscode_AuthenticationProvidersChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CandidatePortSource = [`None[@js 0] | `Process[@js 1] | `Output[@js 2]] [@js.enum]
      and vscode_CandidatePortSource_None = [`None[@js 0]] [@js.enum]
      and vscode_CandidatePortSource_Process = [`Process[@js 1]] [@js.enum]
      and vscode_CandidatePortSource_Output = [`Output[@js 2]] [@js.enum]
      and vscode_CompletionItem = [`Vscode_CompletionItem] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CompletionItemLabel = [`Vscode_CompletionItemLabel] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CustomTextEditorProvider = [`Vscode_CustomTextEditorProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugProtocolVariable = [`Vscode_DebugProtocolVariable] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugProtocolVariableContainer = [`Vscode_DebugProtocolVariableContainer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DocumentFilter = [`Vscode_DocumentFilter] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ExtensionContext = [`Vscode_ExtensionContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ExtensionRuntime = [`Node[@js 1] | `Webworker[@js 2]] [@js.enum]
      and vscode_ExtensionRuntime_Node = [`Node[@js 1]] [@js.enum]
      and vscode_ExtensionRuntime_Webworker = [`Webworker[@js 2]] [@js.enum]
      and vscode_ExternalUriOpener = [`Vscode_ExternalUriOpener] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ExternalUriOpenerMetadata = [`Vscode_ExternalUriOpenerMetadata] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ExternalUriOpenerPriority = [`None[@js 0] | `Option[@js 1] | `Default[@js 2] | `Preferred[@js 3]] [@js.enum]
      and vscode_ExternalUriOpenerPriority_None = [`None[@js 0]] [@js.enum]
      and vscode_ExternalUriOpenerPriority_Option = [`Option[@js 1]] [@js.enum]
      and vscode_ExternalUriOpenerPriority_Default = [`Default[@js 2]] [@js.enum]
      and vscode_ExternalUriOpenerPriority_Preferred = [`Preferred[@js 3]] [@js.enum]
      and vscode_FileSearchOptions = [`Vscode_FileSearchOptions | `Vscode_SearchOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileSearchProvider = [`Vscode_FileSearchProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileSearchQuery = [`Vscode_FileSearchQuery] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileSystemProvider = [`Vscode_FileSystemProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FindTextInFilesOptions = [`Vscode_FindTextInFilesOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_GlobString = string
      and vscode_InlineHint = [`Vscode_InlineHint] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_InlineHintKind = [`Other[@js 0] | `Type[@js 1] | `Parameter[@js 2]] [@js.enum]
      and vscode_InlineHintKind_Other = [`Other[@js 0]] [@js.enum]
      and vscode_InlineHintKind_Type = [`Type[@js 1]] [@js.enum]
      and vscode_InlineHintKind_Parameter = [`Parameter[@js 2]] [@js.enum]
      and vscode_InlineHintsProvider = [`Vscode_InlineHintsProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_InputBoxOptions = [`Vscode_InputBoxOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_LineChange = [`Vscode_LineChange] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_MessageOptions = [`Vscode_MessageOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCell = [`Vscode_NotebookCell] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellData = [`Vscode_NotebookCellData] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellExecuteEndContext = [`Vscode_NotebookCellExecuteEndContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellExecuteStartContext = [`Vscode_NotebookCellExecuteStartContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellExecutionState = [`Idle[@js 1] | `Pending[@js 2] | `Executing[@js 3]] [@js.enum]
      and vscode_NotebookCellExecutionState_Idle = [`Idle[@js 1]] [@js.enum]
      and vscode_NotebookCellExecutionState_Pending = [`Pending[@js 2]] [@js.enum]
      and vscode_NotebookCellExecutionState_Executing = [`Executing[@js 3]] [@js.enum]
      and vscode_NotebookCellExecutionStateChangeEvent = [`Vscode_NotebookCellExecutionStateChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellExecutionSummary = [`Vscode_NotebookCellExecutionSummary] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellExecutionTask = [`Vscode_NotebookCellExecutionTask] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellKind = [`Markdown[@js 1] | `Code[@js 2]] [@js.enum]
      and vscode_NotebookCellKind_Markdown = [`Markdown[@js 1]] [@js.enum]
      and vscode_NotebookCellKind_Code = [`Code[@js 2]] [@js.enum]
      and vscode_NotebookCellMetadata = [`Vscode_NotebookCellMetadata] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellMetadataChangeEvent = [`Vscode_NotebookCellMetadataChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellOutput = [`Vscode_NotebookCellOutput] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellOutputItem = [`Vscode_NotebookCellOutputItem] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellOutputsChangeEvent = [`Vscode_NotebookCellOutputsChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellRange = [`Vscode_NotebookCellRange] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellStatusBarAlignment = [`Left[@js 1] | `Right[@js 2]] [@js.enum]
      and vscode_NotebookCellStatusBarAlignment_Left = [`Left[@js 1]] [@js.enum]
      and vscode_NotebookCellStatusBarAlignment_Right = [`Right[@js 2]] [@js.enum]
      and vscode_NotebookCellStatusBarItem = [`Vscode_NotebookCellStatusBarItem] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellsChangeData = [`Vscode_NotebookCellsChangeData] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCellsChangeEvent = [`Vscode_NotebookCellsChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookCommunication = [`Vscode_NotebookCommunication] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookConcatTextDocument = [`Vscode_NotebookConcatTextDocument] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookContentProvider = [`Vscode_NotebookContentProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookData = [`Vscode_NotebookData] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookDecorationRenderOptions = [`Vscode_NotebookDecorationRenderOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookDocument = [`Vscode_NotebookDocument] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookDocumentBackup = [`Vscode_NotebookDocumentBackup] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookDocumentBackupContext = [`Vscode_NotebookDocumentBackupContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookDocumentContentOptions = [`Vscode_NotebookDocumentContentOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookDocumentFilter = [`Vscode_NotebookDocumentFilter] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookDocumentMetadata = [`Vscode_NotebookDocumentMetadata] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookDocumentMetadataChangeEvent = [`Vscode_NotebookDocumentMetadataChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookDocumentOpenContext = [`Vscode_NotebookDocumentOpenContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookDocumentShowOptions = [`Vscode_NotebookDocumentShowOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookEditor = [`Vscode_NotebookEditor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookEditorDecorationType = [`Vscode_NotebookEditorDecorationType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookEditorEdit = [`Vscode_NotebookEditorEdit] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookEditorRevealType = [`Default[@js 0] | `InCenter[@js 1] | `InCenterIfOutsideViewport[@js 2] | `AtTop[@js 3]] [@js.enum]
      and vscode_NotebookEditorRevealType_Default = [`Default[@js 0]] [@js.enum]
      and vscode_NotebookEditorRevealType_InCenter = [`InCenter[@js 1]] [@js.enum]
      and vscode_NotebookEditorRevealType_InCenterIfOutsideViewport = [`InCenterIfOutsideViewport[@js 2]] [@js.enum]
      and vscode_NotebookEditorRevealType_AtTop = [`AtTop[@js 3]] [@js.enum]
      and vscode_NotebookEditorSelectionChangeEvent = [`Vscode_NotebookEditorSelectionChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookEditorVisibleRangesChangeEvent = [`Vscode_NotebookEditorVisibleRangesChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookFilenamePattern = (GlobPattern.t_0, anonymous_interface_8) union2
      and vscode_NotebookFilter = [`Vscode_NotebookFilter] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookKernel = [`Vscode_NotebookKernel] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookKernel2 = [`Vscode_NotebookKernel2] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_NotebookKernelOptions = [`Vscode_NotebookKernelOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_NotebookKernelProvider = [`Vscode_NotebookKernelProvider of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_NotebookSelector = (vscode_NotebookFilter, vscode_NotebookFilter or_string list) union2 or_string
      and vscode_NotebookSerializer = [`Vscode_NotebookSerializer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_OpenEditorInfo = [`Vscode_OpenEditorInfo] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_OpenExternalOptions = [`Vscode_OpenExternalOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_OpenExternalUriContext = [`Vscode_OpenExternalUriContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_PortAttributes = [`Vscode_PortAttributes] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_PortAttributesProvider = [`Vscode_PortAttributesProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_PortAutoForwardAction = [`Notify[@js 1] | `OpenBrowser[@js 2] | `OpenPreview[@js 3] | `Silent[@js 4] | `Ignore[@js 5]] [@js.enum]
      and vscode_PortAutoForwardAction_Notify = [`Notify[@js 1]] [@js.enum]
      and vscode_PortAutoForwardAction_OpenBrowser = [`OpenBrowser[@js 2]] [@js.enum]
      and vscode_PortAutoForwardAction_OpenPreview = [`OpenPreview[@js 3]] [@js.enum]
      and vscode_PortAutoForwardAction_Silent = [`Silent[@js 4]] [@js.enum]
      and vscode_PortAutoForwardAction_Ignore = [`Ignore[@js 5]] [@js.enum]
      and 'T vscode_QuickPick = [`Vscode_QuickPick of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_QuickPickOptions = [`Vscode_QuickPickOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_RemoteAuthorityResolver = [`Vscode_RemoteAuthorityResolver] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_RemoteAuthorityResolverContext = [`Vscode_RemoteAuthorityResolverContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_RemoteAuthorityResolverError = [`Vscode_RemoteAuthorityResolverError] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ResolvedAuthority = [`Vscode_ResolvedAuthority] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ResolvedOptions = [`Vscode_ResolvedOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ResolverResult = (vscode_ResolvedAuthority, vscode_ResolvedOptions, vscode_TunnelInformation) intersection3
      and vscode_ResourceLabelFormatter = [`Vscode_ResourceLabelFormatter] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ResourceLabelFormatting = [`Vscode_ResourceLabelFormatting] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SearchOptions = [`Vscode_SearchOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SourceControl = [`Vscode_SourceControl] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SourceControlInputBox = [`Vscode_SourceControlInputBox] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SourceControlInputBoxValidation = [`Vscode_SourceControlInputBoxValidation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SourceControlInputBoxValidationType = [`Error[@js 0] | `Warning[@js 1] | `Information[@js 2]] [@js.enum]
      and vscode_SourceControlInputBoxValidationType_Error = [`Error[@js 0]] [@js.enum]
      and vscode_SourceControlInputBoxValidationType_Warning = [`Warning[@js 1]] [@js.enum]
      and vscode_SourceControlInputBoxValidationType_Information = [`Information[@js 2]] [@js.enum]
      and vscode_StandardTokenType = [`Other[@js 0] | `Comment[@js 1] | `String[@js 2] | `RegEx[@js 4]] [@js.enum]
      and vscode_StandardTokenType_Other = [`Other[@js 0]] [@js.enum]
      and vscode_StandardTokenType_Comment = [`Comment[@js 1]] [@js.enum]
      and vscode_StandardTokenType_String = [`String[@js 2]] [@js.enum]
      and vscode_StandardTokenType_RegEx = [`RegEx[@js 4]] [@js.enum]
      and vscode_StatusBarItemOptions = [`Vscode_StatusBarItemOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TaskPresentationOptions = [`Vscode_TaskPresentationOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_Terminal = [`Vscode_Terminal] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TerminalDataWriteEvent = [`Vscode_TerminalDataWriteEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TerminalDimensionsChangeEvent = [`Vscode_TerminalDimensionsChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TerminalOptions = [`Vscode_TerminalOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_TestChildrenCollection = [`Vscode_TestChildrenCollection of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and 'TChildren vscode_TestItem = [`Vscode_TestItem of 'TChildren] intf
      [@@js.custom { of_js=(fun _TChildren -> Obj.magic); to_js=(fun _TChildren -> Obj.magic) }]
      and vscode_TestMessage = [`Vscode_TestMessage] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TestMessageSeverity = [`Error[@js 0] | `Warning[@js 1] | `Information[@js 2] | `Hint[@js 3]] [@js.enum]
      and vscode_TestMessageSeverity_Error = [`Error[@js 0]] [@js.enum]
      and vscode_TestMessageSeverity_Warning = [`Warning[@js 1]] [@js.enum]
      and vscode_TestMessageSeverity_Information = [`Information[@js 2]] [@js.enum]
      and vscode_TestMessageSeverity_Hint = [`Hint[@js 3]] [@js.enum]
      and vscode_TestObserver = [`Vscode_TestObserver] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_TestProvider = [`Vscode_TestProvider of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_TestResultSnapshot = [`Vscode_TestResultSnapshot] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TestResultState = [`Unset[@js 0] | `Queued[@js 1] | `Running[@js 2] | `Passed[@js 3] | `Failed[@js 4] | `Skipped[@js 5] | `Errored[@js 6]] [@js.enum]
      and vscode_TestResultState_Unset = [`Unset[@js 0]] [@js.enum]
      and vscode_TestResultState_Queued = [`Queued[@js 1]] [@js.enum]
      and vscode_TestResultState_Running = [`Running[@js 2]] [@js.enum]
      and vscode_TestResultState_Passed = [`Passed[@js 3]] [@js.enum]
      and vscode_TestResultState_Failed = [`Failed[@js 4]] [@js.enum]
      and vscode_TestResultState_Skipped = [`Skipped[@js 5]] [@js.enum]
      and vscode_TestResultState_Errored = [`Errored[@js 6]] [@js.enum]
      and 'T vscode_TestRunOptions = [`Vscode_TestRunOptions of 'T | `Vscode_TestRunRequest of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and 'T vscode_TestRunRequest = [`Vscode_TestRunRequest of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_TestRunResult = [`Vscode_TestRunResult] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TestsChangeEvent = [`Vscode_TestsChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextDocument = [`Vscode_TextDocument] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextSearchComplete = [`Vscode_TextSearchComplete] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextSearchContext = [`Vscode_TextSearchContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextSearchMatch = [`Vscode_TextSearchMatch] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextSearchMatchPreview = [`Vscode_TextSearchMatchPreview] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextSearchOptions = [`Vscode_TextSearchOptions | `Vscode_SearchOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextSearchPreviewOptions = [`Vscode_TextSearchPreviewOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextSearchProvider = [`Vscode_TextSearchProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextSearchQuery = [`Vscode_TextSearchQuery] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextSearchResult = (vscode_TextSearchContext, vscode_TextSearchMatch) union2
      and vscode_Timeline = [`Vscode_Timeline] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TimelineChangeEvent = [`Vscode_TimelineChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TimelineItem = [`Vscode_TimelineItem] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TimelineOptions = [`Vscode_TimelineOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TimelineProvider = [`Vscode_TimelineProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TokenInformation = [`Vscode_TokenInformation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_TreeView = [`Vscode_TreeView of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_Tunnel = [`Vscode_Tunnel | `Vscode_TunnelDescription] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TunnelCreationOptions = [`Vscode_TunnelCreationOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TunnelDescription = [`Vscode_TunnelDescription] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TunnelInformation = [`Vscode_TunnelInformation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TunnelOptions = [`Vscode_TunnelOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_Webview = [`Vscode_Webview] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WebviewEditorInset = [`Vscode_WebviewEditorInset] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WorkspaceEdit = [`Vscode_WorkspaceEdit] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WorkspaceTrustRequestOptions = [`Vscode_WorkspaceTrustRequestOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WorkspaceTrustState = [`Untrusted[@js 0] | `Trusted[@js 1] | `Unspecified[@js 2]] [@js.enum]
      and vscode_WorkspaceTrustState_Untrusted = [`Untrusted[@js 0]] [@js.enum]
      and vscode_WorkspaceTrustState_Trusted = [`Trusted[@js 1]] [@js.enum]
      and vscode_WorkspaceTrustState_Unspecified = [`Unspecified[@js 2]] [@js.enum]
      and vscode_WorkspaceTrustStateChangeEvent = [`Vscode_WorkspaceTrustStateChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module AnonymousInterface0 : sig
    type t = anonymous_interface_0
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_busy: t -> bool [@@js.get "busy"]
    val set_busy: t -> bool -> unit [@@js.set "busy"]
  end
  module AnonymousInterface1 : sig
    type t = anonymous_interface_1
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_create: t -> bool [@@js.get "create"]
    val set_create: t -> bool -> unit [@@js.set "create"]
  end
  module AnonymousInterface2 : sig
    type t = anonymous_interface_2
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_cursor: t -> string or_undefined [@@js.get "cursor"]
  end
  module AnonymousInterface3 : sig
    type t = anonymous_interface_3
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_displayName: t -> string [@@js.get "displayName"]
    val set_displayName: t -> string -> unit [@@js.set "displayName"]
    val get_filenamePattern: t -> vscode_NotebookFilenamePattern list [@@js.get "filenamePattern"]
    val set_filenamePattern: t -> vscode_NotebookFilenamePattern list -> unit [@@js.set "filenamePattern"]
    val get_exclusive: t -> bool [@@js.get "exclusive"]
    val set_exclusive: t -> bool -> unit [@@js.set "exclusive"]
  end
  module AnonymousInterface4 : sig
    type t = anonymous_interface_4
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_document: t -> vscode_NotebookDocument [@@js.get "document"]
    val set_document: t -> vscode_NotebookDocument -> unit [@@js.set "document"]
    val get_kernel: t -> vscode_NotebookKernel or_undefined [@@js.get "kernel"]
    val set_kernel: t -> vscode_NotebookKernel or_undefined -> unit [@@js.set "kernel"]
  end
  module AnonymousInterface5 : sig
    type t = anonymous_interface_5
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_editable: t -> bool or_null [@@js.get "editable"]
    val set_editable: t -> bool or_null -> unit [@@js.set "editable"]
    val get_breakpointMargin: t -> bool or_null [@@js.get "breakpointMargin"]
    val set_breakpointMargin: t -> bool or_null -> unit [@@js.set "breakpointMargin"]
    val get_statusMessage: t -> string or_null [@@js.get "statusMessage"]
    val set_statusMessage: t -> string or_null -> unit [@@js.set "statusMessage"]
    val get_lastRunDuration: t -> float or_null [@@js.get "lastRunDuration"]
    val set_lastRunDuration: t -> float or_null -> unit [@@js.set "lastRunDuration"]
    val get_inputCollapsed: t -> bool or_null [@@js.get "inputCollapsed"]
    val set_inputCollapsed: t -> bool or_null -> unit [@@js.set "inputCollapsed"]
    val get_outputCollapsed: t -> bool or_null [@@js.get "outputCollapsed"]
    val set_outputCollapsed: t -> bool or_null -> unit [@@js.set "outputCollapsed"]
    val get_custom: t -> (string, any) Record.t_2 or_null [@@js.get "custom"]
    val set_custom: t -> (string, any) Record.t_2 or_null -> unit [@@js.set "custom"]
  end
  module AnonymousInterface6 : sig
    type t = anonymous_interface_6
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_editable: t -> bool or_null [@@js.get "editable"]
    val set_editable: t -> bool or_null -> unit [@@js.set "editable"]
    val get_cellEditable: t -> bool or_null [@@js.get "cellEditable"]
    val set_cellEditable: t -> bool or_null -> unit [@@js.set "cellEditable"]
    val get_custom: t -> anonymous_interface_16 or_null [@@js.get "custom"]
    val set_custom: t -> anonymous_interface_16 or_null -> unit [@@js.set "custom"]
    val get_trusted: t -> bool or_null [@@js.get "trusted"]
    val set_trusted: t -> bool or_null -> unit [@@js.set "trusted"]
  end
  module AnonymousInterface7 : sig
    type t = anonymous_interface_7
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_elevation: t -> bool [@@js.get "elevation"]
    val set_elevation: t -> bool -> unit [@@js.set "elevation"]
    val get_public: t -> bool [@@js.get "public"]
    val set_public: t -> bool -> unit [@@js.set "public"]
  end
  module AnonymousInterface8 : sig
    type t = anonymous_interface_8
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_include: t -> GlobPattern.t_0 [@@js.get "include"]
    val set_include: t -> GlobPattern.t_0 -> unit [@@js.set "include"]
    val get_exclude: t -> GlobPattern.t_0 [@@js.get "exclude"]
    val set_exclude: t -> GlobPattern.t_0 -> unit [@@js.set "exclude"]
  end
  module AnonymousInterface9 : sig
    type t = anonymous_interface_9
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_light: t -> Uri.t_0 [@@js.get "light"]
    val set_light: t -> Uri.t_0 -> unit [@@js.set "light"]
    val get_dark: t -> Uri.t_0 [@@js.get "dark"]
    val set_dark: t -> Uri.t_0 -> unit [@@js.set "dark"]
  end
  module AnonymousInterface10 : sig
    type t = anonymous_interface_10
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_pid: t -> float [@@js.get "pid"]
    val set_pid: t -> float -> unit [@@js.set "pid"]
    val get_portRange: t -> (float * float) [@@js.get "portRange"]
    val set_portRange: t -> (float * float) -> unit [@@js.set "portRange"]
    val get_commandMatcher: t -> regexp [@@js.get "commandMatcher"]
    val set_commandMatcher: t -> regexp -> unit [@@js.set "commandMatcher"]
  end
  module AnonymousInterface11 : sig
    type t = anonymous_interface_11
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_port: t -> float [@@js.get "port"]
    val set_port: t -> float -> unit [@@js.set "port"]
    val get_host: t -> string [@@js.get "host"]
    val set_host: t -> string -> unit [@@js.set "host"]
  end
  module AnonymousInterface12 : sig
    type t = anonymous_interface_12
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_select: t -> bool [@@js.get "select"]
    val set_select: t -> bool -> unit [@@js.set "select"]
    val get_focus: t -> bool [@@js.get "focus"]
    val set_focus: t -> bool -> unit [@@js.set "focus"]
    val get_expand: t -> bool or_number [@@js.get "expand"]
    val set_expand: t -> bool or_number -> unit [@@js.set "expand"]
  end
  module AnonymousInterface13 : sig
    type t = anonymous_interface_13
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_start: t -> float [@@js.get "start"]
    val set_start: t -> float -> unit [@@js.set "start"]
    val get_end: t -> float [@@js.get "end"]
    val set_end: t -> float -> unit [@@js.set "end"]
  end
  module AnonymousInterface14 : sig
    type t = anonymous_interface_14
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_timestamp: t -> float [@@js.get "timestamp"]
    val set_timestamp: t -> float -> unit [@@js.set "timestamp"]
    val get_id: t -> string [@@js.get "id"]
    val set_id: t -> string -> unit [@@js.set "id"]
  end
  module AnonymousInterface15 : sig
    type t = anonymous_interface_15
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_viewOptions: t -> anonymous_interface_3 [@@js.get "viewOptions"]
    val set_viewOptions: t -> anonymous_interface_3 -> unit [@@js.set "viewOptions"]
  end
  module AnonymousInterface16 : sig
    type t = anonymous_interface_16
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get: t -> string -> any [@@js.index_get]
    val set: t -> string -> any -> unit [@@js.index_set]
  end
  module AnonymousInterface17 : sig
    type t = anonymous_interface_17
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get: t -> string -> string or_null [@@js.index_get]
    val set: t -> string -> string or_null -> unit [@@js.index_set]
  end
  module[@js.scope "vscode"] Vscode : sig
    module[@js.scope "AuthenticationProvidersChangeEvent"] AuthenticationProvidersChangeEvent : sig
      type t = vscode_AuthenticationProvidersChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_added: t -> AuthenticationProviderInformation.t_0 list [@@js.get "added"]
      val get_removed: t -> AuthenticationProviderInformation.t_0 list [@@js.get "removed"]
    end
    module[@js.scope "authentication"] Authentication : sig
      val onDidChangeAuthenticationProviders: vscode_AuthenticationProvidersChangeEvent Event.t_1 [@@js.global "onDidChangeAuthenticationProviders"]
      val providers: AuthenticationProviderInformation.t_0 list [@@js.global "providers"]
      val logout: providerId:string -> sessionId:string -> unit Thenable.t_1 [@@js.global "logout"]
    end
    module[@js.scope "MessageOptions"] MessageOptions : sig
      type t = vscode_MessageOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_useCustom: t -> bool [@@js.get "useCustom"]
      val set_useCustom: t -> bool -> unit [@@js.set "useCustom"]
    end
    module[@js.scope "RemoteAuthorityResolverContext"] RemoteAuthorityResolverContext : sig
      type t = vscode_RemoteAuthorityResolverContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_resolveAttempt: t -> float [@@js.get "resolveAttempt"]
      val set_resolveAttempt: t -> float -> unit [@@js.set "resolveAttempt"]
    end
    module[@js.scope "ResolvedAuthority"] ResolvedAuthority : sig
      type t = vscode_ResolvedAuthority
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_host: t -> string [@@js.get "host"]
      val get_port: t -> float [@@js.get "port"]
      val get_connectionToken: t -> string or_undefined [@@js.get "connectionToken"]
      val create: host:string -> port:float -> ?connectionToken:string -> unit -> t [@@js.create]
    end
    module[@js.scope "ResolvedOptions"] ResolvedOptions : sig
      type t = vscode_ResolvedOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_extensionHostEnv: t -> anonymous_interface_17 [@@js.get "extensionHostEnv"]
      val set_extensionHostEnv: t -> anonymous_interface_17 -> unit [@@js.set "extensionHostEnv"]
    end
    module[@js.scope "TunnelOptions"] TunnelOptions : sig
      type t = vscode_TunnelOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_remoteAddress: t -> anonymous_interface_11 [@@js.get "remoteAddress"]
      val set_remoteAddress: t -> anonymous_interface_11 -> unit [@@js.set "remoteAddress"]
      val get_localAddressPort: t -> float [@@js.get "localAddressPort"]
      val set_localAddressPort: t -> float -> unit [@@js.set "localAddressPort"]
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_public: t -> bool [@@js.get "public"]
      val set_public: t -> bool -> unit [@@js.set "public"]
    end
    module[@js.scope "TunnelDescription"] TunnelDescription : sig
      type t = vscode_TunnelDescription
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_remoteAddress: t -> anonymous_interface_11 [@@js.get "remoteAddress"]
      val set_remoteAddress: t -> anonymous_interface_11 -> unit [@@js.set "remoteAddress"]
      val get_localAddress: t -> anonymous_interface_11 or_string [@@js.get "localAddress"]
      val set_localAddress: t -> anonymous_interface_11 or_string -> unit [@@js.set "localAddress"]
      val get_public: t -> bool [@@js.get "public"]
      val set_public: t -> bool -> unit [@@js.set "public"]
    end
    module[@js.scope "Tunnel"] Tunnel : sig
      type t = vscode_Tunnel
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidDispose: t -> unit Event.t_1 [@@js.get "onDidDispose"]
      val set_onDidDispose: t -> unit Event.t_1 -> unit [@@js.set "onDidDispose"]
      val dispose: t -> (unit, unit Thenable.t_1) union2 [@@js.call "dispose"]
      val cast: t -> vscode_TunnelDescription [@@js.cast]
    end
    module[@js.scope "TunnelInformation"] TunnelInformation : sig
      type t = vscode_TunnelInformation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_environmentTunnels: t -> vscode_TunnelDescription list [@@js.get "environmentTunnels"]
      val set_environmentTunnels: t -> vscode_TunnelDescription list -> unit [@@js.set "environmentTunnels"]
    end
    module[@js.scope "TunnelCreationOptions"] TunnelCreationOptions : sig
      type t = vscode_TunnelCreationOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_elevationRequired: t -> bool [@@js.get "elevationRequired"]
      val set_elevationRequired: t -> bool -> unit [@@js.set "elevationRequired"]
    end
    module CandidatePortSource : sig
      type t = vscode_CandidatePortSource
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ResolverResult : sig
      type t = vscode_ResolverResult
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "RemoteAuthorityResolverError"] RemoteAuthorityResolverError : sig
      type t = vscode_RemoteAuthorityResolverError
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val notAvailable: ?message:string -> ?handled:bool -> unit -> t [@@js.global "NotAvailable"]
      val temporarilyNotAvailable: ?message:string -> unit -> t [@@js.global "TemporarilyNotAvailable"]
      val create: ?message:string -> unit -> t [@@js.create]
      val cast: t -> Error.t_0 [@@js.cast]
    end
    module[@js.scope "RemoteAuthorityResolver"] RemoteAuthorityResolver : sig
      type t = vscode_RemoteAuthorityResolver
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val resolve: t -> authority:string -> context:vscode_RemoteAuthorityResolverContext -> (vscode_ResolverResult, vscode_ResolverResult Thenable.t_1) union2 [@@js.call "resolve"]
      val tunnelFactory: t -> tunnelOptions:vscode_TunnelOptions -> tunnelCreationOptions:vscode_TunnelCreationOptions -> vscode_Tunnel Thenable.t_1 or_undefined [@@js.call "tunnelFactory"]
      val showCandidatePort: t -> host:string -> port:float -> detail:string -> bool Thenable.t_1 [@@js.call "showCandidatePort"]
      val get_tunnelFeatures: t -> anonymous_interface_7 [@@js.get "tunnelFeatures"]
      val set_tunnelFeatures: t -> anonymous_interface_7 -> unit [@@js.set "tunnelFeatures"]
      val get_candidatePortSource: t -> vscode_CandidatePortSource [@@js.get "candidatePortSource"]
      val set_candidatePortSource: t -> vscode_CandidatePortSource -> unit [@@js.set "candidatePortSource"]
    end
    module[@js.scope "workspace"] Workspace : sig
      val openTunnel: tunnelOptions:vscode_TunnelOptions -> vscode_Tunnel Thenable.t_1 [@@js.global "openTunnel"]
      val tunnels: vscode_TunnelDescription list Thenable.t_1 [@@js.global "tunnels"]
      val onDidChangeTunnels: unit Event.t_1 [@@js.global "onDidChangeTunnels"]
      val registerRemoteAuthorityResolver: authorityPrefix:string -> resolver:vscode_RemoteAuthorityResolver -> Disposable.t_0 [@@js.global "registerRemoteAuthorityResolver"]
      val registerResourceLabelFormatter: formatter:vscode_ResourceLabelFormatter -> Disposable.t_0 [@@js.global "registerResourceLabelFormatter"]
      val registerFileSearchProvider: scheme:string -> provider:vscode_FileSearchProvider -> Disposable.t_0 [@@js.global "registerFileSearchProvider"]
      val registerTextSearchProvider: scheme:string -> provider:vscode_TextSearchProvider -> Disposable.t_0 [@@js.global "registerTextSearchProvider"]
      val findTextInFiles: query:vscode_TextSearchQuery -> callback:(result:vscode_TextSearchResult -> unit) -> ?token:CancellationToken.t_0 -> unit -> vscode_TextSearchComplete Thenable.t_1 [@@js.global "findTextInFiles"]
      val findTextInFiles: query:vscode_TextSearchQuery -> options:vscode_FindTextInFilesOptions -> callback:(result:vscode_TextSearchResult -> unit) -> ?token:CancellationToken.t_0 -> unit -> vscode_TextSearchComplete Thenable.t_1 [@@js.global "findTextInFiles"]
      val registerTimelineProvider: scheme:string list or_string -> provider:vscode_TimelineProvider -> Disposable.t_0 [@@js.global "registerTimelineProvider"]
      val trustState: vscode_WorkspaceTrustState [@@js.global "trustState"]
      val requestWorkspaceTrust: ?options:vscode_WorkspaceTrustRequestOptions -> unit -> vscode_WorkspaceTrustState or_undefined Thenable.t_1 [@@js.global "requestWorkspaceTrust"]
      val onDidChangeWorkspaceTrustState: vscode_WorkspaceTrustStateChangeEvent Event.t_1 [@@js.global "onDidChangeWorkspaceTrustState"]
      val registerPortAttributesProvider: portSelector:anonymous_interface_10 -> provider:vscode_PortAttributesProvider -> Disposable.t_0 [@@js.global "registerPortAttributesProvider"]
    end
    module[@js.scope "ResourceLabelFormatter"] ResourceLabelFormatter : sig
      type t = vscode_ResourceLabelFormatter
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_scheme: t -> string [@@js.get "scheme"]
      val set_scheme: t -> string -> unit [@@js.set "scheme"]
      val get_authority: t -> string [@@js.get "authority"]
      val set_authority: t -> string -> unit [@@js.set "authority"]
      val get_formatting: t -> vscode_ResourceLabelFormatting [@@js.get "formatting"]
      val set_formatting: t -> vscode_ResourceLabelFormatting -> unit [@@js.set "formatting"]
    end
    module[@js.scope "ResourceLabelFormatting"] ResourceLabelFormatting : sig
      type t = vscode_ResourceLabelFormatting
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_separator: t -> ([`L_s0[@js ""] | `L_s1[@js "/"] | `L_s2[@js "\\"]] [@js.enum]) [@@js.get "separator"]
      val set_separator: t -> ([`L_s0 | `L_s1 | `L_s2] [@js.enum]) -> unit [@@js.set "separator"]
      val get_tildify: t -> bool [@@js.get "tildify"]
      val set_tildify: t -> bool -> unit [@@js.set "tildify"]
      val get_normalizeDriveLetter: t -> bool [@@js.get "normalizeDriveLetter"]
      val set_normalizeDriveLetter: t -> bool -> unit [@@js.set "normalizeDriveLetter"]
      val get_workspaceSuffix: t -> string [@@js.get "workspaceSuffix"]
      val set_workspaceSuffix: t -> string -> unit [@@js.set "workspaceSuffix"]
      val get_authorityPrefix: t -> string [@@js.get "authorityPrefix"]
      val set_authorityPrefix: t -> string -> unit [@@js.set "authorityPrefix"]
      val get_stripPathStartingSeparator: t -> bool [@@js.get "stripPathStartingSeparator"]
      val set_stripPathStartingSeparator: t -> bool -> unit [@@js.set "stripPathStartingSeparator"]
    end
    module[@js.scope "WebviewEditorInset"] WebviewEditorInset : sig
      type t = vscode_WebviewEditorInset
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_editor: t -> TextEditor.t_0 [@@js.get "editor"]
      val get_line: t -> float [@@js.get "line"]
      val get_height: t -> float [@@js.get "height"]
      val get_webview: t -> vscode_Webview [@@js.get "webview"]
      val get_onDidDispose: t -> unit Event.t_1 [@@js.get "onDidDispose"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "window"] Window : sig
      val createWebviewTextEditorInset: editor:TextEditor.t_0 -> line:float -> height:float -> ?options:WebviewOptions.t_0 -> unit -> vscode_WebviewEditorInset [@@js.global "createWebviewTextEditorInset"]
      val onDidWriteTerminalData: vscode_TerminalDataWriteEvent Event.t_1 [@@js.global "onDidWriteTerminalData"]
      val onDidChangeTerminalDimensions: vscode_TerminalDimensionsChangeEvent Event.t_1 [@@js.global "onDidChangeTerminalDimensions"]
      val createStatusBarItem: ?options:vscode_StatusBarItemOptions -> unit -> StatusBarItem.t_0 [@@js.global "createStatusBarItem"]
      val visibleNotebookEditors: vscode_NotebookEditor list [@@js.global "visibleNotebookEditors"]
      val onDidChangeVisibleNotebookEditors: vscode_NotebookEditor list Event.t_1 [@@js.global "onDidChangeVisibleNotebookEditors"]
      val activeNotebookEditor: vscode_NotebookEditor or_undefined [@@js.global "activeNotebookEditor"]
      val onDidChangeActiveNotebookEditor: vscode_NotebookEditor or_undefined Event.t_1 [@@js.global "onDidChangeActiveNotebookEditor"]
      val onDidChangeNotebookEditorSelection: vscode_NotebookEditorSelectionChangeEvent Event.t_1 [@@js.global "onDidChangeNotebookEditorSelection"]
      val onDidChangeNotebookEditorVisibleRanges: vscode_NotebookEditorVisibleRangesChangeEvent Event.t_1 [@@js.global "onDidChangeNotebookEditorVisibleRanges"]
      val showNotebookDocument: uri:Uri.t_0 -> ?options:vscode_NotebookDocumentShowOptions -> unit -> vscode_NotebookEditor Thenable.t_1 [@@js.global "showNotebookDocument"]
      val showNotebookDocument: document:vscode_NotebookDocument -> ?options:vscode_NotebookDocumentShowOptions -> unit -> vscode_NotebookEditor Thenable.t_1 [@@js.global "showNotebookDocument"]
      val registerExternalUriOpener: id:string -> opener:vscode_ExternalUriOpener -> metadata:vscode_ExternalUriOpenerMetadata -> Disposable.t_0 [@@js.global "registerExternalUriOpener"]
      val openEditors: vscode_OpenEditorInfo list [@@js.global "openEditors"]
      val onDidChangeOpenEditors: unit Event.t_1 [@@js.global "onDidChangeOpenEditors"]
    end
    module[@js.scope "FileSystemProvider"] FileSystemProvider : sig
      type t = vscode_FileSystemProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val open_: t -> resource:Uri.t_0 -> options:anonymous_interface_1 -> float Thenable.t_1 or_number [@@js.call "open"]
      val close: t -> fd:float -> (unit, unit Thenable.t_1) union2 [@@js.call "close"]
      val read: t -> fd:float -> pos:float -> data:Uint8Array.t_0 -> offset:float -> length:float -> float Thenable.t_1 or_number [@@js.call "read"]
      val write: t -> fd:float -> pos:float -> data:Uint8Array.t_0 -> offset:float -> length:float -> float Thenable.t_1 or_number [@@js.call "write"]
    end
    module[@js.scope "TextSearchQuery"] TextSearchQuery : sig
      type t = vscode_TextSearchQuery
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_pattern: t -> string [@@js.get "pattern"]
      val set_pattern: t -> string -> unit [@@js.set "pattern"]
      val get_isMultiline: t -> bool [@@js.get "isMultiline"]
      val set_isMultiline: t -> bool -> unit [@@js.set "isMultiline"]
      val get_isRegExp: t -> bool [@@js.get "isRegExp"]
      val set_isRegExp: t -> bool -> unit [@@js.set "isRegExp"]
      val get_isCaseSensitive: t -> bool [@@js.get "isCaseSensitive"]
      val set_isCaseSensitive: t -> bool -> unit [@@js.set "isCaseSensitive"]
      val get_isWordMatch: t -> bool [@@js.get "isWordMatch"]
      val set_isWordMatch: t -> bool -> unit [@@js.set "isWordMatch"]
    end
    module GlobString : sig
      type t = vscode_GlobString
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "SearchOptions"] SearchOptions : sig
      type t = vscode_SearchOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_folder: t -> Uri.t_0 [@@js.get "folder"]
      val set_folder: t -> Uri.t_0 -> unit [@@js.set "folder"]
      val get_includes: t -> vscode_GlobString list [@@js.get "includes"]
      val set_includes: t -> vscode_GlobString list -> unit [@@js.set "includes"]
      val get_excludes: t -> vscode_GlobString list [@@js.get "excludes"]
      val set_excludes: t -> vscode_GlobString list -> unit [@@js.set "excludes"]
      val get_useIgnoreFiles: t -> bool [@@js.get "useIgnoreFiles"]
      val set_useIgnoreFiles: t -> bool -> unit [@@js.set "useIgnoreFiles"]
      val get_followSymlinks: t -> bool [@@js.get "followSymlinks"]
      val set_followSymlinks: t -> bool -> unit [@@js.set "followSymlinks"]
      val get_useGlobalIgnoreFiles: t -> bool [@@js.get "useGlobalIgnoreFiles"]
      val set_useGlobalIgnoreFiles: t -> bool -> unit [@@js.set "useGlobalIgnoreFiles"]
    end
    module[@js.scope "TextSearchPreviewOptions"] TextSearchPreviewOptions : sig
      type t = vscode_TextSearchPreviewOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_matchLines: t -> float [@@js.get "matchLines"]
      val set_matchLines: t -> float -> unit [@@js.set "matchLines"]
      val get_charsPerLine: t -> float [@@js.get "charsPerLine"]
      val set_charsPerLine: t -> float -> unit [@@js.set "charsPerLine"]
    end
    module[@js.scope "TextSearchOptions"] TextSearchOptions : sig
      type t = vscode_TextSearchOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_maxResults: t -> float [@@js.get "maxResults"]
      val set_maxResults: t -> float -> unit [@@js.set "maxResults"]
      val get_previewOptions: t -> vscode_TextSearchPreviewOptions [@@js.get "previewOptions"]
      val set_previewOptions: t -> vscode_TextSearchPreviewOptions -> unit [@@js.set "previewOptions"]
      val get_maxFileSize: t -> float [@@js.get "maxFileSize"]
      val set_maxFileSize: t -> float -> unit [@@js.set "maxFileSize"]
      val get_encoding: t -> string [@@js.get "encoding"]
      val set_encoding: t -> string -> unit [@@js.set "encoding"]
      val get_beforeContext: t -> float [@@js.get "beforeContext"]
      val set_beforeContext: t -> float -> unit [@@js.set "beforeContext"]
      val get_afterContext: t -> float [@@js.get "afterContext"]
      val set_afterContext: t -> float -> unit [@@js.set "afterContext"]
      val cast: t -> vscode_SearchOptions [@@js.cast]
    end
    module[@js.scope "TextSearchComplete"] TextSearchComplete : sig
      type t = vscode_TextSearchComplete
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_limitHit: t -> bool [@@js.get "limitHit"]
      val set_limitHit: t -> bool -> unit [@@js.set "limitHit"]
    end
    module[@js.scope "TextSearchMatchPreview"] TextSearchMatchPreview : sig
      type t = vscode_TextSearchMatchPreview
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_text: t -> string [@@js.get "text"]
      val set_text: t -> string -> unit [@@js.set "text"]
      val get_matches: t -> (Range.t_0, Range.t_0) or_array [@@js.get "matches"]
      val set_matches: t -> (Range.t_0, Range.t_0) or_array -> unit [@@js.set "matches"]
    end
    module[@js.scope "TextSearchMatch"] TextSearchMatch : sig
      type t = vscode_TextSearchMatch
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_uri: t -> Uri.t_0 [@@js.get "uri"]
      val set_uri: t -> Uri.t_0 -> unit [@@js.set "uri"]
      val get_ranges: t -> (Range.t_0, Range.t_0) or_array [@@js.get "ranges"]
      val set_ranges: t -> (Range.t_0, Range.t_0) or_array -> unit [@@js.set "ranges"]
      val get_preview: t -> vscode_TextSearchMatchPreview [@@js.get "preview"]
      val set_preview: t -> vscode_TextSearchMatchPreview -> unit [@@js.set "preview"]
    end
    module[@js.scope "TextSearchContext"] TextSearchContext : sig
      type t = vscode_TextSearchContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_uri: t -> Uri.t_0 [@@js.get "uri"]
      val set_uri: t -> Uri.t_0 -> unit [@@js.set "uri"]
      val get_text: t -> string [@@js.get "text"]
      val set_text: t -> string -> unit [@@js.set "text"]
      val get_lineNumber: t -> float [@@js.get "lineNumber"]
      val set_lineNumber: t -> float -> unit [@@js.set "lineNumber"]
    end
    module TextSearchResult : sig
      type t = vscode_TextSearchResult
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "TextSearchProvider"] TextSearchProvider : sig
      type t = vscode_TextSearchProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideTextSearchResults: t -> query:vscode_TextSearchQuery -> options:vscode_TextSearchOptions -> progress:vscode_TextSearchResult Progress.t_1 -> token:CancellationToken.t_0 -> vscode_TextSearchComplete ProviderResult.t_1 [@@js.call "provideTextSearchResults"]
    end
    module[@js.scope "FileSearchQuery"] FileSearchQuery : sig
      type t = vscode_FileSearchQuery
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_pattern: t -> string [@@js.get "pattern"]
      val set_pattern: t -> string -> unit [@@js.set "pattern"]
    end
    module[@js.scope "FileSearchOptions"] FileSearchOptions : sig
      type t = vscode_FileSearchOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_maxResults: t -> float [@@js.get "maxResults"]
      val set_maxResults: t -> float -> unit [@@js.set "maxResults"]
      val get_session: t -> CancellationToken.t_0 [@@js.get "session"]
      val set_session: t -> CancellationToken.t_0 -> unit [@@js.set "session"]
      val cast: t -> vscode_SearchOptions [@@js.cast]
    end
    module[@js.scope "FileSearchProvider"] FileSearchProvider : sig
      type t = vscode_FileSearchProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideFileSearchResults: t -> query:vscode_FileSearchQuery -> options:vscode_FileSearchOptions -> token:CancellationToken.t_0 -> Uri.t_0 list ProviderResult.t_1 [@@js.call "provideFileSearchResults"]
    end
    module[@js.scope "FindTextInFilesOptions"] FindTextInFilesOptions : sig
      type t = vscode_FindTextInFilesOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_include: t -> GlobPattern.t_0 [@@js.get "include"]
      val set_include: t -> GlobPattern.t_0 -> unit [@@js.set "include"]
      val get_exclude: t -> GlobPattern.t_0 [@@js.get "exclude"]
      val set_exclude: t -> GlobPattern.t_0 -> unit [@@js.set "exclude"]
      val get_useDefaultExcludes: t -> bool [@@js.get "useDefaultExcludes"]
      val set_useDefaultExcludes: t -> bool -> unit [@@js.set "useDefaultExcludes"]
      val get_maxResults: t -> float [@@js.get "maxResults"]
      val set_maxResults: t -> float -> unit [@@js.set "maxResults"]
      val get_useIgnoreFiles: t -> bool [@@js.get "useIgnoreFiles"]
      val set_useIgnoreFiles: t -> bool -> unit [@@js.set "useIgnoreFiles"]
      val get_useGlobalIgnoreFiles: t -> bool [@@js.get "useGlobalIgnoreFiles"]
      val set_useGlobalIgnoreFiles: t -> bool -> unit [@@js.set "useGlobalIgnoreFiles"]
      val get_followSymlinks: t -> bool [@@js.get "followSymlinks"]
      val set_followSymlinks: t -> bool -> unit [@@js.set "followSymlinks"]
      val get_encoding: t -> string [@@js.get "encoding"]
      val set_encoding: t -> string -> unit [@@js.set "encoding"]
      val get_previewOptions: t -> vscode_TextSearchPreviewOptions [@@js.get "previewOptions"]
      val set_previewOptions: t -> vscode_TextSearchPreviewOptions -> unit [@@js.set "previewOptions"]
      val get_beforeContext: t -> float [@@js.get "beforeContext"]
      val set_beforeContext: t -> float -> unit [@@js.set "beforeContext"]
      val get_afterContext: t -> float [@@js.get "afterContext"]
      val set_afterContext: t -> float -> unit [@@js.set "afterContext"]
    end
    module[@js.scope "LineChange"] LineChange : sig
      type t = vscode_LineChange
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_originalStartLineNumber: t -> float [@@js.get "originalStartLineNumber"]
      val get_originalEndLineNumber: t -> float [@@js.get "originalEndLineNumber"]
      val get_modifiedStartLineNumber: t -> float [@@js.get "modifiedStartLineNumber"]
      val get_modifiedEndLineNumber: t -> float [@@js.get "modifiedEndLineNumber"]
    end
    module[@js.scope "commands"] Commands : sig
      val registerDiffInformationCommand: command:string -> callback:(diff:vscode_LineChange list -> args:(any list [@js.variadic]) -> any) -> ?thisArg:any -> unit -> Disposable.t_0 [@@js.global "registerDiffInformationCommand"]
    end
    module DebugProtocolVariableContainer : sig
      type t = vscode_DebugProtocolVariableContainer
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module DebugProtocolVariable : sig
      type t = vscode_DebugProtocolVariable
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module SourceControlInputBoxValidationType : sig
      type t = vscode_SourceControlInputBoxValidationType
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "SourceControlInputBoxValidation"] SourceControlInputBoxValidation : sig
      type t = vscode_SourceControlInputBoxValidation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_message: t -> string [@@js.get "message"]
      val get_type: t -> vscode_SourceControlInputBoxValidationType [@@js.get "type"]
    end
    module[@js.scope "SourceControlInputBox"] SourceControlInputBox : sig
      type t = vscode_SourceControlInputBox
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val focus: t -> unit [@@js.call "focus"]
      val showValidationMessage: t -> message:string -> type_:vscode_SourceControlInputBoxValidationType -> unit [@@js.call "showValidationMessage"]
      val validateInput: t -> value:string -> cursorPosition:float -> vscode_SourceControlInputBoxValidation ProviderResult.t_1 [@@js.call "validateInput"]
    end
    module[@js.scope "SourceControl"] SourceControl : sig
      type t = vscode_SourceControl
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_selected: t -> bool [@@js.get "selected"]
      val get_onDidChangeSelection: t -> bool Event.t_1 [@@js.get "onDidChangeSelection"]
    end
    module[@js.scope "TerminalDataWriteEvent"] TerminalDataWriteEvent : sig
      type t = vscode_TerminalDataWriteEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_terminal: t -> vscode_Terminal [@@js.get "terminal"]
      val get_data: t -> string [@@js.get "data"]
    end
    module[@js.scope "TerminalDimensionsChangeEvent"] TerminalDimensionsChangeEvent : sig
      type t = vscode_TerminalDimensionsChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_terminal: t -> vscode_Terminal [@@js.get "terminal"]
      val get_dimensions: t -> TerminalDimensions.t_0 [@@js.get "dimensions"]
    end
    module[@js.scope "Terminal"] Terminal : sig
      type t = vscode_Terminal
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_dimensions: t -> TerminalDimensions.t_0 or_undefined [@@js.get "dimensions"]
    end
    module[@js.scope "TerminalOptions"] TerminalOptions : sig
      type t = vscode_TerminalOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_icon: t -> string [@@js.get "icon"]
      val get_message: t -> string [@@js.get "message"]
    end
    module[@js.scope "DocumentFilter"] DocumentFilter : sig
      type t = vscode_DocumentFilter
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_exclusive: t -> bool [@@js.get "exclusive"]
    end
    module[@js.scope "TreeView"] TreeView : sig
      type 'T t = 'T vscode_TreeView
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val reveal: 'T t -> element:'T or_undefined -> ?options:anonymous_interface_12 -> unit -> unit Thenable.t_1 [@@js.call "reveal"]
      val cast: 'T t -> Disposable.t_0 [@@js.cast]
    end
    module[@js.scope "TaskPresentationOptions"] TaskPresentationOptions : sig
      type t = vscode_TaskPresentationOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_group: t -> string [@@js.get "group"]
      val set_group: t -> string -> unit [@@js.set "group"]
    end
    module[@js.scope "StatusBarItemOptions"] StatusBarItemOptions : sig
      type t = vscode_StatusBarItemOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val set_id: t -> string -> unit [@@js.set "id"]
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_accessibilityInformation: t -> AccessibilityInformation.t_0 [@@js.get "accessibilityInformation"]
      val set_accessibilityInformation: t -> AccessibilityInformation.t_0 -> unit [@@js.set "accessibilityInformation"]
      val get_alignment: t -> StatusBarAlignment.t_0 [@@js.get "alignment"]
      val set_alignment: t -> StatusBarAlignment.t_0 -> unit [@@js.set "alignment"]
      val get_priority: t -> float [@@js.get "priority"]
      val set_priority: t -> float -> unit [@@js.set "priority"]
    end
    module[@js.scope "CustomTextEditorProvider"] CustomTextEditorProvider : sig
      type t = vscode_CustomTextEditorProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val moveCustomTextEditor: t -> newDocument:vscode_TextDocument -> existingWebviewPanel:WebviewPanel.t_0 -> token:CancellationToken.t_0 -> unit Thenable.t_1 [@@js.call "moveCustomTextEditor"]
    end
    module[@js.scope "QuickPick"] QuickPick : sig
      type 'T t = 'T vscode_QuickPick
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_sortByLabel: 'T t -> bool [@@js.get "sortByLabel"]
      val set_sortByLabel: 'T t -> bool -> unit [@@js.set "sortByLabel"]
      val cast: 'T t -> QuickInput.t_0 [@@js.cast]
    end
    module[@js.scope "QuickPickOptions"] QuickPickOptions : sig
      type t = vscode_QuickPickOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_title: t -> string [@@js.get "title"]
      val set_title: t -> string -> unit [@@js.set "title"]
    end
    module[@js.scope "InputBoxOptions"] InputBoxOptions : sig
      type t = vscode_InputBoxOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_title: t -> string [@@js.get "title"]
      val set_title: t -> string -> unit [@@js.set "title"]
    end
    module NotebookCellKind : sig
      type t = vscode_NotebookCellKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "NotebookCellMetadata"] NotebookCellMetadata : sig
      type t = vscode_NotebookCellMetadata
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_editable: t -> bool [@@js.get "editable"]
      val get_breakpointMargin: t -> bool [@@js.get "breakpointMargin"]
      val get_outputCollapsed: t -> bool [@@js.get "outputCollapsed"]
      val get_inputCollapsed: t -> bool [@@js.get "inputCollapsed"]
      val get_custom: t -> (string, any) Record.t_2 [@@js.get "custom"]
      val get_statusMessage: t -> string [@@js.get "statusMessage"]
      val create: ?editable:bool -> ?breakpointMargin:bool -> ?statusMessage:string -> ?lastRunDuration:float -> ?inputCollapsed:bool -> ?outputCollapsed:bool -> ?custom:(string, any) Record.t_2 -> unit -> t [@@js.create]
      val with_: t -> change:anonymous_interface_5 -> t [@@js.call "with"]
    end
    module[@js.scope "NotebookCellExecutionSummary"] NotebookCellExecutionSummary : sig
      type t = vscode_NotebookCellExecutionSummary
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_executionOrder: t -> float [@@js.get "executionOrder"]
      val set_executionOrder: t -> float -> unit [@@js.set "executionOrder"]
      val get_success: t -> bool [@@js.get "success"]
      val set_success: t -> bool -> unit [@@js.set "success"]
      val get_duration: t -> float [@@js.get "duration"]
      val set_duration: t -> float -> unit [@@js.set "duration"]
    end
    module[@js.scope "NotebookCell"] NotebookCell : sig
      type t = vscode_NotebookCell
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_index: t -> float [@@js.get "index"]
      val get_notebook: t -> vscode_NotebookDocument [@@js.get "notebook"]
      val get_kind: t -> vscode_NotebookCellKind [@@js.get "kind"]
      val get_document: t -> vscode_TextDocument [@@js.get "document"]
      val get_metadata: t -> vscode_NotebookCellMetadata [@@js.get "metadata"]
      val get_outputs: t -> vscode_NotebookCellOutput list [@@js.get "outputs"]
      val get_latestExecutionSummary: t -> vscode_NotebookCellExecutionSummary or_undefined [@@js.get "latestExecutionSummary"]
    end
    module[@js.scope "NotebookDocumentMetadata"] NotebookDocumentMetadata : sig
      type t = vscode_NotebookDocumentMetadata
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_editable: t -> bool [@@js.get "editable"]
      val get_cellEditable: t -> bool [@@js.get "cellEditable"]
      val get_custom: t -> anonymous_interface_16 [@@js.get "custom"]
      val get_trusted: t -> bool [@@js.get "trusted"]
      val create: ?editable:bool -> ?cellEditable:bool -> ?custom:anonymous_interface_16 -> ?trusted:bool -> unit -> t [@@js.create]
      val with_: t -> change:anonymous_interface_6 -> t [@@js.call "with"]
    end
    module[@js.scope "NotebookDocumentContentOptions"] NotebookDocumentContentOptions : sig
      type t = vscode_NotebookDocumentContentOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_transientOutputs: t -> bool [@@js.get "transientOutputs"]
      val set_transientOutputs: t -> bool -> unit [@@js.set "transientOutputs"]
      val get_transientMetadata: t -> (* FIXME: unknown type '{ [K in keyof NotebookCellMetadata]?: boolean }' *)any [@@js.get "transientMetadata"]
      val set_transientMetadata: t -> (* FIXME: unknown type '{ [K in keyof NotebookCellMetadata]?: boolean }' *)any -> unit [@@js.set "transientMetadata"]
    end
    module[@js.scope "NotebookDocument"] NotebookDocument : sig
      type t = vscode_NotebookDocument
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_uri: t -> Uri.t_0 [@@js.get "uri"]
      val get_version: t -> float [@@js.get "version"]
      val get_fileName: t -> string [@@js.get "fileName"]
      val get_isDirty: t -> bool [@@js.get "isDirty"]
      val get_isUntitled: t -> bool [@@js.get "isUntitled"]
      val get_isClosed: t -> bool [@@js.get "isClosed"]
      val get_metadata: t -> vscode_NotebookDocumentMetadata [@@js.get "metadata"]
      val get_viewType: t -> string [@@js.get "viewType"]
      val get_cellCount: t -> float [@@js.get "cellCount"]
      val cellAt: t -> index:float -> vscode_NotebookCell [@@js.call "cellAt"]
      val getCells: t -> ?range:vscode_NotebookCellRange -> unit -> vscode_NotebookCell list [@@js.call "getCells"]
      val save: t -> bool Thenable.t_1 [@@js.call "save"]
    end
    module[@js.scope "NotebookCellRange"] NotebookCellRange : sig
      type t = vscode_NotebookCellRange
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_start: t -> float [@@js.get "start"]
      val get_end: t -> float [@@js.get "end"]
      val get_isEmpty: t -> bool [@@js.get "isEmpty"]
      val create: start:float -> end_:float -> t [@@js.create]
      val with_: t -> change:anonymous_interface_13 -> t [@@js.call "with"]
    end
    module NotebookEditorRevealType : sig
      type t = vscode_NotebookEditorRevealType
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "NotebookEditor"] NotebookEditor : sig
      type t = vscode_NotebookEditor
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val setDecorations: t -> decorationType:vscode_NotebookEditorDecorationType -> range:vscode_NotebookCellRange -> unit [@@js.call "setDecorations"]
      val get_kernel: t -> vscode_NotebookKernel [@@js.get "kernel"]
      val edit: t -> callback:(editBuilder:vscode_NotebookEditorEdit -> unit) -> bool Thenable.t_1 [@@js.call "edit"]
      val get_document: t -> vscode_NotebookDocument [@@js.get "document"]
      val get_selection: t -> vscode_NotebookCell [@@js.get "selection"]
      val get_selections: t -> vscode_NotebookCellRange list [@@js.get "selections"]
      val get_visibleRanges: t -> vscode_NotebookCellRange list [@@js.get "visibleRanges"]
      val revealRange: t -> range:vscode_NotebookCellRange -> ?revealType:vscode_NotebookEditorRevealType -> unit -> unit [@@js.call "revealRange"]
      val get_viewColumn: t -> ViewColumn.t_0 [@@js.get "viewColumn"]
    end
    module[@js.scope "NotebookDocumentMetadataChangeEvent"] NotebookDocumentMetadataChangeEvent : sig
      type t = vscode_NotebookDocumentMetadataChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_document: t -> vscode_NotebookDocument [@@js.get "document"]
    end
    module[@js.scope "NotebookCellsChangeData"] NotebookCellsChangeData : sig
      type t = vscode_NotebookCellsChangeData
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_start: t -> float [@@js.get "start"]
      val get_deletedCount: t -> float [@@js.get "deletedCount"]
      val get_deletedItems: t -> vscode_NotebookCell list [@@js.get "deletedItems"]
      val get_items: t -> vscode_NotebookCell list [@@js.get "items"]
    end
    module[@js.scope "NotebookCellsChangeEvent"] NotebookCellsChangeEvent : sig
      type t = vscode_NotebookCellsChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_document: t -> vscode_NotebookDocument [@@js.get "document"]
      val get_changes: t -> vscode_NotebookCellsChangeData list [@@js.get "changes"]
    end
    module[@js.scope "NotebookCellOutputsChangeEvent"] NotebookCellOutputsChangeEvent : sig
      type t = vscode_NotebookCellOutputsChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_document: t -> vscode_NotebookDocument [@@js.get "document"]
      val get_cells: t -> vscode_NotebookCell list [@@js.get "cells"]
    end
    module[@js.scope "NotebookCellMetadataChangeEvent"] NotebookCellMetadataChangeEvent : sig
      type t = vscode_NotebookCellMetadataChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_document: t -> vscode_NotebookDocument [@@js.get "document"]
      val get_cell: t -> vscode_NotebookCell [@@js.get "cell"]
    end
    module[@js.scope "NotebookEditorSelectionChangeEvent"] NotebookEditorSelectionChangeEvent : sig
      type t = vscode_NotebookEditorSelectionChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_notebookEditor: t -> vscode_NotebookEditor [@@js.get "notebookEditor"]
      val get_selections: t -> vscode_NotebookCellRange list [@@js.get "selections"]
    end
    module[@js.scope "NotebookEditorVisibleRangesChangeEvent"] NotebookEditorVisibleRangesChangeEvent : sig
      type t = vscode_NotebookEditorVisibleRangesChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_notebookEditor: t -> vscode_NotebookEditor [@@js.get "notebookEditor"]
      val get_visibleRanges: t -> vscode_NotebookCellRange list [@@js.get "visibleRanges"]
    end
    module[@js.scope "NotebookCellExecutionStateChangeEvent"] NotebookCellExecutionStateChangeEvent : sig
      type t = vscode_NotebookCellExecutionStateChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_document: t -> vscode_NotebookDocument [@@js.get "document"]
      val get_cell: t -> vscode_NotebookCell [@@js.get "cell"]
      val get_executionState: t -> vscode_NotebookCellExecutionState [@@js.get "executionState"]
    end
    module[@js.scope "NotebookCellData"] NotebookCellData : sig
      type t = vscode_NotebookCellData
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_kind: t -> vscode_NotebookCellKind [@@js.get "kind"]
      val set_kind: t -> vscode_NotebookCellKind -> unit [@@js.set "kind"]
      val get_source: t -> string [@@js.get "source"]
      val set_source: t -> string -> unit [@@js.set "source"]
      val get_language: t -> string [@@js.get "language"]
      val set_language: t -> string -> unit [@@js.set "language"]
      val get_outputs: t -> vscode_NotebookCellOutput list [@@js.get "outputs"]
      val set_outputs: t -> vscode_NotebookCellOutput list -> unit [@@js.set "outputs"]
      val get_metadata: t -> vscode_NotebookCellMetadata [@@js.get "metadata"]
      val set_metadata: t -> vscode_NotebookCellMetadata -> unit [@@js.set "metadata"]
      val get_latestExecutionSummary: t -> vscode_NotebookCellExecutionSummary [@@js.get "latestExecutionSummary"]
      val set_latestExecutionSummary: t -> vscode_NotebookCellExecutionSummary -> unit [@@js.set "latestExecutionSummary"]
      val create: kind:vscode_NotebookCellKind -> source:string -> language:string -> ?outputs:vscode_NotebookCellOutput list -> ?metadata:vscode_NotebookCellMetadata -> ?latestExecutionSummary:vscode_NotebookCellExecutionSummary -> unit -> t [@@js.create]
    end
    module[@js.scope "NotebookData"] NotebookData : sig
      type t = vscode_NotebookData
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_cells: t -> vscode_NotebookCellData list [@@js.get "cells"]
      val set_cells: t -> vscode_NotebookCellData list -> unit [@@js.set "cells"]
      val get_metadata: t -> vscode_NotebookDocumentMetadata [@@js.get "metadata"]
      val set_metadata: t -> vscode_NotebookDocumentMetadata -> unit [@@js.set "metadata"]
      val create: cells:vscode_NotebookCellData list -> ?metadata:vscode_NotebookDocumentMetadata -> unit -> t [@@js.create]
    end
    module[@js.scope "NotebookCommunication"] NotebookCommunication : sig
      type t = vscode_NotebookCommunication
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_editorId: t -> string [@@js.get "editorId"]
      val get_onDidReceiveMessage: t -> any Event.t_1 [@@js.get "onDidReceiveMessage"]
      val postMessage: t -> message:any -> bool Thenable.t_1 [@@js.call "postMessage"]
      val asWebviewUri: t -> localResource:Uri.t_0 -> Uri.t_0 [@@js.call "asWebviewUri"]
    end
    module[@js.scope "NotebookDocumentShowOptions"] NotebookDocumentShowOptions : sig
      type t = vscode_NotebookDocumentShowOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_viewColumn: t -> ViewColumn.t_0 [@@js.get "viewColumn"]
      val set_viewColumn: t -> ViewColumn.t_0 -> unit [@@js.set "viewColumn"]
      val get_preserveFocus: t -> bool [@@js.get "preserveFocus"]
      val set_preserveFocus: t -> bool -> unit [@@js.set "preserveFocus"]
      val get_preview: t -> bool [@@js.get "preview"]
      val set_preview: t -> bool -> unit [@@js.set "preview"]
      val get_selection: t -> vscode_NotebookCellRange [@@js.get "selection"]
      val set_selection: t -> vscode_NotebookCellRange -> unit [@@js.set "selection"]
    end
    module[@js.scope "notebook"] Notebook : sig
      val openNotebookDocument: uri:Uri.t_0 -> vscode_NotebookDocument Thenable.t_1 [@@js.global "openNotebookDocument"]
      val onDidOpenNotebookDocument: vscode_NotebookDocument Event.t_1 [@@js.global "onDidOpenNotebookDocument"]
      val onDidCloseNotebookDocument: vscode_NotebookDocument Event.t_1 [@@js.global "onDidCloseNotebookDocument"]
      val onDidSaveNotebookDocument: vscode_NotebookDocument Event.t_1 [@@js.global "onDidSaveNotebookDocument"]
      val notebookDocuments: vscode_NotebookDocument list [@@js.global "notebookDocuments"]
      val onDidChangeNotebookDocumentMetadata: vscode_NotebookDocumentMetadataChangeEvent Event.t_1 [@@js.global "onDidChangeNotebookDocumentMetadata"]
      val onDidChangeNotebookCells: vscode_NotebookCellsChangeEvent Event.t_1 [@@js.global "onDidChangeNotebookCells"]
      val onDidChangeCellOutputs: vscode_NotebookCellOutputsChangeEvent Event.t_1 [@@js.global "onDidChangeCellOutputs"]
      val onDidChangeCellMetadata: vscode_NotebookCellMetadataChangeEvent Event.t_1 [@@js.global "onDidChangeCellMetadata"]
      val registerNotebookSerializer: notebookType:string -> provider:vscode_NotebookSerializer -> ?options:vscode_NotebookDocumentContentOptions -> unit -> Disposable.t_0 [@@js.global "registerNotebookSerializer"]
      val createNotebookKernel: options:vscode_NotebookKernelOptions -> vscode_NotebookKernel2 [@@js.global "createNotebookKernel"]
      val registerNotebookContentProvider: notebookType:string -> provider:vscode_NotebookContentProvider -> ?options:(vscode_NotebookDocumentContentOptions, anonymous_interface_15) intersection2 -> unit -> Disposable.t_0 [@@js.global "registerNotebookContentProvider"]
      val createNotebookCellExecutionTask: uri:Uri.t_0 -> index:float -> kernelId:string -> vscode_NotebookCellExecutionTask or_undefined [@@js.global "createNotebookCellExecutionTask"]
      val onDidChangeCellExecutionState: vscode_NotebookCellExecutionStateChangeEvent Event.t_1 [@@js.global "onDidChangeCellExecutionState"]
      val onDidChangeActiveNotebookKernel: anonymous_interface_4 Event.t_1 [@@js.global "onDidChangeActiveNotebookKernel"]
      val registerNotebookKernelProvider: selector:vscode_NotebookDocumentFilter -> provider:vscode_NotebookKernel vscode_NotebookKernelProvider -> Disposable.t_0 [@@js.global "registerNotebookKernelProvider"]
      val createNotebookEditorDecorationType: options:vscode_NotebookDecorationRenderOptions -> vscode_NotebookEditorDecorationType [@@js.global "createNotebookEditorDecorationType"]
      val createCellStatusBarItem: cell:vscode_NotebookCell -> ?alignment:vscode_NotebookCellStatusBarAlignment -> ?priority:float -> unit -> vscode_NotebookCellStatusBarItem [@@js.global "createCellStatusBarItem"]
      val createConcatTextDocument: notebook:vscode_NotebookDocument -> ?selector:DocumentSelector.t_0 -> unit -> vscode_NotebookConcatTextDocument [@@js.global "createConcatTextDocument"]
    end
    module[@js.scope "NotebookCellOutputItem"] NotebookCellOutputItem : sig
      type t = vscode_NotebookCellOutputItem
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_mime: t -> string [@@js.get "mime"]
      val get_value: t -> unknown [@@js.get "value"]
      val get_metadata: t -> (string, any) Record.t_2 [@@js.get "metadata"]
      val create: mime:string -> value:unknown -> ?metadata:(string, any) Record.t_2 -> unit -> t [@@js.create]
    end
    module[@js.scope "NotebookCellOutput"] NotebookCellOutput : sig
      type t = vscode_NotebookCellOutput
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val get_outputs: t -> vscode_NotebookCellOutputItem list [@@js.get "outputs"]
      val get_metadata: t -> (string, any) Record.t_2 [@@js.get "metadata"]
      val create: outputs:vscode_NotebookCellOutputItem list -> ?metadata:(string, any) Record.t_2 -> unit -> t [@@js.create]
      val create': outputs:vscode_NotebookCellOutputItem list -> id:string -> ?metadata:(string, any) Record.t_2 -> unit -> t [@@js.create]
    end
    module[@js.scope "WorkspaceEdit"] WorkspaceEdit : sig
      type t = vscode_WorkspaceEdit
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val replaceNotebookMetadata: t -> uri:Uri.t_0 -> value:vscode_NotebookDocumentMetadata -> unit [@@js.call "replaceNotebookMetadata"]
      val replaceNotebookCells: t -> uri:Uri.t_0 -> start:float -> end_:float -> cells:vscode_NotebookCellData list -> ?metadata:WorkspaceEditEntryMetadata.t_0 -> unit -> unit [@@js.call "replaceNotebookCells"]
      val replaceNotebookCellMetadata: t -> uri:Uri.t_0 -> index:float -> cellMetadata:vscode_NotebookCellMetadata -> ?metadata:WorkspaceEditEntryMetadata.t_0 -> unit -> unit [@@js.call "replaceNotebookCellMetadata"]
      val replaceNotebookCellOutput: t -> uri:Uri.t_0 -> index:float -> outputs:vscode_NotebookCellOutput list -> ?metadata:WorkspaceEditEntryMetadata.t_0 -> unit -> unit [@@js.call "replaceNotebookCellOutput"]
      val appendNotebookCellOutput: t -> uri:Uri.t_0 -> index:float -> outputs:vscode_NotebookCellOutput list -> ?metadata:WorkspaceEditEntryMetadata.t_0 -> unit -> unit [@@js.call "appendNotebookCellOutput"]
      val replaceNotebookCellOutputItems: t -> uri:Uri.t_0 -> index:float -> outputId:string -> items:vscode_NotebookCellOutputItem list -> ?metadata:WorkspaceEditEntryMetadata.t_0 -> unit -> unit [@@js.call "replaceNotebookCellOutputItems"]
      val appendNotebookCellOutputItems: t -> uri:Uri.t_0 -> index:float -> outputId:string -> items:vscode_NotebookCellOutputItem list -> ?metadata:WorkspaceEditEntryMetadata.t_0 -> unit -> unit [@@js.call "appendNotebookCellOutputItems"]
    end
    module[@js.scope "NotebookEditorEdit"] NotebookEditorEdit : sig
      type t = vscode_NotebookEditorEdit
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val replaceMetadata: t -> value:vscode_NotebookDocumentMetadata -> unit [@@js.call "replaceMetadata"]
      val replaceCells: t -> start:float -> end_:float -> cells:vscode_NotebookCellData list -> unit [@@js.call "replaceCells"]
      val replaceCellOutput: t -> index:float -> outputs:vscode_NotebookCellOutput list -> unit [@@js.call "replaceCellOutput"]
      val replaceCellMetadata: t -> index:float -> metadata:vscode_NotebookCellMetadata -> unit [@@js.call "replaceCellMetadata"]
    end
    module[@js.scope "NotebookSerializer"] NotebookSerializer : sig
      type t = vscode_NotebookSerializer
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val dataToNotebook: t -> data:Uint8Array.t_0 -> (vscode_NotebookData, vscode_NotebookData Thenable.t_1) union2 [@@js.call "dataToNotebook"]
      val notebookToData: t -> data:vscode_NotebookData -> (Uint8Array.t_0, Uint8Array.t_0 Thenable.t_1) union2 [@@js.call "notebookToData"]
    end
    module[@js.scope "NotebookFilter"] NotebookFilter : sig
      type t = vscode_NotebookFilter
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_viewType: t -> string [@@js.get "viewType"]
      val get_scheme: t -> string [@@js.get "scheme"]
      val get_pattern: t -> GlobPattern.t_0 [@@js.get "pattern"]
    end
    module NotebookSelector : sig
      type t = vscode_NotebookSelector
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "NotebookKernel2"] NotebookKernel2 : sig
      type t = vscode_NotebookKernel2
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val get_selector: t -> vscode_NotebookSelector [@@js.get "selector"]
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_description: t -> string [@@js.get "description"]
      val set_description: t -> string -> unit [@@js.set "description"]
      val get_supportedLanguages: t -> string list [@@js.get "supportedLanguages"]
      val set_supportedLanguages: t -> string list -> unit [@@js.set "supportedLanguages"]
      val get_hasExecutionOrder: t -> bool [@@js.get "hasExecutionOrder"]
      val set_hasExecutionOrder: t -> bool -> unit [@@js.set "hasExecutionOrder"]
      val executeHandler: t -> executions:vscode_NotebookCellExecutionTask list -> unit [@@js.call "executeHandler"]
      val interruptHandler: t -> notebook:vscode_NotebookDocument -> unit [@@js.call "interruptHandler"]
      val dispose: t -> unit [@@js.call "dispose"]
      val createNotebookCellExecutionTask: t -> cell:vscode_NotebookCell -> vscode_NotebookCellExecutionTask [@@js.call "createNotebookCellExecutionTask"]
    end
    module[@js.scope "NotebookKernelOptions"] NotebookKernelOptions : sig
      type t = vscode_NotebookKernelOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val set_id: t -> string -> unit [@@js.set "id"]
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_description: t -> string [@@js.get "description"]
      val set_description: t -> string -> unit [@@js.set "description"]
      val get_selector: t -> vscode_NotebookSelector [@@js.get "selector"]
      val set_selector: t -> vscode_NotebookSelector -> unit [@@js.set "selector"]
      val get_supportedLanguages: t -> string list [@@js.get "supportedLanguages"]
      val set_supportedLanguages: t -> string list -> unit [@@js.set "supportedLanguages"]
      val get_hasExecutionOrder: t -> bool [@@js.get "hasExecutionOrder"]
      val set_hasExecutionOrder: t -> bool -> unit [@@js.set "hasExecutionOrder"]
      val executeHandler: t -> executions:vscode_NotebookCellExecutionTask list -> unit [@@js.call "executeHandler"]
      val interruptHandler: t -> notebook:vscode_NotebookDocument -> unit [@@js.call "interruptHandler"]
    end
    module[@js.scope "NotebookDocumentBackup"] NotebookDocumentBackup : sig
      type t = vscode_NotebookDocumentBackup
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val delete: t -> unit [@@js.call "delete"]
    end
    module[@js.scope "NotebookDocumentBackupContext"] NotebookDocumentBackupContext : sig
      type t = vscode_NotebookDocumentBackupContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_destination: t -> Uri.t_0 [@@js.get "destination"]
    end
    module[@js.scope "NotebookDocumentOpenContext"] NotebookDocumentOpenContext : sig
      type t = vscode_NotebookDocumentOpenContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_backupId: t -> string [@@js.get "backupId"]
      val get_untitledDocumentData: t -> Uint8Array.t_0 [@@js.get "untitledDocumentData"]
    end
    module[@js.scope "NotebookContentProvider"] NotebookContentProvider : sig
      type t = vscode_NotebookContentProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_options: t -> vscode_NotebookDocumentContentOptions [@@js.get "options"]
      val get_onDidChangeNotebookContentOptions: t -> vscode_NotebookDocumentContentOptions Event.t_1 [@@js.get "onDidChangeNotebookContentOptions"]
      val openNotebook: t -> uri:Uri.t_0 -> openContext:vscode_NotebookDocumentOpenContext -> token:CancellationToken.t_0 -> (vscode_NotebookData, vscode_NotebookData Thenable.t_1) union2 [@@js.call "openNotebook"]
      val saveNotebook: t -> document:vscode_NotebookDocument -> token:CancellationToken.t_0 -> unit Thenable.t_1 [@@js.call "saveNotebook"]
      val saveNotebookAs: t -> targetResource:Uri.t_0 -> document:vscode_NotebookDocument -> token:CancellationToken.t_0 -> unit Thenable.t_1 [@@js.call "saveNotebookAs"]
      val backupNotebook: t -> document:vscode_NotebookDocument -> context:vscode_NotebookDocumentBackupContext -> token:CancellationToken.t_0 -> vscode_NotebookDocumentBackup Thenable.t_1 [@@js.call "backupNotebook"]
    end
    module[@js.scope "NotebookKernel"] NotebookKernel : sig
      type t = vscode_NotebookKernel
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_description: t -> string [@@js.get "description"]
      val set_description: t -> string -> unit [@@js.set "description"]
      val get_detail: t -> string [@@js.get "detail"]
      val set_detail: t -> string -> unit [@@js.set "detail"]
      val get_isPreferred: t -> bool [@@js.get "isPreferred"]
      val set_isPreferred: t -> bool -> unit [@@js.set "isPreferred"]
      val get_preloads: t -> Uri.t_0 list [@@js.get "preloads"]
      val set_preloads: t -> Uri.t_0 list -> unit [@@js.set "preloads"]
      val get_supportedLanguages: t -> string list [@@js.get "supportedLanguages"]
      val set_supportedLanguages: t -> string list -> unit [@@js.set "supportedLanguages"]
      val interrupt: t -> document:vscode_NotebookDocument -> unit [@@js.call "interrupt"]
      val executeCellsRequest: t -> document:vscode_NotebookDocument -> ranges:vscode_NotebookCellRange list -> unit Thenable.t_1 [@@js.call "executeCellsRequest"]
    end
    module[@js.scope "NotebookCellExecuteStartContext"] NotebookCellExecuteStartContext : sig
      type t = vscode_NotebookCellExecuteStartContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_startTime: t -> float [@@js.get "startTime"]
      val set_startTime: t -> float -> unit [@@js.set "startTime"]
    end
    module[@js.scope "NotebookCellExecuteEndContext"] NotebookCellExecuteEndContext : sig
      type t = vscode_NotebookCellExecuteEndContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_success: t -> bool [@@js.get "success"]
      val set_success: t -> bool -> unit [@@js.set "success"]
      val get_duration: t -> float [@@js.get "duration"]
      val set_duration: t -> float -> unit [@@js.set "duration"]
    end
    module[@js.scope "NotebookCellExecutionTask"] NotebookCellExecutionTask : sig
      type t = vscode_NotebookCellExecutionTask
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_document: t -> vscode_NotebookDocument [@@js.get "document"]
      val get_cell: t -> vscode_NotebookCell [@@js.get "cell"]
      val start: t -> ?context:vscode_NotebookCellExecuteStartContext -> unit -> unit [@@js.call "start"]
      val get_executionOrder: t -> float or_undefined [@@js.get "executionOrder"]
      val set_executionOrder: t -> float or_undefined -> unit [@@js.set "executionOrder"]
      val end_: t -> ?result:vscode_NotebookCellExecuteEndContext -> unit -> unit [@@js.call "end"]
      val get_token: t -> CancellationToken.t_0 [@@js.get "token"]
      val clearOutput: t -> ?cellIndex:float -> unit -> unit Thenable.t_1 [@@js.call "clearOutput"]
      val appendOutput: t -> out:(vscode_NotebookCellOutput, vscode_NotebookCellOutput) or_array -> ?cellIndex:float -> unit -> unit Thenable.t_1 [@@js.call "appendOutput"]
      val replaceOutput: t -> out:(vscode_NotebookCellOutput, vscode_NotebookCellOutput) or_array -> ?cellIndex:float -> unit -> unit Thenable.t_1 [@@js.call "replaceOutput"]
      val appendOutputItems: t -> items:(vscode_NotebookCellOutputItem, vscode_NotebookCellOutputItem) or_array -> outputId:string -> unit Thenable.t_1 [@@js.call "appendOutputItems"]
      val replaceOutputItems: t -> items:(vscode_NotebookCellOutputItem, vscode_NotebookCellOutputItem) or_array -> outputId:string -> unit Thenable.t_1 [@@js.call "replaceOutputItems"]
    end
    module NotebookCellExecutionState : sig
      type t = vscode_NotebookCellExecutionState
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module NotebookFilenamePattern : sig
      type t = vscode_NotebookFilenamePattern
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "NotebookDocumentFilter"] NotebookDocumentFilter : sig
      type t = vscode_NotebookDocumentFilter
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_viewType: t -> string list or_string [@@js.get "viewType"]
      val set_viewType: t -> string list or_string -> unit [@@js.set "viewType"]
      val get_filenamePattern: t -> vscode_NotebookFilenamePattern [@@js.get "filenamePattern"]
      val set_filenamePattern: t -> vscode_NotebookFilenamePattern -> unit [@@js.set "filenamePattern"]
    end
    module[@js.scope "NotebookKernelProvider"] NotebookKernelProvider : sig
      type 'T t = 'T vscode_NotebookKernelProvider
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_NotebookKernel t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidChangeKernels: 'T t -> vscode_NotebookDocument or_undefined Event.t_1 [@@js.get "onDidChangeKernels"]
      val set_onDidChangeKernels: 'T t -> vscode_NotebookDocument or_undefined Event.t_1 -> unit [@@js.set "onDidChangeKernels"]
      val provideKernels: 'T t -> document:vscode_NotebookDocument -> token:CancellationToken.t_0 -> 'T list ProviderResult.t_1 [@@js.call "provideKernels"]
      val resolveKernel: 'T t -> kernel:'T -> document:vscode_NotebookDocument -> webview:vscode_NotebookCommunication -> token:CancellationToken.t_0 -> unit ProviderResult.t_1 [@@js.call "resolveKernel"]
    end
    module[@js.scope "NotebookDecorationRenderOptions"] NotebookDecorationRenderOptions : sig
      type t = vscode_NotebookDecorationRenderOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_backgroundColor: t -> ThemeColor.t_0 or_string [@@js.get "backgroundColor"]
      val set_backgroundColor: t -> ThemeColor.t_0 or_string -> unit [@@js.set "backgroundColor"]
      val get_borderColor: t -> ThemeColor.t_0 or_string [@@js.get "borderColor"]
      val set_borderColor: t -> ThemeColor.t_0 or_string -> unit [@@js.set "borderColor"]
      val get_top: t -> ThemableDecorationAttachmentRenderOptions.t_0 [@@js.get "top"]
      val set_top: t -> ThemableDecorationAttachmentRenderOptions.t_0 -> unit [@@js.set "top"]
    end
    module[@js.scope "NotebookEditorDecorationType"] NotebookEditorDecorationType : sig
      type t = vscode_NotebookEditorDecorationType
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_key: t -> string [@@js.get "key"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module NotebookCellStatusBarAlignment : sig
      type t = vscode_NotebookCellStatusBarAlignment
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "NotebookCellStatusBarItem"] NotebookCellStatusBarItem : sig
      type t = vscode_NotebookCellStatusBarItem
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_cell: t -> vscode_NotebookCell [@@js.get "cell"]
      val get_alignment: t -> vscode_NotebookCellStatusBarAlignment [@@js.get "alignment"]
      val get_priority: t -> float [@@js.get "priority"]
      val get_text: t -> string [@@js.get "text"]
      val set_text: t -> string -> unit [@@js.set "text"]
      val get_tooltip: t -> string or_undefined [@@js.get "tooltip"]
      val set_tooltip: t -> string or_undefined -> unit [@@js.set "tooltip"]
      val get_command: t -> Command.t_0 or_string or_undefined [@@js.get "command"]
      val set_command: t -> Command.t_0 or_string or_undefined -> unit [@@js.set "command"]
      val get_accessibilityInformation: t -> AccessibilityInformation.t_0 [@@js.get "accessibilityInformation"]
      val set_accessibilityInformation: t -> AccessibilityInformation.t_0 -> unit [@@js.set "accessibilityInformation"]
      val show: t -> unit [@@js.call "show"]
      val hide: t -> unit [@@js.call "hide"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "NotebookConcatTextDocument"] NotebookConcatTextDocument : sig
      type t = vscode_NotebookConcatTextDocument
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_uri: t -> Uri.t_0 [@@js.get "uri"]
      val set_uri: t -> Uri.t_0 -> unit [@@js.set "uri"]
      val get_isClosed: t -> bool [@@js.get "isClosed"]
      val set_isClosed: t -> bool -> unit [@@js.set "isClosed"]
      val dispose: t -> unit [@@js.call "dispose"]
      val get_onDidChange: t -> unit Event.t_1 [@@js.get "onDidChange"]
      val set_onDidChange: t -> unit Event.t_1 -> unit [@@js.set "onDidChange"]
      val get_version: t -> float [@@js.get "version"]
      val set_version: t -> float -> unit [@@js.set "version"]
      val getText: t -> string [@@js.call "getText"]
      val getText': t -> range:Range.t_0 -> string [@@js.call "getText"]
      val offsetAt: t -> position:Position.t_0 -> float [@@js.call "offsetAt"]
      val positionAt: t -> offset:float -> Position.t_0 [@@js.call "positionAt"]
      val validateRange: t -> range:Range.t_0 -> Range.t_0 [@@js.call "validateRange"]
      val validatePosition: t -> position:Position.t_0 -> Position.t_0 [@@js.call "validatePosition"]
      val locationAt: t -> positionOrRange:(Position.t_0, Range.t_0) union2 -> Location.t_0 [@@js.call "locationAt"]
      val positionAt': t -> location:Location.t_0 -> Position.t_0 [@@js.call "positionAt"]
      val contains: t -> uri:Uri.t_0 -> bool [@@js.call "contains"]
    end
    module[@js.scope "CompletionItem"] CompletionItem : sig
      type t = vscode_CompletionItem
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_label2: t -> vscode_CompletionItemLabel [@@js.get "label2"]
      val set_label2: t -> vscode_CompletionItemLabel -> unit [@@js.set "label2"]
    end
    module[@js.scope "CompletionItemLabel"] CompletionItemLabel : sig
      type t = vscode_CompletionItemLabel
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_parameters: t -> string [@@js.get "parameters"]
      val set_parameters: t -> string -> unit [@@js.set "parameters"]
      val get_qualifier: t -> string [@@js.get "qualifier"]
      val set_qualifier: t -> string -> unit [@@js.set "qualifier"]
      val get_type: t -> string [@@js.get "type"]
      val set_type: t -> string -> unit [@@js.set "type"]
    end
    module[@js.scope "TimelineItem"] TimelineItem : sig
      type t = vscode_TimelineItem
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_timestamp: t -> float [@@js.get "timestamp"]
      val set_timestamp: t -> float -> unit [@@js.set "timestamp"]
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_id: t -> string [@@js.get "id"]
      val set_id: t -> string -> unit [@@js.set "id"]
      val get_iconPath: t -> (ThemeIcon.t_0, Uri.t_0, anonymous_interface_9) union3 [@@js.get "iconPath"]
      val set_icon_path: t -> (ThemeIcon.t_0, Uri.t_0, anonymous_interface_9) union3 -> unit [@@js.set "iconPath"]
      val get_description: t -> string [@@js.get "description"]
      val set_description: t -> string -> unit [@@js.set "description"]
      val get_detail: t -> string [@@js.get "detail"]
      val set_detail: t -> string -> unit [@@js.set "detail"]
      val get_command: t -> Command.t_0 [@@js.get "command"]
      val set_command: t -> Command.t_0 -> unit [@@js.set "command"]
      val get_contextValue: t -> string [@@js.get "contextValue"]
      val set_contextValue: t -> string -> unit [@@js.set "contextValue"]
      val get_accessibilityInformation: t -> AccessibilityInformation.t_0 [@@js.get "accessibilityInformation"]
      val set_accessibilityInformation: t -> AccessibilityInformation.t_0 -> unit [@@js.set "accessibilityInformation"]
      val create: label:string -> timestamp:float -> t [@@js.create]
    end
    module[@js.scope "TimelineChangeEvent"] TimelineChangeEvent : sig
      type t = vscode_TimelineChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_uri: t -> Uri.t_0 [@@js.get "uri"]
      val set_uri: t -> Uri.t_0 -> unit [@@js.set "uri"]
      val get_reset: t -> bool [@@js.get "reset"]
      val set_reset: t -> bool -> unit [@@js.set "reset"]
    end
    module[@js.scope "Timeline"] Timeline : sig
      type t = vscode_Timeline
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_paging: t -> anonymous_interface_2 [@@js.get "paging"]
      val get_items: t -> vscode_TimelineItem list [@@js.get "items"]
    end
    module[@js.scope "TimelineOptions"] TimelineOptions : sig
      type t = vscode_TimelineOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_cursor: t -> string [@@js.get "cursor"]
      val set_cursor: t -> string -> unit [@@js.set "cursor"]
      val get_limit: t -> anonymous_interface_14 or_number [@@js.get "limit"]
      val set_limit: t -> anonymous_interface_14 or_number -> unit [@@js.set "limit"]
    end
    module[@js.scope "TimelineProvider"] TimelineProvider : sig
      type t = vscode_TimelineProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidChange: t -> vscode_TimelineChangeEvent or_undefined Event.t_1 [@@js.get "onDidChange"]
      val set_onDidChange: t -> vscode_TimelineChangeEvent or_undefined Event.t_1 -> unit [@@js.set "onDidChange"]
      val get_id: t -> string [@@js.get "id"]
      val get_label: t -> string [@@js.get "label"]
      val provideTimeline: t -> uri:Uri.t_0 -> options:vscode_TimelineOptions -> token:CancellationToken.t_0 -> vscode_Timeline ProviderResult.t_1 [@@js.call "provideTimeline"]
    end
    module StandardTokenType : sig
      type t = vscode_StandardTokenType
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "TokenInformation"] TokenInformation : sig
      type t = vscode_TokenInformation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> vscode_StandardTokenType [@@js.get "type"]
      val set_type: t -> vscode_StandardTokenType -> unit [@@js.set "type"]
      val get_range: t -> Range.t_0 [@@js.get "range"]
      val set_range: t -> Range.t_0 -> unit [@@js.set "range"]
    end
    module[@js.scope "languages"] Languages : sig
      val getTokenInformationAtPosition: document:vscode_TextDocument -> position:Position.t_0 -> vscode_TokenInformation Thenable.t_1 [@@js.global "getTokenInformationAtPosition"]
      val registerInlineHintsProvider: selector:DocumentSelector.t_0 -> provider:vscode_InlineHintsProvider -> Disposable.t_0 [@@js.global "registerInlineHintsProvider"]
    end
    module InlineHintKind : sig
      type t = vscode_InlineHintKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "InlineHint"] InlineHint : sig
      type t = vscode_InlineHint
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_text: t -> string [@@js.get "text"]
      val set_text: t -> string -> unit [@@js.set "text"]
      val get_range: t -> Range.t_0 [@@js.get "range"]
      val set_range: t -> Range.t_0 -> unit [@@js.set "range"]
      val get_kind: t -> vscode_InlineHintKind [@@js.get "kind"]
      val set_kind: t -> vscode_InlineHintKind -> unit [@@js.set "kind"]
      val get_description: t -> MarkdownString.t_0 or_string [@@js.get "description"]
      val set_description: t -> MarkdownString.t_0 or_string -> unit [@@js.set "description"]
      val get_whitespaceBefore: t -> bool [@@js.get "whitespaceBefore"]
      val set_whitespaceBefore: t -> bool -> unit [@@js.set "whitespaceBefore"]
      val get_whitespaceAfter: t -> bool [@@js.get "whitespaceAfter"]
      val set_whitespaceAfter: t -> bool -> unit [@@js.set "whitespaceAfter"]
      val create: text:string -> range:Range.t_0 -> ?kind:vscode_InlineHintKind -> unit -> t [@@js.create]
    end
    module[@js.scope "InlineHintsProvider"] InlineHintsProvider : sig
      type t = vscode_InlineHintsProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidChangeInlineHints: t -> unit Event.t_1 [@@js.get "onDidChangeInlineHints"]
      val set_onDidChangeInlineHints: t -> unit Event.t_1 -> unit [@@js.set "onDidChangeInlineHints"]
      val provideInlineHints: t -> model:vscode_TextDocument -> range:Range.t_0 -> token:CancellationToken.t_0 -> vscode_InlineHint list ProviderResult.t_1 [@@js.call "provideInlineHints"]
    end
    module ExtensionRuntime : sig
      type t = vscode_ExtensionRuntime
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "ExtensionContext"] ExtensionContext : sig
      type t = vscode_ExtensionContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_extensionRuntime: t -> vscode_ExtensionRuntime [@@js.get "extensionRuntime"]
    end
    module[@js.scope "TextDocument"] TextDocument : sig
      type t = vscode_TextDocument
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_notebook: t -> vscode_NotebookDocument or_undefined [@@js.get "notebook"]
      val set_notebook: t -> vscode_NotebookDocument or_undefined -> unit [@@js.set "notebook"]
    end
    module[@js.scope "test"] Test : sig
      val registerTestProvider: testProvider:'T vscode_TestProvider -> Disposable.t_0 [@@js.global "registerTestProvider"]
      val runTests: run:'T vscode_TestRunRequest -> ?token:CancellationToken.t_0 -> unit -> unit Thenable.t_1 [@@js.global "runTests"]
      val createWorkspaceTestObserver: workspaceFolder:WorkspaceFolder.t_0 -> vscode_TestObserver [@@js.global "createWorkspaceTestObserver"]
      val createDocumentTestObserver: document:vscode_TextDocument -> vscode_TestObserver [@@js.global "createDocumentTestObserver"]
      val publishTestResult: results:vscode_TestRunResult -> ?persist:bool -> unit -> unit [@@js.global "publishTestResult"]
      val testResults: vscode_TestRunResult list [@@js.global "testResults"]
      val onDidChangeTestResults: unit Event.t_1 [@@js.global "onDidChangeTestResults"]
    end
    module[@js.scope "TestObserver"] TestObserver : sig
      type t = vscode_TestObserver
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_tests: t -> any vscode_TestItem list [@@js.get "tests"]
      val get_onDidChangeTest: t -> vscode_TestsChangeEvent Event.t_1 [@@js.get "onDidChangeTest"]
      val get_onDidDiscoverInitialTests: t -> unit Event.t_1 [@@js.get "onDidDiscoverInitialTests"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "TestsChangeEvent"] TestsChangeEvent : sig
      type t = vscode_TestsChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_added: t -> any vscode_TestItem list [@@js.get "added"]
      val get_updated: t -> any vscode_TestItem list [@@js.get "updated"]
      val get_removed: t -> any vscode_TestItem list [@@js.get "removed"]
    end
    module[@js.scope "TestProvider"] TestProvider : sig
      type 'T t = 'T vscode_TestProvider
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = any vscode_TestItem t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideWorkspaceTestRoot: 'T t -> workspace:WorkspaceFolder.t_0 -> token:CancellationToken.t_0 -> 'T ProviderResult.t_1 [@@js.call "provideWorkspaceTestRoot"]
      val provideDocumentTestRoot: 'T t -> document:vscode_TextDocument -> token:CancellationToken.t_0 -> 'T ProviderResult.t_1 [@@js.call "provideDocumentTestRoot"]
      val runTests: 'T t -> options:'T vscode_TestRunOptions -> token:CancellationToken.t_0 -> unit ProviderResult.t_1 [@@js.call "runTests"]
    end
    module[@js.scope "TestRunRequest"] TestRunRequest : sig
      type 'T t = 'T vscode_TestRunRequest
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = any vscode_TestItem t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_tests: 'T t -> 'T list [@@js.get "tests"]
      val set_tests: 'T t -> 'T list -> unit [@@js.set "tests"]
      val get_exclude: 'T t -> 'T list [@@js.get "exclude"]
      val set_exclude: 'T t -> 'T list -> unit [@@js.set "exclude"]
      val get_debug: 'T t -> bool [@@js.get "debug"]
      val set_debug: 'T t -> bool -> unit [@@js.set "debug"]
    end
    module[@js.scope "TestRunOptions"] TestRunOptions : sig
      type 'T t = 'T vscode_TestRunOptions
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = any vscode_TestItem t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val setState: 'T t -> test:'T -> state:vscode_TestResultState -> ?duration:float -> unit -> unit [@@js.call "setState"]
      val appendMessage: 'T t -> test:'T -> message:vscode_TestMessage -> unit [@@js.call "appendMessage"]
      val appendOutput: 'T t -> output:string -> unit [@@js.call "appendOutput"]
      val cast: 'T t -> 'T vscode_TestRunRequest [@@js.cast]
    end
    module[@js.scope "TestChildrenCollection"] TestChildrenCollection : sig
      type 'T t = 'T vscode_TestChildrenCollection
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_size: 'T t -> float [@@js.get "size"]
      val get_: 'T t -> id:string -> 'T or_undefined [@@js.call "get"]
      val add: 'T t -> child:'T -> unit [@@js.call "add"]
      val delete: 'T t -> child:'T or_string -> unit [@@js.call "delete"]
      val clear: 'T t -> unit [@@js.call "clear"]
      val cast: 'T t -> 'T Iterable.t_1 [@@js.cast]
    end
    module[@js.scope "TestItem"] TestItem : sig
      type 'TChildren t = 'TChildren vscode_TestItem
      val t_to_js: ('TChildren -> Ojs.t) -> 'TChildren t -> Ojs.t
      val t_of_js: (Ojs.t -> 'TChildren) -> Ojs.t -> 'TChildren t
      type 'TChildren t_1 = 'TChildren t
      val t_1_to_js: ('TChildren -> Ojs.t) -> 'TChildren t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'TChildren) -> Ojs.t -> 'TChildren t_1
      type t_0 = any t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: 'TChildren t -> string [@@js.get "id"]
      val get_uri: 'TChildren t -> Uri.t_0 [@@js.get "uri"]
      val get_children: 'TChildren t -> 'TChildren vscode_TestChildrenCollection [@@js.get "children"]
      val get_label: 'TChildren t -> string [@@js.get "label"]
      val set_label: 'TChildren t -> string -> unit [@@js.set "label"]
      val get_description: 'TChildren t -> string [@@js.get "description"]
      val set_description: 'TChildren t -> string -> unit [@@js.set "description"]
      val get_range: 'TChildren t -> Range.t_0 [@@js.get "range"]
      val set_range: 'TChildren t -> Range.t_0 -> unit [@@js.set "range"]
      val get_runnable: 'TChildren t -> bool [@@js.get "runnable"]
      val set_runnable: 'TChildren t -> bool -> unit [@@js.set "runnable"]
      val get_debuggable: 'TChildren t -> bool [@@js.get "debuggable"]
      val set_debuggable: 'TChildren t -> bool -> unit [@@js.set "debuggable"]
      val get_expandable: 'TChildren t -> bool [@@js.get "expandable"]
      val set_expandable: 'TChildren t -> bool -> unit [@@js.set "expandable"]
      val create: id:string -> label:string -> uri:Uri.t_0 -> expandable:bool -> 'TChildren t [@@js.create]
      val invalidate: 'TChildren t -> unit [@@js.call "invalidate"]
      val discoverChildren: 'TChildren t -> progress:anonymous_interface_0 Progress.t_1 -> token:CancellationToken.t_0 -> unit [@@js.call "discoverChildren"]
    end
    module TestResultState : sig
      type t = vscode_TestResultState
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module TestMessageSeverity : sig
      type t = vscode_TestMessageSeverity
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "TestMessage"] TestMessage : sig
      type t = vscode_TestMessage
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_message: t -> MarkdownString.t_0 or_string [@@js.get "message"]
      val set_message: t -> MarkdownString.t_0 or_string -> unit [@@js.set "message"]
      val get_severity: t -> vscode_TestMessageSeverity [@@js.get "severity"]
      val set_severity: t -> vscode_TestMessageSeverity -> unit [@@js.set "severity"]
      val get_expectedOutput: t -> string [@@js.get "expectedOutput"]
      val set_expectedOutput: t -> string -> unit [@@js.set "expectedOutput"]
      val get_actualOutput: t -> string [@@js.get "actualOutput"]
      val set_actualOutput: t -> string -> unit [@@js.set "actualOutput"]
      val get_location: t -> Location.t_0 [@@js.get "location"]
      val set_location: t -> Location.t_0 -> unit [@@js.set "location"]
      val diff: message:MarkdownString.t_0 or_string -> expected:string -> actual:string -> t [@@js.global "diff"]
      val create: message:MarkdownString.t_0 or_string -> t [@@js.create]
    end
    module[@js.scope "TestRunResult"] TestRunResult : sig
      type t = vscode_TestRunResult
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_completedAt: t -> float [@@js.get "completedAt"]
      val set_completedAt: t -> float -> unit [@@js.set "completedAt"]
      val get_output: t -> string [@@js.get "output"]
      val set_output: t -> string -> unit [@@js.set "output"]
      val get_results: t -> vscode_TestResultSnapshot Readonly.t_1 list [@@js.get "results"]
      val set_results: t -> vscode_TestResultSnapshot Readonly.t_1 list -> unit [@@js.set "results"]
    end
    module[@js.scope "TestResultSnapshot"] TestResultSnapshot : sig
      type t = vscode_TestResultSnapshot
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val get_uri: t -> Uri.t_0 [@@js.get "uri"]
      val get_label: t -> string [@@js.get "label"]
      val get_description: t -> string [@@js.get "description"]
      val get_range: t -> Range.t_0 [@@js.get "range"]
      val get_state: t -> vscode_TestResultState [@@js.get "state"]
      val get_duration: t -> float [@@js.get "duration"]
      val get_messages: t -> vscode_TestMessage list [@@js.get "messages"]
      val get_children: t -> t Readonly.t_1 list [@@js.get "children"]
    end
    module ExternalUriOpenerPriority : sig
      type t = vscode_ExternalUriOpenerPriority
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "ExternalUriOpener"] ExternalUriOpener : sig
      type t = vscode_ExternalUriOpener
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val canOpenExternalUri: t -> uri:Uri.t_0 -> token:CancellationToken.t_0 -> ((vscode_ExternalUriOpenerPriority, vscode_ExternalUriOpenerPriority Thenable.t_1) union2, ([`Default[@js 2] | `None[@js 0] | `Option[@js 1] | `Preferred[@js 3]] [@js.enum])) or_enum [@@js.call "canOpenExternalUri"]
      val openExternalUri: t -> resolvedUri:Uri.t_0 -> ctx:vscode_OpenExternalUriContext -> token:CancellationToken.t_0 -> (unit, unit Thenable.t_1) union2 [@@js.call "openExternalUri"]
    end
    module[@js.scope "OpenExternalUriContext"] OpenExternalUriContext : sig
      type t = vscode_OpenExternalUriContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_sourceUri: t -> Uri.t_0 [@@js.get "sourceUri"]
    end
    module[@js.scope "ExternalUriOpenerMetadata"] ExternalUriOpenerMetadata : sig
      type t = vscode_ExternalUriOpenerMetadata
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_schemes: t -> string list [@@js.get "schemes"]
      val get_label: t -> string [@@js.get "label"]
    end
    module[@js.scope "OpenExternalOptions"] OpenExternalOptions : sig
      type t = vscode_OpenExternalOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_allowContributedOpeners: t -> bool or_string [@@js.get "allowContributedOpeners"]
    end
    module[@js.scope "env"] Env : sig
      val openExternal: target:Uri.t_0 -> ?options:vscode_OpenExternalOptions -> unit -> bool Thenable.t_1 [@@js.global "openExternal"]
    end
    module[@js.scope "OpenEditorInfo"] OpenEditorInfo : sig
      type t = vscode_OpenEditorInfo
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_resource: t -> Uri.t_0 [@@js.get "resource"]
      val set_resource: t -> Uri.t_0 -> unit [@@js.set "resource"]
    end
    module WorkspaceTrustState : sig
      type t = vscode_WorkspaceTrustState
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "WorkspaceTrustStateChangeEvent"] WorkspaceTrustStateChangeEvent : sig
      type t = vscode_WorkspaceTrustStateChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_newTrustState: t -> vscode_WorkspaceTrustState [@@js.get "newTrustState"]
    end
    module[@js.scope "WorkspaceTrustRequestOptions"] WorkspaceTrustRequestOptions : sig
      type t = vscode_WorkspaceTrustRequestOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_modal: t -> bool [@@js.get "modal"]
    end
    module[@js.scope "Webview"] Webview : sig
      type t = vscode_Webview
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val postMessage: t -> message:any -> bool Thenable.t_1 [@@js.call "postMessage"]
    end
    module PortAutoForwardAction : sig
      type t = vscode_PortAutoForwardAction
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "PortAttributes"] PortAttributes : sig
      type t = vscode_PortAttributes
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_port: t -> float [@@js.get "port"]
      val set_port: t -> float -> unit [@@js.set "port"]
      val get_autoForwardAction: t -> vscode_PortAutoForwardAction [@@js.get "autoForwardAction"]
      val set_autoForwardAction: t -> vscode_PortAutoForwardAction -> unit [@@js.set "autoForwardAction"]
    end
    module[@js.scope "PortAttributesProvider"] PortAttributesProvider : sig
      type t = vscode_PortAttributesProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val providePortAttributes: t -> port:float -> pid:float or_undefined -> commandLine:string or_undefined -> token:CancellationToken.t_0 -> vscode_PortAttributes ProviderResult.t_1 [@@js.call "providePortAttributes"]
    end
  end
end
