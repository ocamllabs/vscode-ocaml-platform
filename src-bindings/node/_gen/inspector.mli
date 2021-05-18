[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Error
  - EventEmitter
 *)
[@@@js.stop]
module type Missing = sig
  module Error : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module EventEmitter : sig
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
    module EventEmitter : sig
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
    end
    module Types : sig
      open AnonymousInterfaces
      type inspector_Console_ConsoleMessage = [`Inspector_Console_ConsoleMessage] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Console_MessageAddedEventDataType = [`Inspector_Console_MessageAddedEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_BreakLocation = [`Inspector_Debugger_BreakLocation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_BreakpointId = string
      and inspector_Debugger_BreakpointResolvedEventDataType = [`Inspector_Debugger_BreakpointResolvedEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_CallFrame = [`Inspector_Debugger_CallFrame] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_CallFrameId = string
      and inspector_Debugger_ContinueToLocationParameterType = [`Inspector_Debugger_ContinueToLocationParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_EnableReturnType = [`Inspector_Debugger_EnableReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_EvaluateOnCallFrameParameterType = [`Inspector_Debugger_EvaluateOnCallFrameParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_EvaluateOnCallFrameReturnType = [`Inspector_Debugger_EvaluateOnCallFrameReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_GetPossibleBreakpointsParameterType = [`Inspector_Debugger_GetPossibleBreakpointsParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_GetPossibleBreakpointsReturnType = [`Inspector_Debugger_GetPossibleBreakpointsReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_GetScriptSourceParameterType = [`Inspector_Debugger_GetScriptSourceParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_GetScriptSourceReturnType = [`Inspector_Debugger_GetScriptSourceReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_GetStackTraceParameterType = [`Inspector_Debugger_GetStackTraceParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_GetStackTraceReturnType = [`Inspector_Debugger_GetStackTraceReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_Location = [`Inspector_Debugger_Location] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_PauseOnAsyncCallParameterType = [`Inspector_Debugger_PauseOnAsyncCallParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_PausedEventDataType = [`Inspector_Debugger_PausedEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_RemoveBreakpointParameterType = [`Inspector_Debugger_RemoveBreakpointParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_RestartFrameParameterType = [`Inspector_Debugger_RestartFrameParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_RestartFrameReturnType = [`Inspector_Debugger_RestartFrameReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_Scope = [`Inspector_Debugger_Scope] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_ScriptFailedToParseEventDataType = [`Inspector_Debugger_ScriptFailedToParseEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_ScriptParsedEventDataType = [`Inspector_Debugger_ScriptParsedEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_ScriptPosition = [`Inspector_Debugger_ScriptPosition] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SearchInContentParameterType = [`Inspector_Debugger_SearchInContentParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SearchInContentReturnType = [`Inspector_Debugger_SearchInContentReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SearchMatch = [`Inspector_Debugger_SearchMatch] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetAsyncCallStackDepthParameterType = [`Inspector_Debugger_SetAsyncCallStackDepthParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetBlackboxPatternsParameterType = [`Inspector_Debugger_SetBlackboxPatternsParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetBlackboxedRangesParameterType = [`Inspector_Debugger_SetBlackboxedRangesParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetBreakpointByUrlParameterType = [`Inspector_Debugger_SetBreakpointByUrlParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetBreakpointByUrlReturnType = [`Inspector_Debugger_SetBreakpointByUrlReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetBreakpointParameterType = [`Inspector_Debugger_SetBreakpointParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetBreakpointReturnType = [`Inspector_Debugger_SetBreakpointReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetBreakpointsActiveParameterType = [`Inspector_Debugger_SetBreakpointsActiveParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetPauseOnExceptionsParameterType = [`Inspector_Debugger_SetPauseOnExceptionsParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetReturnValueParameterType = [`Inspector_Debugger_SetReturnValueParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetScriptSourceParameterType = [`Inspector_Debugger_SetScriptSourceParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetScriptSourceReturnType = [`Inspector_Debugger_SetScriptSourceReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetSkipAllPausesParameterType = [`Inspector_Debugger_SetSkipAllPausesParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_SetVariableValueParameterType = [`Inspector_Debugger_SetVariableValueParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Debugger_StepIntoParameterType = [`Inspector_Debugger_StepIntoParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_AddHeapSnapshotChunkEventDataType = [`Inspector_HeapProfiler_AddHeapSnapshotChunkEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_AddInspectedHeapObjectParameterType = [`Inspector_HeapProfiler_AddInspectedHeapObjectParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_GetHeapObjectIdParameterType = [`Inspector_HeapProfiler_GetHeapObjectIdParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_GetHeapObjectIdReturnType = [`Inspector_HeapProfiler_GetHeapObjectIdReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_GetObjectByHeapObjectIdParameterType = [`Inspector_HeapProfiler_GetObjectByHeapObjectIdParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_GetObjectByHeapObjectIdReturnType = [`Inspector_HeapProfiler_GetObjectByHeapObjectIdReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_GetSamplingProfileReturnType = [`Inspector_HeapProfiler_GetSamplingProfileReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_HeapSnapshotObjectId = string
      and inspector_HeapProfiler_HeapStatsUpdateEventDataType = [`Inspector_HeapProfiler_HeapStatsUpdateEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_LastSeenObjectIdEventDataType = [`Inspector_HeapProfiler_LastSeenObjectIdEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_ReportHeapSnapshotProgressEventDataType = [`Inspector_HeapProfiler_ReportHeapSnapshotProgressEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_SamplingHeapProfile = [`Inspector_HeapProfiler_SamplingHeapProfile] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_SamplingHeapProfileNode = [`Inspector_HeapProfiler_SamplingHeapProfileNode] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_StartSamplingParameterType = [`Inspector_HeapProfiler_StartSamplingParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_StartTrackingHeapObjectsParameterType = [`Inspector_HeapProfiler_StartTrackingHeapObjectsParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_StopSamplingReturnType = [`Inspector_HeapProfiler_StopSamplingReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_StopTrackingHeapObjectsParameterType = [`Inspector_HeapProfiler_StopTrackingHeapObjectsParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_HeapProfiler_TakeHeapSnapshotParameterType = [`Inspector_HeapProfiler_TakeHeapSnapshotParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T inspector_InspectorNotification = [`Inspector_InspectorNotification of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and inspector_NodeRuntime_NotifyWhenWaitingForDisconnectParameterType = [`Inspector_NodeRuntime_NotifyWhenWaitingForDisconnectParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_NodeTracing_DataCollectedEventDataType = [`Inspector_NodeTracing_DataCollectedEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_NodeTracing_GetCategoriesReturnType = [`Inspector_NodeTracing_GetCategoriesReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_NodeTracing_StartParameterType = [`Inspector_NodeTracing_StartParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_NodeTracing_TraceConfig = [`Inspector_NodeTracing_TraceConfig] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_NodeWorker_AttachedToWorkerEventDataType = [`Inspector_NodeWorker_AttachedToWorkerEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_NodeWorker_DetachParameterType = [`Inspector_NodeWorker_DetachParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_NodeWorker_DetachedFromWorkerEventDataType = [`Inspector_NodeWorker_DetachedFromWorkerEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_NodeWorker_EnableParameterType = [`Inspector_NodeWorker_EnableParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_NodeWorker_ReceivedMessageFromWorkerEventDataType = [`Inspector_NodeWorker_ReceivedMessageFromWorkerEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_NodeWorker_SendMessageToWorkerParameterType = [`Inspector_NodeWorker_SendMessageToWorkerParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_NodeWorker_SessionID = string
      and inspector_NodeWorker_WorkerID = string
      and inspector_NodeWorker_WorkerInfo = [`Inspector_NodeWorker_WorkerInfo] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_ConsoleProfileFinishedEventDataType = [`Inspector_Profiler_ConsoleProfileFinishedEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_ConsoleProfileStartedEventDataType = [`Inspector_Profiler_ConsoleProfileStartedEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_CoverageRange = [`Inspector_Profiler_CoverageRange] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_FunctionCoverage = [`Inspector_Profiler_FunctionCoverage] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_GetBestEffortCoverageReturnType = [`Inspector_Profiler_GetBestEffortCoverageReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_PositionTickInfo = [`Inspector_Profiler_PositionTickInfo] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_Profile = [`Inspector_Profiler_Profile] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_ProfileNode = [`Inspector_Profiler_ProfileNode] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_ScriptCoverage = [`Inspector_Profiler_ScriptCoverage] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_ScriptTypeProfile = [`Inspector_Profiler_ScriptTypeProfile] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_SetSamplingIntervalParameterType = [`Inspector_Profiler_SetSamplingIntervalParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_StartPreciseCoverageParameterType = [`Inspector_Profiler_StartPreciseCoverageParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_StopReturnType = [`Inspector_Profiler_StopReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_TakePreciseCoverageReturnType = [`Inspector_Profiler_TakePreciseCoverageReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_TakeTypeProfileReturnType = [`Inspector_Profiler_TakeTypeProfileReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_TypeObject = [`Inspector_Profiler_TypeObject] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Profiler_TypeProfileEntry = [`Inspector_Profiler_TypeProfileEntry] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_AwaitPromiseParameterType = [`Inspector_Runtime_AwaitPromiseParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_AwaitPromiseReturnType = [`Inspector_Runtime_AwaitPromiseReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_CallArgument = [`Inspector_Runtime_CallArgument] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_CallFrame = [`Inspector_Runtime_CallFrame] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_CallFunctionOnParameterType = [`Inspector_Runtime_CallFunctionOnParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_CallFunctionOnReturnType = [`Inspector_Runtime_CallFunctionOnReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_CompileScriptParameterType = [`Inspector_Runtime_CompileScriptParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_CompileScriptReturnType = [`Inspector_Runtime_CompileScriptReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_ConsoleAPICalledEventDataType = [`Inspector_Runtime_ConsoleAPICalledEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_CustomPreview = [`Inspector_Runtime_CustomPreview] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_EntryPreview = [`Inspector_Runtime_EntryPreview] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_EvaluateParameterType = [`Inspector_Runtime_EvaluateParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_EvaluateReturnType = [`Inspector_Runtime_EvaluateReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_ExceptionDetails = [`Inspector_Runtime_ExceptionDetails] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_ExceptionRevokedEventDataType = [`Inspector_Runtime_ExceptionRevokedEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_ExceptionThrownEventDataType = [`Inspector_Runtime_ExceptionThrownEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_ExecutionContextCreatedEventDataType = [`Inspector_Runtime_ExecutionContextCreatedEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_ExecutionContextDescription = [`Inspector_Runtime_ExecutionContextDescription] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_ExecutionContextDestroyedEventDataType = [`Inspector_Runtime_ExecutionContextDestroyedEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_ExecutionContextId = float
      and inspector_Runtime_GetPropertiesParameterType = [`Inspector_Runtime_GetPropertiesParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_GetPropertiesReturnType = [`Inspector_Runtime_GetPropertiesReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_GlobalLexicalScopeNamesParameterType = [`Inspector_Runtime_GlobalLexicalScopeNamesParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_GlobalLexicalScopeNamesReturnType = [`Inspector_Runtime_GlobalLexicalScopeNamesReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_InspectRequestedEventDataType = [`Inspector_Runtime_InspectRequestedEventDataType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_InternalPropertyDescriptor = [`Inspector_Runtime_InternalPropertyDescriptor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_ObjectPreview = [`Inspector_Runtime_ObjectPreview] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_PropertyDescriptor = [`Inspector_Runtime_PropertyDescriptor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_PropertyPreview = [`Inspector_Runtime_PropertyPreview] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_QueryObjectsParameterType = [`Inspector_Runtime_QueryObjectsParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_QueryObjectsReturnType = [`Inspector_Runtime_QueryObjectsReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_ReleaseObjectGroupParameterType = [`Inspector_Runtime_ReleaseObjectGroupParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_ReleaseObjectParameterType = [`Inspector_Runtime_ReleaseObjectParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_RemoteObject = [`Inspector_Runtime_RemoteObject] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_RemoteObjectId = string
      and inspector_Runtime_RunScriptParameterType = [`Inspector_Runtime_RunScriptParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_RunScriptReturnType = [`Inspector_Runtime_RunScriptReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_ScriptId = string
      and inspector_Runtime_SetCustomObjectFormatterEnabledParameterType = [`Inspector_Runtime_SetCustomObjectFormatterEnabledParameterType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_StackTrace = [`Inspector_Runtime_StackTrace] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_StackTraceId = [`Inspector_Runtime_StackTraceId] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Runtime_Timestamp = float
      and inspector_Runtime_UniqueDebuggerId = string
      and inspector_Runtime_UnserializableValue = string
      and inspector_Schema_Domain = [`Inspector_Schema_Domain] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Schema_GetDomainsReturnType = [`Inspector_Schema_GetDomainsReturnType] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and inspector_Session = [`Inspector_Session] intf
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
  end
  module[@js.scope "node:inspector"] Node_inspector : sig
    (* export * from 'inspector'; *)
  end
  module[@js.scope "inspector"] Inspector : sig
    (* import EventEmitter = require('node:events'); *)
    module[@js.scope "InspectorNotification"] InspectorNotification : sig
      type 'T t = 'T inspector_InspectorNotification
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_method: 'T t -> string [@@js.get "method"]
      val set_method: 'T t -> string -> unit [@@js.set "method"]
      val get_params: 'T t -> 'T [@@js.get "params"]
      val set_params: 'T t -> 'T -> unit [@@js.set "params"]
    end
    module[@js.scope "Schema"] Schema : sig
      module[@js.scope "Domain"] Domain : sig
        type t = inspector_Schema_Domain
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_name: t -> string [@@js.get "name"]
        val set_name: t -> string -> unit [@@js.set "name"]
        val get_version: t -> string [@@js.get "version"]
        val set_version: t -> string -> unit [@@js.set "version"]
      end
      module[@js.scope "GetDomainsReturnType"] GetDomainsReturnType : sig
        type t = inspector_Schema_GetDomainsReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_domains: t -> inspector_Schema_Domain list [@@js.get "domains"]
        val set_domains: t -> inspector_Schema_Domain list -> unit [@@js.set "domains"]
      end
    end
    module[@js.scope "Runtime"] Runtime : sig
      module ScriptId : sig
        type t = inspector_Runtime_ScriptId
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module RemoteObjectId : sig
        type t = inspector_Runtime_RemoteObjectId
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module UnserializableValue : sig
        type t = inspector_Runtime_UnserializableValue
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module[@js.scope "RemoteObject"] RemoteObject : sig
        type t = inspector_Runtime_RemoteObject
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_type: t -> string [@@js.get "type"]
        val set_type: t -> string -> unit [@@js.set "type"]
        val get_subtype: t -> string [@@js.get "subtype"]
        val set_subtype: t -> string -> unit [@@js.set "subtype"]
        val get_className: t -> string [@@js.get "className"]
        val set_className: t -> string -> unit [@@js.set "className"]
        val get_value: t -> any [@@js.get "value"]
        val set_value: t -> any -> unit [@@js.set "value"]
        val get_unserializableValue: t -> inspector_Runtime_UnserializableValue [@@js.get "unserializableValue"]
        val set_unserializableValue: t -> inspector_Runtime_UnserializableValue -> unit [@@js.set "unserializableValue"]
        val get_description: t -> string [@@js.get "description"]
        val set_description: t -> string -> unit [@@js.set "description"]
        val get_objectId: t -> inspector_Runtime_RemoteObjectId [@@js.get "objectId"]
        val set_objectId: t -> inspector_Runtime_RemoteObjectId -> unit [@@js.set "objectId"]
        val get_preview: t -> inspector_Runtime_ObjectPreview [@@js.get "preview"]
        val set_preview: t -> inspector_Runtime_ObjectPreview -> unit [@@js.set "preview"]
        val get_customPreview: t -> inspector_Runtime_CustomPreview [@@js.get "customPreview"]
        val set_customPreview: t -> inspector_Runtime_CustomPreview -> unit [@@js.set "customPreview"]
      end
      module[@js.scope "CustomPreview"] CustomPreview : sig
        type t = inspector_Runtime_CustomPreview
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_header: t -> string [@@js.get "header"]
        val set_header: t -> string -> unit [@@js.set "header"]
        val get_hasBody: t -> bool [@@js.get "hasBody"]
        val set_hasBody: t -> bool -> unit [@@js.set "hasBody"]
        val get_formatterObjectId: t -> inspector_Runtime_RemoteObjectId [@@js.get "formatterObjectId"]
        val set_formatterObjectId: t -> inspector_Runtime_RemoteObjectId -> unit [@@js.set "formatterObjectId"]
        val get_bindRemoteObjectFunctionId: t -> inspector_Runtime_RemoteObjectId [@@js.get "bindRemoteObjectFunctionId"]
        val set_bindRemoteObjectFunctionId: t -> inspector_Runtime_RemoteObjectId -> unit [@@js.set "bindRemoteObjectFunctionId"]
        val get_configObjectId: t -> inspector_Runtime_RemoteObjectId [@@js.get "configObjectId"]
        val set_configObjectId: t -> inspector_Runtime_RemoteObjectId -> unit [@@js.set "configObjectId"]
      end
      module[@js.scope "ObjectPreview"] ObjectPreview : sig
        type t = inspector_Runtime_ObjectPreview
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_type: t -> string [@@js.get "type"]
        val set_type: t -> string -> unit [@@js.set "type"]
        val get_subtype: t -> string [@@js.get "subtype"]
        val set_subtype: t -> string -> unit [@@js.set "subtype"]
        val get_description: t -> string [@@js.get "description"]
        val set_description: t -> string -> unit [@@js.set "description"]
        val get_overflow: t -> bool [@@js.get "overflow"]
        val set_overflow: t -> bool -> unit [@@js.set "overflow"]
        val get_properties: t -> inspector_Runtime_PropertyPreview list [@@js.get "properties"]
        val set_properties: t -> inspector_Runtime_PropertyPreview list -> unit [@@js.set "properties"]
        val get_entries: t -> inspector_Runtime_EntryPreview list [@@js.get "entries"]
        val set_entries: t -> inspector_Runtime_EntryPreview list -> unit [@@js.set "entries"]
      end
      module[@js.scope "PropertyPreview"] PropertyPreview : sig
        type t = inspector_Runtime_PropertyPreview
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_name: t -> string [@@js.get "name"]
        val set_name: t -> string -> unit [@@js.set "name"]
        val get_type: t -> string [@@js.get "type"]
        val set_type: t -> string -> unit [@@js.set "type"]
        val get_value: t -> string [@@js.get "value"]
        val set_value: t -> string -> unit [@@js.set "value"]
        val get_valuePreview: t -> inspector_Runtime_ObjectPreview [@@js.get "valuePreview"]
        val set_valuePreview: t -> inspector_Runtime_ObjectPreview -> unit [@@js.set "valuePreview"]
        val get_subtype: t -> string [@@js.get "subtype"]
        val set_subtype: t -> string -> unit [@@js.set "subtype"]
      end
      module[@js.scope "EntryPreview"] EntryPreview : sig
        type t = inspector_Runtime_EntryPreview
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_key: t -> inspector_Runtime_ObjectPreview [@@js.get "key"]
        val set_key: t -> inspector_Runtime_ObjectPreview -> unit [@@js.set "key"]
        val get_value: t -> inspector_Runtime_ObjectPreview [@@js.get "value"]
        val set_value: t -> inspector_Runtime_ObjectPreview -> unit [@@js.set "value"]
      end
      module[@js.scope "PropertyDescriptor"] PropertyDescriptor : sig
        type t = inspector_Runtime_PropertyDescriptor
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_name: t -> string [@@js.get "name"]
        val set_name: t -> string -> unit [@@js.set "name"]
        val get_value: t -> inspector_Runtime_RemoteObject [@@js.get "value"]
        val set_value: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "value"]
        val get_writable: t -> bool [@@js.get "writable"]
        val set_writable: t -> bool -> unit [@@js.set "writable"]
        val get_get: t -> inspector_Runtime_RemoteObject [@@js.get "get"]
        val set_get: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "get"]
        val get_set: t -> inspector_Runtime_RemoteObject [@@js.get "set"]
        val set_set: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "set"]
        val get_configurable: t -> bool [@@js.get "configurable"]
        val set_configurable: t -> bool -> unit [@@js.set "configurable"]
        val get_enumerable: t -> bool [@@js.get "enumerable"]
        val set_enumerable: t -> bool -> unit [@@js.set "enumerable"]
        val get_wasThrown: t -> bool [@@js.get "wasThrown"]
        val set_wasThrown: t -> bool -> unit [@@js.set "wasThrown"]
        val get_isOwn: t -> bool [@@js.get "isOwn"]
        val set_isOwn: t -> bool -> unit [@@js.set "isOwn"]
        val get_symbol: t -> inspector_Runtime_RemoteObject [@@js.get "symbol"]
        val set_symbol: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "symbol"]
      end
      module[@js.scope "InternalPropertyDescriptor"] InternalPropertyDescriptor : sig
        type t = inspector_Runtime_InternalPropertyDescriptor
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_name: t -> string [@@js.get "name"]
        val set_name: t -> string -> unit [@@js.set "name"]
        val get_value: t -> inspector_Runtime_RemoteObject [@@js.get "value"]
        val set_value: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "value"]
      end
      module[@js.scope "CallArgument"] CallArgument : sig
        type t = inspector_Runtime_CallArgument
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_value: t -> any [@@js.get "value"]
        val set_value: t -> any -> unit [@@js.set "value"]
        val get_unserializableValue: t -> inspector_Runtime_UnserializableValue [@@js.get "unserializableValue"]
        val set_unserializableValue: t -> inspector_Runtime_UnserializableValue -> unit [@@js.set "unserializableValue"]
        val get_objectId: t -> inspector_Runtime_RemoteObjectId [@@js.get "objectId"]
        val set_objectId: t -> inspector_Runtime_RemoteObjectId -> unit [@@js.set "objectId"]
      end
      module ExecutionContextId : sig
        type t = inspector_Runtime_ExecutionContextId
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module[@js.scope "ExecutionContextDescription"] ExecutionContextDescription : sig
        type t = inspector_Runtime_ExecutionContextDescription
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_id: t -> inspector_Runtime_ExecutionContextId [@@js.get "id"]
        val set_id: t -> inspector_Runtime_ExecutionContextId -> unit [@@js.set "id"]
        val get_origin: t -> string [@@js.get "origin"]
        val set_origin: t -> string -> unit [@@js.set "origin"]
        val get_name: t -> string [@@js.get "name"]
        val set_name: t -> string -> unit [@@js.set "name"]
        val get_auxData: t -> anonymous_interface_0 [@@js.get "auxData"]
        val set_auxData: t -> anonymous_interface_0 -> unit [@@js.set "auxData"]
      end
      module[@js.scope "ExceptionDetails"] ExceptionDetails : sig
        type t = inspector_Runtime_ExceptionDetails
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_exceptionId: t -> float [@@js.get "exceptionId"]
        val set_exceptionId: t -> float -> unit [@@js.set "exceptionId"]
        val get_text: t -> string [@@js.get "text"]
        val set_text: t -> string -> unit [@@js.set "text"]
        val get_lineNumber: t -> float [@@js.get "lineNumber"]
        val set_lineNumber: t -> float -> unit [@@js.set "lineNumber"]
        val get_columnNumber: t -> float [@@js.get "columnNumber"]
        val set_columnNumber: t -> float -> unit [@@js.set "columnNumber"]
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_url: t -> string [@@js.get "url"]
        val set_url: t -> string -> unit [@@js.set "url"]
        val get_stackTrace: t -> inspector_Runtime_StackTrace [@@js.get "stackTrace"]
        val set_stackTrace: t -> inspector_Runtime_StackTrace -> unit [@@js.set "stackTrace"]
        val get_exception: t -> inspector_Runtime_RemoteObject [@@js.get "exception"]
        val set_exception: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "exception"]
        val get_executionContextId: t -> inspector_Runtime_ExecutionContextId [@@js.get "executionContextId"]
        val set_executionContextId: t -> inspector_Runtime_ExecutionContextId -> unit [@@js.set "executionContextId"]
      end
      module Timestamp : sig
        type t = inspector_Runtime_Timestamp
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module[@js.scope "CallFrame"] CallFrame : sig
        type t = inspector_Runtime_CallFrame
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_functionName: t -> string [@@js.get "functionName"]
        val set_functionName: t -> string -> unit [@@js.set "functionName"]
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_url: t -> string [@@js.get "url"]
        val set_url: t -> string -> unit [@@js.set "url"]
        val get_lineNumber: t -> float [@@js.get "lineNumber"]
        val set_lineNumber: t -> float -> unit [@@js.set "lineNumber"]
        val get_columnNumber: t -> float [@@js.get "columnNumber"]
        val set_columnNumber: t -> float -> unit [@@js.set "columnNumber"]
      end
      module[@js.scope "StackTrace"] StackTrace : sig
        type t = inspector_Runtime_StackTrace
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_description: t -> string [@@js.get "description"]
        val set_description: t -> string -> unit [@@js.set "description"]
        val get_callFrames: t -> inspector_Runtime_CallFrame list [@@js.get "callFrames"]
        val set_callFrames: t -> inspector_Runtime_CallFrame list -> unit [@@js.set "callFrames"]
        val get_parent: t -> t [@@js.get "parent"]
        val set_parent: t -> t -> unit [@@js.set "parent"]
        val get_parentId: t -> inspector_Runtime_StackTraceId [@@js.get "parentId"]
        val set_parentId: t -> inspector_Runtime_StackTraceId -> unit [@@js.set "parentId"]
      end
      module UniqueDebuggerId : sig
        type t = inspector_Runtime_UniqueDebuggerId
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module[@js.scope "StackTraceId"] StackTraceId : sig
        type t = inspector_Runtime_StackTraceId
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_id: t -> string [@@js.get "id"]
        val set_id: t -> string -> unit [@@js.set "id"]
        val get_debuggerId: t -> inspector_Runtime_UniqueDebuggerId [@@js.get "debuggerId"]
        val set_debuggerId: t -> inspector_Runtime_UniqueDebuggerId -> unit [@@js.set "debuggerId"]
      end
      module[@js.scope "EvaluateParameterType"] EvaluateParameterType : sig
        type t = inspector_Runtime_EvaluateParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_expression: t -> string [@@js.get "expression"]
        val set_expression: t -> string -> unit [@@js.set "expression"]
        val get_objectGroup: t -> string [@@js.get "objectGroup"]
        val set_objectGroup: t -> string -> unit [@@js.set "objectGroup"]
        val get_includeCommandLineAPI: t -> bool [@@js.get "includeCommandLineAPI"]
        val set_includeCommandLineAPI: t -> bool -> unit [@@js.set "includeCommandLineAPI"]
        val get_silent: t -> bool [@@js.get "silent"]
        val set_silent: t -> bool -> unit [@@js.set "silent"]
        val get_contextId: t -> inspector_Runtime_ExecutionContextId [@@js.get "contextId"]
        val set_contextId: t -> inspector_Runtime_ExecutionContextId -> unit [@@js.set "contextId"]
        val get_returnByValue: t -> bool [@@js.get "returnByValue"]
        val set_returnByValue: t -> bool -> unit [@@js.set "returnByValue"]
        val get_generatePreview: t -> bool [@@js.get "generatePreview"]
        val set_generatePreview: t -> bool -> unit [@@js.set "generatePreview"]
        val get_userGesture: t -> bool [@@js.get "userGesture"]
        val set_userGesture: t -> bool -> unit [@@js.set "userGesture"]
        val get_awaitPromise: t -> bool [@@js.get "awaitPromise"]
        val set_awaitPromise: t -> bool -> unit [@@js.set "awaitPromise"]
      end
      module[@js.scope "AwaitPromiseParameterType"] AwaitPromiseParameterType : sig
        type t = inspector_Runtime_AwaitPromiseParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_promiseObjectId: t -> inspector_Runtime_RemoteObjectId [@@js.get "promiseObjectId"]
        val set_promiseObjectId: t -> inspector_Runtime_RemoteObjectId -> unit [@@js.set "promiseObjectId"]
        val get_returnByValue: t -> bool [@@js.get "returnByValue"]
        val set_returnByValue: t -> bool -> unit [@@js.set "returnByValue"]
        val get_generatePreview: t -> bool [@@js.get "generatePreview"]
        val set_generatePreview: t -> bool -> unit [@@js.set "generatePreview"]
      end
      module[@js.scope "CallFunctionOnParameterType"] CallFunctionOnParameterType : sig
        type t = inspector_Runtime_CallFunctionOnParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_functionDeclaration: t -> string [@@js.get "functionDeclaration"]
        val set_functionDeclaration: t -> string -> unit [@@js.set "functionDeclaration"]
        val get_objectId: t -> inspector_Runtime_RemoteObjectId [@@js.get "objectId"]
        val set_objectId: t -> inspector_Runtime_RemoteObjectId -> unit [@@js.set "objectId"]
        val get_arguments: t -> inspector_Runtime_CallArgument list [@@js.get "arguments"]
        val set_arguments: t -> inspector_Runtime_CallArgument list -> unit [@@js.set "arguments"]
        val get_silent: t -> bool [@@js.get "silent"]
        val set_silent: t -> bool -> unit [@@js.set "silent"]
        val get_returnByValue: t -> bool [@@js.get "returnByValue"]
        val set_returnByValue: t -> bool -> unit [@@js.set "returnByValue"]
        val get_generatePreview: t -> bool [@@js.get "generatePreview"]
        val set_generatePreview: t -> bool -> unit [@@js.set "generatePreview"]
        val get_userGesture: t -> bool [@@js.get "userGesture"]
        val set_userGesture: t -> bool -> unit [@@js.set "userGesture"]
        val get_awaitPromise: t -> bool [@@js.get "awaitPromise"]
        val set_awaitPromise: t -> bool -> unit [@@js.set "awaitPromise"]
        val get_executionContextId: t -> inspector_Runtime_ExecutionContextId [@@js.get "executionContextId"]
        val set_executionContextId: t -> inspector_Runtime_ExecutionContextId -> unit [@@js.set "executionContextId"]
        val get_objectGroup: t -> string [@@js.get "objectGroup"]
        val set_objectGroup: t -> string -> unit [@@js.set "objectGroup"]
      end
      module[@js.scope "GetPropertiesParameterType"] GetPropertiesParameterType : sig
        type t = inspector_Runtime_GetPropertiesParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_objectId: t -> inspector_Runtime_RemoteObjectId [@@js.get "objectId"]
        val set_objectId: t -> inspector_Runtime_RemoteObjectId -> unit [@@js.set "objectId"]
        val get_ownProperties: t -> bool [@@js.get "ownProperties"]
        val set_ownProperties: t -> bool -> unit [@@js.set "ownProperties"]
        val get_accessorPropertiesOnly: t -> bool [@@js.get "accessorPropertiesOnly"]
        val set_accessorPropertiesOnly: t -> bool -> unit [@@js.set "accessorPropertiesOnly"]
        val get_generatePreview: t -> bool [@@js.get "generatePreview"]
        val set_generatePreview: t -> bool -> unit [@@js.set "generatePreview"]
      end
      module[@js.scope "ReleaseObjectParameterType"] ReleaseObjectParameterType : sig
        type t = inspector_Runtime_ReleaseObjectParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_objectId: t -> inspector_Runtime_RemoteObjectId [@@js.get "objectId"]
        val set_objectId: t -> inspector_Runtime_RemoteObjectId -> unit [@@js.set "objectId"]
      end
      module[@js.scope "ReleaseObjectGroupParameterType"] ReleaseObjectGroupParameterType : sig
        type t = inspector_Runtime_ReleaseObjectGroupParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_objectGroup: t -> string [@@js.get "objectGroup"]
        val set_objectGroup: t -> string -> unit [@@js.set "objectGroup"]
      end
      module[@js.scope "SetCustomObjectFormatterEnabledParameterType"] SetCustomObjectFormatterEnabledParameterType : sig
        type t = inspector_Runtime_SetCustomObjectFormatterEnabledParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_enabled: t -> bool [@@js.get "enabled"]
        val set_enabled: t -> bool -> unit [@@js.set "enabled"]
      end
      module[@js.scope "CompileScriptParameterType"] CompileScriptParameterType : sig
        type t = inspector_Runtime_CompileScriptParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_expression: t -> string [@@js.get "expression"]
        val set_expression: t -> string -> unit [@@js.set "expression"]
        val get_sourceURL: t -> string [@@js.get "sourceURL"]
        val set_sourceURL: t -> string -> unit [@@js.set "sourceURL"]
        val get_persistScript: t -> bool [@@js.get "persistScript"]
        val set_persistScript: t -> bool -> unit [@@js.set "persistScript"]
        val get_executionContextId: t -> inspector_Runtime_ExecutionContextId [@@js.get "executionContextId"]
        val set_executionContextId: t -> inspector_Runtime_ExecutionContextId -> unit [@@js.set "executionContextId"]
      end
      module[@js.scope "RunScriptParameterType"] RunScriptParameterType : sig
        type t = inspector_Runtime_RunScriptParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_executionContextId: t -> inspector_Runtime_ExecutionContextId [@@js.get "executionContextId"]
        val set_executionContextId: t -> inspector_Runtime_ExecutionContextId -> unit [@@js.set "executionContextId"]
        val get_objectGroup: t -> string [@@js.get "objectGroup"]
        val set_objectGroup: t -> string -> unit [@@js.set "objectGroup"]
        val get_silent: t -> bool [@@js.get "silent"]
        val set_silent: t -> bool -> unit [@@js.set "silent"]
        val get_includeCommandLineAPI: t -> bool [@@js.get "includeCommandLineAPI"]
        val set_includeCommandLineAPI: t -> bool -> unit [@@js.set "includeCommandLineAPI"]
        val get_returnByValue: t -> bool [@@js.get "returnByValue"]
        val set_returnByValue: t -> bool -> unit [@@js.set "returnByValue"]
        val get_generatePreview: t -> bool [@@js.get "generatePreview"]
        val set_generatePreview: t -> bool -> unit [@@js.set "generatePreview"]
        val get_awaitPromise: t -> bool [@@js.get "awaitPromise"]
        val set_awaitPromise: t -> bool -> unit [@@js.set "awaitPromise"]
      end
      module[@js.scope "QueryObjectsParameterType"] QueryObjectsParameterType : sig
        type t = inspector_Runtime_QueryObjectsParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_prototypeObjectId: t -> inspector_Runtime_RemoteObjectId [@@js.get "prototypeObjectId"]
        val set_prototypeObjectId: t -> inspector_Runtime_RemoteObjectId -> unit [@@js.set "prototypeObjectId"]
      end
      module[@js.scope "GlobalLexicalScopeNamesParameterType"] GlobalLexicalScopeNamesParameterType : sig
        type t = inspector_Runtime_GlobalLexicalScopeNamesParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_executionContextId: t -> inspector_Runtime_ExecutionContextId [@@js.get "executionContextId"]
        val set_executionContextId: t -> inspector_Runtime_ExecutionContextId -> unit [@@js.set "executionContextId"]
      end
      module[@js.scope "EvaluateReturnType"] EvaluateReturnType : sig
        type t = inspector_Runtime_EvaluateReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_result: t -> inspector_Runtime_RemoteObject [@@js.get "result"]
        val set_result: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "result"]
        val get_exceptionDetails: t -> inspector_Runtime_ExceptionDetails [@@js.get "exceptionDetails"]
        val set_exceptionDetails: t -> inspector_Runtime_ExceptionDetails -> unit [@@js.set "exceptionDetails"]
      end
      module[@js.scope "AwaitPromiseReturnType"] AwaitPromiseReturnType : sig
        type t = inspector_Runtime_AwaitPromiseReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_result: t -> inspector_Runtime_RemoteObject [@@js.get "result"]
        val set_result: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "result"]
        val get_exceptionDetails: t -> inspector_Runtime_ExceptionDetails [@@js.get "exceptionDetails"]
        val set_exceptionDetails: t -> inspector_Runtime_ExceptionDetails -> unit [@@js.set "exceptionDetails"]
      end
      module[@js.scope "CallFunctionOnReturnType"] CallFunctionOnReturnType : sig
        type t = inspector_Runtime_CallFunctionOnReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_result: t -> inspector_Runtime_RemoteObject [@@js.get "result"]
        val set_result: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "result"]
        val get_exceptionDetails: t -> inspector_Runtime_ExceptionDetails [@@js.get "exceptionDetails"]
        val set_exceptionDetails: t -> inspector_Runtime_ExceptionDetails -> unit [@@js.set "exceptionDetails"]
      end
      module[@js.scope "GetPropertiesReturnType"] GetPropertiesReturnType : sig
        type t = inspector_Runtime_GetPropertiesReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_result: t -> inspector_Runtime_PropertyDescriptor list [@@js.get "result"]
        val set_result: t -> inspector_Runtime_PropertyDescriptor list -> unit [@@js.set "result"]
        val get_internalProperties: t -> inspector_Runtime_InternalPropertyDescriptor list [@@js.get "internalProperties"]
        val set_internalProperties: t -> inspector_Runtime_InternalPropertyDescriptor list -> unit [@@js.set "internalProperties"]
        val get_exceptionDetails: t -> inspector_Runtime_ExceptionDetails [@@js.get "exceptionDetails"]
        val set_exceptionDetails: t -> inspector_Runtime_ExceptionDetails -> unit [@@js.set "exceptionDetails"]
      end
      module[@js.scope "CompileScriptReturnType"] CompileScriptReturnType : sig
        type t = inspector_Runtime_CompileScriptReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_exceptionDetails: t -> inspector_Runtime_ExceptionDetails [@@js.get "exceptionDetails"]
        val set_exceptionDetails: t -> inspector_Runtime_ExceptionDetails -> unit [@@js.set "exceptionDetails"]
      end
      module[@js.scope "RunScriptReturnType"] RunScriptReturnType : sig
        type t = inspector_Runtime_RunScriptReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_result: t -> inspector_Runtime_RemoteObject [@@js.get "result"]
        val set_result: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "result"]
        val get_exceptionDetails: t -> inspector_Runtime_ExceptionDetails [@@js.get "exceptionDetails"]
        val set_exceptionDetails: t -> inspector_Runtime_ExceptionDetails -> unit [@@js.set "exceptionDetails"]
      end
      module[@js.scope "QueryObjectsReturnType"] QueryObjectsReturnType : sig
        type t = inspector_Runtime_QueryObjectsReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_objects: t -> inspector_Runtime_RemoteObject [@@js.get "objects"]
        val set_objects: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "objects"]
      end
      module[@js.scope "GlobalLexicalScopeNamesReturnType"] GlobalLexicalScopeNamesReturnType : sig
        type t = inspector_Runtime_GlobalLexicalScopeNamesReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_names: t -> string list [@@js.get "names"]
        val set_names: t -> string list -> unit [@@js.set "names"]
      end
      module[@js.scope "ExecutionContextCreatedEventDataType"] ExecutionContextCreatedEventDataType : sig
        type t = inspector_Runtime_ExecutionContextCreatedEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_context: t -> inspector_Runtime_ExecutionContextDescription [@@js.get "context"]
        val set_context: t -> inspector_Runtime_ExecutionContextDescription -> unit [@@js.set "context"]
      end
      module[@js.scope "ExecutionContextDestroyedEventDataType"] ExecutionContextDestroyedEventDataType : sig
        type t = inspector_Runtime_ExecutionContextDestroyedEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_executionContextId: t -> inspector_Runtime_ExecutionContextId [@@js.get "executionContextId"]
        val set_executionContextId: t -> inspector_Runtime_ExecutionContextId -> unit [@@js.set "executionContextId"]
      end
      module[@js.scope "ExceptionThrownEventDataType"] ExceptionThrownEventDataType : sig
        type t = inspector_Runtime_ExceptionThrownEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_timestamp: t -> inspector_Runtime_Timestamp [@@js.get "timestamp"]
        val set_timestamp: t -> inspector_Runtime_Timestamp -> unit [@@js.set "timestamp"]
        val get_exceptionDetails: t -> inspector_Runtime_ExceptionDetails [@@js.get "exceptionDetails"]
        val set_exceptionDetails: t -> inspector_Runtime_ExceptionDetails -> unit [@@js.set "exceptionDetails"]
      end
      module[@js.scope "ExceptionRevokedEventDataType"] ExceptionRevokedEventDataType : sig
        type t = inspector_Runtime_ExceptionRevokedEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_reason: t -> string [@@js.get "reason"]
        val set_reason: t -> string -> unit [@@js.set "reason"]
        val get_exceptionId: t -> float [@@js.get "exceptionId"]
        val set_exceptionId: t -> float -> unit [@@js.set "exceptionId"]
      end
      module[@js.scope "ConsoleAPICalledEventDataType"] ConsoleAPICalledEventDataType : sig
        type t = inspector_Runtime_ConsoleAPICalledEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_type: t -> string [@@js.get "type"]
        val set_type: t -> string -> unit [@@js.set "type"]
        val get_args: t -> inspector_Runtime_RemoteObject list [@@js.get "args"]
        val set_args: t -> inspector_Runtime_RemoteObject list -> unit [@@js.set "args"]
        val get_executionContextId: t -> inspector_Runtime_ExecutionContextId [@@js.get "executionContextId"]
        val set_executionContextId: t -> inspector_Runtime_ExecutionContextId -> unit [@@js.set "executionContextId"]
        val get_timestamp: t -> inspector_Runtime_Timestamp [@@js.get "timestamp"]
        val set_timestamp: t -> inspector_Runtime_Timestamp -> unit [@@js.set "timestamp"]
        val get_stackTrace: t -> inspector_Runtime_StackTrace [@@js.get "stackTrace"]
        val set_stackTrace: t -> inspector_Runtime_StackTrace -> unit [@@js.set "stackTrace"]
        val get_context: t -> string [@@js.get "context"]
        val set_context: t -> string -> unit [@@js.set "context"]
      end
      module[@js.scope "InspectRequestedEventDataType"] InspectRequestedEventDataType : sig
        type t = inspector_Runtime_InspectRequestedEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_object: t -> inspector_Runtime_RemoteObject [@@js.get "object"]
        val set_object: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "object"]
        val get_hints: t -> anonymous_interface_0 [@@js.get "hints"]
        val set_hints: t -> anonymous_interface_0 -> unit [@@js.set "hints"]
      end
    end
    module[@js.scope "Debugger"] Debugger : sig
      module BreakpointId : sig
        type t = inspector_Debugger_BreakpointId
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module CallFrameId : sig
        type t = inspector_Debugger_CallFrameId
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module[@js.scope "Location"] Location : sig
        type t = inspector_Debugger_Location
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_lineNumber: t -> float [@@js.get "lineNumber"]
        val set_lineNumber: t -> float -> unit [@@js.set "lineNumber"]
        val get_columnNumber: t -> float [@@js.get "columnNumber"]
        val set_columnNumber: t -> float -> unit [@@js.set "columnNumber"]
      end
      module[@js.scope "ScriptPosition"] ScriptPosition : sig
        type t = inspector_Debugger_ScriptPosition
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_lineNumber: t -> float [@@js.get "lineNumber"]
        val set_lineNumber: t -> float -> unit [@@js.set "lineNumber"]
        val get_columnNumber: t -> float [@@js.get "columnNumber"]
        val set_columnNumber: t -> float -> unit [@@js.set "columnNumber"]
      end
      module[@js.scope "CallFrame"] CallFrame : sig
        type t = inspector_Debugger_CallFrame
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_callFrameId: t -> inspector_Debugger_CallFrameId [@@js.get "callFrameId"]
        val set_callFrameId: t -> inspector_Debugger_CallFrameId -> unit [@@js.set "callFrameId"]
        val get_functionName: t -> string [@@js.get "functionName"]
        val set_functionName: t -> string -> unit [@@js.set "functionName"]
        val get_functionLocation: t -> inspector_Debugger_Location [@@js.get "functionLocation"]
        val set_functionLocation: t -> inspector_Debugger_Location -> unit [@@js.set "functionLocation"]
        val get_location: t -> inspector_Debugger_Location [@@js.get "location"]
        val set_location: t -> inspector_Debugger_Location -> unit [@@js.set "location"]
        val get_url: t -> string [@@js.get "url"]
        val set_url: t -> string -> unit [@@js.set "url"]
        val get_scopeChain: t -> inspector_Debugger_Scope list [@@js.get "scopeChain"]
        val set_scopeChain: t -> inspector_Debugger_Scope list -> unit [@@js.set "scopeChain"]
        val get_this: t -> inspector_Runtime_RemoteObject [@@js.get "this"]
        val set_this: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "this"]
        val get_returnValue: t -> inspector_Runtime_RemoteObject [@@js.get "returnValue"]
        val set_returnValue: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "returnValue"]
      end
      module[@js.scope "Scope"] Scope : sig
        type t = inspector_Debugger_Scope
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_type: t -> string [@@js.get "type"]
        val set_type: t -> string -> unit [@@js.set "type"]
        val get_object: t -> inspector_Runtime_RemoteObject [@@js.get "object"]
        val set_object: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "object"]
        val get_name: t -> string [@@js.get "name"]
        val set_name: t -> string -> unit [@@js.set "name"]
        val get_startLocation: t -> inspector_Debugger_Location [@@js.get "startLocation"]
        val set_startLocation: t -> inspector_Debugger_Location -> unit [@@js.set "startLocation"]
        val get_endLocation: t -> inspector_Debugger_Location [@@js.get "endLocation"]
        val set_endLocation: t -> inspector_Debugger_Location -> unit [@@js.set "endLocation"]
      end
      module[@js.scope "SearchMatch"] SearchMatch : sig
        type t = inspector_Debugger_SearchMatch
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_lineNumber: t -> float [@@js.get "lineNumber"]
        val set_lineNumber: t -> float -> unit [@@js.set "lineNumber"]
        val get_lineContent: t -> string [@@js.get "lineContent"]
        val set_lineContent: t -> string -> unit [@@js.set "lineContent"]
      end
      module[@js.scope "BreakLocation"] BreakLocation : sig
        type t = inspector_Debugger_BreakLocation
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_lineNumber: t -> float [@@js.get "lineNumber"]
        val set_lineNumber: t -> float -> unit [@@js.set "lineNumber"]
        val get_columnNumber: t -> float [@@js.get "columnNumber"]
        val set_columnNumber: t -> float -> unit [@@js.set "columnNumber"]
        val get_type: t -> string [@@js.get "type"]
        val set_type: t -> string -> unit [@@js.set "type"]
      end
      module[@js.scope "SetBreakpointsActiveParameterType"] SetBreakpointsActiveParameterType : sig
        type t = inspector_Debugger_SetBreakpointsActiveParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_active: t -> bool [@@js.get "active"]
        val set_active: t -> bool -> unit [@@js.set "active"]
      end
      module[@js.scope "SetSkipAllPausesParameterType"] SetSkipAllPausesParameterType : sig
        type t = inspector_Debugger_SetSkipAllPausesParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_skip: t -> bool [@@js.get "skip"]
        val set_skip: t -> bool -> unit [@@js.set "skip"]
      end
      module[@js.scope "SetBreakpointByUrlParameterType"] SetBreakpointByUrlParameterType : sig
        type t = inspector_Debugger_SetBreakpointByUrlParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_lineNumber: t -> float [@@js.get "lineNumber"]
        val set_lineNumber: t -> float -> unit [@@js.set "lineNumber"]
        val get_url: t -> string [@@js.get "url"]
        val set_url: t -> string -> unit [@@js.set "url"]
        val get_urlRegex: t -> string [@@js.get "urlRegex"]
        val set_urlRegex: t -> string -> unit [@@js.set "urlRegex"]
        val get_scriptHash: t -> string [@@js.get "scriptHash"]
        val set_scriptHash: t -> string -> unit [@@js.set "scriptHash"]
        val get_columnNumber: t -> float [@@js.get "columnNumber"]
        val set_columnNumber: t -> float -> unit [@@js.set "columnNumber"]
        val get_condition: t -> string [@@js.get "condition"]
        val set_condition: t -> string -> unit [@@js.set "condition"]
      end
      module[@js.scope "SetBreakpointParameterType"] SetBreakpointParameterType : sig
        type t = inspector_Debugger_SetBreakpointParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_location: t -> inspector_Debugger_Location [@@js.get "location"]
        val set_location: t -> inspector_Debugger_Location -> unit [@@js.set "location"]
        val get_condition: t -> string [@@js.get "condition"]
        val set_condition: t -> string -> unit [@@js.set "condition"]
      end
      module[@js.scope "RemoveBreakpointParameterType"] RemoveBreakpointParameterType : sig
        type t = inspector_Debugger_RemoveBreakpointParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_breakpointId: t -> inspector_Debugger_BreakpointId [@@js.get "breakpointId"]
        val set_breakpointId: t -> inspector_Debugger_BreakpointId -> unit [@@js.set "breakpointId"]
      end
      module[@js.scope "GetPossibleBreakpointsParameterType"] GetPossibleBreakpointsParameterType : sig
        type t = inspector_Debugger_GetPossibleBreakpointsParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_start: t -> inspector_Debugger_Location [@@js.get "start"]
        val set_start: t -> inspector_Debugger_Location -> unit [@@js.set "start"]
        val get_end: t -> inspector_Debugger_Location [@@js.get "end"]
        val set_end: t -> inspector_Debugger_Location -> unit [@@js.set "end"]
        val get_restrictToFunction: t -> bool [@@js.get "restrictToFunction"]
        val set_restrictToFunction: t -> bool -> unit [@@js.set "restrictToFunction"]
      end
      module[@js.scope "ContinueToLocationParameterType"] ContinueToLocationParameterType : sig
        type t = inspector_Debugger_ContinueToLocationParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_location: t -> inspector_Debugger_Location [@@js.get "location"]
        val set_location: t -> inspector_Debugger_Location -> unit [@@js.set "location"]
        val get_targetCallFrames: t -> string [@@js.get "targetCallFrames"]
        val set_targetCallFrames: t -> string -> unit [@@js.set "targetCallFrames"]
      end
      module[@js.scope "PauseOnAsyncCallParameterType"] PauseOnAsyncCallParameterType : sig
        type t = inspector_Debugger_PauseOnAsyncCallParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_parentStackTraceId: t -> inspector_Runtime_StackTraceId [@@js.get "parentStackTraceId"]
        val set_parentStackTraceId: t -> inspector_Runtime_StackTraceId -> unit [@@js.set "parentStackTraceId"]
      end
      module[@js.scope "StepIntoParameterType"] StepIntoParameterType : sig
        type t = inspector_Debugger_StepIntoParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_breakOnAsyncCall: t -> bool [@@js.get "breakOnAsyncCall"]
        val set_breakOnAsyncCall: t -> bool -> unit [@@js.set "breakOnAsyncCall"]
      end
      module[@js.scope "GetStackTraceParameterType"] GetStackTraceParameterType : sig
        type t = inspector_Debugger_GetStackTraceParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_stackTraceId: t -> inspector_Runtime_StackTraceId [@@js.get "stackTraceId"]
        val set_stackTraceId: t -> inspector_Runtime_StackTraceId -> unit [@@js.set "stackTraceId"]
      end
      module[@js.scope "SearchInContentParameterType"] SearchInContentParameterType : sig
        type t = inspector_Debugger_SearchInContentParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_query: t -> string [@@js.get "query"]
        val set_query: t -> string -> unit [@@js.set "query"]
        val get_caseSensitive: t -> bool [@@js.get "caseSensitive"]
        val set_caseSensitive: t -> bool -> unit [@@js.set "caseSensitive"]
        val get_isRegex: t -> bool [@@js.get "isRegex"]
        val set_isRegex: t -> bool -> unit [@@js.set "isRegex"]
      end
      module[@js.scope "SetScriptSourceParameterType"] SetScriptSourceParameterType : sig
        type t = inspector_Debugger_SetScriptSourceParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_scriptSource: t -> string [@@js.get "scriptSource"]
        val set_scriptSource: t -> string -> unit [@@js.set "scriptSource"]
        val get_dryRun: t -> bool [@@js.get "dryRun"]
        val set_dryRun: t -> bool -> unit [@@js.set "dryRun"]
      end
      module[@js.scope "RestartFrameParameterType"] RestartFrameParameterType : sig
        type t = inspector_Debugger_RestartFrameParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_callFrameId: t -> inspector_Debugger_CallFrameId [@@js.get "callFrameId"]
        val set_callFrameId: t -> inspector_Debugger_CallFrameId -> unit [@@js.set "callFrameId"]
      end
      module[@js.scope "GetScriptSourceParameterType"] GetScriptSourceParameterType : sig
        type t = inspector_Debugger_GetScriptSourceParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
      end
      module[@js.scope "SetPauseOnExceptionsParameterType"] SetPauseOnExceptionsParameterType : sig
        type t = inspector_Debugger_SetPauseOnExceptionsParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_state: t -> string [@@js.get "state"]
        val set_state: t -> string -> unit [@@js.set "state"]
      end
      module[@js.scope "EvaluateOnCallFrameParameterType"] EvaluateOnCallFrameParameterType : sig
        type t = inspector_Debugger_EvaluateOnCallFrameParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_callFrameId: t -> inspector_Debugger_CallFrameId [@@js.get "callFrameId"]
        val set_callFrameId: t -> inspector_Debugger_CallFrameId -> unit [@@js.set "callFrameId"]
        val get_expression: t -> string [@@js.get "expression"]
        val set_expression: t -> string -> unit [@@js.set "expression"]
        val get_objectGroup: t -> string [@@js.get "objectGroup"]
        val set_objectGroup: t -> string -> unit [@@js.set "objectGroup"]
        val get_includeCommandLineAPI: t -> bool [@@js.get "includeCommandLineAPI"]
        val set_includeCommandLineAPI: t -> bool -> unit [@@js.set "includeCommandLineAPI"]
        val get_silent: t -> bool [@@js.get "silent"]
        val set_silent: t -> bool -> unit [@@js.set "silent"]
        val get_returnByValue: t -> bool [@@js.get "returnByValue"]
        val set_returnByValue: t -> bool -> unit [@@js.set "returnByValue"]
        val get_generatePreview: t -> bool [@@js.get "generatePreview"]
        val set_generatePreview: t -> bool -> unit [@@js.set "generatePreview"]
        val get_throwOnSideEffect: t -> bool [@@js.get "throwOnSideEffect"]
        val set_throwOnSideEffect: t -> bool -> unit [@@js.set "throwOnSideEffect"]
      end
      module[@js.scope "SetVariableValueParameterType"] SetVariableValueParameterType : sig
        type t = inspector_Debugger_SetVariableValueParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scopeNumber: t -> float [@@js.get "scopeNumber"]
        val set_scopeNumber: t -> float -> unit [@@js.set "scopeNumber"]
        val get_variableName: t -> string [@@js.get "variableName"]
        val set_variableName: t -> string -> unit [@@js.set "variableName"]
        val get_newValue: t -> inspector_Runtime_CallArgument [@@js.get "newValue"]
        val set_newValue: t -> inspector_Runtime_CallArgument -> unit [@@js.set "newValue"]
        val get_callFrameId: t -> inspector_Debugger_CallFrameId [@@js.get "callFrameId"]
        val set_callFrameId: t -> inspector_Debugger_CallFrameId -> unit [@@js.set "callFrameId"]
      end
      module[@js.scope "SetReturnValueParameterType"] SetReturnValueParameterType : sig
        type t = inspector_Debugger_SetReturnValueParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_newValue: t -> inspector_Runtime_CallArgument [@@js.get "newValue"]
        val set_newValue: t -> inspector_Runtime_CallArgument -> unit [@@js.set "newValue"]
      end
      module[@js.scope "SetAsyncCallStackDepthParameterType"] SetAsyncCallStackDepthParameterType : sig
        type t = inspector_Debugger_SetAsyncCallStackDepthParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_maxDepth: t -> float [@@js.get "maxDepth"]
        val set_maxDepth: t -> float -> unit [@@js.set "maxDepth"]
      end
      module[@js.scope "SetBlackboxPatternsParameterType"] SetBlackboxPatternsParameterType : sig
        type t = inspector_Debugger_SetBlackboxPatternsParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_patterns: t -> string list [@@js.get "patterns"]
        val set_patterns: t -> string list -> unit [@@js.set "patterns"]
      end
      module[@js.scope "SetBlackboxedRangesParameterType"] SetBlackboxedRangesParameterType : sig
        type t = inspector_Debugger_SetBlackboxedRangesParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_positions: t -> inspector_Debugger_ScriptPosition list [@@js.get "positions"]
        val set_positions: t -> inspector_Debugger_ScriptPosition list -> unit [@@js.set "positions"]
      end
      module[@js.scope "EnableReturnType"] EnableReturnType : sig
        type t = inspector_Debugger_EnableReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_debuggerId: t -> inspector_Runtime_UniqueDebuggerId [@@js.get "debuggerId"]
        val set_debuggerId: t -> inspector_Runtime_UniqueDebuggerId -> unit [@@js.set "debuggerId"]
      end
      module[@js.scope "SetBreakpointByUrlReturnType"] SetBreakpointByUrlReturnType : sig
        type t = inspector_Debugger_SetBreakpointByUrlReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_breakpointId: t -> inspector_Debugger_BreakpointId [@@js.get "breakpointId"]
        val set_breakpointId: t -> inspector_Debugger_BreakpointId -> unit [@@js.set "breakpointId"]
        val get_locations: t -> inspector_Debugger_Location list [@@js.get "locations"]
        val set_locations: t -> inspector_Debugger_Location list -> unit [@@js.set "locations"]
      end
      module[@js.scope "SetBreakpointReturnType"] SetBreakpointReturnType : sig
        type t = inspector_Debugger_SetBreakpointReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_breakpointId: t -> inspector_Debugger_BreakpointId [@@js.get "breakpointId"]
        val set_breakpointId: t -> inspector_Debugger_BreakpointId -> unit [@@js.set "breakpointId"]
        val get_actualLocation: t -> inspector_Debugger_Location [@@js.get "actualLocation"]
        val set_actualLocation: t -> inspector_Debugger_Location -> unit [@@js.set "actualLocation"]
      end
      module[@js.scope "GetPossibleBreakpointsReturnType"] GetPossibleBreakpointsReturnType : sig
        type t = inspector_Debugger_GetPossibleBreakpointsReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_locations: t -> inspector_Debugger_BreakLocation list [@@js.get "locations"]
        val set_locations: t -> inspector_Debugger_BreakLocation list -> unit [@@js.set "locations"]
      end
      module[@js.scope "GetStackTraceReturnType"] GetStackTraceReturnType : sig
        type t = inspector_Debugger_GetStackTraceReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_stackTrace: t -> inspector_Runtime_StackTrace [@@js.get "stackTrace"]
        val set_stackTrace: t -> inspector_Runtime_StackTrace -> unit [@@js.set "stackTrace"]
      end
      module[@js.scope "SearchInContentReturnType"] SearchInContentReturnType : sig
        type t = inspector_Debugger_SearchInContentReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_result: t -> inspector_Debugger_SearchMatch list [@@js.get "result"]
        val set_result: t -> inspector_Debugger_SearchMatch list -> unit [@@js.set "result"]
      end
      module[@js.scope "SetScriptSourceReturnType"] SetScriptSourceReturnType : sig
        type t = inspector_Debugger_SetScriptSourceReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_callFrames: t -> inspector_Debugger_CallFrame list [@@js.get "callFrames"]
        val set_callFrames: t -> inspector_Debugger_CallFrame list -> unit [@@js.set "callFrames"]
        val get_stackChanged: t -> bool [@@js.get "stackChanged"]
        val set_stackChanged: t -> bool -> unit [@@js.set "stackChanged"]
        val get_asyncStackTrace: t -> inspector_Runtime_StackTrace [@@js.get "asyncStackTrace"]
        val set_asyncStackTrace: t -> inspector_Runtime_StackTrace -> unit [@@js.set "asyncStackTrace"]
        val get_asyncStackTraceId: t -> inspector_Runtime_StackTraceId [@@js.get "asyncStackTraceId"]
        val set_asyncStackTraceId: t -> inspector_Runtime_StackTraceId -> unit [@@js.set "asyncStackTraceId"]
        val get_exceptionDetails: t -> inspector_Runtime_ExceptionDetails [@@js.get "exceptionDetails"]
        val set_exceptionDetails: t -> inspector_Runtime_ExceptionDetails -> unit [@@js.set "exceptionDetails"]
      end
      module[@js.scope "RestartFrameReturnType"] RestartFrameReturnType : sig
        type t = inspector_Debugger_RestartFrameReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_callFrames: t -> inspector_Debugger_CallFrame list [@@js.get "callFrames"]
        val set_callFrames: t -> inspector_Debugger_CallFrame list -> unit [@@js.set "callFrames"]
        val get_asyncStackTrace: t -> inspector_Runtime_StackTrace [@@js.get "asyncStackTrace"]
        val set_asyncStackTrace: t -> inspector_Runtime_StackTrace -> unit [@@js.set "asyncStackTrace"]
        val get_asyncStackTraceId: t -> inspector_Runtime_StackTraceId [@@js.get "asyncStackTraceId"]
        val set_asyncStackTraceId: t -> inspector_Runtime_StackTraceId -> unit [@@js.set "asyncStackTraceId"]
      end
      module[@js.scope "GetScriptSourceReturnType"] GetScriptSourceReturnType : sig
        type t = inspector_Debugger_GetScriptSourceReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptSource: t -> string [@@js.get "scriptSource"]
        val set_scriptSource: t -> string -> unit [@@js.set "scriptSource"]
      end
      module[@js.scope "EvaluateOnCallFrameReturnType"] EvaluateOnCallFrameReturnType : sig
        type t = inspector_Debugger_EvaluateOnCallFrameReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_result: t -> inspector_Runtime_RemoteObject [@@js.get "result"]
        val set_result: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "result"]
        val get_exceptionDetails: t -> inspector_Runtime_ExceptionDetails [@@js.get "exceptionDetails"]
        val set_exceptionDetails: t -> inspector_Runtime_ExceptionDetails -> unit [@@js.set "exceptionDetails"]
      end
      module[@js.scope "ScriptParsedEventDataType"] ScriptParsedEventDataType : sig
        type t = inspector_Debugger_ScriptParsedEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_url: t -> string [@@js.get "url"]
        val set_url: t -> string -> unit [@@js.set "url"]
        val get_startLine: t -> float [@@js.get "startLine"]
        val set_startLine: t -> float -> unit [@@js.set "startLine"]
        val get_startColumn: t -> float [@@js.get "startColumn"]
        val set_startColumn: t -> float -> unit [@@js.set "startColumn"]
        val get_endLine: t -> float [@@js.get "endLine"]
        val set_endLine: t -> float -> unit [@@js.set "endLine"]
        val get_endColumn: t -> float [@@js.get "endColumn"]
        val set_endColumn: t -> float -> unit [@@js.set "endColumn"]
        val get_executionContextId: t -> inspector_Runtime_ExecutionContextId [@@js.get "executionContextId"]
        val set_executionContextId: t -> inspector_Runtime_ExecutionContextId -> unit [@@js.set "executionContextId"]
        val get_hash: t -> string [@@js.get "hash"]
        val set_hash: t -> string -> unit [@@js.set "hash"]
        val get_executionContextAuxData: t -> anonymous_interface_0 [@@js.get "executionContextAuxData"]
        val set_executionContextAuxData: t -> anonymous_interface_0 -> unit [@@js.set "executionContextAuxData"]
        val get_isLiveEdit: t -> bool [@@js.get "isLiveEdit"]
        val set_isLiveEdit: t -> bool -> unit [@@js.set "isLiveEdit"]
        val get_sourceMapURL: t -> string [@@js.get "sourceMapURL"]
        val set_sourceMapURL: t -> string -> unit [@@js.set "sourceMapURL"]
        val get_hasSourceURL: t -> bool [@@js.get "hasSourceURL"]
        val set_hasSourceURL: t -> bool -> unit [@@js.set "hasSourceURL"]
        val get_isModule: t -> bool [@@js.get "isModule"]
        val set_isModule: t -> bool -> unit [@@js.set "isModule"]
        val get_length: t -> float [@@js.get "length"]
        val set_length: t -> float -> unit [@@js.set "length"]
        val get_stackTrace: t -> inspector_Runtime_StackTrace [@@js.get "stackTrace"]
        val set_stackTrace: t -> inspector_Runtime_StackTrace -> unit [@@js.set "stackTrace"]
      end
      module[@js.scope "ScriptFailedToParseEventDataType"] ScriptFailedToParseEventDataType : sig
        type t = inspector_Debugger_ScriptFailedToParseEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_url: t -> string [@@js.get "url"]
        val set_url: t -> string -> unit [@@js.set "url"]
        val get_startLine: t -> float [@@js.get "startLine"]
        val set_startLine: t -> float -> unit [@@js.set "startLine"]
        val get_startColumn: t -> float [@@js.get "startColumn"]
        val set_startColumn: t -> float -> unit [@@js.set "startColumn"]
        val get_endLine: t -> float [@@js.get "endLine"]
        val set_endLine: t -> float -> unit [@@js.set "endLine"]
        val get_endColumn: t -> float [@@js.get "endColumn"]
        val set_endColumn: t -> float -> unit [@@js.set "endColumn"]
        val get_executionContextId: t -> inspector_Runtime_ExecutionContextId [@@js.get "executionContextId"]
        val set_executionContextId: t -> inspector_Runtime_ExecutionContextId -> unit [@@js.set "executionContextId"]
        val get_hash: t -> string [@@js.get "hash"]
        val set_hash: t -> string -> unit [@@js.set "hash"]
        val get_executionContextAuxData: t -> anonymous_interface_0 [@@js.get "executionContextAuxData"]
        val set_executionContextAuxData: t -> anonymous_interface_0 -> unit [@@js.set "executionContextAuxData"]
        val get_sourceMapURL: t -> string [@@js.get "sourceMapURL"]
        val set_sourceMapURL: t -> string -> unit [@@js.set "sourceMapURL"]
        val get_hasSourceURL: t -> bool [@@js.get "hasSourceURL"]
        val set_hasSourceURL: t -> bool -> unit [@@js.set "hasSourceURL"]
        val get_isModule: t -> bool [@@js.get "isModule"]
        val set_isModule: t -> bool -> unit [@@js.set "isModule"]
        val get_length: t -> float [@@js.get "length"]
        val set_length: t -> float -> unit [@@js.set "length"]
        val get_stackTrace: t -> inspector_Runtime_StackTrace [@@js.get "stackTrace"]
        val set_stackTrace: t -> inspector_Runtime_StackTrace -> unit [@@js.set "stackTrace"]
      end
      module[@js.scope "BreakpointResolvedEventDataType"] BreakpointResolvedEventDataType : sig
        type t = inspector_Debugger_BreakpointResolvedEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_breakpointId: t -> inspector_Debugger_BreakpointId [@@js.get "breakpointId"]
        val set_breakpointId: t -> inspector_Debugger_BreakpointId -> unit [@@js.set "breakpointId"]
        val get_location: t -> inspector_Debugger_Location [@@js.get "location"]
        val set_location: t -> inspector_Debugger_Location -> unit [@@js.set "location"]
      end
      module[@js.scope "PausedEventDataType"] PausedEventDataType : sig
        type t = inspector_Debugger_PausedEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_callFrames: t -> inspector_Debugger_CallFrame list [@@js.get "callFrames"]
        val set_callFrames: t -> inspector_Debugger_CallFrame list -> unit [@@js.set "callFrames"]
        val get_reason: t -> string [@@js.get "reason"]
        val set_reason: t -> string -> unit [@@js.set "reason"]
        val get_data: t -> anonymous_interface_0 [@@js.get "data"]
        val set_data: t -> anonymous_interface_0 -> unit [@@js.set "data"]
        val get_hitBreakpoints: t -> string list [@@js.get "hitBreakpoints"]
        val set_hitBreakpoints: t -> string list -> unit [@@js.set "hitBreakpoints"]
        val get_asyncStackTrace: t -> inspector_Runtime_StackTrace [@@js.get "asyncStackTrace"]
        val set_asyncStackTrace: t -> inspector_Runtime_StackTrace -> unit [@@js.set "asyncStackTrace"]
        val get_asyncStackTraceId: t -> inspector_Runtime_StackTraceId [@@js.get "asyncStackTraceId"]
        val set_asyncStackTraceId: t -> inspector_Runtime_StackTraceId -> unit [@@js.set "asyncStackTraceId"]
        val get_asyncCallStackTraceId: t -> inspector_Runtime_StackTraceId [@@js.get "asyncCallStackTraceId"]
        val set_asyncCallStackTraceId: t -> inspector_Runtime_StackTraceId -> unit [@@js.set "asyncCallStackTraceId"]
      end
    end
    module[@js.scope "Console"] Console : sig
      module[@js.scope "ConsoleMessage"] ConsoleMessage : sig
        type t = inspector_Console_ConsoleMessage
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_source: t -> string [@@js.get "source"]
        val set_source: t -> string -> unit [@@js.set "source"]
        val get_level: t -> string [@@js.get "level"]
        val set_level: t -> string -> unit [@@js.set "level"]
        val get_text: t -> string [@@js.get "text"]
        val set_text: t -> string -> unit [@@js.set "text"]
        val get_url: t -> string [@@js.get "url"]
        val set_url: t -> string -> unit [@@js.set "url"]
        val get_line: t -> float [@@js.get "line"]
        val set_line: t -> float -> unit [@@js.set "line"]
        val get_column: t -> float [@@js.get "column"]
        val set_column: t -> float -> unit [@@js.set "column"]
      end
      module[@js.scope "MessageAddedEventDataType"] MessageAddedEventDataType : sig
        type t = inspector_Console_MessageAddedEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_message: t -> inspector_Console_ConsoleMessage [@@js.get "message"]
        val set_message: t -> inspector_Console_ConsoleMessage -> unit [@@js.set "message"]
      end
    end
    module[@js.scope "Profiler"] Profiler : sig
      module[@js.scope "ProfileNode"] ProfileNode : sig
        type t = inspector_Profiler_ProfileNode
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_id: t -> float [@@js.get "id"]
        val set_id: t -> float -> unit [@@js.set "id"]
        val get_callFrame: t -> inspector_Runtime_CallFrame [@@js.get "callFrame"]
        val set_callFrame: t -> inspector_Runtime_CallFrame -> unit [@@js.set "callFrame"]
        val get_hitCount: t -> float [@@js.get "hitCount"]
        val set_hitCount: t -> float -> unit [@@js.set "hitCount"]
        val get_children: t -> float list [@@js.get "children"]
        val set_children: t -> float list -> unit [@@js.set "children"]
        val get_deoptReason: t -> string [@@js.get "deoptReason"]
        val set_deoptReason: t -> string -> unit [@@js.set "deoptReason"]
        val get_positionTicks: t -> inspector_Profiler_PositionTickInfo list [@@js.get "positionTicks"]
        val set_positionTicks: t -> inspector_Profiler_PositionTickInfo list -> unit [@@js.set "positionTicks"]
      end
      module[@js.scope "Profile"] Profile : sig
        type t = inspector_Profiler_Profile
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_nodes: t -> inspector_Profiler_ProfileNode list [@@js.get "nodes"]
        val set_nodes: t -> inspector_Profiler_ProfileNode list -> unit [@@js.set "nodes"]
        val get_startTime: t -> float [@@js.get "startTime"]
        val set_startTime: t -> float -> unit [@@js.set "startTime"]
        val get_endTime: t -> float [@@js.get "endTime"]
        val set_endTime: t -> float -> unit [@@js.set "endTime"]
        val get_samples: t -> float list [@@js.get "samples"]
        val set_samples: t -> float list -> unit [@@js.set "samples"]
        val get_timeDeltas: t -> float list [@@js.get "timeDeltas"]
        val set_timeDeltas: t -> float list -> unit [@@js.set "timeDeltas"]
      end
      module[@js.scope "PositionTickInfo"] PositionTickInfo : sig
        type t = inspector_Profiler_PositionTickInfo
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_line: t -> float [@@js.get "line"]
        val set_line: t -> float -> unit [@@js.set "line"]
        val get_ticks: t -> float [@@js.get "ticks"]
        val set_ticks: t -> float -> unit [@@js.set "ticks"]
      end
      module[@js.scope "CoverageRange"] CoverageRange : sig
        type t = inspector_Profiler_CoverageRange
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_startOffset: t -> float [@@js.get "startOffset"]
        val set_startOffset: t -> float -> unit [@@js.set "startOffset"]
        val get_endOffset: t -> float [@@js.get "endOffset"]
        val set_endOffset: t -> float -> unit [@@js.set "endOffset"]
        val get_count: t -> float [@@js.get "count"]
        val set_count: t -> float -> unit [@@js.set "count"]
      end
      module[@js.scope "FunctionCoverage"] FunctionCoverage : sig
        type t = inspector_Profiler_FunctionCoverage
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_functionName: t -> string [@@js.get "functionName"]
        val set_functionName: t -> string -> unit [@@js.set "functionName"]
        val get_ranges: t -> inspector_Profiler_CoverageRange list [@@js.get "ranges"]
        val set_ranges: t -> inspector_Profiler_CoverageRange list -> unit [@@js.set "ranges"]
        val get_isBlockCoverage: t -> bool [@@js.get "isBlockCoverage"]
        val set_isBlockCoverage: t -> bool -> unit [@@js.set "isBlockCoverage"]
      end
      module[@js.scope "ScriptCoverage"] ScriptCoverage : sig
        type t = inspector_Profiler_ScriptCoverage
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_url: t -> string [@@js.get "url"]
        val set_url: t -> string -> unit [@@js.set "url"]
        val get_functions: t -> inspector_Profiler_FunctionCoverage list [@@js.get "functions"]
        val set_functions: t -> inspector_Profiler_FunctionCoverage list -> unit [@@js.set "functions"]
      end
      module[@js.scope "TypeObject"] TypeObject : sig
        type t = inspector_Profiler_TypeObject
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_name: t -> string [@@js.get "name"]
        val set_name: t -> string -> unit [@@js.set "name"]
      end
      module[@js.scope "TypeProfileEntry"] TypeProfileEntry : sig
        type t = inspector_Profiler_TypeProfileEntry
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_offset: t -> float [@@js.get "offset"]
        val set_offset: t -> float -> unit [@@js.set "offset"]
        val get_types: t -> inspector_Profiler_TypeObject list [@@js.get "types"]
        val set_types: t -> inspector_Profiler_TypeObject list -> unit [@@js.set "types"]
      end
      module[@js.scope "ScriptTypeProfile"] ScriptTypeProfile : sig
        type t = inspector_Profiler_ScriptTypeProfile
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_scriptId: t -> inspector_Runtime_ScriptId [@@js.get "scriptId"]
        val set_scriptId: t -> inspector_Runtime_ScriptId -> unit [@@js.set "scriptId"]
        val get_url: t -> string [@@js.get "url"]
        val set_url: t -> string -> unit [@@js.set "url"]
        val get_entries: t -> inspector_Profiler_TypeProfileEntry list [@@js.get "entries"]
        val set_entries: t -> inspector_Profiler_TypeProfileEntry list -> unit [@@js.set "entries"]
      end
      module[@js.scope "SetSamplingIntervalParameterType"] SetSamplingIntervalParameterType : sig
        type t = inspector_Profiler_SetSamplingIntervalParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_interval: t -> float [@@js.get "interval"]
        val set_interval: t -> float -> unit [@@js.set "interval"]
      end
      module[@js.scope "StartPreciseCoverageParameterType"] StartPreciseCoverageParameterType : sig
        type t = inspector_Profiler_StartPreciseCoverageParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_callCount: t -> bool [@@js.get "callCount"]
        val set_callCount: t -> bool -> unit [@@js.set "callCount"]
        val get_detailed: t -> bool [@@js.get "detailed"]
        val set_detailed: t -> bool -> unit [@@js.set "detailed"]
      end
      module[@js.scope "StopReturnType"] StopReturnType : sig
        type t = inspector_Profiler_StopReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_profile: t -> inspector_Profiler_Profile [@@js.get "profile"]
        val set_profile: t -> inspector_Profiler_Profile -> unit [@@js.set "profile"]
      end
      module[@js.scope "TakePreciseCoverageReturnType"] TakePreciseCoverageReturnType : sig
        type t = inspector_Profiler_TakePreciseCoverageReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_result: t -> inspector_Profiler_ScriptCoverage list [@@js.get "result"]
        val set_result: t -> inspector_Profiler_ScriptCoverage list -> unit [@@js.set "result"]
      end
      module[@js.scope "GetBestEffortCoverageReturnType"] GetBestEffortCoverageReturnType : sig
        type t = inspector_Profiler_GetBestEffortCoverageReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_result: t -> inspector_Profiler_ScriptCoverage list [@@js.get "result"]
        val set_result: t -> inspector_Profiler_ScriptCoverage list -> unit [@@js.set "result"]
      end
      module[@js.scope "TakeTypeProfileReturnType"] TakeTypeProfileReturnType : sig
        type t = inspector_Profiler_TakeTypeProfileReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_result: t -> inspector_Profiler_ScriptTypeProfile list [@@js.get "result"]
        val set_result: t -> inspector_Profiler_ScriptTypeProfile list -> unit [@@js.set "result"]
      end
      module[@js.scope "ConsoleProfileStartedEventDataType"] ConsoleProfileStartedEventDataType : sig
        type t = inspector_Profiler_ConsoleProfileStartedEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_id: t -> string [@@js.get "id"]
        val set_id: t -> string -> unit [@@js.set "id"]
        val get_location: t -> inspector_Debugger_Location [@@js.get "location"]
        val set_location: t -> inspector_Debugger_Location -> unit [@@js.set "location"]
        val get_title: t -> string [@@js.get "title"]
        val set_title: t -> string -> unit [@@js.set "title"]
      end
      module[@js.scope "ConsoleProfileFinishedEventDataType"] ConsoleProfileFinishedEventDataType : sig
        type t = inspector_Profiler_ConsoleProfileFinishedEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_id: t -> string [@@js.get "id"]
        val set_id: t -> string -> unit [@@js.set "id"]
        val get_location: t -> inspector_Debugger_Location [@@js.get "location"]
        val set_location: t -> inspector_Debugger_Location -> unit [@@js.set "location"]
        val get_profile: t -> inspector_Profiler_Profile [@@js.get "profile"]
        val set_profile: t -> inspector_Profiler_Profile -> unit [@@js.set "profile"]
        val get_title: t -> string [@@js.get "title"]
        val set_title: t -> string -> unit [@@js.set "title"]
      end
    end
    module[@js.scope "HeapProfiler"] HeapProfiler : sig
      module HeapSnapshotObjectId : sig
        type t = inspector_HeapProfiler_HeapSnapshotObjectId
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module[@js.scope "SamplingHeapProfileNode"] SamplingHeapProfileNode : sig
        type t = inspector_HeapProfiler_SamplingHeapProfileNode
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_callFrame: t -> inspector_Runtime_CallFrame [@@js.get "callFrame"]
        val set_callFrame: t -> inspector_Runtime_CallFrame -> unit [@@js.set "callFrame"]
        val get_selfSize: t -> float [@@js.get "selfSize"]
        val set_selfSize: t -> float -> unit [@@js.set "selfSize"]
        val get_children: t -> t list [@@js.get "children"]
        val set_children: t -> t list -> unit [@@js.set "children"]
      end
      module[@js.scope "SamplingHeapProfile"] SamplingHeapProfile : sig
        type t = inspector_HeapProfiler_SamplingHeapProfile
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_head: t -> inspector_HeapProfiler_SamplingHeapProfileNode [@@js.get "head"]
        val set_head: t -> inspector_HeapProfiler_SamplingHeapProfileNode -> unit [@@js.set "head"]
      end
      module[@js.scope "StartTrackingHeapObjectsParameterType"] StartTrackingHeapObjectsParameterType : sig
        type t = inspector_HeapProfiler_StartTrackingHeapObjectsParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_trackAllocations: t -> bool [@@js.get "trackAllocations"]
        val set_trackAllocations: t -> bool -> unit [@@js.set "trackAllocations"]
      end
      module[@js.scope "StopTrackingHeapObjectsParameterType"] StopTrackingHeapObjectsParameterType : sig
        type t = inspector_HeapProfiler_StopTrackingHeapObjectsParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_reportProgress: t -> bool [@@js.get "reportProgress"]
        val set_reportProgress: t -> bool -> unit [@@js.set "reportProgress"]
      end
      module[@js.scope "TakeHeapSnapshotParameterType"] TakeHeapSnapshotParameterType : sig
        type t = inspector_HeapProfiler_TakeHeapSnapshotParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_reportProgress: t -> bool [@@js.get "reportProgress"]
        val set_reportProgress: t -> bool -> unit [@@js.set "reportProgress"]
      end
      module[@js.scope "GetObjectByHeapObjectIdParameterType"] GetObjectByHeapObjectIdParameterType : sig
        type t = inspector_HeapProfiler_GetObjectByHeapObjectIdParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_objectId: t -> inspector_HeapProfiler_HeapSnapshotObjectId [@@js.get "objectId"]
        val set_objectId: t -> inspector_HeapProfiler_HeapSnapshotObjectId -> unit [@@js.set "objectId"]
        val get_objectGroup: t -> string [@@js.get "objectGroup"]
        val set_objectGroup: t -> string -> unit [@@js.set "objectGroup"]
      end
      module[@js.scope "AddInspectedHeapObjectParameterType"] AddInspectedHeapObjectParameterType : sig
        type t = inspector_HeapProfiler_AddInspectedHeapObjectParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_heapObjectId: t -> inspector_HeapProfiler_HeapSnapshotObjectId [@@js.get "heapObjectId"]
        val set_heapObjectId: t -> inspector_HeapProfiler_HeapSnapshotObjectId -> unit [@@js.set "heapObjectId"]
      end
      module[@js.scope "GetHeapObjectIdParameterType"] GetHeapObjectIdParameterType : sig
        type t = inspector_HeapProfiler_GetHeapObjectIdParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_objectId: t -> inspector_Runtime_RemoteObjectId [@@js.get "objectId"]
        val set_objectId: t -> inspector_Runtime_RemoteObjectId -> unit [@@js.set "objectId"]
      end
      module[@js.scope "StartSamplingParameterType"] StartSamplingParameterType : sig
        type t = inspector_HeapProfiler_StartSamplingParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_samplingInterval: t -> float [@@js.get "samplingInterval"]
        val set_samplingInterval: t -> float -> unit [@@js.set "samplingInterval"]
      end
      module[@js.scope "GetObjectByHeapObjectIdReturnType"] GetObjectByHeapObjectIdReturnType : sig
        type t = inspector_HeapProfiler_GetObjectByHeapObjectIdReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_result: t -> inspector_Runtime_RemoteObject [@@js.get "result"]
        val set_result: t -> inspector_Runtime_RemoteObject -> unit [@@js.set "result"]
      end
      module[@js.scope "GetHeapObjectIdReturnType"] GetHeapObjectIdReturnType : sig
        type t = inspector_HeapProfiler_GetHeapObjectIdReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_heapSnapshotObjectId: t -> inspector_HeapProfiler_HeapSnapshotObjectId [@@js.get "heapSnapshotObjectId"]
        val set_heapSnapshotObjectId: t -> inspector_HeapProfiler_HeapSnapshotObjectId -> unit [@@js.set "heapSnapshotObjectId"]
      end
      module[@js.scope "StopSamplingReturnType"] StopSamplingReturnType : sig
        type t = inspector_HeapProfiler_StopSamplingReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_profile: t -> inspector_HeapProfiler_SamplingHeapProfile [@@js.get "profile"]
        val set_profile: t -> inspector_HeapProfiler_SamplingHeapProfile -> unit [@@js.set "profile"]
      end
      module[@js.scope "GetSamplingProfileReturnType"] GetSamplingProfileReturnType : sig
        type t = inspector_HeapProfiler_GetSamplingProfileReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_profile: t -> inspector_HeapProfiler_SamplingHeapProfile [@@js.get "profile"]
        val set_profile: t -> inspector_HeapProfiler_SamplingHeapProfile -> unit [@@js.set "profile"]
      end
      module[@js.scope "AddHeapSnapshotChunkEventDataType"] AddHeapSnapshotChunkEventDataType : sig
        type t = inspector_HeapProfiler_AddHeapSnapshotChunkEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_chunk: t -> string [@@js.get "chunk"]
        val set_chunk: t -> string -> unit [@@js.set "chunk"]
      end
      module[@js.scope "ReportHeapSnapshotProgressEventDataType"] ReportHeapSnapshotProgressEventDataType : sig
        type t = inspector_HeapProfiler_ReportHeapSnapshotProgressEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_done: t -> float [@@js.get "done"]
        val set_done: t -> float -> unit [@@js.set "done"]
        val get_total: t -> float [@@js.get "total"]
        val set_total: t -> float -> unit [@@js.set "total"]
        val get_finished: t -> bool [@@js.get "finished"]
        val set_finished: t -> bool -> unit [@@js.set "finished"]
      end
      module[@js.scope "LastSeenObjectIdEventDataType"] LastSeenObjectIdEventDataType : sig
        type t = inspector_HeapProfiler_LastSeenObjectIdEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_lastSeenObjectId: t -> float [@@js.get "lastSeenObjectId"]
        val set_lastSeenObjectId: t -> float -> unit [@@js.set "lastSeenObjectId"]
        val get_timestamp: t -> float [@@js.get "timestamp"]
        val set_timestamp: t -> float -> unit [@@js.set "timestamp"]
      end
      module[@js.scope "HeapStatsUpdateEventDataType"] HeapStatsUpdateEventDataType : sig
        type t = inspector_HeapProfiler_HeapStatsUpdateEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_statsUpdate: t -> float list [@@js.get "statsUpdate"]
        val set_statsUpdate: t -> float list -> unit [@@js.set "statsUpdate"]
      end
    end
    module[@js.scope "NodeTracing"] NodeTracing : sig
      module[@js.scope "TraceConfig"] TraceConfig : sig
        type t = inspector_NodeTracing_TraceConfig
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_recordMode: t -> string [@@js.get "recordMode"]
        val set_recordMode: t -> string -> unit [@@js.set "recordMode"]
        val get_includedCategories: t -> string list [@@js.get "includedCategories"]
        val set_includedCategories: t -> string list -> unit [@@js.set "includedCategories"]
      end
      module[@js.scope "StartParameterType"] StartParameterType : sig
        type t = inspector_NodeTracing_StartParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_traceConfig: t -> inspector_NodeTracing_TraceConfig [@@js.get "traceConfig"]
        val set_traceConfig: t -> inspector_NodeTracing_TraceConfig -> unit [@@js.set "traceConfig"]
      end
      module[@js.scope "GetCategoriesReturnType"] GetCategoriesReturnType : sig
        type t = inspector_NodeTracing_GetCategoriesReturnType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_categories: t -> string list [@@js.get "categories"]
        val set_categories: t -> string list -> unit [@@js.set "categories"]
      end
      module[@js.scope "DataCollectedEventDataType"] DataCollectedEventDataType : sig
        type t = inspector_NodeTracing_DataCollectedEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_value: t -> anonymous_interface_0 list [@@js.get "value"]
        val set_value: t -> anonymous_interface_0 list -> unit [@@js.set "value"]
      end
    end
    module[@js.scope "NodeWorker"] NodeWorker : sig
      module WorkerID : sig
        type t = inspector_NodeWorker_WorkerID
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module SessionID : sig
        type t = inspector_NodeWorker_SessionID
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module[@js.scope "WorkerInfo"] WorkerInfo : sig
        type t = inspector_NodeWorker_WorkerInfo
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_workerId: t -> inspector_NodeWorker_WorkerID [@@js.get "workerId"]
        val set_workerId: t -> inspector_NodeWorker_WorkerID -> unit [@@js.set "workerId"]
        val get_type: t -> string [@@js.get "type"]
        val set_type: t -> string -> unit [@@js.set "type"]
        val get_title: t -> string [@@js.get "title"]
        val set_title: t -> string -> unit [@@js.set "title"]
        val get_url: t -> string [@@js.get "url"]
        val set_url: t -> string -> unit [@@js.set "url"]
      end
      module[@js.scope "SendMessageToWorkerParameterType"] SendMessageToWorkerParameterType : sig
        type t = inspector_NodeWorker_SendMessageToWorkerParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_message: t -> string [@@js.get "message"]
        val set_message: t -> string -> unit [@@js.set "message"]
        val get_sessionId: t -> inspector_NodeWorker_SessionID [@@js.get "sessionId"]
        val set_sessionId: t -> inspector_NodeWorker_SessionID -> unit [@@js.set "sessionId"]
      end
      module[@js.scope "EnableParameterType"] EnableParameterType : sig
        type t = inspector_NodeWorker_EnableParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_waitForDebuggerOnStart: t -> bool [@@js.get "waitForDebuggerOnStart"]
        val set_waitForDebuggerOnStart: t -> bool -> unit [@@js.set "waitForDebuggerOnStart"]
      end
      module[@js.scope "DetachParameterType"] DetachParameterType : sig
        type t = inspector_NodeWorker_DetachParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_sessionId: t -> inspector_NodeWorker_SessionID [@@js.get "sessionId"]
        val set_sessionId: t -> inspector_NodeWorker_SessionID -> unit [@@js.set "sessionId"]
      end
      module[@js.scope "AttachedToWorkerEventDataType"] AttachedToWorkerEventDataType : sig
        type t = inspector_NodeWorker_AttachedToWorkerEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_sessionId: t -> inspector_NodeWorker_SessionID [@@js.get "sessionId"]
        val set_sessionId: t -> inspector_NodeWorker_SessionID -> unit [@@js.set "sessionId"]
        val get_workerInfo: t -> inspector_NodeWorker_WorkerInfo [@@js.get "workerInfo"]
        val set_workerInfo: t -> inspector_NodeWorker_WorkerInfo -> unit [@@js.set "workerInfo"]
        val get_waitingForDebugger: t -> bool [@@js.get "waitingForDebugger"]
        val set_waitingForDebugger: t -> bool -> unit [@@js.set "waitingForDebugger"]
      end
      module[@js.scope "DetachedFromWorkerEventDataType"] DetachedFromWorkerEventDataType : sig
        type t = inspector_NodeWorker_DetachedFromWorkerEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_sessionId: t -> inspector_NodeWorker_SessionID [@@js.get "sessionId"]
        val set_sessionId: t -> inspector_NodeWorker_SessionID -> unit [@@js.set "sessionId"]
      end
      module[@js.scope "ReceivedMessageFromWorkerEventDataType"] ReceivedMessageFromWorkerEventDataType : sig
        type t = inspector_NodeWorker_ReceivedMessageFromWorkerEventDataType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_sessionId: t -> inspector_NodeWorker_SessionID [@@js.get "sessionId"]
        val set_sessionId: t -> inspector_NodeWorker_SessionID -> unit [@@js.set "sessionId"]
        val get_message: t -> string [@@js.get "message"]
        val set_message: t -> string -> unit [@@js.set "message"]
      end
    end
    module[@js.scope "NodeRuntime"] NodeRuntime : sig
      module[@js.scope "NotifyWhenWaitingForDisconnectParameterType"] NotifyWhenWaitingForDisconnectParameterType : sig
        type t = inspector_NodeRuntime_NotifyWhenWaitingForDisconnectParameterType
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_enabled: t -> bool [@@js.get "enabled"]
        val set_enabled: t -> bool -> unit [@@js.set "enabled"]
      end
    end
    module[@js.scope "Session"] Session : sig
      type t = inspector_Session
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: unit -> t [@@js.create]
      val connect: t -> unit [@@js.call "connect"]
      val disconnect: t -> unit [@@js.call "disconnect"]
      val post: t -> method_:string -> ?params:anonymous_interface_0 -> ?callback:(err:Error.t_0 or_null -> ?params:anonymous_interface_0 -> unit -> unit) -> unit -> unit [@@js.call "post"]
      val post': t -> method_:string -> ?callback:(err:Error.t_0 or_null -> ?params:anonymous_interface_0 -> unit -> unit) -> unit -> unit [@@js.call "post"]
      val post'': t -> method_:([`L_s104_Schema_getDomains] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Schema_GetDomainsReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''': t -> method_:([`L_s89_Runtime_evaluate] [@js.enum]) -> ?params:inspector_Runtime_EvaluateParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_EvaluateReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''': t -> method_:([`L_s89_Runtime_evaluate] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_EvaluateReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''': t -> method_:([`L_s82_Runtime_awaitPromise] [@js.enum]) -> ?params:inspector_Runtime_AwaitPromiseParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_AwaitPromiseReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''': t -> method_:([`L_s82_Runtime_awaitPromise] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_AwaitPromiseReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''': t -> method_:([`L_s83_Runtime_callFunctionOn] [@js.enum]) -> ?params:inspector_Runtime_CallFunctionOnParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_CallFunctionOnReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''': t -> method_:([`L_s83_Runtime_callFunctionOn] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_CallFunctionOnReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''': t -> method_:([`L_s95_Runtime_getProperties] [@js.enum]) -> ?params:inspector_Runtime_GetPropertiesParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_GetPropertiesReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''': t -> method_:([`L_s95_Runtime_getProperties] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_GetPropertiesReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''': t -> method_:([`L_s99_Runtime_releaseObject] [@js.enum]) -> ?params:inspector_Runtime_ReleaseObjectParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''': t -> method_:([`L_s99_Runtime_releaseObject] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''': t -> method_:([`L_s100_Runtime_releaseObjectGroup] [@js.enum]) -> ?params:inspector_Runtime_ReleaseObjectGroupParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''': t -> method_:([`L_s100_Runtime_releaseObjectGroup] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''': t -> method_:([`L_s101_Runtime_runIfWaitingForDebugger] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''': t -> method_:([`L_s88_Runtime_enable] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''': t -> method_:([`L_s86_Runtime_disable] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''': t -> method_:([`L_s87_Runtime_discardConsoleEntries] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''': t -> method_:([`L_s103_Runtime_setCustomObjectFormatterEnabled] [@js.enum]) -> ?params:inspector_Runtime_SetCustomObjectFormatterEnabledParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''': t -> method_:([`L_s103_Runtime_setCustomObjectFormatterEnabled] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''': t -> method_:([`L_s84_Runtime_compileScript] [@js.enum]) -> ?params:inspector_Runtime_CompileScriptParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_CompileScriptReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''': t -> method_:([`L_s84_Runtime_compileScript] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_CompileScriptReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''': t -> method_:([`L_s102_Runtime_runScript] [@js.enum]) -> ?params:inspector_Runtime_RunScriptParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_RunScriptReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''': t -> method_:([`L_s102_Runtime_runScript] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_RunScriptReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''': t -> method_:([`L_s98_Runtime_queryObjects] [@js.enum]) -> ?params:inspector_Runtime_QueryObjectsParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_QueryObjectsReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''': t -> method_:([`L_s98_Runtime_queryObjects] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_QueryObjectsReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''': t -> method_:([`L_s96_Runtime_globalLexicalScopeNames] [@js.enum]) -> ?params:inspector_Runtime_GlobalLexicalScopeNamesParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_GlobalLexicalScopeNamesReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''': t -> method_:([`L_s96_Runtime_globalLexicalScopeNames] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Runtime_GlobalLexicalScopeNamesReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''': t -> method_:([`L_s7_Debugger_enable] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_EnableReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''': t -> method_:([`L_s6_Debugger_disable] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''': t -> method_:([`L_s28_Debugger_setBreakpointsActive] [@js.enum]) -> ?params:inspector_Debugger_SetBreakpointsActiveParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''': t -> method_:([`L_s28_Debugger_setBreakpointsActive] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''': t -> method_:([`L_s32_Debugger_setSkipAllPauses] [@js.enum]) -> ?params:inspector_Debugger_SetSkipAllPausesParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''': t -> method_:([`L_s32_Debugger_setSkipAllPauses] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''': t -> method_:([`L_s27_Debugger_setBreakpointByUrl] [@js.enum]) -> ?params:inspector_Debugger_SetBreakpointByUrlParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_SetBreakpointByUrlReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''': t -> method_:([`L_s27_Debugger_setBreakpointByUrl] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_SetBreakpointByUrlReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s26_Debugger_setBreakpoint] [@js.enum]) -> ?params:inspector_Debugger_SetBreakpointParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_SetBreakpointReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s26_Debugger_setBreakpoint] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_SetBreakpointReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s15_Debugger_removeBreakpoint] [@js.enum]) -> ?params:inspector_Debugger_RemoveBreakpointParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s15_Debugger_removeBreakpoint] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s9_Debugger_getPossibleBreakpoints] [@js.enum]) -> ?params:inspector_Debugger_GetPossibleBreakpointsParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_GetPossibleBreakpointsReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s9_Debugger_getPossibleBreakpoints] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_GetPossibleBreakpointsReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s5_Debugger_continueToLocation] [@js.enum]) -> ?params:inspector_Debugger_ContinueToLocationParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s5_Debugger_continueToLocation] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s13_Debugger_pauseOnAsyncCall] [@js.enum]) -> ?params:inspector_Debugger_PauseOnAsyncCallParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s13_Debugger_pauseOnAsyncCall] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s36_Debugger_stepOver] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s34_Debugger_stepInto] [@js.enum]) -> ?params:inspector_Debugger_StepIntoParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s34_Debugger_stepInto] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s35_Debugger_stepOut] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s12_Debugger_pause] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s19_Debugger_scheduleStepIntoAsync] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s17_Debugger_resume] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s11_Debugger_getStackTrace] [@js.enum]) -> ?params:inspector_Debugger_GetStackTraceParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_GetStackTraceReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s11_Debugger_getStackTrace] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_GetStackTraceReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s22_Debugger_searchInContent] [@js.enum]) -> ?params:inspector_Debugger_SearchInContentParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_SearchInContentReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s22_Debugger_searchInContent] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_SearchInContentReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s31_Debugger_setScriptSource] [@js.enum]) -> ?params:inspector_Debugger_SetScriptSourceParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_SetScriptSourceReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s31_Debugger_setScriptSource] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_SetScriptSourceReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s16_Debugger_restartFrame] [@js.enum]) -> ?params:inspector_Debugger_RestartFrameParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_RestartFrameReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s16_Debugger_restartFrame] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_RestartFrameReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s10_Debugger_getScriptSource] [@js.enum]) -> ?params:inspector_Debugger_GetScriptSourceParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_GetScriptSourceReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s10_Debugger_getScriptSource] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_GetScriptSourceReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s29_Debugger_setPauseOnExceptions] [@js.enum]) -> ?params:inspector_Debugger_SetPauseOnExceptionsParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s29_Debugger_setPauseOnExceptions] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s8_Debugger_evaluateOnCallFrame] [@js.enum]) -> ?params:inspector_Debugger_EvaluateOnCallFrameParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_EvaluateOnCallFrameReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s8_Debugger_evaluateOnCallFrame] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Debugger_EvaluateOnCallFrameReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s33_Debugger_setVariableValue] [@js.enum]) -> ?params:inspector_Debugger_SetVariableValueParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s33_Debugger_setVariableValue] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s30_Debugger_setReturnValue] [@js.enum]) -> ?params:inspector_Debugger_SetReturnValueParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s30_Debugger_setReturnValue] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s23_Debugger_setAsyncCallStackDepth] [@js.enum]) -> ?params:inspector_Debugger_SetAsyncCallStackDepthParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s23_Debugger_setAsyncCallStackDepth] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s24_Debugger_setBlackboxPatterns] [@js.enum]) -> ?params:inspector_Debugger_SetBlackboxPatternsParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s24_Debugger_setBlackboxPatterns] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s25_Debugger_setBlackboxedRanges] [@js.enum]) -> ?params:inspector_Debugger_SetBlackboxedRangesParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s25_Debugger_setBlackboxedRanges] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s2_Console_enable] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s1_Console_disable] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s0_Console_clearMessages] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s71_Profiler_enable] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s70_Profiler_disable] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s73_Profiler_setSamplingInterval] [@js.enum]) -> ?params:inspector_Profiler_SetSamplingIntervalParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s73_Profiler_setSamplingInterval] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s74_Profiler_start] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s77_Profiler_stop] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Profiler_StopReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s75_Profiler_startPreciseCoverage] [@js.enum]) -> ?params:inspector_Profiler_StartPreciseCoverageParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s75_Profiler_startPreciseCoverage] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s78_Profiler_stopPreciseCoverage] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s80_Profiler_takePreciseCoverage] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Profiler_TakePreciseCoverageReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s72_Profiler_getBestEffortCoverage] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Profiler_GetBestEffortCoverageReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s76_Profiler_startTypeProfile] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s79_Profiler_stopTypeProfile] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s81_Profiler_takeTypeProfile] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_Profiler_TakeTypeProfileReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s41_HeapProfiler_enable] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s40_HeapProfiler_disable] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s50_HeapProfiler_startTrackingHeapObjects] [@js.enum]) -> ?params:inspector_HeapProfiler_StartTrackingHeapObjectsParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s50_HeapProfiler_startTrackingHeapObjects] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s52_HeapProfiler_stopTrackingHeapObjects] [@js.enum]) -> ?params:inspector_HeapProfiler_StopTrackingHeapObjectsParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s52_HeapProfiler_stopTrackingHeapObjects] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s53_HeapProfiler_takeHeapSnapshot] [@js.enum]) -> ?params:inspector_HeapProfiler_TakeHeapSnapshotParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s53_HeapProfiler_takeHeapSnapshot] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s39_HeapProfiler_collectGarbage] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s43_HeapProfiler_getObjectByHeapObjectId] [@js.enum]) -> ?params:inspector_HeapProfiler_GetObjectByHeapObjectIdParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_HeapProfiler_GetObjectByHeapObjectIdReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s43_HeapProfiler_getObjectByHeapObjectId] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_HeapProfiler_GetObjectByHeapObjectIdReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s38_HeapProfiler_addInspectedHeapObject] [@js.enum]) -> ?params:inspector_HeapProfiler_AddInspectedHeapObjectParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s38_HeapProfiler_addInspectedHeapObject] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s42_HeapProfiler_getHeapObjectId] [@js.enum]) -> ?params:inspector_HeapProfiler_GetHeapObjectIdParameterType -> ?callback:(err:Error.t_0 or_null -> params:inspector_HeapProfiler_GetHeapObjectIdReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s42_HeapProfiler_getHeapObjectId] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_HeapProfiler_GetHeapObjectIdReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s49_HeapProfiler_startSampling] [@js.enum]) -> ?params:inspector_HeapProfiler_StartSamplingParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s49_HeapProfiler_startSampling] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s51_HeapProfiler_stopSampling] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_HeapProfiler_StopSamplingReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s44_HeapProfiler_getSamplingProfile] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_HeapProfiler_GetSamplingProfileReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s57_NodeTracing_getCategories] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> params:inspector_NodeTracing_GetCategoriesReturnType -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s58_NodeTracing_start] [@js.enum]) -> ?params:inspector_NodeTracing_StartParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s58_NodeTracing_start] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s59_NodeTracing_stop] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s67_NodeWorker_sendMessageToWorker] [@js.enum]) -> ?params:inspector_NodeWorker_SendMessageToWorkerParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s67_NodeWorker_sendMessageToWorker] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s65_NodeWorker_enable] [@js.enum]) -> ?params:inspector_NodeWorker_EnableParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s65_NodeWorker_enable] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s64_NodeWorker_disable] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s62_NodeWorker_detach] [@js.enum]) -> ?params:inspector_NodeWorker_DetachParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s62_NodeWorker_detach] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s54_NodeRuntime_notifyWhenWaitingForDisconnect] [@js.enum]) -> ?params:inspector_NodeRuntime_NotifyWhenWaitingForDisconnectParameterType -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val post'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''': t -> method_:([`L_s54_NodeRuntime_notifyWhenWaitingForDisconnect] [@js.enum]) -> ?callback:(err:Error.t_0 or_null -> unit) -> unit -> unit [@@js.call "post"]
      val addListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
      val addListener': t -> event:([`L_s105_inspectorNotification] [@js.enum]) -> listener:(message:anonymous_interface_0 inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener'': t -> event:([`L_s92_Runtime_executionContextCreated] [@js.enum]) -> listener:(message:inspector_Runtime_ExecutionContextCreatedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener''': t -> event:([`L_s93_Runtime_executionContextDestroyed] [@js.enum]) -> listener:(message:inspector_Runtime_ExecutionContextDestroyedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener'''': t -> event:([`L_s94_Runtime_executionContextsCleared] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''''': t -> event:([`L_s91_Runtime_exceptionThrown] [@js.enum]) -> listener:(message:inspector_Runtime_ExceptionThrownEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener'''''': t -> event:([`L_s90_Runtime_exceptionRevoked] [@js.enum]) -> listener:(message:inspector_Runtime_ExceptionRevokedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener''''''': t -> event:([`L_s85_Runtime_consoleAPICalled] [@js.enum]) -> listener:(message:inspector_Runtime_ConsoleAPICalledEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''': t -> event:([`L_s97_Runtime_inspectRequested] [@js.enum]) -> listener:(message:inspector_Runtime_InspectRequestedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener''''''''': t -> event:([`L_s21_Debugger_scriptParsed] [@js.enum]) -> listener:(message:inspector_Debugger_ScriptParsedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''''': t -> event:([`L_s20_Debugger_scriptFailedToParse] [@js.enum]) -> listener:(message:inspector_Debugger_ScriptFailedToParseEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener''''''''''': t -> event:([`L_s4_Debugger_breakpointResolved] [@js.enum]) -> listener:(message:inspector_Debugger_BreakpointResolvedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''''''': t -> event:([`L_s14_Debugger_paused] [@js.enum]) -> listener:(message:inspector_Debugger_PausedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener''''''''''''': t -> event:([`L_s18_Debugger_resumed] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''''''''': t -> event:([`L_s3_Console_messageAdded] [@js.enum]) -> listener:(message:inspector_Console_MessageAddedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener''''''''''''''': t -> event:([`L_s69_Profiler_consoleProfileStarted] [@js.enum]) -> listener:(message:inspector_Profiler_ConsoleProfileStartedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''''''''''': t -> event:([`L_s68_Profiler_consoleProfileFinished] [@js.enum]) -> listener:(message:inspector_Profiler_ConsoleProfileFinishedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener''''''''''''''''': t -> event:([`L_s37_HeapProfiler_addHeapSnapshotChunk] [@js.enum]) -> listener:(message:inspector_HeapProfiler_AddHeapSnapshotChunkEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''''''''''''': t -> event:([`L_s48_HeapProfiler_resetProfiles] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''''''''''''''''''': t -> event:([`L_s47_HeapProfiler_reportHeapSnapshotProgress] [@js.enum]) -> listener:(message:inspector_HeapProfiler_ReportHeapSnapshotProgressEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''''''''''''''': t -> event:([`L_s46_HeapProfiler_lastSeenObjectId] [@js.enum]) -> listener:(message:inspector_HeapProfiler_LastSeenObjectIdEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener''''''''''''''''''''': t -> event:([`L_s45_HeapProfiler_heapStatsUpdate] [@js.enum]) -> listener:(message:inspector_HeapProfiler_HeapStatsUpdateEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''''''''''''''''': t -> event:([`L_s56_NodeTracing_dataCollected] [@js.enum]) -> listener:(message:inspector_NodeTracing_DataCollectedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener''''''''''''''''''''''': t -> event:([`L_s60_NodeTracing_tracingComplete] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''''''''''''''''''': t -> event:([`L_s61_NodeWorker_attachedToWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_AttachedToWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener''''''''''''''''''''''''': t -> event:([`L_s63_NodeWorker_detachedFromWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_DetachedFromWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''''''''''''''''''''': t -> event:([`L_s66_NodeWorker_receivedMessageFromWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_ReceivedMessageFromWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "addListener"]
      val addListener''''''''''''''''''''''''''': t -> event:([`L_s55_NodeRuntime_waitingForDisconnect] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val emit: t -> event:symbol or_string -> args:(any list [@js.variadic]) -> bool [@@js.call "emit"]
      val emit': t -> event:([`L_s105_inspectorNotification] [@js.enum]) -> message:anonymous_interface_0 inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit'': t -> event:([`L_s92_Runtime_executionContextCreated] [@js.enum]) -> message:inspector_Runtime_ExecutionContextCreatedEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit''': t -> event:([`L_s93_Runtime_executionContextDestroyed] [@js.enum]) -> message:inspector_Runtime_ExecutionContextDestroyedEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit'''': t -> event:([`L_s94_Runtime_executionContextsCleared] [@js.enum]) -> bool [@@js.call "emit"]
      val emit''''': t -> event:([`L_s91_Runtime_exceptionThrown] [@js.enum]) -> message:inspector_Runtime_ExceptionThrownEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit'''''': t -> event:([`L_s90_Runtime_exceptionRevoked] [@js.enum]) -> message:inspector_Runtime_ExceptionRevokedEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit''''''': t -> event:([`L_s85_Runtime_consoleAPICalled] [@js.enum]) -> message:inspector_Runtime_ConsoleAPICalledEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit'''''''': t -> event:([`L_s97_Runtime_inspectRequested] [@js.enum]) -> message:inspector_Runtime_InspectRequestedEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit''''''''': t -> event:([`L_s21_Debugger_scriptParsed] [@js.enum]) -> message:inspector_Debugger_ScriptParsedEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit'''''''''': t -> event:([`L_s20_Debugger_scriptFailedToParse] [@js.enum]) -> message:inspector_Debugger_ScriptFailedToParseEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit''''''''''': t -> event:([`L_s4_Debugger_breakpointResolved] [@js.enum]) -> message:inspector_Debugger_BreakpointResolvedEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit'''''''''''': t -> event:([`L_s14_Debugger_paused] [@js.enum]) -> message:inspector_Debugger_PausedEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit''''''''''''': t -> event:([`L_s18_Debugger_resumed] [@js.enum]) -> bool [@@js.call "emit"]
      val emit'''''''''''''': t -> event:([`L_s3_Console_messageAdded] [@js.enum]) -> message:inspector_Console_MessageAddedEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit''''''''''''''': t -> event:([`L_s69_Profiler_consoleProfileStarted] [@js.enum]) -> message:inspector_Profiler_ConsoleProfileStartedEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit'''''''''''''''': t -> event:([`L_s68_Profiler_consoleProfileFinished] [@js.enum]) -> message:inspector_Profiler_ConsoleProfileFinishedEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit''''''''''''''''': t -> event:([`L_s37_HeapProfiler_addHeapSnapshotChunk] [@js.enum]) -> message:inspector_HeapProfiler_AddHeapSnapshotChunkEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit'''''''''''''''''': t -> event:([`L_s48_HeapProfiler_resetProfiles] [@js.enum]) -> bool [@@js.call "emit"]
      val emit''''''''''''''''''': t -> event:([`L_s47_HeapProfiler_reportHeapSnapshotProgress] [@js.enum]) -> message:inspector_HeapProfiler_ReportHeapSnapshotProgressEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit'''''''''''''''''''': t -> event:([`L_s46_HeapProfiler_lastSeenObjectId] [@js.enum]) -> message:inspector_HeapProfiler_LastSeenObjectIdEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit''''''''''''''''''''': t -> event:([`L_s45_HeapProfiler_heapStatsUpdate] [@js.enum]) -> message:inspector_HeapProfiler_HeapStatsUpdateEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit'''''''''''''''''''''': t -> event:([`L_s56_NodeTracing_dataCollected] [@js.enum]) -> message:inspector_NodeTracing_DataCollectedEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit''''''''''''''''''''''': t -> event:([`L_s60_NodeTracing_tracingComplete] [@js.enum]) -> bool [@@js.call "emit"]
      val emit'''''''''''''''''''''''': t -> event:([`L_s61_NodeWorker_attachedToWorker] [@js.enum]) -> message:inspector_NodeWorker_AttachedToWorkerEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit''''''''''''''''''''''''': t -> event:([`L_s63_NodeWorker_detachedFromWorker] [@js.enum]) -> message:inspector_NodeWorker_DetachedFromWorkerEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit'''''''''''''''''''''''''': t -> event:([`L_s66_NodeWorker_receivedMessageFromWorker] [@js.enum]) -> message:inspector_NodeWorker_ReceivedMessageFromWorkerEventDataType inspector_InspectorNotification -> bool [@@js.call "emit"]
      val emit''''''''''''''''''''''''''': t -> event:([`L_s55_NodeRuntime_waitingForDisconnect] [@js.enum]) -> bool [@@js.call "emit"]
      val on: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
      val on': t -> event:([`L_s105_inspectorNotification] [@js.enum]) -> listener:(message:anonymous_interface_0 inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on'': t -> event:([`L_s92_Runtime_executionContextCreated] [@js.enum]) -> listener:(message:inspector_Runtime_ExecutionContextCreatedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on''': t -> event:([`L_s93_Runtime_executionContextDestroyed] [@js.enum]) -> listener:(message:inspector_Runtime_ExecutionContextDestroyedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on'''': t -> event:([`L_s94_Runtime_executionContextsCleared] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''''': t -> event:([`L_s91_Runtime_exceptionThrown] [@js.enum]) -> listener:(message:inspector_Runtime_ExceptionThrownEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on'''''': t -> event:([`L_s90_Runtime_exceptionRevoked] [@js.enum]) -> listener:(message:inspector_Runtime_ExceptionRevokedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on''''''': t -> event:([`L_s85_Runtime_consoleAPICalled] [@js.enum]) -> listener:(message:inspector_Runtime_ConsoleAPICalledEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on'''''''': t -> event:([`L_s97_Runtime_inspectRequested] [@js.enum]) -> listener:(message:inspector_Runtime_InspectRequestedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on''''''''': t -> event:([`L_s21_Debugger_scriptParsed] [@js.enum]) -> listener:(message:inspector_Debugger_ScriptParsedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on'''''''''': t -> event:([`L_s20_Debugger_scriptFailedToParse] [@js.enum]) -> listener:(message:inspector_Debugger_ScriptFailedToParseEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on''''''''''': t -> event:([`L_s4_Debugger_breakpointResolved] [@js.enum]) -> listener:(message:inspector_Debugger_BreakpointResolvedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on'''''''''''': t -> event:([`L_s14_Debugger_paused] [@js.enum]) -> listener:(message:inspector_Debugger_PausedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on''''''''''''': t -> event:([`L_s18_Debugger_resumed] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'''''''''''''': t -> event:([`L_s3_Console_messageAdded] [@js.enum]) -> listener:(message:inspector_Console_MessageAddedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on''''''''''''''': t -> event:([`L_s69_Profiler_consoleProfileStarted] [@js.enum]) -> listener:(message:inspector_Profiler_ConsoleProfileStartedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on'''''''''''''''': t -> event:([`L_s68_Profiler_consoleProfileFinished] [@js.enum]) -> listener:(message:inspector_Profiler_ConsoleProfileFinishedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on''''''''''''''''': t -> event:([`L_s37_HeapProfiler_addHeapSnapshotChunk] [@js.enum]) -> listener:(message:inspector_HeapProfiler_AddHeapSnapshotChunkEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on'''''''''''''''''': t -> event:([`L_s48_HeapProfiler_resetProfiles] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''''''''''''''''''': t -> event:([`L_s47_HeapProfiler_reportHeapSnapshotProgress] [@js.enum]) -> listener:(message:inspector_HeapProfiler_ReportHeapSnapshotProgressEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on'''''''''''''''''''': t -> event:([`L_s46_HeapProfiler_lastSeenObjectId] [@js.enum]) -> listener:(message:inspector_HeapProfiler_LastSeenObjectIdEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on''''''''''''''''''''': t -> event:([`L_s45_HeapProfiler_heapStatsUpdate] [@js.enum]) -> listener:(message:inspector_HeapProfiler_HeapStatsUpdateEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on'''''''''''''''''''''': t -> event:([`L_s56_NodeTracing_dataCollected] [@js.enum]) -> listener:(message:inspector_NodeTracing_DataCollectedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on''''''''''''''''''''''': t -> event:([`L_s60_NodeTracing_tracingComplete] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'''''''''''''''''''''''': t -> event:([`L_s61_NodeWorker_attachedToWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_AttachedToWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on''''''''''''''''''''''''': t -> event:([`L_s63_NodeWorker_detachedFromWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_DetachedFromWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on'''''''''''''''''''''''''': t -> event:([`L_s66_NodeWorker_receivedMessageFromWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_ReceivedMessageFromWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "on"]
      val on''''''''''''''''''''''''''': t -> event:([`L_s55_NodeRuntime_waitingForDisconnect] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val once: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
      val once': t -> event:([`L_s105_inspectorNotification] [@js.enum]) -> listener:(message:anonymous_interface_0 inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once'': t -> event:([`L_s92_Runtime_executionContextCreated] [@js.enum]) -> listener:(message:inspector_Runtime_ExecutionContextCreatedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once''': t -> event:([`L_s93_Runtime_executionContextDestroyed] [@js.enum]) -> listener:(message:inspector_Runtime_ExecutionContextDestroyedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once'''': t -> event:([`L_s94_Runtime_executionContextsCleared] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''''': t -> event:([`L_s91_Runtime_exceptionThrown] [@js.enum]) -> listener:(message:inspector_Runtime_ExceptionThrownEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once'''''': t -> event:([`L_s90_Runtime_exceptionRevoked] [@js.enum]) -> listener:(message:inspector_Runtime_ExceptionRevokedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once''''''': t -> event:([`L_s85_Runtime_consoleAPICalled] [@js.enum]) -> listener:(message:inspector_Runtime_ConsoleAPICalledEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once'''''''': t -> event:([`L_s97_Runtime_inspectRequested] [@js.enum]) -> listener:(message:inspector_Runtime_InspectRequestedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once''''''''': t -> event:([`L_s21_Debugger_scriptParsed] [@js.enum]) -> listener:(message:inspector_Debugger_ScriptParsedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once'''''''''': t -> event:([`L_s20_Debugger_scriptFailedToParse] [@js.enum]) -> listener:(message:inspector_Debugger_ScriptFailedToParseEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once''''''''''': t -> event:([`L_s4_Debugger_breakpointResolved] [@js.enum]) -> listener:(message:inspector_Debugger_BreakpointResolvedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once'''''''''''': t -> event:([`L_s14_Debugger_paused] [@js.enum]) -> listener:(message:inspector_Debugger_PausedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once''''''''''''': t -> event:([`L_s18_Debugger_resumed] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'''''''''''''': t -> event:([`L_s3_Console_messageAdded] [@js.enum]) -> listener:(message:inspector_Console_MessageAddedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once''''''''''''''': t -> event:([`L_s69_Profiler_consoleProfileStarted] [@js.enum]) -> listener:(message:inspector_Profiler_ConsoleProfileStartedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once'''''''''''''''': t -> event:([`L_s68_Profiler_consoleProfileFinished] [@js.enum]) -> listener:(message:inspector_Profiler_ConsoleProfileFinishedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once''''''''''''''''': t -> event:([`L_s37_HeapProfiler_addHeapSnapshotChunk] [@js.enum]) -> listener:(message:inspector_HeapProfiler_AddHeapSnapshotChunkEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once'''''''''''''''''': t -> event:([`L_s48_HeapProfiler_resetProfiles] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''''''''''''''''''': t -> event:([`L_s47_HeapProfiler_reportHeapSnapshotProgress] [@js.enum]) -> listener:(message:inspector_HeapProfiler_ReportHeapSnapshotProgressEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once'''''''''''''''''''': t -> event:([`L_s46_HeapProfiler_lastSeenObjectId] [@js.enum]) -> listener:(message:inspector_HeapProfiler_LastSeenObjectIdEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once''''''''''''''''''''': t -> event:([`L_s45_HeapProfiler_heapStatsUpdate] [@js.enum]) -> listener:(message:inspector_HeapProfiler_HeapStatsUpdateEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once'''''''''''''''''''''': t -> event:([`L_s56_NodeTracing_dataCollected] [@js.enum]) -> listener:(message:inspector_NodeTracing_DataCollectedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once''''''''''''''''''''''': t -> event:([`L_s60_NodeTracing_tracingComplete] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'''''''''''''''''''''''': t -> event:([`L_s61_NodeWorker_attachedToWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_AttachedToWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once''''''''''''''''''''''''': t -> event:([`L_s63_NodeWorker_detachedFromWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_DetachedFromWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once'''''''''''''''''''''''''': t -> event:([`L_s66_NodeWorker_receivedMessageFromWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_ReceivedMessageFromWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "once"]
      val once''''''''''''''''''''''''''': t -> event:([`L_s55_NodeRuntime_waitingForDisconnect] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val prependListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
      val prependListener': t -> event:([`L_s105_inspectorNotification] [@js.enum]) -> listener:(message:anonymous_interface_0 inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener'': t -> event:([`L_s92_Runtime_executionContextCreated] [@js.enum]) -> listener:(message:inspector_Runtime_ExecutionContextCreatedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener''': t -> event:([`L_s93_Runtime_executionContextDestroyed] [@js.enum]) -> listener:(message:inspector_Runtime_ExecutionContextDestroyedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''': t -> event:([`L_s94_Runtime_executionContextsCleared] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''': t -> event:([`L_s91_Runtime_exceptionThrown] [@js.enum]) -> listener:(message:inspector_Runtime_ExceptionThrownEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''': t -> event:([`L_s90_Runtime_exceptionRevoked] [@js.enum]) -> listener:(message:inspector_Runtime_ExceptionRevokedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''': t -> event:([`L_s85_Runtime_consoleAPICalled] [@js.enum]) -> listener:(message:inspector_Runtime_ConsoleAPICalledEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''': t -> event:([`L_s97_Runtime_inspectRequested] [@js.enum]) -> listener:(message:inspector_Runtime_InspectRequestedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''''': t -> event:([`L_s21_Debugger_scriptParsed] [@js.enum]) -> listener:(message:inspector_Debugger_ScriptParsedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''''': t -> event:([`L_s20_Debugger_scriptFailedToParse] [@js.enum]) -> listener:(message:inspector_Debugger_ScriptFailedToParseEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''''''': t -> event:([`L_s4_Debugger_breakpointResolved] [@js.enum]) -> listener:(message:inspector_Debugger_BreakpointResolvedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''''''': t -> event:([`L_s14_Debugger_paused] [@js.enum]) -> listener:(message:inspector_Debugger_PausedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''''''''': t -> event:([`L_s18_Debugger_resumed] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''''''''': t -> event:([`L_s3_Console_messageAdded] [@js.enum]) -> listener:(message:inspector_Console_MessageAddedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''''''''''': t -> event:([`L_s69_Profiler_consoleProfileStarted] [@js.enum]) -> listener:(message:inspector_Profiler_ConsoleProfileStartedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''''''''''': t -> event:([`L_s68_Profiler_consoleProfileFinished] [@js.enum]) -> listener:(message:inspector_Profiler_ConsoleProfileFinishedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''''''''''''': t -> event:([`L_s37_HeapProfiler_addHeapSnapshotChunk] [@js.enum]) -> listener:(message:inspector_HeapProfiler_AddHeapSnapshotChunkEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''''''''''''': t -> event:([`L_s48_HeapProfiler_resetProfiles] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''''''''''''''': t -> event:([`L_s47_HeapProfiler_reportHeapSnapshotProgress] [@js.enum]) -> listener:(message:inspector_HeapProfiler_ReportHeapSnapshotProgressEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''''''''''''''': t -> event:([`L_s46_HeapProfiler_lastSeenObjectId] [@js.enum]) -> listener:(message:inspector_HeapProfiler_LastSeenObjectIdEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''''''''''''''''': t -> event:([`L_s45_HeapProfiler_heapStatsUpdate] [@js.enum]) -> listener:(message:inspector_HeapProfiler_HeapStatsUpdateEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''''''''''''''''': t -> event:([`L_s56_NodeTracing_dataCollected] [@js.enum]) -> listener:(message:inspector_NodeTracing_DataCollectedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''''''''''''''''''': t -> event:([`L_s60_NodeTracing_tracingComplete] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''''''''''''''''''': t -> event:([`L_s61_NodeWorker_attachedToWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_AttachedToWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''''''''''''''''''''': t -> event:([`L_s63_NodeWorker_detachedFromWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_DetachedFromWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''''''''''''''''''''': t -> event:([`L_s66_NodeWorker_receivedMessageFromWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_ReceivedMessageFromWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''''''''''''''''''''''': t -> event:([`L_s55_NodeRuntime_waitingForDisconnect] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependOnceListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener': t -> event:([`L_s105_inspectorNotification] [@js.enum]) -> listener:(message:anonymous_interface_0 inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'': t -> event:([`L_s92_Runtime_executionContextCreated] [@js.enum]) -> listener:(message:inspector_Runtime_ExecutionContextCreatedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''': t -> event:([`L_s93_Runtime_executionContextDestroyed] [@js.enum]) -> listener:(message:inspector_Runtime_ExecutionContextDestroyedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''': t -> event:([`L_s94_Runtime_executionContextsCleared] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''': t -> event:([`L_s91_Runtime_exceptionThrown] [@js.enum]) -> listener:(message:inspector_Runtime_ExceptionThrownEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''': t -> event:([`L_s90_Runtime_exceptionRevoked] [@js.enum]) -> listener:(message:inspector_Runtime_ExceptionRevokedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''': t -> event:([`L_s85_Runtime_consoleAPICalled] [@js.enum]) -> listener:(message:inspector_Runtime_ConsoleAPICalledEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''': t -> event:([`L_s97_Runtime_inspectRequested] [@js.enum]) -> listener:(message:inspector_Runtime_InspectRequestedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''''': t -> event:([`L_s21_Debugger_scriptParsed] [@js.enum]) -> listener:(message:inspector_Debugger_ScriptParsedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''''': t -> event:([`L_s20_Debugger_scriptFailedToParse] [@js.enum]) -> listener:(message:inspector_Debugger_ScriptFailedToParseEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''''''': t -> event:([`L_s4_Debugger_breakpointResolved] [@js.enum]) -> listener:(message:inspector_Debugger_BreakpointResolvedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''''''': t -> event:([`L_s14_Debugger_paused] [@js.enum]) -> listener:(message:inspector_Debugger_PausedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''''''''': t -> event:([`L_s18_Debugger_resumed] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''''''''': t -> event:([`L_s3_Console_messageAdded] [@js.enum]) -> listener:(message:inspector_Console_MessageAddedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''''''''''': t -> event:([`L_s69_Profiler_consoleProfileStarted] [@js.enum]) -> listener:(message:inspector_Profiler_ConsoleProfileStartedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''''''''''': t -> event:([`L_s68_Profiler_consoleProfileFinished] [@js.enum]) -> listener:(message:inspector_Profiler_ConsoleProfileFinishedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''''''''''''': t -> event:([`L_s37_HeapProfiler_addHeapSnapshotChunk] [@js.enum]) -> listener:(message:inspector_HeapProfiler_AddHeapSnapshotChunkEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''''''''''''': t -> event:([`L_s48_HeapProfiler_resetProfiles] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''''''''''''''': t -> event:([`L_s47_HeapProfiler_reportHeapSnapshotProgress] [@js.enum]) -> listener:(message:inspector_HeapProfiler_ReportHeapSnapshotProgressEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''''''''''''''': t -> event:([`L_s46_HeapProfiler_lastSeenObjectId] [@js.enum]) -> listener:(message:inspector_HeapProfiler_LastSeenObjectIdEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''''''''''''''''': t -> event:([`L_s45_HeapProfiler_heapStatsUpdate] [@js.enum]) -> listener:(message:inspector_HeapProfiler_HeapStatsUpdateEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''''''''''''''''': t -> event:([`L_s56_NodeTracing_dataCollected] [@js.enum]) -> listener:(message:inspector_NodeTracing_DataCollectedEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''''''''''''''''''': t -> event:([`L_s60_NodeTracing_tracingComplete] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''''''''''''''''''': t -> event:([`L_s61_NodeWorker_attachedToWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_AttachedToWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''''''''''''''''''''': t -> event:([`L_s63_NodeWorker_detachedFromWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_DetachedFromWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''''''''''''''''''''': t -> event:([`L_s66_NodeWorker_receivedMessageFromWorker] [@js.enum]) -> listener:(message:inspector_NodeWorker_ReceivedMessageFromWorkerEventDataType inspector_InspectorNotification -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''''''''''''''''''''''': t -> event:([`L_s55_NodeRuntime_waitingForDisconnect] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val cast: t -> EventEmitter.t_0 [@@js.cast]
    end
    val open_: ?port:float -> ?host:string -> ?wait:bool -> unit -> unit [@@js.global "open"]
    val close: unit -> unit [@@js.global "close"]
    val url: unit -> string or_undefined [@@js.global "url"]
    val waitForDebugger: unit -> unit [@@js.global "waitForDebugger"]
  end
end
