[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_message : t -> string [@@js.get "message"]

  val set_message : t -> string -> unit [@@js.set "message"]

  val get_actual : t -> any [@@js.get "actual"]

  val set_actual : t -> any -> unit [@@js.set "actual"]

  val get_expected : t -> any [@@js.get "expected"]

  val set_expected : t -> any -> unit [@@js.set "expected"]

  val get_operator : t -> string [@@js.get "operator"]

  val set_operator : t -> string -> unit [@@js.set "operator"]

  val get_stack_start_fn : t -> untyped_function [@@js.get "stackStartFn"]

  val set_stack_start_fn : t -> untyped_function -> unit
    [@@js.set "stackStartFn"]
end

module Anonymous_interface1 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val apply :
    t -> actual:any -> expected:'T -> ?message:Error.t or_string -> unit -> bool
    [@@js.apply]
end

module Anonymous_interface3 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val apply : t -> value:any -> ?message:Error.t or_string -> unit -> bool
    [@@js.apply]

  val get_equal : t -> Anonymous_interface1.t [@@js.get "equal"]

  val set_equal : t -> Anonymous_interface1.t -> unit [@@js.set "equal"]

  val not_equal :
       t
    -> actual:any
    -> expected:any
    -> ?message:Error.t or_string
    -> unit
    -> unit
    [@@js.call "notEqual"]

  val get_deep_equal : t -> Anonymous_interface1.t [@@js.get "deepEqual"]

  val set_deep_equal : t -> Anonymous_interface1.t -> unit
    [@@js.set "deepEqual"]

  val not_deep_equal :
       t
    -> actual:any
    -> expected:any
    -> ?message:Error.t or_string
    -> unit
    -> unit
    [@@js.call "notDeepEqual"]

  val ok : t -> value:any -> ?message:Error.t or_string -> unit -> bool
    [@@js.call "ok"]

  val get_strict_equal : t -> Anonymous_interface1.t [@@js.get "strictEqual"]

  val set_strict_equal : t -> Anonymous_interface1.t -> unit
    [@@js.set "strictEqual"]

  val get_deep_strict_equal : t -> Anonymous_interface1.t
    [@@js.get "deepStrictEqual"]

  val set_deep_strict_equal : t -> Anonymous_interface1.t -> unit
    [@@js.set "deepStrictEqual"]

  val if_error : t -> value:any -> bool [@@js.call "ifError"]

  val get_strict : t -> (* FIXME: unknown type 'typeof strict' *) any
    [@@js.get "strict"]

  val set_strict : t -> (* FIXME: unknown type 'typeof strict' *) any -> unit
    [@@js.set "strict"]
end

module Anonymous_interface2 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val apply : t -> value:any -> ?message:Error.t or_string -> unit -> bool
    [@@js.apply]

  val get_equal : t -> Anonymous_interface1.t [@@js.get "equal"]

  val set_equal : t -> Anonymous_interface1.t -> unit [@@js.set "equal"]

  val not_equal :
       t
    -> actual:any
    -> expected:any
    -> ?message:Error.t or_string
    -> unit
    -> unit
    [@@js.call "notEqual"]

  val get_deep_equal : t -> Anonymous_interface1.t [@@js.get "deepEqual"]

  val set_deep_equal : t -> Anonymous_interface1.t -> unit
    [@@js.set "deepEqual"]

  val not_deep_equal :
       t
    -> actual:any
    -> expected:any
    -> ?message:Error.t or_string
    -> unit
    -> unit
    [@@js.call "notDeepEqual"]

  val ok : t -> value:any -> ?message:Error.t or_string -> unit -> bool
    [@@js.call "ok"]

  val get_strict_equal : t -> Anonymous_interface1.t [@@js.get "strictEqual"]

  val set_strict_equal : t -> Anonymous_interface1.t -> unit
    [@@js.set "strictEqual"]

  val get_deep_strict_equal : t -> Anonymous_interface1.t
    [@@js.get "deepStrictEqual"]

  val set_deep_strict_equal : t -> Anonymous_interface1.t -> unit
    [@@js.set "deepStrictEqual"]

  val if_error : t -> value:any -> bool [@@js.call "ifError"]

  val get_strict :
       t
    -> ( ( value:any -> ?message:Error.t or_string -> unit -> bool
         , ([ `L_s1_deepEqual [@js "deepEqual"]
            | `L_s2_deepStrictEqual [@js "deepStrictEqual"]
            | `L_s3_equal [@js "equal"]
            | `L_s4_ifError [@js "ifError"]
            | `L_s5_notDeepEqual [@js "notDeepEqual"]
            | `L_s6_notEqual [@js "notEqual"]
            | `L_s7_ok [@js "ok"]
            | `L_s8_strict [@js "strict"]
            | `L_s9_strictEqual [@js "strictEqual"]
            ]
           [@js.enum]) )
         Omit.t
       , Anonymous_interface3.t )
       intersection2
    [@@js.get "strict"]

  val set_strict :
       t
    -> ( ( value:any -> ?message:Error.t or_string -> unit -> bool
         , ([ `L_s1_deepEqual
            | `L_s2_deepStrictEqual
            | `L_s3_equal
            | `L_s4_ifError
            | `L_s5_notDeepEqual
            | `L_s6_notEqual
            | `L_s7_ok
            | `L_s8_strict
            | `L_s9_strictEqual
            ]
           [@js.enum]) )
         Omit.t
       , Anonymous_interface3.t )
       intersection2
    -> unit
    [@@js.set "strict"]
end

module Anonymous_interface4 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> untyped_object [@@js.apply_newable]
end

module Assert : sig
  module Assertion_error : sig
    include module type of struct
      include Error
    end

    val get_actual : t -> any [@@js.get "actual"]

    val set_actual : t -> any -> unit [@@js.set "actual"]

    val get_expected : t -> any [@@js.get "expected"]

    val set_expected : t -> any -> unit [@@js.set "expected"]

    val get_operator : t -> string [@@js.get "operator"]

    val set_operator : t -> string -> unit [@@js.set "operator"]

    val get_generated_message : t -> bool [@@js.get "generatedMessage"]

    val set_generated_message : t -> bool -> unit [@@js.set "generatedMessage"]

    val get_code :
      t -> ([ `L_s0_ERR_ASSERTION [@js "ERR_ASSERTION"] ][@js.enum])
      [@@js.get "code"]

    val set_code : t -> ([ `L_s0_ERR_ASSERTION ][@js.enum]) -> unit
      [@@js.set "code"]

    val create : ?options:Anonymous_interface0.t -> unit -> t [@@js.create]
  end
  [@@js.scope "AssertionError"]

  module Call_tracker_report_information : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_message : t -> string [@@js.get "message"]

    val set_message : t -> string -> unit [@@js.set "message"]

    val get_actual : t -> float [@@js.get "actual"]

    val set_actual : t -> float -> unit [@@js.set "actual"]

    val get_expected : t -> float [@@js.get "expected"]

    val set_expected : t -> float -> unit [@@js.set "expected"]

    val get_operator : t -> string [@@js.get "operator"]

    val set_operator : t -> string -> unit [@@js.set "operator"]

    val get_stack : t -> untyped_object [@@js.get "stack"]

    val set_stack : t -> untyped_object -> unit [@@js.set "stack"]
  end
  [@@js.scope "CallTrackerReportInformation"]

  module Call_tracker : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val calls : t -> ?exact:float -> unit -> (unit -> unit[@js.dummy])
      [@@js.call "calls"]

    val calls' : t -> ?fn:'Func -> ?exact:float -> unit -> 'Func
      [@@js.call "calls"]

    val report : t -> Call_tracker_report_information.t list
      [@@js.call "report"]

    val verify : t -> unit [@@js.call "verify"]
  end
  [@@js.scope "CallTracker"]

  module Assert_predicate : sig
    type t =
      ( Error.t
      , regexp
      , untyped_object
      , Anonymous_interface4.t
      , thrown:any -> bool )
      union5

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  val fail : ?message:Error.t or_string -> unit -> never [@@js.global "fail"]

  val fail :
       actual:any
    -> expected:any
    -> ?message:Error.t or_string
    -> ?operator:string
    -> ?stack_start_fn:untyped_function
    -> unit
    -> never
    [@@js.global "fail"]

  val ok : value:any -> ?message:Error.t or_string -> unit -> bool
    [@@js.global "ok"]

  val equal :
    actual:any -> expected:any -> ?message:Error.t or_string -> unit -> unit
    [@@js.global "equal"]

  val not_equal :
    actual:any -> expected:any -> ?message:Error.t or_string -> unit -> unit
    [@@js.global "notEqual"]

  val deep_equal :
    actual:any -> expected:any -> ?message:Error.t or_string -> unit -> unit
    [@@js.global "deepEqual"]

  val not_deep_equal :
    actual:any -> expected:any -> ?message:Error.t or_string -> unit -> unit
    [@@js.global "notDeepEqual"]

  val strict_equal :
    actual:any -> expected:'T -> ?message:Error.t or_string -> unit -> bool
    [@@js.global "strictEqual"]

  val not_strict_equal :
    actual:any -> expected:any -> ?message:Error.t or_string -> unit -> unit
    [@@js.global "notStrictEqual"]

  val deep_strict_equal :
    actual:any -> expected:'T -> ?message:Error.t or_string -> unit -> bool
    [@@js.global "deepStrictEqual"]

  val not_deep_strict_equal :
    actual:any -> expected:any -> ?message:Error.t or_string -> unit -> unit
    [@@js.global "notDeepStrictEqual"]

  val throws : block:(unit -> any) -> ?message:Error.t or_string -> unit -> unit
    [@@js.global "throws"]

  val throws :
       block:(unit -> any)
    -> error:Assert_predicate.t
    -> ?message:Error.t or_string
    -> unit
    -> unit
    [@@js.global "throws"]

  val does_not_throw :
    block:(unit -> any) -> ?message:Error.t or_string -> unit -> unit
    [@@js.global "doesNotThrow"]

  val does_not_throw :
       block:(unit -> any)
    -> error:Assert_predicate.t
    -> ?message:Error.t or_string
    -> unit
    -> unit
    [@@js.global "doesNotThrow"]

  val if_error : value:any -> bool [@@js.global "ifError"]

  val rejects :
       block:(unit -> any Promise.t, any Promise.t) union2
    -> ?message:Error.t or_string
    -> unit
    -> unit Promise.t
    [@@js.global "rejects"]

  val rejects :
       block:(unit -> any Promise.t, any Promise.t) union2
    -> error:Assert_predicate.t
    -> ?message:Error.t or_string
    -> unit
    -> unit Promise.t
    [@@js.global "rejects"]

  val does_not_reject :
       block:(unit -> any Promise.t, any Promise.t) union2
    -> ?message:Error.t or_string
    -> unit
    -> unit Promise.t
    [@@js.global "doesNotReject"]

  val does_not_reject :
       block:(unit -> any Promise.t, any Promise.t) union2
    -> error:Assert_predicate.t
    -> ?message:Error.t or_string
    -> unit
    -> unit Promise.t
    [@@js.global "doesNotReject"]

  val match_ :
    value:string -> reg_exp:regexp -> ?message:Error.t or_string -> unit -> unit
    [@@js.global "match"]

  val does_not_match :
    value:string -> reg_exp:regexp -> ?message:Error.t or_string -> unit -> unit
    [@@js.global "doesNotMatch"]

  val strict :
    ( ( value:any -> ?message:Error.t or_string -> unit -> bool
      , ([ `L_s1_deepEqual [@js "deepEqual"]
         | `L_s2_deepStrictEqual [@js "deepStrictEqual"]
         | `L_s3_equal [@js "equal"]
         | `L_s4_ifError [@js "ifError"]
         | `L_s5_notDeepEqual [@js "notDeepEqual"]
         | `L_s6_notEqual [@js "notEqual"]
         | `L_s7_ok [@js "ok"]
         | `L_s8_strict [@js "strict"]
         | `L_s9_strictEqual [@js "strictEqual"]
         ]
        [@js.enum]) )
      Omit.t
    , Anonymous_interface2.t )
    intersection2
    [@@js.global "strict"]
end
[@@js.scope Import.assert_]

val assert_ : bool -> ?message:Error.t or_string -> unit -> bool
  [@@js.global "assert"]
