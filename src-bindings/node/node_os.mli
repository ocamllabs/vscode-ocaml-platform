[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

  val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]
end

module Anonymous_interface1 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_encoding : t -> ([ `buffer [@js "buffer"] ][@js.enum])
    [@@js.get "encoding"]

  val set_encoding : t -> ([ `buffer ][@js.enum]) -> unit [@@js.set "encoding"]
end

module Anonymous_interface2 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_user : t -> int [@@js.get "user"]

  val set_user : t -> int -> unit [@@js.set "user"]

  val get_nice : t -> int [@@js.get "nice"]

  val set_nice : t -> int -> unit [@@js.set "nice"]

  val get_sys : t -> int [@@js.get "sys"]

  val set_sys : t -> int -> unit [@@js.set "sys"]

  val get_idle : t -> int [@@js.get "idle"]

  val set_idle : t -> int -> unit [@@js.set "idle"]

  val get_irq : t -> int [@@js.get "irq"]

  val set_irq : t -> int -> unit [@@js.set "irq"]
end

module Os : sig
  module Cpu_info : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_model : t -> string [@@js.get "model"]

    val set_model : t -> string -> unit [@@js.set "model"]

    val get_speed : t -> int [@@js.get "speed"]

    val set_speed : t -> int -> unit [@@js.set "speed"]

    val get_times : t -> Anonymous_interface2.t [@@js.get "times"]

    val set_times : t -> Anonymous_interface2.t -> unit [@@js.set "times"]
  end
  [@@js.scope "CpuInfo"]

  module Network_interface_base : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_address : t -> string [@@js.get "address"]

    val set_address : t -> string -> unit [@@js.set "address"]

    val get_netmask : t -> string [@@js.get "netmask"]

    val set_netmask : t -> string -> unit [@@js.set "netmask"]

    val get_mac : t -> string [@@js.get "mac"]

    val set_mac : t -> string -> unit [@@js.set "mac"]

    val get_internal : t -> bool [@@js.get "internal"]

    val set_internal : t -> bool -> unit [@@js.set "internal"]

    val get_cidr : t -> string or_null [@@js.get "cidr"]

    val set_cidr : t -> string or_null -> unit [@@js.set "cidr"]
  end
  [@@js.scope "NetworkInterfaceBase"]

  module Network_interface_info_i_pv4 : sig
    include module type of struct
      include Network_interface_base
    end

    val get_family : t -> ([ `IPv4 [@js "IPv4"] ][@js.enum]) [@@js.get "family"]

    val set_family : t -> ([ `IPv4 ][@js.enum]) -> unit [@@js.set "family"]
  end
  [@@js.scope "NetworkInterfaceInfoIPv4"]

  module Network_interface_info_i_pv6 : sig
    include module type of struct
      include Network_interface_base
    end

    val get_family : t -> ([ `IPv6 [@js "IPv6"] ][@js.enum]) [@@js.get "family"]

    val set_family : t -> ([ `IPv6 ][@js.enum]) -> unit [@@js.set "family"]

    val get_scopeid : t -> int [@@js.get "scopeid"]

    val set_scopeid : t -> int -> unit [@@js.set "scopeid"]
  end
  [@@js.scope "NetworkInterfaceInfoIPv6"]

  module User_info : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val get_username : 'T t -> 'T [@@js.get "username"]

    val set_username : 'T t -> 'T -> unit [@@js.set "username"]

    val get_uid : 'T t -> int [@@js.get "uid"]

    val set_uid : 'T t -> int -> unit [@@js.set "uid"]

    val get_gid : 'T t -> int [@@js.get "gid"]

    val set_gid : 'T t -> int -> unit [@@js.set "gid"]

    val get_shell : 'T t -> 'T [@@js.get "shell"]

    val set_shell : 'T t -> 'T -> unit [@@js.set "shell"]

    val get_homedir : 'T t -> 'T [@@js.get "homedir"]

    val set_homedir : 'T t -> 'T -> unit [@@js.set "homedir"]
  end
  [@@js.scope "UserInfo"]

  module Network_interface_info : sig
    type t =
      ([ `U_s1_IPv4 of Network_interface_info_i_pv4.t [@js "IPv4"]
       | `U_s2_IPv6 of Network_interface_info_i_pv6.t [@js "IPv6"]
       ]
      [@js.union on_field "family"])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  val hostname : unit -> string [@@js.global "hostname"]

  val loadavg : unit -> int list [@@js.global "loadavg"]

  val uptime : unit -> int [@@js.global "uptime"]

  val freemem : unit -> int [@@js.global "freemem"]

  val totalmem : unit -> int [@@js.global "totalmem"]

  val cpus : unit -> Cpu_info.t list [@@js.global "cpus"]

  val type_ : unit -> string [@@js.global "type"]

  val release : unit -> string [@@js.global "release"]

  val network_interfaces : unit -> Network_interface_info.t list Dict.t
    [@@js.global "networkInterfaces"]

  val homedir : unit -> string [@@js.global "homedir"]

  val user_info : options:Anonymous_interface1.t -> Buffer.t User_info.t
    [@@js.global "userInfo"]

  val user_info : ?options:Anonymous_interface0.t -> unit -> string User_info.t
    [@@js.global "userInfo"]

  module Signal_constants : sig
    type t = (* FIXME: unknown type '{ [key in Signals]: number; }' *) any

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Constants : sig
    val uv_udp_reuseaddr : int [@@js.global "UV_UDP_REUSEADDR"]

    val signals : Signal_constants.t [@@js.global "signals"]

    module Errno : sig
      val e2BIG : int [@@js.global "E2BIG"]

      val eacces : int [@@js.global "EACCES"]

      val eaddrinuse : int [@@js.global "EADDRINUSE"]

      val eaddrnotavail : int [@@js.global "EADDRNOTAVAIL"]

      val eafnosupport : int [@@js.global "EAFNOSUPPORT"]

      val eagain : int [@@js.global "EAGAIN"]

      val ealready : int [@@js.global "EALREADY"]

      val ebadf : int [@@js.global "EBADF"]

      val ebadmsg : int [@@js.global "EBADMSG"]

      val ebusy : int [@@js.global "EBUSY"]

      val ecanceled : int [@@js.global "ECANCELED"]

      val echild : int [@@js.global "ECHILD"]

      val econnaborted : int [@@js.global "ECONNABORTED"]

      val econnrefused : int [@@js.global "ECONNREFUSED"]

      val econnreset : int [@@js.global "ECONNRESET"]

      val edeadlk : int [@@js.global "EDEADLK"]

      val edestaddrreq : int [@@js.global "EDESTADDRREQ"]

      val edom : int [@@js.global "EDOM"]

      val edquot : int [@@js.global "EDQUOT"]

      val eexist : int [@@js.global "EEXIST"]

      val efault : int [@@js.global "EFAULT"]

      val efbig : int [@@js.global "EFBIG"]

      val ehostunreach : int [@@js.global "EHOSTUNREACH"]

      val eidrm : int [@@js.global "EIDRM"]

      val eilseq : int [@@js.global "EILSEQ"]

      val einprogress : int [@@js.global "EINPROGRESS"]

      val eintr : int [@@js.global "EINTR"]

      val einval : int [@@js.global "EINVAL"]

      val eio : int [@@js.global "EIO"]

      val eisconn : int [@@js.global "EISCONN"]

      val eisdir : int [@@js.global "EISDIR"]

      val eloop : int [@@js.global "ELOOP"]

      val emfile : int [@@js.global "EMFILE"]

      val emlink : int [@@js.global "EMLINK"]

      val emsgsize : int [@@js.global "EMSGSIZE"]

      val emultihop : int [@@js.global "EMULTIHOP"]

      val enametoolong : int [@@js.global "ENAMETOOLONG"]

      val enetdown : int [@@js.global "ENETDOWN"]

      val enetreset : int [@@js.global "ENETRESET"]

      val enetunreach : int [@@js.global "ENETUNREACH"]

      val enfile : int [@@js.global "ENFILE"]

      val enobufs : int [@@js.global "ENOBUFS"]

      val enodata : int [@@js.global "ENODATA"]

      val enodev : int [@@js.global "ENODEV"]

      val enoent : int [@@js.global "ENOENT"]

      val enoexec : int [@@js.global "ENOEXEC"]

      val enolck : int [@@js.global "ENOLCK"]

      val enolink : int [@@js.global "ENOLINK"]

      val enomem : int [@@js.global "ENOMEM"]

      val enomsg : int [@@js.global "ENOMSG"]

      val enoprotoopt : int [@@js.global "ENOPROTOOPT"]

      val enospc : int [@@js.global "ENOSPC"]

      val enosr : int [@@js.global "ENOSR"]

      val enostr : int [@@js.global "ENOSTR"]

      val enosys : int [@@js.global "ENOSYS"]

      val enotconn : int [@@js.global "ENOTCONN"]

      val enotdir : int [@@js.global "ENOTDIR"]

      val enotempty : int [@@js.global "ENOTEMPTY"]

      val enotsock : int [@@js.global "ENOTSOCK"]

      val enotsup : int [@@js.global "ENOTSUP"]

      val enotty : int [@@js.global "ENOTTY"]

      val enxio : int [@@js.global "ENXIO"]

      val eopnotsupp : int [@@js.global "EOPNOTSUPP"]

      val eoverflow : int [@@js.global "EOVERFLOW"]

      val eperm : int [@@js.global "EPERM"]

      val epipe : int [@@js.global "EPIPE"]

      val eproto : int [@@js.global "EPROTO"]

      val eprotonosupport : int [@@js.global "EPROTONOSUPPORT"]

      val eprototype : int [@@js.global "EPROTOTYPE"]

      val erange : int [@@js.global "ERANGE"]

      val erofs : int [@@js.global "EROFS"]

      val espipe : int [@@js.global "ESPIPE"]

      val esrch : int [@@js.global "ESRCH"]

      val estale : int [@@js.global "ESTALE"]

      val etime : int [@@js.global "ETIME"]

      val etimedout : int [@@js.global "ETIMEDOUT"]

      val etxtbsy : int [@@js.global "ETXTBSY"]

      val ewouldblock : int [@@js.global "EWOULDBLOCK"]

      val exdev : int [@@js.global "EXDEV"]

      val wsaeintr : int [@@js.global "WSAEINTR"]

      val wsaebadf : int [@@js.global "WSAEBADF"]

      val wsaeacces : int [@@js.global "WSAEACCES"]

      val wsaefault : int [@@js.global "WSAEFAULT"]

      val wsaeinval : int [@@js.global "WSAEINVAL"]

      val wsaemfile : int [@@js.global "WSAEMFILE"]

      val wsaewouldblock : int [@@js.global "WSAEWOULDBLOCK"]

      val wsaeinprogress : int [@@js.global "WSAEINPROGRESS"]

      val wsaealready : int [@@js.global "WSAEALREADY"]

      val wsaenotsock : int [@@js.global "WSAENOTSOCK"]

      val wsaedestaddrreq : int [@@js.global "WSAEDESTADDRREQ"]

      val wsaemsgsize : int [@@js.global "WSAEMSGSIZE"]

      val wsaeprototype : int [@@js.global "WSAEPROTOTYPE"]

      val wsaenoprotoopt : int [@@js.global "WSAENOPROTOOPT"]

      val wsaeprotonosupport : int [@@js.global "WSAEPROTONOSUPPORT"]

      val wsaesocktnosupport : int [@@js.global "WSAESOCKTNOSUPPORT"]

      val wsaeopnotsupp : int [@@js.global "WSAEOPNOTSUPP"]

      val wsaepfnosupport : int [@@js.global "WSAEPFNOSUPPORT"]

      val wsaeafnosupport : int [@@js.global "WSAEAFNOSUPPORT"]

      val wsaeaddrinuse : int [@@js.global "WSAEADDRINUSE"]

      val wsaeaddrnotavail : int [@@js.global "WSAEADDRNOTAVAIL"]

      val wsaenetdown : int [@@js.global "WSAENETDOWN"]

      val wsaenetunreach : int [@@js.global "WSAENETUNREACH"]

      val wsaenetreset : int [@@js.global "WSAENETRESET"]

      val wsaeconnaborted : int [@@js.global "WSAECONNABORTED"]

      val wsaeconnreset : int [@@js.global "WSAECONNRESET"]

      val wsaenobufs : int [@@js.global "WSAENOBUFS"]

      val wsaeisconn : int [@@js.global "WSAEISCONN"]

      val wsaenotconn : int [@@js.global "WSAENOTCONN"]

      val wsaeshutdown : int [@@js.global "WSAESHUTDOWN"]

      val wsaetoomanyrefs : int [@@js.global "WSAETOOMANYREFS"]

      val wsaetimedout : int [@@js.global "WSAETIMEDOUT"]

      val wsaeconnrefused : int [@@js.global "WSAECONNREFUSED"]

      val wsaeloop : int [@@js.global "WSAELOOP"]

      val wsaenametoolong : int [@@js.global "WSAENAMETOOLONG"]

      val wsaehostdown : int [@@js.global "WSAEHOSTDOWN"]

      val wsaehostunreach : int [@@js.global "WSAEHOSTUNREACH"]

      val wsaenotempty : int [@@js.global "WSAENOTEMPTY"]

      val wsaeproclim : int [@@js.global "WSAEPROCLIM"]

      val wsaeusers : int [@@js.global "WSAEUSERS"]

      val wsaedquot : int [@@js.global "WSAEDQUOT"]

      val wsaestale : int [@@js.global "WSAESTALE"]

      val wsaeremote : int [@@js.global "WSAEREMOTE"]

      val wsasysnotready : int [@@js.global "WSASYSNOTREADY"]

      val wsavernotsupported : int [@@js.global "WSAVERNOTSUPPORTED"]

      val wsanotinitialised : int [@@js.global "WSANOTINITIALISED"]

      val wsaediscon : int [@@js.global "WSAEDISCON"]

      val wsaenomore : int [@@js.global "WSAENOMORE"]

      val wsaecancelled : int [@@js.global "WSAECANCELLED"]

      val wsaeinvalidproctable : int [@@js.global "WSAEINVALIDPROCTABLE"]

      val wsaeinvalidprovider : int [@@js.global "WSAEINVALIDPROVIDER"]

      val wsaeproviderfailedinit : int [@@js.global "WSAEPROVIDERFAILEDINIT"]

      val wsasyscallfailure : int [@@js.global "WSASYSCALLFAILURE"]

      val wsaservice_not_found : int [@@js.global "WSASERVICE_NOT_FOUND"]

      val wsatype_not_found : int [@@js.global "WSATYPE_NOT_FOUND"]

      val wsa_e_no_more : int [@@js.global "WSA_E_NO_MORE"]

      val wsa_e_cancelled : int [@@js.global "WSA_E_CANCELLED"]

      val wsaerefused : int [@@js.global "WSAEREFUSED"]
    end
    [@@js.scope "errno"]

    module Priority : sig
      val priority_low : int [@@js.global "PRIORITY_LOW"]

      val priority_below_normal : int [@@js.global "PRIORITY_BELOW_NORMAL"]

      val priority_normal : int [@@js.global "PRIORITY_NORMAL"]

      val priority_above_normal : int [@@js.global "PRIORITY_ABOVE_NORMAL"]

      val priority_high : int [@@js.global "PRIORITY_HIGH"]

      val priority_highest : int [@@js.global "PRIORITY_HIGHEST"]
    end
    [@@js.scope "priority"]
  end
  [@@js.scope "constants"]

  val arch : unit -> string [@@js.global "arch"]

  val version : unit -> string [@@js.global "version"]

  val platform : unit -> Node_process.Process.Platform.t
    [@@js.global "platform"]

  val tmpdir : unit -> string [@@js.global "tmpdir"]

  val eol : string [@@js.global "EOL"]

  val endianness : unit -> ([ `BE [@js "BE"] | `LE [@js "LE"] ][@js.enum])
    [@@js.global "endianness"]

  val get_priority : ?pid:int -> unit -> int [@@js.global "getPriority"]

  val set_priority : priority:int -> unit [@@js.global "setPriority"]

  val set_priority : pid:int -> priority:int -> unit [@@js.global "setPriority"]
end
[@@js.scope Import.os]
