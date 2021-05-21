[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

include module type of struct
  include Es2016
end

include module type of struct
  include Es2017_object
end

include module type of struct
  include Es2017_sharedmemory
end

include module type of struct
  include Es2017_string
end

include module type of struct
  include Es2017_intl
end

include module type of struct
  include Es2017_typedarrays
end
