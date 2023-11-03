(*auxiliary functions*)

let explode (s: string) : char list = 
  let rec expl i l = 
    if i < 0 then l 
    else expl (i - 1) (String.get s i :: l) in 
  expl (String.length s - 1) []

(*end auxiliary functions*)

(* Grammar 

<expr> ::= <digit>>+<expr> | <digit>
<digit> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 

 *)
  

type expr = Add of int * expr | Digit of int

let rec expr_to_string (c:expr) : string =
  match c with
  | Add(t1,t2) -> ( string_of_int t1) ^ "+" ^ (expr_to_string t2)
  | Digit d ->   string_of_int d
                     
let parse_digit (x:char) : expr option =
  let t = int_of_char x - 48 in
  if (0 <= t) && (t <= 9) then Some (Digit t) else None 

 let rec parse_expr(s:char list) : expr option =
  match s with
  | x::'+'::tl -> ( match parse_digit x, parse_expr tl  with
                  |Some (Digit a), Some e ->  Some (Add (a,e))
                  | _ -> None)
  | x::[] -> parse_digit x
  | _ -> None

let parse (s:string) : expr option =
  parse_expr (explode s)
