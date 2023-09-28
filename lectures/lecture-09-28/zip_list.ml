(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

(*
 A "cheap"
 implementation
 that is NOT tail-recursive
*)
let rec
list_zip2
(xs: 'a list)
(ys: 'b list): ('a * 'b) list =
(
match xs, ys with
| [], _ -> []
| _, [] -> []
| (x1 :: xs), (y1 :: ys) ->
  (x1, y1) :: list_zip2(xs)(ys) )

(* ****** ****** *)

(*
This is a tail-recursive implementation
*)
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
list_zip2
(xs: 'a list)
(ys: 'b list): ('a * 'b) list =
list_make_fwork
(fun work ->
 list_z2foreach(xs)(ys)(fun x y -> work(x, y)))
;;
(* ****** ****** *)

let xs = [1;2;3;4;5]
let ys = ["1";"2";"3";"4";"5"]
let () =
list_foreach
(list_zip2(xs)(ys))
(fun(x, y) -> Printf.printf "(x, y) = (%i, \"%s\")\n" x y)

(* ****** ****** *)

(* end of [lecture-09-28-zip_list.ml] *)  
