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

type shell =
  | Sh of Path.t
  | PowerShell of Path.t

let shell =
  let sh = Sh (Path.ofString "/bin/sh") in
  let powershell =
    PowerShell
      (Path.ofString
         "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe")
  in
  Map.find { win32 = powershell; darwin = sh; linux = sh; other = sh } t
