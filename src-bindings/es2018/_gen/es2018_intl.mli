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
    type _Intl_LDMLPluralRule = ([`L_s2_few[@js "few"] | `L_s4_many[@js "many"] | `L_s5_one[@js "one"] | `L_s7_other[@js "other"] | `L_s8_two[@js "two"] | `L_s9_zero[@js "zero"]] [@js.enum])
    and _Intl_PluralRuleType = ([`L_s1_cardinal[@js "cardinal"] | `L_s6_ordinal[@js "ordinal"]] [@js.enum])
    and _Intl_PluralRules = [`Intl_PluralRules] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_PluralRulesOptions = [`Intl_PluralRulesOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _Intl_ResolvedPluralRulesOptions = [`Intl_ResolvedPluralRulesOptions] intf
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
  val create: t -> ?locales:string list or_string -> ?options:_Intl_PluralRulesOptions -> unit -> _Intl_PluralRules [@@js.apply_newable]
  val apply: t -> ?locales:string list or_string -> ?options:_Intl_PluralRulesOptions -> unit -> _Intl_PluralRules [@@js.apply]
  val supportedLocalesOf: t -> locales:string list or_string -> ?options:_Intl_PluralRulesOptions -> unit -> string list [@@js.call "supportedLocalesOf"]
end
module[@js.scope "Intl"] Intl : sig
  module LDMLPluralRule : sig
    type t = _Intl_LDMLPluralRule
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module PluralRuleType : sig
    type t = _Intl_PluralRuleType
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module[@js.scope "PluralRulesOptions"] PluralRulesOptions : sig
    type t = _Intl_PluralRulesOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_localeMatcher: t -> ([`L_s0_best_fit[@js "best fit"] | `L_s3_lookup[@js "lookup"]] [@js.enum]) [@@js.get "localeMatcher"]
    val set_localeMatcher: t -> ([`L_s0_best_fit | `L_s3_lookup] [@js.enum]) -> unit [@@js.set "localeMatcher"]
    val get_type: t -> _Intl_PluralRuleType [@@js.get "type"]
    val set_type: t -> _Intl_PluralRuleType -> unit [@@js.set "type"]
    val get_minimumIntegerDigits: t -> float [@@js.get "minimumIntegerDigits"]
    val set_minimumIntegerDigits: t -> float -> unit [@@js.set "minimumIntegerDigits"]
    val get_minimumFractionDigits: t -> float [@@js.get "minimumFractionDigits"]
    val set_minimumFractionDigits: t -> float -> unit [@@js.set "minimumFractionDigits"]
    val get_maximumFractionDigits: t -> float [@@js.get "maximumFractionDigits"]
    val set_maximumFractionDigits: t -> float -> unit [@@js.set "maximumFractionDigits"]
    val get_minimumSignificantDigits: t -> float [@@js.get "minimumSignificantDigits"]
    val set_minimumSignificantDigits: t -> float -> unit [@@js.set "minimumSignificantDigits"]
    val get_maximumSignificantDigits: t -> float [@@js.get "maximumSignificantDigits"]
    val set_maximumSignificantDigits: t -> float -> unit [@@js.set "maximumSignificantDigits"]
  end
  module[@js.scope "ResolvedPluralRulesOptions"] ResolvedPluralRulesOptions : sig
    type t = _Intl_ResolvedPluralRulesOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_locale: t -> string [@@js.get "locale"]
    val set_locale: t -> string -> unit [@@js.set "locale"]
    val get_pluralCategories: t -> _Intl_LDMLPluralRule list [@@js.get "pluralCategories"]
    val set_pluralCategories: t -> _Intl_LDMLPluralRule list -> unit [@@js.set "pluralCategories"]
    val get_type: t -> _Intl_PluralRuleType [@@js.get "type"]
    val set_type: t -> _Intl_PluralRuleType -> unit [@@js.set "type"]
    val get_minimumIntegerDigits: t -> float [@@js.get "minimumIntegerDigits"]
    val set_minimumIntegerDigits: t -> float -> unit [@@js.set "minimumIntegerDigits"]
    val get_minimumFractionDigits: t -> float [@@js.get "minimumFractionDigits"]
    val set_minimumFractionDigits: t -> float -> unit [@@js.set "minimumFractionDigits"]
    val get_maximumFractionDigits: t -> float [@@js.get "maximumFractionDigits"]
    val set_maximumFractionDigits: t -> float -> unit [@@js.set "maximumFractionDigits"]
    val get_minimumSignificantDigits: t -> float [@@js.get "minimumSignificantDigits"]
    val set_minimumSignificantDigits: t -> float -> unit [@@js.set "minimumSignificantDigits"]
    val get_maximumSignificantDigits: t -> float [@@js.get "maximumSignificantDigits"]
    val set_maximumSignificantDigits: t -> float -> unit [@@js.set "maximumSignificantDigits"]
  end
  module[@js.scope "PluralRules"] PluralRules : sig
    type t = _Intl_PluralRules
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val resolvedOptions: t -> _Intl_ResolvedPluralRulesOptions [@@js.call "resolvedOptions"]
    val select: t -> n:float -> _Intl_LDMLPluralRule [@@js.call "select"]
  end
  val pluralRules: anonymous_interface_0 [@@js.global "PluralRules"]
end
