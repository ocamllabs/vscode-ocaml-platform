{

exception Error of string

let err m = raise (Error m)

type token =
  | Lparen
  | Rparen
  | Atom of string
  | Eof

let b = Buffer.create 256

let new_atom () = Buffer.clear b

let get_atom () = Atom (Buffer.contents b)

let add_string s = Buffer.add_string b s

let add_char c = Buffer.add_char b c

}

let atom_char = [^ ';' '(' ')' '"' '\000'-'\032' '\127'-'\255']
let newline   = '\r'? '\n'
let blank     = [' ' '\t' '\012']

rule token = parse
  | '(' { Lparen }
  | ')' { Rparen }
  | '"' { new_atom (); quoted_atom lexbuf }
  | atom_char+ as atom { new_atom (); add_string atom; get_atom () }
  | (blank | newline) { token lexbuf }
  | eof { Eof }

and quoted_atom = parse
  | '"' { get_atom () }
  | '\\' { escape_sequence lexbuf }
  | _ as c { add_char c; quoted_atom lexbuf }
  | eof { err "unterminated string" }

and escape_sequence = parse
  | '"' as c { add_char c; quoted_atom lexbuf }
  | '\\' as c { add_char c; quoted_atom lexbuf }
  | _ { err "unknown escape code" }
  | eof { err "unterminated escape sequence" }

{
  type t =
    | Atom of string
    | List of t list

  let parse_string (s : string) =
    let lexbuf = Lexing.from_string s in
    let rec list depth (acc : t list) =
      match (token lexbuf : token) with
      | Eof -> List (List.rev acc)
      | Rparen ->
        if depth = 0 then err "unbalanced parens";
        List (List.rev acc)
      | Lparen ->
        let sublist = list (depth + 1) [] in
        list depth (sublist :: acc)
      | Atom a ->
        list depth (Atom a :: acc)
    in
    match list 0 [] with
    | exception (Error m) -> Error m
    | Atom _ -> assert false
    | List [x] -> Ok x
    | List [] -> Error "empty sexp"
    | List (_ :: _ :: _) -> Error "unexpected atom"
}
