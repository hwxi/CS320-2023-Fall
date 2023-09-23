(* ****** ****** *)
#use "./../../MySolution/OCaml/assign2-3.ml";;
(* ****** ****** *)
#use "./../../../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)
let
list_iforeach =
fun xs -> foldleft_to_iforeach(list_foldleft)(xs)
;;
let ixs =
list_make_fwork
(
fun work ->
list_iforeach([1;2;3;4;5])(fun i x -> work(i, x)))
;;
(* ****** ****** *)
let () =
assert
(
list_forall
(ixs)(fun ix -> let (i, x) = ix in i+1 = x));;
(* ****** ****** *)
let () = print_string("Assign2-3-test passed!\n");;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign2-3-test.sml] *)
