open Import

type t =
  | Win32
  | Darwin
  | Linux
  | Other

let of_string = function
  | "win32" -> Win32
  | "darwin" -> Darwin
  | "linux" -> Linux
  | _ -> Other

let t = of_string Process.platform

module Map = struct
  type 'a t =
    { win32 : 'a
    ; darwin : 'a
    ; linux : 'a
    ; other : 'a
    }

  let find { win32; darwin; linux; other } = function
    | Win32 -> win32
    | Darwin -> darwin
    | Linux -> linux
    | Other -> other
end
