[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

include module type of struct
  include Es2019
end

include module type of struct
  include Es2020_bigint
end

include module type of struct
  include Es2020_promise
end

include module type of struct
  include Es2020_sharedmemory
end

include module type of struct
  include Es2020_string
end

include module type of struct
  include Es2020_symbol_wellknown
end

include module type of struct
  include Es2020_intl
end
