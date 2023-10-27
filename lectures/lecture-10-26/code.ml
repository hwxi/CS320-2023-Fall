(*auxiliary functions*)

let explode (s: string) : char list = 
  let rec expl i l = 
    if i < 0 then l 
    else expl (i - 1) (String.get s i :: l) in 
  expl (String.length s - 1) []

(*end auxiliary functions*)

(* Grammar 

<expression> ::= <term> + <term> | <term> - <term>
<term> ::= <var> | <const> 
<var> ::= a | b | c | d
<const> ::= 0 | 1
 *)
  

type const = Zero | One

type var = A | B | C | D

type term = Var of var | Const of const

type expr = Add of term * term | Min of term * term

let const_to_string (c:const) : string =
  match c with
    Zero -> "0" 
  | One -> "1" 


let var_to_string (c:var) : string =
  match c with
    A -> "a" 
  | B -> "b" 
  | C -> "c" 
  | D -> "d" 

let term_to_string (c:term) : string =
  match c with
    Var v -> var_to_string v
  | Const c -> const_to_string c


let print_expr (c:expr) : string =
  match c with
    Add(t1,t2) -> (term_to_string t1) ^ " + " ^ (term_to_string t2)
  | Min(t1,t2) -> (term_to_string t1) ^ " - " ^ (term_to_string t2)

let parse_const (x:char) : const option =
  match x with
  | '0' -> Some Zero
  | '1' -> Some One
  |  _  -> None                                                   
                      
let parse_var (x:char) : var option =
  match x with
  | 'a' -> Some A
  | 'b' -> Some B
  | 'c' -> Some C
  | 'd' -> Some D
  |  _  -> None                                                   

let parse_term (x:char) : term option =
  match parse_const x with
  |Some c ->  Some (Const c)
  |None -> (match parse_var x with
            |Some v ->  Some (Var v)
            |None -> None)

let parse_expr(s: char list) : expr option =
  match s with
  | x::y::z::[] -> ( match parse_term x with
                  |Some a -> (match parse_term z with
                             |Some c -> (match y with
                                        |'+' -> Some (Add (a,c))
                                        |'-' -> Some (Min (a,c))
                                        | _ -> None)
                             |  _ -> None)
                  | _ -> None)                           
  |_ -> None

let parse (s:string) : expr option=
  parse_expr (explode s)
