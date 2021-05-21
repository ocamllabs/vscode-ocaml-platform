[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2016

module Int8_array : sig
  include module type of struct
    include Int8_array
  end

  (* Constructor *)

  (* The spec introduces a constructor without any parameter, so we make the
     length optional on the existing constructor *)
  val create : ?length:int -> unit -> Int8_array.t [@@js.new "Int8Array"]
end

module Int8_array_constructor : sig
  include module type of struct
    include Int8_array_constructor
  end

  val create : t -> ?length:int -> unit -> Int8_array.t [@@js.apply_newable]
end
[@@js.scope "Int8ArrayConstructor"]

module Uint8_array : sig
  include module type of struct
    include Uint8_array
  end

  (* Constructor *)

  (* The spec introduces a constructor without any parameter, so we make the
     length optional on the existing constructor *)
  val create : ?length:int -> unit -> Uint8_array.t [@@js.new "Uint8Array"]
end

module Uint8_array_constructor : sig
  include module type of struct
    include Uint8_array_constructor
  end

  val create : t -> ?length:int -> unit -> Uint8_array.t [@@js.apply_newable]
end
[@@js.scope "Uint8ArrayConstructor"]

module Uint8_clamped_array : sig
  include module type of struct
    include Uint8_clamped_array
  end

  (* Constructor *)

  (* The spec introduces a constructor without any parameter, so we make the
     length optional on the existing constructor *)
  val create : ?length:int -> unit -> Uint8_clamped_array.t
    [@@js.new "Uint8ClampedArray"]
end

module Uint8_clamped_array_constructor : sig
  include module type of struct
    include Uint8_clamped_array_constructor
  end

  val create : t -> ?length:int -> unit -> Uint8_clamped_array.t
    [@@js.apply_newable]
end
[@@js.scope "Uint8ClampedArrayConstructor"]

module Int16_array : sig
  include module type of struct
    include Int16_array
  end

  (* Constructor *)

  (* The spec introduces a constructor without any parameter, so we make the
     length optional on the existing constructor *)
  val create : ?length:int -> unit -> Int16_array.t [@@js.new "Int16Array"]
end

module Int16_array_constructor : sig
  include module type of struct
    include Int16_array_constructor
  end

  val create : t -> ?length:int -> unit -> Int16_array.t [@@js.apply_newable]
end
[@@js.scope "Int16ArrayConstructor"]

module Uint16_array : sig
  include module type of struct
    include Uint16_array
  end

  (* Constructor *)

  (* The spec introduces a constructor without any parameter, so we make the
     length optional on the existing constructor *)
  val create : ?length:int -> unit -> Uint16_array.t [@@js.new "Uint16Array"]
end

module Uint16_array_constructor : sig
  include module type of struct
    include Uint16_array_constructor
  end

  val create : t -> ?length:int -> unit -> Uint16_array.t [@@js.apply_newable]
end
[@@js.scope "Uint16ArrayConstructor"]

module Int32_array : sig
  include module type of struct
    include Int32_array
  end

  (* Constructor *)

  (* The spec introduces a constructor without any parameter, so we make the
     length optional on the existing constructor *)
  val create : ?length:int -> unit -> Int32_array.t [@@js.new "Int32Array"]
end

module Int32_array_constructor : sig
  include module type of struct
    include Int32_array_constructor
  end

  val create : t -> ?length:int -> unit -> Int32_array.t [@@js.apply_newable]
end
[@@js.scope "Int32ArrayConstructor"]

module Uint32_array : sig
  include module type of struct
    include Uint32_array
  end

  (* Constructor *)

  (* The spec introduces a constructor without any parameter, so we make the
     length optional on the existing constructor *)
  val create : ?length:int -> unit -> Uint32_array.t [@@js.new "Uint32Array"]
end

module Uint32_array_constructor : sig
  include module type of struct
    include Uint32_array_constructor
  end

  val create : t -> ?length:int -> unit -> Uint32_array.t [@@js.apply_newable]
end
[@@js.scope "Uint32ArrayConstructor"]

module Float32_array : sig
  include module type of struct
    include Float32_array
  end

  (* Constructor *)

  (* The spec introduces a constructor without any parameter, so we make the
     length optional on the existing constructor *)
  val create : ?length:int -> unit -> Float32_array.t [@@js.new "Float32Array"]
end

module Float32_array_constructor : sig
  include module type of struct
    include Float32_array_constructor
  end

  val create : t -> ?length:int -> unit -> Float32_array.t [@@js.apply_newable]
end
[@@js.scope "Float32ArrayConstructor"]

module Float64_array : sig
  include module type of struct
    include Float64_array
  end

  (* Constructor *)

  (* The spec introduces a constructor without any parameter, so we make the
     length optional on the existing constructor *)
  val create : ?length:int -> unit -> Float64_array.t [@@js.new "Float64Array"]
end

module Float64_array_constructor : sig
  include module type of struct
    include Float64_array_constructor
  end

  val create : t -> ?length:int -> unit -> Float64_array.t [@@js.apply_newable]
end
[@@js.scope "Float64ArrayConstructor"]
