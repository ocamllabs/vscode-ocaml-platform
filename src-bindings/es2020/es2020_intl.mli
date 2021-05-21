[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2019

module Intl : sig
  include module type of struct
    include Intl
  end

  module Bcp47_language_tag : sig
    type t = string

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Relative_time_format_unit : sig
    type t =
      ([ `day [@js "day"]
       | `days [@js "days"]
       | `hour [@js "hour"]
       | `hours [@js "hours"]
       | `minute [@js "minute"]
       | `minutes [@js "minutes"]
       | `month [@js "month"]
       | `months [@js "months"]
       | `quarter [@js "quarter"]
       | `quarters [@js "quarters"]
       | `second [@js "second"]
       | `seconds [@js "seconds"]
       | `week [@js "week"]
       | `weeks [@js "weeks"]
       | `year [@js "year"]
       | `years [@js "years"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Relative_time_format_locale_matcher : sig
    type t =
      ([ `best_fit [@js "best fit"]
       | `lookup [@js "lookup"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Relative_time_format_numeric : sig
    type t =
      ([ `always [@js "always"]
       | `auto [@js "auto"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Relative_time_format_style : sig
    type t =
      ([ `long [@js "long"]
       | `narrow [@js "narrow"]
       | `short [@js "short"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Calendar : sig
    type t =
      ([ `buddhist [@js "buddhist"]
       | `chinese [@js "chinese"]
       | `coptic [@js "coptic"]
       | `dangi [@js "dangi"]
       | `ethioaa [@js "ethioaa"]
       | `ethiopic [@js "ethiopic"]
       | `ethiopic_amete_alem [@js "ethiopic-amete-alem"]
       | `gregorian [@js "gregorian"]
       | `gregory [@js "gregory"]
       | `hebrew [@js "hebrew"]
       | `indian [@js "indian"]
       | `islamic [@js "islamic"]
       | `islamic_civil [@js "islamic-civil"]
       | `islamic_rgsa [@js "islamic-rgsa"]
       | `islamic_tbla [@js "islamic-tbla"]
       | `islamic_umalqura [@js "islamic-umalqura"]
       | `islamicc [@js "islamicc"]
       | `iso8601 [@js "iso8601"]
       | `japanese [@js "japanese"]
       | `persian [@js "persian"]
       | `roc [@js "roc"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Numbering_system : sig
    type t =
      ([ `adlm [@js "adlm"]
       | `ahom [@js "ahom"]
       | `arab [@js "arab"]
       | `arabext [@js "arabext"]
       | `armn [@js "armn"]
       | `armnlow [@js "armnlow"]
       | `bali [@js "bali"]
       | `beng [@js "beng"]
       | `bhks [@js "bhks"]
       | `brah [@js "brah"]
       | `cakm [@js "cakm"]
       | `cham [@js "cham"]
       | `cyrl [@js "cyrl"]
       | `deva [@js "deva"]
       | `diak [@js "diak"]
       | `ethi [@js "ethi"]
       | `finance [@js "finance"]
       | `fullwide [@js "fullwide"]
       | `geor [@js "geor"]
       | `gong [@js "gong"]
       | `gonm [@js "gonm"]
       | `grek [@js "grek"]
       | `greklow [@js "greklow"]
       | `gujr [@js "gujr"]
       | `guru [@js "guru"]
       | `hanidays [@js "hanidays"]
       | `hanidec [@js "hanidec"]
       | `hans [@js "hans"]
       | `hansfin [@js "hansfin"]
       | `hant [@js "hant"]
       | `hantfin [@js "hantfin"]
       | `hebr [@js "hebr"]
       | `hmng [@js "hmng"]
       | `hmnp [@js "hmnp"]
       | `java [@js "java"]
       | `jpan [@js "jpan"]
       | `jpanfin [@js "jpanfin"]
       | `jpanyear [@js "jpanyear"]
       | `kali [@js "kali"]
       | `khmr [@js "khmr"]
       | `knda [@js "knda"]
       | `lana [@js "lana"]
       | `lanatham [@js "lanatham"]
       | `laoo [@js "laoo"]
       | `latn [@js "latn"]
       | `lepc [@js "lepc"]
       | `limb [@js "limb"]
       | `mathbold [@js "mathbold"]
       | `mathdbl [@js "mathdbl"]
       | `mathmono [@js "mathmono"]
       | `mathsanb [@js "mathsanb"]
       | `mathsans [@js "mathsans"]
       | `mlym [@js "mlym"]
       | `modi [@js "modi"]
       | `mong [@js "mong"]
       | `mroo [@js "mroo"]
       | `mtei [@js "mtei"]
       | `mymr [@js "mymr"]
       | `mymrshan [@js "mymrshan"]
       | `mymrtlng [@js "mymrtlng"]
       | `native [@js "native"]
       | `newa [@js "newa"]
       | `nkoo [@js "nkoo"]
       | `olck [@js "olck"]
       | `orya [@js "orya"]
       | `osma [@js "osma"]
       | `rohg [@js "rohg"]
       | `roman [@js "roman"]
       | `romanlow [@js "romanlow"]
       | `saur [@js "saur"]
       | `shrd [@js "shrd"]
       | `sind [@js "sind"]
       | `sinh [@js "sinh"]
       | `sora [@js "sora"]
       | `sund [@js "sund"]
       | `takr [@js "takr"]
       | `talu [@js "talu"]
       | `taml [@js "taml"]
       | `tamldec [@js "tamldec"]
       | `telu [@js "telu"]
       | `thai [@js "thai"]
       | `tibt [@js "tibt"]
       | `tirh [@js "tirh"]
       | `traditio [@js "traditio"]
       | `traditional [@js "traditional"]
       | `vaii [@js "vaii"]
       | `wara [@js "wara"]
       | `wcho [@js "wcho"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Relative_time_format_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_locale_matcher : t -> Relative_time_format_locale_matcher.t
      [@@js.get "localeMatcher"]

    val set_locale_matcher : t -> Relative_time_format_locale_matcher.t -> unit
      [@@js.set "localeMatcher"]

    val get_numeric : t -> Relative_time_format_numeric.t [@@js.get "numeric"]

    val set_numeric : t -> Relative_time_format_numeric.t -> unit
      [@@js.set "numeric"]

    val get_style : t -> Relative_time_format_style.t [@@js.get "style"]

    val set_style : t -> Relative_time_format_style.t -> unit [@@js.set "style"]
  end
  [@@js.scope "RelativeTimeFormatOptions"]

  module Resolved_relative_time_format_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_locale : t -> string [@@js.get "locale"]

    val set_locale : t -> string -> unit [@@js.set "locale"]

    val get_style : t -> Relative_time_format_style.t [@@js.get "style"]

    val set_style : t -> Relative_time_format_style.t -> unit [@@js.set "style"]

    val get_numeric : t -> Relative_time_format_numeric.t [@@js.get "numeric"]

    val set_numeric : t -> Relative_time_format_numeric.t -> unit
      [@@js.set "numeric"]

    val get_numbering_system : t -> string [@@js.get "numberingSystem"]

    val set_numbering_system : t -> string -> unit [@@js.set "numberingSystem"]
  end
  [@@js.scope "ResolvedRelativeTimeFormatOptions"]

  module Relative_time_format_part : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_type : t -> string [@@js.get "type"]

    val set_type : t -> string -> unit [@@js.set "type"]

    val get_value : t -> string [@@js.get "value"]

    val set_value : t -> string -> unit [@@js.set "value"]

    val get_unit : t -> Relative_time_format_unit.t [@@js.get "unit"]

    val set_unit : t -> Relative_time_format_unit.t -> unit [@@js.set "unit"]
  end
  [@@js.scope "RelativeTimeFormatPart"]

  module Relative_time_format : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val format : t -> value:int -> unit:Relative_time_format_unit.t -> string
      [@@js.call "format"]

    val format_to_parts :
         t
      -> value:int
      -> unit:Relative_time_format_unit.t
      -> Relative_time_format_part.t list
      [@@js.call "formatToParts"]

    val resolved_options : t -> Resolved_relative_time_format_options.t
      [@@js.call "resolvedOptions"]
  end
  [@@js.scope "RelativeTimeFormat"]

  module Anonymous_interface0 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create :
         t
      -> ?locales:(string, string) or_array
      -> ?options:Relative_time_format_options.t
      -> unit
      -> Relative_time_format.t
      [@@js.apply_newable]

    val supported_locales_of :
         t
      -> locales:(string, string) or_array
      -> ?options:Relative_time_format_options.t
      -> unit
      -> string list
      [@@js.call "supportedLocalesOf"]
  end

  val relative_time_format : Anonymous_interface0.t
    [@@js.global "RelativeTimeFormat"]

  module Number_format_options : sig
    include module type of struct
      include Number_format_options
    end

    val get_compact_display : t -> string [@@js.get "compactDisplay"]

    val set_compact_display : t -> string -> unit [@@js.set "compactDisplay"]

    val get_notation : t -> string [@@js.get "notation"]

    val set_notation : t -> string -> unit [@@js.set "notation"]

    val get_sign_display : t -> string [@@js.get "signDisplay"]

    val set_sign_display : t -> string -> unit [@@js.set "signDisplay"]

    val get_unit : t -> string [@@js.get "unit"]

    val set_unit : t -> string -> unit [@@js.set "unit"]

    val get_unit_display : t -> string [@@js.get "unitDisplay"]

    val set_unit_display : t -> string -> unit [@@js.set "unitDisplay"]
  end
  [@@js.scope "NumberFormatOptions"]

  module Resolved_number_format_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_compact_display : t -> string [@@js.get "compactDisplay"]

    val set_compact_display : t -> string -> unit [@@js.set "compactDisplay"]

    val get_notation : t -> string [@@js.get "notation"]

    val set_notation : t -> string -> unit [@@js.set "notation"]

    val get_sign_display : t -> string [@@js.get "signDisplay"]

    val set_sign_display : t -> string -> unit [@@js.set "signDisplay"]

    val get_unit : t -> string [@@js.get "unit"]

    val set_unit : t -> string -> unit [@@js.set "unit"]

    val get_unit_display : t -> string [@@js.get "unitDisplay"]

    val set_unit_display : t -> string -> unit [@@js.set "unitDisplay"]
  end
  [@@js.scope "ResolvedNumberFormatOptions"]

  module Date_time_format_options : sig
    include module type of struct
      include Date_time_format_options
    end

    val get_date_style :
         t
      -> ([ `full [@js "full"]
          | `long [@js "long"]
          | `medium [@js "medium"]
          | `short [@js "short"]
          ]
         [@js.enum])
      [@@js.get "dateStyle"]

    val set_date_style :
      t -> ([ `full | `long | `medium | `short ][@js.enum]) -> unit
      [@@js.set "dateStyle"]

    val get_time_style :
         t
      -> ([ `full [@js "full"]
          | `long [@js "long"]
          | `medium [@js "medium"]
          | `short [@js "short"]
          ]
         [@js.enum])
      [@@js.get "timeStyle"]

    val set_time_style :
      t -> ([ `full | `long | `medium | `short ][@js.enum]) -> unit
      [@@js.set "timeStyle"]

    val get_calendar : t -> Calendar.t [@@js.get "calendar"]

    val set_calendar : t -> Calendar.t -> unit [@@js.set "calendar"]

    val get_day_period :
         t
      -> ([ `long [@js "long"] | `narrow [@js "narrow"] | `short [@js "short"] ]
         [@js.enum])
      [@@js.get "dayPeriod"]

    val set_day_period : t -> ([ `long | `narrow | `short ][@js.enum]) -> unit
      [@@js.set "dayPeriod"]

    val get_numbering_system : t -> Numbering_system.t
      [@@js.get "numberingSystem"]

    val set_numbering_system : t -> Numbering_system.t -> unit
      [@@js.set "numberingSystem"]

    val get_hour_cycle :
         t
      -> ([ `h11 [@js "h11"]
          | `h12 [@js "h12"]
          | `h23 [@js "h23"]
          | `h24 [@js "h24"]
          ]
         [@js.enum])
      [@@js.get "hourCycle"]

    val set_hour_cycle : t -> ([ `h11 | `h12 | `h23 | `h24 ][@js.enum]) -> unit
      [@@js.set "hourCycle"]

    val get_fractional_second_digits :
         t
      -> ([ `L_n_0 [@js 0] | `L_n_1 [@js 1] | `L_n_2 [@js 2] | `L_n_3 [@js 3] ]
         [@js.enum])
      [@@js.get "fractionalSecondDigits"]

    val set_fractional_second_digits :
      t -> ([ `L_n_0 | `L_n_1 | `L_n_2 | `L_n_3 ][@js.enum]) -> unit
      [@@js.set "fractionalSecondDigits"]
  end
  [@@js.scope "DateTimeFormatOptions"]
end
[@@js.scope "Intl"]
