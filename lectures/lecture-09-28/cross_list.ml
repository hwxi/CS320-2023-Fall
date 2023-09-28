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

let xs = [1;2;3;4;5]
let ys = [1,2;3,4;5,6]
let xys = list_cross(xs)(ys)
let ( ) =
list_foreach(xys)
(fun(x,y) -> Printf.printf
    ("(x, y) = (%i, (%i, %i))\n")
    (x) (let (y1, y2) = y in y1) (let (y1, y2) = y in y2))

(* ****** ****** *)

(* end of [lecture-09-28-cross_list.ml] *)  
