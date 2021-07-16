val transform : string -> Jsonoo.t

val from_structure : Parsetree.structure -> Jsonoo.t

val reparse :
  Parsetree.structure_item list -> Parsetree.structure_item list -> Jsonoo.t
