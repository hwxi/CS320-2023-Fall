(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let rec
list_m2foreach
(xs0: 'a list)
(ys0: 'a list)
(pick:
 'a -> 'a -> bool)
(work: 'a -> unit): unit =
(
match xs0, ys0 with
| [], _ -> list_foreach(ys0)(work)
| _, [] -> list_foreach(xs0)(work)
| x1 :: xs1, y1 :: ys1 ->
 if pick x1 y1
 then (work(x1); list_m2foreach(xs1)(ys0)(pick)(work))
 else (work(y1); list_m2foreach(xs0)(ys1)(pick)(work))
)
;;
(* ****** ****** *)

let
list_merge
(xs0: 'a list)
(ys0: 'a list)
(pick:
 'a -> 'a -> bool): 'a list =
list_make_fwork
(fun work -> list_m2foreach(xs0)(ys0)(pick)(work))

(* ****** ****** *)

let
list_append(xs)(ys) = list_merge(xs)(ys)(fun x y -> true)
;;
(* ****** ****** *)

(* end of [lecture-09-28-merge_list.ml] *)  
