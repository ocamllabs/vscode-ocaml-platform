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

let arch_of_string = function
  | "arm" -> Arm
  | "arm64" -> Arm64
  | "ia32" -> Ia32
  | "mips" -> Mips
  | "mipsel" -> Mipsel
  | "ppc" -> Ppc
  | "ppc64" -> Ppc64
  | "s390" -> S390
  | "s390x" -> S390x
  | "x32" -> X32
  | "x64" -> X64
  | _ -> assert false

let arch = Node.Process.arch |> arch_of_string

type shell =
  | Sh of Path.t
  | PowerShell of Path.t

let shell =
  let sh = Sh (Path.of_string "/bin/sh") in
  let powershell =
    PowerShell
      (Path.of_string
         "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe")
  in
  Map.find { win32 = powershell; darwin = sh; linux = sh; other = sh } t
