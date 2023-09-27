(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let
list_x2foreach
(xs: 'a list)
(ys: 'b list)
(work: 'a -> 'b -> unit): unit =
list_foreach(xs)
(fun x -> list_foreach(ys)(fun y -> work x y))
;;
(* ****** ****** *)

let
list_cross
(xs: 'a list)
(ys: 'b list): ('a * 'b) list =
list_make_fwork
(fun work ->
 list_x2foreach(xs)(ys)(fun x y -> work(x, y)))
;;
(* ****** ****** *)

(* end of [lecture-09-28-cross_list.ml] *)  
