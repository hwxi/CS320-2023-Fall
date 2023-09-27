(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let rec
list_zip
(xs: 'a list)
(ys: 'b list): ('a * 'b) list =
(
match xs, ys with
| [], _ -> []
| _, [] -> []
| (x1 :: xs), (y1 :: ys) ->
  (x1, y1) :: list_zip(xs)(ys) )

(* ****** ****** *)

let rec
list_z2foreach
(xs: 'a list)
(ys: 'b list)
(work: 'a -> 'b -> unit): unit =
(
match xs, ys with
| [], _ -> ()
| _, [] -> ()
| (x1 :: xs), (y1 :: ys) ->
  (work(x1)(y1); list_z2foreach(xs)(ys)(work)))
;;
(* ****** ****** *)

let
list_zip
(xs: 'a list)
(ys: 'b list): ('a * 'b) list =
list_make_fwork
(fun work ->
 list_z2foreach(xs)(ys)(fun x y -> work(x, y)))
;;
(* ****** ****** *)

(* end of [lecture-09-28-zip_list.ml] *)  
