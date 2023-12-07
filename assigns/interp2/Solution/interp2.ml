(* open MyOCaml *)
#use "../../../classlib/OCaml/MyOCaml.ml";;

(*

Please implement the interp function following the
specifications described in CS320_Fall_2023_Project-2.pdf

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
  | Sym of string

type value =
  | VInt of int
  | VBool of bool
  | VUnit
  | VSym of string
  | VClo of string * env * coms

and com =
  | Push of const | Pop | Swap | Trace
  | Add | Sub | Mul | Div
  | And | Or | Not
  | Lt | Gt
  | Ifte of coms * coms 
  | Bind | Lookup
  | Fun of coms | Call | Ret

and coms = com list
and env = (string * value) list
and stack = value list
and trace = string list

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

let parse_sym =
  let parse_letter = satisfy char_islower in
  let parse_digit = satisfy char_isdigit in
  let* c = parse_letter in
  let* cs = many (parse_letter <|> parse_digit) in
  let s = string_make_fwork (list_foreach (c :: cs)) in
  pure (Sym s)

let parse_const =
  parse_int <|>
  parse_bool <|>
  parse_unit <|>
  parse_sym

let rec parse_com () = 
  (keyword "Push" >> parse_const >>= fun c -> pure (Push c)) <|>
  (keyword "Pop" >> pure Pop) <|>
  (keyword "Swap" >> pure Swap) <|>
  (keyword "Trace" >> pure Trace) <|>
  (keyword "Add" >> pure Add) <|>
  (keyword "Sub" >> pure Sub) <|>
  (keyword "Mul" >> pure Mul) <|>
  (keyword "Div" >> pure Div) <|>
  (keyword "And" >> pure And) <|>
  (keyword "Or" >> pure Or) <|>
  (keyword "Not" >> pure Not) <|>
  (keyword "Lt" >> pure Lt) <|>
  (keyword "Gt" >> pure Gt) <|>
  parse_ifte () <|>
  (keyword "Bind" >> pure Bind) <|>
  (keyword "Lookup" >> pure Lookup) <|>
  parse_fun () <|>
  (keyword "Call" >> pure Call) <|>
  (keyword "Return" >> pure Ret)

and parse_coms () = 
  many' (fun x -> parse_com x << keyword ";")

and parse_ifte () =
  let* _ = keyword "If" in
  let* coms1 = parse_coms () in
  let* _ = keyword "Else" in
  let* coms2 = parse_coms () in
  let* _ = keyword "End" in
  pure (Ifte (coms1, coms2))

and parse_fun () =
  let* _ = keyword "Fun" in
  let* coms = parse_coms () in
  let* _ = keyword "End" in
  pure (Fun coms)

(* ------------------------------------------------------------ *)

(* interpreter *)

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

let toString (v : value) : string =
  match v with
  | VInt i -> str_of_int i
  | VBool true -> "True"
  | VBool false -> "False"
  | VUnit -> "Unit"
  | VSym x -> x
  | VClo (x, _, _) -> string_concat_list ["Fun<"; x; ">"]

let value_of_const (c : const) : value =
  match c with
  | Int i -> VInt i
  | Bool b -> VBool b
  | Unit -> VUnit
  | Sym s -> VSym s

let find_sym (x : string) (e : env) : value option =
  let rec loop e =
    match e with
    | (y, v) :: e0 ->
      if x = y then Some v else loop e0
    | [] -> None
  in loop e

let rec eval (s : stack) (t : trace) (e : env) (p : coms) : trace =
  match p with
  (* termination state returns the trace *)
  | [] -> t
  | Push c :: p0 (* PushStack *) -> eval (value_of_const c :: s) t e p0
  | Pop :: p0 ->
    (match s with
     | _ :: s0 (* PopStack *) -> eval s0 t e p0
     | []      (* PopError *) -> eval [] ("Panic" :: t) e [])
  | Swap :: p0 ->
    (match s with
     | c1 :: c2 :: s0 (* SwapStack *)  -> eval (c2 :: c1 :: s0) t e p0
     | _ :: s0        (* SwapError1 *) -> eval [] ("Panic" :: t) e []
     | []             (* SwapError2 *) -> eval [] ("Panic" :: t) e [])
  | Trace :: p0 ->
    (match s with
     | c :: s0 (* TraceStack *) -> eval (VUnit :: s0) (toString c :: t) e p0
     | []      (* TraceError *) -> eval [] ("Panic" :: t) e [])
  | Add :: p0 ->
    (match s with
     | VInt i :: VInt j :: s0 (* AddStack *)  -> eval (VInt (i + j) :: s0) t e p0
     | _ :: _ :: s0           (* AddError1 *) -> eval [] ("Panic" :: t) e []
     | []                     (* AddError2 *) -> eval [] ("Panic" :: t) e []
     | _ :: []                (* AddError3 *) -> eval [] ("Panic" :: t) e [])
  | Sub :: p0 ->
    (match s with
     | VInt i :: VInt j :: s0 (* SubStack *)  -> eval (VInt (i - j) :: s0) t e p0
     | _ :: _ :: s0           (* SubError1 *) -> eval [] ("Panic" :: t) e []
     | []                     (* SubError2 *) -> eval [] ("Panic" :: t) e []
     | _ :: []                (* SubError3 *) -> eval [] ("Panic" :: t) e [])
  | Mul :: p0 ->
    (match s with
     | VInt i :: VInt j :: s0 (* MulStack *)  -> eval (VInt (i * j) :: s0) t e p0
     | _ :: _ :: s0           (* MulError1 *) -> eval [] ("Panic" :: t) e []
     | []                     (* MulError2 *) -> eval [] ("Panic" :: t) e []
     | _ :: []                (* MulError3 *) -> eval [] ("Panic" :: t) e [])
  | Div :: p0 ->
    (match s with
     | VInt i :: VInt 0 :: s0 (* DivError0 *) -> eval [] ("Panic" :: t) e []
     | VInt i :: VInt j :: s0 (* DivStack *)  -> eval (VInt (i / j) :: s0) t e p0
     | _ :: _ :: s0           (* DivError1 *) -> eval [] ("Panic" :: t) e []
     | []                     (* DivError2 *) -> eval [] ("Panic" :: t) e []
     | _ :: []                (* DivError3 *) -> eval [] ("Panic" :: t) e [])
  | And :: p0 ->
    (match s with
     | VBool a :: VBool b :: s0 (* AndStack *)  -> eval (VBool (a && b) :: s0) t e p0
     | _ :: _ :: s0             (* AndError1 *) -> eval [] ("Panic" :: t) e []
     | []                       (* AndError2 *) -> eval [] ("Panic" :: t) e []
     | _ :: []                  (* AndError3 *) -> eval [] ("Panic" :: t) e [])
  | Or :: p0 ->
    (match s with
     | VBool a :: VBool b :: s0 (* OrStack *)  -> eval (VBool (a || b) :: s0) t e p0
     | _ :: _ :: s0             (* OrError1 *) -> eval [] ("Panic" :: t) e []
     | []                       (* OrError2 *) -> eval [] ("Panic" :: t) e []
     | _ :: []                  (* OrError3 *) -> eval [] ("Panic" :: t) e [])
  | Not :: p0 ->
    (match s with
     | VBool a :: s0 (* NotStack  *) -> eval (VBool (not a) :: s0) t e p0
     | _ :: s0       (* NotError1 *) -> eval [] ("Panic" :: t) e []
     | []            (* NotError2 *) -> eval [] ("Panic" :: t) e [])
  | Lt :: p0 ->
    (match s with
     | VInt i :: VInt j :: s0 (* LtStack *)  -> eval (VBool (i < j) :: s0) t e p0
     | _ :: _ :: s0           (* LtError1 *) -> eval [] ("Panic" :: t) e []
     | []                     (* LtError2 *) -> eval [] ("Panic" :: t) e []
     | _ :: []                (* LtError3 *) -> eval [] ("Panic" :: t) e [])
  | Gt :: p0 ->
    (match s with
     | VInt i :: VInt j :: s0 (* GtStack *)  -> eval (VBool (i > j) :: s0) t e p0
     | _ :: _ :: s0           (* GtError1 *) -> eval [] ("Panic" :: t) e []
     | []                     (* GtError2 *) -> eval [] ("Panic" :: t) e []
     | _ :: []                (* GtError3 *) -> eval [] ("Panic" :: t) e [])
  | Ifte (coms1, coms2) :: p0 ->
    (match s with
     | VBool true  :: s0 (* ThenStack *)    -> eval s0 t e (list_append coms1 p0)
     | VBool false :: s0 (* ElseStack *)    -> eval s0 t e (list_append coms2 p0)
     | _ :: s0           (* IfElseError1 *) -> eval [] ("Panic" :: t) e []
     | []                (* IfElseError2 *) -> eval [] ("Panic" :: t) e [])
  | Bind :: p0 ->
    (match s with
     | VSym x :: v :: s0 (* BindStack *)  -> eval s0 t ((x, v) :: e) p0
     | _ :: v :: s0      (* BindError1 *) -> eval [] ("Panic" :: t) e []
     | _ :: []           (* BindError3 *) -> eval [] ("Panic" :: t) e []
     | []                (* BindError2 *) -> eval [] ("Panic" :: t) e [])
  | Lookup :: p0 ->
    (match s with
     | VSym x :: s0 -> 
       (match find_sym x e with
        | None   (* LookupError3 *) -> eval [] ("Panic" :: t) e []
        | Some v (* LookupStack *)  -> eval (v :: s0) t e p0)
     | _ :: s0   (* LookupError1 *) -> eval [] ("Panic" :: t) e []
     | []        (* LookupError2 *) -> eval [] ("Panic" :: t) e [])
  | Fun coms :: p0 -> 
    (match s with
     | VSym x :: s0 (* FunStack *)  -> eval (VClo (x, e, coms) :: s0) t e p0
     | _ :: s0      (* FunError1 *) -> eval [] ("Panic" :: t) e []
     | []           (* FunError2 *) -> eval [] ("Panic" :: t) e [])
  | Call :: p0 -> 
    (match s with
     | VClo (f, ef, coms) :: a :: s0 (* CallStack *) -> 
       eval (a :: VClo ("cc", e, p0) :: s0) t ((f, VClo (f, ef, coms)) :: ef) coms
     | _ :: [] (* CallError3 *) -> eval [] ("Panic" :: t) e []
     | _ :: s0 (* CallError1 *) -> eval [] ("Panic" :: t) e []
     | []      (* CallError2 *) -> eval [] ("Panic" :: t) e [])
  | Ret :: p0 ->
    (match s with
     | VClo (f, ef, coms) :: a :: s0 (* ReturnStack *) -> 
       eval (a :: s0) t ef coms
     | _ :: [] (* ReturnError3 *) -> eval [] ("Panic" :: t) e []
     | _ :: s0 (* ReturnError1 *) -> eval [] ("Panic" :: t) e []
     | []      (* ReturnError2 *) -> eval [] ("Panic" :: t) e [])

(* ------------------------------------------------------------ *)

(* putting it all together [input -> parser -> eval -> output] *)

let interp (s : string) : string list option =
  match string_parse (whitespaces >> parse_coms ()) s with
  | Some (p, []) -> Some (eval [] [] [] p)
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

let interp_file (fname : string) =
  let src = read_file fname in
  interp src
