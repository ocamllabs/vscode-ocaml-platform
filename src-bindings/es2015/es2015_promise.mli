[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es5

module Promise : sig
  include module type of struct
    include Promise
  end

  val create :
    (resolve:('T -> unit) -> reject:('E -> unit) -> unit) -> 'T Promise.t
    [@@js.new "Promise"]

  val all : 'T1 Promise.t list -> 'T1 list Promise.t [@@js.global "Promise.all"]

  val all10 :
       'T1 Promise.t
       * 'T2 Promise.t
       * 'T3 Promise.t
       * 'T4 Promise.t
       * 'T5 Promise.t
       * 'T6 Promise.t
       * 'T7 Promise.t
       * 'T8 Promise.t
       * 'T9 Promise.t
       * 'T10 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6 * 'T7 * 'T8 * 'T9 * 'T10) Promise.t
    [@@js.global "Promise.all"]

  val all9 :
       'T1 Promise.t
       * 'T2 Promise.t
       * 'T3 Promise.t
       * 'T4 Promise.t
       * 'T5 Promise.t
       * 'T6 Promise.t
       * 'T7 Promise.t
       * 'T8 Promise.t
       * 'T9 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6 * 'T7 * 'T8 * 'T9) Promise.t
    [@@js.global "Promise.all"]

  val all8 :
       'T1 Promise.t
       * 'T2 Promise.t
       * 'T3 Promise.t
       * 'T4 Promise.t
       * 'T5 Promise.t
       * 'T6 Promise.t
       * 'T7 Promise.t
       * 'T8 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6 * 'T7 * 'T8) Promise.t
    [@@js.global "Promise.all"]

  val all7 :
       'T1 Promise.t
       * 'T2 Promise.t
       * 'T3 Promise.t
       * 'T4 Promise.t
       * 'T5 Promise.t
       * 'T6 Promise.t
       * 'T7 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6 * 'T7) Promise.t
    [@@js.global "Promise.all"]

  val all6 :
       'T1 Promise.t
       * 'T2 Promise.t
       * 'T3 Promise.t
       * 'T4 Promise.t
       * 'T5 Promise.t
       * 'T6 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6) Promise.t
    [@@js.global "Promise.all"]

  val all5 :
       'T1 Promise.t
       * 'T2 Promise.t
       * 'T3 Promise.t
       * 'T4 Promise.t
       * 'T5 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5) Promise.t
    [@@js.global "Promise.all"]

  val all4 :
       'T1 Promise.t * 'T2 Promise.t * 'T3 Promise.t * 'T4 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4) Promise.t
    [@@js.global "Promise.all"]

  val all3 :
    'T1 Promise.t * 'T2 Promise.t * 'T3 Promise.t -> ('T1 * 'T2 * 'T3) Promise.t
    [@@js.global "Promise.all"]

  val all2 : 'T1 Promise.t * 'T2 Promise.t -> ('T1 * 'T2) Promise.t
    [@@js.global "Promise.all"]

  val all1 : 'T Promise.t list -> 'T list Promise.t [@@js.global "Promise.all"]

  val race :
       'T list
    -> (* FIXME: unknown type 'T extends Promise<infer U> ? U : T' *)
       any Promise.t
    [@@js.global "Promise.race"]

  val reject : 'E -> 'T Promise.t [@@js.global "Promise.reject"]

  val resolve : 'T -> 'T Promise.t [@@js.global "Promise.resolve"]
end

module Promise_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> any Promise.t [@@js.get "prototype"]

  val create :
    t -> (resolve:('T -> unit) -> reject:('E -> unit) -> unit) -> 'T Promise.t
    [@@js.apply_newable]

  val all : t -> 'T1 Promise.t list -> 'T1 list Promise.t [@@js.call "all"]

  val all10 :
       t
    -> 'T1 Promise.t
       * 'T2 Promise.t
       * 'T3 Promise.t
       * 'T4 Promise.t
       * 'T5 Promise.t
       * 'T6 Promise.t
       * 'T7 Promise.t
       * 'T8 Promise.t
       * 'T9 Promise.t
       * 'T10 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6 * 'T7 * 'T8 * 'T9 * 'T10) Promise.t
    [@@js.call "all"]

  val all9 :
       t
    -> 'T1 Promise.t
       * 'T2 Promise.t
       * 'T3 Promise.t
       * 'T4 Promise.t
       * 'T5 Promise.t
       * 'T6 Promise.t
       * 'T7 Promise.t
       * 'T8 Promise.t
       * 'T9 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6 * 'T7 * 'T8 * 'T9) Promise.t
    [@@js.call "all"]

  val all8 :
       t
    -> 'T1 Promise.t
       * 'T2 Promise.t
       * 'T3 Promise.t
       * 'T4 Promise.t
       * 'T5 Promise.t
       * 'T6 Promise.t
       * 'T7 Promise.t
       * 'T8 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6 * 'T7 * 'T8) Promise.t
    [@@js.call "all"]

  val all7 :
       t
    -> 'T1 Promise.t
       * 'T2 Promise.t
       * 'T3 Promise.t
       * 'T4 Promise.t
       * 'T5 Promise.t
       * 'T6 Promise.t
       * 'T7 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6 * 'T7) Promise.t
    [@@js.call "all"]

  val all6 :
       t
    -> 'T1 Promise.t
       * 'T2 Promise.t
       * 'T3 Promise.t
       * 'T4 Promise.t
       * 'T5 Promise.t
       * 'T6 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6) Promise.t
    [@@js.call "all"]

  val all5 :
       t
    -> 'T1 Promise.t
       * 'T2 Promise.t
       * 'T3 Promise.t
       * 'T4 Promise.t
       * 'T5 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5) Promise.t
    [@@js.call "all"]

  val all4 :
       t
    -> 'T1 Promise.t * 'T2 Promise.t * 'T3 Promise.t * 'T4 Promise.t
    -> ('T1 * 'T2 * 'T3 * 'T4) Promise.t
    [@@js.call "all"]

  val all3 :
       t
    -> 'T1 Promise.t * 'T2 Promise.t * 'T3 Promise.t
    -> ('T1 * 'T2 * 'T3) Promise.t
    [@@js.call "all"]

  val all2 : t -> 'T1 Promise.t * 'T2 Promise.t -> ('T1 * 'T2) Promise.t
    [@@js.call "all"]

  val all1 : t -> 'T Promise.t list -> 'T list Promise.t [@@js.call "all"]

  val race :
       t
    -> 'T list
    -> (* FIXME: unknown type 'T extends Promise<infer U> ? U : T' *)
       any Promise.t
    [@@js.call "race"]

  val reject : t -> 'E -> 'T Promise.t [@@js.call "reject"]

  val resolve : t -> unit Promise.t [@@js.call "resolve"]

  val resolve' : t -> 'T -> 'T Promise.t [@@js.call "resolve"]
end
[@@js.scope "PromiseConstructor"]

val promise : Promise_constructor.t [@@js.global "Promise"]
