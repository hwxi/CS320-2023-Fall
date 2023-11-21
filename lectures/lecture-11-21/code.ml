(* util functions *)

let is_lower_case c =
  'a' <= c && c <= 'z'

let is_upper_case c =
  'A' <= c && c <= 'Z'

let is_alpha c =
  is_lower_case c || is_upper_case c

let is_digit c =
  '0' <= c && c <= '9'

let is_alphanum c =
  is_lower_case c ||
  is_upper_case c ||
  is_digit c

let is_blank c =
  String.contains " \012\n\r\t" c

let explode s =
  List.of_seq (String.to_seq s)

let implode ls =
  String.of_seq (List.to_seq ls)

let readlines (file : string) : string =
  let fp = open_in file in
  let rec loop () =
    match input_line fp with
    | s -> s ^ "\n" ^ (loop ())
    | exception End_of_file -> ""
  in
  let res = loop () in
  let () = close_in fp in
  res

(* end of util functions *)

(* parser combinators *)

type 'a parser = char list -> ('a * char list) option

let parse (p : 'a parser) (s : string) : ('a * char list) option =
  p (explode s)

let pure (x : 'a) : 'a parser =
  fun ls -> Some (x, ls)

let fail : 'a parser = fun ls -> None

let bind (p : 'a parser) (q : 'a -> 'b parser) : 'b parser =
  fun ls ->
    match p ls with
    | Some (a, ls) -> q a ls
    | None -> None

let (>>=) = bind
let (let*) = bind

let read : char parser =
  fun ls ->
  match ls with
  | x :: ls -> Some (x, ls)
  | _ -> None

let satisfy (f : char -> bool) : char parser =
  fun ls ->
  match ls with
  | x :: ls ->
    if f x then Some (x, ls)
    else None
  | _ -> None

let char (c : char) : char parser =
  satisfy (fun x -> x = c)

let seq (p1 : 'a parser) (p2 : 'b parser) : 'b parser =
  fun ls ->
  match p1 ls with
  | Some (_, ls) -> p2 ls
  | None -> None

let (>>) = seq

let seq' (p1 : 'a parser) (p2 : 'b parser) : 'a parser =
  fun ls ->
  match p1 ls with
  | Some (x, ls) ->
    (match p2 ls with
     | Some (_, ls) -> Some (x, ls)
     | None -> None)
  | None -> None

let (<<) = seq'

let disj (p1 : 'a parser) (p2 : 'a parser) : 'a parser =
  fun ls ->
  match p1 ls with
  | Some (x, ls)  -> Some (x, ls)
  | None -> p2 ls

let (<|>) = disj

let map (p : 'a parser) (f : 'a -> 'b) : 'b parser =
  fun ls ->
  match p ls with
  | Some (a, ls) -> Some (f a, ls)
  | None -> None

let (>|=) = map

let (>|) = fun p c -> map p (fun _ -> c)

let rec many (p : 'a parser) : ('a list) parser =
  fun ls ->
  match p ls with
  | Some (x, ls) ->
    (match many p ls with
     | Some (xs, ls) -> Some (x :: xs, ls)
     | None -> Some (x :: [], ls))
  | None -> Some ([], ls)

let rec many1 (p : 'a parser) : ('a list) parser =
  fun ls ->
  match p ls with
  | Some (x, ls) ->
    (match many p ls with
     | Some (xs, ls) -> Some (x :: xs, ls)
     | None -> Some (x :: [], ls))
  | None -> None

let rec many' (p : unit -> 'a parser) : ('a list) parser =
  fun ls ->
  match p () ls with
  | Some (x, ls) ->
    (match many' p ls with
     | Some (xs, ls) -> Some (x :: xs, ls)
     | None -> Some (x :: [], ls))
  | None -> Some ([], ls)

let rec many1' (p : unit -> 'a parser) : ('a list) parser =
  fun ls ->
  match p () ls with
  | Some (x, ls) ->
    (match many' p ls with
     | Some (xs, ls) -> Some (x :: xs, ls)
     | None -> Some (x :: [], ls))
  | None -> None

let whitespace : unit parser =
  fun ls ->
  match ls with
  | c :: ls ->
    if String.contains " \012\n\r\t" c
    then Some ((), ls)
    else None
  | _ -> None

let ws : unit parser =
  (many whitespace) >| ()

let ws1 : unit parser =
  (many1 whitespace) >| ()

let digit : char parser =
  satisfy is_digit

let natural : int parser =
  fun ls ->
  match many1 digit ls with
  | Some (xs, ls) ->
    Some (int_of_string (implode xs), ls)
  | _ -> None

let literal (s : string) : unit parser =
  fun ls ->
  let cs = explode s in
  let rec loop cs ls =
    match cs, ls with
    | [], _ -> Some ((), ls)
    | c :: cs, x :: xs ->
      if x = c
      then loop cs xs
      else None
    | _ -> None
  in loop cs ls

let keyword (s : string) : unit parser =
  (literal s) >> ws >| ()
                         
                         (* end of parser combinators *)


(* <expr> ::=  int + <expr>   | int - <expr>  | int
 *)


type expr = Add of expr * expr | Sub of expr * expr |  D of int

let integer : int parser =
   (let* _ = char '-' in
   let* x = natural in pure  (-x))
   <|>
     (let* x = natural in pure x)
                                                         

let rec expr() =
  (let* _ = ws in
   let* x = integer in
   let* _ = ws in
   let* _ = char '+' in
   let* _ = ws in
   let* y=expr() in
   let* _ = ws in
   pure (Add (D x, y)))
  <|>
  (let* _ = ws in
   let* x = integer in
   let* _ = ws in
   let* _ = char '-' in
   let* _ = ws in
   let* y=expr() in
   let* _ = ws in
   pure (Sub (D x,y)))
  <|>
    (let* _ = ws in
     let* v = integer in
     let* _ = ws in
     pure (D v))
  

  
 let rec eval_step (x:expr) : expr =
  match x with
  | Add (D v1,D v2) -> D(v1+v2)
  | Sub (D v1,D v2) -> D(v1-v2)
  | Add (D v1,e2) -> let e2' = eval_step e2 in Add(D v1,e2')
  | Sub (D v1,e2) -> let e2' = eval_step e2 in Sub(D v1,e2')
  | Add (e1,e2) -> let e1' = eval_step e1 in Add(e1',e2)
  | Sub (e1,e2) -> let e1' = eval_step e1 in Sub(e1',e2)
                                           
let rec eval (x:expr) (n:int): expr =
  if n<=0 then x else let x' = eval_step x in eval x' (n-1)


                                            

let rec eval_step_s (x:expr) : expr =
  match x with
  | Add (D v1,D v2) -> D(v1+v2)
  | Sub (D v1,D v2) -> D(v1-v2)
  | Add (D v1,e2) -> let e2' = eval_step e2 in Add(D v1,e2')
  | Sub (D v1,e2) -> let e2' = eval_step e2 in Sub(D v1,e2')
  
let rec eval_s (x:expr) (n:int): expr =
  if n<=0 then x else (let y = eval_step_s x in (eval_s y (n-1)))
                                                  


(* <bexpr> ::=  <const> and <bexpr>   | <const> or <bexpr>  | <const> eq <bexpr>
   <const> ::= bool | int
 *)


type bexpr = And of bexpr * bexpr | Or of bexpr * bexpr |  Eq of bexpr * bexpr
             | B of bool | D of int

let integerP : bexpr parser =
   (let* _ = char '-' in
   let* x = natural in pure (D (-x)))
   <|>
     (let* x = natural in pure (D x))
  
let boolP : bexpr parser =
   (let* x = char 'T' in pure (B true))
   <|>
   (let* x = char 'F' in pure (B false))
  
let constP : bexpr parser =
  integerP <|> boolP
  
let rec bexpr() =
  (let* _ = ws in
   let* x = constP in
   let* _ = ws in
   let* _ = keyword "and" in
   let* _ = ws in
   let* y=bexpr() in
   let* _ = ws in
   pure (And (x, y)))
  <|>
  (let* _ = ws in
   let* x = constP in
   let* _ = ws in
   let* _ = keyword "or" in
   let* _ = ws in
   let* y=bexpr() in
   let* _ = ws in
   pure (Or (x,y)))
  <|>
  (let* _ = ws in
   let* x = constP in
   let* _ = ws in
   let* _ = keyword "eq" in
   let* _ = ws in
   let* y=bexpr() in
   let* _ = ws in
   pure (Eq (x,y)))
  <|>
    (let* _ = ws in
     let* v = constP in
     let* _ = ws in
     pure (v))

 let rec beval_step (x:bexpr) : bexpr option =
   match x with
     
  | And (B v1,B v2) -> Some (B (v1 && v2))
  | And (D _ ,B _) -> None
  | And (B _,D _) -> None
  | And (B v1,e2) -> (match beval_step e2 with
                     None -> None
                    |Some e2' -> Some (And(B v1,e2')))
  | And (D v1,e2) -> (match beval_step e2 with
                     None -> None
                    |Some e2' -> Some (And(D v1,e2')))
  | And (e1,e2) -> (match beval_step e1 with
                     None -> None
                    |Some e1' -> Some (And(e1',e2)))
  | Or (B v1,B v2) -> Some (B (v1 || v2))
  | Or (D _ ,B _) -> None
  | Or (B _,D _) -> None
  | Or (B v1,e2) -> (match beval_step e2 with
                     None -> None
                    |Some e2' -> Some (Or(B v1,e2')))
  | Or (D v1,e2) -> (match beval_step e2 with
                     None -> None
                    |Some e2' -> Some (Or(D v1,e2')))
  | Or (e1,e2) -> (match beval_step e1 with
                     None -> None
                    |Some e1' -> Some (Or(e1',e2)))
  | Eq (B v1,B v2) -> Some (B (v1 = v2))
  | Eq (D v1 , D v2) -> Some (B (v1 = v2))
  | Eq (B _,D _) -> None
  | Eq (D _,B _) -> None
  | Eq (B v1,e2) -> (match beval_step e2 with
                     None -> None
                    |Some e2' -> Some (Eq(B v1,e2')))
  | Eq (D v1,e2) -> (match beval_step e2 with
                     None -> None
                    |Some e2' -> Some (Eq(D v1,e2')))
  | Eq (e1,e2) -> (match beval_step e1 with
                     None -> None
                    |Some e1' -> Some (Eq(e1',e2)))
                             
let rec beval (x:bexpr) (n:int): bexpr option =
  if n<=0 then Some x else match beval_step x with
                             None -> None
                            |Some x' -> beval x' (n-1)

(* optimized *)
                                      

let rec beval_step' (x:bexpr) : bexpr option =
  match x with
  | And (B false, _ ) -> Some (B false)
  | And (B true,B v2) -> Some (B v2)
  | And (B true,e2) -> (match beval_step' e2 with
                        |Some e2' -> Some (And (B true, e2'))
                        | _ -> None)                 
  | And (D _ ,_) -> None
  | And (_,D _) -> None
  | And (e1,e2) -> (match beval_step' e1 with
                     None -> None
                    |Some e1' -> Some (And(e1',e2)))
  | Or (B true, _) -> Some (B true)
  | Or (B false,B v2) -> Some (B v2)
  | Or (B false,e2) -> (match beval_step' e2 with
                        |Some e2' -> Some (Or (B false, e2'))
                        |_ -> None)                 
  | Or (D _ ,_) -> None
  | Or (_,D _) -> None
  | Or (e1,e2) -> (match beval_step e1 with
                     None -> None
                    |Some e1' -> Some (Or(e1',e2)))
  | Eq (B v1,B v2) -> Some (B (v1 = v2))
  | Eq (D v1 , D v2) -> Some (B (v1 = v2))
  | Eq (B _,D _) -> None
  | Eq (D _,B _) -> None
  | Eq (B v1,e2) -> (match beval_step' e2 with
                     None -> None
                    |Some e2' -> Some (Eq(B v1,e2')))
  | Eq (D v1,e2) -> (match beval_step' e2 with
                     None -> None
                    |Some e2' -> Some (Eq(D v1,e2')))
  | Eq (e1,e2) -> (match beval_step' e1 with
                     None -> None
                    |Some e1' -> Some (Eq(e1',e2)))
                             
let rec beval' (x:bexpr) (n:int): bexpr option =
  if n<=0 then Some x else match beval_step' x with
                             None -> None
                            |Some x' -> beval' x' (n-1)
                                      
  
  
(* <expr> ::=  <term> + <expr>   | <term> - <expr>  | <term>
   <term> ::= nat | var
 *)

  type expr_v = Add of expr_v * expr_v | Sub of expr_v *expr_v
                |  D of int | V of string

                                      
  type mem = (string*int) list 



let integer : int parser =
   (let* _ = char '-' in
   let* x = natural in pure  (-x))
   <|>
     (let* x = natural in pure x)

let variable : string parser =
   (let*  x= many1 (satisfy (fun c -> is_alpha c))in
   pure  (implode x))

let base : expr_v parser =  
    (let* _ = ws in
     let* v = integer  in
     let* _ = ws in
     pure (D v)) <|>
      (let* _ = ws in
     let* v = variable  in
     let* _ = ws in
     pure (V v))

  

let rec expr_v() =
  (let* _ = ws in
   let* x = base in
   let* _ = ws in
   let* _ = char '+' in
   let* _ = ws in
   let* y=expr_v() in
   let* _ = ws in
   pure (Add (x, y)))
  <|>
  (let* _ = ws in
   let* x = base in
   let* _ = ws in
   let* _ = char '-' in
   let* _ = ws in
   let* y=expr_v() in
   let* _ = ws in
   pure (Sub (x,y)))
  <|>
    (let* _ = ws in
     let* v = base  in
     let* _ = ws in
     pure v)


let rec fetch (s:string) (m:mem) : int =
  match m with
    (x,v)::xs -> if s=x then v else fetch s xs 
  

let rec eval_step_s (x:expr_v) (m:mem): expr_v =
  match x with
  | V v1 -> D (fetch v1 m)
  | Add (D v1,D v2) -> D(v1+v2)
  | Sub (D v1,D v2) -> D(v1-v2)
  | Add (D v1,e2) -> let e2' = eval_step_s e2 m in Add(D v1,e2')
  | Sub (D v1,e2) -> let e2' = eval_step_s e2 m in Sub(D v1,e2')
  | Add (V v1,e2) -> let v2 = fetch v1 m  in Add(D v2,e2)
  | Sub (V v1,e2) -> let v2 = fetch v1 m in Sub(D v2,e2)

                                             
let rec eval_s (x:expr_v) (n:int) (m:mem): expr_v =
  if n<=0 then x else (let y = eval_step_s x m in (eval_s y (n-1) m))

let interp (s:string) (m:mem) (n:int) :expr_v =
  match (parse (expr_v()) s)  with
  Some (x,[]) -> eval_s x n m

  
let m = [("X",1);("Y",2);("W",3);("Z",4)] 
  
                             
