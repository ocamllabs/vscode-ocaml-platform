[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Constants : sig
  include module type of struct
    include Node_os.Os.Constants.Errno
  end

  include module type of struct
    include Node_os.Os.Constants.Priority
  end

  include module type of struct
    include Node_os.Os.Signal_constants
  end

  include module type of struct
    include Node_crypto.Crypto.Constants
  end

  include module type of struct
    include Node_fs.Fs.Constants
  end
end
