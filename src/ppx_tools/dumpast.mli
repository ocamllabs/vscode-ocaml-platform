(** [transform s k] transforms the code containted in [s] into its AST
    serialized as a [Jsonoo.t] value. The kind [k] specifies if it is an
    interface or an implementation. *)
val transform : string -> [ `Intf | `Impl ] -> Jsonoo.t

(** [from_structure str] serializes [str] as a [Jsonoo.t] value *)
val from_structure : Parsetree.structure -> Jsonoo.t

(** [reparse str str'] creates a serialized AST as a [Jsonoo.t] value that has
    {i double locations} that come both from [str] and [str'] . This is possible
    under the assumption that [str] [str'] are structurally identical modulo
    [Location.t] values; If it's not the case, the result will only contain
    simple locations coming from [str] starting from the subtree that is
    structurally different. *)
val reparse :
  Parsetree.structure_item list -> Parsetree.structure_item list -> Jsonoo.t

(** [reparse_signature sg sg'] does the same tranformation as {!reparse} but the
    starting point is [Parsetree.signature] *)
val reparse_signature :
  Parsetree.signature_item list -> Parsetree.signature_item list -> Jsonoo.t
