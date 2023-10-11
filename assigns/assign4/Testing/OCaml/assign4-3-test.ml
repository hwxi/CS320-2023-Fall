(* ****** ****** *)
#use "./../../MySolution/OCaml/assign4-3.ml";;
(* ****** ****** *)
let xs0 = GTnil
let xs1 = GTcons(1, [])
let xs2 = GTcons(2, [])
let xs3 = GTcons(3, [xs1;xs2])
let xs4 = GTcons(4, [xs1;xs2;xs3])
let xs5 = GTcons(5, [xs1;xs2;xs3;xs4])
;;
(* ****** ****** *)
let ys0_dfs = gtree_streamize_dfs(xs5)
let ys1_bfs = gtree_streamize_bfs(xs5)
(* ****** ****** *)
let ys0_lst =
list_make_fwork
(fun work -> stream_foreach(ys0_dfs)(work))
let ys1_lst =
list_make_fwork
(fun work -> stream_foreach(ys1_bfs)(work))
let () = assert
(ys0_lst = [5; 1; 2; 3; 1; 2; 4; 1; 2; 3; 1; 2])
let () = assert
(ys1_lst = [5; 1; 2; 3; 4; 1; 2; 1; 2; 3; 1; 2])
(* ****** ****** *)
let () = print_string("Assign4-3-test passed!\n")
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign4-3-test.sml] *)
