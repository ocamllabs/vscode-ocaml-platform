[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Date
 *)
[@@@js.stop]
module type Missing = sig
  module Date : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module Date : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
]
module Make (M: Missing) : sig
  open M
  module Internal : sig
    module AnonymousInterfaces : sig
      
    end
    module Types : sig
      open AnonymousInterfaces
      type _Intl_DateTimeFormat = [`Intl_DateTimeFormat] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Intl_DateTimeFormatPart = [`Intl_DateTimeFormatPart] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Intl_DateTimeFormatPartTypes = ([`L_s0_day[@js "day"] | `L_s1_dayPeriod[@js "dayPeriod"] | `L_s2_era[@js "era"] | `L_s3_hour[@js "hour"] | `L_s4_literal[@js "literal"] | `L_s5_minute[@js "minute"] | `L_s6_month[@js "month"] | `L_s7_second[@js "second"] | `L_s8_timeZoneName[@js "timeZoneName"] | `L_s9_weekday[@js "weekday"] | `L_s10_year[@js "year"]] [@js.enum])
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "Intl"] Intl : sig
    module DateTimeFormatPartTypes : sig
      type t = _Intl_DateTimeFormatPartTypes
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "DateTimeFormatPart"] DateTimeFormatPart : sig
      type t = _Intl_DateTimeFormatPart
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> _Intl_DateTimeFormatPartTypes [@@js.get "type"]
      val set_type: t -> _Intl_DateTimeFormatPartTypes -> unit [@@js.set "type"]
      val get_value: t -> string [@@js.get "value"]
      val set_value: t -> string -> unit [@@js.set "value"]
    end
    module[@js.scope "DateTimeFormat"] DateTimeFormat : sig
      type t = _Intl_DateTimeFormat
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val formatToParts: t -> ?date:Date.t_0 or_number -> unit -> _Intl_DateTimeFormatPart list [@@js.call "formatToParts"]
    end
  end
end
