module Olsp_verbose_hover = struct
  include Interop.Class.Extend (Vscode.VerboseHover) ()

  let to_verboseHover (t : t) : Vscode.VerboseHover.t = Obj.magic t

  let from_hover (hover : Vscode.Hover.t) : t option =
    (* @ulugbekna: we should do an instanceof check but I don't know how
       to... *)
    if Ojs.has_property (Vscode.Hover.t_to_js hover) "verbosity" then
      Some (Obj.magic hover)
    else None

  include
    [%js:
    val canIncreaseVerbosity : t -> bool option [@@js.get]

    val canDecreaseVerbosity : t -> bool option [@@js.get]

    val contents : t -> Vscode.MarkdownString.t list [@@js.get]

    val range : t -> Vscode.Range.t option [@@js.get]

    val verbosity : t -> int [@@js.get]

    val make :
         contents:
           ([ `MarkdownString of Vscode.MarkdownString.t
            | `MarkdownStringArray of Vscode.MarkdownString.t list
            ]
           [@js.union])
      -> verbosity:int
      -> range:Vscode.Range.t option
      -> canIncreaseVerbosity:bool option
      -> canDecreaseVerbosity:bool option
      -> unit
      -> t
    [@@js.new "OlspVerboseHover"]]
end
