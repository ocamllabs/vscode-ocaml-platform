[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2015

module Array : sig
  include module type of struct
    include Array
  end

  val includes : 'T t -> search_element:'T -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]

  val to_ml : 'T t -> 'T list [@@js.cast]

  val of_ml : 'T list -> 'T t [@@js.cast]
end
[@@js.scope "Array"]

module Readonly_array : sig
  include module type of struct
    include Readonly_array
  end

  val includes : 'T t -> search_element:'T -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]

  val to_ml : 'T t -> 'T list [@@js.cast]

  val of_ml : 'T list -> 'T t [@@js.cast]
end
[@@js.scope "ReadonlyArray"]

module Int8_array : sig
  include module type of struct
    include Int8_array
  end

  val includes : t -> search_element:int -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]
end
[@@js.scope "Int8Array"]

module Uint8_array : sig
  include module type of struct
    include Uint8_array
  end

  val includes : t -> search_element:int -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]
end
[@@js.scope "Uint8Array"]

module Uint8_clamped_array : sig
  include module type of struct
    include Uint8_clamped_array
  end

  val includes : t -> search_element:int -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]
end
[@@js.scope "Uint8ClampedArray"]

module Int16_array : sig
  include module type of struct
    include Int16_array
  end

  val includes : t -> search_element:int -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]
end
[@@js.scope "Int16Array"]

module Uint16_array : sig
  include module type of struct
    include Uint16_array
  end

  val includes : t -> search_element:int -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]
end
[@@js.scope "Uint16Array"]

module Int32_array : sig
  include module type of struct
    include Int32_array
  end

  val includes : t -> search_element:int -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]
end
[@@js.scope "Int32Array"]

module Uint32_array : sig
  include module type of struct
    include Uint32_array
  end

  val includes : t -> search_element:int -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]
end
[@@js.scope "Uint32Array"]

module Float32_array : sig
  include module type of struct
    include Float32_array
  end

  val includes : t -> search_element:int -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]
end
[@@js.scope "Float32Array"]

module Float64_array : sig
  include module type of struct
    include Float64_array
  end

  val includes : t -> search_element:int -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]
end
[@@js.scope "Float64Array"]
