#use "./MyOCaml.ml"

type expr =
  | Add of expr * expr
  | Dig of int

let rec parser_expr () =
  (let* x = natural       in
   let* _ = whitespaces   in
   let* _ = char '+'      in
   let* _ = whitespaces   in
   let* y = parser_expr () in
   pure(Add(Dig(x), y)))
  <|>
  (let* x = natural in
   if (0 <= x) && (x <= 9) then
     pure(Dig x)
   else fail)

let parse_expr e =
  string_parse (parser_expr ()) e

