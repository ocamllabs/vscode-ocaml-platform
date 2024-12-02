open Ppxlib

(** [transform s k] transforms syntactically correct code containted in [s] into
    its AST serialized as a [Jsonoo.t] value. The kind [k] specifies if it is an
    interface or an implementation. [Error err_msg] is returned on syntax error
*)
val transform : string -> [ `Intf | `Impl ] -> (Jsonoo.t, string) result

(** [from_structure str] serializes [str] as a [Jsonoo.t] value *)
val from_structure : Parsetree.structure -> (Jsonoo.t, string) result

(** [reparse str str'] creates a serialized AST as a [Jsonoo.t] value that has
    {i double locations} that come both from [str] and [str'] . This is possible
    under the assumption that [str] [str'] are structurally identical modulo
    [Location.t] values; If it's not the case, the result will only contain
    simple locations coming from [str] starting from the subtree that is
    structurally different. The result should a priori always be an [Ok json],
    since all possibles cases of [Error e] are accounted for. *)
val reparse :
     Parsetree.structure_item list
  -> Parsetree.structure_item list
  -> (Jsonoo.t, string) result

(** [reparse_signature sg sg'] does the same tranformation as {!reparse} but the
    starting point is [Parsetree.signature] *)
val reparse_signature :
     Parsetree.signature_item list
  -> Parsetree.signature_item list
  -> (Jsonoo.t, string) result
