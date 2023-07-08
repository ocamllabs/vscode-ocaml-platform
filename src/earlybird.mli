module VariableGetClosureCodeLocation : sig
  val command : string

  module Args : sig
    type t = { handle : int }

    val t_to_js : t -> Ojs.t
  end

  module Result : sig
    type position

    type range =
      { source : string
      ; pos : position
      ; end_ : position
      }

    val range_to_vscode : range -> Vscode.Range.t

    type t = { location : range option }

    val t_of_js : Ojs.t -> t
  end
end

val register : Vscode.ExtensionContext.t -> Extension_instance.t -> unit
