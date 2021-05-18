[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Error
  - Omit<T1, T2>
  - Promise<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module Error : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Omit : sig
    type ('T1, 'T2) t_2
    val t_2_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t_2
  end
  module Promise : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
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
    module Omit : sig
      type ('T1, 'T2) t_2
      val t_2_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t_2
    end
    module Promise : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
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
    end
    module Types : sig
      open AnonymousInterfaces
      type assert_assert_AssertPredicate = (Error.t_0, regexp, untyped_object, anonymous_interface_4, (thrown:any -> bool)) union5
      and assert_assert_AssertionError = [`Assert_assert_AssertionError] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and assert_assert_CallTracker = [`Assert_assert_CallTracker] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and assert_assert_CallTrackerReportInformation = [`Assert_assert_CallTrackerReportInformation] intf
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
    val get_message: t -> string [@@js.get "message"]
    val set_message: t -> string -> unit [@@js.set "message"]
    val get_actual: t -> any [@@js.get "actual"]
    val set_actual: t -> any -> unit [@@js.set "actual"]
    val get_expected: t -> any [@@js.get "expected"]
    val set_expected: t -> any -> unit [@@js.set "expected"]
    val get_operator: t -> string [@@js.get "operator"]
    val set_operator: t -> string -> unit [@@js.set "operator"]
    val get_stackStartFn: t -> untyped_function [@@js.get "stackStartFn"]
    val set_stackStartFn: t -> untyped_function -> unit [@@js.set "stackStartFn"]
  end
  module AnonymousInterface1 : sig
    type t = anonymous_interface_1
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val apply: t -> actual:any -> expected:'T -> ?message:Error.t_0 or_string -> unit -> bool [@@js.apply]
  end
  module AnonymousInterface2 : sig
    type t = anonymous_interface_2
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val apply: t -> value:any -> ?message:Error.t_0 or_string -> unit -> bool [@@js.apply]
    val get_equal: t -> anonymous_interface_1 [@@js.get "equal"]
    val set_equal: t -> anonymous_interface_1 -> unit [@@js.set "equal"]
    val notEqual: t -> actual:any -> expected:any -> ?message:Error.t_0 or_string -> unit -> unit [@@js.call "notEqual"]
    val get_deepEqual: t -> anonymous_interface_1 [@@js.get "deepEqual"]
    val set_deepEqual: t -> anonymous_interface_1 -> unit [@@js.set "deepEqual"]
    val notDeepEqual: t -> actual:any -> expected:any -> ?message:Error.t_0 or_string -> unit -> unit [@@js.call "notDeepEqual"]
    val ok: t -> value:any -> ?message:Error.t_0 or_string -> unit -> bool [@@js.call "ok"]
    val get_strictEqual: t -> anonymous_interface_1 [@@js.get "strictEqual"]
    val set_strictEqual: t -> anonymous_interface_1 -> unit [@@js.set "strictEqual"]
    val get_deepStrictEqual: t -> anonymous_interface_1 [@@js.get "deepStrictEqual"]
    val set_deepStrictEqual: t -> anonymous_interface_1 -> unit [@@js.set "deepStrictEqual"]
    val ifError: t -> value:any -> bool [@@js.call "ifError"]
    val get_strict: t -> (((value:any -> ?message:Error.t_0 or_string -> unit -> bool), ([`L_s1_deepEqual[@js "deepEqual"] | `L_s2_deepStrictEqual[@js "deepStrictEqual"] | `L_s3_equal[@js "equal"] | `L_s4_ifError[@js "ifError"] | `L_s5_notDeepEqual[@js "notDeepEqual"] | `L_s6_notEqual[@js "notEqual"] | `L_s7_ok[@js "ok"] | `L_s8_strict[@js "strict"] | `L_s9_strictEqual[@js "strictEqual"]] [@js.enum])) Omit.t_2, anonymous_interface_3) intersection2 [@@js.get "strict"]
    val set_strict: t -> (((value:any -> ?message:Error.t_0 or_string -> unit -> bool), ([`L_s1_deepEqual | `L_s2_deepStrictEqual | `L_s3_equal | `L_s4_ifError | `L_s5_notDeepEqual | `L_s6_notEqual | `L_s7_ok | `L_s8_strict | `L_s9_strictEqual] [@js.enum])) Omit.t_2, anonymous_interface_3) intersection2 -> unit [@@js.set "strict"]
  end
  module AnonymousInterface3 : sig
    type t = anonymous_interface_3
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val apply: t -> value:any -> ?message:Error.t_0 or_string -> unit -> bool [@@js.apply]
    val get_equal: t -> anonymous_interface_1 [@@js.get "equal"]
    val set_equal: t -> anonymous_interface_1 -> unit [@@js.set "equal"]
    val notEqual: t -> actual:any -> expected:any -> ?message:Error.t_0 or_string -> unit -> unit [@@js.call "notEqual"]
    val get_deepEqual: t -> anonymous_interface_1 [@@js.get "deepEqual"]
    val set_deepEqual: t -> anonymous_interface_1 -> unit [@@js.set "deepEqual"]
    val notDeepEqual: t -> actual:any -> expected:any -> ?message:Error.t_0 or_string -> unit -> unit [@@js.call "notDeepEqual"]
    val ok: t -> value:any -> ?message:Error.t_0 or_string -> unit -> bool [@@js.call "ok"]
    val get_strictEqual: t -> anonymous_interface_1 [@@js.get "strictEqual"]
    val set_strictEqual: t -> anonymous_interface_1 -> unit [@@js.set "strictEqual"]
    val get_deepStrictEqual: t -> anonymous_interface_1 [@@js.get "deepStrictEqual"]
    val set_deepStrictEqual: t -> anonymous_interface_1 -> unit [@@js.set "deepStrictEqual"]
    val ifError: t -> value:any -> bool [@@js.call "ifError"]
    val get_strict: t -> (* FIXME: unknown type 'typeof strict' *)any [@@js.get "strict"]
    val set_strict: t -> (* FIXME: unknown type 'typeof strict' *)any -> unit [@@js.set "strict"]
  end
  module AnonymousInterface4 : sig
    type t = anonymous_interface_4
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> untyped_object [@@js.apply_newable]
  end
  module[@js.scope "node:assert"] Node_assert : sig
    (* import assert = require('assert'); *)
    
  end
  module[@js.scope "assert"] Assert : sig
    val assert_: value:any -> ?message:Error.t_0 or_string -> unit -> bool [@@js.global "assert"]
    module[@js.scope "assert"] Assert : sig
      module[@js.scope "AssertionError"] AssertionError : sig
        type t = assert_assert_AssertionError
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_actual: t -> any [@@js.get "actual"]
        val set_actual: t -> any -> unit [@@js.set "actual"]
        val get_expected: t -> any [@@js.get "expected"]
        val set_expected: t -> any -> unit [@@js.set "expected"]
        val get_operator: t -> string [@@js.get "operator"]
        val set_operator: t -> string -> unit [@@js.set "operator"]
        val get_generatedMessage: t -> bool [@@js.get "generatedMessage"]
        val set_generatedMessage: t -> bool -> unit [@@js.set "generatedMessage"]
        val get_code: t -> ([`L_s0_ERR_ASSERTION[@js "ERR_ASSERTION"]] [@js.enum]) [@@js.get "code"]
        val set_code: t -> ([`L_s0_ERR_ASSERTION] [@js.enum]) -> unit [@@js.set "code"]
        val create: ?options:anonymous_interface_0 -> unit -> t [@@js.create]
        val cast: t -> Error.t_0 [@@js.cast]
      end
      module[@js.scope "CallTracker"] CallTracker : sig
        type t = assert_assert_CallTracker
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val calls: t -> ?exact:float -> unit -> (unit -> unit [@js.dummy]) [@@js.call "calls"]
        val calls': t -> ?fn:'Func -> ?exact:float -> unit -> 'Func [@@js.call "calls"]
        val report: t -> assert_assert_CallTrackerReportInformation list [@@js.call "report"]
        val verify: t -> unit [@@js.call "verify"]
      end
      module[@js.scope "CallTrackerReportInformation"] CallTrackerReportInformation : sig
        type t = assert_assert_CallTrackerReportInformation
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_message: t -> string [@@js.get "message"]
        val set_message: t -> string -> unit [@@js.set "message"]
        val get_actual: t -> float [@@js.get "actual"]
        val set_actual: t -> float -> unit [@@js.set "actual"]
        val get_expected: t -> float [@@js.get "expected"]
        val set_expected: t -> float -> unit [@@js.set "expected"]
        val get_operator: t -> string [@@js.get "operator"]
        val set_operator: t -> string -> unit [@@js.set "operator"]
        val get_stack: t -> untyped_object [@@js.get "stack"]
        val set_stack: t -> untyped_object -> unit [@@js.set "stack"]
      end
      module AssertPredicate : sig
        type t = assert_assert_AssertPredicate
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      val fail: ?message:Error.t_0 or_string -> unit -> never [@@js.global "fail"]
      val fail: actual:any -> expected:any -> ?message:Error.t_0 or_string -> ?operator:string -> ?stackStartFn:untyped_function -> unit -> never [@@js.global "fail"]
      val ok: value:any -> ?message:Error.t_0 or_string -> unit -> bool [@@js.global "ok"]
      val equal: actual:any -> expected:any -> ?message:Error.t_0 or_string -> unit -> unit [@@js.global "equal"]
      val notEqual: actual:any -> expected:any -> ?message:Error.t_0 or_string -> unit -> unit [@@js.global "notEqual"]
      val deepEqual: actual:any -> expected:any -> ?message:Error.t_0 or_string -> unit -> unit [@@js.global "deepEqual"]
      val notDeepEqual: actual:any -> expected:any -> ?message:Error.t_0 or_string -> unit -> unit [@@js.global "notDeepEqual"]
      val strictEqual: actual:any -> expected:'T -> ?message:Error.t_0 or_string -> unit -> bool [@@js.global "strictEqual"]
      val notStrictEqual: actual:any -> expected:any -> ?message:Error.t_0 or_string -> unit -> unit [@@js.global "notStrictEqual"]
      val deepStrictEqual: actual:any -> expected:'T -> ?message:Error.t_0 or_string -> unit -> bool [@@js.global "deepStrictEqual"]
      val notDeepStrictEqual: actual:any -> expected:any -> ?message:Error.t_0 or_string -> unit -> unit [@@js.global "notDeepStrictEqual"]
      val throws: block:(unit -> any) -> ?message:Error.t_0 or_string -> unit -> unit [@@js.global "throws"]
      val throws: block:(unit -> any) -> error:assert_assert_AssertPredicate -> ?message:Error.t_0 or_string -> unit -> unit [@@js.global "throws"]
      val doesNotThrow: block:(unit -> any) -> ?message:Error.t_0 or_string -> unit -> unit [@@js.global "doesNotThrow"]
      val doesNotThrow: block:(unit -> any) -> error:assert_assert_AssertPredicate -> ?message:Error.t_0 or_string -> unit -> unit [@@js.global "doesNotThrow"]
      val ifError: value:any -> bool [@@js.global "ifError"]
      val rejects: block:((unit -> any Promise.t_1), any Promise.t_1) union2 -> ?message:Error.t_0 or_string -> unit -> unit Promise.t_1 [@@js.global "rejects"]
      val rejects: block:((unit -> any Promise.t_1), any Promise.t_1) union2 -> error:assert_assert_AssertPredicate -> ?message:Error.t_0 or_string -> unit -> unit Promise.t_1 [@@js.global "rejects"]
      val doesNotReject: block:((unit -> any Promise.t_1), any Promise.t_1) union2 -> ?message:Error.t_0 or_string -> unit -> unit Promise.t_1 [@@js.global "doesNotReject"]
      val doesNotReject: block:((unit -> any Promise.t_1), any Promise.t_1) union2 -> error:assert_assert_AssertPredicate -> ?message:Error.t_0 or_string -> unit -> unit Promise.t_1 [@@js.global "doesNotReject"]
      val match_: value:string -> regExp:regexp -> ?message:Error.t_0 or_string -> unit -> unit [@@js.global "match"]
      val doesNotMatch: value:string -> regExp:regexp -> ?message:Error.t_0 or_string -> unit -> unit [@@js.global "doesNotMatch"]
      val strict: (((value:any -> ?message:Error.t_0 or_string -> unit -> bool), ([`L_s1_deepEqual[@js "deepEqual"] | `L_s2_deepStrictEqual[@js "deepStrictEqual"] | `L_s3_equal[@js "equal"] | `L_s4_ifError[@js "ifError"] | `L_s5_notDeepEqual[@js "notDeepEqual"] | `L_s6_notEqual[@js "notEqual"] | `L_s7_ok[@js "ok"] | `L_s8_strict[@js "strict"] | `L_s9_strictEqual[@js "strictEqual"]] [@js.enum])) Omit.t_2, anonymous_interface_2) intersection2 [@@js.global "strict"]
    end
    
  end
end
