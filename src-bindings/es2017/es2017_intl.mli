[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2016

module Intl : sig
  include module type of struct
    include Intl
  end

  module Date_time_format_part_types : sig
    type t =
      ([ `day [@js "day"]
       | `dayPeriod [@js "dayPeriod"]
       | `era [@js "era"]
       | `hour [@js "hour"]
       | `literal [@js "literal"]
       | `minute [@js "minute"]
       | `month [@js "month"]
       | `second [@js "second"]
       | `timeZoneName [@js "timeZoneName"]
       | `weekday [@js "weekday"]
       | `year [@js "year"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Date_time_format_part : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_type : t -> Date_time_format_part_types.t [@@js.get "type"]

    val set_type : t -> Date_time_format_part_types.t -> unit [@@js.set "type"]

    val get_value : t -> string [@@js.get "value"]

    val set_value : t -> string -> unit [@@js.set "value"]
  end
  [@@js.scope "DateTimeFormatPart"]

  module Date_time_format : sig
    include module type of struct
      include Date_time_format
    end

    val format_to_parts :
      t -> ?date:Date.t or_number -> unit -> Date_time_format_part.t list
      [@@js.call "formatToParts"]
  end
  [@@js.scope "DateTimeFormat"]
end
[@@js.scope "Intl"]
