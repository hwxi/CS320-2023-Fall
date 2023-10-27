type const = Zero | One

type var = A | B | C | D

type term = Var of var | Const of const

type expr = Add of term * term | Mul of term * term

let const_to_string (c:const) : string =
  match c with
    Zero -> "0" 
  | One -> "1" 


let var_to_string (c:var) : string =
  match c with
    A -> "A" 
  | B -> "B" 
  | C -> "C" 
  | D -> "D" 

let term_to_string (c:term) : string =
  match c with
    Var v -> var_to_string v
  | Const c -> const_to_string c


let print_expr (c:expr) : string =
  match c with
    Add(t1,t2) -> (term_to_string t1) ^ " + " ^ (term_to_string t2)
  | Mul(t1,t2) -> (term_to_string t1) ^ " * " ^ (term_to_string t2)

                      
