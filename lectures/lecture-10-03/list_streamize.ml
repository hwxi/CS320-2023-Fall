(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let rec
list_streamize
(xs: 'a list): 'a stream = fun () ->
match xs with
| [] -> StrNil
| (x1 :: xs) -> StrCons(x1, list_streamize(xs))
;;
(* ****** ****** *)

(* end of [list_streamize.ml] *)
