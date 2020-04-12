type t

(* Bindinds for https://www.npmjs.com/package/rimraf. rimraf is a
   cross-platform utility library to delete a directory and all its contens *)

val run : string -> (unit, unit) result Promise.t
