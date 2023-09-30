(* ****** ****** *)
#use "./../../MySolution/OCaml/assign3-2.ml";;
(* ****** ****** *)
let xs = [1;2;3;4;5];;
let xss = list_subsets(xs);;
(* ****** ****** *)
let res = list_concat(xss);;
let res = List.sort(fun x1 x2 -> x1 - x2)(res);;
(* ****** ****** *)
let ( ) =
assert
(
res =
list_make_fwork
(fun work ->
     int1_foreach(5)
     (fun i -> int1_foreach(16)(fun _ -> work(i+1)))));;
(* ****** ****** *)
let ys = [1;2;3;4;5;6];;
let yss = list_subsets(ys);;
(* ****** ****** *)
let res = list_concat(yss);;
let res = List.sort(fun y1 y2 -> y1 - y2)(res);;
(* ****** ****** *)
let ( ) =
assert
(
res =
list_make_fwork
(fun work ->
     int1_foreach(6)
     (fun i -> int1_foreach(32)(fun _ -> work(i+1)))));;
(* ****** ****** *)
let () = print_string("Assign3-2-test passed!\n")
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign3-2-test.sml] *)
