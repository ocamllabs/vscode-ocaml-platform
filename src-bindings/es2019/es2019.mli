[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

include module type of struct
  include Es2018
end

include module type of struct
  include Es2019_array
end

include module type of struct
  include Es2019_object
end

include module type of struct
  include Es2019_string
end

include module type of struct
  include Es2019_symbol
end
