val transform : string -> [ `Intf | `Impl ] -> Jsonoo.t

val from_structure : Parsetree.structure -> Jsonoo.t

val reparse :
  Parsetree.structure_item list -> Parsetree.structure_item list -> Jsonoo.t

val reparse_signature :
  Parsetree.signature_item list -> Parsetree.signature_item list -> Jsonoo.t
