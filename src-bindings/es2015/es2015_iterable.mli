[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es5
open Es2015_symbol
open Es2015_collection

module Symbol_constructor : sig
  include module type of struct
    include Symbol_constructor
  end

  val get_iterator : t -> symbol [@@js.get "iterator"]
end
[@@js.scope "SymbolConstructor"]

module Iterator_yield_result : sig
  type 'TYield t

  val t_to_js : ('TYield -> Ojs.t) -> 'TYield t -> Ojs.t

  val t_of_js : (Ojs.t -> 'TYield) -> Ojs.t -> 'TYield t

  val get_done : 'TYield t -> ([ `L_b_false [@js false] ][@js.enum])
    [@@js.get "done"]

  val set_done : 'TYield t -> ([ `L_b_false ][@js.enum]) -> unit
    [@@js.set "done"]

  val get_value : 'TYield t -> 'TYield [@@js.get "value"]

  val set_value : 'TYield t -> 'TYield -> unit [@@js.set "value"]
end
[@@js.scope "IteratorYieldResult"]

module Iterator_return_result : sig
  type 'TReturn t

  val t_to_js : ('TReturn -> Ojs.t) -> 'TReturn t -> Ojs.t

  val t_of_js : (Ojs.t -> 'TReturn) -> Ojs.t -> 'TReturn t

  val get_done : 'TReturn t -> ([ `L_b_true [@js true] ][@js.enum])
    [@@js.get "done"]

  val set_done : 'TReturn t -> ([ `L_b_true ][@js.enum]) -> unit
    [@@js.set "done"]

  val get_value : 'TReturn t -> 'TReturn [@@js.get "value"]

  val set_value : 'TReturn t -> 'TReturn -> unit [@@js.set "value"]
end
[@@js.scope "IteratorReturnResult"]

module Iterator_result : sig
  type ('T, 'TReturn) t =
    ([ `false_ of 'T Iterator_yield_result.t [@js false]
     | `true_ of 'TReturn Iterator_return_result.t [@js true]
     ]
    [@js.union on_field "done"])

  val t_to_js :
    ('T -> Ojs.t) -> ('TReturn -> Ojs.t) -> ('T, 'TReturn) t -> Ojs.t

  val t_of_js :
    (Ojs.t -> 'T) -> (Ojs.t -> 'TReturn) -> Ojs.t -> ('T, 'TReturn) t
end

module Iterator : sig
  type ('T, 'TReturn, 'TNext) t

  val t_to_js :
       ('T -> Ojs.t)
    -> ('TReturn -> Ojs.t)
    -> ('TNext -> Ojs.t)
    -> ('T, 'TReturn, 'TNext) t
    -> Ojs.t

  val t_of_js :
       (Ojs.t -> 'T)
    -> (Ojs.t -> 'TReturn)
    -> (Ojs.t -> 'TNext)
    -> Ojs.t
    -> ('T, 'TReturn, 'TNext) t

  val next :
       ('T, 'TReturn, 'TNext) t
    -> args:
         (* FIXME: type 'union<() | ('TNext)>' cannot be used for variadic
            argument *) (any list[@js.variadic])
    -> ('T, 'TReturn) Iterator_result.t
    [@@js.call "next"]

  val return :
       ('T, 'TReturn, 'TNext) t
    -> ?value:'TReturn
    -> unit
    -> ('T, 'TReturn) Iterator_result.t
    [@@js.call "return"]

  val throw :
       ('T, 'TReturn, 'TNext) t
    -> ?e:any
    -> unit
    -> ('T, 'TReturn) Iterator_result.t
    [@@js.call "throw"]
end
[@@js.scope "Iterator"]

module Iterable : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Iterable_iterator : sig
  type 'T t = ('T, any, never or_undefined) Iterator.t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Array : sig
  include module type of struct
    include Array
  end

  val entries : 'T t -> (int * 'T) Iterable_iterator.t [@@js.call "entries"]

  val keys : 'T t -> int Iterable_iterator.t [@@js.call "keys"]

  val values : 'T t -> 'T Iterable_iterator.t [@@js.call "values"]

  val to_ml : 'T t -> 'T list [@@js.cast]

  val of_ml : 'T list -> 'T t [@@js.cast]

  (* Constructor *)

  val from_iterable : iterable:('T Array.t, 'T Iterable.t) union2 -> 'T list
    [@@js.global "Array.from"]

  val from_iterable' :
       iterable:('T Array.t, 'T Iterable.t) union2
    -> mapfn:(v:'T -> k:int -> 'U)
    -> ?this_arg:any
    -> unit
    -> 'U list
    [@@js.global "Array.from"]
end

module Array_constructor : sig
  include module type of struct
    include Array_constructor
  end

  val from_iterable :
    t -> iterable:('T Array.t, 'T Iterable.t) union2 -> 'T list
    [@@js.call "from"]

  val from_iterable' :
       t
    -> iterable:('T Array.t, 'T Iterable.t) union2
    -> mapfn:(v:'T -> k:int -> 'U)
    -> ?this_arg:any
    -> unit
    -> 'U list
    [@@js.call "from"]
end
[@@js.scope "ArrayConstructor"]

module Readonly_array : sig
  include module type of struct
    include Readonly_array
  end

  val entries : 'T t -> (int * 'T) Iterable_iterator.t [@@js.call "entries"]

  val keys : 'T t -> int Iterable_iterator.t [@@js.call "keys"]

  val values : 'T t -> 'T Iterable_iterator.t [@@js.call "values"]

  val to_ml : 'T t -> 'T list [@@js.cast]

  val of_ml : 'T list -> 'T t [@@js.cast]
end
[@@js.scope "ReadonlyArray"]

module Iarguments : sig
  include module type of struct
    include Iarguments
  end
end

module Map : sig
  include module type of struct
    include Map
  end

  val entries : ('K, 'V) t -> ('K * 'V) Iterable_iterator.t
    [@@js.call "entries"]

  val keys : ('K, 'V) t -> 'K Iterable_iterator.t [@@js.call "keys"]

  val values : ('K, 'V) t -> 'V Iterable_iterator.t [@@js.call "values"]

  (* Constructor *)

  val create_iterable : iterable:('K * 'V) Iterable.t -> ('K, 'V) t
    [@@js.new "Map"]
end

module Readonly_map : sig
  include module type of struct
    include Readonly_map
  end

  val entries : ('K, 'V) t -> ('K * 'V) Iterable_iterator.t
    [@@js.call "entries"]

  val keys : ('K, 'V) t -> 'K Iterable_iterator.t [@@js.call "keys"]

  val values : ('K, 'V) t -> 'V Iterable_iterator.t [@@js.call "values"]
end
[@@js.scope "ReadonlyMap"]

module Map_constructor : sig
  include module type of struct
    include Map_constructor
  end

  val create_iterable : t -> iterable:('K * 'V) Iterable.t -> ('K, 'V) Map.t
    [@@js.apply_newable]
end
[@@js.scope "MapConstructor"]

module Weak_map : sig
  include module type of struct
    include Weak_map
  end

  (* Constructor *)

  val create_iterable : iterable:('K * 'V) Iterable.t -> ('K, 'V) t
    [@@js.new "WeakMap"]
end

module Weak_map_constructor : sig
  include module type of struct
    include Weak_map_constructor
  end

  val create_iterable :
    t -> iterable:('K * 'V) Iterable.t -> ('K, 'V) Weak_map.t
    [@@js.apply_newable]
end
[@@js.scope "WeakMapConstructor"]

module Set : sig
  include module type of struct
    include Set
  end

  val entries : 'T t -> ('T * 'T) Iterable_iterator.t [@@js.call "entries"]

  val keys : 'T t -> 'T Iterable_iterator.t [@@js.call "keys"]

  val values : 'T t -> 'T Iterable_iterator.t [@@js.call "values"]

  (* Constructor *)

  val create_iterable : ?iterable:'T Iterable.t or_null -> unit -> 'T t
    [@@js.new "Set"]
end

module Readonly_set : sig
  include module type of struct
    include Readonly_set
  end

  val entries : 'T t -> ('T * 'T) Iterable_iterator.t [@@js.call "entries"]

  val keys : 'T t -> 'T Iterable_iterator.t [@@js.call "keys"]

  val values : 'T t -> 'T Iterable_iterator.t [@@js.call "values"]
end
[@@js.scope "ReadonlySet"]

module Set_constructor : sig
  include module type of struct
    include Set_constructor
  end

  val create_iterable : t -> ?iterable:'T Iterable.t or_null -> unit -> 'T Set.t
    [@@js.apply_newable]
end
[@@js.scope "SetConstructor"]

module Weak_set : sig
  include module type of struct
    include Weak_set
  end

  (* Constructor *)

  val create_iterable : iterable:'T Iterable.t -> 'T t [@@js.new "WeakSet"]
end

module Weak_set_constructor : sig
  include module type of struct
    include Weak_set_constructor
  end

  val create_iterable : t -> iterable:'T Iterable.t -> 'T Weak_set.t
    [@@js.apply_newable]
end
[@@js.scope "WeakSetConstructor"]

module Promise : sig
  include module type of struct
    include Promise
  end

  (* Constructor *)

  val all_iterable : 'T Promise.t Iterable.t -> 'T list t
    [@@js.global "Promise.all"]

  val race_iterable : 'T Promise.t Iterable.t -> 'T t
    [@@js.global "Promise.race"]
end

module Promise_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val all_iterable : t -> 'T Promise.t Iterable.t -> 'T list Promise.t
    [@@js.call "all"]

  val race_iterable : t -> 'T Promise.t Iterable.t -> 'T Promise.t
    [@@js.call "race"]
end
[@@js.scope "PromiseConstructor"]

module String : sig
  include module type of struct
    include String
  end

  val to_ml : t -> string [@@js.cast]

  val of_ml : string -> t [@@js.cast]
end
[@@js.scope "String"]

module Int8_array : sig
  include module type of struct
    include Int8_array
  end

  val entries : t -> (int * int) Iterable_iterator.t [@@js.call "entries"]

  val keys : t -> int Iterable_iterator.t [@@js.call "keys"]

  val values : t -> int Iterable_iterator.t [@@js.call "values"]

  (* Constructor *)

  val create_iterable : int Iterable.t -> t [@@js.new "Int8Array"]

  val from_iterable :
       array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Int8Array.from"]
end

module Int8_array_constructor : sig
  include module type of struct
    include Int8_array_constructor
  end

  val create_iterable : t -> int Iterable.t -> Int8_array.t [@@js.apply_newable]

  val from_iterable :
       t
    -> array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Int8_array.t
    [@@js.call "from"]
end
[@@js.scope "Int8ArrayConstructor"]

module Uint8_array : sig
  include module type of struct
    include Uint8_array
  end

  val entries : t -> (int * int) Iterable_iterator.t [@@js.call "entries"]

  val keys : t -> int Iterable_iterator.t [@@js.call "keys"]

  val values : t -> int Iterable_iterator.t [@@js.call "values"]

  (* Constructor *)

  val create_iterable : int Iterable.t -> t [@@js.new "Uint8Array"]

  val from_iterable :
       array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Uint8Array.from"]
end

module Uint8_array_constructor : sig
  include module type of struct
    include Uint8_array_constructor
  end

  val create_iterable : t -> int Iterable.t -> Uint8_array.t
    [@@js.apply_newable]

  val from_iterable :
       t
    -> array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Uint8_array.t
    [@@js.call "from"]
end
[@@js.scope "Uint8ArrayConstructor"]

module Uint8_clamped_array : sig
  include module type of struct
    include Uint8_clamped_array
  end

  val entries : t -> (int * int) Iterable_iterator.t [@@js.call "entries"]

  val keys : t -> int Iterable_iterator.t [@@js.call "keys"]

  val values : t -> int Iterable_iterator.t [@@js.call "values"]

  (* Constructor *)

  val create_iterable : int Iterable.t -> t [@@js.new "Uint8ClampedArray"]

  val from_iterable :
       array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Uint8ClampedArray.from"]
end

module Uint8_clamped_array_constructor : sig
  include module type of struct
    include Uint8_clamped_array_constructor
  end

  val create_iterable : t -> int Iterable.t -> Uint8_clamped_array.t
    [@@js.apply_newable]

  val from_iterable :
       t
    -> array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Uint8_clamped_array.t
    [@@js.call "from"]
end
[@@js.scope "Uint8ClampedArrayConstructor"]

module Int16_array : sig
  include module type of struct
    include Int16_array
  end

  val entries : t -> (int * int) Iterable_iterator.t [@@js.call "entries"]

  val keys : t -> int Iterable_iterator.t [@@js.call "keys"]

  val values : t -> int Iterable_iterator.t [@@js.call "values"]

  (* Constructor *)

  val create_iterable : int Iterable.t -> t [@@js.new "Int16Array"]

  val from_iterable :
       array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Int16Array.from"]
end

module Int16_array_constructor : sig
  include module type of struct
    include Int16_array_constructor
  end

  val create_iterable : t -> int Iterable.t -> Int16_array.t
    [@@js.apply_newable]

  val from_iterable :
       t
    -> array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Int16_array.t
    [@@js.call "from"]
end
[@@js.scope "Int16ArrayConstructor"]

module Uint16_array : sig
  include module type of struct
    include Uint16_array
  end

  val entries : t -> (int * int) Iterable_iterator.t [@@js.call "entries"]

  val keys : t -> int Iterable_iterator.t [@@js.call "keys"]

  val values : t -> int Iterable_iterator.t [@@js.call "values"]

  (* Constructor *)

  val create_iterable : int Iterable.t -> t [@@js.new "Uint16Array"]

  val from_iterable :
       array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Uint16Array.from"]
end

module Uint16_array_constructor : sig
  include module type of struct
    include Uint16_array_constructor
  end

  val create_iterable : t -> int Iterable.t -> Uint16_array.t
    [@@js.apply_newable]

  val from_iterable :
       t
    -> array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Uint16_array.t
    [@@js.call "from"]
end
[@@js.scope "Uint16ArrayConstructor"]

module Int32_array : sig
  include module type of struct
    include Int32_array
  end

  val entries : t -> (int * int) Iterable_iterator.t [@@js.call "entries"]

  val keys : t -> int Iterable_iterator.t [@@js.call "keys"]

  val values : t -> int Iterable_iterator.t [@@js.call "values"]

  (* Constructor *)

  val create_iterable : int Iterable.t -> t [@@js.new "Int32Array"]

  val from_iterable :
       array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Int32Array.from"]
end

module Int32_array_constructor : sig
  include module type of struct
    include Int32_array_constructor
  end

  val create_iterable : t -> int Iterable.t -> Int32_array.t
    [@@js.apply_newable]

  val from_iterable :
       t
    -> array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Int32_array.t
    [@@js.call "from"]
end
[@@js.scope "Int32ArrayConstructor"]

module Uint32_array : sig
  include module type of struct
    include Uint32_array
  end

  val entries : t -> (int * int) Iterable_iterator.t [@@js.call "entries"]

  val keys : t -> int Iterable_iterator.t [@@js.call "keys"]

  val values : t -> int Iterable_iterator.t [@@js.call "values"]

  (* Constructor *)

  val create_iterable : int Iterable.t -> t [@@js.new "Uint32Array"]

  val from_iterable :
       array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Uint32Array.from"]
end

module Uint32_array_constructor : sig
  include module type of struct
    include Uint32_array_constructor
  end

  val create_iterable : t -> int Iterable.t -> Uint32_array.t
    [@@js.apply_newable]

  val from_iterable :
       t
    -> array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Uint32_array.t
    [@@js.call "from"]
end
[@@js.scope "Uint32ArrayConstructor"]

module Float32_array : sig
  include module type of struct
    include Float32_array
  end

  val entries : t -> (int * int) Iterable_iterator.t [@@js.call "entries"]

  val keys : t -> int Iterable_iterator.t [@@js.call "keys"]

  val values : t -> int Iterable_iterator.t [@@js.call "values"]

  (* Constructor *)

  val create_iterable : int Iterable.t -> t [@@js.new "Float32Array"]

  val from_iterable :
       array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Float32Array.from"]
end

module Float32_array_constructor : sig
  include module type of struct
    include Float32_array_constructor
  end

  val create_iterable : t -> int Iterable.t -> Float32_array.t
    [@@js.apply_newable]

  val from_iterable :
       t
    -> array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Float32_array.t
    [@@js.call "from"]
end
[@@js.scope "Float32ArrayConstructor"]

module Float64_array : sig
  include module type of struct
    include Float64_array
  end

  val entries : t -> (int * int) Iterable_iterator.t [@@js.call "entries"]

  val keys : t -> int Iterable_iterator.t [@@js.call "keys"]

  val values : t -> int Iterable_iterator.t [@@js.call "values"]

  (* Constructor *)

  val create_iterable : int Iterable.t -> t [@@js.new "Float64Array"]

  val from_iterable :
       array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Float64Array.from"]
end

module Float64_array_constructor : sig
  include module type of struct
    include Float64_array_constructor
  end

  val create_iterable : t -> int Iterable.t -> Float64_array.t
    [@@js.apply_newable]

  val from_iterable :
       t
    -> array:int Iterable.t
    -> ?mapfn:(v:int -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Float64_array.t
    [@@js.call "from"]
end
[@@js.scope "Float64ArrayConstructor"]
