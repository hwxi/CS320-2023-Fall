#use "./../../../classlib/OCaml/MyOCaml.ml";;

(*

Please implement the interp function following the
specifications described in CS320_Fall_2023_Project-1.pdf

Notes:
1. You are only allowed to use library functions defined in MyOCaml.ml
   or ones you implement yourself.
2. You may NOT use OCaml standard library functions directly.

*)

(* abstract syntax tree of interp1 *)
type const =
  | Int of int
  | Bool of bool
  | Unit

type com =
  | Push of const | Pop | Trace
  | Add | Sub | Mul | Div
  | And | Or | Not
  | Lt | Gt

type coms = com list

(* ------------------------------------------------------------ *)

(* parsers for interp1 *)
let parse_nat = 
  let* n = natural << whitespaces in pure n

let parse_int =
  (let* n = parse_nat in pure (Int n)) <|>
  (keyword "-" >> let* n = parse_nat in pure (Int (-n)))

let parse_bool =
  (keyword "True" >> pure (Bool true)) <|>
  (keyword "False" >> pure (Bool false))

let parse_unit =
  keyword "Unit" >> pure Unit

let parse_const =
  parse_int <|>
  parse_bool <|>
  parse_unit

let parse_com = 
  (keyword "Push" >> parse_const >>= fun c -> pure (Push c)) <|>
  (keyword "Pop" >> pure Pop) <|>
  (keyword "Trace" >> pure Trace) <|>
  (keyword "Add" >> pure Add) <|>
  (keyword "Sub" >> pure Sub) <|>
  (keyword "Mul" >> pure Mul) <|>
  (keyword "Div" >> pure Div) <|>
  (keyword "And" >> pure And) <|>
  (keyword "Or" >> pure Or) <|>
  (keyword "Not" >> pure Not) <|>
  (keyword "Lt" >> pure Lt) <|>
  (keyword "Gt" >> pure Gt)

let parse_coms = many (parse_com << keyword ";")

(* ------------------------------------------------------------ *)

(* interpreter *)

type stack = const list
type trace = string list
type prog = coms

let rec str_of_nat (n : int) : string =
  let d = n mod 10 in 
  let n0 = n / 10 in
  let s = str (chr (d + ord '0')) in 
  if 0 < n0 then
    string_append (str_of_nat n0) s
  else s

let str_of_int (n : int) : string = 
  if n < 0 then
    string_append "-" (str_of_nat (-n))
  else str_of_nat n

let toString (c : const) : string =
  match c with
  | Int i -> str_of_int i
  | Bool true -> "True"
  | Bool false -> "False"
  | Unit -> "Unit"

let rec eval (s : stack) (t : trace) (p : prog) : trace =
  match p with
  (* termination state returns the trace *)
  | [] -> t
  | Push c :: p0 (* PushStack *) -> eval (c :: s) t p0
  | Pop :: p0 ->
    (match s with
     | _ :: s0 (* PopStack *) -> eval s0 t p0
     | []      (* PopError *) -> eval [] ("Panic" :: t) [])
  | Trace :: p0 ->
    (match s with
     | c :: s0 (* TraceStack *) -> eval (Unit :: s0) (toString c :: t) p0
     | []      (* TraceError *) -> eval [] ("Panic" :: t) [])
  | Add :: p0 ->
    (match s with
     | Int i :: Int j :: s0 (* AddStack *)  -> eval (Int (i + j) :: s0) t p0
     | _ :: _ :: s0         (* AddError1 *) -> eval [] ("Panic" :: t) []
     | []                   (* AddError2 *) -> eval [] ("Panic" :: t) []
     | _ :: []              (* AddError3 *) -> eval [] ("Panic" :: t) [])
  | Sub :: p0 ->
    (match s with
     | Int i :: Int j :: s0 (* SubStack *)  -> eval (Int (i - j) :: s0) t p0
     | _ :: _ :: s0         (* SubError1 *) -> eval [] ("Panic" :: t) []
     | []                   (* SubError2 *) -> eval [] ("Panic" :: t) []
     | _ :: []              (* SubError3 *) -> eval [] ("Panic" :: t) [])
  | Mul :: p0 ->
    (match s with
     | Int i :: Int j :: s0 (* MulStack *)  -> eval (Int (i * j) :: s0) t p0
     | _ :: _ :: s0         (* MulError1 *) -> eval [] ("Panic" :: t) []
     | []                   (* MulError2 *) -> eval [] ("Panic" :: t) []
     | _ :: []              (* MulError3 *) -> eval [] ("Panic" :: t) [])
  | Div :: p0 ->
    (match s with
     | Int i :: Int 0 :: s0 (* DivError0 *) -> eval [] ("Panic" :: t) []
     | Int i :: Int j :: s0 (* DivStack *)  -> eval (Int (i / j) :: s0) t p0
     | _ :: _ :: s0         (* DivError1 *) -> eval [] ("Panic" :: t) []
     | []                   (* DivError2 *) -> eval [] ("Panic" :: t) []
     | _ :: []              (* DivError3 *) -> eval [] ("Panic" :: t) [])
  | And :: p0 ->
    (match s with
     | Bool a :: Bool b :: s0 (* AndStack *)  -> eval (Bool (a && b) :: s0) t p0
     | _ :: _ :: s0           (* AndError1 *) -> eval [] ("Panic" :: t) []
     | []                     (* AndError2 *) -> eval [] ("Panic" :: t) []
     | _ :: []                (* AndError3 *) -> eval [] ("Panic" :: t) [])
  | Or :: p0 ->
    (match s with
     | Bool a :: Bool b :: s0 (* OrStack *)  -> eval (Bool (a || b) :: s0) t p0
     | _ :: _ :: s0           (* OrError1 *) -> eval [] ("Panic" :: t) []
     | []                     (* OrError2 *) -> eval [] ("Panic" :: t) []
     | _ :: []                (* OrError3 *) -> eval [] ("Panic" :: t) [])
  | Not :: p0 ->
    (match s with
     | Bool a :: s0 (* NotStack  *) -> eval (Bool (not a) :: s0) t p0
     | _ :: s0      (* NotError1 *) -> eval [] ("Panic" :: t) []
     | []           (* NotError2 *) -> eval [] ("Panic" :: t) [])
  | Lt :: p0 ->
    (match s with
     | Int i :: Int j :: s0 (* LtStack *)  -> eval (Bool (i < j) :: s0) t p0
     | _ :: _ :: s0         (* LtError1 *) -> eval [] ("Panic" :: t) []
     | []                   (* LtError2 *) -> eval [] ("Panic" :: t) []
     | _ :: []              (* LtError3 *) -> eval [] ("Panic" :: t) [])
  | Gt :: p0 ->
    (match s with
     | Int i :: Int j :: s0 (* GtStack *)  -> eval (Bool (i > j) :: s0) t p0
     | _ :: _ :: s0         (* GtError1 *) -> eval [] ("Panic" :: t) []
     | []                   (* GtError2 *) -> eval [] ("Panic" :: t) []
     | _ :: []              (* GtError3 *) -> eval [] ("Panic" :: t) [])

(* ------------------------------------------------------------ *)

(* putting it all together [input -> parser -> eval -> output] *)

let interp (s : string) : string list option =
  match string_parse (whitespaces >> parse_coms) s with
  | Some (p, []) -> Some (eval [] [] p)
  | _ -> None

(* ------------------------------------------------------------ *)

(* interp from file *)

let read_file (fname : string) : string =
  let fp = open_in fname in
  let s = string_make_fwork (fun work ->
      try
        while true do
          work (input_char fp)
        done
      with _ -> ())
  in
  close_in fp; s

let interp_file (fname : string) : string list option =
  let src = read_file fname in
  interp src
