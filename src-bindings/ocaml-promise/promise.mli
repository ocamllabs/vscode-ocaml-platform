(** The Promise object represents the eventual completion (or failure) of an
    asynchronous operation, and its resulting value. *)
type 'a t = 'a Es5.Promise.t

(** Type for errors returned by [reject] *)
type error = private Es5.any

(** Creates a new Promise object. The constructor is primarily used to wrap
    functions that do not already support promises. *)
val make : (resolve:('a -> unit) -> reject:('e -> unit) -> unit) -> 'a t

(** {1 Instance Methods} *)

(** Appends a rejection handler callback to the promise, and returns a new
    promise resolving to the return value of the callback if it is called, or to
    its original fulfillment value if the promise is instead fulfilled. *)
val catch : rejected:(error -> 'a t) -> 'a t -> 'a t

(** Appends fulfillment and rejection handlers to the promise, and returns a new
    promise resolving to the return value of the called handler, or to its
    original settled value if the promise was not handled (i.e. if the relevant
    handler [fulfilled] or [rejected] is not a function). *)
val then_ : fulfilled:('a -> 'b t) -> ?rejected:(error -> 'b t) -> 'a t -> 'b t

(** Appends a handler to the promise, and returns a new promise that is resolved
    when the original promise is resolved. The handler is called when the
    promise is settled, whether fulfilled or rejected. *)
val finally : f:(unit -> unit) -> 'a t -> 'a t

(** {1 Static Methods} *)

(** Wait for all promises to be resolved, or for any to be rejected. If the
    returned promise resolves, it is resolved with an aggregating array of the
    values from the resolved promises ,in the same order as defined in the
    iterable of multiple promises. If it rejects, it is rejected with the reason
    from the first promise in the iterable that was rejected. *)
val all : 'a t array -> 'a array t

(** Specialization of {!all} for a tuple of 2 promises *)
val all2 : 'a t * 'b t -> ('a * 'b) t

(** Specialization of {!all} for a tuple of 3 promises *)
val all3 : 'a t * 'b t * 'c t -> ('a * 'b * 'c) t

(** Specialization of {!all} for a list of promises *)
val all_list : 'a t list -> 'a list t

(** Wait until any of the promises is resolved or rejected. If the returned
    promise resolves, it is resolved with the value of the first promise in the
    iterable that resolved. If it rejects, it is rejected with the reason from
    the first promise that was rejected. *)
val race : 'a t array -> 'a t

(** Specialization of {!race} for a list of promises *)
val race_list : 'a t list -> 'a t

(** Returns a new [Promise] object that is rejected with the given reason. *)
val reject : 'e -> 'a t

(** Returns a new [Promise] object that is resolved with the given value. If the
    value is a thenable (i.e. has a [then] method), the returned promise will
    "follow" that thenable, adopting its eventual state; otherwise the returned
    promise will be fulfilled with the value. Generally, if you don't know if a
    value is a promise or not, [Promise.resolve value] it instead and work with
    the return value as a promise. *)
val resolve : 'a -> 'a t

(** {1 Supplemental API} *)

(** Functions that are not part of the original JS Promise API, but are useful
    for writing OCaml code *)

(** Equivalent to {!resolve} *)
val return : 'a -> 'a t

val map : ('a -> 'b) -> 'a t -> 'b t

val bind : ('a -> 'b t) -> 'a t -> 'b t

module Syntax : sig
  (** Equivalent to {!Promise.map} *)
  val ( >>| ) : 'a t -> ('a -> 'b) -> 'b t

  (** Equivalent to {!Promise.bind} *)
  val ( >>= ) : 'a t -> ('a -> 'b t) -> 'b t

  (** Equivalent to {!Promise.map} *)
  val ( let+ ) : 'a t -> ('a -> 'b) -> 'b t

  (** Equivalent to {!Promise.bind} *)
  val ( let* ) : 'a t -> ('a -> 'b t) -> 'b t
end

module Option : sig
  val return : 'a -> 'a option t

  val map : ('a -> 'b) -> 'a option t -> 'b option t

  val bind : ('a -> 'b option t) -> 'a option t -> 'b option t

  val iter : ('a -> unit) -> 'a option t -> unit t

  module Syntax : sig
    (** Equivalent to {!Promise.Option.map} *)
    val ( >>| ) : 'a option t -> ('a -> 'b) -> 'b option t

    (** Equivalent to {!Promise.Option.bind} *)
    val ( >>= ) : 'a option t -> ('a -> 'b option t) -> 'b option t

    (** Equivalent to {!Promise.Option.map} *)
    val ( let+ ) : 'a option t -> ('a -> 'b) -> 'b option t

    (** Equivalent to {!Promise.Option.bind} *)
    val ( let* ) : 'a option t -> ('a -> 'b option t) -> 'b option t
  end
end

module Result : sig
  (** [from_catch p] catches any rejections on the promise [p] and resolves it
      to [Error reason], or [Ok value] when the promise is fulfilled *)
  val from_catch : 'a t -> ('a, error) result t

  val return : 'a -> ('a, 'e) result t

  val map : ('a -> 'b) -> ('a, 'e) result t -> ('b, 'e) result t

  val bind : ('a -> ('b, 'e) result t) -> ('a, 'e) result t -> ('b, 'e) result t

  val iter :
    ?ok:('a -> unit) -> ?error:('b -> unit) -> ('a, 'b) result t -> unit t

  module Syntax : sig
    (** Equivalent to {!Promise.Result.map} *)
    val ( >>| ) : ('a, 'e) result t -> ('a -> 'b) -> ('b, 'e) result t

    (** Equivalent to {!Promise.Result.bind} *)
    val ( >>= ) :
      ('a, 'e) result t -> ('a -> ('b, 'e) result t) -> ('b, 'e) result t

    (** Equivalent to {!Promise.Result.map} *)
    val ( let+ ) : ('a, 'e) result t -> ('a -> 'b) -> ('b, 'e) result t

    (** Equivalent to {!Promise.Result.bind} *)
    val ( let* ) :
      ('a, 'e) result t -> ('a -> ('b, 'e) result t) -> ('b, 'e) result t
  end
end

module Array : sig
  (** [find_map f a] applies [f] to the elements of [a] in order, and resolves
      the first result of the form [Some v], or [None] if none exist. *)
  val find_map : ('a -> 'b option t) -> 'a array -> 'b option t

  (** [filter_map f a] applies [f] to every element of [a], filters out the
      [None] elements and resolves the list of the arguments of the [Some]
      elements. *)
  val filter_map : ('a -> 'b option t) -> 'a array -> 'b array t
end

module List : sig
  (** [find_map f l] applies [f] to the elements of [l] in order, and resolves
      the first result of the form [Some v], or [None] if none exist. *)
  val find_map : ('a -> 'b option t) -> 'a list -> 'b option t

  (** [filter_map f l] applies [f] to every element of [l], filters out the
      [None] elements and resolves the list of the arguments of the [Some]
      elements. *)
  val filter_map : ('a -> 'b option t) -> 'a list -> 'b list t
end

(** {1 Compatibility with gen_js_api} *)

val t_to_js : ('a -> Ojs.t) -> 'a t -> Ojs.t

val t_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a t

type void = unit t

val void_to_js : void -> Ojs.t

val void_of_js : Ojs.t -> void

val error_to_js : error -> Ojs.t

val error_of_js : Ojs.t -> error
