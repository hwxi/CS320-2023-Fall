(* ****** ****** *)
#use "./../../MySolution/OCaml/assign4-1.ml";;
(* ****** ****** *)
let eps = 1E-6
(* ****** ****** *)
exception Empty
(* ****** ****** *)
let uncons(fxs) =
match fxs() with
  | StrNil -> raise Empty
  | StrCons(x1, fxs) -> (x1, fxs)
(* ****** ****** *)
let fxs = the_ln2_stream
let (x1, fxs) = uncons(fxs)
let (x2, fxs) = uncons(fxs)
let (x3, fxs) = uncons(fxs)
let (x4, fxs) = uncons(fxs)
let (x5, fxs) = uncons(fxs)
(* ****** ****** *)
let () = assert(abs_float(x1 -. 1.0) < eps)
let () = assert(abs_float(x2 -. 0.5) < eps)
let () = assert(abs_float(x3 -. 0.8333333) < eps)
let () = assert(abs_float(x4 -. 0.5833333) < eps)
let () = assert(abs_float(x5 -. 0.7833333) < eps)
(* ****** ****** *)
let () = print_string("Assign4-1-test passed!\n")
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign4-1-test.sml] *)
