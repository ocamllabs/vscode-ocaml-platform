# 1 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
 

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


# 26 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\250\255\251\255\001\000\094\000\253\255\254\255\255\255\
    \187\000\252\255\253\255\254\255\255\255\188\000\252\255\253\255\
    \254\255\255\255";
  Lexing.lex_backtrk =
   "\255\255\255\255\255\255\255\255\003\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255";
  Lexing.lex_default =
   "\255\255\000\000\000\000\255\255\255\255\000\000\000\000\000\000\
    \010\000\000\000\000\000\000\000\000\000\015\000\000\000\000\000\
    \000\000\000\000";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\002\000\002\000\002\000\002\000\003\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\004\000\005\000\004\000\004\000\004\000\004\000\004\000\
    \007\000\006\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\000\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \000\000\004\000\004\000\004\000\004\000\004\000\000\000\000\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\000\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\012\000\017\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\011\000\
    \016\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\009\000\014\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\003\000\000\000\000\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\255\255\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\004\000\
    \255\255\004\000\004\000\004\000\004\000\004\000\255\255\255\255\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\255\255\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\008\000\013\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\008\000\
    \013\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\008\000\013\000";
  Lexing.lex_base_code =
   "";
  Lexing.lex_backtrk_code =
   "";
  Lexing.lex_default_code =
   "";
  Lexing.lex_trans_code =
   "";
  Lexing.lex_check_code =
   "";
  Lexing.lex_code =
   "";
}

let rec token lexbuf =
   __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 30 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
        ( Lparen )
# 175 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | 1 ->
# 31 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
        ( Rparen )
# 180 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | 2 ->
# 32 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
        ( new_atom (); quoted_atom lexbuf )
# 185 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | 3 ->
let
# 33 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
                  atom
# 191 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 33 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
                       ( new_atom (); add_string atom; get_atom () )
# 195 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | 4 ->
# 34 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
                      ( token lexbuf )
# 200 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | 5 ->
# 35 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
        ( Eof )
# 205 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_token_rec lexbuf __ocaml_lex_state

and quoted_atom lexbuf =
   __ocaml_lex_quoted_atom_rec lexbuf 8
and __ocaml_lex_quoted_atom_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 38 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
        ( get_atom () )
# 217 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | 1 ->
# 39 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
         ( escape_sequence lexbuf )
# 222 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | 2 ->
let
# 40 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
         c
# 228 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 40 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
           ( add_char c; quoted_atom lexbuf )
# 232 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | 3 ->
# 41 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
        ( err "unterminated string" )
# 237 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_quoted_atom_rec lexbuf __ocaml_lex_state

and escape_sequence lexbuf =
   __ocaml_lex_escape_sequence_rec lexbuf 13
and __ocaml_lex_escape_sequence_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
let
# 44 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
           c
# 250 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 44 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
             ( add_char c; quoted_atom lexbuf )
# 254 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | 1 ->
let
# 45 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
            c
# 260 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 45 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
              ( add_char c; quoted_atom lexbuf )
# 264 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | 2 ->
# 46 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
      ( err "unknown escape code" )
# 269 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | 3 ->
# 47 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
        ( err "unterminated escape sequence" )
# 274 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_escape_sequence_rec lexbuf __ocaml_lex_state

;;

# 49 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.mll"
 
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

# 308 "/Users/manas/development/ocamllabs/vscode-ocaml/src/sexp.ml"
