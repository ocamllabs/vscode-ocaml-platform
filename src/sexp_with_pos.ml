open Import
open Sexp
open Parsexp

type t =
  | Atom of string * Positions.range
  | List of t list * Positions.range

let rec annotate_many sexp_list positions =
  let annots_rev, rest =
    List.fold_left sexp_list ~init:([], positions)
      ~f:(fun (acc, positions) sexp ->
        let annot, positions = annotate_single sexp positions in
        (annot :: acc, positions))
  in
  (List.rev annots_rev, rest)

and annotate_single sexp positions =
  match (sexp, positions) with
  | Sexp.Atom v, start_pos :: last_pos :: rest ->
    (Atom (v, Positions.make_range_incl ~start_pos ~last_pos), rest)
  | List l, start_pos :: rest -> (
    let annots_rev, rest = annotate_many l rest in
    match rest with
    | [] -> assert false
    | last_pos :: rest ->
      (List (annots_rev, Positions.make_range_incl ~start_pos ~last_pos), rest))
  | _ -> assert false
