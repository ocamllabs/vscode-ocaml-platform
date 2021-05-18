[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib

module Internal : sig
  module AnonymousInterfaces : sig
    type anonymous_interface_0 = [`anonymous_interface_0] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
  end
  module Types : sig
    open AnonymousInterfaces
    type _Intl_BCP47LanguageTag = string
    and _Intl_Calendar = ([`L_s13_buddhist[@js "buddhist"] | `L_s16_chinese[@js "chinese"] | `L_s17_coptic[@js "coptic"] | `L_s19_dangi[@js "dangi"] | `L_s25_ethioaa[@js "ethioaa"] | `L_s26_ethiopic[@js "ethiopic"] | `L_s27_ethiopic_amete_alem[@js "ethiopic-amete-alem"] | `L_s34_gregorian[@js "gregorian"] | `L_s35_gregory[@js "gregory"] | `L_s51_hebrew[@js "hebrew"] | `L_s56_indian[@js "indian"] | `L_s57_islamic[@js "islamic"] | `L_s58_islamic_civil[@js "islamic-civil"] | `L_s59_islamic_rgsa[@js "islamic-rgsa"] | `L_s60_islamic_tbla[@js "islamic-tbla"] | `L_s61_islamic_umalqura[@js "islamic-umalqura"] | `L_s62_islamicc[@js "islamicc"] | `L_s63_iso8601[@js "iso8601"] | `L_s64_japanese[@js "japanese"] | `L_s105_persian[@js "persian"] | `L_s108_roc[@js "roc"]] [@js.enum])
    and _Intl_DateTimeFormatOptions = [`Intl_DateTimeFormatOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_NumberFormatOptions = [`Intl_NumberFormatOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_NumberingSystem = ([`L_s0_adlm[@js "adlm"] | `L_s1_ahom[@js "ahom"] | `L_s3_arab[@js "arab"] | `L_s4_arabext[@js "arabext"] | `L_s5_armn[@js "armn"] | `L_s6_armnlow[@js "armnlow"] | `L_s8_bali[@js "bali"] | `L_s9_beng[@js "beng"] | `L_s11_bhks[@js "bhks"] | `L_s12_brah[@js "brah"] | `L_s14_cakm[@js "cakm"] | `L_s15_cham[@js "cham"] | `L_s18_cyrl[@js "cyrl"] | `L_s22_deva[@js "deva"] | `L_s23_diak[@js "diak"] | `L_s24_ethi[@js "ethi"] | `L_s28_finance[@js "finance"] | `L_s30_fullwide[@js "fullwide"] | `L_s31_geor[@js "geor"] | `L_s32_gong[@js "gong"] | `L_s33_gonm[@js "gonm"] | `L_s36_grek[@js "grek"] | `L_s37_greklow[@js "greklow"] | `L_s38_gujr[@js "gujr"] | `L_s39_guru[@js "guru"] | `L_s44_hanidays[@js "hanidays"] | `L_s45_hanidec[@js "hanidec"] | `L_s46_hans[@js "hans"] | `L_s47_hansfin[@js "hansfin"] | `L_s48_hant[@js "hant"] | `L_s49_hantfin[@js "hantfin"] | `L_s50_hebr[@js "hebr"] | `L_s52_hmng[@js "hmng"] | `L_s53_hmnp[@js "hmnp"] | `L_s65_java[@js "java"] | `L_s66_jpan[@js "jpan"] | `L_s67_jpanfin[@js "jpanfin"] | `L_s68_jpanyear[@js "jpanyear"] | `L_s69_kali[@js "kali"] | `L_s70_khmr[@js "khmr"] | `L_s71_knda[@js "knda"] | `L_s72_lana[@js "lana"] | `L_s73_lanatham[@js "lanatham"] | `L_s74_laoo[@js "laoo"] | `L_s75_latn[@js "latn"] | `L_s76_lepc[@js "lepc"] | `L_s77_limb[@js "limb"] | `L_s80_mathbold[@js "mathbold"] | `L_s81_mathdbl[@js "mathdbl"] | `L_s82_mathmono[@js "mathmono"] | `L_s83_mathsanb[@js "mathsanb"] | `L_s84_mathsans[@js "mathsans"] | `L_s88_mlym[@js "mlym"] | `L_s89_modi[@js "modi"] | `L_s90_mong[@js "mong"] | `L_s93_mroo[@js "mroo"] | `L_s94_mtei[@js "mtei"] | `L_s95_mymr[@js "mymr"] | `L_s96_mymrshan[@js "mymrshan"] | `L_s97_mymrtlng[@js "mymrtlng"] | `L_s99_native[@js "native"] | `L_s100_newa[@js "newa"] | `L_s101_nkoo[@js "nkoo"] | `L_s102_olck[@js "olck"] | `L_s103_orya[@js "orya"] | `L_s104_osma[@js "osma"] | `L_s109_rohg[@js "rohg"] | `L_s110_roman[@js "roman"] | `L_s111_romanlow[@js "romanlow"] | `L_s112_saur[@js "saur"] | `L_s116_shrd[@js "shrd"] | `L_s117_sind[@js "sind"] | `L_s118_sinh[@js "sinh"] | `L_s119_sora[@js "sora"] | `L_s120_sund[@js "sund"] | `L_s121_takr[@js "takr"] | `L_s122_talu[@js "talu"] | `L_s123_taml[@js "taml"] | `L_s124_tamldec[@js "tamldec"] | `L_s125_telu[@js "telu"] | `L_s126_thai[@js "thai"] | `L_s127_tibt[@js "tibt"] | `L_s128_tirh[@js "tirh"] | `L_s129_traditio[@js "traditio"] | `L_s130_traditional[@js "traditional"] | `L_s131_vaii[@js "vaii"] | `L_s132_wara[@js "wara"] | `L_s133_wcho[@js "wcho"]] [@js.enum])
    and _Intl_RelativeTimeFormat = [`Intl_RelativeTimeFormat] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_RelativeTimeFormatLocaleMatcher = ([`L_s10_best_fit[@js "best fit"] | `L_s79_lookup[@js "lookup"]] [@js.enum])
    and _Intl_RelativeTimeFormatNumeric = ([`L_s2_always[@js "always"] | `L_s7_auto[@js "auto"]] [@js.enum])
    and _Intl_RelativeTimeFormatOptions = [`Intl_RelativeTimeFormatOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_RelativeTimeFormatPart = [`Intl_RelativeTimeFormatPart] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_RelativeTimeFormatStyle = ([`L_s78_long[@js "long"] | `L_s98_narrow[@js "narrow"] | `L_s115_short[@js "short"]] [@js.enum])
    and _Intl_RelativeTimeFormatUnit = ([`L_s20_day[@js "day"] | `L_s21_days[@js "days"] | `L_s54_hour[@js "hour"] | `L_s55_hours[@js "hours"] | `L_s86_minute[@js "minute"] | `L_s87_minutes[@js "minutes"] | `L_s91_month[@js "month"] | `L_s92_months[@js "months"] | `L_s106_quarter[@js "quarter"] | `L_s107_quarters[@js "quarters"] | `L_s113_second[@js "second"] | `L_s114_seconds[@js "seconds"] | `L_s134_week[@js "week"] | `L_s135_weeks[@js "weeks"] | `L_s136_year[@js "year"] | `L_s137_years[@js "years"]] [@js.enum])
    and _Intl_ResolvedNumberFormatOptions = [`Intl_ResolvedNumberFormatOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_ResolvedRelativeTimeFormatOptions = [`Intl_ResolvedRelativeTimeFormatOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
  end
end

open Internal
open AnonymousInterfaces
open Types
module AnonymousInterface0 : sig
  type t = anonymous_interface_0
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val create: t -> ?locales:(_Intl_BCP47LanguageTag, _Intl_BCP47LanguageTag) or_array -> ?options:_Intl_RelativeTimeFormatOptions -> unit -> _Intl_RelativeTimeFormat [@@js.apply_newable]
  val supportedLocalesOf: t -> locales:(_Intl_BCP47LanguageTag, _Intl_BCP47LanguageTag) or_array -> ?options:_Intl_RelativeTimeFormatOptions -> unit -> _Intl_BCP47LanguageTag list [@@js.call "supportedLocalesOf"]
end
module[@js.scope "Intl"] Intl : sig
  module BCP47LanguageTag : sig
    type t = _Intl_BCP47LanguageTag
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module RelativeTimeFormatUnit : sig
    type t = _Intl_RelativeTimeFormatUnit
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module RelativeTimeFormatLocaleMatcher : sig
    type t = _Intl_RelativeTimeFormatLocaleMatcher
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module RelativeTimeFormatNumeric : sig
    type t = _Intl_RelativeTimeFormatNumeric
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module RelativeTimeFormatStyle : sig
    type t = _Intl_RelativeTimeFormatStyle
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Calendar : sig
    type t = _Intl_Calendar
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module NumberingSystem : sig
    type t = _Intl_NumberingSystem
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module[@js.scope "RelativeTimeFormatOptions"] RelativeTimeFormatOptions : sig
    type t = _Intl_RelativeTimeFormatOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_localeMatcher: t -> _Intl_RelativeTimeFormatLocaleMatcher [@@js.get "localeMatcher"]
    val set_localeMatcher: t -> _Intl_RelativeTimeFormatLocaleMatcher -> unit [@@js.set "localeMatcher"]
    val get_numeric: t -> _Intl_RelativeTimeFormatNumeric [@@js.get "numeric"]
    val set_numeric: t -> _Intl_RelativeTimeFormatNumeric -> unit [@@js.set "numeric"]
    val get_style: t -> _Intl_RelativeTimeFormatStyle [@@js.get "style"]
    val set_style: t -> _Intl_RelativeTimeFormatStyle -> unit [@@js.set "style"]
  end
  module[@js.scope "ResolvedRelativeTimeFormatOptions"] ResolvedRelativeTimeFormatOptions : sig
    type t = _Intl_ResolvedRelativeTimeFormatOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_locale: t -> _Intl_BCP47LanguageTag [@@js.get "locale"]
    val set_locale: t -> _Intl_BCP47LanguageTag -> unit [@@js.set "locale"]
    val get_style: t -> _Intl_RelativeTimeFormatStyle [@@js.get "style"]
    val set_style: t -> _Intl_RelativeTimeFormatStyle -> unit [@@js.set "style"]
    val get_numeric: t -> _Intl_RelativeTimeFormatNumeric [@@js.get "numeric"]
    val set_numeric: t -> _Intl_RelativeTimeFormatNumeric -> unit [@@js.set "numeric"]
    val get_numberingSystem: t -> string [@@js.get "numberingSystem"]
    val set_numberingSystem: t -> string -> unit [@@js.set "numberingSystem"]
  end
  module[@js.scope "RelativeTimeFormatPart"] RelativeTimeFormatPart : sig
    type t = _Intl_RelativeTimeFormatPart
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_type: t -> string [@@js.get "type"]
    val set_type: t -> string -> unit [@@js.set "type"]
    val get_value: t -> string [@@js.get "value"]
    val set_value: t -> string -> unit [@@js.set "value"]
    val get_unit: t -> _Intl_RelativeTimeFormatUnit [@@js.get "unit"]
    val set_unit: t -> _Intl_RelativeTimeFormatUnit -> unit [@@js.set "unit"]
  end
  module[@js.scope "RelativeTimeFormat"] RelativeTimeFormat : sig
    type t = _Intl_RelativeTimeFormat
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val format: t -> value:float -> unit:_Intl_RelativeTimeFormatUnit -> string [@@js.call "format"]
    val formatToParts: t -> value:float -> unit:_Intl_RelativeTimeFormatUnit -> _Intl_RelativeTimeFormatPart list [@@js.call "formatToParts"]
    val resolvedOptions: t -> _Intl_ResolvedRelativeTimeFormatOptions [@@js.call "resolvedOptions"]
  end
  val relativeTimeFormat: anonymous_interface_0 [@@js.global "RelativeTimeFormat"]
  module[@js.scope "NumberFormatOptions"] NumberFormatOptions : sig
    type t = _Intl_NumberFormatOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_compactDisplay: t -> string [@@js.get "compactDisplay"]
    val set_compactDisplay: t -> string -> unit [@@js.set "compactDisplay"]
    val get_notation: t -> string [@@js.get "notation"]
    val set_notation: t -> string -> unit [@@js.set "notation"]
    val get_signDisplay: t -> string [@@js.get "signDisplay"]
    val set_signDisplay: t -> string -> unit [@@js.set "signDisplay"]
    val get_unit: t -> string [@@js.get "unit"]
    val set_unit: t -> string -> unit [@@js.set "unit"]
    val get_unitDisplay: t -> string [@@js.get "unitDisplay"]
    val set_unitDisplay: t -> string -> unit [@@js.set "unitDisplay"]
  end
  module[@js.scope "ResolvedNumberFormatOptions"] ResolvedNumberFormatOptions : sig
    type t = _Intl_ResolvedNumberFormatOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_compactDisplay: t -> string [@@js.get "compactDisplay"]
    val set_compactDisplay: t -> string -> unit [@@js.set "compactDisplay"]
    val get_notation: t -> string [@@js.get "notation"]
    val set_notation: t -> string -> unit [@@js.set "notation"]
    val get_signDisplay: t -> string [@@js.get "signDisplay"]
    val set_signDisplay: t -> string -> unit [@@js.set "signDisplay"]
    val get_unit: t -> string [@@js.get "unit"]
    val set_unit: t -> string -> unit [@@js.set "unit"]
    val get_unitDisplay: t -> string [@@js.get "unitDisplay"]
    val set_unitDisplay: t -> string -> unit [@@js.set "unitDisplay"]
  end
  module[@js.scope "DateTimeFormatOptions"] DateTimeFormatOptions : sig
    type t = _Intl_DateTimeFormatOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_dateStyle: t -> ([`L_s29_full[@js "full"] | `L_s78_long[@js "long"] | `L_s85_medium[@js "medium"] | `L_s115_short[@js "short"]] [@js.enum]) [@@js.get "dateStyle"]
    val set_dateStyle: t -> ([`L_s29_full | `L_s78_long | `L_s85_medium | `L_s115_short] [@js.enum]) -> unit [@@js.set "dateStyle"]
    val get_timeStyle: t -> ([`L_s29_full[@js "full"] | `L_s78_long[@js "long"] | `L_s85_medium[@js "medium"] | `L_s115_short[@js "short"]] [@js.enum]) [@@js.get "timeStyle"]
    val set_timeStyle: t -> ([`L_s29_full | `L_s78_long | `L_s85_medium | `L_s115_short] [@js.enum]) -> unit [@@js.set "timeStyle"]
    val get_calendar: t -> _Intl_Calendar [@@js.get "calendar"]
    val set_calendar: t -> _Intl_Calendar -> unit [@@js.set "calendar"]
    val get_dayPeriod: t -> ([`L_s78_long[@js "long"] | `L_s98_narrow[@js "narrow"] | `L_s115_short[@js "short"]] [@js.enum]) [@@js.get "dayPeriod"]
    val set_dayPeriod: t -> ([`L_s78_long | `L_s98_narrow | `L_s115_short] [@js.enum]) -> unit [@@js.set "dayPeriod"]
    val get_numberingSystem: t -> _Intl_NumberingSystem [@@js.get "numberingSystem"]
    val set_numberingSystem: t -> _Intl_NumberingSystem -> unit [@@js.set "numberingSystem"]
    val get_hourCycle: t -> ([`L_s40_h11[@js "h11"] | `L_s41_h12[@js "h12"] | `L_s42_h23[@js "h23"] | `L_s43_h24[@js "h24"]] [@js.enum]) [@@js.get "hourCycle"]
    val set_hourCycle: t -> ([`L_s40_h11 | `L_s41_h12 | `L_s42_h23 | `L_s43_h24] [@js.enum]) -> unit [@@js.set "hourCycle"]
    val get_fractionalSecondDigits: t -> ([`L_n_0[@js 0] | `L_n_1[@js 1] | `L_n_2[@js 2] | `L_n_3[@js 3]] [@js.enum]) [@@js.get "fractionalSecondDigits"]
    val set_fractionalSecondDigits: t -> ([`L_n_0 | `L_n_1 | `L_n_2 | `L_n_3] [@js.enum]) -> unit [@@js.set "fractionalSecondDigits"]
  end
end
