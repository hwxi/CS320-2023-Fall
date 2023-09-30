(* ****** ****** *)
#use "./../../MySolution/OCaml/assign3-3.ml";;
(* ****** ****** *)
let xs =
[1;2;3;4;5];;
let xss =
list_nchoose(xs)(2);;
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
     (fun i -> int1_foreach(4)(fun _ -> work(i+1)))));;
(* ****** ****** *)
let ys =
[1;2;3;4;5;6];;
let yss =
list_nchoose(ys)(3);;
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
     (fun i -> int1_foreach(10)(fun _ -> work(i+1)))));;
(* ****** ****** *)
let () = print_string("Assign3-3-test passed!\n")
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign3-3-test.sml] *)
