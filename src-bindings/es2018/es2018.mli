[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

include module type of struct
  include Es2017
end

include module type of struct
  include Es2018_asynciterable
end

include module type of struct
  include Es2018_asyncgenerator
end

include module type of struct
  include Es2018_promise
end

include module type of struct
  include Es2018_regexp
end

include module type of struct
  include Es2018_intl
end
