[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib

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
    type ('A, 'A0, 'A1, 'A2, 'A3, 'R) anonymous_interface_5 = [`anonymous_interface_5] intf
    [@@js.custom { of_js=(fun _A _A0 _A1 _A2 _A3 _R -> Obj.magic); to_js=(fun _A _A0 _A1 _A2 _A3 _R -> Obj.magic) }]
    type ('A, 'A0, 'A1, 'A2, 'R) anonymous_interface_6 = [`anonymous_interface_6] intf
    [@@js.custom { of_js=(fun _A _A0 _A1 _A2 _R -> Obj.magic); to_js=(fun _A _A0 _A1 _A2 _R -> Obj.magic) }]
    type ('A, 'A0, 'A1, 'R) anonymous_interface_7 = [`anonymous_interface_7] intf
    [@@js.custom { of_js=(fun _A _A0 _A1 _R -> Obj.magic); to_js=(fun _A _A0 _A1 _R -> Obj.magic) }]
    type ('A, 'A0, 'R) anonymous_interface_8 = [`anonymous_interface_8] intf
    [@@js.custom { of_js=(fun _A _A0 _R -> Obj.magic); to_js=(fun _A _A0 _R -> Obj.magic) }]
    type ('A, 'R) anonymous_interface_9 = [`anonymous_interface_9] intf
    [@@js.custom { of_js=(fun _A _R -> Obj.magic); to_js=(fun _A _R -> Obj.magic) }]
    type ('A, 'T) anonymous_interface_10 = [`anonymous_interface_10] intf
    [@@js.custom { of_js=(fun _A _T -> Obj.magic); to_js=(fun _A _T -> Obj.magic) }]
    type ('AX, 'R) anonymous_interface_11 = [`anonymous_interface_11] intf
    [@@js.custom { of_js=(fun _AX _R -> Obj.magic); to_js=(fun _AX _R -> Obj.magic) }]
    type 'T anonymous_interface_12 = [`anonymous_interface_12] intf
    [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
  end
  module Types : sig
    open AnonymousInterfaces
    type 'T _Array = [`Array of 'T] intf
    [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
    and _ArrayBuffer = [`ArrayBuffer] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _ArrayBufferConstructor = [`ArrayBufferConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _ArrayBufferLike = _ArrayBuffer
    and _ArrayBufferTypes = [`ArrayBufferTypes] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _ArrayBufferView = [`ArrayBufferView] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _ArrayConstructor = [`ArrayConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'T _ArrayLike = [`ArrayLike of 'T] intf
    [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
    and _Boolean = [`Boolean] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _BooleanConstructor = [`BooleanConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _CallableFunction = [`CallableFunction | `Function] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'S _Capitalize = Ojs.t
    and _ClassDecorator = [`ClassDecorator] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'T _ConcatArray = [`ConcatArray of 'T] intf
    [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
    and 'T _ConstructorParameters = (* FIXME: unknown type 'T extends new (...args: infer P) => any ? P : never' *)any
    and _DataView = [`DataView] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _DataViewConstructor = [`DataViewConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Date = [`Date] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _DateConstructor = [`DateConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Error = [`Error] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _ErrorConstructor = [`ErrorConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _EvalError = [`EvalError | `Error] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _EvalErrorConstructor = [`EvalErrorConstructor | `ErrorConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and ('T, 'U) _Exclude = (* FIXME: unknown type 'T extends U ? never : T' *)any
    and ('T, 'U) _Extract = (* FIXME: unknown type 'T extends U ? T : never' *)any
    and _Float32Array = [`Float32Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Float32ArrayConstructor = [`Float32ArrayConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Float64Array = [`Float64Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Float64ArrayConstructor = [`Float64ArrayConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Function = untyped_function
    and _FunctionConstructor = [`FunctionConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _IArguments = [`IArguments] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _ImportMeta = [`ImportMeta] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'T _InstanceType = (* FIXME: unknown type 'T extends new (...args: any) => infer R ? R : any' *)any
    and _Int16Array = [`Int16Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Int16ArrayConstructor = [`Int16ArrayConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Int32Array = [`Int32Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Int32ArrayConstructor = [`Int32ArrayConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Int8Array = [`Int8Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Int8ArrayConstructor = [`Int8ArrayConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_Collator = [`Intl_Collator] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_CollatorOptions = [`Intl_CollatorOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_DateTimeFormat = [`Intl_DateTimeFormat] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_DateTimeFormatOptions = [`Intl_DateTimeFormatOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_NumberFormat = [`Intl_NumberFormat] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_NumberFormatOptions = [`Intl_NumberFormatOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_ResolvedCollatorOptions = [`Intl_ResolvedCollatorOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_ResolvedDateTimeFormatOptions = [`Intl_ResolvedDateTimeFormatOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_ResolvedNumberFormatOptions = [`Intl_ResolvedNumberFormatOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _JSON = [`JSON] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'S _Lowercase = Ojs.t
    and _Math = [`Math] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _MethodDecorator = [`MethodDecorator] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _NewableFunction = [`NewableFunction | `Function] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'T _NonNullable = (* FIXME: unknown type 'T extends null | undefined ? never : T' *)any
    and _Number = [`Number] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _NumberConstructor = [`NumberConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Object = untyped_object
    and _ObjectConstructor = [`ObjectConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and ('T, 'K) _Omit = ('T, ((* FIXME: unknown type ''T' *)any, 'K) _Exclude) _Pick
    and 'T _OmitThisParameter = (* FIXME: unknown type 'unknown extends ThisParameterType<T> ? T : T extends (...args: infer A) => infer R ? (...args: A) => R : T' *)any
    and _ParameterDecorator = [`ParameterDecorator] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'T _Parameters = (* FIXME: unknown type 'T extends (...args: infer P) => any ? P : never' *)any
    and 'T _Partial = (* FIXME: unknown type '{
        [P in keyof T]?: T[P];
    }' *)any
    and ('T, 'K) _Pick = (* FIXME: unknown type '{
        [P in K]: T[P];
    }' *)any
    and 'T _Promise = [`Promise of 'T] intf
    [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
    and _PromiseConstructorLike = anonymous_interface_1
    and 'T _PromiseLike = [`PromiseLike of 'T] intf
    [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
    and _PropertyDecorator = [`PropertyDecorator] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _PropertyDescriptor = [`PropertyDescriptor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _PropertyDescriptorMap = [`PropertyDescriptorMap] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _PropertyKey = symbol or_string or_number
    and _RangeError = [`RangeError | `Error] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _RangeErrorConstructor = [`RangeErrorConstructor | `ErrorConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'T _Readonly = (* FIXME: unknown type '{
        readonly [P in keyof T]: T[P];
    }' *)any
    and 'T _ReadonlyArray = [`ReadonlyArray of 'T] intf
    [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
    and ('K, 'T) _Record = (* FIXME: unknown type '{
        [P in K]: T;
    }' *)any
    and _ReferenceError = [`ReferenceError | `Error] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _ReferenceErrorConstructor = [`ReferenceErrorConstructor | `ErrorConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _RegExp = regexp
    and _RegExpConstructor = [`RegExpConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _RegExpExecArray = [`RegExpExecArray | `Array of string] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _RegExpMatchArray = [`RegExpMatchArray | `Array of string] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'T _Required = (* FIXME: unknown type '{
        [P in keyof T]-?: T[P];
    }' *)any
    and 'T _ReturnType = (* FIXME: unknown type 'T extends (...args: any) => infer R ? R : any' *)any
    and _String = [`String] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _StringConstructor = [`StringConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Symbol = symbol
    and _SyntaxError = [`SyntaxError | `Error] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _SyntaxErrorConstructor = [`SyntaxErrorConstructor | `ErrorConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _TemplateStringsArray = [`TemplateStringsArray | `ReadonlyArray of string] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'T _ThisParameterType = (* FIXME: unknown type 'T extends (this: infer U, ...args: any[]) => any ? U : unknown' *)any
    and 'T _ThisType = [`ThisType of 'T] intf
    [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
    and _TypeError = [`TypeError | `Error] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _TypeErrorConstructor = [`TypeErrorConstructor | `ErrorConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'T _TypedPropertyDescriptor = [`TypedPropertyDescriptor of 'T] intf
    [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
    and _URIError = [`URIError | `Error] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _URIErrorConstructor = [`URIErrorConstructor | `ErrorConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Uint16Array = [`Uint16Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Uint16ArrayConstructor = [`Uint16ArrayConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Uint32Array = [`Uint32Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Uint32ArrayConstructor = [`Uint32ArrayConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Uint8Array = [`Uint8Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Uint8ArrayConstructor = [`Uint8ArrayConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Uint8ClampedArray = [`Uint8ClampedArray] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Uint8ClampedArrayConstructor = [`Uint8ClampedArrayConstructor] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'S _Uncapitalize = Ojs.t
    and 'S _Uppercase = Ojs.t
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
  val create: t -> args:((* FIXME: type 'Any' cannot be used for variadic argument *)any list [@js.variadic]) -> any [@@js.apply_newable]
end
module AnonymousInterface1 : sig
  type t = anonymous_interface_1
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> executor:(resolve:(value:('T, 'T _PromiseLike) union2 -> unit) -> reject:(?reason:any -> unit -> unit) -> unit) -> 'T _PromiseLike [@@js.apply_newable]
end
module AnonymousInterface2 : sig
  type t = anonymous_interface_2
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?locales:string list or_string -> ?options:_Intl_CollatorOptions -> unit -> _Intl_Collator [@@js.apply_newable]
  val apply: t -> ?locales:string list or_string -> ?options:_Intl_CollatorOptions -> unit -> _Intl_Collator [@@js.apply]
  val supportedLocalesOf: t -> locales:string list or_string -> ?options:_Intl_CollatorOptions -> unit -> string list [@@js.call "supportedLocalesOf"]
end
module AnonymousInterface3 : sig
  type t = anonymous_interface_3
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?locales:string list or_string -> ?options:_Intl_DateTimeFormatOptions -> unit -> _Intl_DateTimeFormat [@@js.apply_newable]
  val apply: t -> ?locales:string list or_string -> ?options:_Intl_DateTimeFormatOptions -> unit -> _Intl_DateTimeFormat [@@js.apply]
  val supportedLocalesOf: t -> locales:string list or_string -> ?options:_Intl_DateTimeFormatOptions -> unit -> string list [@@js.call "supportedLocalesOf"]
end
module AnonymousInterface4 : sig
  type t = anonymous_interface_4
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?locales:string list or_string -> ?options:_Intl_NumberFormatOptions -> unit -> _Intl_NumberFormat [@@js.apply_newable]
  val apply: t -> ?locales:string list or_string -> ?options:_Intl_NumberFormatOptions -> unit -> _Intl_NumberFormat [@@js.apply]
  val supportedLocalesOf: t -> locales:string list or_string -> ?options:_Intl_NumberFormatOptions -> unit -> string list [@@js.call "supportedLocalesOf"]
end
module AnonymousInterface5 : sig
  type ('A, 'A0, 'A1, 'A2, 'A3, 'R) t = ('A, 'A0, 'A1, 'A2, 'A3, 'R) anonymous_interface_5
  val t_to_js: ('A -> Ojs.t) -> ('A0 -> Ojs.t) -> ('A1 -> Ojs.t) -> ('A2 -> Ojs.t) -> ('A3 -> Ojs.t) -> ('R -> Ojs.t) -> ('A, 'A0, 'A1, 'A2, 'A3, 'R) t -> Ojs.t
  val t_of_js: (Ojs.t -> 'A) -> (Ojs.t -> 'A0) -> (Ojs.t -> 'A1) -> (Ojs.t -> 'A2) -> (Ojs.t -> 'A3) -> (Ojs.t -> 'R) -> Ojs.t -> ('A, 'A0, 'A1, 'A2, 'A3, 'R) t
  type ('A, 'A0, 'A1, 'A2, 'A3, 'R) t_6 = ('A, 'A0, 'A1, 'A2, 'A3, 'R) t
  val t_6_to_js: ('A -> Ojs.t) -> ('A0 -> Ojs.t) -> ('A1 -> Ojs.t) -> ('A2 -> Ojs.t) -> ('A3 -> Ojs.t) -> ('R -> Ojs.t) -> ('A, 'A0, 'A1, 'A2, 'A3, 'R) t_6 -> Ojs.t
  val t_6_of_js: (Ojs.t -> 'A) -> (Ojs.t -> 'A0) -> (Ojs.t -> 'A1) -> (Ojs.t -> 'A2) -> (Ojs.t -> 'A3) -> (Ojs.t -> 'R) -> Ojs.t -> ('A, 'A0, 'A1, 'A2, 'A3, 'R) t_6
  val create: ('A, 'A0, 'A1, 'A2, 'A3, 'R) t -> arg0:'A0 -> arg1:'A1 -> arg2:'A2 -> arg3:'A3 -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R [@@js.apply_newable]
end
module AnonymousInterface6 : sig
  type ('A, 'A0, 'A1, 'A2, 'R) t = ('A, 'A0, 'A1, 'A2, 'R) anonymous_interface_6
  val t_to_js: ('A -> Ojs.t) -> ('A0 -> Ojs.t) -> ('A1 -> Ojs.t) -> ('A2 -> Ojs.t) -> ('R -> Ojs.t) -> ('A, 'A0, 'A1, 'A2, 'R) t -> Ojs.t
  val t_of_js: (Ojs.t -> 'A) -> (Ojs.t -> 'A0) -> (Ojs.t -> 'A1) -> (Ojs.t -> 'A2) -> (Ojs.t -> 'R) -> Ojs.t -> ('A, 'A0, 'A1, 'A2, 'R) t
  type ('A, 'A0, 'A1, 'A2, 'R) t_5 = ('A, 'A0, 'A1, 'A2, 'R) t
  val t_5_to_js: ('A -> Ojs.t) -> ('A0 -> Ojs.t) -> ('A1 -> Ojs.t) -> ('A2 -> Ojs.t) -> ('R -> Ojs.t) -> ('A, 'A0, 'A1, 'A2, 'R) t_5 -> Ojs.t
  val t_5_of_js: (Ojs.t -> 'A) -> (Ojs.t -> 'A0) -> (Ojs.t -> 'A1) -> (Ojs.t -> 'A2) -> (Ojs.t -> 'R) -> Ojs.t -> ('A, 'A0, 'A1, 'A2, 'R) t_5
  val create: ('A, 'A0, 'A1, 'A2, 'R) t -> arg0:'A0 -> arg1:'A1 -> arg2:'A2 -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R [@@js.apply_newable]
end
module AnonymousInterface7 : sig
  type ('A, 'A0, 'A1, 'R) t = ('A, 'A0, 'A1, 'R) anonymous_interface_7
  val t_to_js: ('A -> Ojs.t) -> ('A0 -> Ojs.t) -> ('A1 -> Ojs.t) -> ('R -> Ojs.t) -> ('A, 'A0, 'A1, 'R) t -> Ojs.t
  val t_of_js: (Ojs.t -> 'A) -> (Ojs.t -> 'A0) -> (Ojs.t -> 'A1) -> (Ojs.t -> 'R) -> Ojs.t -> ('A, 'A0, 'A1, 'R) t
  type ('A, 'A0, 'A1, 'R) t_4 = ('A, 'A0, 'A1, 'R) t
  val t_4_to_js: ('A -> Ojs.t) -> ('A0 -> Ojs.t) -> ('A1 -> Ojs.t) -> ('R -> Ojs.t) -> ('A, 'A0, 'A1, 'R) t_4 -> Ojs.t
  val t_4_of_js: (Ojs.t -> 'A) -> (Ojs.t -> 'A0) -> (Ojs.t -> 'A1) -> (Ojs.t -> 'R) -> Ojs.t -> ('A, 'A0, 'A1, 'R) t_4
  val create: ('A, 'A0, 'A1, 'R) t -> arg0:'A0 -> arg1:'A1 -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R [@@js.apply_newable]
end
module AnonymousInterface8 : sig
  type ('A, 'A0, 'R) t = ('A, 'A0, 'R) anonymous_interface_8
  val t_to_js: ('A -> Ojs.t) -> ('A0 -> Ojs.t) -> ('R -> Ojs.t) -> ('A, 'A0, 'R) t -> Ojs.t
  val t_of_js: (Ojs.t -> 'A) -> (Ojs.t -> 'A0) -> (Ojs.t -> 'R) -> Ojs.t -> ('A, 'A0, 'R) t
  type ('A, 'A0, 'R) t_3 = ('A, 'A0, 'R) t
  val t_3_to_js: ('A -> Ojs.t) -> ('A0 -> Ojs.t) -> ('R -> Ojs.t) -> ('A, 'A0, 'R) t_3 -> Ojs.t
  val t_3_of_js: (Ojs.t -> 'A) -> (Ojs.t -> 'A0) -> (Ojs.t -> 'R) -> Ojs.t -> ('A, 'A0, 'R) t_3
  val create: ('A, 'A0, 'R) t -> arg0:'A0 -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R [@@js.apply_newable]
end
module AnonymousInterface9 : sig
  type ('A, 'R) t = ('A, 'R) anonymous_interface_9
  val t_to_js: ('A -> Ojs.t) -> ('R -> Ojs.t) -> ('A, 'R) t -> Ojs.t
  val t_of_js: (Ojs.t -> 'A) -> (Ojs.t -> 'R) -> Ojs.t -> ('A, 'R) t
  type ('A, 'R) t_2 = ('A, 'R) t
  val t_2_to_js: ('A -> Ojs.t) -> ('R -> Ojs.t) -> ('A, 'R) t_2 -> Ojs.t
  val t_2_of_js: (Ojs.t -> 'A) -> (Ojs.t -> 'R) -> Ojs.t -> ('A, 'R) t_2
  val create: ('A, 'R) t -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R [@@js.apply_newable]
end
module AnonymousInterface10 : sig
  type ('A, 'T) t = ('A, 'T) anonymous_interface_10
  val t_to_js: ('A -> Ojs.t) -> ('T -> Ojs.t) -> ('A, 'T) t -> Ojs.t
  val t_of_js: (Ojs.t -> 'A) -> (Ojs.t -> 'T) -> Ojs.t -> ('A, 'T) t
  type ('A, 'T) t_2 = ('A, 'T) t
  val t_2_to_js: ('A -> Ojs.t) -> ('T -> Ojs.t) -> ('A, 'T) t_2 -> Ojs.t
  val t_2_of_js: (Ojs.t -> 'A) -> (Ojs.t -> 'T) -> Ojs.t -> ('A, 'T) t_2
  val create: ('A, 'T) t -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'T [@@js.apply_newable]
end
module AnonymousInterface11 : sig
  type ('AX, 'R) t = ('AX, 'R) anonymous_interface_11
  val t_to_js: ('AX -> Ojs.t) -> ('R -> Ojs.t) -> ('AX, 'R) t -> Ojs.t
  val t_of_js: (Ojs.t -> 'AX) -> (Ojs.t -> 'R) -> Ojs.t -> ('AX, 'R) t
  type ('AX, 'R) t_2 = ('AX, 'R) t
  val t_2_to_js: ('AX -> Ojs.t) -> ('R -> Ojs.t) -> ('AX, 'R) t_2 -> Ojs.t
  val t_2_of_js: (Ojs.t -> 'AX) -> (Ojs.t -> 'R) -> Ojs.t -> ('AX, 'R) t_2
  val create: ('AX, 'R) t -> args:('AX list [@js.variadic]) -> 'R [@@js.apply_newable]
end
module AnonymousInterface12 : sig
  type 'T t = 'T anonymous_interface_12
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  val create: 'T t -> 'T [@@js.apply_newable]
end
val naN: float [@@js.global "NaN"]
val infinity: float [@@js.global "Infinity"]
val eval: x:string -> any [@@js.global "eval"]
val parseInt: s:string -> ?radix:float -> unit -> float [@@js.global "parseInt"]
val parseFloat: string:string -> float [@@js.global "parseFloat"]
val isNaN: number:float -> bool [@@js.global "isNaN"]
val isFinite: number:float -> bool [@@js.global "isFinite"]
val decodeURI: encodedURI:string -> string [@@js.global "decodeURI"]
val decodeURIComponent: encodedURIComponent:string -> string [@@js.global "decodeURIComponent"]
val encodeURI: uri:string -> string [@@js.global "encodeURI"]
val encodeURIComponent: uriComponent:bool or_string or_number -> string [@@js.global "encodeURIComponent"]
val escape: string:string -> string [@@js.global "escape"]
val unescape: string:string -> string [@@js.global "unescape"]
module[@js.scope "Symbol"] Symbol : sig
  type t = _Symbol
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val toString: t -> string [@@js.call "toString"]
  val valueOf: t -> symbol [@@js.call "valueOf"]
end
module PropertyKey : sig
  type t = _PropertyKey
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
end
module[@js.scope "PropertyDescriptor"] PropertyDescriptor : sig
  type t = _PropertyDescriptor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_configurable: t -> bool [@@js.get "configurable"]
  val set_configurable: t -> bool -> unit [@@js.set "configurable"]
  val get_enumerable: t -> bool [@@js.get "enumerable"]
  val set_enumerable: t -> bool -> unit [@@js.set "enumerable"]
  val get_value: t -> any [@@js.get "value"]
  val set_value: t -> any -> unit [@@js.set "value"]
  val get_writable: t -> bool [@@js.get "writable"]
  val set_writable: t -> bool -> unit [@@js.set "writable"]
  val get_: t -> any [@@js.call "get"]
  val set_: t -> v:any -> unit [@@js.call "set"]
end
module[@js.scope "PropertyDescriptorMap"] PropertyDescriptorMap : sig
  type t = _PropertyDescriptorMap
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get: t -> string -> _PropertyDescriptor [@@js.index_get]
  val set: t -> string -> _PropertyDescriptor -> unit [@@js.index_set]
end
module[@js.scope "Object"] Object : sig
  type t = _Object
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_constructor: t -> _Function [@@js.get "constructor"]
  val set_constructor: t -> _Function -> unit [@@js.set "constructor"]
  val toString: t -> string [@@js.call "toString"]
  val toLocaleString: t -> string [@@js.call "toLocaleString"]
  val valueOf: t -> t [@@js.call "valueOf"]
  val hasOwnProperty: t -> v:_PropertyKey -> bool [@@js.call "hasOwnProperty"]
  val isPrototypeOf: t -> v:t -> bool [@@js.call "isPrototypeOf"]
  val propertyIsEnumerable: t -> v:_PropertyKey -> bool [@@js.call "propertyIsEnumerable"]
end
module[@js.scope "ObjectConstructor"] ObjectConstructor : sig
  type t = _ObjectConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?value:any -> unit -> _Object [@@js.apply_newable]
  val apply: t -> any [@@js.apply]
  val apply': t -> value:any -> any [@@js.apply]
  val get_prototype: t -> _Object [@@js.get "prototype"]
  val getPrototypeOf: t -> o:any -> any [@@js.call "getPrototypeOf"]
  val getOwnPropertyDescriptor: t -> o:any -> p:_PropertyKey -> _PropertyDescriptor or_undefined [@@js.call "getOwnPropertyDescriptor"]
  val getOwnPropertyNames: t -> o:any -> string list [@@js.call "getOwnPropertyNames"]
  val create_: t -> o:untyped_object or_null -> any [@@js.call "create"]
  val create_': t -> o:untyped_object or_null -> properties:(_PropertyDescriptorMap, any _ThisType) intersection2 -> any [@@js.call "create"]
  val defineProperty: t -> o:any -> p:_PropertyKey -> attributes:(_PropertyDescriptor, any _ThisType) intersection2 -> any [@@js.call "defineProperty"]
  val defineProperties: t -> o:any -> properties:(_PropertyDescriptorMap, any _ThisType) intersection2 -> any [@@js.call "defineProperties"]
  val seal: t -> o:'T -> 'T [@@js.call "seal"]
  val freeze: t -> a:'T list -> 'T list [@@js.call "freeze"]
  val freeze': t -> f:'T -> 'T [@@js.call "freeze"]
  val freeze'': t -> o:'T -> 'T _Readonly [@@js.call "freeze"]
  val preventExtensions: t -> o:'T -> 'T [@@js.call "preventExtensions"]
  val isSealed: t -> o:any -> bool [@@js.call "isSealed"]
  val isFrozen: t -> o:any -> bool [@@js.call "isFrozen"]
  val isExtensible: t -> o:any -> bool [@@js.call "isExtensible"]
  val keys: t -> o:untyped_object -> string list [@@js.call "keys"]
end
val object_: _ObjectConstructor [@@js.global "Object"]
module[@js.scope "Function"] Function : sig
  type t = _Function
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val apply_: t -> this:t -> thisArg:any -> ?argArray:any -> unit -> any [@@js.call "apply"]
  val call: t -> this:t -> thisArg:any -> argArray:(any list [@js.variadic]) -> any [@@js.call "call"]
  val bind: t -> this:t -> thisArg:any -> argArray:(any list [@js.variadic]) -> any [@@js.call "bind"]
  val toString: t -> string [@@js.call "toString"]
  val get_prototype: t -> any [@@js.get "prototype"]
  val set_prototype: t -> any -> unit [@@js.set "prototype"]
  val get_length: t -> float [@@js.get "length"]
  val get_arguments: t -> any [@@js.get "arguments"]
  val set_arguments: t -> any -> unit [@@js.set "arguments"]
  val get_caller: t -> t [@@js.get "caller"]
  val set_caller: t -> t -> unit [@@js.set "caller"]
end
module[@js.scope "FunctionConstructor"] FunctionConstructor : sig
  type t = _FunctionConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> args:(string list [@js.variadic]) -> _Function [@@js.apply_newable]
  val apply: t -> args:(string list [@js.variadic]) -> _Function [@@js.apply]
  val get_prototype: t -> _Function [@@js.get "prototype"]
end
val function_: _FunctionConstructor [@@js.global "Function"]
module ThisParameterType : sig
  type 'T t = 'T _ThisParameterType
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
end
module OmitThisParameter : sig
  type 'T t = 'T _OmitThisParameter
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
end
module[@js.scope "CallableFunction"] CallableFunction : sig
  type t = _CallableFunction
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val apply_: t -> this:(this:'T -> 'R) -> thisArg:'T -> 'R [@@js.call "apply"]
  val apply_': t -> this:(this:'T -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R) -> thisArg:'T -> args:'A -> 'R [@@js.call "apply"]
  val call: t -> this:(this:'T -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R) -> thisArg:'T -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R [@@js.call "call"]
  val bind: t -> this:'T -> thisArg:'T _ThisParameterType -> 'T _OmitThisParameter [@@js.call "bind"]
  val bind': t -> this:(this:'T -> arg0:'A0 -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R) -> thisArg:'T -> arg0:'A0 -> (args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R [@js.dummy]) [@@js.call "bind"]
  val bind'': t -> this:(this:'T -> arg0:'A0 -> arg1:'A1 -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R) -> thisArg:'T -> arg0:'A0 -> arg1:'A1 -> (args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R [@js.dummy]) [@@js.call "bind"]
  val bind''': t -> this:(this:'T -> arg0:'A0 -> arg1:'A1 -> arg2:'A2 -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R) -> thisArg:'T -> arg0:'A0 -> arg1:'A1 -> arg2:'A2 -> (args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R [@js.dummy]) [@@js.call "bind"]
  val bind'''': t -> this:(this:'T -> arg0:'A0 -> arg1:'A1 -> arg2:'A2 -> arg3:'A3 -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R) -> thisArg:'T -> arg0:'A0 -> arg1:'A1 -> arg2:'A2 -> arg3:'A3 -> (args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> 'R [@js.dummy]) [@@js.call "bind"]
  val bind''''': t -> this:(this:'T -> args:('AX list [@js.variadic]) -> 'R) -> thisArg:'T -> args:('AX list [@js.variadic]) -> (args':('AX list [@js.variadic]) -> 'R [@js.dummy]) [@@js.call "bind"]
  val cast: t -> _Function [@@js.cast]
end
module[@js.scope "NewableFunction"] NewableFunction : sig
  type t = _NewableFunction
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val apply_: t -> this:'T anonymous_interface_12 -> thisArg:'T -> unit [@@js.call "apply"]
  val apply_': t -> this:('A, 'T) anonymous_interface_10 -> thisArg:'T -> args:'A -> unit [@@js.call "apply"]
  val call: t -> this:('A, 'T) anonymous_interface_10 -> thisArg:'T -> args:((* FIXME: type ''A' cannot be used for variadic argument *)any list [@js.variadic]) -> unit [@@js.call "call"]
  val bind: t -> this:'T -> thisArg:any -> 'T [@@js.call "bind"]
  val bind': t -> this:('A, 'A0, 'R) anonymous_interface_8 -> thisArg:any -> arg0:'A0 -> ('A, 'R) anonymous_interface_9 [@@js.call "bind"]
  val bind'': t -> this:('A, 'A0, 'A1, 'R) anonymous_interface_7 -> thisArg:any -> arg0:'A0 -> arg1:'A1 -> ('A, 'R) anonymous_interface_9 [@@js.call "bind"]
  val bind''': t -> this:('A, 'A0, 'A1, 'A2, 'R) anonymous_interface_6 -> thisArg:any -> arg0:'A0 -> arg1:'A1 -> arg2:'A2 -> ('A, 'R) anonymous_interface_9 [@@js.call "bind"]
  val bind'''': t -> this:('A, 'A0, 'A1, 'A2, 'A3, 'R) anonymous_interface_5 -> thisArg:any -> arg0:'A0 -> arg1:'A1 -> arg2:'A2 -> arg3:'A3 -> ('A, 'R) anonymous_interface_9 [@@js.call "bind"]
  val bind''''': t -> this:('AX, 'R) anonymous_interface_11 -> thisArg:any -> args:('AX list [@js.variadic]) -> ('AX, 'R) anonymous_interface_11 [@@js.call "bind"]
  val cast: t -> _Function [@@js.cast]
end
module[@js.scope "IArguments"] IArguments : sig
  type t = _IArguments
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get: t -> float -> any [@@js.index_get]
  val set: t -> float -> any -> unit [@@js.index_set]
  val get_length: t -> float [@@js.get "length"]
  val set_length: t -> float -> unit [@@js.set "length"]
  val get_callee: t -> _Function [@@js.get "callee"]
  val set_callee: t -> _Function -> unit [@@js.set "callee"]
end
module[@js.scope "String"] String : sig
  type t = _String
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val localeCompare: t -> that:string -> ?locales:string list or_string -> ?options:_Intl_CollatorOptions -> unit -> float [@@js.call "localeCompare"]
  val toString: t -> string [@@js.call "toString"]
  val charAt: t -> pos:float -> string [@@js.call "charAt"]
  val charCodeAt: t -> index:float -> float [@@js.call "charCodeAt"]
  val concat: t -> strings:(string list [@js.variadic]) -> string [@@js.call "concat"]
  val indexOf: t -> searchString:string -> ?position:float -> unit -> float [@@js.call "indexOf"]
  val lastIndexOf: t -> searchString:string -> ?position:float -> unit -> float [@@js.call "lastIndexOf"]
  val localeCompare': t -> that:string -> float [@@js.call "localeCompare"]
  val match_: t -> regexp:_RegExp or_string -> _RegExpMatchArray or_null [@@js.call "match"]
  val replace: t -> searchValue:_RegExp or_string -> replaceValue:string -> string [@@js.call "replace"]
  val replace': t -> searchValue:_RegExp or_string -> replacer:(substring:string -> args:(any list [@js.variadic]) -> string) -> string [@@js.call "replace"]
  val search: t -> regexp:_RegExp or_string -> float [@@js.call "search"]
  val slice: t -> ?start:float -> ?end_:float -> unit -> string [@@js.call "slice"]
  val split: t -> separator:_RegExp or_string -> ?limit:float -> unit -> string list [@@js.call "split"]
  val substring: t -> start:float -> ?end_:float -> unit -> string [@@js.call "substring"]
  val toLowerCase: t -> string [@@js.call "toLowerCase"]
  val toLocaleLowerCase: t -> ?locales:string list or_string -> unit -> string [@@js.call "toLocaleLowerCase"]
  val toUpperCase: t -> string [@@js.call "toUpperCase"]
  val toLocaleUpperCase: t -> ?locales:string list or_string -> unit -> string [@@js.call "toLocaleUpperCase"]
  val trim: t -> string [@@js.call "trim"]
  val get_length: t -> float [@@js.get "length"]
  val substr: t -> from:float -> ?length:float -> unit -> string [@@js.call "substr"]
  val valueOf: t -> string [@@js.call "valueOf"]
  val get: t -> float -> string [@@js.index_get]
  val to_ml: t -> string [@@js.cast]
  val of_ml: string -> t [@@js.cast]
end
module[@js.scope "StringConstructor"] StringConstructor : sig
  type t = _StringConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?value:any -> unit -> _String [@@js.apply_newable]
  val apply: t -> ?value:any -> unit -> string [@@js.apply]
  val get_prototype: t -> _String [@@js.get "prototype"]
  val fromCharCode: t -> codes:(float list [@js.variadic]) -> string [@@js.call "fromCharCode"]
end
val string: _StringConstructor [@@js.global "String"]
module[@js.scope "Boolean"] Boolean : sig
  type t = _Boolean
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val valueOf: t -> bool [@@js.call "valueOf"]
  val to_ml: t -> bool [@@js.cast]
  val of_ml: bool -> t [@@js.cast]
end
module[@js.scope "BooleanConstructor"] BooleanConstructor : sig
  type t = _BooleanConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?value:any -> unit -> _Boolean [@@js.apply_newable]
  val apply: t -> ?value:'T -> unit -> bool [@@js.apply]
  val get_prototype: t -> _Boolean [@@js.get "prototype"]
end
val boolean: _BooleanConstructor [@@js.global "Boolean"]
module[@js.scope "Number"] Number : sig
  type t = _Number
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val toLocaleString: t -> ?locales:string list or_string -> ?options:_Intl_NumberFormatOptions -> unit -> string [@@js.call "toLocaleString"]
  val toString: t -> ?radix:float -> unit -> string [@@js.call "toString"]
  val toFixed: t -> ?fractionDigits:float -> unit -> string [@@js.call "toFixed"]
  val toExponential: t -> ?fractionDigits:float -> unit -> string [@@js.call "toExponential"]
  val toPrecision: t -> ?precision:float -> unit -> string [@@js.call "toPrecision"]
  val valueOf: t -> float [@@js.call "valueOf"]
  val to_ml: t -> float [@@js.cast]
  val of_ml: float -> t [@@js.cast]
end
module[@js.scope "NumberConstructor"] NumberConstructor : sig
  type t = _NumberConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?value:any -> unit -> _Number [@@js.apply_newable]
  val apply: t -> ?value:any -> unit -> float [@@js.apply]
  val get_prototype: t -> _Number [@@js.get "prototype"]
  val get_MAX_VALUE: t -> float [@@js.get "MAX_VALUE"]
  val get_MIN_VALUE: t -> float [@@js.get "MIN_VALUE"]
  val get_NaN: t -> float [@@js.get "NaN"]
  val get_NEGATIVE_INFINITY: t -> float [@@js.get "NEGATIVE_INFINITY"]
  val get_POSITIVE_INFINITY: t -> float [@@js.get "POSITIVE_INFINITY"]
end
val number: _NumberConstructor [@@js.global "Number"]
module[@js.scope "TemplateStringsArray"] TemplateStringsArray : sig
  type t = _TemplateStringsArray
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_raw: t -> string list [@@js.get "raw"]
  val cast: t -> string _ReadonlyArray [@@js.cast]
end
module ImportMeta : sig
  type t = _ImportMeta
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
end
module[@js.scope "Math"] Math : sig
  type t = _Math
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_E: t -> float [@@js.get "E"]
  val get_LN10: t -> float [@@js.get "LN10"]
  val get_LN2: t -> float [@@js.get "LN2"]
  val get_LOG2E: t -> float [@@js.get "LOG2E"]
  val get_LOG10E: t -> float [@@js.get "LOG10E"]
  val get_PI: t -> float [@@js.get "PI"]
  val get_SQRT1_2: t -> float [@@js.get "SQRT1_2"]
  val get_SQRT2: t -> float [@@js.get "SQRT2"]
  val abs: t -> x:float -> float [@@js.call "abs"]
  val acos: t -> x:float -> float [@@js.call "acos"]
  val asin: t -> x:float -> float [@@js.call "asin"]
  val atan: t -> x:float -> float [@@js.call "atan"]
  val atan2: t -> y:float -> x:float -> float [@@js.call "atan2"]
  val ceil: t -> x:float -> float [@@js.call "ceil"]
  val cos: t -> x:float -> float [@@js.call "cos"]
  val exp: t -> x:float -> float [@@js.call "exp"]
  val floor: t -> x:float -> float [@@js.call "floor"]
  val log: t -> x:float -> float [@@js.call "log"]
  val max: t -> values:(float list [@js.variadic]) -> float [@@js.call "max"]
  val min: t -> values:(float list [@js.variadic]) -> float [@@js.call "min"]
  val pow: t -> x:float -> y:float -> float [@@js.call "pow"]
  val random: t -> float [@@js.call "random"]
  val round: t -> x:float -> float [@@js.call "round"]
  val sin: t -> x:float -> float [@@js.call "sin"]
  val sqrt: t -> x:float -> float [@@js.call "sqrt"]
  val tan: t -> x:float -> float [@@js.call "tan"]
end
val math: _Math [@@js.global "Math"]
module[@js.scope "Date"] Date : sig
  type t = _Date
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val toLocaleString: t -> ?locales:string list or_string -> ?options:_Intl_DateTimeFormatOptions -> unit -> string [@@js.call "toLocaleString"]
  val toLocaleDateString: t -> ?locales:string list or_string -> ?options:_Intl_DateTimeFormatOptions -> unit -> string [@@js.call "toLocaleDateString"]
  val toLocaleTimeString: t -> ?locales:string list or_string -> ?options:_Intl_DateTimeFormatOptions -> unit -> string [@@js.call "toLocaleTimeString"]
  val toString: t -> string [@@js.call "toString"]
  val toDateString: t -> string [@@js.call "toDateString"]
  val toTimeString: t -> string [@@js.call "toTimeString"]
  val toLocaleString': t -> string [@@js.call "toLocaleString"]
  val toLocaleDateString': t -> string [@@js.call "toLocaleDateString"]
  val toLocaleTimeString': t -> string [@@js.call "toLocaleTimeString"]
  val valueOf: t -> float [@@js.call "valueOf"]
  val getTime: t -> float [@@js.call "getTime"]
  val getFullYear: t -> float [@@js.call "getFullYear"]
  val getUTCFullYear: t -> float [@@js.call "getUTCFullYear"]
  val getMonth: t -> float [@@js.call "getMonth"]
  val getUTCMonth: t -> float [@@js.call "getUTCMonth"]
  val getDate: t -> float [@@js.call "getDate"]
  val getUTCDate: t -> float [@@js.call "getUTCDate"]
  val getDay: t -> float [@@js.call "getDay"]
  val getUTCDay: t -> float [@@js.call "getUTCDay"]
  val getHours: t -> float [@@js.call "getHours"]
  val getUTCHours: t -> float [@@js.call "getUTCHours"]
  val getMinutes: t -> float [@@js.call "getMinutes"]
  val getUTCMinutes: t -> float [@@js.call "getUTCMinutes"]
  val getSeconds: t -> float [@@js.call "getSeconds"]
  val getUTCSeconds: t -> float [@@js.call "getUTCSeconds"]
  val getMilliseconds: t -> float [@@js.call "getMilliseconds"]
  val getUTCMilliseconds: t -> float [@@js.call "getUTCMilliseconds"]
  val getTimezoneOffset: t -> float [@@js.call "getTimezoneOffset"]
  val setTime: t -> time:float -> float [@@js.call "setTime"]
  val setMilliseconds: t -> ms:float -> float [@@js.call "setMilliseconds"]
  val setUTCMilliseconds: t -> ms:float -> float [@@js.call "setUTCMilliseconds"]
  val setSeconds: t -> sec:float -> ?ms:float -> unit -> float [@@js.call "setSeconds"]
  val setUTCSeconds: t -> sec:float -> ?ms:float -> unit -> float [@@js.call "setUTCSeconds"]
  val setMinutes: t -> min:float -> ?sec:float -> ?ms:float -> unit -> float [@@js.call "setMinutes"]
  val setUTCMinutes: t -> min:float -> ?sec:float -> ?ms:float -> unit -> float [@@js.call "setUTCMinutes"]
  val setHours: t -> hours:float -> ?min:float -> ?sec:float -> ?ms:float -> unit -> float [@@js.call "setHours"]
  val setUTCHours: t -> hours:float -> ?min:float -> ?sec:float -> ?ms:float -> unit -> float [@@js.call "setUTCHours"]
  val setDate: t -> date:float -> float [@@js.call "setDate"]
  val setUTCDate: t -> date:float -> float [@@js.call "setUTCDate"]
  val setMonth: t -> month:float -> ?date:float -> unit -> float [@@js.call "setMonth"]
  val setUTCMonth: t -> month:float -> ?date:float -> unit -> float [@@js.call "setUTCMonth"]
  val setFullYear: t -> year:float -> ?month:float -> ?date:float -> unit -> float [@@js.call "setFullYear"]
  val setUTCFullYear: t -> year:float -> ?month:float -> ?date:float -> unit -> float [@@js.call "setUTCFullYear"]
  val toUTCString: t -> string [@@js.call "toUTCString"]
  val toISOString: t -> string [@@js.call "toISOString"]
  val toJSON: t -> ?key:any -> unit -> string [@@js.call "toJSON"]
end
module[@js.scope "DateConstructor"] DateConstructor : sig
  type t = _DateConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> _Date [@@js.apply_newable]
  val create': t -> value:string or_number -> _Date [@@js.apply_newable]
  val create'': t -> year:float -> month:float -> ?date:float -> ?hours:float -> ?minutes:float -> ?seconds:float -> ?ms:float -> unit -> _Date [@@js.apply_newable]
  val apply: t -> string [@@js.apply]
  val get_prototype: t -> _Date [@@js.get "prototype"]
  val parse: t -> s:string -> float [@@js.call "parse"]
  val uTC: t -> year:float -> month:float -> ?date:float -> ?hours:float -> ?minutes:float -> ?seconds:float -> ?ms:float -> unit -> float [@@js.call "UTC"]
  val now: t -> float [@@js.call "now"]
end
val date: _DateConstructor [@@js.global "Date"]
module[@js.scope "RegExpMatchArray"] RegExpMatchArray : sig
  type t = _RegExpMatchArray
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_index: t -> float [@@js.get "index"]
  val set_index: t -> float -> unit [@@js.set "index"]
  val get_input: t -> string [@@js.get "input"]
  val set_input: t -> string -> unit [@@js.set "input"]
  val cast: t -> string _Array [@@js.cast]
end
module[@js.scope "RegExpExecArray"] RegExpExecArray : sig
  type t = _RegExpExecArray
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_index: t -> float [@@js.get "index"]
  val set_index: t -> float -> unit [@@js.set "index"]
  val get_input: t -> string [@@js.get "input"]
  val set_input: t -> string -> unit [@@js.set "input"]
  val cast: t -> string _Array [@@js.cast]
end
module[@js.scope "RegExp"] RegExp : sig
  type t = _RegExp
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val exec: t -> string:string -> _RegExpExecArray or_null [@@js.call "exec"]
  val test: t -> string:string -> bool [@@js.call "test"]
  val get_source: t -> string [@@js.get "source"]
  val get_global: t -> bool [@@js.get "global"]
  val get_ignoreCase: t -> bool [@@js.get "ignoreCase"]
  val get_multiline: t -> bool [@@js.get "multiline"]
  val get_lastIndex: t -> float [@@js.get "lastIndex"]
  val set_lastIndex: t -> float -> unit [@@js.set "lastIndex"]
  val compile: t -> t [@@js.call "compile"]
end
module[@js.scope "RegExpConstructor"] RegExpConstructor : sig
  type t = _RegExpConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> pattern:_RegExp or_string -> _RegExp [@@js.apply_newable]
  val create': t -> pattern:string -> ?flags:string -> unit -> _RegExp [@@js.apply_newable]
  val apply: t -> pattern:_RegExp or_string -> _RegExp [@@js.apply]
  val apply': t -> pattern:string -> ?flags:string -> unit -> _RegExp [@@js.apply]
  val get_prototype: t -> _RegExp [@@js.get "prototype"]
  val get__1: t -> string [@@js.get "$1"]
  val set__1: t -> string -> unit [@@js.set "$1"]
  val get__2: t -> string [@@js.get "$2"]
  val set__2: t -> string -> unit [@@js.set "$2"]
  val get__3: t -> string [@@js.get "$3"]
  val set__3: t -> string -> unit [@@js.set "$3"]
  val get__4: t -> string [@@js.get "$4"]
  val set__4: t -> string -> unit [@@js.set "$4"]
  val get__5: t -> string [@@js.get "$5"]
  val set__5: t -> string -> unit [@@js.set "$5"]
  val get__6: t -> string [@@js.get "$6"]
  val set__6: t -> string -> unit [@@js.set "$6"]
  val get__7: t -> string [@@js.get "$7"]
  val set__7: t -> string -> unit [@@js.set "$7"]
  val get__8: t -> string [@@js.get "$8"]
  val set__8: t -> string -> unit [@@js.set "$8"]
  val get__9: t -> string [@@js.get "$9"]
  val set__9: t -> string -> unit [@@js.set "$9"]
  val get_lastMatch: t -> string [@@js.get "lastMatch"]
  val set_lastMatch: t -> string -> unit [@@js.set "lastMatch"]
end
val regExp: _RegExpConstructor [@@js.global "RegExp"]
module[@js.scope "Error"] Error : sig
  type t = _Error
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_name: t -> string [@@js.get "name"]
  val set_name: t -> string -> unit [@@js.set "name"]
  val get_message: t -> string [@@js.get "message"]
  val set_message: t -> string -> unit [@@js.set "message"]
  val get_stack: t -> string [@@js.get "stack"]
  val set_stack: t -> string -> unit [@@js.set "stack"]
end
module[@js.scope "ErrorConstructor"] ErrorConstructor : sig
  type t = _ErrorConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?message:string -> unit -> _Error [@@js.apply_newable]
  val apply: t -> ?message:string -> unit -> _Error [@@js.apply]
  val get_prototype: t -> _Error [@@js.get "prototype"]
end
val error: _ErrorConstructor [@@js.global "Error"]
module[@js.scope "EvalError"] EvalError : sig
  type t = _EvalError
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val cast: t -> _Error [@@js.cast]
end
module[@js.scope "EvalErrorConstructor"] EvalErrorConstructor : sig
  type t = _EvalErrorConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?message:string -> unit -> _EvalError [@@js.apply_newable]
  val apply: t -> ?message:string -> unit -> _EvalError [@@js.apply]
  val get_prototype: t -> _EvalError [@@js.get "prototype"]
  val cast: t -> _ErrorConstructor [@@js.cast]
end
val evalError: _EvalErrorConstructor [@@js.global "EvalError"]
module[@js.scope "RangeError"] RangeError : sig
  type t = _RangeError
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val cast: t -> _Error [@@js.cast]
end
module[@js.scope "RangeErrorConstructor"] RangeErrorConstructor : sig
  type t = _RangeErrorConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?message:string -> unit -> _RangeError [@@js.apply_newable]
  val apply: t -> ?message:string -> unit -> _RangeError [@@js.apply]
  val get_prototype: t -> _RangeError [@@js.get "prototype"]
  val cast: t -> _ErrorConstructor [@@js.cast]
end
val rangeError: _RangeErrorConstructor [@@js.global "RangeError"]
module[@js.scope "ReferenceError"] ReferenceError : sig
  type t = _ReferenceError
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val cast: t -> _Error [@@js.cast]
end
module[@js.scope "ReferenceErrorConstructor"] ReferenceErrorConstructor : sig
  type t = _ReferenceErrorConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?message:string -> unit -> _ReferenceError [@@js.apply_newable]
  val apply: t -> ?message:string -> unit -> _ReferenceError [@@js.apply]
  val get_prototype: t -> _ReferenceError [@@js.get "prototype"]
  val cast: t -> _ErrorConstructor [@@js.cast]
end
val referenceError: _ReferenceErrorConstructor [@@js.global "ReferenceError"]
module[@js.scope "SyntaxError"] SyntaxError : sig
  type t = _SyntaxError
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val cast: t -> _Error [@@js.cast]
end
module[@js.scope "SyntaxErrorConstructor"] SyntaxErrorConstructor : sig
  type t = _SyntaxErrorConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?message:string -> unit -> _SyntaxError [@@js.apply_newable]
  val apply: t -> ?message:string -> unit -> _SyntaxError [@@js.apply]
  val get_prototype: t -> _SyntaxError [@@js.get "prototype"]
  val cast: t -> _ErrorConstructor [@@js.cast]
end
val syntaxError: _SyntaxErrorConstructor [@@js.global "SyntaxError"]
module[@js.scope "TypeError"] TypeError : sig
  type t = _TypeError
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val cast: t -> _Error [@@js.cast]
end
module[@js.scope "TypeErrorConstructor"] TypeErrorConstructor : sig
  type t = _TypeErrorConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?message:string -> unit -> _TypeError [@@js.apply_newable]
  val apply: t -> ?message:string -> unit -> _TypeError [@@js.apply]
  val get_prototype: t -> _TypeError [@@js.get "prototype"]
  val cast: t -> _ErrorConstructor [@@js.cast]
end
val typeError: _TypeErrorConstructor [@@js.global "TypeError"]
module[@js.scope "URIError"] URIError : sig
  type t = _URIError
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val cast: t -> _Error [@@js.cast]
end
module[@js.scope "URIErrorConstructor"] URIErrorConstructor : sig
  type t = _URIErrorConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?message:string -> unit -> _URIError [@@js.apply_newable]
  val apply: t -> ?message:string -> unit -> _URIError [@@js.apply]
  val get_prototype: t -> _URIError [@@js.get "prototype"]
  val cast: t -> _ErrorConstructor [@@js.cast]
end
val uRIError: _URIErrorConstructor [@@js.global "URIError"]
module[@js.scope "JSON"] JSON : sig
  type t = _JSON
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val parse: t -> text:string -> ?reviver:(this:any -> key:string -> value:any -> any) -> unit -> any [@@js.call "parse"]
  val stringify: t -> value:any -> ?replacer:(this:any -> key:string -> value:any -> any) -> ?space:string or_number -> unit -> string [@@js.call "stringify"]
  val stringify': t -> value:any -> ?replacer:string or_number list or_null -> ?space:string or_number -> unit -> string [@@js.call "stringify"]
end
val jSON: _JSON [@@js.global "JSON"]
module[@js.scope "ReadonlyArray"] ReadonlyArray : sig
  type 'T t = 'T _ReadonlyArray
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  val get_length: 'T t -> float [@@js.get "length"]
  val toString: 'T t -> string [@@js.call "toString"]
  val toLocaleString: 'T t -> string [@@js.call "toLocaleString"]
  val concat: 'T t -> items:('T _ConcatArray list [@js.variadic]) -> 'T list [@@js.call "concat"]
  val concat': 'T t -> items:(('T, 'T _ConcatArray) union2 list [@js.variadic]) -> 'T list [@@js.call "concat"]
  val join: 'T t -> ?separator:string -> unit -> string [@@js.call "join"]
  val slice: 'T t -> ?start:float -> ?end_:float -> unit -> 'T list [@@js.call "slice"]
  val indexOf: 'T t -> searchElement:'T -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
  val lastIndexOf: 'T t -> searchElement:'T -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
  val every: 'T t -> predicate:(value:'T -> index:float -> array:'T list -> bool) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val every': 'T t -> predicate:(value:'T -> index:float -> array:'T list -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val some: 'T t -> predicate:(value:'T -> index:float -> array:'T list -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
  val forEach: 'T t -> callbackfn:(value:'T -> index:float -> array:'T list -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
  val map: 'T t -> callbackfn:(value:'T -> index:float -> array:'T list -> 'U) -> ?thisArg:any -> unit -> 'U list [@@js.call "map"]
  val filter: 'T t -> predicate:(value:'T -> index:float -> array:'T list -> bool) -> ?thisArg:any -> unit -> 'S list [@@js.call "filter"]
  val filter': 'T t -> predicate:(value:'T -> index:float -> array:'T list -> unknown) -> ?thisArg:any -> unit -> 'T list [@@js.call "filter"]
  val reduce: 'T t -> callbackfn:(previousValue:'T -> currentValue:'T -> currentIndex:float -> array:'T list -> 'T) -> 'T [@@js.call "reduce"]
  val reduce': 'T t -> callbackfn:(previousValue:'T -> currentValue:'T -> currentIndex:float -> array:'T list -> 'T) -> initialValue:'T -> 'T [@@js.call "reduce"]
  val reduce'': 'T t -> callbackfn:(previousValue:'U -> currentValue:'T -> currentIndex:float -> array:'T list -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
  val reduceRight: 'T t -> callbackfn:(previousValue:'T -> currentValue:'T -> currentIndex:float -> array:'T list -> 'T) -> 'T [@@js.call "reduceRight"]
  val reduceRight': 'T t -> callbackfn:(previousValue:'T -> currentValue:'T -> currentIndex:float -> array:'T list -> 'T) -> initialValue:'T -> 'T [@@js.call "reduceRight"]
  val reduceRight'': 'T t -> callbackfn:(previousValue:'U -> currentValue:'T -> currentIndex:float -> array:'T list -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
  val get: 'T t -> float -> 'T [@@js.index_get]
  val to_ml: 'T t -> 'T list [@@js.cast]
  val of_ml: 'T list -> 'T t [@@js.cast]
end
module[@js.scope "ConcatArray"] ConcatArray : sig
  type 'T t = 'T _ConcatArray
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  val get_length: 'T t -> float [@@js.get "length"]
  val get: 'T t -> float -> 'T [@@js.index_get]
  val join: 'T t -> ?separator:string -> unit -> string [@@js.call "join"]
  val slice: 'T t -> ?start:float -> ?end_:float -> unit -> 'T list [@@js.call "slice"]
end
module[@js.scope "Array"] Array : sig
  type 'T t = 'T _Array
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  val get_length: 'T t -> float [@@js.get "length"]
  val set_length: 'T t -> float -> unit [@@js.set "length"]
  val toString: 'T t -> string [@@js.call "toString"]
  val toLocaleString: 'T t -> string [@@js.call "toLocaleString"]
  val pop: 'T t -> 'T or_undefined [@@js.call "pop"]
  val push: 'T t -> items:('T list [@js.variadic]) -> float [@@js.call "push"]
  val concat: 'T t -> items:('T _ConcatArray list [@js.variadic]) -> 'T list [@@js.call "concat"]
  val concat': 'T t -> items:(('T, 'T _ConcatArray) union2 list [@js.variadic]) -> 'T list [@@js.call "concat"]
  val join: 'T t -> ?separator:string -> unit -> string [@@js.call "join"]
  val reverse: 'T t -> 'T list [@@js.call "reverse"]
  val shift: 'T t -> 'T or_undefined [@@js.call "shift"]
  val slice: 'T t -> ?start:float -> ?end_:float -> unit -> 'T list [@@js.call "slice"]
  val sort: 'T t -> ?compareFn:(a:'T -> b:'T -> float) -> unit -> 'T t [@@js.call "sort"]
  val splice: 'T t -> start:float -> ?deleteCount:float -> unit -> 'T list [@@js.call "splice"]
  val splice': 'T t -> start:float -> deleteCount:float -> items:('T list [@js.variadic]) -> 'T list [@@js.call "splice"]
  val unshift: 'T t -> items:('T list [@js.variadic]) -> float [@@js.call "unshift"]
  val indexOf: 'T t -> searchElement:'T -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
  val lastIndexOf: 'T t -> searchElement:'T -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
  val every: 'T t -> predicate:(value:'T -> index:float -> array:'T list -> bool) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val every': 'T t -> predicate:(value:'T -> index:float -> array:'T list -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val some: 'T t -> predicate:(value:'T -> index:float -> array:'T list -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
  val forEach: 'T t -> callbackfn:(value:'T -> index:float -> array:'T list -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
  val map: 'T t -> callbackfn:(value:'T -> index:float -> array:'T list -> 'U) -> ?thisArg:any -> unit -> 'U list [@@js.call "map"]
  val filter: 'T t -> predicate:(value:'T -> index:float -> array:'T list -> bool) -> ?thisArg:any -> unit -> 'S list [@@js.call "filter"]
  val filter': 'T t -> predicate:(value:'T -> index:float -> array:'T list -> unknown) -> ?thisArg:any -> unit -> 'T list [@@js.call "filter"]
  val reduce: 'T t -> callbackfn:(previousValue:'T -> currentValue:'T -> currentIndex:float -> array:'T list -> 'T) -> 'T [@@js.call "reduce"]
  val reduce': 'T t -> callbackfn:(previousValue:'T -> currentValue:'T -> currentIndex:float -> array:'T list -> 'T) -> initialValue:'T -> 'T [@@js.call "reduce"]
  val reduce'': 'T t -> callbackfn:(previousValue:'U -> currentValue:'T -> currentIndex:float -> array:'T list -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
  val reduceRight: 'T t -> callbackfn:(previousValue:'T -> currentValue:'T -> currentIndex:float -> array:'T list -> 'T) -> 'T [@@js.call "reduceRight"]
  val reduceRight': 'T t -> callbackfn:(previousValue:'T -> currentValue:'T -> currentIndex:float -> array:'T list -> 'T) -> initialValue:'T -> 'T [@@js.call "reduceRight"]
  val reduceRight'': 'T t -> callbackfn:(previousValue:'U -> currentValue:'T -> currentIndex:float -> array:'T list -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
  val get: 'T t -> float -> 'T [@@js.index_get]
  val set: 'T t -> float -> 'T -> unit [@@js.index_set]
  val to_ml: 'T t -> 'T list [@@js.cast]
  val of_ml: 'T list -> 'T t [@@js.cast]
end
module[@js.scope "ArrayConstructor"] ArrayConstructor : sig
  type t = _ArrayConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?arrayLength:float -> unit -> any list [@@js.apply_newable]
  val create': t -> arrayLength:float -> 'T list [@@js.apply_newable]
  val create'': t -> items:('T list [@js.variadic]) -> 'T list [@@js.apply_newable]
  val apply: t -> ?arrayLength:float -> unit -> any list [@@js.apply]
  val apply': t -> arrayLength:float -> 'T list [@@js.apply]
  val apply'': t -> items:('T list [@js.variadic]) -> 'T list [@@js.apply]
  val isArray: t -> arg:any -> bool [@@js.call "isArray"]
  val get_prototype: t -> any list [@@js.get "prototype"]
end
val array: _ArrayConstructor [@@js.global "Array"]
module[@js.scope "TypedPropertyDescriptor"] TypedPropertyDescriptor : sig
  type 'T t = 'T _TypedPropertyDescriptor
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  val get_enumerable: 'T t -> bool [@@js.get "enumerable"]
  val set_enumerable: 'T t -> bool -> unit [@@js.set "enumerable"]
  val get_configurable: 'T t -> bool [@@js.get "configurable"]
  val set_configurable: 'T t -> bool -> unit [@@js.set "configurable"]
  val get_writable: 'T t -> bool [@@js.get "writable"]
  val set_writable: 'T t -> bool -> unit [@@js.set "writable"]
  val get_value: 'T t -> 'T [@@js.get "value"]
  val set_value: 'T t -> 'T -> unit [@@js.set "value"]
  val get_: 'T t -> 'T [@@js.call "get"]
  val set_: 'T t -> value:'T -> unit [@@js.call "set"]
end
module[@js.scope "ClassDecorator"] ClassDecorator : sig
  type t = _ClassDecorator
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val apply: t -> target:'TFunction -> ('TFunction, unit) union2 [@@js.apply]
end
module[@js.scope "PropertyDecorator"] PropertyDecorator : sig
  type t = _PropertyDecorator
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val apply: t -> target:_Object -> propertyKey:symbol or_string -> unit [@@js.apply]
end
module[@js.scope "MethodDecorator"] MethodDecorator : sig
  type t = _MethodDecorator
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val apply: t -> target:_Object -> propertyKey:symbol or_string -> descriptor:'T _TypedPropertyDescriptor -> (unit, 'T _TypedPropertyDescriptor) union2 [@@js.apply]
end
module[@js.scope "ParameterDecorator"] ParameterDecorator : sig
  type t = _ParameterDecorator
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val apply: t -> target:_Object -> propertyKey:symbol or_string -> parameterIndex:float -> unit [@@js.apply]
end
module PromiseConstructorLike : sig
  type t = _PromiseConstructorLike
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
end
module[@js.scope "PromiseLike"] PromiseLike : sig
  type 'T t = 'T _PromiseLike
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  val then_: 'T t -> ?onfulfilled:(value:'T -> ('TResult1, 'TResult1 t) union2) or_null_or_undefined -> ?onrejected:(reason:any -> ('TResult2, 'TResult2 t) union2) or_null_or_undefined -> unit -> ('TResult1, 'TResult2) union2 t [@@js.call "then"]
end
module[@js.scope "Promise"] Promise : sig
  type 'T t = 'T _Promise
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  val then_: 'T t -> ?onfulfilled:(value:'T -> ('TResult1, 'TResult1 _PromiseLike) union2) or_null_or_undefined -> ?onrejected:(reason:any -> ('TResult2, 'TResult2 _PromiseLike) union2) or_null_or_undefined -> unit -> ('TResult1, 'TResult2) union2 t [@@js.call "then"]
  val catch: 'T t -> ?onrejected:(reason:any -> ('TResult, 'TResult _PromiseLike) union2) or_null_or_undefined -> unit -> ('T, 'TResult) union2 t [@@js.call "catch"]
end
module[@js.scope "ArrayLike"] ArrayLike : sig
  type 'T t = 'T _ArrayLike
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  val get_length: 'T t -> float [@@js.get "length"]
  val get: 'T t -> float -> 'T [@@js.index_get]
end
module Partial : sig
  type 'T t = 'T _Partial
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
end
module Required : sig
  type 'T t = 'T _Required
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
end
module Readonly : sig
  type 'T t = 'T _Readonly
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
end
module Pick : sig
  type ('T, 'K) t = ('T, 'K) _Pick
  val t_to_js: ('T -> Ojs.t) -> ('K -> Ojs.t) -> ('T, 'K) t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'K) -> Ojs.t -> ('T, 'K) t
  type ('T, 'K) t_2 = ('T, 'K) t
  val t_2_to_js: ('T -> Ojs.t) -> ('K -> Ojs.t) -> ('T, 'K) t_2 -> Ojs.t
  val t_2_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'K) -> Ojs.t -> ('T, 'K) t_2
end
module Record : sig
  type ('K, 'T) t = ('K, 'T) _Record
  val t_to_js: ('K -> Ojs.t) -> ('T -> Ojs.t) -> ('K, 'T) t -> Ojs.t
  val t_of_js: (Ojs.t -> 'K) -> (Ojs.t -> 'T) -> Ojs.t -> ('K, 'T) t
  type ('K, 'T) t_2 = ('K, 'T) t
  val t_2_to_js: ('K -> Ojs.t) -> ('T -> Ojs.t) -> ('K, 'T) t_2 -> Ojs.t
  val t_2_of_js: (Ojs.t -> 'K) -> (Ojs.t -> 'T) -> Ojs.t -> ('K, 'T) t_2
end
module Exclude : sig
  type ('T, 'U) t = ('T, 'U) _Exclude
  val t_to_js: ('T -> Ojs.t) -> ('U -> Ojs.t) -> ('T, 'U) t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'U) -> Ojs.t -> ('T, 'U) t
  type ('T, 'U) t_2 = ('T, 'U) t
  val t_2_to_js: ('T -> Ojs.t) -> ('U -> Ojs.t) -> ('T, 'U) t_2 -> Ojs.t
  val t_2_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'U) -> Ojs.t -> ('T, 'U) t_2
end
module Extract : sig
  type ('T, 'U) t = ('T, 'U) _Extract
  val t_to_js: ('T -> Ojs.t) -> ('U -> Ojs.t) -> ('T, 'U) t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'U) -> Ojs.t -> ('T, 'U) t
  type ('T, 'U) t_2 = ('T, 'U) t
  val t_2_to_js: ('T -> Ojs.t) -> ('U -> Ojs.t) -> ('T, 'U) t_2 -> Ojs.t
  val t_2_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'U) -> Ojs.t -> ('T, 'U) t_2
end
module Omit : sig
  type ('T, 'K) t = ('T, 'K) _Omit
  val t_to_js: ('T -> Ojs.t) -> ('K -> Ojs.t) -> ('T, 'K) t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'K) -> Ojs.t -> ('T, 'K) t
  type ('T, 'K) t_2 = ('T, 'K) t
  val t_2_to_js: ('T -> Ojs.t) -> ('K -> Ojs.t) -> ('T, 'K) t_2 -> Ojs.t
  val t_2_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'K) -> Ojs.t -> ('T, 'K) t_2
end
module NonNullable : sig
  type 'T t = 'T _NonNullable
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
end
module Parameters : sig
  type 'T t = 'T _Parameters
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
end
module ConstructorParameters : sig
  type 'T t = 'T _ConstructorParameters
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
end
module ReturnType : sig
  type 'T t = 'T _ReturnType
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
end
module InstanceType : sig
  type 'T t = 'T _InstanceType
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
end
module Uppercase : sig
  type 'S t = 'S _Uppercase
  val t_to_js: ('S -> Ojs.t) -> 'S t -> Ojs.t
  val t_of_js: (Ojs.t -> 'S) -> Ojs.t -> 'S t
  type 'S t_1 = 'S t
  val t_1_to_js: ('S -> Ojs.t) -> 'S t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'S) -> Ojs.t -> 'S t_1
end
module Lowercase : sig
  type 'S t = 'S _Lowercase
  val t_to_js: ('S -> Ojs.t) -> 'S t -> Ojs.t
  val t_of_js: (Ojs.t -> 'S) -> Ojs.t -> 'S t
  type 'S t_1 = 'S t
  val t_1_to_js: ('S -> Ojs.t) -> 'S t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'S) -> Ojs.t -> 'S t_1
end
module Capitalize : sig
  type 'S t = 'S _Capitalize
  val t_to_js: ('S -> Ojs.t) -> 'S t -> Ojs.t
  val t_of_js: (Ojs.t -> 'S) -> Ojs.t -> 'S t
  type 'S t_1 = 'S t
  val t_1_to_js: ('S -> Ojs.t) -> 'S t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'S) -> Ojs.t -> 'S t_1
end
module Uncapitalize : sig
  type 'S t = 'S _Uncapitalize
  val t_to_js: ('S -> Ojs.t) -> 'S t -> Ojs.t
  val t_of_js: (Ojs.t -> 'S) -> Ojs.t -> 'S t
  type 'S t_1 = 'S t
  val t_1_to_js: ('S -> Ojs.t) -> 'S t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'S) -> Ojs.t -> 'S t_1
end
module ThisType : sig
  type 'T t = 'T _ThisType
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
end
module[@js.scope "ArrayBuffer"] ArrayBuffer : sig
  type t = _ArrayBuffer
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_byteLength: t -> float [@@js.get "byteLength"]
  val slice: t -> begin_:float -> ?end_:float -> unit -> t [@@js.call "slice"]
end
module[@js.scope "ArrayBufferTypes"] ArrayBufferTypes : sig
  type t = _ArrayBufferTypes
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_ArrayBuffer: t -> _ArrayBuffer [@@js.get "ArrayBuffer"]
  val set_ArrayBuffer: t -> _ArrayBuffer -> unit [@@js.set "ArrayBuffer"]
end
module ArrayBufferLike : sig
  type t = _ArrayBufferLike
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
end
module[@js.scope "ArrayBufferConstructor"] ArrayBufferConstructor : sig
  type t = _ArrayBufferConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_prototype: t -> _ArrayBuffer [@@js.get "prototype"]
  val create: t -> byteLength:float -> _ArrayBuffer [@@js.apply_newable]
  val isView: t -> arg:any -> bool [@@js.call "isView"]
end
val arrayBuffer: _ArrayBufferConstructor [@@js.global "ArrayBuffer"]
module[@js.scope "ArrayBufferView"] ArrayBufferView : sig
  type t = _ArrayBufferView
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_buffer: t -> _ArrayBufferLike [@@js.get "buffer"]
  val set_buffer: t -> _ArrayBufferLike -> unit [@@js.set "buffer"]
  val get_byteLength: t -> float [@@js.get "byteLength"]
  val set_byteLength: t -> float -> unit [@@js.set "byteLength"]
  val get_byteOffset: t -> float [@@js.get "byteOffset"]
  val set_byteOffset: t -> float -> unit [@@js.set "byteOffset"]
end
module[@js.scope "DataView"] DataView : sig
  type t = _DataView
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_buffer: t -> _ArrayBuffer [@@js.get "buffer"]
  val get_byteLength: t -> float [@@js.get "byteLength"]
  val get_byteOffset: t -> float [@@js.get "byteOffset"]
  val getFloat32: t -> byteOffset:float -> ?littleEndian:bool -> unit -> float [@@js.call "getFloat32"]
  val getFloat64: t -> byteOffset:float -> ?littleEndian:bool -> unit -> float [@@js.call "getFloat64"]
  val getInt8: t -> byteOffset:float -> float [@@js.call "getInt8"]
  val getInt16: t -> byteOffset:float -> ?littleEndian:bool -> unit -> float [@@js.call "getInt16"]
  val getInt32: t -> byteOffset:float -> ?littleEndian:bool -> unit -> float [@@js.call "getInt32"]
  val getUint8: t -> byteOffset:float -> float [@@js.call "getUint8"]
  val getUint16: t -> byteOffset:float -> ?littleEndian:bool -> unit -> float [@@js.call "getUint16"]
  val getUint32: t -> byteOffset:float -> ?littleEndian:bool -> unit -> float [@@js.call "getUint32"]
  val setFloat32: t -> byteOffset:float -> value:float -> ?littleEndian:bool -> unit -> unit [@@js.call "setFloat32"]
  val setFloat64: t -> byteOffset:float -> value:float -> ?littleEndian:bool -> unit -> unit [@@js.call "setFloat64"]
  val setInt8: t -> byteOffset:float -> value:float -> unit [@@js.call "setInt8"]
  val setInt16: t -> byteOffset:float -> value:float -> ?littleEndian:bool -> unit -> unit [@@js.call "setInt16"]
  val setInt32: t -> byteOffset:float -> value:float -> ?littleEndian:bool -> unit -> unit [@@js.call "setInt32"]
  val setUint8: t -> byteOffset:float -> value:float -> unit [@@js.call "setUint8"]
  val setUint16: t -> byteOffset:float -> value:float -> ?littleEndian:bool -> unit -> unit [@@js.call "setUint16"]
  val setUint32: t -> byteOffset:float -> value:float -> ?littleEndian:bool -> unit -> unit [@@js.call "setUint32"]
end
module[@js.scope "DataViewConstructor"] DataViewConstructor : sig
  type t = _DataViewConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_prototype: t -> _DataView [@@js.get "prototype"]
  val create: t -> buffer:_ArrayBufferLike -> ?byteOffset:float -> ?byteLength:float -> unit -> _DataView [@@js.apply_newable]
end
val dataView: _DataViewConstructor [@@js.global "DataView"]
module[@js.scope "Int8Array"] Int8Array : sig
  type t = _Int8Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val get_buffer: t -> _ArrayBufferLike [@@js.get "buffer"]
  val get_byteLength: t -> float [@@js.get "byteLength"]
  val get_byteOffset: t -> float [@@js.get "byteOffset"]
  val copyWithin: t -> target:float -> start:float -> ?end_:float -> unit -> t [@@js.call "copyWithin"]
  val every: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val fill: t -> value:float -> ?start:float -> ?end_:float -> unit -> t [@@js.call "fill"]
  val filter: t -> predicate:(value:float -> index:float -> array:t -> any) -> ?thisArg:any -> unit -> t [@@js.call "filter"]
  val find: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float or_undefined [@@js.call "find"]
  val findIndex: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
  val forEach: t -> callbackfn:(value:float -> index:float -> array:t -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
  val indexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
  val join: t -> ?separator:string -> unit -> string [@@js.call "join"]
  val lastIndexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
  val get_length: t -> float [@@js.get "length"]
  val map: t -> callbackfn:(value:float -> index:float -> array:t -> float) -> ?thisArg:any -> unit -> t [@@js.call "map"]
  val reduce: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduce"]
  val reduce': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduce"]
  val reduce'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
  val reduceRight: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduceRight"]
  val reduceRight': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduceRight"]
  val reduceRight'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
  val reverse: t -> t [@@js.call "reverse"]
  val set_: t -> array:float _ArrayLike -> ?offset:float -> unit -> unit [@@js.call "set"]
  val slice: t -> ?start:float -> ?end_:float -> unit -> t [@@js.call "slice"]
  val some: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
  val sort: t -> ?compareFn:(a:float -> b:float -> float) -> unit -> t [@@js.call "sort"]
  val subarray: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "subarray"]
  val toLocaleString: t -> string [@@js.call "toLocaleString"]
  val toString: t -> string [@@js.call "toString"]
  val valueOf: t -> t [@@js.call "valueOf"]
  val get: t -> float -> float [@@js.index_get]
  val set: t -> float -> float -> unit [@@js.index_set]
end
module[@js.scope "Int8ArrayConstructor"] Int8ArrayConstructor : sig
  type t = _Int8ArrayConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_prototype: t -> _Int8Array [@@js.get "prototype"]
  val create: t -> length:float -> _Int8Array [@@js.apply_newable]
  val create': t -> array:(_ArrayBufferLike, float _ArrayLike) union2 -> _Int8Array [@@js.apply_newable]
  val create'': t -> buffer:_ArrayBufferLike -> ?byteOffset:float -> ?length:float -> unit -> _Int8Array [@@js.apply_newable]
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val of_: t -> items:(float list [@js.variadic]) -> _Int8Array [@@js.call "of"]
  val from: t -> arrayLike:float _ArrayLike -> _Int8Array [@@js.call "from"]
  val from': t -> arrayLike:'T _ArrayLike -> mapfn:(v:'T -> k:float -> float) -> ?thisArg:any -> unit -> _Int8Array [@@js.call "from"]
end
val int8Array: _Int8ArrayConstructor [@@js.global "Int8Array"]
module[@js.scope "Uint8Array"] Uint8Array : sig
  type t = _Uint8Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val get_buffer: t -> _ArrayBufferLike [@@js.get "buffer"]
  val get_byteLength: t -> float [@@js.get "byteLength"]
  val get_byteOffset: t -> float [@@js.get "byteOffset"]
  val copyWithin: t -> target:float -> start:float -> ?end_:float -> unit -> t [@@js.call "copyWithin"]
  val every: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val fill: t -> value:float -> ?start:float -> ?end_:float -> unit -> t [@@js.call "fill"]
  val filter: t -> predicate:(value:float -> index:float -> array:t -> any) -> ?thisArg:any -> unit -> t [@@js.call "filter"]
  val find: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float or_undefined [@@js.call "find"]
  val findIndex: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
  val forEach: t -> callbackfn:(value:float -> index:float -> array:t -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
  val indexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
  val join: t -> ?separator:string -> unit -> string [@@js.call "join"]
  val lastIndexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
  val get_length: t -> float [@@js.get "length"]
  val map: t -> callbackfn:(value:float -> index:float -> array:t -> float) -> ?thisArg:any -> unit -> t [@@js.call "map"]
  val reduce: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduce"]
  val reduce': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduce"]
  val reduce'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
  val reduceRight: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduceRight"]
  val reduceRight': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduceRight"]
  val reduceRight'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
  val reverse: t -> t [@@js.call "reverse"]
  val set_: t -> array:float _ArrayLike -> ?offset:float -> unit -> unit [@@js.call "set"]
  val slice: t -> ?start:float -> ?end_:float -> unit -> t [@@js.call "slice"]
  val some: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
  val sort: t -> ?compareFn:(a:float -> b:float -> float) -> unit -> t [@@js.call "sort"]
  val subarray: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "subarray"]
  val toLocaleString: t -> string [@@js.call "toLocaleString"]
  val toString: t -> string [@@js.call "toString"]
  val valueOf: t -> t [@@js.call "valueOf"]
  val get: t -> float -> float [@@js.index_get]
  val set: t -> float -> float -> unit [@@js.index_set]
end
module[@js.scope "Uint8ArrayConstructor"] Uint8ArrayConstructor : sig
  type t = _Uint8ArrayConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_prototype: t -> _Uint8Array [@@js.get "prototype"]
  val create: t -> length:float -> _Uint8Array [@@js.apply_newable]
  val create': t -> array:(_ArrayBufferLike, float _ArrayLike) union2 -> _Uint8Array [@@js.apply_newable]
  val create'': t -> buffer:_ArrayBufferLike -> ?byteOffset:float -> ?length:float -> unit -> _Uint8Array [@@js.apply_newable]
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val of_: t -> items:(float list [@js.variadic]) -> _Uint8Array [@@js.call "of"]
  val from: t -> arrayLike:float _ArrayLike -> _Uint8Array [@@js.call "from"]
  val from': t -> arrayLike:'T _ArrayLike -> mapfn:(v:'T -> k:float -> float) -> ?thisArg:any -> unit -> _Uint8Array [@@js.call "from"]
end
val uint8Array: _Uint8ArrayConstructor [@@js.global "Uint8Array"]
module[@js.scope "Uint8ClampedArray"] Uint8ClampedArray : sig
  type t = _Uint8ClampedArray
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val get_buffer: t -> _ArrayBufferLike [@@js.get "buffer"]
  val get_byteLength: t -> float [@@js.get "byteLength"]
  val get_byteOffset: t -> float [@@js.get "byteOffset"]
  val copyWithin: t -> target:float -> start:float -> ?end_:float -> unit -> t [@@js.call "copyWithin"]
  val every: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val fill: t -> value:float -> ?start:float -> ?end_:float -> unit -> t [@@js.call "fill"]
  val filter: t -> predicate:(value:float -> index:float -> array:t -> any) -> ?thisArg:any -> unit -> t [@@js.call "filter"]
  val find: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float or_undefined [@@js.call "find"]
  val findIndex: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
  val forEach: t -> callbackfn:(value:float -> index:float -> array:t -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
  val indexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
  val join: t -> ?separator:string -> unit -> string [@@js.call "join"]
  val lastIndexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
  val get_length: t -> float [@@js.get "length"]
  val map: t -> callbackfn:(value:float -> index:float -> array:t -> float) -> ?thisArg:any -> unit -> t [@@js.call "map"]
  val reduce: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduce"]
  val reduce': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduce"]
  val reduce'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
  val reduceRight: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduceRight"]
  val reduceRight': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduceRight"]
  val reduceRight'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
  val reverse: t -> t [@@js.call "reverse"]
  val set_: t -> array:float _ArrayLike -> ?offset:float -> unit -> unit [@@js.call "set"]
  val slice: t -> ?start:float -> ?end_:float -> unit -> t [@@js.call "slice"]
  val some: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
  val sort: t -> ?compareFn:(a:float -> b:float -> float) -> unit -> t [@@js.call "sort"]
  val subarray: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "subarray"]
  val toLocaleString: t -> string [@@js.call "toLocaleString"]
  val toString: t -> string [@@js.call "toString"]
  val valueOf: t -> t [@@js.call "valueOf"]
  val get: t -> float -> float [@@js.index_get]
  val set: t -> float -> float -> unit [@@js.index_set]
end
module[@js.scope "Uint8ClampedArrayConstructor"] Uint8ClampedArrayConstructor : sig
  type t = _Uint8ClampedArrayConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_prototype: t -> _Uint8ClampedArray [@@js.get "prototype"]
  val create: t -> length:float -> _Uint8ClampedArray [@@js.apply_newable]
  val create': t -> array:(_ArrayBufferLike, float _ArrayLike) union2 -> _Uint8ClampedArray [@@js.apply_newable]
  val create'': t -> buffer:_ArrayBufferLike -> ?byteOffset:float -> ?length:float -> unit -> _Uint8ClampedArray [@@js.apply_newable]
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val of_: t -> items:(float list [@js.variadic]) -> _Uint8ClampedArray [@@js.call "of"]
  val from: t -> arrayLike:float _ArrayLike -> _Uint8ClampedArray [@@js.call "from"]
  val from': t -> arrayLike:'T _ArrayLike -> mapfn:(v:'T -> k:float -> float) -> ?thisArg:any -> unit -> _Uint8ClampedArray [@@js.call "from"]
end
val uint8ClampedArray: _Uint8ClampedArrayConstructor [@@js.global "Uint8ClampedArray"]
module[@js.scope "Int16Array"] Int16Array : sig
  type t = _Int16Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val get_buffer: t -> _ArrayBufferLike [@@js.get "buffer"]
  val get_byteLength: t -> float [@@js.get "byteLength"]
  val get_byteOffset: t -> float [@@js.get "byteOffset"]
  val copyWithin: t -> target:float -> start:float -> ?end_:float -> unit -> t [@@js.call "copyWithin"]
  val every: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val fill: t -> value:float -> ?start:float -> ?end_:float -> unit -> t [@@js.call "fill"]
  val filter: t -> predicate:(value:float -> index:float -> array:t -> any) -> ?thisArg:any -> unit -> t [@@js.call "filter"]
  val find: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float or_undefined [@@js.call "find"]
  val findIndex: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
  val forEach: t -> callbackfn:(value:float -> index:float -> array:t -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
  val indexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
  val join: t -> ?separator:string -> unit -> string [@@js.call "join"]
  val lastIndexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
  val get_length: t -> float [@@js.get "length"]
  val map: t -> callbackfn:(value:float -> index:float -> array:t -> float) -> ?thisArg:any -> unit -> t [@@js.call "map"]
  val reduce: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduce"]
  val reduce': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduce"]
  val reduce'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
  val reduceRight: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduceRight"]
  val reduceRight': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduceRight"]
  val reduceRight'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
  val reverse: t -> t [@@js.call "reverse"]
  val set_: t -> array:float _ArrayLike -> ?offset:float -> unit -> unit [@@js.call "set"]
  val slice: t -> ?start:float -> ?end_:float -> unit -> t [@@js.call "slice"]
  val some: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
  val sort: t -> ?compareFn:(a:float -> b:float -> float) -> unit -> t [@@js.call "sort"]
  val subarray: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "subarray"]
  val toLocaleString: t -> string [@@js.call "toLocaleString"]
  val toString: t -> string [@@js.call "toString"]
  val valueOf: t -> t [@@js.call "valueOf"]
  val get: t -> float -> float [@@js.index_get]
  val set: t -> float -> float -> unit [@@js.index_set]
end
module[@js.scope "Int16ArrayConstructor"] Int16ArrayConstructor : sig
  type t = _Int16ArrayConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_prototype: t -> _Int16Array [@@js.get "prototype"]
  val create: t -> length:float -> _Int16Array [@@js.apply_newable]
  val create': t -> array:(_ArrayBufferLike, float _ArrayLike) union2 -> _Int16Array [@@js.apply_newable]
  val create'': t -> buffer:_ArrayBufferLike -> ?byteOffset:float -> ?length:float -> unit -> _Int16Array [@@js.apply_newable]
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val of_: t -> items:(float list [@js.variadic]) -> _Int16Array [@@js.call "of"]
  val from: t -> arrayLike:float _ArrayLike -> _Int16Array [@@js.call "from"]
  val from': t -> arrayLike:'T _ArrayLike -> mapfn:(v:'T -> k:float -> float) -> ?thisArg:any -> unit -> _Int16Array [@@js.call "from"]
end
val int16Array: _Int16ArrayConstructor [@@js.global "Int16Array"]
module[@js.scope "Uint16Array"] Uint16Array : sig
  type t = _Uint16Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val get_buffer: t -> _ArrayBufferLike [@@js.get "buffer"]
  val get_byteLength: t -> float [@@js.get "byteLength"]
  val get_byteOffset: t -> float [@@js.get "byteOffset"]
  val copyWithin: t -> target:float -> start:float -> ?end_:float -> unit -> t [@@js.call "copyWithin"]
  val every: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val fill: t -> value:float -> ?start:float -> ?end_:float -> unit -> t [@@js.call "fill"]
  val filter: t -> predicate:(value:float -> index:float -> array:t -> any) -> ?thisArg:any -> unit -> t [@@js.call "filter"]
  val find: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float or_undefined [@@js.call "find"]
  val findIndex: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
  val forEach: t -> callbackfn:(value:float -> index:float -> array:t -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
  val indexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
  val join: t -> ?separator:string -> unit -> string [@@js.call "join"]
  val lastIndexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
  val get_length: t -> float [@@js.get "length"]
  val map: t -> callbackfn:(value:float -> index:float -> array:t -> float) -> ?thisArg:any -> unit -> t [@@js.call "map"]
  val reduce: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduce"]
  val reduce': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduce"]
  val reduce'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
  val reduceRight: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduceRight"]
  val reduceRight': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduceRight"]
  val reduceRight'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
  val reverse: t -> t [@@js.call "reverse"]
  val set_: t -> array:float _ArrayLike -> ?offset:float -> unit -> unit [@@js.call "set"]
  val slice: t -> ?start:float -> ?end_:float -> unit -> t [@@js.call "slice"]
  val some: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
  val sort: t -> ?compareFn:(a:float -> b:float -> float) -> unit -> t [@@js.call "sort"]
  val subarray: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "subarray"]
  val toLocaleString: t -> string [@@js.call "toLocaleString"]
  val toString: t -> string [@@js.call "toString"]
  val valueOf: t -> t [@@js.call "valueOf"]
  val get: t -> float -> float [@@js.index_get]
  val set: t -> float -> float -> unit [@@js.index_set]
end
module[@js.scope "Uint16ArrayConstructor"] Uint16ArrayConstructor : sig
  type t = _Uint16ArrayConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_prototype: t -> _Uint16Array [@@js.get "prototype"]
  val create: t -> length:float -> _Uint16Array [@@js.apply_newable]
  val create': t -> array:(_ArrayBufferLike, float _ArrayLike) union2 -> _Uint16Array [@@js.apply_newable]
  val create'': t -> buffer:_ArrayBufferLike -> ?byteOffset:float -> ?length:float -> unit -> _Uint16Array [@@js.apply_newable]
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val of_: t -> items:(float list [@js.variadic]) -> _Uint16Array [@@js.call "of"]
  val from: t -> arrayLike:float _ArrayLike -> _Uint16Array [@@js.call "from"]
  val from': t -> arrayLike:'T _ArrayLike -> mapfn:(v:'T -> k:float -> float) -> ?thisArg:any -> unit -> _Uint16Array [@@js.call "from"]
end
val uint16Array: _Uint16ArrayConstructor [@@js.global "Uint16Array"]
module[@js.scope "Int32Array"] Int32Array : sig
  type t = _Int32Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val get_buffer: t -> _ArrayBufferLike [@@js.get "buffer"]
  val get_byteLength: t -> float [@@js.get "byteLength"]
  val get_byteOffset: t -> float [@@js.get "byteOffset"]
  val copyWithin: t -> target:float -> start:float -> ?end_:float -> unit -> t [@@js.call "copyWithin"]
  val every: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val fill: t -> value:float -> ?start:float -> ?end_:float -> unit -> t [@@js.call "fill"]
  val filter: t -> predicate:(value:float -> index:float -> array:t -> any) -> ?thisArg:any -> unit -> t [@@js.call "filter"]
  val find: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float or_undefined [@@js.call "find"]
  val findIndex: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
  val forEach: t -> callbackfn:(value:float -> index:float -> array:t -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
  val indexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
  val join: t -> ?separator:string -> unit -> string [@@js.call "join"]
  val lastIndexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
  val get_length: t -> float [@@js.get "length"]
  val map: t -> callbackfn:(value:float -> index:float -> array:t -> float) -> ?thisArg:any -> unit -> t [@@js.call "map"]
  val reduce: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduce"]
  val reduce': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduce"]
  val reduce'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
  val reduceRight: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduceRight"]
  val reduceRight': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduceRight"]
  val reduceRight'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
  val reverse: t -> t [@@js.call "reverse"]
  val set_: t -> array:float _ArrayLike -> ?offset:float -> unit -> unit [@@js.call "set"]
  val slice: t -> ?start:float -> ?end_:float -> unit -> t [@@js.call "slice"]
  val some: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
  val sort: t -> ?compareFn:(a:float -> b:float -> float) -> unit -> t [@@js.call "sort"]
  val subarray: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "subarray"]
  val toLocaleString: t -> string [@@js.call "toLocaleString"]
  val toString: t -> string [@@js.call "toString"]
  val valueOf: t -> t [@@js.call "valueOf"]
  val get: t -> float -> float [@@js.index_get]
  val set: t -> float -> float -> unit [@@js.index_set]
end
module[@js.scope "Int32ArrayConstructor"] Int32ArrayConstructor : sig
  type t = _Int32ArrayConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_prototype: t -> _Int32Array [@@js.get "prototype"]
  val create: t -> length:float -> _Int32Array [@@js.apply_newable]
  val create': t -> array:(_ArrayBufferLike, float _ArrayLike) union2 -> _Int32Array [@@js.apply_newable]
  val create'': t -> buffer:_ArrayBufferLike -> ?byteOffset:float -> ?length:float -> unit -> _Int32Array [@@js.apply_newable]
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val of_: t -> items:(float list [@js.variadic]) -> _Int32Array [@@js.call "of"]
  val from: t -> arrayLike:float _ArrayLike -> _Int32Array [@@js.call "from"]
  val from': t -> arrayLike:'T _ArrayLike -> mapfn:(v:'T -> k:float -> float) -> ?thisArg:any -> unit -> _Int32Array [@@js.call "from"]
end
val int32Array: _Int32ArrayConstructor [@@js.global "Int32Array"]
module[@js.scope "Uint32Array"] Uint32Array : sig
  type t = _Uint32Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val get_buffer: t -> _ArrayBufferLike [@@js.get "buffer"]
  val get_byteLength: t -> float [@@js.get "byteLength"]
  val get_byteOffset: t -> float [@@js.get "byteOffset"]
  val copyWithin: t -> target:float -> start:float -> ?end_:float -> unit -> t [@@js.call "copyWithin"]
  val every: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val fill: t -> value:float -> ?start:float -> ?end_:float -> unit -> t [@@js.call "fill"]
  val filter: t -> predicate:(value:float -> index:float -> array:t -> any) -> ?thisArg:any -> unit -> t [@@js.call "filter"]
  val find: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float or_undefined [@@js.call "find"]
  val findIndex: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
  val forEach: t -> callbackfn:(value:float -> index:float -> array:t -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
  val indexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
  val join: t -> ?separator:string -> unit -> string [@@js.call "join"]
  val lastIndexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
  val get_length: t -> float [@@js.get "length"]
  val map: t -> callbackfn:(value:float -> index:float -> array:t -> float) -> ?thisArg:any -> unit -> t [@@js.call "map"]
  val reduce: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduce"]
  val reduce': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduce"]
  val reduce'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
  val reduceRight: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduceRight"]
  val reduceRight': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduceRight"]
  val reduceRight'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
  val reverse: t -> t [@@js.call "reverse"]
  val set_: t -> array:float _ArrayLike -> ?offset:float -> unit -> unit [@@js.call "set"]
  val slice: t -> ?start:float -> ?end_:float -> unit -> t [@@js.call "slice"]
  val some: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
  val sort: t -> ?compareFn:(a:float -> b:float -> float) -> unit -> t [@@js.call "sort"]
  val subarray: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "subarray"]
  val toLocaleString: t -> string [@@js.call "toLocaleString"]
  val toString: t -> string [@@js.call "toString"]
  val valueOf: t -> t [@@js.call "valueOf"]
  val get: t -> float -> float [@@js.index_get]
  val set: t -> float -> float -> unit [@@js.index_set]
end
module[@js.scope "Uint32ArrayConstructor"] Uint32ArrayConstructor : sig
  type t = _Uint32ArrayConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_prototype: t -> _Uint32Array [@@js.get "prototype"]
  val create: t -> length:float -> _Uint32Array [@@js.apply_newable]
  val create': t -> array:(_ArrayBufferLike, float _ArrayLike) union2 -> _Uint32Array [@@js.apply_newable]
  val create'': t -> buffer:_ArrayBufferLike -> ?byteOffset:float -> ?length:float -> unit -> _Uint32Array [@@js.apply_newable]
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val of_: t -> items:(float list [@js.variadic]) -> _Uint32Array [@@js.call "of"]
  val from: t -> arrayLike:float _ArrayLike -> _Uint32Array [@@js.call "from"]
  val from': t -> arrayLike:'T _ArrayLike -> mapfn:(v:'T -> k:float -> float) -> ?thisArg:any -> unit -> _Uint32Array [@@js.call "from"]
end
val uint32Array: _Uint32ArrayConstructor [@@js.global "Uint32Array"]
module[@js.scope "Float32Array"] Float32Array : sig
  type t = _Float32Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val get_buffer: t -> _ArrayBufferLike [@@js.get "buffer"]
  val get_byteLength: t -> float [@@js.get "byteLength"]
  val get_byteOffset: t -> float [@@js.get "byteOffset"]
  val copyWithin: t -> target:float -> start:float -> ?end_:float -> unit -> t [@@js.call "copyWithin"]
  val every: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val fill: t -> value:float -> ?start:float -> ?end_:float -> unit -> t [@@js.call "fill"]
  val filter: t -> predicate:(value:float -> index:float -> array:t -> any) -> ?thisArg:any -> unit -> t [@@js.call "filter"]
  val find: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float or_undefined [@@js.call "find"]
  val findIndex: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
  val forEach: t -> callbackfn:(value:float -> index:float -> array:t -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
  val indexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
  val join: t -> ?separator:string -> unit -> string [@@js.call "join"]
  val lastIndexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
  val get_length: t -> float [@@js.get "length"]
  val map: t -> callbackfn:(value:float -> index:float -> array:t -> float) -> ?thisArg:any -> unit -> t [@@js.call "map"]
  val reduce: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduce"]
  val reduce': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduce"]
  val reduce'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
  val reduceRight: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduceRight"]
  val reduceRight': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduceRight"]
  val reduceRight'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
  val reverse: t -> t [@@js.call "reverse"]
  val set_: t -> array:float _ArrayLike -> ?offset:float -> unit -> unit [@@js.call "set"]
  val slice: t -> ?start:float -> ?end_:float -> unit -> t [@@js.call "slice"]
  val some: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
  val sort: t -> ?compareFn:(a:float -> b:float -> float) -> unit -> t [@@js.call "sort"]
  val subarray: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "subarray"]
  val toLocaleString: t -> string [@@js.call "toLocaleString"]
  val toString: t -> string [@@js.call "toString"]
  val valueOf: t -> t [@@js.call "valueOf"]
  val get: t -> float -> float [@@js.index_get]
  val set: t -> float -> float -> unit [@@js.index_set]
end
module[@js.scope "Float32ArrayConstructor"] Float32ArrayConstructor : sig
  type t = _Float32ArrayConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_prototype: t -> _Float32Array [@@js.get "prototype"]
  val create: t -> length:float -> _Float32Array [@@js.apply_newable]
  val create': t -> array:(_ArrayBufferLike, float _ArrayLike) union2 -> _Float32Array [@@js.apply_newable]
  val create'': t -> buffer:_ArrayBufferLike -> ?byteOffset:float -> ?length:float -> unit -> _Float32Array [@@js.apply_newable]
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val of_: t -> items:(float list [@js.variadic]) -> _Float32Array [@@js.call "of"]
  val from: t -> arrayLike:float _ArrayLike -> _Float32Array [@@js.call "from"]
  val from': t -> arrayLike:'T _ArrayLike -> mapfn:(v:'T -> k:float -> float) -> ?thisArg:any -> unit -> _Float32Array [@@js.call "from"]
end
val float32Array: _Float32ArrayConstructor [@@js.global "Float32Array"]
module[@js.scope "Float64Array"] Float64Array : sig
  type t = _Float64Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val get_buffer: t -> _ArrayBufferLike [@@js.get "buffer"]
  val get_byteLength: t -> float [@@js.get "byteLength"]
  val get_byteOffset: t -> float [@@js.get "byteOffset"]
  val copyWithin: t -> target:float -> start:float -> ?end_:float -> unit -> t [@@js.call "copyWithin"]
  val every: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
  val fill: t -> value:float -> ?start:float -> ?end_:float -> unit -> t [@@js.call "fill"]
  val filter: t -> predicate:(value:float -> index:float -> array:t -> any) -> ?thisArg:any -> unit -> t [@@js.call "filter"]
  val find: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float or_undefined [@@js.call "find"]
  val findIndex: t -> predicate:(value:float -> index:float -> obj:t -> bool) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
  val forEach: t -> callbackfn:(value:float -> index:float -> array:t -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
  val indexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
  val join: t -> ?separator:string -> unit -> string [@@js.call "join"]
  val lastIndexOf: t -> searchElement:float -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
  val get_length: t -> float [@@js.get "length"]
  val map: t -> callbackfn:(value:float -> index:float -> array:t -> float) -> ?thisArg:any -> unit -> t [@@js.call "map"]
  val reduce: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduce"]
  val reduce': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduce"]
  val reduce'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
  val reduceRight: t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> float [@@js.call "reduceRight"]
  val reduceRight': t -> callbackfn:(previousValue:float -> currentValue:float -> currentIndex:float -> array:t -> float) -> initialValue:float -> float [@@js.call "reduceRight"]
  val reduceRight'': t -> callbackfn:(previousValue:'U -> currentValue:float -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
  val reverse: t -> t [@@js.call "reverse"]
  val set_: t -> array:float _ArrayLike -> ?offset:float -> unit -> unit [@@js.call "set"]
  val slice: t -> ?start:float -> ?end_:float -> unit -> t [@@js.call "slice"]
  val some: t -> predicate:(value:float -> index:float -> array:t -> unknown) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
  val sort: t -> ?compareFn:(a:float -> b:float -> float) -> unit -> t [@@js.call "sort"]
  val subarray: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "subarray"]
  val toString: t -> string [@@js.call "toString"]
  val valueOf: t -> t [@@js.call "valueOf"]
  val get: t -> float -> float [@@js.index_get]
  val set: t -> float -> float -> unit [@@js.index_set]
end
module[@js.scope "Float64ArrayConstructor"] Float64ArrayConstructor : sig
  type t = _Float64ArrayConstructor
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_prototype: t -> _Float64Array [@@js.get "prototype"]
  val create: t -> length:float -> _Float64Array [@@js.apply_newable]
  val create': t -> array:(_ArrayBufferLike, float _ArrayLike) union2 -> _Float64Array [@@js.apply_newable]
  val create'': t -> buffer:_ArrayBufferLike -> ?byteOffset:float -> ?length:float -> unit -> _Float64Array [@@js.apply_newable]
  val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
  val of_: t -> items:(float list [@js.variadic]) -> _Float64Array [@@js.call "of"]
  val from: t -> arrayLike:float _ArrayLike -> _Float64Array [@@js.call "from"]
  val from': t -> arrayLike:'T _ArrayLike -> mapfn:(v:'T -> k:float -> float) -> ?thisArg:any -> unit -> _Float64Array [@@js.call "from"]
end
val float64Array: _Float64ArrayConstructor [@@js.global "Float64Array"]
module[@js.scope "Intl"] Intl : sig
  module[@js.scope "CollatorOptions"] CollatorOptions : sig
    type t = _Intl_CollatorOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_usage: t -> string [@@js.get "usage"]
    val set_usage: t -> string -> unit [@@js.set "usage"]
    val get_localeMatcher: t -> string [@@js.get "localeMatcher"]
    val set_localeMatcher: t -> string -> unit [@@js.set "localeMatcher"]
    val get_numeric: t -> bool [@@js.get "numeric"]
    val set_numeric: t -> bool -> unit [@@js.set "numeric"]
    val get_caseFirst: t -> string [@@js.get "caseFirst"]
    val set_caseFirst: t -> string -> unit [@@js.set "caseFirst"]
    val get_sensitivity: t -> string [@@js.get "sensitivity"]
    val set_sensitivity: t -> string -> unit [@@js.set "sensitivity"]
    val get_ignorePunctuation: t -> bool [@@js.get "ignorePunctuation"]
    val set_ignorePunctuation: t -> bool -> unit [@@js.set "ignorePunctuation"]
  end
  module[@js.scope "ResolvedCollatorOptions"] ResolvedCollatorOptions : sig
    type t = _Intl_ResolvedCollatorOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_locale: t -> string [@@js.get "locale"]
    val set_locale: t -> string -> unit [@@js.set "locale"]
    val get_usage: t -> string [@@js.get "usage"]
    val set_usage: t -> string -> unit [@@js.set "usage"]
    val get_sensitivity: t -> string [@@js.get "sensitivity"]
    val set_sensitivity: t -> string -> unit [@@js.set "sensitivity"]
    val get_ignorePunctuation: t -> bool [@@js.get "ignorePunctuation"]
    val set_ignorePunctuation: t -> bool -> unit [@@js.set "ignorePunctuation"]
    val get_collation: t -> string [@@js.get "collation"]
    val set_collation: t -> string -> unit [@@js.set "collation"]
    val get_caseFirst: t -> string [@@js.get "caseFirst"]
    val set_caseFirst: t -> string -> unit [@@js.set "caseFirst"]
    val get_numeric: t -> bool [@@js.get "numeric"]
    val set_numeric: t -> bool -> unit [@@js.set "numeric"]
  end
  module[@js.scope "Collator"] Collator : sig
    type t = _Intl_Collator
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val compare: t -> x:string -> y:string -> float [@@js.call "compare"]
    val resolvedOptions: t -> _Intl_ResolvedCollatorOptions [@@js.call "resolvedOptions"]
  end
  val collator: anonymous_interface_2 [@@js.global "Collator"]
  module[@js.scope "NumberFormatOptions"] NumberFormatOptions : sig
    type t = _Intl_NumberFormatOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_localeMatcher: t -> string [@@js.get "localeMatcher"]
    val set_localeMatcher: t -> string -> unit [@@js.set "localeMatcher"]
    val get_style: t -> string [@@js.get "style"]
    val set_style: t -> string -> unit [@@js.set "style"]
    val get_currency: t -> string [@@js.get "currency"]
    val set_currency: t -> string -> unit [@@js.set "currency"]
    val get_currencyDisplay: t -> string [@@js.get "currencyDisplay"]
    val set_currencyDisplay: t -> string -> unit [@@js.set "currencyDisplay"]
    val get_currencySign: t -> string [@@js.get "currencySign"]
    val set_currencySign: t -> string -> unit [@@js.set "currencySign"]
    val get_useGrouping: t -> bool [@@js.get "useGrouping"]
    val set_useGrouping: t -> bool -> unit [@@js.set "useGrouping"]
    val get_minimumIntegerDigits: t -> float [@@js.get "minimumIntegerDigits"]
    val set_minimumIntegerDigits: t -> float -> unit [@@js.set "minimumIntegerDigits"]
    val get_minimumFractionDigits: t -> float [@@js.get "minimumFractionDigits"]
    val set_minimumFractionDigits: t -> float -> unit [@@js.set "minimumFractionDigits"]
    val get_maximumFractionDigits: t -> float [@@js.get "maximumFractionDigits"]
    val set_maximumFractionDigits: t -> float -> unit [@@js.set "maximumFractionDigits"]
    val get_minimumSignificantDigits: t -> float [@@js.get "minimumSignificantDigits"]
    val set_minimumSignificantDigits: t -> float -> unit [@@js.set "minimumSignificantDigits"]
    val get_maximumSignificantDigits: t -> float [@@js.get "maximumSignificantDigits"]
    val set_maximumSignificantDigits: t -> float -> unit [@@js.set "maximumSignificantDigits"]
  end
  module[@js.scope "ResolvedNumberFormatOptions"] ResolvedNumberFormatOptions : sig
    type t = _Intl_ResolvedNumberFormatOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_locale: t -> string [@@js.get "locale"]
    val set_locale: t -> string -> unit [@@js.set "locale"]
    val get_numberingSystem: t -> string [@@js.get "numberingSystem"]
    val set_numberingSystem: t -> string -> unit [@@js.set "numberingSystem"]
    val get_style: t -> string [@@js.get "style"]
    val set_style: t -> string -> unit [@@js.set "style"]
    val get_currency: t -> string [@@js.get "currency"]
    val set_currency: t -> string -> unit [@@js.set "currency"]
    val get_currencyDisplay: t -> string [@@js.get "currencyDisplay"]
    val set_currencyDisplay: t -> string -> unit [@@js.set "currencyDisplay"]
    val get_minimumIntegerDigits: t -> float [@@js.get "minimumIntegerDigits"]
    val set_minimumIntegerDigits: t -> float -> unit [@@js.set "minimumIntegerDigits"]
    val get_minimumFractionDigits: t -> float [@@js.get "minimumFractionDigits"]
    val set_minimumFractionDigits: t -> float -> unit [@@js.set "minimumFractionDigits"]
    val get_maximumFractionDigits: t -> float [@@js.get "maximumFractionDigits"]
    val set_maximumFractionDigits: t -> float -> unit [@@js.set "maximumFractionDigits"]
    val get_minimumSignificantDigits: t -> float [@@js.get "minimumSignificantDigits"]
    val set_minimumSignificantDigits: t -> float -> unit [@@js.set "minimumSignificantDigits"]
    val get_maximumSignificantDigits: t -> float [@@js.get "maximumSignificantDigits"]
    val set_maximumSignificantDigits: t -> float -> unit [@@js.set "maximumSignificantDigits"]
    val get_useGrouping: t -> bool [@@js.get "useGrouping"]
    val set_useGrouping: t -> bool -> unit [@@js.set "useGrouping"]
  end
  module[@js.scope "NumberFormat"] NumberFormat : sig
    type t = _Intl_NumberFormat
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val format: t -> value:float -> string [@@js.call "format"]
    val resolvedOptions: t -> _Intl_ResolvedNumberFormatOptions [@@js.call "resolvedOptions"]
  end
  val numberFormat: anonymous_interface_4 [@@js.global "NumberFormat"]
  module[@js.scope "DateTimeFormatOptions"] DateTimeFormatOptions : sig
    type t = _Intl_DateTimeFormatOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_localeMatcher: t -> ([`L_s2_best_fit[@js "best fit"] | `L_s4_lookup[@js "lookup"]] [@js.enum]) [@@js.get "localeMatcher"]
    val set_localeMatcher: t -> ([`L_s2_best_fit | `L_s4_lookup] [@js.enum]) -> unit [@@js.set "localeMatcher"]
    val get_weekday: t -> ([`L_s3_long[@js "long"] | `L_s5_narrow[@js "narrow"] | `L_s7_short[@js "short"]] [@js.enum]) [@@js.get "weekday"]
    val set_weekday: t -> ([`L_s3_long | `L_s5_narrow | `L_s7_short] [@js.enum]) -> unit [@@js.set "weekday"]
    val get_era: t -> ([`L_s3_long[@js "long"] | `L_s5_narrow[@js "narrow"] | `L_s7_short[@js "short"]] [@js.enum]) [@@js.get "era"]
    val set_era: t -> ([`L_s3_long | `L_s5_narrow | `L_s7_short] [@js.enum]) -> unit [@@js.set "era"]
    val get_year: t -> ([`L_s0_2_digit[@js "2-digit"] | `L_s6_numeric[@js "numeric"]] [@js.enum]) [@@js.get "year"]
    val set_year: t -> ([`L_s0_2_digit | `L_s6_numeric] [@js.enum]) -> unit [@@js.set "year"]
    val get_month: t -> ([`L_s0_2_digit[@js "2-digit"] | `L_s3_long[@js "long"] | `L_s5_narrow[@js "narrow"] | `L_s6_numeric[@js "numeric"] | `L_s7_short[@js "short"]] [@js.enum]) [@@js.get "month"]
    val set_month: t -> ([`L_s0_2_digit | `L_s3_long | `L_s5_narrow | `L_s6_numeric | `L_s7_short] [@js.enum]) -> unit [@@js.set "month"]
    val get_day: t -> ([`L_s0_2_digit[@js "2-digit"] | `L_s6_numeric[@js "numeric"]] [@js.enum]) [@@js.get "day"]
    val set_day: t -> ([`L_s0_2_digit | `L_s6_numeric] [@js.enum]) -> unit [@@js.set "day"]
    val get_hour: t -> ([`L_s0_2_digit[@js "2-digit"] | `L_s6_numeric[@js "numeric"]] [@js.enum]) [@@js.get "hour"]
    val set_hour: t -> ([`L_s0_2_digit | `L_s6_numeric] [@js.enum]) -> unit [@@js.set "hour"]
    val get_minute: t -> ([`L_s0_2_digit[@js "2-digit"] | `L_s6_numeric[@js "numeric"]] [@js.enum]) [@@js.get "minute"]
    val set_minute: t -> ([`L_s0_2_digit | `L_s6_numeric] [@js.enum]) -> unit [@@js.set "minute"]
    val get_second: t -> ([`L_s0_2_digit[@js "2-digit"] | `L_s6_numeric[@js "numeric"]] [@js.enum]) [@@js.get "second"]
    val set_second: t -> ([`L_s0_2_digit | `L_s6_numeric] [@js.enum]) -> unit [@@js.set "second"]
    val get_timeZoneName: t -> ([`L_s3_long[@js "long"] | `L_s7_short[@js "short"]] [@js.enum]) [@@js.get "timeZoneName"]
    val set_timeZoneName: t -> ([`L_s3_long | `L_s7_short] [@js.enum]) -> unit [@@js.set "timeZoneName"]
    val get_formatMatcher: t -> ([`L_s1_basic[@js "basic"] | `L_s2_best_fit[@js "best fit"]] [@js.enum]) [@@js.get "formatMatcher"]
    val set_formatMatcher: t -> ([`L_s1_basic | `L_s2_best_fit] [@js.enum]) -> unit [@@js.set "formatMatcher"]
    val get_hour12: t -> bool [@@js.get "hour12"]
    val set_hour12: t -> bool -> unit [@@js.set "hour12"]
    val get_timeZone: t -> string [@@js.get "timeZone"]
    val set_timeZone: t -> string -> unit [@@js.set "timeZone"]
  end
  module[@js.scope "ResolvedDateTimeFormatOptions"] ResolvedDateTimeFormatOptions : sig
    type t = _Intl_ResolvedDateTimeFormatOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_locale: t -> string [@@js.get "locale"]
    val set_locale: t -> string -> unit [@@js.set "locale"]
    val get_calendar: t -> string [@@js.get "calendar"]
    val set_calendar: t -> string -> unit [@@js.set "calendar"]
    val get_numberingSystem: t -> string [@@js.get "numberingSystem"]
    val set_numberingSystem: t -> string -> unit [@@js.set "numberingSystem"]
    val get_timeZone: t -> string [@@js.get "timeZone"]
    val set_timeZone: t -> string -> unit [@@js.set "timeZone"]
    val get_hour12: t -> bool [@@js.get "hour12"]
    val set_hour12: t -> bool -> unit [@@js.set "hour12"]
    val get_weekday: t -> string [@@js.get "weekday"]
    val set_weekday: t -> string -> unit [@@js.set "weekday"]
    val get_era: t -> string [@@js.get "era"]
    val set_era: t -> string -> unit [@@js.set "era"]
    val get_year: t -> string [@@js.get "year"]
    val set_year: t -> string -> unit [@@js.set "year"]
    val get_month: t -> string [@@js.get "month"]
    val set_month: t -> string -> unit [@@js.set "month"]
    val get_day: t -> string [@@js.get "day"]
    val set_day: t -> string -> unit [@@js.set "day"]
    val get_hour: t -> string [@@js.get "hour"]
    val set_hour: t -> string -> unit [@@js.set "hour"]
    val get_minute: t -> string [@@js.get "minute"]
    val set_minute: t -> string -> unit [@@js.set "minute"]
    val get_second: t -> string [@@js.get "second"]
    val set_second: t -> string -> unit [@@js.set "second"]
    val get_timeZoneName: t -> string [@@js.get "timeZoneName"]
    val set_timeZoneName: t -> string -> unit [@@js.set "timeZoneName"]
  end
  module[@js.scope "DateTimeFormat"] DateTimeFormat : sig
    type t = _Intl_DateTimeFormat
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val format: t -> ?date:_Date or_number -> unit -> string [@@js.call "format"]
    val resolvedOptions: t -> _Intl_ResolvedDateTimeFormatOptions [@@js.call "resolvedOptions"]
  end
  val dateTimeFormat: anonymous_interface_3 [@@js.global "DateTimeFormat"]
end
