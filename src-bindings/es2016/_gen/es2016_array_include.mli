[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib

module Internal : sig
  module AnonymousInterfaces : sig
    
  end
  module Types : sig
    open AnonymousInterfaces
    type 'T _Array = [`Array of 'T] intf
    [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
    and _Float32Array = [`Float32Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Float64Array = [`Float64Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Int16Array = [`Int16Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Int32Array = [`Int32Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Int8Array = [`Int8Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and 'T _ReadonlyArray = [`ReadonlyArray of 'T] intf
    [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
    and _Uint16Array = [`Uint16Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Uint32Array = [`Uint32Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Uint8Array = [`Uint8Array] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Uint8ClampedArray = [`Uint8ClampedArray] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
  end
end

open Internal
open AnonymousInterfaces
open Types
module[@js.scope "Array"] Array : sig
  type 'T t = 'T _Array
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  val includes: 'T t -> searchElement:'T -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
  val to_ml: 'T t -> 'T list [@@js.cast]
  val of_ml: 'T list -> 'T t [@@js.cast]
end
module[@js.scope "ReadonlyArray"] ReadonlyArray : sig
  type 'T t = 'T _ReadonlyArray
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  val includes: 'T t -> searchElement:'T -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
  val to_ml: 'T t -> 'T list [@@js.cast]
  val of_ml: 'T list -> 'T t [@@js.cast]
end
module[@js.scope "Int8Array"] Int8Array : sig
  type t = _Int8Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val includes: t -> searchElement:float -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
end
module[@js.scope "Uint8Array"] Uint8Array : sig
  type t = _Uint8Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val includes: t -> searchElement:float -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
end
module[@js.scope "Uint8ClampedArray"] Uint8ClampedArray : sig
  type t = _Uint8ClampedArray
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val includes: t -> searchElement:float -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
end
module[@js.scope "Int16Array"] Int16Array : sig
  type t = _Int16Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val includes: t -> searchElement:float -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
end
module[@js.scope "Uint16Array"] Uint16Array : sig
  type t = _Uint16Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val includes: t -> searchElement:float -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
end
module[@js.scope "Int32Array"] Int32Array : sig
  type t = _Int32Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val includes: t -> searchElement:float -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
end
module[@js.scope "Uint32Array"] Uint32Array : sig
  type t = _Uint32Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val includes: t -> searchElement:float -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
end
module[@js.scope "Float32Array"] Float32Array : sig
  type t = _Float32Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val includes: t -> searchElement:float -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
end
module[@js.scope "Float64Array"] Float64Array : sig
  type t = _Float64Array
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val includes: t -> searchElement:float -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
end
