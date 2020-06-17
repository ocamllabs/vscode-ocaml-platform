type t =
  | Win32
  | Darwin
  | Linux
  | Other

val t : t

module Map : sig
  type platform

  type 'a t =
    { win32 : 'a
    ; darwin : 'a
    ; linux : 'a
    ; other : 'a
    }

  val find : 'a t -> platform -> 'a
end
with type platform := t
