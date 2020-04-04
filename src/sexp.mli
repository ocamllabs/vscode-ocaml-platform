
type t =
  | Atom of string
  | List of t list

val parse_string : string -> (t, string) result
