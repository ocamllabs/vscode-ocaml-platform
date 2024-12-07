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

type arch =
  | Arm
  | Arm64
  | Ia32
  | Mips
  | Mipsel
  | Ppc
  | Ppc64
  | S390
  | S390x
  | X32
  | X64

val arch : arch

type shell =
  | Sh of Path.t
  | PowerShell of Path.t

val shell : shell
