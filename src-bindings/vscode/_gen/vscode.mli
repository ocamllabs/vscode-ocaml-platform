[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Error
  - Readonly<T1>
  - Uint32Array
  - Uint8Array
 *)
[@@@js.stop]
module type Missing = sig
  module Error : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Readonly : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module Uint32Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Uint8Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module Error : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Readonly : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module Uint32Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Uint8Array : sig
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
      type anonymous_interface_18 = [`anonymous_interface_18] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_19 = [`anonymous_interface_19] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_20 = [`anonymous_interface_20] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_21 = [`anonymous_interface_21] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_22 = [`anonymous_interface_22] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_23 = [`anonymous_interface_23] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_24 = [`anonymous_interface_24] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_25 = [`anonymous_interface_25] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_26 = [`anonymous_interface_26] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_27 = [`anonymous_interface_27] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_28 = [`anonymous_interface_28] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_29 = [`anonymous_interface_29] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_30 = [`anonymous_interface_30] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_31 = [`anonymous_interface_31] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_32 = [`anonymous_interface_32] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_33 = [`anonymous_interface_33] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_34 = [`anonymous_interface_34] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_35 = [`anonymous_interface_35] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_36 = [`anonymous_interface_36] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_37 = [`anonymous_interface_37] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_38 = [`anonymous_interface_38] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_39 = [`anonymous_interface_39] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_40 = [`anonymous_interface_40] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_41 = [`anonymous_interface_41] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_42 = [`anonymous_interface_42] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_43 = [`anonymous_interface_43] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_44 = [`anonymous_interface_44] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_45 = [`anonymous_interface_45] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_46 = [`anonymous_interface_46] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
    module Types : sig
      open AnonymousInterfaces
      type 'T _Thenable = [`Thenable of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_AccessibilityInformation = [`Vscode_AccessibilityInformation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_AuthenticationGetSessionOptions = [`Vscode_AuthenticationGetSessionOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_AuthenticationProvider = [`Vscode_AuthenticationProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_AuthenticationProviderAuthenticationSessionsChangeEvent = [`Vscode_AuthenticationProviderAuthenticationSessionsChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_AuthenticationProviderInformation = [`Vscode_AuthenticationProviderInformation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_AuthenticationProviderOptions = [`Vscode_AuthenticationProviderOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_AuthenticationSession = [`Vscode_AuthenticationSession] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_AuthenticationSessionAccountInformation = [`Vscode_AuthenticationSessionAccountInformation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_AuthenticationSessionsChangeEvent = [`Vscode_AuthenticationSessionsChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_Breakpoint = [`Vscode_Breakpoint] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_BreakpointsChangeEvent = [`Vscode_BreakpointsChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CallHierarchyIncomingCall = [`Vscode_CallHierarchyIncomingCall] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CallHierarchyItem = [`Vscode_CallHierarchyItem] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CallHierarchyOutgoingCall = [`Vscode_CallHierarchyOutgoingCall] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CallHierarchyProvider = [`Vscode_CallHierarchyProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CancellationError = [`Vscode_CancellationError] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CancellationToken = [`Vscode_CancellationToken] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CancellationTokenSource = [`Vscode_CancellationTokenSource] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CharacterPair = (string * string)
      and vscode_Clipboard = [`Vscode_Clipboard] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CodeAction = [`Vscode_CodeAction] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CodeActionContext = [`Vscode_CodeActionContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CodeActionKind = [`Vscode_CodeActionKind] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_CodeActionProvider = [`Vscode_CodeActionProvider of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_CodeActionProviderMetadata = [`Vscode_CodeActionProviderMetadata] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CodeActionTriggerKind = [`Invoke[@js 1] | `Automatic[@js 2]] [@js.enum]
      and vscode_CodeActionTriggerKind_Invoke = [`Invoke[@js 1]] [@js.enum]
      and vscode_CodeActionTriggerKind_Automatic = [`Automatic[@js 2]] [@js.enum]
      and vscode_CodeLens = [`Vscode_CodeLens] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_CodeLensProvider = [`Vscode_CodeLensProvider of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_Color = [`Vscode_Color] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ColorInformation = [`Vscode_ColorInformation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ColorPresentation = [`Vscode_ColorPresentation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ColorTheme = [`Vscode_ColorTheme] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ColorThemeKind = [`Light[@js 1] | `Dark[@js 2] | `HighContrast[@js 3]] [@js.enum]
      and vscode_ColorThemeKind_Light = [`Light[@js 1]] [@js.enum]
      and vscode_ColorThemeKind_Dark = [`Dark[@js 2]] [@js.enum]
      and vscode_ColorThemeKind_HighContrast = [`HighContrast[@js 3]] [@js.enum]
      and vscode_Command = [`Vscode_Command] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_Comment = [`Vscode_Comment] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CommentAuthorInformation = [`Vscode_CommentAuthorInformation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CommentController = [`Vscode_CommentController] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CommentMode = [`Editing[@js 0] | `Preview[@js 1]] [@js.enum]
      and vscode_CommentMode_Editing = [`Editing[@js 0]] [@js.enum]
      and vscode_CommentMode_Preview = [`Preview[@js 1]] [@js.enum]
      and vscode_CommentOptions = [`Vscode_CommentOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CommentReaction = [`Vscode_CommentReaction] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CommentReply = [`Vscode_CommentReply] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CommentRule = [`Vscode_CommentRule] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CommentThread = [`Vscode_CommentThread] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CommentThreadCollapsibleState = [`Collapsed[@js 0] | `Expanded[@js 1]] [@js.enum]
      and vscode_CommentThreadCollapsibleState_Collapsed = [`Collapsed[@js 0]] [@js.enum]
      and vscode_CommentThreadCollapsibleState_Expanded = [`Expanded[@js 1]] [@js.enum]
      and vscode_CommentingRangeProvider = [`Vscode_CommentingRangeProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CompletionContext = [`Vscode_CompletionContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CompletionItem = [`Vscode_CompletionItem] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CompletionItemKind = [`Text[@js 0] | `Method[@js 1] | `Function[@js 2] | `Constructor[@js 3] | `Field[@js 4] | `Variable[@js 5] | `Class[@js 6] | `Interface[@js 7] | `Module[@js 8] | `Property[@js 9] | `Unit[@js 10] | `Value[@js 11] | `Enum[@js 12] | `Keyword[@js 13] | `Snippet[@js 14] | `Color[@js 15] | `Reference[@js 17] | `File[@js 16] | `Folder[@js 18] | `EnumMember[@js 19] | `Constant[@js 20] | `Struct[@js 21] | `Event[@js 22] | `Operator[@js 23] | `TypeParameter[@js 24] | `User[@js 25] | `Issue[@js 26]] [@js.enum]
      and vscode_CompletionItemKind_Text = [`Text[@js 0]] [@js.enum]
      and vscode_CompletionItemKind_Method = [`Method[@js 1]] [@js.enum]
      and vscode_CompletionItemKind_Function = [`Function[@js 2]] [@js.enum]
      and vscode_CompletionItemKind_Constructor = [`Constructor[@js 3]] [@js.enum]
      and vscode_CompletionItemKind_Field = [`Field[@js 4]] [@js.enum]
      and vscode_CompletionItemKind_Variable = [`Variable[@js 5]] [@js.enum]
      and vscode_CompletionItemKind_Class = [`Class[@js 6]] [@js.enum]
      and vscode_CompletionItemKind_Interface = [`Interface[@js 7]] [@js.enum]
      and vscode_CompletionItemKind_Module = [`Module[@js 8]] [@js.enum]
      and vscode_CompletionItemKind_Property = [`Property[@js 9]] [@js.enum]
      and vscode_CompletionItemKind_Unit = [`Unit[@js 10]] [@js.enum]
      and vscode_CompletionItemKind_Value = [`Value[@js 11]] [@js.enum]
      and vscode_CompletionItemKind_Enum = [`Enum[@js 12]] [@js.enum]
      and vscode_CompletionItemKind_Keyword = [`Keyword[@js 13]] [@js.enum]
      and vscode_CompletionItemKind_Snippet = [`Snippet[@js 14]] [@js.enum]
      and vscode_CompletionItemKind_Color = [`Color[@js 15]] [@js.enum]
      and vscode_CompletionItemKind_Reference = [`Reference[@js 17]] [@js.enum]
      and vscode_CompletionItemKind_File = [`File[@js 16]] [@js.enum]
      and vscode_CompletionItemKind_Folder = [`Folder[@js 18]] [@js.enum]
      and vscode_CompletionItemKind_EnumMember = [`EnumMember[@js 19]] [@js.enum]
      and vscode_CompletionItemKind_Constant = [`Constant[@js 20]] [@js.enum]
      and vscode_CompletionItemKind_Struct = [`Struct[@js 21]] [@js.enum]
      and vscode_CompletionItemKind_Event = [`Event[@js 22]] [@js.enum]
      and vscode_CompletionItemKind_Operator = [`Operator[@js 23]] [@js.enum]
      and vscode_CompletionItemKind_TypeParameter = [`TypeParameter[@js 24]] [@js.enum]
      and vscode_CompletionItemKind_User = [`User[@js 25]] [@js.enum]
      and vscode_CompletionItemKind_Issue = [`Issue[@js 26]] [@js.enum]
      and 'T vscode_CompletionItemProvider = [`Vscode_CompletionItemProvider of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_CompletionItemTag = [`Deprecated[@js 1]] [@js.enum]
      and vscode_CompletionItemTag_Deprecated = [`Deprecated[@js 1]] [@js.enum]
      and 'T vscode_CompletionList = [`Vscode_CompletionList of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_CompletionTriggerKind = [`Invoke[@js 0] | `TriggerCharacter[@js 1] | `TriggerForIncompleteCompletions[@js 2]] [@js.enum]
      and vscode_CompletionTriggerKind_Invoke = [`Invoke[@js 0]] [@js.enum]
      and vscode_CompletionTriggerKind_TriggerCharacter = [`TriggerCharacter[@js 1]] [@js.enum]
      and vscode_CompletionTriggerKind_TriggerForIncompleteCompletions = [`TriggerForIncompleteCompletions[@js 2]] [@js.enum]
      and vscode_ConfigurationChangeEvent = [`Vscode_ConfigurationChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ConfigurationScope = (vscode_TextDocument, vscode_Uri, vscode_WorkspaceFolder, anonymous_interface_35) union4
      and vscode_ConfigurationTarget = [`Global[@js 1] | `Workspace[@js 2] | `WorkspaceFolder[@js 3]] [@js.enum]
      and vscode_ConfigurationTarget_Global = [`Global[@js 1]] [@js.enum]
      and vscode_ConfigurationTarget_Workspace = [`Workspace[@js 2]] [@js.enum]
      and vscode_ConfigurationTarget_WorkspaceFolder = [`WorkspaceFolder[@js 3]] [@js.enum]
      and vscode_CustomDocument = [`Vscode_CustomDocument] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CustomDocumentBackup = [`Vscode_CustomDocumentBackup] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_CustomDocumentBackupContext = [`Vscode_CustomDocumentBackupContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_CustomDocumentContentChangeEvent = [`Vscode_CustomDocumentContentChangeEvent of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and 'T vscode_CustomDocumentEditEvent = [`Vscode_CustomDocumentEditEvent of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_CustomDocumentOpenContext = [`Vscode_CustomDocumentOpenContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_CustomEditorProvider = [`Vscode_CustomEditorProvider of 'T | `Vscode_CustomReadonlyEditorProvider of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_CustomExecution = [`Vscode_CustomExecution] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_CustomReadonlyEditorProvider = [`Vscode_CustomReadonlyEditorProvider of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_CustomTextEditorProvider = [`Vscode_CustomTextEditorProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugAdapter = [`Vscode_DebugAdapter | `Vscode_Disposable] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugAdapterDescriptor = (vscode_DebugAdapterExecutable, vscode_DebugAdapterInlineImplementation, vscode_DebugAdapterNamedPipeServer, vscode_DebugAdapterServer) union4
      and vscode_DebugAdapterDescriptorFactory = [`Vscode_DebugAdapterDescriptorFactory] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugAdapterExecutable = [`Vscode_DebugAdapterExecutable] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugAdapterExecutableOptions = [`Vscode_DebugAdapterExecutableOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugAdapterInlineImplementation = [`Vscode_DebugAdapterInlineImplementation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugAdapterNamedPipeServer = [`Vscode_DebugAdapterNamedPipeServer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugAdapterServer = [`Vscode_DebugAdapterServer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugAdapterTracker = [`Vscode_DebugAdapterTracker] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugAdapterTrackerFactory = [`Vscode_DebugAdapterTrackerFactory] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugConfiguration = [`Vscode_DebugConfiguration] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugConfigurationProvider = [`Vscode_DebugConfigurationProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugConfigurationProviderTriggerKind = [`Initial[@js 1] | `Dynamic[@js 2]] [@js.enum]
      and vscode_DebugConfigurationProviderTriggerKind_Initial = [`Initial[@js 1]] [@js.enum]
      and vscode_DebugConfigurationProviderTriggerKind_Dynamic = [`Dynamic[@js 2]] [@js.enum]
      and vscode_DebugConsole = [`Vscode_DebugConsole] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugConsoleMode = [`Separate[@js 0] | `MergeWithParent[@js 1]] [@js.enum]
      and vscode_DebugConsoleMode_Separate = [`Separate[@js 0]] [@js.enum]
      and vscode_DebugConsoleMode_MergeWithParent = [`MergeWithParent[@js 1]] [@js.enum]
      and vscode_DebugProtocolBreakpoint = [`Vscode_DebugProtocolBreakpoint] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugProtocolMessage = [`Vscode_DebugProtocolMessage] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugProtocolSource = [`Vscode_DebugProtocolSource] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugSession = [`Vscode_DebugSession] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugSessionCustomEvent = [`Vscode_DebugSessionCustomEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DebugSessionOptions = [`Vscode_DebugSessionOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_Declaration = (vscode_Location, (vscode_Location, vscode_LocationLink) union2) or_array
      and vscode_DeclarationProvider = [`Vscode_DeclarationProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DecorationInstanceRenderOptions = [`Vscode_DecorationInstanceRenderOptions | `Vscode_ThemableDecorationInstanceRenderOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DecorationOptions = [`Vscode_DecorationOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DecorationRangeBehavior = [`OpenOpen[@js 0] | `ClosedClosed[@js 1] | `OpenClosed[@js 2] | `ClosedOpen[@js 3]] [@js.enum]
      and vscode_DecorationRangeBehavior_OpenOpen = [`OpenOpen[@js 0]] [@js.enum]
      and vscode_DecorationRangeBehavior_ClosedClosed = [`ClosedClosed[@js 1]] [@js.enum]
      and vscode_DecorationRangeBehavior_OpenClosed = [`OpenClosed[@js 2]] [@js.enum]
      and vscode_DecorationRangeBehavior_ClosedOpen = [`ClosedOpen[@js 3]] [@js.enum]
      and vscode_DecorationRenderOptions = [`Vscode_DecorationRenderOptions | `Vscode_ThemableDecorationRenderOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_Definition = (vscode_Location, vscode_Location) or_array
      and vscode_DefinitionLink = vscode_LocationLink
      and vscode_DefinitionProvider = [`Vscode_DefinitionProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_Diagnostic = [`Vscode_Diagnostic] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DiagnosticChangeEvent = [`Vscode_DiagnosticChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DiagnosticCollection = [`Vscode_DiagnosticCollection] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DiagnosticRelatedInformation = [`Vscode_DiagnosticRelatedInformation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DiagnosticSeverity = [`Error[@js 0] | `Warning[@js 1] | `Information[@js 2] | `Hint[@js 3]] [@js.enum]
      and vscode_DiagnosticSeverity_Error = [`Error[@js 0]] [@js.enum]
      and vscode_DiagnosticSeverity_Warning = [`Warning[@js 1]] [@js.enum]
      and vscode_DiagnosticSeverity_Information = [`Information[@js 2]] [@js.enum]
      and vscode_DiagnosticSeverity_Hint = [`Hint[@js 3]] [@js.enum]
      and vscode_DiagnosticTag = [`Unnecessary[@js 1] | `Deprecated[@js 2]] [@js.enum]
      and vscode_DiagnosticTag_Unnecessary = [`Unnecessary[@js 1]] [@js.enum]
      and vscode_DiagnosticTag_Deprecated = [`Deprecated[@js 2]] [@js.enum]
      and vscode_Disposable = [`Vscode_Disposable] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DocumentColorProvider = [`Vscode_DocumentColorProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DocumentFilter = [`Vscode_DocumentFilter] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DocumentFormattingEditProvider = [`Vscode_DocumentFormattingEditProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DocumentHighlight = [`Vscode_DocumentHighlight] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DocumentHighlightKind = [`Text[@js 0] | `Read[@js 1] | `Write[@js 2]] [@js.enum]
      and vscode_DocumentHighlightKind_Text = [`Text[@js 0]] [@js.enum]
      and vscode_DocumentHighlightKind_Read = [`Read[@js 1]] [@js.enum]
      and vscode_DocumentHighlightKind_Write = [`Write[@js 2]] [@js.enum]
      and vscode_DocumentHighlightProvider = [`Vscode_DocumentHighlightProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DocumentLink = [`Vscode_DocumentLink] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_DocumentLinkProvider = [`Vscode_DocumentLinkProvider of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_DocumentRangeFormattingEditProvider = [`Vscode_DocumentRangeFormattingEditProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DocumentRangeSemanticTokensProvider = [`Vscode_DocumentRangeSemanticTokensProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DocumentSelector = (vscode_DocumentFilter, vscode_DocumentFilter or_string list) union2 or_string
      and vscode_DocumentSemanticTokensProvider = [`Vscode_DocumentSemanticTokensProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DocumentSymbol = [`Vscode_DocumentSymbol] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DocumentSymbolProvider = [`Vscode_DocumentSymbolProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_DocumentSymbolProviderMetadata = [`Vscode_DocumentSymbolProviderMetadata] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_EndOfLine = [`LF[@js 1] | `CRLF[@js 2]] [@js.enum]
      and vscode_EndOfLine_LF = [`LF[@js 1]] [@js.enum]
      and vscode_EndOfLine_CRLF = [`CRLF[@js 2]] [@js.enum]
      and vscode_EnterAction = [`Vscode_EnterAction] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_EnvironmentVariableCollection = [`Vscode_EnvironmentVariableCollection] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_EnvironmentVariableMutator = [`Vscode_EnvironmentVariableMutator] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_EnvironmentVariableMutatorType = [`Replace[@js 1] | `Append[@js 2] | `Prepend[@js 3]] [@js.enum]
      and vscode_EnvironmentVariableMutatorType_Replace = [`Replace[@js 1]] [@js.enum]
      and vscode_EnvironmentVariableMutatorType_Append = [`Append[@js 2]] [@js.enum]
      and vscode_EnvironmentVariableMutatorType_Prepend = [`Prepend[@js 3]] [@js.enum]
      and vscode_EvaluatableExpression = [`Vscode_EvaluatableExpression] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_EvaluatableExpressionProvider = [`Vscode_EvaluatableExpressionProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_Event = [`Vscode_Event of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and 'T vscode_EventEmitter = [`Vscode_EventEmitter of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and 'T vscode_Extension = [`Vscode_Extension of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_ExtensionContext = [`Vscode_ExtensionContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ExtensionKind = [`UI[@js 1] | `Workspace[@js 2]] [@js.enum]
      and vscode_ExtensionKind_UI = [`UI[@js 1]] [@js.enum]
      and vscode_ExtensionKind_Workspace = [`Workspace[@js 2]] [@js.enum]
      and vscode_ExtensionMode = [`Production[@js 1] | `Development[@js 2] | `Test[@js 3]] [@js.enum]
      and vscode_ExtensionMode_Production = [`Production[@js 1]] [@js.enum]
      and vscode_ExtensionMode_Development = [`Development[@js 2]] [@js.enum]
      and vscode_ExtensionMode_Test = [`Test[@js 3]] [@js.enum]
      and vscode_ExtensionTerminalOptions = [`Vscode_ExtensionTerminalOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileChangeEvent = [`Vscode_FileChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileChangeType = [`Changed[@js 1] | `Created[@js 2] | `Deleted[@js 3]] [@js.enum]
      and vscode_FileChangeType_Changed = [`Changed[@js 1]] [@js.enum]
      and vscode_FileChangeType_Created = [`Created[@js 2]] [@js.enum]
      and vscode_FileChangeType_Deleted = [`Deleted[@js 3]] [@js.enum]
      and vscode_FileCreateEvent = [`Vscode_FileCreateEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileDecoration = [`Vscode_FileDecoration] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileDecorationProvider = [`Vscode_FileDecorationProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileDeleteEvent = [`Vscode_FileDeleteEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileRenameEvent = [`Vscode_FileRenameEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileStat = [`Vscode_FileStat] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileSystem = [`Vscode_FileSystem] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileSystemError = [`Vscode_FileSystemError] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileSystemProvider = [`Vscode_FileSystemProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileSystemWatcher = [`Vscode_FileSystemWatcher | `Vscode_Disposable] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileType = [`Unknown[@js 0] | `File[@js 1] | `Directory[@js 2] | `SymbolicLink[@js 64]] [@js.enum]
      and vscode_FileType_Unknown = [`Unknown[@js 0]] [@js.enum]
      and vscode_FileType_File = [`File[@js 1]] [@js.enum]
      and vscode_FileType_Directory = [`Directory[@js 2]] [@js.enum]
      and vscode_FileType_SymbolicLink = [`SymbolicLink[@js 64]] [@js.enum]
      and vscode_FileWillCreateEvent = [`Vscode_FileWillCreateEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileWillDeleteEvent = [`Vscode_FileWillDeleteEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FileWillRenameEvent = [`Vscode_FileWillRenameEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FoldingContext = [`Vscode_FoldingContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FoldingRange = [`Vscode_FoldingRange] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FoldingRangeKind = [`Comment[@js 1] | `Imports[@js 2] | `Region[@js 3]] [@js.enum]
      and vscode_FoldingRangeKind_Comment = [`Comment[@js 1]] [@js.enum]
      and vscode_FoldingRangeKind_Imports = [`Imports[@js 2]] [@js.enum]
      and vscode_FoldingRangeKind_Region = [`Region[@js 3]] [@js.enum]
      and vscode_FoldingRangeProvider = [`Vscode_FoldingRangeProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FormattingOptions = [`Vscode_FormattingOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_FunctionBreakpoint = [`Vscode_FunctionBreakpoint | `Vscode_Breakpoint] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_GlobPattern = vscode_RelativePattern or_string
      and vscode_Hover = [`Vscode_Hover] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_HoverProvider = [`Vscode_HoverProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ImplementationProvider = [`Vscode_ImplementationProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_IndentAction = [`None[@js 0] | `Indent[@js 1] | `IndentOutdent[@js 2] | `Outdent[@js 3]] [@js.enum]
      and vscode_IndentAction_None = [`None[@js 0]] [@js.enum]
      and vscode_IndentAction_Indent = [`Indent[@js 1]] [@js.enum]
      and vscode_IndentAction_IndentOutdent = [`IndentOutdent[@js 2]] [@js.enum]
      and vscode_IndentAction_Outdent = [`Outdent[@js 3]] [@js.enum]
      and vscode_IndentationRule = [`Vscode_IndentationRule] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_InlineValue = (vscode_InlineValueEvaluatableExpression, vscode_InlineValueText, vscode_InlineValueVariableLookup) union3
      and vscode_InlineValueContext = [`Vscode_InlineValueContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_InlineValueEvaluatableExpression = [`Vscode_InlineValueEvaluatableExpression] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_InlineValueText = [`Vscode_InlineValueText] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_InlineValueVariableLookup = [`Vscode_InlineValueVariableLookup] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_InlineValuesProvider = [`Vscode_InlineValuesProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_InputBox = [`Vscode_InputBox | `Vscode_QuickInput] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_InputBoxOptions = [`Vscode_InputBoxOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_LanguageConfiguration = [`Vscode_LanguageConfiguration] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_LinkedEditingRangeProvider = [`Vscode_LinkedEditingRangeProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_LinkedEditingRanges = [`Vscode_LinkedEditingRanges] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_Location = [`Vscode_Location] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_LocationLink = [`Vscode_LocationLink] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_MarkdownString = [`Vscode_MarkdownString] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_MarkedString = (vscode_MarkdownString, anonymous_interface_13) union2 or_string
      and vscode_Memento = [`Vscode_Memento] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_MessageItem = [`Vscode_MessageItem] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_MessageOptions = [`Vscode_MessageOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_OnEnterRule = [`Vscode_OnEnterRule] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_OnTypeFormattingEditProvider = [`Vscode_OnTypeFormattingEditProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_OpenDialogOptions = [`Vscode_OpenDialogOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_OutputChannel = [`Vscode_OutputChannel] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_OverviewRulerLane = [`Left[@js 1] | `Center[@js 2] | `Right[@js 4] | `Full[@js 7]] [@js.enum]
      and vscode_OverviewRulerLane_Left = [`Left[@js 1]] [@js.enum]
      and vscode_OverviewRulerLane_Center = [`Center[@js 2]] [@js.enum]
      and vscode_OverviewRulerLane_Right = [`Right[@js 4]] [@js.enum]
      and vscode_OverviewRulerLane_Full = [`Full[@js 7]] [@js.enum]
      and vscode_ParameterInformation = [`Vscode_ParameterInformation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_Position = [`Vscode_Position] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ProcessExecution = [`Vscode_ProcessExecution] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ProcessExecutionOptions = [`Vscode_ProcessExecutionOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_Progress = [`Vscode_Progress of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_ProgressLocation = [`SourceControl[@js 1] | `Window[@js 10] | `Notification[@js 15]] [@js.enum]
      and vscode_ProgressLocation_SourceControl = [`SourceControl[@js 1]] [@js.enum]
      and vscode_ProgressLocation_Window = [`Window[@js 10]] [@js.enum]
      and vscode_ProgressLocation_Notification = [`Notification[@js 15]] [@js.enum]
      and vscode_ProgressOptions = [`Vscode_ProgressOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_ProviderResult = ('T, 'T or_null_or_undefined _Thenable) union2 or_null_or_undefined
      and vscode_Pseudoterminal = [`Vscode_Pseudoterminal] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_QuickDiffProvider = [`Vscode_QuickDiffProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_QuickInput = [`Vscode_QuickInput] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_QuickInputButton = [`Vscode_QuickInputButton] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_QuickInputButtons = [`Vscode_QuickInputButtons] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_QuickPick = [`Vscode_QuickPick of 'T | `Vscode_QuickInput] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_QuickPickItem = [`Vscode_QuickPickItem] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_QuickPickOptions = [`Vscode_QuickPickOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_Range = [`Vscode_Range] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ReferenceContext = [`Vscode_ReferenceContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ReferenceProvider = [`Vscode_ReferenceProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_RelativePattern = [`Vscode_RelativePattern] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_RenameProvider = [`Vscode_RenameProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_RunOptions = [`Vscode_RunOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SaveDialogOptions = [`Vscode_SaveDialogOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SecretStorage = [`Vscode_SecretStorage] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SecretStorageChangeEvent = [`Vscode_SecretStorageChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_Selection = [`Vscode_Selection | `Vscode_Range] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SelectionRange = [`Vscode_SelectionRange] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SelectionRangeProvider = [`Vscode_SelectionRangeProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SemanticTokens = [`Vscode_SemanticTokens] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SemanticTokensBuilder = [`Vscode_SemanticTokensBuilder] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SemanticTokensEdit = [`Vscode_SemanticTokensEdit] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SemanticTokensEdits = [`Vscode_SemanticTokensEdits] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SemanticTokensLegend = [`Vscode_SemanticTokensLegend] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ShellExecution = [`Vscode_ShellExecution] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ShellExecutionOptions = [`Vscode_ShellExecutionOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ShellQuotedString = [`Vscode_ShellQuotedString] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ShellQuoting = [`Escape[@js 1] | `Strong[@js 2] | `Weak[@js 3]] [@js.enum]
      and vscode_ShellQuoting_Escape = [`Escape[@js 1]] [@js.enum]
      and vscode_ShellQuoting_Strong = [`Strong[@js 2]] [@js.enum]
      and vscode_ShellQuoting_Weak = [`Weak[@js 3]] [@js.enum]
      and vscode_ShellQuotingOptions = [`Vscode_ShellQuotingOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SignatureHelp = [`Vscode_SignatureHelp] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SignatureHelpContext = [`Vscode_SignatureHelpContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SignatureHelpProvider = [`Vscode_SignatureHelpProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SignatureHelpProviderMetadata = [`Vscode_SignatureHelpProviderMetadata] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SignatureHelpTriggerKind = [`Invoke[@js 1] | `TriggerCharacter[@js 2] | `ContentChange[@js 3]] [@js.enum]
      and vscode_SignatureHelpTriggerKind_Invoke = [`Invoke[@js 1]] [@js.enum]
      and vscode_SignatureHelpTriggerKind_TriggerCharacter = [`TriggerCharacter[@js 2]] [@js.enum]
      and vscode_SignatureHelpTriggerKind_ContentChange = [`ContentChange[@js 3]] [@js.enum]
      and vscode_SignatureInformation = [`Vscode_SignatureInformation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SnippetString = [`Vscode_SnippetString] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SourceBreakpoint = [`Vscode_SourceBreakpoint | `Vscode_Breakpoint] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SourceControl = [`Vscode_SourceControl] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SourceControlInputBox = [`Vscode_SourceControlInputBox] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SourceControlResourceDecorations = [`Vscode_SourceControlResourceDecorations | `Vscode_SourceControlResourceThemableDecorations] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SourceControlResourceGroup = [`Vscode_SourceControlResourceGroup] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SourceControlResourceState = [`Vscode_SourceControlResourceState] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SourceControlResourceThemableDecorations = [`Vscode_SourceControlResourceThemableDecorations] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_StatusBarAlignment = [`Left[@js 1] | `Right[@js 2]] [@js.enum]
      and vscode_StatusBarAlignment_Left = [`Left[@js 1]] [@js.enum]
      and vscode_StatusBarAlignment_Right = [`Right[@js 2]] [@js.enum]
      and vscode_StatusBarItem = [`Vscode_StatusBarItem] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SymbolInformation = [`Vscode_SymbolInformation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_SymbolKind = [`File[@js 0] | `Module[@js 1] | `Namespace[@js 2] | `Package[@js 3] | `Class[@js 4] | `Method[@js 5] | `Property[@js 6] | `Field[@js 7] | `Constructor[@js 8] | `Enum[@js 9] | `Interface[@js 10] | `Function[@js 11] | `Variable[@js 12] | `Constant[@js 13] | `String[@js 14] | `Number[@js 15] | `Boolean[@js 16] | `Array[@js 17] | `Object[@js 18] | `Key[@js 19] | `Null[@js 20] | `EnumMember[@js 21] | `Struct[@js 22] | `Event[@js 23] | `Operator[@js 24] | `TypeParameter[@js 25]] [@js.enum]
      and vscode_SymbolKind_File = [`File[@js 0]] [@js.enum]
      and vscode_SymbolKind_Module = [`Module[@js 1]] [@js.enum]
      and vscode_SymbolKind_Namespace = [`Namespace[@js 2]] [@js.enum]
      and vscode_SymbolKind_Package = [`Package[@js 3]] [@js.enum]
      and vscode_SymbolKind_Class = [`Class[@js 4]] [@js.enum]
      and vscode_SymbolKind_Method = [`Method[@js 5]] [@js.enum]
      and vscode_SymbolKind_Property = [`Property[@js 6]] [@js.enum]
      and vscode_SymbolKind_Field = [`Field[@js 7]] [@js.enum]
      and vscode_SymbolKind_Constructor = [`Constructor[@js 8]] [@js.enum]
      and vscode_SymbolKind_Enum = [`Enum[@js 9]] [@js.enum]
      and vscode_SymbolKind_Interface = [`Interface[@js 10]] [@js.enum]
      and vscode_SymbolKind_Function = [`Function[@js 11]] [@js.enum]
      and vscode_SymbolKind_Variable = [`Variable[@js 12]] [@js.enum]
      and vscode_SymbolKind_Constant = [`Constant[@js 13]] [@js.enum]
      and vscode_SymbolKind_String = [`String[@js 14]] [@js.enum]
      and vscode_SymbolKind_Number = [`Number[@js 15]] [@js.enum]
      and vscode_SymbolKind_Boolean = [`Boolean[@js 16]] [@js.enum]
      and vscode_SymbolKind_Array = [`Array[@js 17]] [@js.enum]
      and vscode_SymbolKind_Object = [`Object[@js 18]] [@js.enum]
      and vscode_SymbolKind_Key = [`Key[@js 19]] [@js.enum]
      and vscode_SymbolKind_Null = [`Null[@js 20]] [@js.enum]
      and vscode_SymbolKind_EnumMember = [`EnumMember[@js 21]] [@js.enum]
      and vscode_SymbolKind_Struct = [`Struct[@js 22]] [@js.enum]
      and vscode_SymbolKind_Event = [`Event[@js 23]] [@js.enum]
      and vscode_SymbolKind_Operator = [`Operator[@js 24]] [@js.enum]
      and vscode_SymbolKind_TypeParameter = [`TypeParameter[@js 25]] [@js.enum]
      and vscode_SymbolTag = [`Deprecated[@js 1]] [@js.enum]
      and vscode_SymbolTag_Deprecated = [`Deprecated[@js 1]] [@js.enum]
      and vscode_Task = [`Vscode_Task] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TaskDefinition = [`Vscode_TaskDefinition] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TaskEndEvent = [`Vscode_TaskEndEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TaskExecution = [`Vscode_TaskExecution] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TaskFilter = [`Vscode_TaskFilter] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TaskGroup = [`Vscode_TaskGroup] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TaskPanelKind = [`Shared[@js 1] | `Dedicated[@js 2] | `New[@js 3]] [@js.enum]
      and vscode_TaskPanelKind_Shared = [`Shared[@js 1]] [@js.enum]
      and vscode_TaskPanelKind_Dedicated = [`Dedicated[@js 2]] [@js.enum]
      and vscode_TaskPanelKind_New = [`New[@js 3]] [@js.enum]
      and vscode_TaskPresentationOptions = [`Vscode_TaskPresentationOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TaskProcessEndEvent = [`Vscode_TaskProcessEndEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TaskProcessStartEvent = [`Vscode_TaskProcessStartEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_TaskProvider = [`Vscode_TaskProvider of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_TaskRevealKind = [`Always[@js 1] | `Silent[@js 2] | `Never[@js 3]] [@js.enum]
      and vscode_TaskRevealKind_Always = [`Always[@js 1]] [@js.enum]
      and vscode_TaskRevealKind_Silent = [`Silent[@js 2]] [@js.enum]
      and vscode_TaskRevealKind_Never = [`Never[@js 3]] [@js.enum]
      and vscode_TaskScope = [`Global[@js 1] | `Workspace[@js 2]] [@js.enum]
      and vscode_TaskScope_Global = [`Global[@js 1]] [@js.enum]
      and vscode_TaskScope_Workspace = [`Workspace[@js 2]] [@js.enum]
      and vscode_TaskStartEvent = [`Vscode_TaskStartEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_Terminal = [`Vscode_Terminal] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TerminalDimensions = [`Vscode_TerminalDimensions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TerminalExitStatus = [`Vscode_TerminalExitStatus] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TerminalLink = [`Vscode_TerminalLink] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TerminalLinkContext = [`Vscode_TerminalLinkContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_TerminalLinkProvider = [`Vscode_TerminalLinkProvider of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_TerminalOptions = [`Vscode_TerminalOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextDocument = [`Vscode_TextDocument] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextDocumentChangeEvent = [`Vscode_TextDocumentChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextDocumentContentChangeEvent = [`Vscode_TextDocumentContentChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextDocumentContentProvider = [`Vscode_TextDocumentContentProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextDocumentSaveReason = [`Manual[@js 1] | `AfterDelay[@js 2] | `FocusOut[@js 3]] [@js.enum]
      and vscode_TextDocumentSaveReason_Manual = [`Manual[@js 1]] [@js.enum]
      and vscode_TextDocumentSaveReason_AfterDelay = [`AfterDelay[@js 2]] [@js.enum]
      and vscode_TextDocumentSaveReason_FocusOut = [`FocusOut[@js 3]] [@js.enum]
      and vscode_TextDocumentShowOptions = [`Vscode_TextDocumentShowOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextDocumentWillSaveEvent = [`Vscode_TextDocumentWillSaveEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextEdit = [`Vscode_TextEdit] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextEditor = [`Vscode_TextEditor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextEditorCursorStyle = [`Line[@js 1] | `Block[@js 2] | `Underline[@js 3] | `LineThin[@js 4] | `BlockOutline[@js 5] | `UnderlineThin[@js 6]] [@js.enum]
      and vscode_TextEditorCursorStyle_Line = [`Line[@js 1]] [@js.enum]
      and vscode_TextEditorCursorStyle_Block = [`Block[@js 2]] [@js.enum]
      and vscode_TextEditorCursorStyle_Underline = [`Underline[@js 3]] [@js.enum]
      and vscode_TextEditorCursorStyle_LineThin = [`LineThin[@js 4]] [@js.enum]
      and vscode_TextEditorCursorStyle_BlockOutline = [`BlockOutline[@js 5]] [@js.enum]
      and vscode_TextEditorCursorStyle_UnderlineThin = [`UnderlineThin[@js 6]] [@js.enum]
      and vscode_TextEditorDecorationType = [`Vscode_TextEditorDecorationType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextEditorEdit = [`Vscode_TextEditorEdit] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextEditorLineNumbersStyle = [`Off[@js 0] | `On[@js 1] | `Relative[@js 2]] [@js.enum]
      and vscode_TextEditorLineNumbersStyle_Off = [`Off[@js 0]] [@js.enum]
      and vscode_TextEditorLineNumbersStyle_On = [`On[@js 1]] [@js.enum]
      and vscode_TextEditorLineNumbersStyle_Relative = [`Relative[@js 2]] [@js.enum]
      and vscode_TextEditorOptions = [`Vscode_TextEditorOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextEditorOptionsChangeEvent = [`Vscode_TextEditorOptionsChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextEditorRevealType = [`Default[@js 0] | `InCenter[@js 1] | `InCenterIfOutsideViewport[@js 2] | `AtTop[@js 3]] [@js.enum]
      and vscode_TextEditorRevealType_Default = [`Default[@js 0]] [@js.enum]
      and vscode_TextEditorRevealType_InCenter = [`InCenter[@js 1]] [@js.enum]
      and vscode_TextEditorRevealType_InCenterIfOutsideViewport = [`InCenterIfOutsideViewport[@js 2]] [@js.enum]
      and vscode_TextEditorRevealType_AtTop = [`AtTop[@js 3]] [@js.enum]
      and vscode_TextEditorSelectionChangeEvent = [`Vscode_TextEditorSelectionChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextEditorSelectionChangeKind = [`Keyboard[@js 1] | `Mouse[@js 2] | `Command[@js 3]] [@js.enum]
      and vscode_TextEditorSelectionChangeKind_Keyboard = [`Keyboard[@js 1]] [@js.enum]
      and vscode_TextEditorSelectionChangeKind_Mouse = [`Mouse[@js 2]] [@js.enum]
      and vscode_TextEditorSelectionChangeKind_Command = [`Command[@js 3]] [@js.enum]
      and vscode_TextEditorViewColumnChangeEvent = [`Vscode_TextEditorViewColumnChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextEditorVisibleRangesChangeEvent = [`Vscode_TextEditorVisibleRangesChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TextLine = [`Vscode_TextLine] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ThemableDecorationAttachmentRenderOptions = [`Vscode_ThemableDecorationAttachmentRenderOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ThemableDecorationInstanceRenderOptions = [`Vscode_ThemableDecorationInstanceRenderOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ThemableDecorationRenderOptions = [`Vscode_ThemableDecorationRenderOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ThemeColor = [`Vscode_ThemeColor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ThemeIcon = [`Vscode_ThemeIcon] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_TreeDataProvider = [`Vscode_TreeDataProvider of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_TreeItem = [`Vscode_TreeItem] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TreeItemCollapsibleState = [`None[@js 0] | `Collapsed[@js 1] | `Expanded[@js 2]] [@js.enum]
      and vscode_TreeItemCollapsibleState_None = [`None[@js 0]] [@js.enum]
      and vscode_TreeItemCollapsibleState_Collapsed = [`Collapsed[@js 1]] [@js.enum]
      and vscode_TreeItemCollapsibleState_Expanded = [`Expanded[@js 2]] [@js.enum]
      and vscode_TreeItemLabel = [`Vscode_TreeItemLabel] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_TreeView = [`Vscode_TreeView of 'T | `Vscode_Disposable] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and 'T vscode_TreeViewExpansionEvent = [`Vscode_TreeViewExpansionEvent of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and 'T vscode_TreeViewOptions = [`Vscode_TreeViewOptions of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and 'T vscode_TreeViewSelectionChangeEvent = [`Vscode_TreeViewSelectionChangeEvent of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_TreeViewVisibilityChangeEvent = [`Vscode_TreeViewVisibilityChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_TypeDefinitionProvider = [`Vscode_TypeDefinitionProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_UIKind = [`Desktop[@js 1] | `Web[@js 2]] [@js.enum]
      and vscode_UIKind_Desktop = [`Desktop[@js 1]] [@js.enum]
      and vscode_UIKind_Web = [`Web[@js 2]] [@js.enum]
      and vscode_Uri = [`Vscode_Uri] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_UriHandler = [`Vscode_UriHandler] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_ViewColumn = [`Active[@js -1] | `Beside[@js -2] | `One[@js 1] | `Two[@js 2] | `Three[@js 3] | `Four[@js 4] | `Five[@js 5] | `Six[@js 6] | `Seven[@js 7] | `Eight[@js 8] | `Nine[@js 9]] [@js.enum]
      and vscode_ViewColumn_Active = [`Active[@js -1]] [@js.enum]
      and vscode_ViewColumn_Beside = [`Beside[@js -2]] [@js.enum]
      and vscode_ViewColumn_One = [`One[@js 1]] [@js.enum]
      and vscode_ViewColumn_Two = [`Two[@js 2]] [@js.enum]
      and vscode_ViewColumn_Three = [`Three[@js 3]] [@js.enum]
      and vscode_ViewColumn_Four = [`Four[@js 4]] [@js.enum]
      and vscode_ViewColumn_Five = [`Five[@js 5]] [@js.enum]
      and vscode_ViewColumn_Six = [`Six[@js 6]] [@js.enum]
      and vscode_ViewColumn_Seven = [`Seven[@js 7]] [@js.enum]
      and vscode_ViewColumn_Eight = [`Eight[@js 8]] [@js.enum]
      and vscode_ViewColumn_Nine = [`Nine[@js 9]] [@js.enum]
      and vscode_Webview = [`Vscode_Webview] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WebviewOptions = [`Vscode_WebviewOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WebviewPanel = [`Vscode_WebviewPanel] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WebviewPanelOnDidChangeViewStateEvent = [`Vscode_WebviewPanelOnDidChangeViewStateEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WebviewPanelOptions = [`Vscode_WebviewPanelOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_WebviewPanelSerializer = [`Vscode_WebviewPanelSerializer of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_WebviewPortMapping = [`Vscode_WebviewPortMapping] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WebviewView = [`Vscode_WebviewView] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WebviewViewProvider = [`Vscode_WebviewViewProvider] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_WebviewViewResolveContext = [`Vscode_WebviewViewResolveContext of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and vscode_WindowState = [`Vscode_WindowState] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WorkspaceConfiguration = [`Vscode_WorkspaceConfiguration] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WorkspaceEdit = [`Vscode_WorkspaceEdit] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WorkspaceEditEntryMetadata = [`Vscode_WorkspaceEditEntryMetadata] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WorkspaceFolder = [`Vscode_WorkspaceFolder] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WorkspaceFolderPickOptions = [`Vscode_WorkspaceFolderPickOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vscode_WorkspaceFoldersChangeEvent = [`Vscode_WorkspaceFoldersChangeEvent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T vscode_WorkspaceSymbolProvider = [`Vscode_WorkspaceSymbolProvider of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
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
    val get_autoClosingPairs: t -> anonymous_interface_20 list [@@js.get "autoClosingPairs"]
    val set_autoClosingPairs: t -> anonymous_interface_20 list -> unit [@@js.set "autoClosingPairs"]
  end
  module AnonymousInterface1 : sig
    type t = anonymous_interface_1
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_brackets: t -> any [@@js.get "brackets"]
    val set_brackets: t -> any -> unit [@@js.set "brackets"]
    val get_docComment: t -> anonymous_interface_31 [@@js.get "docComment"]
    val set_docComment: t -> anonymous_interface_31 -> unit [@@js.set "docComment"]
  end
  module AnonymousInterface2 : sig
    type t = anonymous_interface_2
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_canPickMany: t -> ([`L_b_true[@js true]] [@js.enum]) [@@js.get "canPickMany"]
    val set_canPickMany: t -> ([`L_b_true] [@js.enum]) -> unit [@@js.set "canPickMany"]
  end
  module AnonymousInterface3 : sig
    type t = anonymous_interface_3
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_create: t -> bool [@@js.get "create"]
    val set_create: t -> bool -> unit [@@js.set "create"]
    val get_overwrite: t -> bool [@@js.get "overwrite"]
    val set_overwrite: t -> bool -> unit [@@js.set "overwrite"]
  end
  module AnonymousInterface4 : sig
    type t = anonymous_interface_4
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_createIfNone: t -> ([`L_b_true[@js true]] [@js.enum]) [@@js.get "createIfNone"]
    val set_createIfNone: t -> ([`L_b_true] [@js.enum]) -> unit [@@js.set "createIfNone"]
  end
  module AnonymousInterface5 : sig
    type t = anonymous_interface_5
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val dispose: t -> any [@@js.call "dispose"]
  end
  module AnonymousInterface6 : sig
    type t = anonymous_interface_6
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_document: t -> vscode_TextDocument [@@js.get "document"]
    val set_document: t -> vscode_TextDocument -> unit [@@js.set "document"]
    val get_range: t -> vscode_Range [@@js.get "range"]
    val set_range: t -> vscode_Range -> unit [@@js.set "range"]
  end
  module AnonymousInterface7 : sig
    type t = anonymous_interface_7
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_escapeChar: t -> string [@@js.get "escapeChar"]
    val set_escapeChar: t -> string -> unit [@@js.set "escapeChar"]
    val get_charsToEscape: t -> string [@@js.get "charsToEscape"]
    val set_charsToEscape: t -> string -> unit [@@js.set "charsToEscape"]
  end
  module AnonymousInterface8 : sig
    type t = anonymous_interface_8
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_inserting: t -> vscode_Range [@@js.get "inserting"]
    val set_inserting: t -> vscode_Range -> unit [@@js.set "inserting"]
    val get_replacing: t -> vscode_Range [@@js.get "replacing"]
    val set_replacing: t -> vscode_Range -> unit [@@js.set "replacing"]
  end
  module AnonymousInterface9 : sig
    type t = anonymous_interface_9
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_isCaseSensitive: t -> bool [@@js.get "isCaseSensitive"]
    val get_isReadonly: t -> bool [@@js.get "isReadonly"]
  end
  module AnonymousInterface10 : sig
    type t = anonymous_interface_10
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_key: t -> string [@@js.get "key"]
    val set_key: t -> string -> unit [@@js.set "key"]
    val get_defaultValue: t -> 'T [@@js.get "defaultValue"]
    val set_defaultValue: t -> 'T -> unit [@@js.set "defaultValue"]
    val get_globalValue: t -> 'T [@@js.get "globalValue"]
    val set_globalValue: t -> 'T -> unit [@@js.set "globalValue"]
    val get_workspaceValue: t -> 'T [@@js.get "workspaceValue"]
    val set_workspaceValue: t -> 'T -> unit [@@js.set "workspaceValue"]
    val get_workspaceFolderValue: t -> 'T [@@js.get "workspaceFolderValue"]
    val set_workspaceFolderValue: t -> 'T -> unit [@@js.set "workspaceFolderValue"]
    val get_defaultLanguageValue: t -> 'T [@@js.get "defaultLanguageValue"]
    val set_defaultLanguageValue: t -> 'T -> unit [@@js.set "defaultLanguageValue"]
    val get_globalLanguageValue: t -> 'T [@@js.get "globalLanguageValue"]
    val set_globalLanguageValue: t -> 'T -> unit [@@js.set "globalLanguageValue"]
    val get_workspaceLanguageValue: t -> 'T [@@js.get "workspaceLanguageValue"]
    val set_workspaceLanguageValue: t -> 'T -> unit [@@js.set "workspaceLanguageValue"]
    val get_workspaceFolderLanguageValue: t -> 'T [@@js.get "workspaceFolderLanguageValue"]
    val set_workspaceFolderLanguageValue: t -> 'T -> unit [@@js.set "workspaceFolderLanguageValue"]
    val get_languageIds: t -> string list [@@js.get "languageIds"]
    val set_languageIds: t -> string list -> unit [@@js.set "languageIds"]
  end
  module AnonymousInterface11 : sig
    type t = anonymous_interface_11
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_kind: t -> vscode_CodeActionKind [@@js.get "kind"]
    val get_command: t -> vscode_Command [@@js.get "command"]
  end
  module AnonymousInterface12 : sig
    type t = anonymous_interface_12
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_language: t -> string [@@js.get "language"]
    val set_language: t -> string -> unit [@@js.set "language"]
    val get_content: t -> string [@@js.get "content"]
    val set_content: t -> string -> unit [@@js.set "content"]
  end
  module AnonymousInterface13 : sig
    type t = anonymous_interface_13
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_language: t -> string [@@js.get "language"]
    val set_language: t -> string -> unit [@@js.set "language"]
    val get_value: t -> string [@@js.get "value"]
    val set_value: t -> string -> unit [@@js.set "value"]
  end
  module AnonymousInterface14 : sig
    type t = anonymous_interface_14
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_light: t -> vscode_Uri [@@js.get "light"]
    val set_light: t -> vscode_Uri -> unit [@@js.set "light"]
    val get_dark: t -> vscode_Uri [@@js.get "dark"]
    val set_dark: t -> vscode_Uri -> unit [@@js.set "dark"]
  end
  module AnonymousInterface15 : sig
    type t = anonymous_interface_15
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_light: t -> vscode_Uri or_string [@@js.get "light"]
    val set_light: t -> vscode_Uri or_string -> unit [@@js.set "light"]
    val get_dark: t -> vscode_Uri or_string [@@js.get "dark"]
    val set_dark: t -> vscode_Uri or_string -> unit [@@js.set "dark"]
  end
  module AnonymousInterface16 : sig
    type t = anonymous_interface_16
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_line: t -> float [@@js.get "line"]
    val set_line: t -> float -> unit [@@js.set "line"]
    val get_character: t -> float [@@js.get "character"]
    val set_character: t -> float -> unit [@@js.set "character"]
  end
  module AnonymousInterface17 : sig
    type t = anonymous_interface_17
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_lineDelta: t -> float [@@js.get "lineDelta"]
    val set_lineDelta: t -> float -> unit [@@js.set "lineDelta"]
    val get_characterDelta: t -> float [@@js.get "characterDelta"]
    val set_characterDelta: t -> float -> unit [@@js.set "characterDelta"]
  end
  module AnonymousInterface18 : sig
    type t = anonymous_interface_18
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_message: t -> string [@@js.get "message"]
    val set_message: t -> string -> unit [@@js.set "message"]
    val get_increment: t -> float [@@js.get "increment"]
    val set_increment: t -> float -> unit [@@js.set "increment"]
  end
  module AnonymousInterface19 : sig
    type t = anonymous_interface_19
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_oldUri: t -> vscode_Uri [@@js.get "oldUri"]
    val set_oldUri: t -> vscode_Uri -> unit [@@js.set "oldUri"]
    val get_newUri: t -> vscode_Uri [@@js.get "newUri"]
    val set_newUri: t -> vscode_Uri -> unit [@@js.set "newUri"]
  end
  module AnonymousInterface20 : sig
    type t = anonymous_interface_20
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_open: t -> string [@@js.get "open"]
    val set_open: t -> string -> unit [@@js.set "open"]
    val get_close: t -> string [@@js.get "close"]
    val set_close: t -> string -> unit [@@js.set "close"]
    val get_notIn: t -> string list [@@js.get "notIn"]
    val set_notIn: t -> string list -> unit [@@js.set "notIn"]
  end
  module AnonymousInterface21 : sig
    type t = anonymous_interface_21
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_overwrite: t -> bool [@@js.get "overwrite"]
    val set_overwrite: t -> bool -> unit [@@js.set "overwrite"]
  end
  module AnonymousInterface22 : sig
    type t = anonymous_interface_22
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_overwrite: t -> bool [@@js.get "overwrite"]
    val set_overwrite: t -> bool -> unit [@@js.set "overwrite"]
    val get_ignoreIfExists: t -> bool [@@js.get "ignoreIfExists"]
    val set_ignoreIfExists: t -> bool -> unit [@@js.set "ignoreIfExists"]
  end
  module AnonymousInterface23 : sig
    type t = anonymous_interface_23
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_range: t -> vscode_Range [@@js.get "range"]
    val set_range: t -> vscode_Range -> unit [@@js.set "range"]
    val get_placeholder: t -> string [@@js.get "placeholder"]
    val set_placeholder: t -> string -> unit [@@js.set "placeholder"]
  end
  module AnonymousInterface24 : sig
    type t = anonymous_interface_24
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_reason: t -> string [@@js.get "reason"]
  end
  module AnonymousInterface25 : sig
    type t = anonymous_interface_25
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_recursive: t -> bool [@@js.get "recursive"]
    val set_recursive: t -> bool -> unit [@@js.set "recursive"]
  end
  module AnonymousInterface26 : sig
    type t = anonymous_interface_26
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_recursive: t -> bool [@@js.get "recursive"]
    val set_recursive: t -> bool -> unit [@@js.set "recursive"]
    val get_excludes: t -> string list [@@js.get "excludes"]
    val set_excludes: t -> string list -> unit [@@js.set "excludes"]
  end
  module AnonymousInterface27 : sig
    type t = anonymous_interface_27
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_recursive: t -> bool [@@js.get "recursive"]
    val set_recursive: t -> bool -> unit [@@js.set "recursive"]
    val get_ignoreIfNotExists: t -> bool [@@js.get "ignoreIfNotExists"]
    val set_ignoreIfNotExists: t -> bool -> unit [@@js.set "ignoreIfNotExists"]
  end
  module AnonymousInterface28 : sig
    type t = anonymous_interface_28
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_recursive: t -> bool [@@js.get "recursive"]
    val set_recursive: t -> bool -> unit [@@js.set "recursive"]
    val get_useTrash: t -> bool [@@js.get "useTrash"]
    val set_useTrash: t -> bool -> unit [@@js.set "useTrash"]
  end
  module AnonymousInterface29 : sig
    type t = anonymous_interface_29
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_retainContextWhenHidden: t -> bool [@@js.get "retainContextWhenHidden"]
  end
  module AnonymousInterface30 : sig
    type t = anonymous_interface_30
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_scheme: t -> string [@@js.get "scheme"]
    val set_scheme: t -> string -> unit [@@js.set "scheme"]
    val get_authority: t -> string [@@js.get "authority"]
    val set_authority: t -> string -> unit [@@js.set "authority"]
    val get_path: t -> string [@@js.get "path"]
    val set_path: t -> string -> unit [@@js.set "path"]
    val get_query: t -> string [@@js.get "query"]
    val set_query: t -> string -> unit [@@js.set "query"]
    val get_fragment: t -> string [@@js.get "fragment"]
    val set_fragment: t -> string -> unit [@@js.set "fragment"]
  end
  module AnonymousInterface31 : sig
    type t = anonymous_interface_31
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_scope: t -> string [@@js.get "scope"]
    val set_scope: t -> string -> unit [@@js.set "scope"]
    val get_open: t -> string [@@js.get "open"]
    val set_open: t -> string -> unit [@@js.set "open"]
    val get_lineStart: t -> string [@@js.get "lineStart"]
    val set_lineStart: t -> string -> unit [@@js.set "lineStart"]
    val get_close: t -> string [@@js.get "close"]
    val set_close: t -> string -> unit [@@js.set "close"]
  end
  module AnonymousInterface32 : sig
    type t = anonymous_interface_32
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
  module AnonymousInterface33 : sig
    type t = anonymous_interface_33
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_start: t -> vscode_Position [@@js.get "start"]
    val set_start: t -> vscode_Position -> unit [@@js.set "start"]
    val get_end: t -> vscode_Position [@@js.get "end"]
    val set_end: t -> vscode_Position -> unit [@@js.set "end"]
  end
  module AnonymousInterface34 : sig
    type t = anonymous_interface_34
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_undoStopBefore: t -> bool [@@js.get "undoStopBefore"]
    val set_undoStopBefore: t -> bool -> unit [@@js.set "undoStopBefore"]
    val get_undoStopAfter: t -> bool [@@js.get "undoStopAfter"]
    val set_undoStopAfter: t -> bool -> unit [@@js.set "undoStopAfter"]
  end
  module AnonymousInterface35 : sig
    type t = anonymous_interface_35
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_uri: t -> vscode_Uri [@@js.get "uri"]
    val set_uri: t -> vscode_Uri -> unit [@@js.set "uri"]
    val get_languageId: t -> string [@@js.get "languageId"]
    val set_languageId: t -> string -> unit [@@js.set "languageId"]
  end
  module AnonymousInterface36 : sig
    type t = anonymous_interface_36
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_uri: t -> vscode_Uri [@@js.get "uri"]
    val set_uri: t -> vscode_Uri -> unit [@@js.set "uri"]
    val get_name: t -> string [@@js.get "name"]
    val set_name: t -> string -> unit [@@js.set "name"]
  end
  module AnonymousInterface37 : sig
    type t = anonymous_interface_37
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_value: t -> string or_number [@@js.get "value"]
    val set_value: t -> string or_number -> unit [@@js.set "value"]
    val get_target: t -> vscode_Uri [@@js.get "target"]
    val set_target: t -> vscode_Uri -> unit [@@js.set "target"]
  end
  module AnonymousInterface38 : sig
    type t = anonymous_interface_38
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_viewColumn: t -> vscode_ViewColumn [@@js.get "viewColumn"]
    val set_viewColumn: t -> vscode_ViewColumn -> unit [@@js.set "viewColumn"]
    val get_preserveFocus: t -> bool [@@js.get "preserveFocus"]
    val set_preserveFocus: t -> bool -> unit [@@js.set "preserveFocus"]
  end
  module AnonymousInterface39 : sig
    type t = anonymous_interface_39
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_viewId: t -> string [@@js.get "viewId"]
    val set_viewId: t -> string -> unit [@@js.set "viewId"]
  end
  module AnonymousInterface40 : sig
    type t = anonymous_interface_40
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_webviewOptions: t -> vscode_WebviewPanelOptions [@@js.get "webviewOptions"]
    val get_supportsMultipleEditorsPerDocument: t -> bool [@@js.get "supportsMultipleEditorsPerDocument"]
  end
  module AnonymousInterface41 : sig
    type t = anonymous_interface_41
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_webviewOptions: t -> anonymous_interface_29 [@@js.get "webviewOptions"]
  end
  module AnonymousInterface42 : sig
    type t = anonymous_interface_42
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val dispose: t -> any [@@js.call "dispose"]
  end
  module AnonymousInterface43 : sig
    type t = anonymous_interface_43
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val setKeysForSync: t -> keys:string list -> unit [@@js.call "setKeysForSync"]
  end
  module AnonymousInterface44 : sig
    type t = anonymous_interface_44
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get: t -> string -> string [@@js.index_get]
    val set: t -> string -> string -> unit [@@js.index_set]
  end
  module AnonymousInterface45 : sig
    type t = anonymous_interface_45
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get: t -> string -> string or_null_or_undefined [@@js.index_get]
    val set: t -> string -> string or_null_or_undefined -> unit [@@js.index_set]
  end
  module AnonymousInterface46 : sig
    type t = anonymous_interface_46
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get: t -> string -> string list [@@js.index_get]
    val set: t -> string -> string list -> unit [@@js.index_set]
  end
  module[@js.scope "vscode"] Vscode : sig
    val version: string [@@js.global "version"]
    module[@js.scope "Command"] Command : sig
      type t = vscode_Command
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_title: t -> string [@@js.get "title"]
      val set_title: t -> string -> unit [@@js.set "title"]
      val get_command: t -> string [@@js.get "command"]
      val set_command: t -> string -> unit [@@js.set "command"]
      val get_tooltip: t -> string [@@js.get "tooltip"]
      val set_tooltip: t -> string -> unit [@@js.set "tooltip"]
      val get_arguments: t -> any list [@@js.get "arguments"]
      val set_arguments: t -> any list -> unit [@@js.set "arguments"]
    end
    module[@js.scope "TextLine"] TextLine : sig
      type t = vscode_TextLine
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_lineNumber: t -> float [@@js.get "lineNumber"]
      val get_text: t -> string [@@js.get "text"]
      val get_range: t -> vscode_Range [@@js.get "range"]
      val get_rangeIncludingLineBreak: t -> vscode_Range [@@js.get "rangeIncludingLineBreak"]
      val get_firstNonWhitespaceCharacterIndex: t -> float [@@js.get "firstNonWhitespaceCharacterIndex"]
      val get_isEmptyOrWhitespace: t -> bool [@@js.get "isEmptyOrWhitespace"]
    end
    module[@js.scope "TextDocument"] TextDocument : sig
      type t = vscode_TextDocument
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_uri: t -> vscode_Uri [@@js.get "uri"]
      val get_fileName: t -> string [@@js.get "fileName"]
      val get_isUntitled: t -> bool [@@js.get "isUntitled"]
      val get_languageId: t -> string [@@js.get "languageId"]
      val get_version: t -> float [@@js.get "version"]
      val get_isDirty: t -> bool [@@js.get "isDirty"]
      val get_isClosed: t -> bool [@@js.get "isClosed"]
      val save: t -> bool _Thenable [@@js.call "save"]
      val get_eol: t -> vscode_EndOfLine [@@js.get "eol"]
      val get_lineCount: t -> float [@@js.get "lineCount"]
      val lineAt: t -> line:float -> vscode_TextLine [@@js.call "lineAt"]
      val lineAt': t -> position:vscode_Position -> vscode_TextLine [@@js.call "lineAt"]
      val offsetAt: t -> position:vscode_Position -> float [@@js.call "offsetAt"]
      val positionAt: t -> offset:float -> vscode_Position [@@js.call "positionAt"]
      val getText: t -> ?range:vscode_Range -> unit -> string [@@js.call "getText"]
      val getWordRangeAtPosition: t -> position:vscode_Position -> ?regex:regexp -> unit -> vscode_Range or_undefined [@@js.call "getWordRangeAtPosition"]
      val validateRange: t -> range:vscode_Range -> vscode_Range [@@js.call "validateRange"]
      val validatePosition: t -> position:vscode_Position -> vscode_Position [@@js.call "validatePosition"]
    end
    module[@js.scope "Position"] Position : sig
      type t = vscode_Position
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_line: t -> float [@@js.get "line"]
      val get_character: t -> float [@@js.get "character"]
      val create: line:float -> character:float -> t [@@js.create]
      val isBefore: t -> other:t -> bool [@@js.call "isBefore"]
      val isBeforeOrEqual: t -> other:t -> bool [@@js.call "isBeforeOrEqual"]
      val isAfter: t -> other:t -> bool [@@js.call "isAfter"]
      val isAfterOrEqual: t -> other:t -> bool [@@js.call "isAfterOrEqual"]
      val isEqual: t -> other:t -> bool [@@js.call "isEqual"]
      val compareTo: t -> other:t -> float [@@js.call "compareTo"]
      val translate: t -> ?lineDelta:float -> ?characterDelta:float -> unit -> t [@@js.call "translate"]
      val translate': t -> change:anonymous_interface_17 -> t [@@js.call "translate"]
      val with_: t -> ?line:float -> ?character:float -> unit -> t [@@js.call "with"]
      val with_': t -> change:anonymous_interface_16 -> t [@@js.call "with"]
    end
    module[@js.scope "Range"] Range : sig
      type t = vscode_Range
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_start: t -> vscode_Position [@@js.get "start"]
      val get_end: t -> vscode_Position [@@js.get "end"]
      val create: start:vscode_Position -> end_:vscode_Position -> t [@@js.create]
      val create': startLine:float -> startCharacter:float -> endLine:float -> endCharacter:float -> t [@@js.create]
      val get_isEmpty: t -> bool [@@js.get "isEmpty"]
      val set_isEmpty: t -> bool -> unit [@@js.set "isEmpty"]
      val get_isSingleLine: t -> bool [@@js.get "isSingleLine"]
      val set_isSingleLine: t -> bool -> unit [@@js.set "isSingleLine"]
      val contains: t -> positionOrRange:(vscode_Position, t) union2 -> bool [@@js.call "contains"]
      val isEqual: t -> other:t -> bool [@@js.call "isEqual"]
      val intersection: t -> range:t -> t or_undefined [@@js.call "intersection"]
      val union: t -> other:t -> t [@@js.call "union"]
      val with_: t -> ?start:vscode_Position -> ?end_:vscode_Position -> unit -> t [@@js.call "with"]
      val with_': t -> change:anonymous_interface_33 -> t [@@js.call "with"]
    end
    module[@js.scope "Selection"] Selection : sig
      type t = vscode_Selection
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_anchor: t -> vscode_Position [@@js.get "anchor"]
      val set_anchor: t -> vscode_Position -> unit [@@js.set "anchor"]
      val get_active: t -> vscode_Position [@@js.get "active"]
      val set_active: t -> vscode_Position -> unit [@@js.set "active"]
      val create: anchor:vscode_Position -> active:vscode_Position -> t [@@js.create]
      val create': anchorLine:float -> anchorCharacter:float -> activeLine:float -> activeCharacter:float -> t [@@js.create]
      val get_isReversed: t -> bool [@@js.get "isReversed"]
      val set_isReversed: t -> bool -> unit [@@js.set "isReversed"]
      val cast: t -> vscode_Range [@@js.cast]
    end
    module TextEditorSelectionChangeKind : sig
      type t = vscode_TextEditorSelectionChangeKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "TextEditorSelectionChangeEvent"] TextEditorSelectionChangeEvent : sig
      type t = vscode_TextEditorSelectionChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_textEditor: t -> vscode_TextEditor [@@js.get "textEditor"]
      val get_selections: t -> vscode_Selection list [@@js.get "selections"]
      val get_kind: t -> vscode_TextEditorSelectionChangeKind [@@js.get "kind"]
    end
    module[@js.scope "TextEditorVisibleRangesChangeEvent"] TextEditorVisibleRangesChangeEvent : sig
      type t = vscode_TextEditorVisibleRangesChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_textEditor: t -> vscode_TextEditor [@@js.get "textEditor"]
      val get_visibleRanges: t -> vscode_Range list [@@js.get "visibleRanges"]
    end
    module[@js.scope "TextEditorOptionsChangeEvent"] TextEditorOptionsChangeEvent : sig
      type t = vscode_TextEditorOptionsChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_textEditor: t -> vscode_TextEditor [@@js.get "textEditor"]
      val get_options: t -> vscode_TextEditorOptions [@@js.get "options"]
    end
    module[@js.scope "TextEditorViewColumnChangeEvent"] TextEditorViewColumnChangeEvent : sig
      type t = vscode_TextEditorViewColumnChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_textEditor: t -> vscode_TextEditor [@@js.get "textEditor"]
      val get_viewColumn: t -> vscode_ViewColumn [@@js.get "viewColumn"]
    end
    module TextEditorCursorStyle : sig
      type t = vscode_TextEditorCursorStyle
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module TextEditorLineNumbersStyle : sig
      type t = vscode_TextEditorLineNumbersStyle
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "TextEditorOptions"] TextEditorOptions : sig
      type t = vscode_TextEditorOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_tabSize: t -> string or_number [@@js.get "tabSize"]
      val set_tabSize: t -> string or_number -> unit [@@js.set "tabSize"]
      val get_insertSpaces: t -> bool or_string [@@js.get "insertSpaces"]
      val set_insertSpaces: t -> bool or_string -> unit [@@js.set "insertSpaces"]
      val get_cursorStyle: t -> vscode_TextEditorCursorStyle [@@js.get "cursorStyle"]
      val set_cursorStyle: t -> vscode_TextEditorCursorStyle -> unit [@@js.set "cursorStyle"]
      val get_lineNumbers: t -> vscode_TextEditorLineNumbersStyle [@@js.get "lineNumbers"]
      val set_lineNumbers: t -> vscode_TextEditorLineNumbersStyle -> unit [@@js.set "lineNumbers"]
    end
    module[@js.scope "TextEditorDecorationType"] TextEditorDecorationType : sig
      type t = vscode_TextEditorDecorationType
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_key: t -> string [@@js.get "key"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module TextEditorRevealType : sig
      type t = vscode_TextEditorRevealType
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module OverviewRulerLane : sig
      type t = vscode_OverviewRulerLane
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module DecorationRangeBehavior : sig
      type t = vscode_DecorationRangeBehavior
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "TextDocumentShowOptions"] TextDocumentShowOptions : sig
      type t = vscode_TextDocumentShowOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_viewColumn: t -> vscode_ViewColumn [@@js.get "viewColumn"]
      val set_viewColumn: t -> vscode_ViewColumn -> unit [@@js.set "viewColumn"]
      val get_preserveFocus: t -> bool [@@js.get "preserveFocus"]
      val set_preserveFocus: t -> bool -> unit [@@js.set "preserveFocus"]
      val get_preview: t -> bool [@@js.get "preview"]
      val set_preview: t -> bool -> unit [@@js.set "preview"]
      val get_selection: t -> vscode_Range [@@js.get "selection"]
      val set_selection: t -> vscode_Range -> unit [@@js.set "selection"]
    end
    module[@js.scope "ThemeColor"] ThemeColor : sig
      type t = vscode_ThemeColor
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: id:string -> t [@@js.create]
    end
    module[@js.scope "ThemeIcon"] ThemeIcon : sig
      type t = vscode_ThemeIcon
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_File: unit -> t [@@js.get "File"]
      val get_Folder: unit -> t [@@js.get "Folder"]
      val get_id: t -> string [@@js.get "id"]
      val get_color: t -> vscode_ThemeColor [@@js.get "color"]
      val create: id:string -> ?color:vscode_ThemeColor -> unit -> t [@@js.create]
    end
    module[@js.scope "ThemableDecorationRenderOptions"] ThemableDecorationRenderOptions : sig
      type t = vscode_ThemableDecorationRenderOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_backgroundColor: t -> vscode_ThemeColor or_string [@@js.get "backgroundColor"]
      val set_backgroundColor: t -> vscode_ThemeColor or_string -> unit [@@js.set "backgroundColor"]
      val get_outline: t -> string [@@js.get "outline"]
      val set_outline: t -> string -> unit [@@js.set "outline"]
      val get_outlineColor: t -> vscode_ThemeColor or_string [@@js.get "outlineColor"]
      val set_outlineColor: t -> vscode_ThemeColor or_string -> unit [@@js.set "outlineColor"]
      val get_outlineStyle: t -> string [@@js.get "outlineStyle"]
      val set_outlineStyle: t -> string -> unit [@@js.set "outlineStyle"]
      val get_outlineWidth: t -> string [@@js.get "outlineWidth"]
      val set_outlineWidth: t -> string -> unit [@@js.set "outlineWidth"]
      val get_border: t -> string [@@js.get "border"]
      val set_border: t -> string -> unit [@@js.set "border"]
      val get_borderColor: t -> vscode_ThemeColor or_string [@@js.get "borderColor"]
      val set_borderColor: t -> vscode_ThemeColor or_string -> unit [@@js.set "borderColor"]
      val get_borderRadius: t -> string [@@js.get "borderRadius"]
      val set_borderRadius: t -> string -> unit [@@js.set "borderRadius"]
      val get_borderSpacing: t -> string [@@js.get "borderSpacing"]
      val set_borderSpacing: t -> string -> unit [@@js.set "borderSpacing"]
      val get_borderStyle: t -> string [@@js.get "borderStyle"]
      val set_borderStyle: t -> string -> unit [@@js.set "borderStyle"]
      val get_borderWidth: t -> string [@@js.get "borderWidth"]
      val set_borderWidth: t -> string -> unit [@@js.set "borderWidth"]
      val get_fontStyle: t -> string [@@js.get "fontStyle"]
      val set_fontStyle: t -> string -> unit [@@js.set "fontStyle"]
      val get_fontWeight: t -> string [@@js.get "fontWeight"]
      val set_fontWeight: t -> string -> unit [@@js.set "fontWeight"]
      val get_textDecoration: t -> string [@@js.get "textDecoration"]
      val set_textDecoration: t -> string -> unit [@@js.set "textDecoration"]
      val get_cursor: t -> string [@@js.get "cursor"]
      val set_cursor: t -> string -> unit [@@js.set "cursor"]
      val get_color: t -> vscode_ThemeColor or_string [@@js.get "color"]
      val set_color: t -> vscode_ThemeColor or_string -> unit [@@js.set "color"]
      val get_opacity: t -> string [@@js.get "opacity"]
      val set_opacity: t -> string -> unit [@@js.set "opacity"]
      val get_letterSpacing: t -> string [@@js.get "letterSpacing"]
      val set_letterSpacing: t -> string -> unit [@@js.set "letterSpacing"]
      val get_gutterIconPath: t -> vscode_Uri or_string [@@js.get "gutterIconPath"]
      val set_gutterIconPath: t -> vscode_Uri or_string -> unit [@@js.set "gutterIconPath"]
      val get_gutterIconSize: t -> string [@@js.get "gutterIconSize"]
      val set_gutterIconSize: t -> string -> unit [@@js.set "gutterIconSize"]
      val get_overviewRulerColor: t -> vscode_ThemeColor or_string [@@js.get "overviewRulerColor"]
      val set_overviewRulerColor: t -> vscode_ThemeColor or_string -> unit [@@js.set "overviewRulerColor"]
      val get_before: t -> vscode_ThemableDecorationAttachmentRenderOptions [@@js.get "before"]
      val set_before: t -> vscode_ThemableDecorationAttachmentRenderOptions -> unit [@@js.set "before"]
      val get_after: t -> vscode_ThemableDecorationAttachmentRenderOptions [@@js.get "after"]
      val set_after: t -> vscode_ThemableDecorationAttachmentRenderOptions -> unit [@@js.set "after"]
    end
    module[@js.scope "ThemableDecorationAttachmentRenderOptions"] ThemableDecorationAttachmentRenderOptions : sig
      type t = vscode_ThemableDecorationAttachmentRenderOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_contentText: t -> string [@@js.get "contentText"]
      val set_contentText: t -> string -> unit [@@js.set "contentText"]
      val get_contentIconPath: t -> vscode_Uri or_string [@@js.get "contentIconPath"]
      val set_contentIconPath: t -> vscode_Uri or_string -> unit [@@js.set "contentIconPath"]
      val get_border: t -> string [@@js.get "border"]
      val set_border: t -> string -> unit [@@js.set "border"]
      val get_borderColor: t -> vscode_ThemeColor or_string [@@js.get "borderColor"]
      val set_borderColor: t -> vscode_ThemeColor or_string -> unit [@@js.set "borderColor"]
      val get_fontStyle: t -> string [@@js.get "fontStyle"]
      val set_fontStyle: t -> string -> unit [@@js.set "fontStyle"]
      val get_fontWeight: t -> string [@@js.get "fontWeight"]
      val set_fontWeight: t -> string -> unit [@@js.set "fontWeight"]
      val get_textDecoration: t -> string [@@js.get "textDecoration"]
      val set_textDecoration: t -> string -> unit [@@js.set "textDecoration"]
      val get_color: t -> vscode_ThemeColor or_string [@@js.get "color"]
      val set_color: t -> vscode_ThemeColor or_string -> unit [@@js.set "color"]
      val get_backgroundColor: t -> vscode_ThemeColor or_string [@@js.get "backgroundColor"]
      val set_backgroundColor: t -> vscode_ThemeColor or_string -> unit [@@js.set "backgroundColor"]
      val get_margin: t -> string [@@js.get "margin"]
      val set_margin: t -> string -> unit [@@js.set "margin"]
      val get_width: t -> string [@@js.get "width"]
      val set_width: t -> string -> unit [@@js.set "width"]
      val get_height: t -> string [@@js.get "height"]
      val set_height: t -> string -> unit [@@js.set "height"]
    end
    module[@js.scope "DecorationRenderOptions"] DecorationRenderOptions : sig
      type t = vscode_DecorationRenderOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_isWholeLine: t -> bool [@@js.get "isWholeLine"]
      val set_isWholeLine: t -> bool -> unit [@@js.set "isWholeLine"]
      val get_rangeBehavior: t -> vscode_DecorationRangeBehavior [@@js.get "rangeBehavior"]
      val set_rangeBehavior: t -> vscode_DecorationRangeBehavior -> unit [@@js.set "rangeBehavior"]
      val get_overviewRulerLane: t -> vscode_OverviewRulerLane [@@js.get "overviewRulerLane"]
      val set_overviewRulerLane: t -> vscode_OverviewRulerLane -> unit [@@js.set "overviewRulerLane"]
      val get_light: t -> vscode_ThemableDecorationRenderOptions [@@js.get "light"]
      val set_light: t -> vscode_ThemableDecorationRenderOptions -> unit [@@js.set "light"]
      val get_dark: t -> vscode_ThemableDecorationRenderOptions [@@js.get "dark"]
      val set_dark: t -> vscode_ThemableDecorationRenderOptions -> unit [@@js.set "dark"]
      val cast: t -> vscode_ThemableDecorationRenderOptions [@@js.cast]
    end
    module[@js.scope "DecorationOptions"] DecorationOptions : sig
      type t = vscode_DecorationOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val get_hoverMessage: t -> (vscode_MarkedString, vscode_MarkedString) or_array [@@js.get "hoverMessage"]
      val set_hoverMessage: t -> (vscode_MarkedString, vscode_MarkedString) or_array -> unit [@@js.set "hoverMessage"]
      val get_renderOptions: t -> vscode_DecorationInstanceRenderOptions [@@js.get "renderOptions"]
      val set_renderOptions: t -> vscode_DecorationInstanceRenderOptions -> unit [@@js.set "renderOptions"]
    end
    module[@js.scope "ThemableDecorationInstanceRenderOptions"] ThemableDecorationInstanceRenderOptions : sig
      type t = vscode_ThemableDecorationInstanceRenderOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_before: t -> vscode_ThemableDecorationAttachmentRenderOptions [@@js.get "before"]
      val set_before: t -> vscode_ThemableDecorationAttachmentRenderOptions -> unit [@@js.set "before"]
      val get_after: t -> vscode_ThemableDecorationAttachmentRenderOptions [@@js.get "after"]
      val set_after: t -> vscode_ThemableDecorationAttachmentRenderOptions -> unit [@@js.set "after"]
    end
    module[@js.scope "DecorationInstanceRenderOptions"] DecorationInstanceRenderOptions : sig
      type t = vscode_DecorationInstanceRenderOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_light: t -> vscode_ThemableDecorationInstanceRenderOptions [@@js.get "light"]
      val set_light: t -> vscode_ThemableDecorationInstanceRenderOptions -> unit [@@js.set "light"]
      val get_dark: t -> vscode_ThemableDecorationInstanceRenderOptions [@@js.get "dark"]
      val set_dark: t -> vscode_ThemableDecorationInstanceRenderOptions -> unit [@@js.set "dark"]
      val cast: t -> vscode_ThemableDecorationInstanceRenderOptions [@@js.cast]
    end
    module[@js.scope "TextEditor"] TextEditor : sig
      type t = vscode_TextEditor
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_document: t -> vscode_TextDocument [@@js.get "document"]
      val get_selection: t -> vscode_Selection [@@js.get "selection"]
      val set_selection: t -> vscode_Selection -> unit [@@js.set "selection"]
      val get_selections: t -> vscode_Selection list [@@js.get "selections"]
      val set_selections: t -> vscode_Selection list -> unit [@@js.set "selections"]
      val get_visibleRanges: t -> vscode_Range list [@@js.get "visibleRanges"]
      val get_options: t -> vscode_TextEditorOptions [@@js.get "options"]
      val set_options: t -> vscode_TextEditorOptions -> unit [@@js.set "options"]
      val get_viewColumn: t -> vscode_ViewColumn [@@js.get "viewColumn"]
      val edit: t -> callback:(editBuilder:vscode_TextEditorEdit -> unit) -> ?options:anonymous_interface_34 -> unit -> bool _Thenable [@@js.call "edit"]
      val insertSnippet: t -> snippet:vscode_SnippetString -> ?location:(vscode_Position, vscode_Range, vscode_Position list, vscode_Range list) union4 -> ?options:anonymous_interface_34 -> unit -> bool _Thenable [@@js.call "insertSnippet"]
      val setDecorations: t -> decorationType:vscode_TextEditorDecorationType -> rangesOrOptions:(vscode_DecorationOptions, vscode_Range) union2 list -> unit [@@js.call "setDecorations"]
      val revealRange: t -> range:vscode_Range -> ?revealType:vscode_TextEditorRevealType -> unit -> unit [@@js.call "revealRange"]
      val show: t -> ?column:vscode_ViewColumn -> unit -> unit [@@js.call "show"]
      val hide: t -> unit [@@js.call "hide"]
    end
    module EndOfLine : sig
      type t = vscode_EndOfLine
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "TextEditorEdit"] TextEditorEdit : sig
      type t = vscode_TextEditorEdit
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val replace: t -> location:(vscode_Position, vscode_Range, vscode_Selection) union3 -> value:string -> unit [@@js.call "replace"]
      val insert: t -> location:vscode_Position -> value:string -> unit [@@js.call "insert"]
      val delete: t -> location:(vscode_Range, vscode_Selection) union2 -> unit [@@js.call "delete"]
      val setEndOfLine: t -> endOfLine:vscode_EndOfLine -> unit [@@js.call "setEndOfLine"]
    end
    module[@js.scope "Uri"] Uri : sig
      type t = vscode_Uri
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val parse: value:string -> ?strict:bool -> unit -> t [@@js.global "parse"]
      val file: path:string -> t [@@js.global "file"]
      val joinPath: base:t -> pathSegments:(string list [@js.variadic]) -> t [@@js.global "joinPath"]
      val create: scheme:string -> authority:string -> path:string -> query:string -> fragment:string -> t [@@js.create]
      val get_scheme: t -> string [@@js.get "scheme"]
      val get_authority: t -> string [@@js.get "authority"]
      val get_path: t -> string [@@js.get "path"]
      val get_query: t -> string [@@js.get "query"]
      val get_fragment: t -> string [@@js.get "fragment"]
      val get_fsPath: t -> string [@@js.get "fsPath"]
      val with_: t -> change:anonymous_interface_30 -> t [@@js.call "with"]
      val toString: t -> ?skipEncoding:bool -> unit -> string [@@js.call "toString"]
      val toJSON: t -> any [@@js.call "toJSON"]
    end
    module[@js.scope "CancellationToken"] CancellationToken : sig
      type t = vscode_CancellationToken
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_isCancellationRequested: t -> bool [@@js.get "isCancellationRequested"]
      val set_isCancellationRequested: t -> bool -> unit [@@js.set "isCancellationRequested"]
      val get_onCancellationRequested: t -> any vscode_Event [@@js.get "onCancellationRequested"]
      val set_onCancellationRequested: t -> any vscode_Event -> unit [@@js.set "onCancellationRequested"]
    end
    module[@js.scope "CancellationTokenSource"] CancellationTokenSource : sig
      type t = vscode_CancellationTokenSource
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_token: t -> vscode_CancellationToken [@@js.get "token"]
      val set_token: t -> vscode_CancellationToken -> unit [@@js.set "token"]
      val cancel: t -> unit [@@js.call "cancel"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "CancellationError"] CancellationError : sig
      type t = vscode_CancellationError
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: unit -> t [@@js.create]
      val cast: t -> Error.t_0 [@@js.cast]
    end
    module[@js.scope "Disposable"] Disposable : sig
      type t = vscode_Disposable
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val from: disposableLikes:(anonymous_interface_5 list [@js.variadic]) -> t [@@js.global "from"]
      val create: callOnDispose:untyped_function -> t [@@js.create]
      val dispose: t -> any [@@js.call "dispose"]
    end
    module[@js.scope "Event"] Event : sig
      type 'T t = 'T vscode_Event
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val apply: 'T t -> listener:(e:'T -> any) -> ?thisArgs:any -> ?disposables:vscode_Disposable list -> unit -> vscode_Disposable [@@js.apply]
    end
    module[@js.scope "EventEmitter"] EventEmitter : sig
      type 'T t = 'T vscode_EventEmitter
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_event: 'T t -> 'T vscode_Event [@@js.get "event"]
      val set_event: 'T t -> 'T vscode_Event -> unit [@@js.set "event"]
      val fire: 'T t -> data:'T -> unit [@@js.call "fire"]
      val dispose: 'T t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "FileSystemWatcher"] FileSystemWatcher : sig
      type t = vscode_FileSystemWatcher
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_ignoreCreateEvents: t -> bool [@@js.get "ignoreCreateEvents"]
      val set_ignoreCreateEvents: t -> bool -> unit [@@js.set "ignoreCreateEvents"]
      val get_ignoreChangeEvents: t -> bool [@@js.get "ignoreChangeEvents"]
      val set_ignoreChangeEvents: t -> bool -> unit [@@js.set "ignoreChangeEvents"]
      val get_ignoreDeleteEvents: t -> bool [@@js.get "ignoreDeleteEvents"]
      val set_ignoreDeleteEvents: t -> bool -> unit [@@js.set "ignoreDeleteEvents"]
      val get_onDidCreate: t -> vscode_Uri vscode_Event [@@js.get "onDidCreate"]
      val set_onDidCreate: t -> vscode_Uri vscode_Event -> unit [@@js.set "onDidCreate"]
      val get_onDidChange: t -> vscode_Uri vscode_Event [@@js.get "onDidChange"]
      val set_onDidChange: t -> vscode_Uri vscode_Event -> unit [@@js.set "onDidChange"]
      val get_onDidDelete: t -> vscode_Uri vscode_Event [@@js.get "onDidDelete"]
      val set_onDidDelete: t -> vscode_Uri vscode_Event -> unit [@@js.set "onDidDelete"]
      val cast: t -> vscode_Disposable [@@js.cast]
    end
    module[@js.scope "TextDocumentContentProvider"] TextDocumentContentProvider : sig
      type t = vscode_TextDocumentContentProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidChange: t -> vscode_Uri vscode_Event [@@js.get "onDidChange"]
      val set_onDidChange: t -> vscode_Uri vscode_Event -> unit [@@js.set "onDidChange"]
      val provideTextDocumentContent: t -> uri:vscode_Uri -> token:vscode_CancellationToken -> string vscode_ProviderResult [@@js.call "provideTextDocumentContent"]
    end
    module[@js.scope "QuickPickItem"] QuickPickItem : sig
      type t = vscode_QuickPickItem
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_description: t -> string [@@js.get "description"]
      val set_description: t -> string -> unit [@@js.set "description"]
      val get_detail: t -> string [@@js.get "detail"]
      val set_detail: t -> string -> unit [@@js.set "detail"]
      val get_picked: t -> bool [@@js.get "picked"]
      val set_picked: t -> bool -> unit [@@js.set "picked"]
      val get_alwaysShow: t -> bool [@@js.get "alwaysShow"]
      val set_alwaysShow: t -> bool -> unit [@@js.set "alwaysShow"]
    end
    module[@js.scope "QuickPickOptions"] QuickPickOptions : sig
      type t = vscode_QuickPickOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_matchOnDescription: t -> bool [@@js.get "matchOnDescription"]
      val set_matchOnDescription: t -> bool -> unit [@@js.set "matchOnDescription"]
      val get_matchOnDetail: t -> bool [@@js.get "matchOnDetail"]
      val set_matchOnDetail: t -> bool -> unit [@@js.set "matchOnDetail"]
      val get_placeHolder: t -> string [@@js.get "placeHolder"]
      val set_placeHolder: t -> string -> unit [@@js.set "placeHolder"]
      val get_ignoreFocusOut: t -> bool [@@js.get "ignoreFocusOut"]
      val set_ignoreFocusOut: t -> bool -> unit [@@js.set "ignoreFocusOut"]
      val get_canPickMany: t -> bool [@@js.get "canPickMany"]
      val set_canPickMany: t -> bool -> unit [@@js.set "canPickMany"]
      val onDidSelectItem: t -> item:vscode_QuickPickItem or_string -> any [@@js.call "onDidSelectItem"]
    end
    module[@js.scope "WorkspaceFolderPickOptions"] WorkspaceFolderPickOptions : sig
      type t = vscode_WorkspaceFolderPickOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_placeHolder: t -> string [@@js.get "placeHolder"]
      val set_placeHolder: t -> string -> unit [@@js.set "placeHolder"]
      val get_ignoreFocusOut: t -> bool [@@js.get "ignoreFocusOut"]
      val set_ignoreFocusOut: t -> bool -> unit [@@js.set "ignoreFocusOut"]
    end
    module[@js.scope "OpenDialogOptions"] OpenDialogOptions : sig
      type t = vscode_OpenDialogOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_defaultUri: t -> vscode_Uri [@@js.get "defaultUri"]
      val set_defaultUri: t -> vscode_Uri -> unit [@@js.set "defaultUri"]
      val get_openLabel: t -> string [@@js.get "openLabel"]
      val set_openLabel: t -> string -> unit [@@js.set "openLabel"]
      val get_canSelectFiles: t -> bool [@@js.get "canSelectFiles"]
      val set_canSelectFiles: t -> bool -> unit [@@js.set "canSelectFiles"]
      val get_canSelectFolders: t -> bool [@@js.get "canSelectFolders"]
      val set_canSelectFolders: t -> bool -> unit [@@js.set "canSelectFolders"]
      val get_canSelectMany: t -> bool [@@js.get "canSelectMany"]
      val set_canSelectMany: t -> bool -> unit [@@js.set "canSelectMany"]
      val get_filters: t -> anonymous_interface_46 [@@js.get "filters"]
      val set_filters: t -> anonymous_interface_46 -> unit [@@js.set "filters"]
      val get_title: t -> string [@@js.get "title"]
      val set_title: t -> string -> unit [@@js.set "title"]
    end
    module[@js.scope "SaveDialogOptions"] SaveDialogOptions : sig
      type t = vscode_SaveDialogOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_defaultUri: t -> vscode_Uri [@@js.get "defaultUri"]
      val set_defaultUri: t -> vscode_Uri -> unit [@@js.set "defaultUri"]
      val get_saveLabel: t -> string [@@js.get "saveLabel"]
      val set_saveLabel: t -> string -> unit [@@js.set "saveLabel"]
      val get_filters: t -> anonymous_interface_46 [@@js.get "filters"]
      val set_filters: t -> anonymous_interface_46 -> unit [@@js.set "filters"]
      val get_title: t -> string [@@js.get "title"]
      val set_title: t -> string -> unit [@@js.set "title"]
    end
    module[@js.scope "MessageItem"] MessageItem : sig
      type t = vscode_MessageItem
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_title: t -> string [@@js.get "title"]
      val set_title: t -> string -> unit [@@js.set "title"]
      val get_isCloseAffordance: t -> bool [@@js.get "isCloseAffordance"]
      val set_isCloseAffordance: t -> bool -> unit [@@js.set "isCloseAffordance"]
    end
    module[@js.scope "MessageOptions"] MessageOptions : sig
      type t = vscode_MessageOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_modal: t -> bool [@@js.get "modal"]
      val set_modal: t -> bool -> unit [@@js.set "modal"]
    end
    module[@js.scope "InputBoxOptions"] InputBoxOptions : sig
      type t = vscode_InputBoxOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_value: t -> string [@@js.get "value"]
      val set_value: t -> string -> unit [@@js.set "value"]
      val get_valueSelection: t -> (float * float) [@@js.get "valueSelection"]
      val set_valueSelection: t -> (float * float) -> unit [@@js.set "valueSelection"]
      val get_prompt: t -> string [@@js.get "prompt"]
      val set_prompt: t -> string -> unit [@@js.set "prompt"]
      val get_placeHolder: t -> string [@@js.get "placeHolder"]
      val set_placeHolder: t -> string -> unit [@@js.set "placeHolder"]
      val get_password: t -> bool [@@js.get "password"]
      val set_password: t -> bool -> unit [@@js.set "password"]
      val get_ignoreFocusOut: t -> bool [@@js.get "ignoreFocusOut"]
      val set_ignoreFocusOut: t -> bool -> unit [@@js.set "ignoreFocusOut"]
      val validateInput: t -> value:string -> string or_null_or_undefined _Thenable or_string or_null_or_undefined [@@js.call "validateInput"]
    end
    module[@js.scope "RelativePattern"] RelativePattern : sig
      type t = vscode_RelativePattern
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_base: t -> string [@@js.get "base"]
      val set_base: t -> string -> unit [@@js.set "base"]
      val get_pattern: t -> string [@@js.get "pattern"]
      val set_pattern: t -> string -> unit [@@js.set "pattern"]
      val create: base:(vscode_Uri, vscode_WorkspaceFolder) union2 or_string -> pattern:string -> t [@@js.create]
    end
    module GlobPattern : sig
      type t = vscode_GlobPattern
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "DocumentFilter"] DocumentFilter : sig
      type t = vscode_DocumentFilter
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_language: t -> string [@@js.get "language"]
      val get_scheme: t -> string [@@js.get "scheme"]
      val get_pattern: t -> vscode_GlobPattern [@@js.get "pattern"]
    end
    module DocumentSelector : sig
      type t = vscode_DocumentSelector
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ProviderResult : sig
      type 'T t = 'T vscode_ProviderResult
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    end
    module[@js.scope "CodeActionKind"] CodeActionKind : sig
      type t = vscode_CodeActionKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_Empty: unit -> t [@@js.get "Empty"]
      val get_QuickFix: unit -> t [@@js.get "QuickFix"]
      val get_Refactor: unit -> t [@@js.get "Refactor"]
      val get_RefactorExtract: unit -> t [@@js.get "RefactorExtract"]
      val get_RefactorInline: unit -> t [@@js.get "RefactorInline"]
      val get_RefactorRewrite: unit -> t [@@js.get "RefactorRewrite"]
      val get_Source: unit -> t [@@js.get "Source"]
      val get_SourceOrganizeImports: unit -> t [@@js.get "SourceOrganizeImports"]
      val get_SourceFixAll: unit -> t [@@js.get "SourceFixAll"]
      val create: value:string -> t [@@js.create]
      val get_value: t -> string [@@js.get "value"]
      val append: t -> parts:string -> t [@@js.call "append"]
      val intersects: t -> other:t -> bool [@@js.call "intersects"]
      val contains: t -> other:t -> bool [@@js.call "contains"]
    end
    module CodeActionTriggerKind : sig
      type t = vscode_CodeActionTriggerKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "CodeActionContext"] CodeActionContext : sig
      type t = vscode_CodeActionContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_triggerKind: t -> vscode_CodeActionTriggerKind [@@js.get "triggerKind"]
      val get_diagnostics: t -> vscode_Diagnostic list [@@js.get "diagnostics"]
      val get_only: t -> vscode_CodeActionKind [@@js.get "only"]
    end
    module[@js.scope "CodeAction"] CodeAction : sig
      type t = vscode_CodeAction
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_title: t -> string [@@js.get "title"]
      val set_title: t -> string -> unit [@@js.set "title"]
      val get_edit: t -> vscode_WorkspaceEdit [@@js.get "edit"]
      val set_edit: t -> vscode_WorkspaceEdit -> unit [@@js.set "edit"]
      val get_diagnostics: t -> vscode_Diagnostic list [@@js.get "diagnostics"]
      val set_diagnostics: t -> vscode_Diagnostic list -> unit [@@js.set "diagnostics"]
      val get_command: t -> vscode_Command [@@js.get "command"]
      val set_command: t -> vscode_Command -> unit [@@js.set "command"]
      val get_kind: t -> vscode_CodeActionKind [@@js.get "kind"]
      val set_kind: t -> vscode_CodeActionKind -> unit [@@js.set "kind"]
      val get_isPreferred: t -> bool [@@js.get "isPreferred"]
      val set_isPreferred: t -> bool -> unit [@@js.set "isPreferred"]
      val get_disabled: t -> anonymous_interface_24 [@@js.get "disabled"]
      val set_disabled: t -> anonymous_interface_24 -> unit [@@js.set "disabled"]
      val create: title:string -> ?kind:vscode_CodeActionKind -> unit -> t [@@js.create]
    end
    module[@js.scope "CodeActionProvider"] CodeActionProvider : sig
      type 'T t = 'T vscode_CodeActionProvider
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_CodeAction t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideCodeActions: 'T t -> document:vscode_TextDocument -> range:(vscode_Range, vscode_Selection) union2 -> context:vscode_CodeActionContext -> token:vscode_CancellationToken -> (vscode_Command, 'T) union2 list vscode_ProviderResult [@@js.call "provideCodeActions"]
      val resolveCodeAction: 'T t -> codeAction:'T -> token:vscode_CancellationToken -> 'T vscode_ProviderResult [@@js.call "resolveCodeAction"]
    end
    module[@js.scope "CodeActionProviderMetadata"] CodeActionProviderMetadata : sig
      type t = vscode_CodeActionProviderMetadata
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_providedCodeActionKinds: t -> vscode_CodeActionKind list [@@js.get "providedCodeActionKinds"]
      val get_documentation: t -> anonymous_interface_11 list [@@js.get "documentation"]
    end
    module[@js.scope "CodeLens"] CodeLens : sig
      type t = vscode_CodeLens
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val get_command: t -> vscode_Command [@@js.get "command"]
      val set_command: t -> vscode_Command -> unit [@@js.set "command"]
      val get_isResolved: t -> bool [@@js.get "isResolved"]
      val create: range:vscode_Range -> ?command:vscode_Command -> unit -> t [@@js.create]
    end
    module[@js.scope "CodeLensProvider"] CodeLensProvider : sig
      type 'T t = 'T vscode_CodeLensProvider
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_CodeLens t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidChangeCodeLenses: 'T t -> unit vscode_Event [@@js.get "onDidChangeCodeLenses"]
      val set_onDidChangeCodeLenses: 'T t -> unit vscode_Event -> unit [@@js.set "onDidChangeCodeLenses"]
      val provideCodeLenses: 'T t -> document:vscode_TextDocument -> token:vscode_CancellationToken -> 'T list vscode_ProviderResult [@@js.call "provideCodeLenses"]
      val resolveCodeLens: 'T t -> codeLens:'T -> token:vscode_CancellationToken -> 'T vscode_ProviderResult [@@js.call "resolveCodeLens"]
    end
    module DefinitionLink : sig
      type t = vscode_DefinitionLink
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Definition : sig
      type t = vscode_Definition
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "DefinitionProvider"] DefinitionProvider : sig
      type t = vscode_DefinitionProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideDefinition: t -> document:vscode_TextDocument -> position:vscode_Position -> token:vscode_CancellationToken -> (vscode_Definition, vscode_DefinitionLink) or_array vscode_ProviderResult [@@js.call "provideDefinition"]
    end
    module[@js.scope "ImplementationProvider"] ImplementationProvider : sig
      type t = vscode_ImplementationProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideImplementation: t -> document:vscode_TextDocument -> position:vscode_Position -> token:vscode_CancellationToken -> (vscode_Definition, vscode_DefinitionLink) or_array vscode_ProviderResult [@@js.call "provideImplementation"]
    end
    module[@js.scope "TypeDefinitionProvider"] TypeDefinitionProvider : sig
      type t = vscode_TypeDefinitionProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideTypeDefinition: t -> document:vscode_TextDocument -> position:vscode_Position -> token:vscode_CancellationToken -> (vscode_Definition, vscode_DefinitionLink) or_array vscode_ProviderResult [@@js.call "provideTypeDefinition"]
    end
    module Declaration : sig
      type t = vscode_Declaration
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "DeclarationProvider"] DeclarationProvider : sig
      type t = vscode_DeclarationProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideDeclaration: t -> document:vscode_TextDocument -> position:vscode_Position -> token:vscode_CancellationToken -> vscode_Declaration vscode_ProviderResult [@@js.call "provideDeclaration"]
    end
    module[@js.scope "MarkdownString"] MarkdownString : sig
      type t = vscode_MarkdownString
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_value: t -> string [@@js.get "value"]
      val set_value: t -> string -> unit [@@js.set "value"]
      val get_isTrusted: t -> bool [@@js.get "isTrusted"]
      val set_isTrusted: t -> bool -> unit [@@js.set "isTrusted"]
      val get_supportThemeIcons: t -> bool [@@js.get "supportThemeIcons"]
      val create: ?value:string -> ?supportThemeIcons:bool -> unit -> t [@@js.create]
      val appendText: t -> value:string -> t [@@js.call "appendText"]
      val appendMarkdown: t -> value:string -> t [@@js.call "appendMarkdown"]
      val appendCodeblock: t -> value:string -> ?language:string -> unit -> t [@@js.call "appendCodeblock"]
    end
    module MarkedString : sig
      type t = vscode_MarkedString
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "Hover"] Hover : sig
      type t = vscode_Hover
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_contents: t -> vscode_MarkedString list [@@js.get "contents"]
      val set_contents: t -> vscode_MarkedString list -> unit [@@js.set "contents"]
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val create: contents:(vscode_MarkedString, vscode_MarkedString) or_array -> ?range:vscode_Range -> unit -> t [@@js.create]
    end
    module[@js.scope "HoverProvider"] HoverProvider : sig
      type t = vscode_HoverProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideHover: t -> document:vscode_TextDocument -> position:vscode_Position -> token:vscode_CancellationToken -> vscode_Hover vscode_ProviderResult [@@js.call "provideHover"]
    end
    module[@js.scope "EvaluatableExpression"] EvaluatableExpression : sig
      type t = vscode_EvaluatableExpression
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_range: t -> vscode_Range [@@js.get "range"]
      val get_expression: t -> string [@@js.get "expression"]
      val create: range:vscode_Range -> ?expression:string -> unit -> t [@@js.create]
    end
    module[@js.scope "EvaluatableExpressionProvider"] EvaluatableExpressionProvider : sig
      type t = vscode_EvaluatableExpressionProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideEvaluatableExpression: t -> document:vscode_TextDocument -> position:vscode_Position -> token:vscode_CancellationToken -> vscode_EvaluatableExpression vscode_ProviderResult [@@js.call "provideEvaluatableExpression"]
    end
    module[@js.scope "InlineValueText"] InlineValueText : sig
      type t = vscode_InlineValueText
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_range: t -> vscode_Range [@@js.get "range"]
      val get_text: t -> string [@@js.get "text"]
      val create: range:vscode_Range -> text:string -> t [@@js.create]
    end
    module[@js.scope "InlineValueVariableLookup"] InlineValueVariableLookup : sig
      type t = vscode_InlineValueVariableLookup
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_range: t -> vscode_Range [@@js.get "range"]
      val get_variableName: t -> string [@@js.get "variableName"]
      val get_caseSensitiveLookup: t -> bool [@@js.get "caseSensitiveLookup"]
      val create: range:vscode_Range -> ?variableName:string -> ?caseSensitiveLookup:bool -> unit -> t [@@js.create]
    end
    module[@js.scope "InlineValueEvaluatableExpression"] InlineValueEvaluatableExpression : sig
      type t = vscode_InlineValueEvaluatableExpression
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_range: t -> vscode_Range [@@js.get "range"]
      val get_expression: t -> string [@@js.get "expression"]
      val create: range:vscode_Range -> ?expression:string -> unit -> t [@@js.create]
    end
    module InlineValue : sig
      type t = vscode_InlineValue
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "InlineValueContext"] InlineValueContext : sig
      type t = vscode_InlineValueContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_frameId: t -> float [@@js.get "frameId"]
      val get_stoppedLocation: t -> vscode_Range [@@js.get "stoppedLocation"]
    end
    module[@js.scope "InlineValuesProvider"] InlineValuesProvider : sig
      type t = vscode_InlineValuesProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidChangeInlineValues: t -> unit vscode_Event or_undefined [@@js.get "onDidChangeInlineValues"]
      val set_onDidChangeInlineValues: t -> unit vscode_Event or_undefined -> unit [@@js.set "onDidChangeInlineValues"]
      val provideInlineValues: t -> document:vscode_TextDocument -> viewPort:vscode_Range -> context:vscode_InlineValueContext -> token:vscode_CancellationToken -> vscode_InlineValue list vscode_ProviderResult [@@js.call "provideInlineValues"]
    end
    module DocumentHighlightKind : sig
      type t = vscode_DocumentHighlightKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "DocumentHighlight"] DocumentHighlight : sig
      type t = vscode_DocumentHighlight
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val get_kind: t -> vscode_DocumentHighlightKind [@@js.get "kind"]
      val set_kind: t -> vscode_DocumentHighlightKind -> unit [@@js.set "kind"]
      val create: range:vscode_Range -> ?kind:vscode_DocumentHighlightKind -> unit -> t [@@js.create]
    end
    module[@js.scope "DocumentHighlightProvider"] DocumentHighlightProvider : sig
      type t = vscode_DocumentHighlightProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideDocumentHighlights: t -> document:vscode_TextDocument -> position:vscode_Position -> token:vscode_CancellationToken -> vscode_DocumentHighlight list vscode_ProviderResult [@@js.call "provideDocumentHighlights"]
    end
    module SymbolKind : sig
      type t = vscode_SymbolKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module SymbolTag : sig
      type t = vscode_SymbolTag
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "SymbolInformation"] SymbolInformation : sig
      type t = vscode_SymbolInformation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_containerName: t -> string [@@js.get "containerName"]
      val set_containerName: t -> string -> unit [@@js.set "containerName"]
      val get_kind: t -> vscode_SymbolKind [@@js.get "kind"]
      val set_kind: t -> vscode_SymbolKind -> unit [@@js.set "kind"]
      val get_tags: t -> vscode_SymbolTag list [@@js.get "tags"]
      val set_tags: t -> vscode_SymbolTag list -> unit [@@js.set "tags"]
      val get_location: t -> vscode_Location [@@js.get "location"]
      val set_location: t -> vscode_Location -> unit [@@js.set "location"]
      val create: name:string -> kind:vscode_SymbolKind -> containerName:string -> location:vscode_Location -> t [@@js.create]
      val create': name:string -> kind:vscode_SymbolKind -> range:vscode_Range -> ?uri:vscode_Uri -> ?containerName:string -> unit -> t [@@js.create]
    end
    module[@js.scope "DocumentSymbol"] DocumentSymbol : sig
      type t = vscode_DocumentSymbol
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_detail: t -> string [@@js.get "detail"]
      val set_detail: t -> string -> unit [@@js.set "detail"]
      val get_kind: t -> vscode_SymbolKind [@@js.get "kind"]
      val set_kind: t -> vscode_SymbolKind -> unit [@@js.set "kind"]
      val get_tags: t -> vscode_SymbolTag list [@@js.get "tags"]
      val set_tags: t -> vscode_SymbolTag list -> unit [@@js.set "tags"]
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val get_selectionRange: t -> vscode_Range [@@js.get "selectionRange"]
      val set_selectionRange: t -> vscode_Range -> unit [@@js.set "selectionRange"]
      val get_children: t -> t list [@@js.get "children"]
      val set_children: t -> t list -> unit [@@js.set "children"]
      val create: name:string -> detail:string -> kind:vscode_SymbolKind -> range:vscode_Range -> selectionRange:vscode_Range -> t [@@js.create]
    end
    module[@js.scope "DocumentSymbolProvider"] DocumentSymbolProvider : sig
      type t = vscode_DocumentSymbolProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideDocumentSymbols: t -> document:vscode_TextDocument -> token:vscode_CancellationToken -> ([`U_n_0 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 0] | `U_n_1 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 1] | `U_n_2 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 2] | `U_n_3 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 3] | `U_n_4 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 4] | `U_n_5 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 5] | `U_n_6 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 6] | `U_n_7 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 7] | `U_n_8 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 8] | `U_n_9 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 9] | `U_n_10 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 10] | `U_n_11 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 11] | `U_n_12 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 12] | `U_n_13 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 13] | `U_n_14 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 14] | `U_n_15 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 15] | `U_n_16 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 16] | `U_n_17 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 17] | `U_n_18 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 18] | `U_n_19 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 19] | `U_n_20 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 20] | `U_n_21 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 21] | `U_n_22 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 22] | `U_n_23 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 23] | `U_n_24 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 24] | `U_n_25 of (vscode_DocumentSymbol, vscode_SymbolInformation) union2 [@js 25]] [@js.union on_field "kind"]) list vscode_ProviderResult [@@js.call "provideDocumentSymbols"]
    end
    module[@js.scope "DocumentSymbolProviderMetadata"] DocumentSymbolProviderMetadata : sig
      type t = vscode_DocumentSymbolProviderMetadata
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
    end
    module[@js.scope "WorkspaceSymbolProvider"] WorkspaceSymbolProvider : sig
      type 'T t = 'T vscode_WorkspaceSymbolProvider
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_SymbolInformation t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideWorkspaceSymbols: 'T t -> query:string -> token:vscode_CancellationToken -> 'T list vscode_ProviderResult [@@js.call "provideWorkspaceSymbols"]
      val resolveWorkspaceSymbol: 'T t -> symbol:'T -> token:vscode_CancellationToken -> 'T vscode_ProviderResult [@@js.call "resolveWorkspaceSymbol"]
    end
    module[@js.scope "ReferenceContext"] ReferenceContext : sig
      type t = vscode_ReferenceContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_includeDeclaration: t -> bool [@@js.get "includeDeclaration"]
      val set_includeDeclaration: t -> bool -> unit [@@js.set "includeDeclaration"]
    end
    module[@js.scope "ReferenceProvider"] ReferenceProvider : sig
      type t = vscode_ReferenceProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideReferences: t -> document:vscode_TextDocument -> position:vscode_Position -> context:vscode_ReferenceContext -> token:vscode_CancellationToken -> vscode_Location list vscode_ProviderResult [@@js.call "provideReferences"]
    end
    module[@js.scope "TextEdit"] TextEdit : sig
      type t = vscode_TextEdit
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val replace: range:vscode_Range -> newText:string -> t [@@js.global "replace"]
      val insert: position:vscode_Position -> newText:string -> t [@@js.global "insert"]
      val delete: range:vscode_Range -> t [@@js.global "delete"]
      val setEndOfLine: eol:vscode_EndOfLine -> t [@@js.global "setEndOfLine"]
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val get_newText: t -> string [@@js.get "newText"]
      val set_newText: t -> string -> unit [@@js.set "newText"]
      val get_newEol: t -> vscode_EndOfLine [@@js.get "newEol"]
      val set_newEol: t -> vscode_EndOfLine -> unit [@@js.set "newEol"]
      val create: range:vscode_Range -> newText:string -> t [@@js.create]
    end
    module[@js.scope "WorkspaceEditEntryMetadata"] WorkspaceEditEntryMetadata : sig
      type t = vscode_WorkspaceEditEntryMetadata
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_needsConfirmation: t -> bool [@@js.get "needsConfirmation"]
      val set_needsConfirmation: t -> bool -> unit [@@js.set "needsConfirmation"]
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_description: t -> string [@@js.get "description"]
      val set_description: t -> string -> unit [@@js.set "description"]
      val get_iconPath: t -> (vscode_ThemeIcon, vscode_Uri, anonymous_interface_14) union3 [@@js.get "iconPath"]
      val set_icon_path: t -> (vscode_ThemeIcon, vscode_Uri, anonymous_interface_14) union3 -> unit [@@js.set "iconPath"]
    end
    module[@js.scope "WorkspaceEdit"] WorkspaceEdit : sig
      type t = vscode_WorkspaceEdit
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_size: t -> float [@@js.get "size"]
      val replace: t -> uri:vscode_Uri -> range:vscode_Range -> newText:string -> ?metadata:vscode_WorkspaceEditEntryMetadata -> unit -> unit [@@js.call "replace"]
      val insert: t -> uri:vscode_Uri -> position:vscode_Position -> newText:string -> ?metadata:vscode_WorkspaceEditEntryMetadata -> unit -> unit [@@js.call "insert"]
      val delete: t -> uri:vscode_Uri -> range:vscode_Range -> ?metadata:vscode_WorkspaceEditEntryMetadata -> unit -> unit [@@js.call "delete"]
      val has: t -> uri:vscode_Uri -> bool [@@js.call "has"]
      val set_: t -> uri:vscode_Uri -> edits:vscode_TextEdit list -> unit [@@js.call "set"]
      val get_: t -> uri:vscode_Uri -> vscode_TextEdit list [@@js.call "get"]
      val createFile: t -> uri:vscode_Uri -> ?options:anonymous_interface_22 -> ?metadata:vscode_WorkspaceEditEntryMetadata -> unit -> unit [@@js.call "createFile"]
      val deleteFile: t -> uri:vscode_Uri -> ?options:anonymous_interface_27 -> ?metadata:vscode_WorkspaceEditEntryMetadata -> unit -> unit [@@js.call "deleteFile"]
      val renameFile: t -> oldUri:vscode_Uri -> newUri:vscode_Uri -> ?options:anonymous_interface_22 -> ?metadata:vscode_WorkspaceEditEntryMetadata -> unit -> unit [@@js.call "renameFile"]
      val entries: t -> (vscode_Uri * vscode_TextEdit list) list [@@js.call "entries"]
    end
    module[@js.scope "SnippetString"] SnippetString : sig
      type t = vscode_SnippetString
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_value: t -> string [@@js.get "value"]
      val set_value: t -> string -> unit [@@js.set "value"]
      val create: ?value:string -> unit -> t [@@js.create]
      val appendText: t -> string:string -> t [@@js.call "appendText"]
      val appendTabstop: t -> ?number:float -> unit -> t [@@js.call "appendTabstop"]
      val appendPlaceholder: t -> value:(snippet:t -> any) or_string -> ?number:float -> unit -> t [@@js.call "appendPlaceholder"]
      val appendChoice: t -> values:string list -> ?number:float -> unit -> t [@@js.call "appendChoice"]
      val appendVariable: t -> name:string -> defaultValue:(snippet:t -> any) or_string -> t [@@js.call "appendVariable"]
    end
    module[@js.scope "RenameProvider"] RenameProvider : sig
      type t = vscode_RenameProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideRenameEdits: t -> document:vscode_TextDocument -> position:vscode_Position -> newName:string -> token:vscode_CancellationToken -> vscode_WorkspaceEdit vscode_ProviderResult [@@js.call "provideRenameEdits"]
      val prepareRename: t -> document:vscode_TextDocument -> position:vscode_Position -> token:vscode_CancellationToken -> (vscode_Range, anonymous_interface_23) union2 vscode_ProviderResult [@@js.call "prepareRename"]
    end
    module[@js.scope "SemanticTokensLegend"] SemanticTokensLegend : sig
      type t = vscode_SemanticTokensLegend
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_tokenTypes: t -> string list [@@js.get "tokenTypes"]
      val get_tokenModifiers: t -> string list [@@js.get "tokenModifiers"]
      val create: tokenTypes:string list -> ?tokenModifiers:string list -> unit -> t [@@js.create]
    end
    module[@js.scope "SemanticTokensBuilder"] SemanticTokensBuilder : sig
      type t = vscode_SemanticTokensBuilder
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: ?legend:vscode_SemanticTokensLegend -> unit -> t [@@js.create]
      val push: t -> line:float -> char:float -> length:float -> tokenType:float -> ?tokenModifiers:float -> unit -> unit [@@js.call "push"]
      val push': t -> range:vscode_Range -> tokenType:string -> ?tokenModifiers:string list -> unit -> unit [@@js.call "push"]
      val build: t -> ?resultId:string -> unit -> vscode_SemanticTokens [@@js.call "build"]
    end
    module[@js.scope "SemanticTokens"] SemanticTokens : sig
      type t = vscode_SemanticTokens
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_resultId: t -> string [@@js.get "resultId"]
      val get_data: t -> Uint32Array.t_0 [@@js.get "data"]
      val create: data:Uint32Array.t_0 -> ?resultId:string -> unit -> t [@@js.create]
    end
    module[@js.scope "SemanticTokensEdits"] SemanticTokensEdits : sig
      type t = vscode_SemanticTokensEdits
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_resultId: t -> string [@@js.get "resultId"]
      val get_edits: t -> vscode_SemanticTokensEdit list [@@js.get "edits"]
      val create: edits:vscode_SemanticTokensEdit list -> ?resultId:string -> unit -> t [@@js.create]
    end
    module[@js.scope "SemanticTokensEdit"] SemanticTokensEdit : sig
      type t = vscode_SemanticTokensEdit
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_start: t -> float [@@js.get "start"]
      val get_deleteCount: t -> float [@@js.get "deleteCount"]
      val get_data: t -> Uint32Array.t_0 [@@js.get "data"]
      val create: start:float -> deleteCount:float -> ?data:Uint32Array.t_0 -> unit -> t [@@js.create]
    end
    module[@js.scope "DocumentSemanticTokensProvider"] DocumentSemanticTokensProvider : sig
      type t = vscode_DocumentSemanticTokensProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidChangeSemanticTokens: t -> unit vscode_Event [@@js.get "onDidChangeSemanticTokens"]
      val set_onDidChangeSemanticTokens: t -> unit vscode_Event -> unit [@@js.set "onDidChangeSemanticTokens"]
      val provideDocumentSemanticTokens: t -> document:vscode_TextDocument -> token:vscode_CancellationToken -> vscode_SemanticTokens vscode_ProviderResult [@@js.call "provideDocumentSemanticTokens"]
      val provideDocumentSemanticTokensEdits: t -> document:vscode_TextDocument -> previousResultId:string -> token:vscode_CancellationToken -> (vscode_SemanticTokens, vscode_SemanticTokensEdits) union2 vscode_ProviderResult [@@js.call "provideDocumentSemanticTokensEdits"]
    end
    module[@js.scope "DocumentRangeSemanticTokensProvider"] DocumentRangeSemanticTokensProvider : sig
      type t = vscode_DocumentRangeSemanticTokensProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideDocumentRangeSemanticTokens: t -> document:vscode_TextDocument -> range:vscode_Range -> token:vscode_CancellationToken -> vscode_SemanticTokens vscode_ProviderResult [@@js.call "provideDocumentRangeSemanticTokens"]
    end
    module[@js.scope "FormattingOptions"] FormattingOptions : sig
      type t = vscode_FormattingOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_tabSize: t -> float [@@js.get "tabSize"]
      val set_tabSize: t -> float -> unit [@@js.set "tabSize"]
      val get_insertSpaces: t -> bool [@@js.get "insertSpaces"]
      val set_insertSpaces: t -> bool -> unit [@@js.set "insertSpaces"]
      val get: t -> string -> bool or_string or_number [@@js.index_get]
      val set: t -> string -> bool or_string or_number -> unit [@@js.index_set]
    end
    module[@js.scope "DocumentFormattingEditProvider"] DocumentFormattingEditProvider : sig
      type t = vscode_DocumentFormattingEditProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideDocumentFormattingEdits: t -> document:vscode_TextDocument -> options:vscode_FormattingOptions -> token:vscode_CancellationToken -> vscode_TextEdit list vscode_ProviderResult [@@js.call "provideDocumentFormattingEdits"]
    end
    module[@js.scope "DocumentRangeFormattingEditProvider"] DocumentRangeFormattingEditProvider : sig
      type t = vscode_DocumentRangeFormattingEditProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideDocumentRangeFormattingEdits: t -> document:vscode_TextDocument -> range:vscode_Range -> options:vscode_FormattingOptions -> token:vscode_CancellationToken -> vscode_TextEdit list vscode_ProviderResult [@@js.call "provideDocumentRangeFormattingEdits"]
    end
    module[@js.scope "OnTypeFormattingEditProvider"] OnTypeFormattingEditProvider : sig
      type t = vscode_OnTypeFormattingEditProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideOnTypeFormattingEdits: t -> document:vscode_TextDocument -> position:vscode_Position -> ch:string -> options:vscode_FormattingOptions -> token:vscode_CancellationToken -> vscode_TextEdit list vscode_ProviderResult [@@js.call "provideOnTypeFormattingEdits"]
    end
    module[@js.scope "ParameterInformation"] ParameterInformation : sig
      type t = vscode_ParameterInformation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_label: t -> (float * float) or_string [@@js.get "label"]
      val set_label: t -> (float * float) or_string -> unit [@@js.set "label"]
      val get_documentation: t -> vscode_MarkdownString or_string [@@js.get "documentation"]
      val set_documentation: t -> vscode_MarkdownString or_string -> unit [@@js.set "documentation"]
      val create: label:(float * float) or_string -> ?documentation:vscode_MarkdownString or_string -> unit -> t [@@js.create]
    end
    module[@js.scope "SignatureInformation"] SignatureInformation : sig
      type t = vscode_SignatureInformation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_documentation: t -> vscode_MarkdownString or_string [@@js.get "documentation"]
      val set_documentation: t -> vscode_MarkdownString or_string -> unit [@@js.set "documentation"]
      val get_parameters: t -> vscode_ParameterInformation list [@@js.get "parameters"]
      val set_parameters: t -> vscode_ParameterInformation list -> unit [@@js.set "parameters"]
      val get_activeParameter: t -> float [@@js.get "activeParameter"]
      val set_activeParameter: t -> float -> unit [@@js.set "activeParameter"]
      val create: label:string -> ?documentation:vscode_MarkdownString or_string -> unit -> t [@@js.create]
    end
    module[@js.scope "SignatureHelp"] SignatureHelp : sig
      type t = vscode_SignatureHelp
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_signatures: t -> vscode_SignatureInformation list [@@js.get "signatures"]
      val set_signatures: t -> vscode_SignatureInformation list -> unit [@@js.set "signatures"]
      val get_activeSignature: t -> float [@@js.get "activeSignature"]
      val set_activeSignature: t -> float -> unit [@@js.set "activeSignature"]
      val get_activeParameter: t -> float [@@js.get "activeParameter"]
      val set_activeParameter: t -> float -> unit [@@js.set "activeParameter"]
    end
    module SignatureHelpTriggerKind : sig
      type t = vscode_SignatureHelpTriggerKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "SignatureHelpContext"] SignatureHelpContext : sig
      type t = vscode_SignatureHelpContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_triggerKind: t -> vscode_SignatureHelpTriggerKind [@@js.get "triggerKind"]
      val get_triggerCharacter: t -> string [@@js.get "triggerCharacter"]
      val get_isRetrigger: t -> bool [@@js.get "isRetrigger"]
      val get_activeSignatureHelp: t -> vscode_SignatureHelp [@@js.get "activeSignatureHelp"]
    end
    module[@js.scope "SignatureHelpProvider"] SignatureHelpProvider : sig
      type t = vscode_SignatureHelpProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideSignatureHelp: t -> document:vscode_TextDocument -> position:vscode_Position -> token:vscode_CancellationToken -> context:vscode_SignatureHelpContext -> vscode_SignatureHelp vscode_ProviderResult [@@js.call "provideSignatureHelp"]
    end
    module[@js.scope "SignatureHelpProviderMetadata"] SignatureHelpProviderMetadata : sig
      type t = vscode_SignatureHelpProviderMetadata
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_triggerCharacters: t -> string list [@@js.get "triggerCharacters"]
      val get_retriggerCharacters: t -> string list [@@js.get "retriggerCharacters"]
    end
    module CompletionItemKind : sig
      type t = vscode_CompletionItemKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module CompletionItemTag : sig
      type t = vscode_CompletionItemTag
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "CompletionItem"] CompletionItem : sig
      type t = vscode_CompletionItem
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_kind: t -> vscode_CompletionItemKind [@@js.get "kind"]
      val set_kind: t -> vscode_CompletionItemKind -> unit [@@js.set "kind"]
      val get_tags: t -> vscode_CompletionItemTag list [@@js.get "tags"]
      val set_tags: t -> vscode_CompletionItemTag list -> unit [@@js.set "tags"]
      val get_detail: t -> string [@@js.get "detail"]
      val set_detail: t -> string -> unit [@@js.set "detail"]
      val get_documentation: t -> vscode_MarkdownString or_string [@@js.get "documentation"]
      val set_documentation: t -> vscode_MarkdownString or_string -> unit [@@js.set "documentation"]
      val get_sortText: t -> string [@@js.get "sortText"]
      val set_sortText: t -> string -> unit [@@js.set "sortText"]
      val get_filterText: t -> string [@@js.get "filterText"]
      val set_filterText: t -> string -> unit [@@js.set "filterText"]
      val get_preselect: t -> bool [@@js.get "preselect"]
      val set_preselect: t -> bool -> unit [@@js.set "preselect"]
      val get_insertText: t -> vscode_SnippetString or_string [@@js.get "insertText"]
      val set_insertText: t -> vscode_SnippetString or_string -> unit [@@js.set "insertText"]
      val get_range: t -> (vscode_Range, anonymous_interface_8) union2 [@@js.get "range"]
      val set_range: t -> (vscode_Range, anonymous_interface_8) union2 -> unit [@@js.set "range"]
      val get_commitCharacters: t -> string list [@@js.get "commitCharacters"]
      val set_commitCharacters: t -> string list -> unit [@@js.set "commitCharacters"]
      val get_keepWhitespace: t -> bool [@@js.get "keepWhitespace"]
      val set_keepWhitespace: t -> bool -> unit [@@js.set "keepWhitespace"]
      val get_textEdit: t -> vscode_TextEdit [@@js.get "textEdit"]
      val set_textEdit: t -> vscode_TextEdit -> unit [@@js.set "textEdit"]
      val get_additionalTextEdits: t -> vscode_TextEdit list [@@js.get "additionalTextEdits"]
      val set_additionalTextEdits: t -> vscode_TextEdit list -> unit [@@js.set "additionalTextEdits"]
      val get_command: t -> vscode_Command [@@js.get "command"]
      val set_command: t -> vscode_Command -> unit [@@js.set "command"]
      val create: label:string -> ?kind:vscode_CompletionItemKind -> unit -> t [@@js.create]
    end
    module[@js.scope "CompletionList"] CompletionList : sig
      type 'T t = 'T vscode_CompletionList
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_CompletionItem t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_isIncomplete: 'T t -> bool [@@js.get "isIncomplete"]
      val set_isIncomplete: 'T t -> bool -> unit [@@js.set "isIncomplete"]
      val get_items: 'T t -> 'T list [@@js.get "items"]
      val set_items: 'T t -> 'T list -> unit [@@js.set "items"]
      val create: ?items:'T list -> ?isIncomplete:bool -> unit -> 'T t [@@js.create]
    end
    module CompletionTriggerKind : sig
      type t = vscode_CompletionTriggerKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "CompletionContext"] CompletionContext : sig
      type t = vscode_CompletionContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_triggerKind: t -> vscode_CompletionTriggerKind [@@js.get "triggerKind"]
      val get_triggerCharacter: t -> string [@@js.get "triggerCharacter"]
    end
    module[@js.scope "CompletionItemProvider"] CompletionItemProvider : sig
      type 'T t = 'T vscode_CompletionItemProvider
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_CompletionItem t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideCompletionItems: 'T t -> document:vscode_TextDocument -> position:vscode_Position -> token:vscode_CancellationToken -> context:vscode_CompletionContext -> ('T vscode_CompletionList, 'T) or_array vscode_ProviderResult [@@js.call "provideCompletionItems"]
      val resolveCompletionItem: 'T t -> item:'T -> token:vscode_CancellationToken -> 'T vscode_ProviderResult [@@js.call "resolveCompletionItem"]
    end
    module[@js.scope "DocumentLink"] DocumentLink : sig
      type t = vscode_DocumentLink
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val get_target: t -> vscode_Uri [@@js.get "target"]
      val set_target: t -> vscode_Uri -> unit [@@js.set "target"]
      val get_tooltip: t -> string [@@js.get "tooltip"]
      val set_tooltip: t -> string -> unit [@@js.set "tooltip"]
      val create: range:vscode_Range -> ?target:vscode_Uri -> unit -> t [@@js.create]
    end
    module[@js.scope "DocumentLinkProvider"] DocumentLinkProvider : sig
      type 'T t = 'T vscode_DocumentLinkProvider
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_DocumentLink t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideDocumentLinks: 'T t -> document:vscode_TextDocument -> token:vscode_CancellationToken -> 'T list vscode_ProviderResult [@@js.call "provideDocumentLinks"]
      val resolveDocumentLink: 'T t -> link:'T -> token:vscode_CancellationToken -> 'T vscode_ProviderResult [@@js.call "resolveDocumentLink"]
    end
    module[@js.scope "Color"] Color : sig
      type t = vscode_Color
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_red: t -> float [@@js.get "red"]
      val get_green: t -> float [@@js.get "green"]
      val get_blue: t -> float [@@js.get "blue"]
      val get_alpha: t -> float [@@js.get "alpha"]
      val create: red:float -> green:float -> blue:float -> alpha:float -> t [@@js.create]
    end
    module[@js.scope "ColorInformation"] ColorInformation : sig
      type t = vscode_ColorInformation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val get_color: t -> vscode_Color [@@js.get "color"]
      val set_color: t -> vscode_Color -> unit [@@js.set "color"]
      val create: range:vscode_Range -> color:vscode_Color -> t [@@js.create]
    end
    module[@js.scope "ColorPresentation"] ColorPresentation : sig
      type t = vscode_ColorPresentation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_textEdit: t -> vscode_TextEdit [@@js.get "textEdit"]
      val set_textEdit: t -> vscode_TextEdit -> unit [@@js.set "textEdit"]
      val get_additionalTextEdits: t -> vscode_TextEdit list [@@js.get "additionalTextEdits"]
      val set_additionalTextEdits: t -> vscode_TextEdit list -> unit [@@js.set "additionalTextEdits"]
      val create: label:string -> t [@@js.create]
    end
    module[@js.scope "DocumentColorProvider"] DocumentColorProvider : sig
      type t = vscode_DocumentColorProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideDocumentColors: t -> document:vscode_TextDocument -> token:vscode_CancellationToken -> vscode_ColorInformation list vscode_ProviderResult [@@js.call "provideDocumentColors"]
      val provideColorPresentations: t -> color:vscode_Color -> context:anonymous_interface_6 -> token:vscode_CancellationToken -> vscode_ColorPresentation list vscode_ProviderResult [@@js.call "provideColorPresentations"]
    end
    module[@js.scope "FoldingRange"] FoldingRange : sig
      type t = vscode_FoldingRange
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_start: t -> float [@@js.get "start"]
      val set_start: t -> float -> unit [@@js.set "start"]
      val get_end: t -> float [@@js.get "end"]
      val set_end: t -> float -> unit [@@js.set "end"]
      val get_kind: t -> vscode_FoldingRangeKind [@@js.get "kind"]
      val set_kind: t -> vscode_FoldingRangeKind -> unit [@@js.set "kind"]
      val create: start:float -> end_:float -> ?kind:vscode_FoldingRangeKind -> unit -> t [@@js.create]
    end
    module FoldingRangeKind : sig
      type t = vscode_FoldingRangeKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module FoldingContext : sig
      type t = vscode_FoldingContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "FoldingRangeProvider"] FoldingRangeProvider : sig
      type t = vscode_FoldingRangeProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidChangeFoldingRanges: t -> unit vscode_Event [@@js.get "onDidChangeFoldingRanges"]
      val set_onDidChangeFoldingRanges: t -> unit vscode_Event -> unit [@@js.set "onDidChangeFoldingRanges"]
      val provideFoldingRanges: t -> document:vscode_TextDocument -> context:vscode_FoldingContext -> token:vscode_CancellationToken -> vscode_FoldingRange list vscode_ProviderResult [@@js.call "provideFoldingRanges"]
    end
    module[@js.scope "SelectionRange"] SelectionRange : sig
      type t = vscode_SelectionRange
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val get_parent: t -> t [@@js.get "parent"]
      val set_parent: t -> t -> unit [@@js.set "parent"]
      val create: range:vscode_Range -> ?parent:t -> unit -> t [@@js.create]
    end
    module[@js.scope "SelectionRangeProvider"] SelectionRangeProvider : sig
      type t = vscode_SelectionRangeProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideSelectionRanges: t -> document:vscode_TextDocument -> positions:vscode_Position list -> token:vscode_CancellationToken -> vscode_SelectionRange list vscode_ProviderResult [@@js.call "provideSelectionRanges"]
    end
    module[@js.scope "CallHierarchyItem"] CallHierarchyItem : sig
      type t = vscode_CallHierarchyItem
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_kind: t -> vscode_SymbolKind [@@js.get "kind"]
      val set_kind: t -> vscode_SymbolKind -> unit [@@js.set "kind"]
      val get_tags: t -> vscode_SymbolTag list [@@js.get "tags"]
      val set_tags: t -> vscode_SymbolTag list -> unit [@@js.set "tags"]
      val get_detail: t -> string [@@js.get "detail"]
      val set_detail: t -> string -> unit [@@js.set "detail"]
      val get_uri: t -> vscode_Uri [@@js.get "uri"]
      val set_uri: t -> vscode_Uri -> unit [@@js.set "uri"]
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val get_selectionRange: t -> vscode_Range [@@js.get "selectionRange"]
      val set_selectionRange: t -> vscode_Range -> unit [@@js.set "selectionRange"]
      val create: kind:vscode_SymbolKind -> name:string -> detail:string -> uri:vscode_Uri -> range:vscode_Range -> selectionRange:vscode_Range -> t [@@js.create]
    end
    module[@js.scope "CallHierarchyIncomingCall"] CallHierarchyIncomingCall : sig
      type t = vscode_CallHierarchyIncomingCall
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_from: t -> vscode_CallHierarchyItem [@@js.get "from"]
      val set_from: t -> vscode_CallHierarchyItem -> unit [@@js.set "from"]
      val get_fromRanges: t -> vscode_Range list [@@js.get "fromRanges"]
      val set_fromRanges: t -> vscode_Range list -> unit [@@js.set "fromRanges"]
      val create: item:vscode_CallHierarchyItem -> fromRanges:vscode_Range list -> t [@@js.create]
    end
    module[@js.scope "CallHierarchyOutgoingCall"] CallHierarchyOutgoingCall : sig
      type t = vscode_CallHierarchyOutgoingCall
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_to: t -> vscode_CallHierarchyItem [@@js.get "to"]
      val set_to: t -> vscode_CallHierarchyItem -> unit [@@js.set "to"]
      val get_fromRanges: t -> vscode_Range list [@@js.get "fromRanges"]
      val set_fromRanges: t -> vscode_Range list -> unit [@@js.set "fromRanges"]
      val create: item:vscode_CallHierarchyItem -> fromRanges:vscode_Range list -> t [@@js.create]
    end
    module[@js.scope "CallHierarchyProvider"] CallHierarchyProvider : sig
      type t = vscode_CallHierarchyProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val prepareCallHierarchy: t -> document:vscode_TextDocument -> position:vscode_Position -> token:vscode_CancellationToken -> (vscode_CallHierarchyItem, vscode_CallHierarchyItem) or_array vscode_ProviderResult [@@js.call "prepareCallHierarchy"]
      val provideCallHierarchyIncomingCalls: t -> item:vscode_CallHierarchyItem -> token:vscode_CancellationToken -> vscode_CallHierarchyIncomingCall list vscode_ProviderResult [@@js.call "provideCallHierarchyIncomingCalls"]
      val provideCallHierarchyOutgoingCalls: t -> item:vscode_CallHierarchyItem -> token:vscode_CancellationToken -> vscode_CallHierarchyOutgoingCall list vscode_ProviderResult [@@js.call "provideCallHierarchyOutgoingCalls"]
    end
    module[@js.scope "LinkedEditingRanges"] LinkedEditingRanges : sig
      type t = vscode_LinkedEditingRanges
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: ranges:vscode_Range list -> ?wordPattern:regexp -> unit -> t [@@js.create]
      val get_ranges: t -> vscode_Range list [@@js.get "ranges"]
      val get_wordPattern: t -> regexp [@@js.get "wordPattern"]
    end
    module[@js.scope "LinkedEditingRangeProvider"] LinkedEditingRangeProvider : sig
      type t = vscode_LinkedEditingRangeProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideLinkedEditingRanges: t -> document:vscode_TextDocument -> position:vscode_Position -> token:vscode_CancellationToken -> vscode_LinkedEditingRanges vscode_ProviderResult [@@js.call "provideLinkedEditingRanges"]
    end
    module CharacterPair : sig
      type t = vscode_CharacterPair
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "CommentRule"] CommentRule : sig
      type t = vscode_CommentRule
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_lineComment: t -> string [@@js.get "lineComment"]
      val set_lineComment: t -> string -> unit [@@js.set "lineComment"]
      val get_blockComment: t -> vscode_CharacterPair [@@js.get "blockComment"]
      val set_blockComment: t -> vscode_CharacterPair -> unit [@@js.set "blockComment"]
    end
    module[@js.scope "IndentationRule"] IndentationRule : sig
      type t = vscode_IndentationRule
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_decreaseIndentPattern: t -> regexp [@@js.get "decreaseIndentPattern"]
      val set_decreaseIndentPattern: t -> regexp -> unit [@@js.set "decreaseIndentPattern"]
      val get_increaseIndentPattern: t -> regexp [@@js.get "increaseIndentPattern"]
      val set_increaseIndentPattern: t -> regexp -> unit [@@js.set "increaseIndentPattern"]
      val get_indentNextLinePattern: t -> regexp [@@js.get "indentNextLinePattern"]
      val set_indentNextLinePattern: t -> regexp -> unit [@@js.set "indentNextLinePattern"]
      val get_unIndentedLinePattern: t -> regexp [@@js.get "unIndentedLinePattern"]
      val set_unIndentedLinePattern: t -> regexp -> unit [@@js.set "unIndentedLinePattern"]
    end
    module IndentAction : sig
      type t = vscode_IndentAction
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "EnterAction"] EnterAction : sig
      type t = vscode_EnterAction
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_indentAction: t -> vscode_IndentAction [@@js.get "indentAction"]
      val set_indentAction: t -> vscode_IndentAction -> unit [@@js.set "indentAction"]
      val get_appendText: t -> string [@@js.get "appendText"]
      val set_appendText: t -> string -> unit [@@js.set "appendText"]
      val get_removeText: t -> float [@@js.get "removeText"]
      val set_removeText: t -> float -> unit [@@js.set "removeText"]
    end
    module[@js.scope "OnEnterRule"] OnEnterRule : sig
      type t = vscode_OnEnterRule
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_beforeText: t -> regexp [@@js.get "beforeText"]
      val set_beforeText: t -> regexp -> unit [@@js.set "beforeText"]
      val get_afterText: t -> regexp [@@js.get "afterText"]
      val set_afterText: t -> regexp -> unit [@@js.set "afterText"]
      val get_previousLineText: t -> regexp [@@js.get "previousLineText"]
      val set_previousLineText: t -> regexp -> unit [@@js.set "previousLineText"]
      val get_action: t -> vscode_EnterAction [@@js.get "action"]
      val set_action: t -> vscode_EnterAction -> unit [@@js.set "action"]
    end
    module[@js.scope "LanguageConfiguration"] LanguageConfiguration : sig
      type t = vscode_LanguageConfiguration
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_comments: t -> vscode_CommentRule [@@js.get "comments"]
      val set_comments: t -> vscode_CommentRule -> unit [@@js.set "comments"]
      val get_brackets: t -> vscode_CharacterPair list [@@js.get "brackets"]
      val set_brackets: t -> vscode_CharacterPair list -> unit [@@js.set "brackets"]
      val get_wordPattern: t -> regexp [@@js.get "wordPattern"]
      val set_wordPattern: t -> regexp -> unit [@@js.set "wordPattern"]
      val get_indentationRules: t -> vscode_IndentationRule [@@js.get "indentationRules"]
      val set_indentationRules: t -> vscode_IndentationRule -> unit [@@js.set "indentationRules"]
      val get_onEnterRules: t -> vscode_OnEnterRule list [@@js.get "onEnterRules"]
      val set_onEnterRules: t -> vscode_OnEnterRule list -> unit [@@js.set "onEnterRules"]
      val get___electricCharacterSupport: t -> anonymous_interface_1 [@@js.get "__electricCharacterSupport"]
      val set___electricCharacterSupport: t -> anonymous_interface_1 -> unit [@@js.set "__electricCharacterSupport"]
      val get___characterPairSupport: t -> anonymous_interface_0 [@@js.get "__characterPairSupport"]
      val set___characterPairSupport: t -> anonymous_interface_0 -> unit [@@js.set "__characterPairSupport"]
    end
    module ConfigurationTarget : sig
      type t = vscode_ConfigurationTarget
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "WorkspaceConfiguration"] WorkspaceConfiguration : sig
      type t = vscode_WorkspaceConfiguration
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_: t -> section:string -> 'T or_undefined [@@js.call "get"]
      val get_': t -> section:string -> defaultValue:'T -> 'T [@@js.call "get"]
      val has: t -> section:string -> bool [@@js.call "has"]
      val inspect: t -> section:string -> anonymous_interface_10 or_undefined [@@js.call "inspect"]
      val update: t -> section:string -> value:any -> ?configurationTarget:vscode_ConfigurationTarget or_boolean -> ?overrideInLanguage:bool -> unit -> unit _Thenable [@@js.call "update"]
      val get: t -> string -> any [@@js.index_get]
    end
    module[@js.scope "Location"] Location : sig
      type t = vscode_Location
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_uri: t -> vscode_Uri [@@js.get "uri"]
      val set_uri: t -> vscode_Uri -> unit [@@js.set "uri"]
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val create: uri:vscode_Uri -> rangeOrPosition:(vscode_Position, vscode_Range) union2 -> t [@@js.create]
    end
    module[@js.scope "LocationLink"] LocationLink : sig
      type t = vscode_LocationLink
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_originSelectionRange: t -> vscode_Range [@@js.get "originSelectionRange"]
      val set_originSelectionRange: t -> vscode_Range -> unit [@@js.set "originSelectionRange"]
      val get_targetUri: t -> vscode_Uri [@@js.get "targetUri"]
      val set_targetUri: t -> vscode_Uri -> unit [@@js.set "targetUri"]
      val get_targetRange: t -> vscode_Range [@@js.get "targetRange"]
      val set_targetRange: t -> vscode_Range -> unit [@@js.set "targetRange"]
      val get_targetSelectionRange: t -> vscode_Range [@@js.get "targetSelectionRange"]
      val set_targetSelectionRange: t -> vscode_Range -> unit [@@js.set "targetSelectionRange"]
    end
    module[@js.scope "DiagnosticChangeEvent"] DiagnosticChangeEvent : sig
      type t = vscode_DiagnosticChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_uris: t -> vscode_Uri list [@@js.get "uris"]
    end
    module DiagnosticSeverity : sig
      type t = vscode_DiagnosticSeverity
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "DiagnosticRelatedInformation"] DiagnosticRelatedInformation : sig
      type t = vscode_DiagnosticRelatedInformation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_location: t -> vscode_Location [@@js.get "location"]
      val set_location: t -> vscode_Location -> unit [@@js.set "location"]
      val get_message: t -> string [@@js.get "message"]
      val set_message: t -> string -> unit [@@js.set "message"]
      val create: location:vscode_Location -> message:string -> t [@@js.create]
    end
    module DiagnosticTag : sig
      type t = vscode_DiagnosticTag
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "Diagnostic"] Diagnostic : sig
      type t = vscode_Diagnostic
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val get_message: t -> string [@@js.get "message"]
      val set_message: t -> string -> unit [@@js.set "message"]
      val get_severity: t -> vscode_DiagnosticSeverity [@@js.get "severity"]
      val set_severity: t -> vscode_DiagnosticSeverity -> unit [@@js.set "severity"]
      val get_source: t -> string [@@js.get "source"]
      val set_source: t -> string -> unit [@@js.set "source"]
      val get_code: t -> anonymous_interface_37 or_string or_number [@@js.get "code"]
      val set_code: t -> anonymous_interface_37 or_string or_number -> unit [@@js.set "code"]
      val get_relatedInformation: t -> vscode_DiagnosticRelatedInformation list [@@js.get "relatedInformation"]
      val set_relatedInformation: t -> vscode_DiagnosticRelatedInformation list -> unit [@@js.set "relatedInformation"]
      val get_tags: t -> vscode_DiagnosticTag list [@@js.get "tags"]
      val set_tags: t -> vscode_DiagnosticTag list -> unit [@@js.set "tags"]
      val create: range:vscode_Range -> message:string -> ?severity:vscode_DiagnosticSeverity -> unit -> t [@@js.create]
    end
    module[@js.scope "DiagnosticCollection"] DiagnosticCollection : sig
      type t = vscode_DiagnosticCollection
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val set_: t -> uri:vscode_Uri -> diagnostics:vscode_Diagnostic list or_undefined -> unit [@@js.call "set"]
      val set_': t -> entries:(vscode_Uri * vscode_Diagnostic list or_undefined) list -> unit [@@js.call "set"]
      val delete: t -> uri:vscode_Uri -> unit [@@js.call "delete"]
      val clear: t -> unit [@@js.call "clear"]
      val forEach: t -> callback:(uri:vscode_Uri -> diagnostics:vscode_Diagnostic list -> collection:t -> any) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
      val get_: t -> uri:vscode_Uri -> vscode_Diagnostic list or_undefined [@@js.call "get"]
      val has: t -> uri:vscode_Uri -> bool [@@js.call "has"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module ViewColumn : sig
      type t = vscode_ViewColumn
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "OutputChannel"] OutputChannel : sig
      type t = vscode_OutputChannel
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val append: t -> value:string -> unit [@@js.call "append"]
      val appendLine: t -> value:string -> unit [@@js.call "appendLine"]
      val clear: t -> unit [@@js.call "clear"]
      val show: t -> ?preserveFocus:bool -> unit -> unit [@@js.call "show"]
      val show': t -> ?column:vscode_ViewColumn -> ?preserveFocus:bool -> unit -> unit [@@js.call "show"]
      val hide: t -> unit [@@js.call "hide"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "AccessibilityInformation"] AccessibilityInformation : sig
      type t = vscode_AccessibilityInformation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_role: t -> string [@@js.get "role"]
      val set_role: t -> string -> unit [@@js.set "role"]
    end
    module StatusBarAlignment : sig
      type t = vscode_StatusBarAlignment
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "StatusBarItem"] StatusBarItem : sig
      type t = vscode_StatusBarItem
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_alignment: t -> vscode_StatusBarAlignment [@@js.get "alignment"]
      val get_priority: t -> float [@@js.get "priority"]
      val get_text: t -> string [@@js.get "text"]
      val set_text: t -> string -> unit [@@js.set "text"]
      val get_tooltip: t -> string or_undefined [@@js.get "tooltip"]
      val set_tooltip: t -> string or_undefined -> unit [@@js.set "tooltip"]
      val get_color: t -> vscode_ThemeColor or_string or_undefined [@@js.get "color"]
      val set_color: t -> vscode_ThemeColor or_string or_undefined -> unit [@@js.set "color"]
      val get_backgroundColor: t -> vscode_ThemeColor or_undefined [@@js.get "backgroundColor"]
      val set_backgroundColor: t -> vscode_ThemeColor or_undefined -> unit [@@js.set "backgroundColor"]
      val get_command: t -> vscode_Command or_string or_undefined [@@js.get "command"]
      val set_command: t -> vscode_Command or_string or_undefined -> unit [@@js.set "command"]
      val get_accessibilityInformation: t -> vscode_AccessibilityInformation [@@js.get "accessibilityInformation"]
      val set_accessibilityInformation: t -> vscode_AccessibilityInformation -> unit [@@js.set "accessibilityInformation"]
      val show: t -> unit [@@js.call "show"]
      val hide: t -> unit [@@js.call "hide"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "Progress"] Progress : sig
      type 'T t = 'T vscode_Progress
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val report: 'T t -> value:'T -> unit [@@js.call "report"]
    end
    module[@js.scope "Terminal"] Terminal : sig
      type t = vscode_Terminal
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val get_processId: t -> float or_undefined _Thenable [@@js.get "processId"]
      val get_creationOptions: t -> (vscode_ExtensionTerminalOptions, vscode_TerminalOptions) union2 Readonly.t_1 [@@js.get "creationOptions"]
      val get_exitStatus: t -> vscode_TerminalExitStatus or_undefined [@@js.get "exitStatus"]
      val sendText: t -> text:string -> ?addNewLine:bool -> unit -> unit [@@js.call "sendText"]
      val show: t -> ?preserveFocus:bool -> unit -> unit [@@js.call "show"]
      val hide: t -> unit [@@js.call "hide"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "TerminalLinkContext"] TerminalLinkContext : sig
      type t = vscode_TerminalLinkContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_line: t -> string [@@js.get "line"]
      val set_line: t -> string -> unit [@@js.set "line"]
      val get_terminal: t -> vscode_Terminal [@@js.get "terminal"]
      val set_terminal: t -> vscode_Terminal -> unit [@@js.set "terminal"]
    end
    module[@js.scope "TerminalLinkProvider"] TerminalLinkProvider : sig
      type 'T t = 'T vscode_TerminalLinkProvider
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_TerminalLink t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideTerminalLinks: 'T t -> context:vscode_TerminalLinkContext -> token:vscode_CancellationToken -> 'T list vscode_ProviderResult [@@js.call "provideTerminalLinks"]
      val handleTerminalLink: 'T t -> link:'T -> unit vscode_ProviderResult [@@js.call "handleTerminalLink"]
    end
    module[@js.scope "TerminalLink"] TerminalLink : sig
      type t = vscode_TerminalLink
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_startIndex: t -> float [@@js.get "startIndex"]
      val set_startIndex: t -> float -> unit [@@js.set "startIndex"]
      val get_length: t -> float [@@js.get "length"]
      val set_length: t -> float -> unit [@@js.set "length"]
      val get_tooltip: t -> string [@@js.get "tooltip"]
      val set_tooltip: t -> string -> unit [@@js.set "tooltip"]
    end
    module[@js.scope "FileDecoration"] FileDecoration : sig
      type t = vscode_FileDecoration
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_badge: t -> string [@@js.get "badge"]
      val set_badge: t -> string -> unit [@@js.set "badge"]
      val get_tooltip: t -> string [@@js.get "tooltip"]
      val set_tooltip: t -> string -> unit [@@js.set "tooltip"]
      val get_color: t -> vscode_ThemeColor [@@js.get "color"]
      val set_color: t -> vscode_ThemeColor -> unit [@@js.set "color"]
      val get_propagate: t -> bool [@@js.get "propagate"]
      val set_propagate: t -> bool -> unit [@@js.set "propagate"]
      val create: ?badge:string -> ?tooltip:string -> ?color:vscode_ThemeColor -> unit -> t [@@js.create]
    end
    module[@js.scope "FileDecorationProvider"] FileDecorationProvider : sig
      type t = vscode_FileDecorationProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidChangeFileDecorations: t -> (vscode_Uri, vscode_Uri) or_array or_undefined vscode_Event [@@js.get "onDidChangeFileDecorations"]
      val set_onDidChangeFileDecorations: t -> (vscode_Uri, vscode_Uri) or_array or_undefined vscode_Event -> unit [@@js.set "onDidChangeFileDecorations"]
      val provideFileDecoration: t -> uri:vscode_Uri -> token:vscode_CancellationToken -> vscode_FileDecoration vscode_ProviderResult [@@js.call "provideFileDecoration"]
    end
    module ExtensionKind : sig
      type t = vscode_ExtensionKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "Extension"] Extension : sig
      type 'T t = 'T vscode_Extension
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_id: 'T t -> string [@@js.get "id"]
      val get_extensionUri: 'T t -> vscode_Uri [@@js.get "extensionUri"]
      val get_extensionPath: 'T t -> string [@@js.get "extensionPath"]
      val get_isActive: 'T t -> bool [@@js.get "isActive"]
      val get_packageJSON: 'T t -> any [@@js.get "packageJSON"]
      val get_extensionKind: 'T t -> vscode_ExtensionKind [@@js.get "extensionKind"]
      val set_extensionKind: 'T t -> vscode_ExtensionKind -> unit [@@js.set "extensionKind"]
      val get_exports: 'T t -> 'T [@@js.get "exports"]
      val activate: 'T t -> 'T _Thenable [@@js.call "activate"]
    end
    module ExtensionMode : sig
      type t = vscode_ExtensionMode
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
      val get_subscriptions: t -> anonymous_interface_42 list [@@js.get "subscriptions"]
      val get_workspaceState: t -> vscode_Memento [@@js.get "workspaceState"]
      val get_globalState: t -> (vscode_Memento, anonymous_interface_43) intersection2 [@@js.get "globalState"]
      val get_secrets: t -> vscode_SecretStorage [@@js.get "secrets"]
      val get_extensionUri: t -> vscode_Uri [@@js.get "extensionUri"]
      val get_extensionPath: t -> string [@@js.get "extensionPath"]
      val get_environmentVariableCollection: t -> vscode_EnvironmentVariableCollection [@@js.get "environmentVariableCollection"]
      val asAbsolutePath: t -> relativePath:string -> string [@@js.call "asAbsolutePath"]
      val get_storageUri: t -> vscode_Uri or_undefined [@@js.get "storageUri"]
      val get_storagePath: t -> string or_undefined [@@js.get "storagePath"]
      val get_globalStorageUri: t -> vscode_Uri [@@js.get "globalStorageUri"]
      val get_globalStoragePath: t -> string [@@js.get "globalStoragePath"]
      val get_logUri: t -> vscode_Uri [@@js.get "logUri"]
      val get_logPath: t -> string [@@js.get "logPath"]
      val get_extensionMode: t -> vscode_ExtensionMode [@@js.get "extensionMode"]
      val get_extension: t -> any vscode_Extension [@@js.get "extension"]
    end
    module[@js.scope "Memento"] Memento : sig
      type t = vscode_Memento
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_: t -> key:string -> 'T or_undefined [@@js.call "get"]
      val get_': t -> key:string -> defaultValue:'T -> 'T [@@js.call "get"]
      val update: t -> key:string -> value:any -> unit _Thenable [@@js.call "update"]
    end
    module[@js.scope "SecretStorageChangeEvent"] SecretStorageChangeEvent : sig
      type t = vscode_SecretStorageChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_key: t -> string [@@js.get "key"]
    end
    module[@js.scope "SecretStorage"] SecretStorage : sig
      type t = vscode_SecretStorage
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_: t -> key:string -> string or_undefined _Thenable [@@js.call "get"]
      val store: t -> key:string -> value:string -> unit _Thenable [@@js.call "store"]
      val delete: t -> key:string -> unit _Thenable [@@js.call "delete"]
      val get_onDidChange: t -> vscode_SecretStorageChangeEvent vscode_Event [@@js.get "onDidChange"]
      val set_onDidChange: t -> vscode_SecretStorageChangeEvent vscode_Event -> unit [@@js.set "onDidChange"]
    end
    module ColorThemeKind : sig
      type t = vscode_ColorThemeKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "ColorTheme"] ColorTheme : sig
      type t = vscode_ColorTheme
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_kind: t -> vscode_ColorThemeKind [@@js.get "kind"]
    end
    module TaskRevealKind : sig
      type t = vscode_TaskRevealKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module TaskPanelKind : sig
      type t = vscode_TaskPanelKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "TaskPresentationOptions"] TaskPresentationOptions : sig
      type t = vscode_TaskPresentationOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_reveal: t -> vscode_TaskRevealKind [@@js.get "reveal"]
      val set_reveal: t -> vscode_TaskRevealKind -> unit [@@js.set "reveal"]
      val get_echo: t -> bool [@@js.get "echo"]
      val set_echo: t -> bool -> unit [@@js.set "echo"]
      val get_focus: t -> bool [@@js.get "focus"]
      val set_focus: t -> bool -> unit [@@js.set "focus"]
      val get_panel: t -> vscode_TaskPanelKind [@@js.get "panel"]
      val set_panel: t -> vscode_TaskPanelKind -> unit [@@js.set "panel"]
      val get_showReuseMessage: t -> bool [@@js.get "showReuseMessage"]
      val set_showReuseMessage: t -> bool -> unit [@@js.set "showReuseMessage"]
      val get_clear: t -> bool [@@js.get "clear"]
      val set_clear: t -> bool -> unit [@@js.set "clear"]
    end
    module[@js.scope "TaskGroup"] TaskGroup : sig
      type t = vscode_TaskGroup
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_Clean: unit -> t [@@js.get "Clean"]
      val set_Clean: t -> unit [@@js.set "Clean"]
      val get_Build: unit -> t [@@js.get "Build"]
      val set_Build: t -> unit [@@js.set "Build"]
      val get_Rebuild: unit -> t [@@js.get "Rebuild"]
      val set_Rebuild: t -> unit [@@js.set "Rebuild"]
      val get_Test: unit -> t [@@js.get "Test"]
      val set_Test: t -> unit [@@js.set "Test"]
      val create: id:string -> label:string -> t [@@js.create]
    end
    module[@js.scope "TaskDefinition"] TaskDefinition : sig
      type t = vscode_TaskDefinition
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> string [@@js.get "type"]
      val get: t -> string -> any [@@js.index_get]
      val set: t -> string -> any -> unit [@@js.index_set]
    end
    module[@js.scope "ProcessExecutionOptions"] ProcessExecutionOptions : sig
      type t = vscode_ProcessExecutionOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_cwd: t -> string [@@js.get "cwd"]
      val set_cwd: t -> string -> unit [@@js.set "cwd"]
      val get_env: t -> anonymous_interface_44 [@@js.get "env"]
      val set_env: t -> anonymous_interface_44 -> unit [@@js.set "env"]
    end
    module[@js.scope "ProcessExecution"] ProcessExecution : sig
      type t = vscode_ProcessExecution
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: process:string -> ?options:vscode_ProcessExecutionOptions -> unit -> t [@@js.create]
      val create': process:string -> args:string list -> ?options:vscode_ProcessExecutionOptions -> unit -> t [@@js.create]
      val get_process: t -> string [@@js.get "process"]
      val set_process: t -> string -> unit [@@js.set "process"]
      val get_args: t -> string list [@@js.get "args"]
      val set_args: t -> string list -> unit [@@js.set "args"]
      val get_options: t -> vscode_ProcessExecutionOptions [@@js.get "options"]
      val set_options: t -> vscode_ProcessExecutionOptions -> unit [@@js.set "options"]
    end
    module[@js.scope "ShellQuotingOptions"] ShellQuotingOptions : sig
      type t = vscode_ShellQuotingOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_escape: t -> anonymous_interface_7 or_string [@@js.get "escape"]
      val set_escape: t -> anonymous_interface_7 or_string -> unit [@@js.set "escape"]
      val get_strong: t -> string [@@js.get "strong"]
      val set_strong: t -> string -> unit [@@js.set "strong"]
      val get_weak: t -> string [@@js.get "weak"]
      val set_weak: t -> string -> unit [@@js.set "weak"]
    end
    module[@js.scope "ShellExecutionOptions"] ShellExecutionOptions : sig
      type t = vscode_ShellExecutionOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_executable: t -> string [@@js.get "executable"]
      val set_executable: t -> string -> unit [@@js.set "executable"]
      val get_shellArgs: t -> string list [@@js.get "shellArgs"]
      val set_shellArgs: t -> string list -> unit [@@js.set "shellArgs"]
      val get_shellQuoting: t -> vscode_ShellQuotingOptions [@@js.get "shellQuoting"]
      val set_shellQuoting: t -> vscode_ShellQuotingOptions -> unit [@@js.set "shellQuoting"]
      val get_cwd: t -> string [@@js.get "cwd"]
      val set_cwd: t -> string -> unit [@@js.set "cwd"]
      val get_env: t -> anonymous_interface_44 [@@js.get "env"]
      val set_env: t -> anonymous_interface_44 -> unit [@@js.set "env"]
    end
    module ShellQuoting : sig
      type t = vscode_ShellQuoting
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "ShellQuotedString"] ShellQuotedString : sig
      type t = vscode_ShellQuotedString
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_value: t -> string [@@js.get "value"]
      val set_value: t -> string -> unit [@@js.set "value"]
      val get_quoting: t -> vscode_ShellQuoting [@@js.get "quoting"]
      val set_quoting: t -> vscode_ShellQuoting -> unit [@@js.set "quoting"]
    end
    module[@js.scope "ShellExecution"] ShellExecution : sig
      type t = vscode_ShellExecution
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: commandLine:string -> ?options:vscode_ShellExecutionOptions -> unit -> t [@@js.create]
      val create': command:vscode_ShellQuotedString or_string -> args:vscode_ShellQuotedString or_string list -> ?options:vscode_ShellExecutionOptions -> unit -> t [@@js.create]
      val get_commandLine: t -> string or_undefined [@@js.get "commandLine"]
      val set_commandLine: t -> string or_undefined -> unit [@@js.set "commandLine"]
      val get_command: t -> vscode_ShellQuotedString or_string [@@js.get "command"]
      val set_command: t -> vscode_ShellQuotedString or_string -> unit [@@js.set "command"]
      val get_args: t -> vscode_ShellQuotedString or_string list [@@js.get "args"]
      val set_args: t -> vscode_ShellQuotedString or_string list -> unit [@@js.set "args"]
      val get_options: t -> vscode_ShellExecutionOptions [@@js.get "options"]
      val set_options: t -> vscode_ShellExecutionOptions -> unit [@@js.set "options"]
    end
    module[@js.scope "CustomExecution"] CustomExecution : sig
      type t = vscode_CustomExecution
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: callback:(resolvedDefinition:vscode_TaskDefinition -> vscode_Pseudoterminal _Thenable) -> t [@@js.create]
    end
    module TaskScope : sig
      type t = vscode_TaskScope
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "RunOptions"] RunOptions : sig
      type t = vscode_RunOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_reevaluateOnRerun: t -> bool [@@js.get "reevaluateOnRerun"]
      val set_reevaluateOnRerun: t -> bool -> unit [@@js.set "reevaluateOnRerun"]
    end
    module[@js.scope "Task"] Task : sig
      type t = vscode_Task
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: taskDefinition:vscode_TaskDefinition -> scope:((vscode_TaskScope_Global, vscode_TaskScope_Workspace, vscode_WorkspaceFolder) union3, ([`Global | `Workspace] [@js.enum])) or_enum -> name:string -> source:string -> ?execution:(vscode_CustomExecution, vscode_ProcessExecution, vscode_ShellExecution) union3 -> ?problemMatchers:string list or_string -> unit -> t [@@js.create]
      val create': taskDefinition:vscode_TaskDefinition -> name:string -> source:string -> ?execution:(vscode_ProcessExecution, vscode_ShellExecution) union2 -> ?problemMatchers:string list or_string -> unit -> t [@@js.create]
      val get_definition: t -> vscode_TaskDefinition [@@js.get "definition"]
      val set_definition: t -> vscode_TaskDefinition -> unit [@@js.set "definition"]
      val get_scope: t -> ((vscode_TaskScope_Global, vscode_TaskScope_Workspace, vscode_WorkspaceFolder) union3, ([`Global[@js 1] | `Workspace[@js 2]] [@js.enum])) or_enum [@@js.get "scope"]
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_detail: t -> string [@@js.get "detail"]
      val set_detail: t -> string -> unit [@@js.set "detail"]
      val get_execution: t -> (vscode_CustomExecution, vscode_ProcessExecution, vscode_ShellExecution) union3 [@@js.get "execution"]
      val set_execution: t -> (vscode_CustomExecution, vscode_ProcessExecution, vscode_ShellExecution) union3 -> unit [@@js.set "execution"]
      val get_isBackground: t -> bool [@@js.get "isBackground"]
      val set_isBackground: t -> bool -> unit [@@js.set "isBackground"]
      val get_source: t -> string [@@js.get "source"]
      val set_source: t -> string -> unit [@@js.set "source"]
      val get_group: t -> vscode_TaskGroup [@@js.get "group"]
      val set_group: t -> vscode_TaskGroup -> unit [@@js.set "group"]
      val get_presentationOptions: t -> vscode_TaskPresentationOptions [@@js.get "presentationOptions"]
      val set_presentationOptions: t -> vscode_TaskPresentationOptions -> unit [@@js.set "presentationOptions"]
      val get_problemMatchers: t -> string list [@@js.get "problemMatchers"]
      val set_problemMatchers: t -> string list -> unit [@@js.set "problemMatchers"]
      val get_runOptions: t -> vscode_RunOptions [@@js.get "runOptions"]
      val set_runOptions: t -> vscode_RunOptions -> unit [@@js.set "runOptions"]
    end
    module[@js.scope "TaskProvider"] TaskProvider : sig
      type 'T t = 'T vscode_TaskProvider
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_Task t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideTasks: 'T t -> token:vscode_CancellationToken -> 'T list vscode_ProviderResult [@@js.call "provideTasks"]
      val resolveTask: 'T t -> task:'T -> token:vscode_CancellationToken -> 'T vscode_ProviderResult [@@js.call "resolveTask"]
    end
    module[@js.scope "TaskExecution"] TaskExecution : sig
      type t = vscode_TaskExecution
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_task: t -> vscode_Task [@@js.get "task"]
      val set_task: t -> vscode_Task -> unit [@@js.set "task"]
      val terminate: t -> unit [@@js.call "terminate"]
    end
    module[@js.scope "TaskStartEvent"] TaskStartEvent : sig
      type t = vscode_TaskStartEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_execution: t -> vscode_TaskExecution [@@js.get "execution"]
    end
    module[@js.scope "TaskEndEvent"] TaskEndEvent : sig
      type t = vscode_TaskEndEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_execution: t -> vscode_TaskExecution [@@js.get "execution"]
    end
    module[@js.scope "TaskProcessStartEvent"] TaskProcessStartEvent : sig
      type t = vscode_TaskProcessStartEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_execution: t -> vscode_TaskExecution [@@js.get "execution"]
      val get_processId: t -> float [@@js.get "processId"]
    end
    module[@js.scope "TaskProcessEndEvent"] TaskProcessEndEvent : sig
      type t = vscode_TaskProcessEndEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_execution: t -> vscode_TaskExecution [@@js.get "execution"]
      val get_exitCode: t -> float or_undefined [@@js.get "exitCode"]
    end
    module[@js.scope "TaskFilter"] TaskFilter : sig
      type t = vscode_TaskFilter
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_version: t -> string [@@js.get "version"]
      val set_version: t -> string -> unit [@@js.set "version"]
      val get_type: t -> string [@@js.get "type"]
      val set_type: t -> string -> unit [@@js.set "type"]
    end
    module[@js.scope "tasks"] Tasks : sig
      val registerTaskProvider: type_:string -> provider:vscode_Task vscode_TaskProvider -> vscode_Disposable [@@js.global "registerTaskProvider"]
      val fetchTasks: ?filter:vscode_TaskFilter -> unit -> vscode_Task list _Thenable [@@js.global "fetchTasks"]
      val executeTask: task:vscode_Task -> vscode_TaskExecution _Thenable [@@js.global "executeTask"]
      val taskExecutions: vscode_TaskExecution list [@@js.global "taskExecutions"]
      val onDidStartTask: vscode_TaskStartEvent vscode_Event [@@js.global "onDidStartTask"]
      val onDidEndTask: vscode_TaskEndEvent vscode_Event [@@js.global "onDidEndTask"]
      val onDidStartTaskProcess: vscode_TaskProcessStartEvent vscode_Event [@@js.global "onDidStartTaskProcess"]
      val onDidEndTaskProcess: vscode_TaskProcessEndEvent vscode_Event [@@js.global "onDidEndTaskProcess"]
    end
    module FileType : sig
      type t = vscode_FileType
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "FileStat"] FileStat : sig
      type t = vscode_FileStat
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> vscode_FileType [@@js.get "type"]
      val set_type: t -> vscode_FileType -> unit [@@js.set "type"]
      val get_ctime: t -> float [@@js.get "ctime"]
      val set_ctime: t -> float -> unit [@@js.set "ctime"]
      val get_mtime: t -> float [@@js.get "mtime"]
      val set_mtime: t -> float -> unit [@@js.set "mtime"]
      val get_size: t -> float [@@js.get "size"]
      val set_size: t -> float -> unit [@@js.set "size"]
    end
    module[@js.scope "FileSystemError"] FileSystemError : sig
      type t = vscode_FileSystemError
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val fileNotFound: ?messageOrUri:vscode_Uri or_string -> unit -> t [@@js.global "FileNotFound"]
      val fileExists: ?messageOrUri:vscode_Uri or_string -> unit -> t [@@js.global "FileExists"]
      val fileNotADirectory: ?messageOrUri:vscode_Uri or_string -> unit -> t [@@js.global "FileNotADirectory"]
      val fileIsADirectory: ?messageOrUri:vscode_Uri or_string -> unit -> t [@@js.global "FileIsADirectory"]
      val noPermissions: ?messageOrUri:vscode_Uri or_string -> unit -> t [@@js.global "NoPermissions"]
      val unavailable: ?messageOrUri:vscode_Uri or_string -> unit -> t [@@js.global "Unavailable"]
      val create: ?messageOrUri:vscode_Uri or_string -> unit -> t [@@js.create]
      val get_code: t -> string [@@js.get "code"]
      val cast: t -> Error.t_0 [@@js.cast]
    end
    module FileChangeType : sig
      type t = vscode_FileChangeType
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "FileChangeEvent"] FileChangeEvent : sig
      type t = vscode_FileChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> vscode_FileChangeType [@@js.get "type"]
      val get_uri: t -> vscode_Uri [@@js.get "uri"]
    end
    module[@js.scope "FileSystemProvider"] FileSystemProvider : sig
      type t = vscode_FileSystemProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidChangeFile: t -> vscode_FileChangeEvent list vscode_Event [@@js.get "onDidChangeFile"]
      val watch: t -> uri:vscode_Uri -> options:anonymous_interface_26 -> vscode_Disposable [@@js.call "watch"]
      val stat: t -> uri:vscode_Uri -> (vscode_FileStat, vscode_FileStat _Thenable) union2 [@@js.call "stat"]
      val readDirectory: t -> uri:vscode_Uri -> ((string * vscode_FileType) list _Thenable, (string * vscode_FileType)) or_array [@@js.call "readDirectory"]
      val createDirectory: t -> uri:vscode_Uri -> (unit, unit _Thenable) union2 [@@js.call "createDirectory"]
      val readFile: t -> uri:vscode_Uri -> (Uint8Array.t_0, Uint8Array.t_0 _Thenable) union2 [@@js.call "readFile"]
      val writeFile: t -> uri:vscode_Uri -> content:Uint8Array.t_0 -> options:anonymous_interface_3 -> (unit, unit _Thenable) union2 [@@js.call "writeFile"]
      val delete: t -> uri:vscode_Uri -> options:anonymous_interface_25 -> (unit, unit _Thenable) union2 [@@js.call "delete"]
      val rename: t -> oldUri:vscode_Uri -> newUri:vscode_Uri -> options:anonymous_interface_21 -> (unit, unit _Thenable) union2 [@@js.call "rename"]
      val copy: t -> source:vscode_Uri -> destination:vscode_Uri -> options:anonymous_interface_21 -> (unit, unit _Thenable) union2 [@@js.call "copy"]
    end
    module[@js.scope "FileSystem"] FileSystem : sig
      type t = vscode_FileSystem
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val stat: t -> uri:vscode_Uri -> vscode_FileStat _Thenable [@@js.call "stat"]
      val readDirectory: t -> uri:vscode_Uri -> (string * vscode_FileType) list _Thenable [@@js.call "readDirectory"]
      val createDirectory: t -> uri:vscode_Uri -> unit _Thenable [@@js.call "createDirectory"]
      val readFile: t -> uri:vscode_Uri -> Uint8Array.t_0 _Thenable [@@js.call "readFile"]
      val writeFile: t -> uri:vscode_Uri -> content:Uint8Array.t_0 -> unit _Thenable [@@js.call "writeFile"]
      val delete: t -> uri:vscode_Uri -> ?options:anonymous_interface_28 -> unit -> unit _Thenable [@@js.call "delete"]
      val rename: t -> source:vscode_Uri -> target:vscode_Uri -> ?options:anonymous_interface_21 -> unit -> unit _Thenable [@@js.call "rename"]
      val copy: t -> source:vscode_Uri -> target:vscode_Uri -> ?options:anonymous_interface_21 -> unit -> unit _Thenable [@@js.call "copy"]
      val isWritableFileSystem: t -> scheme:string -> bool or_undefined [@@js.call "isWritableFileSystem"]
    end
    module[@js.scope "WebviewPortMapping"] WebviewPortMapping : sig
      type t = vscode_WebviewPortMapping
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_webviewPort: t -> float [@@js.get "webviewPort"]
      val get_extensionHostPort: t -> float [@@js.get "extensionHostPort"]
    end
    module[@js.scope "WebviewOptions"] WebviewOptions : sig
      type t = vscode_WebviewOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_enableScripts: t -> bool [@@js.get "enableScripts"]
      val get_enableCommandUris: t -> bool [@@js.get "enableCommandUris"]
      val get_localResourceRoots: t -> vscode_Uri list [@@js.get "localResourceRoots"]
      val get_portMapping: t -> vscode_WebviewPortMapping list [@@js.get "portMapping"]
    end
    module[@js.scope "Webview"] Webview : sig
      type t = vscode_Webview
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_options: t -> vscode_WebviewOptions [@@js.get "options"]
      val set_options: t -> vscode_WebviewOptions -> unit [@@js.set "options"]
      val get_html: t -> string [@@js.get "html"]
      val set_html: t -> string -> unit [@@js.set "html"]
      val get_onDidReceiveMessage: t -> any vscode_Event [@@js.get "onDidReceiveMessage"]
      val postMessage: t -> message:any -> bool _Thenable [@@js.call "postMessage"]
      val asWebviewUri: t -> localResource:vscode_Uri -> vscode_Uri [@@js.call "asWebviewUri"]
      val get_cspSource: t -> string [@@js.get "cspSource"]
    end
    module[@js.scope "WebviewPanelOptions"] WebviewPanelOptions : sig
      type t = vscode_WebviewPanelOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_enableFindWidget: t -> bool [@@js.get "enableFindWidget"]
      val get_retainContextWhenHidden: t -> bool [@@js.get "retainContextWhenHidden"]
    end
    module[@js.scope "WebviewPanel"] WebviewPanel : sig
      type t = vscode_WebviewPanel
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_viewType: t -> string [@@js.get "viewType"]
      val get_title: t -> string [@@js.get "title"]
      val set_title: t -> string -> unit [@@js.set "title"]
      val get_iconPath: t -> (vscode_Uri, anonymous_interface_14) union2 [@@js.get "iconPath"]
      val set_icon_path: t -> (vscode_Uri, anonymous_interface_14) union2 -> unit [@@js.set "iconPath"]
      val get_webview: t -> vscode_Webview [@@js.get "webview"]
      val get_options: t -> vscode_WebviewPanelOptions [@@js.get "options"]
      val get_viewColumn: t -> vscode_ViewColumn [@@js.get "viewColumn"]
      val get_active: t -> bool [@@js.get "active"]
      val get_visible: t -> bool [@@js.get "visible"]
      val get_onDidChangeViewState: t -> vscode_WebviewPanelOnDidChangeViewStateEvent vscode_Event [@@js.get "onDidChangeViewState"]
      val get_onDidDispose: t -> unit vscode_Event [@@js.get "onDidDispose"]
      val reveal: t -> ?viewColumn:vscode_ViewColumn -> ?preserveFocus:bool -> unit -> unit [@@js.call "reveal"]
      val dispose: t -> any [@@js.call "dispose"]
    end
    module[@js.scope "WebviewPanelOnDidChangeViewStateEvent"] WebviewPanelOnDidChangeViewStateEvent : sig
      type t = vscode_WebviewPanelOnDidChangeViewStateEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_webviewPanel: t -> vscode_WebviewPanel [@@js.get "webviewPanel"]
    end
    module[@js.scope "WebviewPanelSerializer"] WebviewPanelSerializer : sig
      type 'T t = 'T vscode_WebviewPanelSerializer
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = unknown t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val deserializeWebviewPanel: 'T t -> webviewPanel:vscode_WebviewPanel -> state:'T -> unit _Thenable [@@js.call "deserializeWebviewPanel"]
    end
    module[@js.scope "WebviewView"] WebviewView : sig
      type t = vscode_WebviewView
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_viewType: t -> string [@@js.get "viewType"]
      val get_webview: t -> vscode_Webview [@@js.get "webview"]
      val get_title: t -> string [@@js.get "title"]
      val set_title: t -> string -> unit [@@js.set "title"]
      val get_description: t -> string [@@js.get "description"]
      val set_description: t -> string -> unit [@@js.set "description"]
      val get_onDidDispose: t -> unit vscode_Event [@@js.get "onDidDispose"]
      val get_visible: t -> bool [@@js.get "visible"]
      val get_onDidChangeVisibility: t -> unit vscode_Event [@@js.get "onDidChangeVisibility"]
      val show: t -> ?preserveFocus:bool -> unit -> unit [@@js.call "show"]
    end
    module[@js.scope "WebviewViewResolveContext"] WebviewViewResolveContext : sig
      type 'T t = 'T vscode_WebviewViewResolveContext
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = unknown t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_state: 'T t -> 'T or_undefined [@@js.get "state"]
    end
    module[@js.scope "WebviewViewProvider"] WebviewViewProvider : sig
      type t = vscode_WebviewViewProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val resolveWebviewView: t -> webviewView:vscode_WebviewView -> context:unknown vscode_WebviewViewResolveContext -> token:vscode_CancellationToken -> (unit, unit _Thenable) union2 [@@js.call "resolveWebviewView"]
    end
    module[@js.scope "CustomTextEditorProvider"] CustomTextEditorProvider : sig
      type t = vscode_CustomTextEditorProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val resolveCustomTextEditor: t -> document:vscode_TextDocument -> webviewPanel:vscode_WebviewPanel -> token:vscode_CancellationToken -> (unit, unit _Thenable) union2 [@@js.call "resolveCustomTextEditor"]
    end
    module[@js.scope "CustomDocument"] CustomDocument : sig
      type t = vscode_CustomDocument
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_uri: t -> vscode_Uri [@@js.get "uri"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "CustomDocumentEditEvent"] CustomDocumentEditEvent : sig
      type 'T t = 'T vscode_CustomDocumentEditEvent
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_CustomDocument t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_document: 'T t -> 'T [@@js.get "document"]
      val undo: 'T t -> (unit, unit _Thenable) union2 [@@js.call "undo"]
      val redo: 'T t -> (unit, unit _Thenable) union2 [@@js.call "redo"]
      val get_label: 'T t -> string [@@js.get "label"]
    end
    module[@js.scope "CustomDocumentContentChangeEvent"] CustomDocumentContentChangeEvent : sig
      type 'T t = 'T vscode_CustomDocumentContentChangeEvent
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_CustomDocument t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_document: 'T t -> 'T [@@js.get "document"]
    end
    module[@js.scope "CustomDocumentBackup"] CustomDocumentBackup : sig
      type t = vscode_CustomDocumentBackup
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val delete: t -> unit [@@js.call "delete"]
    end
    module[@js.scope "CustomDocumentBackupContext"] CustomDocumentBackupContext : sig
      type t = vscode_CustomDocumentBackupContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_destination: t -> vscode_Uri [@@js.get "destination"]
    end
    module[@js.scope "CustomDocumentOpenContext"] CustomDocumentOpenContext : sig
      type t = vscode_CustomDocumentOpenContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_backupId: t -> string [@@js.get "backupId"]
      val get_untitledDocumentData: t -> Uint8Array.t_0 [@@js.get "untitledDocumentData"]
    end
    module[@js.scope "CustomReadonlyEditorProvider"] CustomReadonlyEditorProvider : sig
      type 'T t = 'T vscode_CustomReadonlyEditorProvider
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_CustomDocument t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val openCustomDocument: 'T t -> uri:vscode_Uri -> openContext:vscode_CustomDocumentOpenContext -> token:vscode_CancellationToken -> ('T, 'T _Thenable) union2 [@@js.call "openCustomDocument"]
      val resolveCustomEditor: 'T t -> document:'T -> webviewPanel:vscode_WebviewPanel -> token:vscode_CancellationToken -> (unit, unit _Thenable) union2 [@@js.call "resolveCustomEditor"]
    end
    module[@js.scope "CustomEditorProvider"] CustomEditorProvider : sig
      type 'T t = 'T vscode_CustomEditorProvider
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      type t_0 = vscode_CustomDocument t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidChangeCustomDocument: 'T t -> ('T vscode_CustomDocumentContentChangeEvent vscode_Event, 'T vscode_CustomDocumentEditEvent vscode_Event) union2 [@@js.get "onDidChangeCustomDocument"]
      val saveCustomDocument: 'T t -> document:'T -> cancellation:vscode_CancellationToken -> unit _Thenable [@@js.call "saveCustomDocument"]
      val saveCustomDocumentAs: 'T t -> document:'T -> destination:vscode_Uri -> cancellation:vscode_CancellationToken -> unit _Thenable [@@js.call "saveCustomDocumentAs"]
      val revertCustomDocument: 'T t -> document:'T -> cancellation:vscode_CancellationToken -> unit _Thenable [@@js.call "revertCustomDocument"]
      val backupCustomDocument: 'T t -> document:'T -> context:vscode_CustomDocumentBackupContext -> cancellation:vscode_CancellationToken -> vscode_CustomDocumentBackup _Thenable [@@js.call "backupCustomDocument"]
      val cast: 'T t -> 'T vscode_CustomReadonlyEditorProvider [@@js.cast]
    end
    module[@js.scope "Clipboard"] Clipboard : sig
      type t = vscode_Clipboard
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val readText: t -> string _Thenable [@@js.call "readText"]
      val writeText: t -> value:string -> unit _Thenable [@@js.call "writeText"]
    end
    module UIKind : sig
      type t = vscode_UIKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "env"] Env : sig
      val appName: string [@@js.global "appName"]
      val appRoot: string [@@js.global "appRoot"]
      val uriScheme: string [@@js.global "uriScheme"]
      val language: string [@@js.global "language"]
      val clipboard: vscode_Clipboard [@@js.global "clipboard"]
      val machineId: string [@@js.global "machineId"]
      val sessionId: string [@@js.global "sessionId"]
      val isNewAppInstall: bool [@@js.global "isNewAppInstall"]
      val isTelemetryEnabled: bool [@@js.global "isTelemetryEnabled"]
      val onDidChangeTelemetryEnabled: bool vscode_Event [@@js.global "onDidChangeTelemetryEnabled"]
      val remoteName: string or_undefined [@@js.global "remoteName"]
      val shell: string [@@js.global "shell"]
      val uiKind: vscode_UIKind [@@js.global "uiKind"]
      val openExternal: target:vscode_Uri -> bool _Thenable [@@js.global "openExternal"]
      val asExternalUri: target:vscode_Uri -> vscode_Uri _Thenable [@@js.global "asExternalUri"]
    end
    module[@js.scope "commands"] Commands : sig
      val registerCommand: command:string -> callback:(args:(any list [@js.variadic]) -> any) -> ?thisArg:any -> unit -> vscode_Disposable [@@js.global "registerCommand"]
      val registerTextEditorCommand: command:string -> callback:(textEditor:vscode_TextEditor -> edit:vscode_TextEditorEdit -> args:(any list [@js.variadic]) -> unit) -> ?thisArg:any -> unit -> vscode_Disposable [@@js.global "registerTextEditorCommand"]
      val executeCommand: command:string -> rest:(any list [@js.variadic]) -> 'T or_undefined _Thenable [@@js.global "executeCommand"]
      val getCommands: ?filterInternal:bool -> unit -> string list _Thenable [@@js.global "getCommands"]
    end
    module[@js.scope "WindowState"] WindowState : sig
      type t = vscode_WindowState
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_focused: t -> bool [@@js.get "focused"]
    end
    module[@js.scope "UriHandler"] UriHandler : sig
      type t = vscode_UriHandler
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val handleUri: t -> uri:vscode_Uri -> unit vscode_ProviderResult [@@js.call "handleUri"]
    end
    module[@js.scope "window"] Window : sig
      val activeTextEditor: vscode_TextEditor or_undefined [@@js.global "activeTextEditor"]
      val visibleTextEditors: vscode_TextEditor list [@@js.global "visibleTextEditors"]
      val onDidChangeActiveTextEditor: vscode_TextEditor or_undefined vscode_Event [@@js.global "onDidChangeActiveTextEditor"]
      val onDidChangeVisibleTextEditors: vscode_TextEditor list vscode_Event [@@js.global "onDidChangeVisibleTextEditors"]
      val onDidChangeTextEditorSelection: vscode_TextEditorSelectionChangeEvent vscode_Event [@@js.global "onDidChangeTextEditorSelection"]
      val onDidChangeTextEditorVisibleRanges: vscode_TextEditorVisibleRangesChangeEvent vscode_Event [@@js.global "onDidChangeTextEditorVisibleRanges"]
      val onDidChangeTextEditorOptions: vscode_TextEditorOptionsChangeEvent vscode_Event [@@js.global "onDidChangeTextEditorOptions"]
      val onDidChangeTextEditorViewColumn: vscode_TextEditorViewColumnChangeEvent vscode_Event [@@js.global "onDidChangeTextEditorViewColumn"]
      val terminals: vscode_Terminal list [@@js.global "terminals"]
      val activeTerminal: vscode_Terminal or_undefined [@@js.global "activeTerminal"]
      val onDidChangeActiveTerminal: vscode_Terminal or_undefined vscode_Event [@@js.global "onDidChangeActiveTerminal"]
      val onDidOpenTerminal: vscode_Terminal vscode_Event [@@js.global "onDidOpenTerminal"]
      val onDidCloseTerminal: vscode_Terminal vscode_Event [@@js.global "onDidCloseTerminal"]
      val state: vscode_WindowState [@@js.global "state"]
      val onDidChangeWindowState: vscode_WindowState vscode_Event [@@js.global "onDidChangeWindowState"]
      val showTextDocument: document:vscode_TextDocument -> ?column:vscode_ViewColumn -> ?preserveFocus:bool -> unit -> vscode_TextEditor _Thenable [@@js.global "showTextDocument"]
      val showTextDocument: document:vscode_TextDocument -> ?options:vscode_TextDocumentShowOptions -> unit -> vscode_TextEditor _Thenable [@@js.global "showTextDocument"]
      val showTextDocument: uri:vscode_Uri -> ?options:vscode_TextDocumentShowOptions -> unit -> vscode_TextEditor _Thenable [@@js.global "showTextDocument"]
      val createTextEditorDecorationType: options:vscode_DecorationRenderOptions -> vscode_TextEditorDecorationType [@@js.global "createTextEditorDecorationType"]
      val show_information_message: message:string -> items:(string list [@js.variadic]) -> string or_undefined _Thenable [@@js.global "show_information_message"]
      val show_information_message: message:string -> options:vscode_MessageOptions -> items:(string list [@js.variadic]) -> string or_undefined _Thenable [@@js.global "show_information_message"]
      val show_information_message: message:string -> items:('T list [@js.variadic]) -> 'T or_undefined _Thenable [@@js.global "show_information_message"]
      val show_information_message: message:string -> options:vscode_MessageOptions -> items:('T list [@js.variadic]) -> 'T or_undefined _Thenable [@@js.global "show_information_message"]
      val show_warning_message: message:string -> items:(string list [@js.variadic]) -> string or_undefined _Thenable [@@js.global "show_warning_message"]
      val show_warning_message: message:string -> options:vscode_MessageOptions -> items:(string list [@js.variadic]) -> string or_undefined _Thenable [@@js.global "show_warning_message"]
      val show_warning_message: message:string -> items:('T list [@js.variadic]) -> 'T or_undefined _Thenable [@@js.global "show_warning_message"]
      val show_warning_message: message:string -> options:vscode_MessageOptions -> items:('T list [@js.variadic]) -> 'T or_undefined _Thenable [@@js.global "show_warning_message"]
      val showErrorMessage: message:string -> items:(string list [@js.variadic]) -> string or_undefined _Thenable [@@js.global "showErrorMessage"]
      val showErrorMessage: message:string -> options:vscode_MessageOptions -> items:(string list [@js.variadic]) -> string or_undefined _Thenable [@@js.global "showErrorMessage"]
      val showErrorMessage: message:string -> items:('T list [@js.variadic]) -> 'T or_undefined _Thenable [@@js.global "showErrorMessage"]
      val showErrorMessage: message:string -> options:vscode_MessageOptions -> items:('T list [@js.variadic]) -> 'T or_undefined _Thenable [@@js.global "showErrorMessage"]
      val showQuickPick: items:(string list _Thenable, string) or_array -> options:(vscode_QuickPickOptions, anonymous_interface_2) intersection2 -> ?token:vscode_CancellationToken -> unit -> string list or_undefined _Thenable [@@js.global "showQuickPick"]
      val showQuickPick: items:(string list _Thenable, string) or_array -> ?options:vscode_QuickPickOptions -> ?token:vscode_CancellationToken -> unit -> string or_undefined _Thenable [@@js.global "showQuickPick"]
      val showQuickPick: items:('T list _Thenable, 'T) or_array -> options:(vscode_QuickPickOptions, anonymous_interface_2) intersection2 -> ?token:vscode_CancellationToken -> unit -> 'T list or_undefined _Thenable [@@js.global "showQuickPick"]
      val showQuickPick: items:('T list _Thenable, 'T) or_array -> ?options:vscode_QuickPickOptions -> ?token:vscode_CancellationToken -> unit -> 'T or_undefined _Thenable [@@js.global "showQuickPick"]
      val showWorkspaceFolderPick: ?options:vscode_WorkspaceFolderPickOptions -> unit -> vscode_WorkspaceFolder or_undefined _Thenable [@@js.global "showWorkspaceFolderPick"]
      val showOpenDialog: ?options:vscode_OpenDialogOptions -> unit -> vscode_Uri list or_undefined _Thenable [@@js.global "showOpenDialog"]
      val showSaveDialog: ?options:vscode_SaveDialogOptions -> unit -> vscode_Uri or_undefined _Thenable [@@js.global "showSaveDialog"]
      val showInputBox: ?options:vscode_InputBoxOptions -> ?token:vscode_CancellationToken -> unit -> string or_undefined _Thenable [@@js.global "showInputBox"]
      val createQuickPick: unit -> 'T vscode_QuickPick [@@js.global "createQuickPick"]
      val createInputBox: unit -> vscode_InputBox [@@js.global "createInputBox"]
      val createOutputChannel: name:string -> vscode_OutputChannel [@@js.global "createOutputChannel"]
      val createWebviewPanel: viewType:string -> title:string -> showOptions:((vscode_ViewColumn, anonymous_interface_38) union2, ([`Active | `Beside | `Eight | `Five | `Four | `Nine | `One | `Seven | `Six | `Three | `Two] [@js.enum])) or_enum -> ?options:(vscode_WebviewPanelOptions, vscode_WebviewOptions) intersection2 -> unit -> vscode_WebviewPanel [@@js.global "createWebviewPanel"]
      val setStatusBarMessage: text:string -> hideAfterTimeout:float -> vscode_Disposable [@@js.global "setStatusBarMessage"]
      val setStatusBarMessage: text:string -> hideWhenDone:any _Thenable -> vscode_Disposable [@@js.global "setStatusBarMessage"]
      val setStatusBarMessage: text:string -> vscode_Disposable [@@js.global "setStatusBarMessage"]
      val withScmProgress: task:(progress:float vscode_Progress -> 'R _Thenable) -> 'R _Thenable [@@js.global "withScmProgress"]
      val withProgress: options:vscode_ProgressOptions -> task:(progress:anonymous_interface_18 vscode_Progress -> token:vscode_CancellationToken -> 'R _Thenable) -> 'R _Thenable [@@js.global "withProgress"]
      val createStatusBarItem: ?alignment:vscode_StatusBarAlignment -> ?priority:float -> unit -> vscode_StatusBarItem [@@js.global "createStatusBarItem"]
      val createTerminal: ?name:string -> ?shellPath:string -> ?shellArgs:string list or_string -> unit -> vscode_Terminal [@@js.global "createTerminal"]
      val createTerminal: options:vscode_TerminalOptions -> vscode_Terminal [@@js.global "createTerminal"]
      val createTerminal: options:vscode_ExtensionTerminalOptions -> vscode_Terminal [@@js.global "createTerminal"]
      val registerTreeDataProvider: viewId:string -> treeDataProvider:'T vscode_TreeDataProvider -> vscode_Disposable [@@js.global "registerTreeDataProvider"]
      val createTreeView: viewId:string -> options:'T vscode_TreeViewOptions -> 'T vscode_TreeView [@@js.global "createTreeView"]
      val registerUriHandler: handler:vscode_UriHandler -> vscode_Disposable [@@js.global "registerUriHandler"]
      val registerWebviewPanelSerializer: viewType:string -> serializer:unknown vscode_WebviewPanelSerializer -> vscode_Disposable [@@js.global "registerWebviewPanelSerializer"]
      val registerWebviewViewProvider: viewId:string -> provider:vscode_WebviewViewProvider -> ?options:anonymous_interface_41 -> unit -> vscode_Disposable [@@js.global "registerWebviewViewProvider"]
      val registerCustomEditorProvider: viewType:string -> provider:(vscode_CustomDocument vscode_CustomEditorProvider, vscode_CustomDocument vscode_CustomReadonlyEditorProvider, vscode_CustomTextEditorProvider) union3 -> ?options:anonymous_interface_40 -> unit -> vscode_Disposable [@@js.global "registerCustomEditorProvider"]
      val registerTerminalLinkProvider: provider:vscode_TerminalLink vscode_TerminalLinkProvider -> vscode_Disposable [@@js.global "registerTerminalLinkProvider"]
      val registerFileDecorationProvider: provider:vscode_FileDecorationProvider -> vscode_Disposable [@@js.global "registerFileDecorationProvider"]
      val activeColorTheme: vscode_ColorTheme [@@js.global "activeColorTheme"]
      val onDidChangeActiveColorTheme: vscode_ColorTheme vscode_Event [@@js.global "onDidChangeActiveColorTheme"]
    end
    module[@js.scope "TreeViewOptions"] TreeViewOptions : sig
      type 'T t = 'T vscode_TreeViewOptions
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_treeDataProvider: 'T t -> 'T vscode_TreeDataProvider [@@js.get "treeDataProvider"]
      val set_treeDataProvider: 'T t -> 'T vscode_TreeDataProvider -> unit [@@js.set "treeDataProvider"]
      val get_showCollapseAll: 'T t -> bool [@@js.get "showCollapseAll"]
      val set_showCollapseAll: 'T t -> bool -> unit [@@js.set "showCollapseAll"]
      val get_canSelectMany: 'T t -> bool [@@js.get "canSelectMany"]
      val set_canSelectMany: 'T t -> bool -> unit [@@js.set "canSelectMany"]
    end
    module[@js.scope "TreeViewExpansionEvent"] TreeViewExpansionEvent : sig
      type 'T t = 'T vscode_TreeViewExpansionEvent
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_element: 'T t -> 'T [@@js.get "element"]
    end
    module[@js.scope "TreeViewSelectionChangeEvent"] TreeViewSelectionChangeEvent : sig
      type 'T t = 'T vscode_TreeViewSelectionChangeEvent
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_selection: 'T t -> 'T list [@@js.get "selection"]
    end
    module[@js.scope "TreeViewVisibilityChangeEvent"] TreeViewVisibilityChangeEvent : sig
      type t = vscode_TreeViewVisibilityChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_visible: t -> bool [@@js.get "visible"]
    end
    module[@js.scope "TreeView"] TreeView : sig
      type 'T t = 'T vscode_TreeView
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_onDidExpandElement: 'T t -> 'T vscode_TreeViewExpansionEvent vscode_Event [@@js.get "onDidExpandElement"]
      val get_onDidCollapseElement: 'T t -> 'T vscode_TreeViewExpansionEvent vscode_Event [@@js.get "onDidCollapseElement"]
      val get_selection: 'T t -> 'T list [@@js.get "selection"]
      val get_onDidChangeSelection: 'T t -> 'T vscode_TreeViewSelectionChangeEvent vscode_Event [@@js.get "onDidChangeSelection"]
      val get_visible: 'T t -> bool [@@js.get "visible"]
      val get_onDidChangeVisibility: 'T t -> vscode_TreeViewVisibilityChangeEvent vscode_Event [@@js.get "onDidChangeVisibility"]
      val get_message: 'T t -> string [@@js.get "message"]
      val set_message: 'T t -> string -> unit [@@js.set "message"]
      val get_title: 'T t -> string [@@js.get "title"]
      val set_title: 'T t -> string -> unit [@@js.set "title"]
      val get_description: 'T t -> string [@@js.get "description"]
      val set_description: 'T t -> string -> unit [@@js.set "description"]
      val reveal: 'T t -> element:'T -> ?options:anonymous_interface_32 -> unit -> unit _Thenable [@@js.call "reveal"]
      val cast: 'T t -> vscode_Disposable [@@js.cast]
    end
    module[@js.scope "TreeDataProvider"] TreeDataProvider : sig
      type 'T t = 'T vscode_TreeDataProvider
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_onDidChangeTreeData: 'T t -> ('T, unit) union2 or_null_or_undefined vscode_Event [@@js.get "onDidChangeTreeData"]
      val set_onDidChangeTreeData: 'T t -> ('T, unit) union2 or_null_or_undefined vscode_Event -> unit [@@js.set "onDidChangeTreeData"]
      val getTreeItem: 'T t -> element:'T -> (vscode_TreeItem, vscode_TreeItem _Thenable) union2 [@@js.call "getTreeItem"]
      val getChildren: 'T t -> ?element:'T -> unit -> 'T list vscode_ProviderResult [@@js.call "getChildren"]
      val getParent: 'T t -> element:'T -> 'T vscode_ProviderResult [@@js.call "getParent"]
      val resolveTreeItem: 'T t -> item:vscode_TreeItem -> element:'T -> token:vscode_CancellationToken -> vscode_TreeItem vscode_ProviderResult [@@js.call "resolveTreeItem"]
    end
    module[@js.scope "TreeItem"] TreeItem : sig
      type t = vscode_TreeItem
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_label: t -> vscode_TreeItemLabel or_string [@@js.get "label"]
      val set_label: t -> vscode_TreeItemLabel or_string -> unit [@@js.set "label"]
      val get_id: t -> string [@@js.get "id"]
      val set_id: t -> string -> unit [@@js.set "id"]
      val get_iconPath: t -> (vscode_ThemeIcon, vscode_Uri, anonymous_interface_15) union3 or_string [@@js.get "iconPath"]
      val set_icon_path: t -> (vscode_ThemeIcon, vscode_Uri, anonymous_interface_15) union3 or_string -> unit [@@js.set "iconPath"]
      val get_description: t -> bool or_string [@@js.get "description"]
      val set_description: t -> bool or_string -> unit [@@js.set "description"]
      val get_resourceUri: t -> vscode_Uri [@@js.get "resourceUri"]
      val set_resourceUri: t -> vscode_Uri -> unit [@@js.set "resourceUri"]
      val get_tooltip: t -> vscode_MarkdownString or_string or_undefined [@@js.get "tooltip"]
      val set_tooltip: t -> vscode_MarkdownString or_string or_undefined -> unit [@@js.set "tooltip"]
      val get_command: t -> vscode_Command [@@js.get "command"]
      val set_command: t -> vscode_Command -> unit [@@js.set "command"]
      val get_collapsibleState: t -> vscode_TreeItemCollapsibleState [@@js.get "collapsibleState"]
      val set_collapsibleState: t -> vscode_TreeItemCollapsibleState -> unit [@@js.set "collapsibleState"]
      val get_contextValue: t -> string [@@js.get "contextValue"]
      val set_contextValue: t -> string -> unit [@@js.set "contextValue"]
      val get_accessibilityInformation: t -> vscode_AccessibilityInformation [@@js.get "accessibilityInformation"]
      val set_accessibilityInformation: t -> vscode_AccessibilityInformation -> unit [@@js.set "accessibilityInformation"]
      val create: label:vscode_TreeItemLabel or_string -> ?collapsibleState:vscode_TreeItemCollapsibleState -> unit -> t [@@js.create]
      val create': resourceUri:vscode_Uri -> ?collapsibleState:vscode_TreeItemCollapsibleState -> unit -> t [@@js.create]
    end
    module TreeItemCollapsibleState : sig
      type t = vscode_TreeItemCollapsibleState
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "TreeItemLabel"] TreeItemLabel : sig
      type t = vscode_TreeItemLabel
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_highlights: t -> (float * float) list [@@js.get "highlights"]
      val set_highlights: t -> (float * float) list -> unit [@@js.set "highlights"]
    end
    module[@js.scope "TerminalOptions"] TerminalOptions : sig
      type t = vscode_TerminalOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_shellPath: t -> string [@@js.get "shellPath"]
      val set_shellPath: t -> string -> unit [@@js.set "shellPath"]
      val get_shellArgs: t -> string list or_string [@@js.get "shellArgs"]
      val set_shellArgs: t -> string list or_string -> unit [@@js.set "shellArgs"]
      val get_cwd: t -> vscode_Uri or_string [@@js.get "cwd"]
      val set_cwd: t -> vscode_Uri or_string -> unit [@@js.set "cwd"]
      val get_env: t -> anonymous_interface_45 [@@js.get "env"]
      val set_env: t -> anonymous_interface_45 -> unit [@@js.set "env"]
      val get_strictEnv: t -> bool [@@js.get "strictEnv"]
      val set_strictEnv: t -> bool -> unit [@@js.set "strictEnv"]
      val get_hideFromUser: t -> bool [@@js.get "hideFromUser"]
      val set_hideFromUser: t -> bool -> unit [@@js.set "hideFromUser"]
    end
    module[@js.scope "ExtensionTerminalOptions"] ExtensionTerminalOptions : sig
      type t = vscode_ExtensionTerminalOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_pty: t -> vscode_Pseudoterminal [@@js.get "pty"]
      val set_pty: t -> vscode_Pseudoterminal -> unit [@@js.set "pty"]
    end
    module[@js.scope "Pseudoterminal"] Pseudoterminal : sig
      type t = vscode_Pseudoterminal
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidWrite: t -> string vscode_Event [@@js.get "onDidWrite"]
      val set_onDidWrite: t -> string vscode_Event -> unit [@@js.set "onDidWrite"]
      val get_onDidOverrideDimensions: t -> vscode_TerminalDimensions or_undefined vscode_Event [@@js.get "onDidOverrideDimensions"]
      val set_onDidOverrideDimensions: t -> vscode_TerminalDimensions or_undefined vscode_Event -> unit [@@js.set "onDidOverrideDimensions"]
      val get_onDidClose: t -> unit or_number vscode_Event [@@js.get "onDidClose"]
      val set_onDidClose: t -> unit or_number vscode_Event -> unit [@@js.set "onDidClose"]
      val open_: t -> initialDimensions:vscode_TerminalDimensions or_undefined -> unit [@@js.call "open"]
      val close: t -> unit [@@js.call "close"]
      val handleInput: t -> data:string -> unit [@@js.call "handleInput"]
      val setDimensions: t -> dimensions:vscode_TerminalDimensions -> unit [@@js.call "setDimensions"]
    end
    module[@js.scope "TerminalDimensions"] TerminalDimensions : sig
      type t = vscode_TerminalDimensions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_columns: t -> float [@@js.get "columns"]
      val get_rows: t -> float [@@js.get "rows"]
    end
    module[@js.scope "TerminalExitStatus"] TerminalExitStatus : sig
      type t = vscode_TerminalExitStatus
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_code: t -> float or_undefined [@@js.get "code"]
    end
    module EnvironmentVariableMutatorType : sig
      type t = vscode_EnvironmentVariableMutatorType
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "EnvironmentVariableMutator"] EnvironmentVariableMutator : sig
      type t = vscode_EnvironmentVariableMutator
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> vscode_EnvironmentVariableMutatorType [@@js.get "type"]
      val get_value: t -> string [@@js.get "value"]
    end
    module[@js.scope "EnvironmentVariableCollection"] EnvironmentVariableCollection : sig
      type t = vscode_EnvironmentVariableCollection
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_persistent: t -> bool [@@js.get "persistent"]
      val set_persistent: t -> bool -> unit [@@js.set "persistent"]
      val replace: t -> variable:string -> value:string -> unit [@@js.call "replace"]
      val append: t -> variable:string -> value:string -> unit [@@js.call "append"]
      val prepend: t -> variable:string -> value:string -> unit [@@js.call "prepend"]
      val get_: t -> variable:string -> vscode_EnvironmentVariableMutator or_undefined [@@js.call "get"]
      val forEach: t -> callback:(variable:string -> mutator:vscode_EnvironmentVariableMutator -> collection:t -> any) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
      val delete: t -> variable:string -> unit [@@js.call "delete"]
      val clear: t -> unit [@@js.call "clear"]
    end
    module ProgressLocation : sig
      type t = vscode_ProgressLocation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "ProgressOptions"] ProgressOptions : sig
      type t = vscode_ProgressOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_location: t -> ((vscode_ProgressLocation, anonymous_interface_39) union2, ([`Notification[@js 15] | `SourceControl[@js 1] | `Window[@js 10]] [@js.enum])) or_enum [@@js.get "location"]
      val set_location: t -> ((vscode_ProgressLocation, anonymous_interface_39) union2, ([`Notification | `SourceControl | `Window] [@js.enum])) or_enum -> unit [@@js.set "location"]
      val get_title: t -> string [@@js.get "title"]
      val set_title: t -> string -> unit [@@js.set "title"]
      val get_cancellable: t -> bool [@@js.get "cancellable"]
      val set_cancellable: t -> bool -> unit [@@js.set "cancellable"]
    end
    module[@js.scope "QuickInput"] QuickInput : sig
      type t = vscode_QuickInput
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_title: t -> string or_undefined [@@js.get "title"]
      val set_title: t -> string or_undefined -> unit [@@js.set "title"]
      val get_step: t -> float or_undefined [@@js.get "step"]
      val set_step: t -> float or_undefined -> unit [@@js.set "step"]
      val get_totalSteps: t -> float or_undefined [@@js.get "totalSteps"]
      val set_totalSteps: t -> float or_undefined -> unit [@@js.set "totalSteps"]
      val get_enabled: t -> bool [@@js.get "enabled"]
      val set_enabled: t -> bool -> unit [@@js.set "enabled"]
      val get_busy: t -> bool [@@js.get "busy"]
      val set_busy: t -> bool -> unit [@@js.set "busy"]
      val get_ignoreFocusOut: t -> bool [@@js.get "ignoreFocusOut"]
      val set_ignoreFocusOut: t -> bool -> unit [@@js.set "ignoreFocusOut"]
      val show: t -> unit [@@js.call "show"]
      val hide: t -> unit [@@js.call "hide"]
      val get_onDidHide: t -> unit vscode_Event [@@js.get "onDidHide"]
      val set_onDidHide: t -> unit vscode_Event -> unit [@@js.set "onDidHide"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "QuickPick"] QuickPick : sig
      type 'T t = 'T vscode_QuickPick
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_value: 'T t -> string [@@js.get "value"]
      val set_value: 'T t -> string -> unit [@@js.set "value"]
      val get_placeholder: 'T t -> string or_undefined [@@js.get "placeholder"]
      val set_placeholder: 'T t -> string or_undefined -> unit [@@js.set "placeholder"]
      val get_onDidChangeValue: 'T t -> string vscode_Event [@@js.get "onDidChangeValue"]
      val get_onDidAccept: 'T t -> unit vscode_Event [@@js.get "onDidAccept"]
      val get_buttons: 'T t -> vscode_QuickInputButton list [@@js.get "buttons"]
      val set_buttons: 'T t -> vscode_QuickInputButton list -> unit [@@js.set "buttons"]
      val get_onDidTriggerButton: 'T t -> vscode_QuickInputButton vscode_Event [@@js.get "onDidTriggerButton"]
      val get_items: 'T t -> 'T list [@@js.get "items"]
      val set_items: 'T t -> 'T list -> unit [@@js.set "items"]
      val get_canSelectMany: 'T t -> bool [@@js.get "canSelectMany"]
      val set_canSelectMany: 'T t -> bool -> unit [@@js.set "canSelectMany"]
      val get_matchOnDescription: 'T t -> bool [@@js.get "matchOnDescription"]
      val set_matchOnDescription: 'T t -> bool -> unit [@@js.set "matchOnDescription"]
      val get_matchOnDetail: 'T t -> bool [@@js.get "matchOnDetail"]
      val set_matchOnDetail: 'T t -> bool -> unit [@@js.set "matchOnDetail"]
      val get_activeItems: 'T t -> 'T list [@@js.get "activeItems"]
      val set_activeItems: 'T t -> 'T list -> unit [@@js.set "activeItems"]
      val get_onDidChangeActive: 'T t -> 'T list vscode_Event [@@js.get "onDidChangeActive"]
      val get_selectedItems: 'T t -> 'T list [@@js.get "selectedItems"]
      val set_selectedItems: 'T t -> 'T list -> unit [@@js.set "selectedItems"]
      val get_onDidChangeSelection: 'T t -> 'T list vscode_Event [@@js.get "onDidChangeSelection"]
      val cast: 'T t -> vscode_QuickInput [@@js.cast]
    end
    module[@js.scope "InputBox"] InputBox : sig
      type t = vscode_InputBox
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_value: t -> string [@@js.get "value"]
      val set_value: t -> string -> unit [@@js.set "value"]
      val get_placeholder: t -> string or_undefined [@@js.get "placeholder"]
      val set_placeholder: t -> string or_undefined -> unit [@@js.set "placeholder"]
      val get_password: t -> bool [@@js.get "password"]
      val set_password: t -> bool -> unit [@@js.set "password"]
      val get_onDidChangeValue: t -> string vscode_Event [@@js.get "onDidChangeValue"]
      val get_onDidAccept: t -> unit vscode_Event [@@js.get "onDidAccept"]
      val get_buttons: t -> vscode_QuickInputButton list [@@js.get "buttons"]
      val set_buttons: t -> vscode_QuickInputButton list -> unit [@@js.set "buttons"]
      val get_onDidTriggerButton: t -> vscode_QuickInputButton vscode_Event [@@js.get "onDidTriggerButton"]
      val get_prompt: t -> string or_undefined [@@js.get "prompt"]
      val set_prompt: t -> string or_undefined -> unit [@@js.set "prompt"]
      val get_validationMessage: t -> string or_undefined [@@js.get "validationMessage"]
      val set_validationMessage: t -> string or_undefined -> unit [@@js.set "validationMessage"]
      val cast: t -> vscode_QuickInput [@@js.cast]
    end
    module[@js.scope "QuickInputButton"] QuickInputButton : sig
      type t = vscode_QuickInputButton
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_iconPath: t -> (vscode_ThemeIcon, vscode_Uri, anonymous_interface_14) union3 [@@js.get "iconPath"]
      val get_tooltip: t -> string or_undefined [@@js.get "tooltip"]
    end
    module[@js.scope "QuickInputButtons"] QuickInputButtons : sig
      type t = vscode_QuickInputButtons
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_Back: unit -> vscode_QuickInputButton [@@js.get "Back"]
      val create: unit -> t [@@js.create]
    end
    module[@js.scope "TextDocumentContentChangeEvent"] TextDocumentContentChangeEvent : sig
      type t = vscode_TextDocumentContentChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_range: t -> vscode_Range [@@js.get "range"]
      val get_rangeOffset: t -> float [@@js.get "rangeOffset"]
      val get_rangeLength: t -> float [@@js.get "rangeLength"]
      val get_text: t -> string [@@js.get "text"]
    end
    module[@js.scope "TextDocumentChangeEvent"] TextDocumentChangeEvent : sig
      type t = vscode_TextDocumentChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_document: t -> vscode_TextDocument [@@js.get "document"]
      val get_contentChanges: t -> vscode_TextDocumentContentChangeEvent list [@@js.get "contentChanges"]
    end
    module TextDocumentSaveReason : sig
      type t = vscode_TextDocumentSaveReason
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "TextDocumentWillSaveEvent"] TextDocumentWillSaveEvent : sig
      type t = vscode_TextDocumentWillSaveEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_document: t -> vscode_TextDocument [@@js.get "document"]
      val get_reason: t -> vscode_TextDocumentSaveReason [@@js.get "reason"]
      val waitUntil: t -> thenable:vscode_TextEdit list _Thenable -> unit [@@js.call "waitUntil"]
      val waitUntil': t -> thenable:any _Thenable -> unit [@@js.call "waitUntil"]
    end
    module[@js.scope "FileWillCreateEvent"] FileWillCreateEvent : sig
      type t = vscode_FileWillCreateEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_files: t -> vscode_Uri list [@@js.get "files"]
      val waitUntil: t -> thenable:vscode_WorkspaceEdit _Thenable -> unit [@@js.call "waitUntil"]
      val waitUntil': t -> thenable:any _Thenable -> unit [@@js.call "waitUntil"]
    end
    module[@js.scope "FileCreateEvent"] FileCreateEvent : sig
      type t = vscode_FileCreateEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_files: t -> vscode_Uri list [@@js.get "files"]
    end
    module[@js.scope "FileWillDeleteEvent"] FileWillDeleteEvent : sig
      type t = vscode_FileWillDeleteEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_files: t -> vscode_Uri list [@@js.get "files"]
      val waitUntil: t -> thenable:vscode_WorkspaceEdit _Thenable -> unit [@@js.call "waitUntil"]
      val waitUntil': t -> thenable:any _Thenable -> unit [@@js.call "waitUntil"]
    end
    module[@js.scope "FileDeleteEvent"] FileDeleteEvent : sig
      type t = vscode_FileDeleteEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_files: t -> vscode_Uri list [@@js.get "files"]
    end
    module[@js.scope "FileWillRenameEvent"] FileWillRenameEvent : sig
      type t = vscode_FileWillRenameEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_files: t -> anonymous_interface_19 list [@@js.get "files"]
      val waitUntil: t -> thenable:vscode_WorkspaceEdit _Thenable -> unit [@@js.call "waitUntil"]
      val waitUntil': t -> thenable:any _Thenable -> unit [@@js.call "waitUntil"]
    end
    module[@js.scope "FileRenameEvent"] FileRenameEvent : sig
      type t = vscode_FileRenameEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_files: t -> anonymous_interface_19 list [@@js.get "files"]
    end
    module[@js.scope "WorkspaceFoldersChangeEvent"] WorkspaceFoldersChangeEvent : sig
      type t = vscode_WorkspaceFoldersChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_added: t -> vscode_WorkspaceFolder list [@@js.get "added"]
      val get_removed: t -> vscode_WorkspaceFolder list [@@js.get "removed"]
    end
    module[@js.scope "WorkspaceFolder"] WorkspaceFolder : sig
      type t = vscode_WorkspaceFolder
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_uri: t -> vscode_Uri [@@js.get "uri"]
      val get_name: t -> string [@@js.get "name"]
      val get_index: t -> float [@@js.get "index"]
    end
    module[@js.scope "workspace"] Workspace : sig
      val fs: vscode_FileSystem [@@js.global "fs"]
      val rootPath: string or_undefined [@@js.global "rootPath"]
      val workspaceFolders: vscode_WorkspaceFolder list or_undefined [@@js.global "workspaceFolders"]
      val name: string or_undefined [@@js.global "name"]
      val workspaceFile: vscode_Uri or_undefined [@@js.global "workspaceFile"]
      val onDidChangeWorkspaceFolders: vscode_WorkspaceFoldersChangeEvent vscode_Event [@@js.global "onDidChangeWorkspaceFolders"]
      val getWorkspaceFolder: uri:vscode_Uri -> vscode_WorkspaceFolder or_undefined [@@js.global "getWorkspaceFolder"]
      val asRelativePath: pathOrUri:vscode_Uri or_string -> ?includeWorkspaceFolder:bool -> unit -> string [@@js.global "asRelativePath"]
      val updateWorkspaceFolders: start:float -> deleteCount:float or_null_or_undefined -> workspaceFoldersToAdd:(anonymous_interface_36 list [@js.variadic]) -> bool [@@js.global "updateWorkspaceFolders"]
      val createFileSystemWatcher: globPattern:vscode_GlobPattern -> ?ignoreCreateEvents:bool -> ?ignoreChangeEvents:bool -> ?ignoreDeleteEvents:bool -> unit -> vscode_FileSystemWatcher [@@js.global "createFileSystemWatcher"]
      val findFiles: include_:vscode_GlobPattern -> ?exclude:vscode_GlobPattern or_null -> ?maxResults:float -> ?token:vscode_CancellationToken -> unit -> vscode_Uri list _Thenable [@@js.global "findFiles"]
      val saveAll: ?includeUntitled:bool -> unit -> bool _Thenable [@@js.global "saveAll"]
      val applyEdit: edit:vscode_WorkspaceEdit -> bool _Thenable [@@js.global "applyEdit"]
      val textDocuments: vscode_TextDocument list [@@js.global "textDocuments"]
      val openTextDocument: uri:vscode_Uri -> vscode_TextDocument _Thenable [@@js.global "openTextDocument"]
      val openTextDocument: fileName:string -> vscode_TextDocument _Thenable [@@js.global "openTextDocument"]
      val openTextDocument: ?options:anonymous_interface_12 -> unit -> vscode_TextDocument _Thenable [@@js.global "openTextDocument"]
      val registerTextDocumentContentProvider: scheme:string -> provider:vscode_TextDocumentContentProvider -> vscode_Disposable [@@js.global "registerTextDocumentContentProvider"]
      val onDidOpenTextDocument: vscode_TextDocument vscode_Event [@@js.global "onDidOpenTextDocument"]
      val onDidCloseTextDocument: vscode_TextDocument vscode_Event [@@js.global "onDidCloseTextDocument"]
      val onDidChangeTextDocument: vscode_TextDocumentChangeEvent vscode_Event [@@js.global "onDidChangeTextDocument"]
      val onWillSaveTextDocument: vscode_TextDocumentWillSaveEvent vscode_Event [@@js.global "onWillSaveTextDocument"]
      val onDidSaveTextDocument: vscode_TextDocument vscode_Event [@@js.global "onDidSaveTextDocument"]
      val onWillCreateFiles: vscode_FileWillCreateEvent vscode_Event [@@js.global "onWillCreateFiles"]
      val onDidCreateFiles: vscode_FileCreateEvent vscode_Event [@@js.global "onDidCreateFiles"]
      val onWillDeleteFiles: vscode_FileWillDeleteEvent vscode_Event [@@js.global "onWillDeleteFiles"]
      val onDidDeleteFiles: vscode_FileDeleteEvent vscode_Event [@@js.global "onDidDeleteFiles"]
      val onWillRenameFiles: vscode_FileWillRenameEvent vscode_Event [@@js.global "onWillRenameFiles"]
      val onDidRenameFiles: vscode_FileRenameEvent vscode_Event [@@js.global "onDidRenameFiles"]
      val getConfiguration: ?section:string or_undefined -> ?scope:vscode_ConfigurationScope or_null -> unit -> vscode_WorkspaceConfiguration [@@js.global "getConfiguration"]
      val onDidChangeConfiguration: vscode_ConfigurationChangeEvent vscode_Event [@@js.global "onDidChangeConfiguration"]
      val registerTaskProvider: type_:string -> provider:vscode_Task vscode_TaskProvider -> vscode_Disposable [@@js.global "registerTaskProvider"]
      val registerFileSystemProvider: scheme:string -> provider:vscode_FileSystemProvider -> ?options:anonymous_interface_9 -> unit -> vscode_Disposable [@@js.global "registerFileSystemProvider"]
    end
    module ConfigurationScope : sig
      type t = vscode_ConfigurationScope
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "ConfigurationChangeEvent"] ConfigurationChangeEvent : sig
      type t = vscode_ConfigurationChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val affectsConfiguration: t -> section:string -> ?scope:vscode_ConfigurationScope -> unit -> bool [@@js.call "affectsConfiguration"]
    end
    module[@js.scope "languages"] Languages : sig
      val getLanguages: unit -> string list _Thenable [@@js.global "getLanguages"]
      val setTextDocumentLanguage: document:vscode_TextDocument -> languageId:string -> vscode_TextDocument _Thenable [@@js.global "setTextDocumentLanguage"]
      val match_: selector:vscode_DocumentSelector -> document:vscode_TextDocument -> float [@@js.global "match"]
      val onDidChangeDiagnostics: vscode_DiagnosticChangeEvent vscode_Event [@@js.global "onDidChangeDiagnostics"]
      val getDiagnostics: resource:vscode_Uri -> vscode_Diagnostic list [@@js.global "getDiagnostics"]
      val getDiagnostics: unit -> (vscode_Uri * vscode_Diagnostic list) list [@@js.global "getDiagnostics"]
      val createDiagnosticCollection: ?name:string -> unit -> vscode_DiagnosticCollection [@@js.global "createDiagnosticCollection"]
      val registerCompletionItemProvider: selector:vscode_DocumentSelector -> provider:vscode_CompletionItem vscode_CompletionItemProvider -> triggerCharacters:(string list [@js.variadic]) -> vscode_Disposable [@@js.global "registerCompletionItemProvider"]
      val registerCodeActionsProvider: selector:vscode_DocumentSelector -> provider:vscode_CodeAction vscode_CodeActionProvider -> ?metadata:vscode_CodeActionProviderMetadata -> unit -> vscode_Disposable [@@js.global "registerCodeActionsProvider"]
      val registerCodeLensProvider: selector:vscode_DocumentSelector -> provider:vscode_CodeLens vscode_CodeLensProvider -> vscode_Disposable [@@js.global "registerCodeLensProvider"]
      val registerDefinitionProvider: selector:vscode_DocumentSelector -> provider:vscode_DefinitionProvider -> vscode_Disposable [@@js.global "registerDefinitionProvider"]
      val registerImplementationProvider: selector:vscode_DocumentSelector -> provider:vscode_ImplementationProvider -> vscode_Disposable [@@js.global "registerImplementationProvider"]
      val registerTypeDefinitionProvider: selector:vscode_DocumentSelector -> provider:vscode_TypeDefinitionProvider -> vscode_Disposable [@@js.global "registerTypeDefinitionProvider"]
      val registerDeclarationProvider: selector:vscode_DocumentSelector -> provider:vscode_DeclarationProvider -> vscode_Disposable [@@js.global "registerDeclarationProvider"]
      val registerHoverProvider: selector:vscode_DocumentSelector -> provider:vscode_HoverProvider -> vscode_Disposable [@@js.global "registerHoverProvider"]
      val registerEvaluatableExpressionProvider: selector:vscode_DocumentSelector -> provider:vscode_EvaluatableExpressionProvider -> vscode_Disposable [@@js.global "registerEvaluatableExpressionProvider"]
      val registerInlineValuesProvider: selector:vscode_DocumentSelector -> provider:vscode_InlineValuesProvider -> vscode_Disposable [@@js.global "registerInlineValuesProvider"]
      val registerDocumentHighlightProvider: selector:vscode_DocumentSelector -> provider:vscode_DocumentHighlightProvider -> vscode_Disposable [@@js.global "registerDocumentHighlightProvider"]
      val registerDocumentSymbolProvider: selector:vscode_DocumentSelector -> provider:vscode_DocumentSymbolProvider -> ?metaData:vscode_DocumentSymbolProviderMetadata -> unit -> vscode_Disposable [@@js.global "registerDocumentSymbolProvider"]
      val registerWorkspaceSymbolProvider: provider:vscode_SymbolInformation vscode_WorkspaceSymbolProvider -> vscode_Disposable [@@js.global "registerWorkspaceSymbolProvider"]
      val registerReferenceProvider: selector:vscode_DocumentSelector -> provider:vscode_ReferenceProvider -> vscode_Disposable [@@js.global "registerReferenceProvider"]
      val registerRenameProvider: selector:vscode_DocumentSelector -> provider:vscode_RenameProvider -> vscode_Disposable [@@js.global "registerRenameProvider"]
      val registerDocumentSemanticTokensProvider: selector:vscode_DocumentSelector -> provider:vscode_DocumentSemanticTokensProvider -> legend:vscode_SemanticTokensLegend -> vscode_Disposable [@@js.global "registerDocumentSemanticTokensProvider"]
      val registerDocumentRangeSemanticTokensProvider: selector:vscode_DocumentSelector -> provider:vscode_DocumentRangeSemanticTokensProvider -> legend:vscode_SemanticTokensLegend -> vscode_Disposable [@@js.global "registerDocumentRangeSemanticTokensProvider"]
      val registerDocumentFormattingEditProvider: selector:vscode_DocumentSelector -> provider:vscode_DocumentFormattingEditProvider -> vscode_Disposable [@@js.global "registerDocumentFormattingEditProvider"]
      val registerDocumentRangeFormattingEditProvider: selector:vscode_DocumentSelector -> provider:vscode_DocumentRangeFormattingEditProvider -> vscode_Disposable [@@js.global "registerDocumentRangeFormattingEditProvider"]
      val registerOnTypeFormattingEditProvider: selector:vscode_DocumentSelector -> provider:vscode_OnTypeFormattingEditProvider -> firstTriggerCharacter:string -> moreTriggerCharacter:(string list [@js.variadic]) -> vscode_Disposable [@@js.global "registerOnTypeFormattingEditProvider"]
      val registerSignatureHelpProvider: selector:vscode_DocumentSelector -> provider:vscode_SignatureHelpProvider -> triggerCharacters:(string list [@js.variadic]) -> vscode_Disposable [@@js.global "registerSignatureHelpProvider"]
      val registerSignatureHelpProvider: selector:vscode_DocumentSelector -> provider:vscode_SignatureHelpProvider -> metadata:vscode_SignatureHelpProviderMetadata -> vscode_Disposable [@@js.global "registerSignatureHelpProvider"]
      val registerDocumentLinkProvider: selector:vscode_DocumentSelector -> provider:vscode_DocumentLink vscode_DocumentLinkProvider -> vscode_Disposable [@@js.global "registerDocumentLinkProvider"]
      val registerColorProvider: selector:vscode_DocumentSelector -> provider:vscode_DocumentColorProvider -> vscode_Disposable [@@js.global "registerColorProvider"]
      val registerFoldingRangeProvider: selector:vscode_DocumentSelector -> provider:vscode_FoldingRangeProvider -> vscode_Disposable [@@js.global "registerFoldingRangeProvider"]
      val registerSelectionRangeProvider: selector:vscode_DocumentSelector -> provider:vscode_SelectionRangeProvider -> vscode_Disposable [@@js.global "registerSelectionRangeProvider"]
      val registerCallHierarchyProvider: selector:vscode_DocumentSelector -> provider:vscode_CallHierarchyProvider -> vscode_Disposable [@@js.global "registerCallHierarchyProvider"]
      val registerLinkedEditingRangeProvider: selector:vscode_DocumentSelector -> provider:vscode_LinkedEditingRangeProvider -> vscode_Disposable [@@js.global "registerLinkedEditingRangeProvider"]
      val setLanguageConfiguration: language:string -> configuration:vscode_LanguageConfiguration -> vscode_Disposable [@@js.global "setLanguageConfiguration"]
    end
    module[@js.scope "SourceControlInputBox"] SourceControlInputBox : sig
      type t = vscode_SourceControlInputBox
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_value: t -> string [@@js.get "value"]
      val set_value: t -> string -> unit [@@js.set "value"]
      val get_placeholder: t -> string [@@js.get "placeholder"]
      val set_placeholder: t -> string -> unit [@@js.set "placeholder"]
      val get_visible: t -> bool [@@js.get "visible"]
      val set_visible: t -> bool -> unit [@@js.set "visible"]
    end
    module[@js.scope "QuickDiffProvider"] QuickDiffProvider : sig
      type t = vscode_QuickDiffProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideOriginalResource: t -> uri:vscode_Uri -> token:vscode_CancellationToken -> vscode_Uri vscode_ProviderResult [@@js.call "provideOriginalResource"]
    end
    module[@js.scope "SourceControlResourceThemableDecorations"] SourceControlResourceThemableDecorations : sig
      type t = vscode_SourceControlResourceThemableDecorations
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_iconPath: t -> vscode_Uri or_string [@@js.get "iconPath"]
    end
    module[@js.scope "SourceControlResourceDecorations"] SourceControlResourceDecorations : sig
      type t = vscode_SourceControlResourceDecorations
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_strikeThrough: t -> bool [@@js.get "strikeThrough"]
      val get_faded: t -> bool [@@js.get "faded"]
      val get_tooltip: t -> string [@@js.get "tooltip"]
      val get_light: t -> vscode_SourceControlResourceThemableDecorations [@@js.get "light"]
      val get_dark: t -> vscode_SourceControlResourceThemableDecorations [@@js.get "dark"]
      val cast: t -> vscode_SourceControlResourceThemableDecorations [@@js.cast]
    end
    module[@js.scope "SourceControlResourceState"] SourceControlResourceState : sig
      type t = vscode_SourceControlResourceState
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_resourceUri: t -> vscode_Uri [@@js.get "resourceUri"]
      val get_command: t -> vscode_Command [@@js.get "command"]
      val get_decorations: t -> vscode_SourceControlResourceDecorations [@@js.get "decorations"]
      val get_contextValue: t -> string [@@js.get "contextValue"]
    end
    module[@js.scope "SourceControlResourceGroup"] SourceControlResourceGroup : sig
      type t = vscode_SourceControlResourceGroup
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val get_hideWhenEmpty: t -> bool [@@js.get "hideWhenEmpty"]
      val set_hideWhenEmpty: t -> bool -> unit [@@js.set "hideWhenEmpty"]
      val get_resourceStates: t -> vscode_SourceControlResourceState list [@@js.get "resourceStates"]
      val set_resourceStates: t -> vscode_SourceControlResourceState list -> unit [@@js.set "resourceStates"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "SourceControl"] SourceControl : sig
      type t = vscode_SourceControl
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val get_label: t -> string [@@js.get "label"]
      val get_rootUri: t -> vscode_Uri or_undefined [@@js.get "rootUri"]
      val get_inputBox: t -> vscode_SourceControlInputBox [@@js.get "inputBox"]
      val get_count: t -> float [@@js.get "count"]
      val set_count: t -> float -> unit [@@js.set "count"]
      val get_quickDiffProvider: t -> vscode_QuickDiffProvider [@@js.get "quickDiffProvider"]
      val set_quickDiffProvider: t -> vscode_QuickDiffProvider -> unit [@@js.set "quickDiffProvider"]
      val get_commitTemplate: t -> string [@@js.get "commitTemplate"]
      val set_commitTemplate: t -> string -> unit [@@js.set "commitTemplate"]
      val get_acceptInputCommand: t -> vscode_Command [@@js.get "acceptInputCommand"]
      val set_acceptInputCommand: t -> vscode_Command -> unit [@@js.set "acceptInputCommand"]
      val get_statusBarCommands: t -> vscode_Command list [@@js.get "statusBarCommands"]
      val set_statusBarCommands: t -> vscode_Command list -> unit [@@js.set "statusBarCommands"]
      val createResourceGroup: t -> id:string -> label:string -> vscode_SourceControlResourceGroup [@@js.call "createResourceGroup"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "scm"] Scm : sig
      val inputBox: vscode_SourceControlInputBox [@@js.global "inputBox"]
      val createSourceControl: id:string -> label:string -> ?rootUri:vscode_Uri -> unit -> vscode_SourceControl [@@js.global "createSourceControl"]
    end
    module DebugProtocolMessage : sig
      type t = vscode_DebugProtocolMessage
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module DebugProtocolSource : sig
      type t = vscode_DebugProtocolSource
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module DebugProtocolBreakpoint : sig
      type t = vscode_DebugProtocolBreakpoint
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "DebugConfiguration"] DebugConfiguration : sig
      type t = vscode_DebugConfiguration
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> string [@@js.get "type"]
      val set_type: t -> string -> unit [@@js.set "type"]
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_request: t -> string [@@js.get "request"]
      val set_request: t -> string -> unit [@@js.set "request"]
      val get: t -> string -> any [@@js.index_get]
      val set: t -> string -> any -> unit [@@js.index_set]
    end
    module[@js.scope "DebugSession"] DebugSession : sig
      type t = vscode_DebugSession
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val get_type: t -> string [@@js.get "type"]
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_workspaceFolder: t -> vscode_WorkspaceFolder or_undefined [@@js.get "workspaceFolder"]
      val get_configuration: t -> vscode_DebugConfiguration [@@js.get "configuration"]
      val customRequest: t -> command:string -> ?args:any -> unit -> any _Thenable [@@js.call "customRequest"]
      val getDebugProtocolBreakpoint: t -> breakpoint:vscode_Breakpoint -> vscode_DebugProtocolBreakpoint or_undefined _Thenable [@@js.call "getDebugProtocolBreakpoint"]
    end
    module[@js.scope "DebugSessionCustomEvent"] DebugSessionCustomEvent : sig
      type t = vscode_DebugSessionCustomEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_session: t -> vscode_DebugSession [@@js.get "session"]
      val get_event: t -> string [@@js.get "event"]
      val get_body: t -> any [@@js.get "body"]
    end
    module[@js.scope "DebugConfigurationProvider"] DebugConfigurationProvider : sig
      type t = vscode_DebugConfigurationProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideDebugConfigurations: t -> folder:vscode_WorkspaceFolder or_undefined -> ?token:vscode_CancellationToken -> unit -> vscode_DebugConfiguration list vscode_ProviderResult [@@js.call "provideDebugConfigurations"]
      val resolveDebugConfiguration: t -> folder:vscode_WorkspaceFolder or_undefined -> debugConfiguration:vscode_DebugConfiguration -> ?token:vscode_CancellationToken -> unit -> vscode_DebugConfiguration vscode_ProviderResult [@@js.call "resolveDebugConfiguration"]
      val resolveDebugConfigurationWithSubstitutedVariables: t -> folder:vscode_WorkspaceFolder or_undefined -> debugConfiguration:vscode_DebugConfiguration -> ?token:vscode_CancellationToken -> unit -> vscode_DebugConfiguration vscode_ProviderResult [@@js.call "resolveDebugConfigurationWithSubstitutedVariables"]
    end
    module[@js.scope "DebugAdapterExecutable"] DebugAdapterExecutable : sig
      type t = vscode_DebugAdapterExecutable
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: command:string -> ?args:string list -> ?options:vscode_DebugAdapterExecutableOptions -> unit -> t [@@js.create]
      val get_command: t -> string [@@js.get "command"]
      val get_args: t -> string list [@@js.get "args"]
      val get_options: t -> vscode_DebugAdapterExecutableOptions [@@js.get "options"]
    end
    module[@js.scope "DebugAdapterExecutableOptions"] DebugAdapterExecutableOptions : sig
      type t = vscode_DebugAdapterExecutableOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_env: t -> anonymous_interface_44 [@@js.get "env"]
      val set_env: t -> anonymous_interface_44 -> unit [@@js.set "env"]
      val get_cwd: t -> string [@@js.get "cwd"]
      val set_cwd: t -> string -> unit [@@js.set "cwd"]
    end
    module[@js.scope "DebugAdapterServer"] DebugAdapterServer : sig
      type t = vscode_DebugAdapterServer
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_port: t -> float [@@js.get "port"]
      val get_host: t -> string [@@js.get "host"]
      val create: port:float -> ?host:string -> unit -> t [@@js.create]
    end
    module[@js.scope "DebugAdapterNamedPipeServer"] DebugAdapterNamedPipeServer : sig
      type t = vscode_DebugAdapterNamedPipeServer
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_path: t -> string [@@js.get "path"]
      val create: path:string -> t [@@js.create]
    end
    module[@js.scope "DebugAdapter"] DebugAdapter : sig
      type t = vscode_DebugAdapter
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidSendMessage: t -> vscode_DebugProtocolMessage vscode_Event [@@js.get "onDidSendMessage"]
      val handleMessage: t -> message:vscode_DebugProtocolMessage -> unit [@@js.call "handleMessage"]
      val cast: t -> vscode_Disposable [@@js.cast]
    end
    module[@js.scope "DebugAdapterInlineImplementation"] DebugAdapterInlineImplementation : sig
      type t = vscode_DebugAdapterInlineImplementation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: implementation:vscode_DebugAdapter -> t [@@js.create]
    end
    module DebugAdapterDescriptor : sig
      type t = vscode_DebugAdapterDescriptor
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "DebugAdapterDescriptorFactory"] DebugAdapterDescriptorFactory : sig
      type t = vscode_DebugAdapterDescriptorFactory
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val createDebugAdapterDescriptor: t -> session:vscode_DebugSession -> executable:vscode_DebugAdapterExecutable or_undefined -> vscode_DebugAdapterDescriptor vscode_ProviderResult [@@js.call "createDebugAdapterDescriptor"]
    end
    module[@js.scope "DebugAdapterTracker"] DebugAdapterTracker : sig
      type t = vscode_DebugAdapterTracker
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val onWillStartSession: t -> unit [@@js.call "onWillStartSession"]
      val onWillReceiveMessage: t -> message:any -> unit [@@js.call "onWillReceiveMessage"]
      val onDidSendMessage: t -> message:any -> unit [@@js.call "onDidSendMessage"]
      val onWillStopSession: t -> unit [@@js.call "onWillStopSession"]
      val onError: t -> error:Error.t_0 -> unit [@@js.call "onError"]
      val onExit: t -> code:float or_undefined -> signal:string or_undefined -> unit [@@js.call "onExit"]
    end
    module[@js.scope "DebugAdapterTrackerFactory"] DebugAdapterTrackerFactory : sig
      type t = vscode_DebugAdapterTrackerFactory
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val createDebugAdapterTracker: t -> session:vscode_DebugSession -> vscode_DebugAdapterTracker vscode_ProviderResult [@@js.call "createDebugAdapterTracker"]
    end
    module[@js.scope "DebugConsole"] DebugConsole : sig
      type t = vscode_DebugConsole
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val append: t -> value:string -> unit [@@js.call "append"]
      val appendLine: t -> value:string -> unit [@@js.call "appendLine"]
    end
    module[@js.scope "BreakpointsChangeEvent"] BreakpointsChangeEvent : sig
      type t = vscode_BreakpointsChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_added: t -> vscode_Breakpoint list [@@js.get "added"]
      val get_removed: t -> vscode_Breakpoint list [@@js.get "removed"]
      val get_changed: t -> vscode_Breakpoint list [@@js.get "changed"]
    end
    module[@js.scope "Breakpoint"] Breakpoint : sig
      type t = vscode_Breakpoint
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val get_enabled: t -> bool [@@js.get "enabled"]
      val get_condition: t -> string [@@js.get "condition"]
      val get_hitCondition: t -> string [@@js.get "hitCondition"]
      val get_logMessage: t -> string [@@js.get "logMessage"]
      val create: ?enabled:bool -> ?condition:string -> ?hitCondition:string -> ?logMessage:string -> unit -> t [@@js.create]
    end
    module[@js.scope "SourceBreakpoint"] SourceBreakpoint : sig
      type t = vscode_SourceBreakpoint
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_location: t -> vscode_Location [@@js.get "location"]
      val create: location:vscode_Location -> ?enabled:bool -> ?condition:string -> ?hitCondition:string -> ?logMessage:string -> unit -> t [@@js.create]
      val cast: t -> vscode_Breakpoint [@@js.cast]
    end
    module[@js.scope "FunctionBreakpoint"] FunctionBreakpoint : sig
      type t = vscode_FunctionBreakpoint
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_functionName: t -> string [@@js.get "functionName"]
      val create: functionName:string -> ?enabled:bool -> ?condition:string -> ?hitCondition:string -> ?logMessage:string -> unit -> t [@@js.create]
      val cast: t -> vscode_Breakpoint [@@js.cast]
    end
    module DebugConsoleMode : sig
      type t = vscode_DebugConsoleMode
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "DebugSessionOptions"] DebugSessionOptions : sig
      type t = vscode_DebugSessionOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_parentSession: t -> vscode_DebugSession [@@js.get "parentSession"]
      val set_parentSession: t -> vscode_DebugSession -> unit [@@js.set "parentSession"]
      val get_consoleMode: t -> vscode_DebugConsoleMode [@@js.get "consoleMode"]
      val set_consoleMode: t -> vscode_DebugConsoleMode -> unit [@@js.set "consoleMode"]
      val get_noDebug: t -> bool [@@js.get "noDebug"]
      val set_noDebug: t -> bool -> unit [@@js.set "noDebug"]
      val get_compact: t -> bool [@@js.get "compact"]
      val set_compact: t -> bool -> unit [@@js.set "compact"]
    end
    module DebugConfigurationProviderTriggerKind : sig
      type t = vscode_DebugConfigurationProviderTriggerKind
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "debug"] Debug : sig
      val activeDebugSession: vscode_DebugSession or_undefined [@@js.global "activeDebugSession"]
      val activeDebugConsole: vscode_DebugConsole [@@js.global "activeDebugConsole"]
      val breakpoints: vscode_Breakpoint list [@@js.global "breakpoints"]
      val onDidChangeActiveDebugSession: vscode_DebugSession or_undefined vscode_Event [@@js.global "onDidChangeActiveDebugSession"]
      val onDidStartDebugSession: vscode_DebugSession vscode_Event [@@js.global "onDidStartDebugSession"]
      val onDidReceiveDebugSessionCustomEvent: vscode_DebugSessionCustomEvent vscode_Event [@@js.global "onDidReceiveDebugSessionCustomEvent"]
      val onDidTerminateDebugSession: vscode_DebugSession vscode_Event [@@js.global "onDidTerminateDebugSession"]
      val onDidChangeBreakpoints: vscode_BreakpointsChangeEvent vscode_Event [@@js.global "onDidChangeBreakpoints"]
      val registerDebugConfigurationProvider: debugType:string -> provider:vscode_DebugConfigurationProvider -> ?triggerKind:vscode_DebugConfigurationProviderTriggerKind -> unit -> vscode_Disposable [@@js.global "registerDebugConfigurationProvider"]
      val registerDebugAdapterDescriptorFactory: debugType:string -> factory:vscode_DebugAdapterDescriptorFactory -> vscode_Disposable [@@js.global "registerDebugAdapterDescriptorFactory"]
      val registerDebugAdapterTrackerFactory: debugType:string -> factory:vscode_DebugAdapterTrackerFactory -> vscode_Disposable [@@js.global "registerDebugAdapterTrackerFactory"]
      val startDebugging: folder:vscode_WorkspaceFolder or_undefined -> nameOrConfiguration:vscode_DebugConfiguration or_string -> ?parentSessionOrOptions:(vscode_DebugSession, vscode_DebugSessionOptions) union2 -> unit -> bool _Thenable [@@js.global "startDebugging"]
      val stopDebugging: ?session:vscode_DebugSession -> unit -> unit _Thenable [@@js.global "stopDebugging"]
      val addBreakpoints: breakpoints:vscode_Breakpoint list -> unit [@@js.global "addBreakpoints"]
      val removeBreakpoints: breakpoints:vscode_Breakpoint list -> unit [@@js.global "removeBreakpoints"]
      val asDebugSourceUri: source:vscode_DebugProtocolSource -> ?session:vscode_DebugSession -> unit -> vscode_Uri [@@js.global "asDebugSourceUri"]
    end
    module[@js.scope "extensions"] Extensions : sig
      val getExtension: extensionId:string -> any vscode_Extension or_undefined [@@js.global "getExtension"]
      val getExtension: extensionId:string -> 'T vscode_Extension or_undefined [@@js.global "getExtension"]
      val all: any vscode_Extension list [@@js.global "all"]
      val onDidChange: unit vscode_Event [@@js.global "onDidChange"]
    end
    module CommentThreadCollapsibleState : sig
      type t = vscode_CommentThreadCollapsibleState
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module CommentMode : sig
      type t = vscode_CommentMode
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "CommentThread"] CommentThread : sig
      type t = vscode_CommentThread
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_uri: t -> vscode_Uri [@@js.get "uri"]
      val get_range: t -> vscode_Range [@@js.get "range"]
      val set_range: t -> vscode_Range -> unit [@@js.set "range"]
      val get_comments: t -> vscode_Comment list [@@js.get "comments"]
      val set_comments: t -> vscode_Comment list -> unit [@@js.set "comments"]
      val get_collapsibleState: t -> vscode_CommentThreadCollapsibleState [@@js.get "collapsibleState"]
      val set_collapsibleState: t -> vscode_CommentThreadCollapsibleState -> unit [@@js.set "collapsibleState"]
      val get_canReply: t -> bool [@@js.get "canReply"]
      val set_canReply: t -> bool -> unit [@@js.set "canReply"]
      val get_contextValue: t -> string [@@js.get "contextValue"]
      val set_contextValue: t -> string -> unit [@@js.set "contextValue"]
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "CommentAuthorInformation"] CommentAuthorInformation : sig
      type t = vscode_CommentAuthorInformation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_iconPath: t -> vscode_Uri [@@js.get "iconPath"]
      val set_icon_path: t -> vscode_Uri -> unit [@@js.set "iconPath"]
    end
    module[@js.scope "CommentReaction"] CommentReaction : sig
      type t = vscode_CommentReaction
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_label: t -> string [@@js.get "label"]
      val get_iconPath: t -> vscode_Uri or_string [@@js.get "iconPath"]
      val get_count: t -> float [@@js.get "count"]
      val get_authorHasReacted: t -> bool [@@js.get "authorHasReacted"]
    end
    module[@js.scope "Comment"] Comment : sig
      type t = vscode_Comment
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_body: t -> vscode_MarkdownString or_string [@@js.get "body"]
      val set_body: t -> vscode_MarkdownString or_string -> unit [@@js.set "body"]
      val get_mode: t -> vscode_CommentMode [@@js.get "mode"]
      val set_mode: t -> vscode_CommentMode -> unit [@@js.set "mode"]
      val get_author: t -> vscode_CommentAuthorInformation [@@js.get "author"]
      val set_author: t -> vscode_CommentAuthorInformation -> unit [@@js.set "author"]
      val get_contextValue: t -> string [@@js.get "contextValue"]
      val set_contextValue: t -> string -> unit [@@js.set "contextValue"]
      val get_reactions: t -> vscode_CommentReaction list [@@js.get "reactions"]
      val set_reactions: t -> vscode_CommentReaction list -> unit [@@js.set "reactions"]
      val get_label: t -> string [@@js.get "label"]
      val set_label: t -> string -> unit [@@js.set "label"]
    end
    module[@js.scope "CommentReply"] CommentReply : sig
      type t = vscode_CommentReply
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_thread: t -> vscode_CommentThread [@@js.get "thread"]
      val set_thread: t -> vscode_CommentThread -> unit [@@js.set "thread"]
      val get_text: t -> string [@@js.get "text"]
      val set_text: t -> string -> unit [@@js.set "text"]
    end
    module[@js.scope "CommentingRangeProvider"] CommentingRangeProvider : sig
      type t = vscode_CommentingRangeProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val provideCommentingRanges: t -> document:vscode_TextDocument -> token:vscode_CancellationToken -> vscode_Range list vscode_ProviderResult [@@js.call "provideCommentingRanges"]
    end
    module[@js.scope "CommentOptions"] CommentOptions : sig
      type t = vscode_CommentOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_prompt: t -> string [@@js.get "prompt"]
      val set_prompt: t -> string -> unit [@@js.set "prompt"]
      val get_placeHolder: t -> string [@@js.get "placeHolder"]
      val set_placeHolder: t -> string -> unit [@@js.set "placeHolder"]
    end
    module[@js.scope "CommentController"] CommentController : sig
      type t = vscode_CommentController
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val get_label: t -> string [@@js.get "label"]
      val get_options: t -> vscode_CommentOptions [@@js.get "options"]
      val set_options: t -> vscode_CommentOptions -> unit [@@js.set "options"]
      val get_commentingRangeProvider: t -> vscode_CommentingRangeProvider [@@js.get "commentingRangeProvider"]
      val set_commentingRangeProvider: t -> vscode_CommentingRangeProvider -> unit [@@js.set "commentingRangeProvider"]
      val createCommentThread: t -> uri:vscode_Uri -> range:vscode_Range -> comments:vscode_Comment list -> vscode_CommentThread [@@js.call "createCommentThread"]
      val reactionHandler: t -> comment:vscode_Comment -> reaction:vscode_CommentReaction -> unit _Thenable [@@js.call "reactionHandler"]
      val dispose: t -> unit [@@js.call "dispose"]
    end
    module[@js.scope "comments"] Comments : sig
      val createCommentController: id:string -> label:string -> vscode_CommentController [@@js.global "createCommentController"]
    end
    module[@js.scope "AuthenticationSession"] AuthenticationSession : sig
      type t = vscode_AuthenticationSession
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val get_accessToken: t -> string [@@js.get "accessToken"]
      val get_account: t -> vscode_AuthenticationSessionAccountInformation [@@js.get "account"]
      val get_scopes: t -> string list [@@js.get "scopes"]
    end
    module[@js.scope "AuthenticationSessionAccountInformation"] AuthenticationSessionAccountInformation : sig
      type t = vscode_AuthenticationSessionAccountInformation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val get_label: t -> string [@@js.get "label"]
    end
    module[@js.scope "AuthenticationGetSessionOptions"] AuthenticationGetSessionOptions : sig
      type t = vscode_AuthenticationGetSessionOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_createIfNone: t -> bool [@@js.get "createIfNone"]
      val set_createIfNone: t -> bool -> unit [@@js.set "createIfNone"]
      val get_clearSessionPreference: t -> bool [@@js.get "clearSessionPreference"]
      val set_clearSessionPreference: t -> bool -> unit [@@js.set "clearSessionPreference"]
    end
    module[@js.scope "AuthenticationProviderInformation"] AuthenticationProviderInformation : sig
      type t = vscode_AuthenticationProviderInformation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_id: t -> string [@@js.get "id"]
      val get_label: t -> string [@@js.get "label"]
    end
    module[@js.scope "AuthenticationSessionsChangeEvent"] AuthenticationSessionsChangeEvent : sig
      type t = vscode_AuthenticationSessionsChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_provider: t -> vscode_AuthenticationProviderInformation [@@js.get "provider"]
    end
    module[@js.scope "AuthenticationProviderOptions"] AuthenticationProviderOptions : sig
      type t = vscode_AuthenticationProviderOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_supportsMultipleAccounts: t -> bool [@@js.get "supportsMultipleAccounts"]
    end
    module[@js.scope "AuthenticationProviderAuthenticationSessionsChangeEvent"] AuthenticationProviderAuthenticationSessionsChangeEvent : sig
      type t = vscode_AuthenticationProviderAuthenticationSessionsChangeEvent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_added: t -> vscode_AuthenticationSession list [@@js.get "added"]
      val get_removed: t -> vscode_AuthenticationSession list [@@js.get "removed"]
      val get_changed: t -> vscode_AuthenticationSession list [@@js.get "changed"]
    end
    module[@js.scope "AuthenticationProvider"] AuthenticationProvider : sig
      type t = vscode_AuthenticationProvider
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_onDidChangeSessions: t -> vscode_AuthenticationProviderAuthenticationSessionsChangeEvent vscode_Event [@@js.get "onDidChangeSessions"]
      val getSessions: t -> ?scopes:string list -> unit -> vscode_AuthenticationSession list _Thenable [@@js.call "getSessions"]
      val createSession: t -> scopes:string list -> vscode_AuthenticationSession _Thenable [@@js.call "createSession"]
      val removeSession: t -> sessionId:string -> unit _Thenable [@@js.call "removeSession"]
    end
    module[@js.scope "authentication"] Authentication : sig
      val getSession: providerId:string -> scopes:string list -> options:(vscode_AuthenticationGetSessionOptions, anonymous_interface_4) intersection2 -> vscode_AuthenticationSession _Thenable [@@js.global "getSession"]
      val getSession: providerId:string -> scopes:string list -> ?options:vscode_AuthenticationGetSessionOptions -> unit -> vscode_AuthenticationSession or_undefined _Thenable [@@js.global "getSession"]
      val onDidChangeSessions: vscode_AuthenticationSessionsChangeEvent vscode_Event [@@js.global "onDidChangeSessions"]
      val registerAuthenticationProvider: id:string -> label:string -> provider:vscode_AuthenticationProvider -> ?options:vscode_AuthenticationProviderOptions -> unit -> vscode_Disposable [@@js.global "registerAuthenticationProvider"]
    end
  end
  module[@js.scope "Thenable"] Thenable : sig
    type 'T t = 'T _Thenable
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val then_: 'T t -> ?onfulfilled:(value:'T -> ('TResult, 'TResult t) union2) -> ?onrejected:(reason:any -> ('TResult, 'TResult t) union2) -> unit -> 'TResult t [@@js.call "then"]
    val then_': 'T t -> ?onfulfilled:(value:'T -> ('TResult, 'TResult t) union2) -> ?onrejected:(reason:any -> unit) -> unit -> 'TResult t [@@js.call "then"]
  end
end
