(* ****** ****** *)
#use "./../../MySolution/OCaml/assign4-2.ml";;
(* ****** ****** *)
exception Empty
(* ****** ****** *)
let uncons(fxs) =
match fxs() with
  | StrNil -> raise Empty
  | StrCons(xy1, fxs) -> (xy1, fxs)
(* ****** ****** *)
let
the_squares_stream =
let rec
helper
(cxs
:(int*int)strcon)
(tot: int)(sum: int): int strcon =
match cxs with
|
StrNil -> raise Empty
|
StrCons((x, y), fxs) ->
if
x + y <= sum
then (Printf.printf("(x, y) = (%i, %i)\n") (x)(y); helper(fxs())(tot+1)(sum))
else StrCons(tot, fun() -> helper(cxs)(tot)(sum+1)) in fun() -> helper(theNatPairs())(0)(0)
(* ****** ****** *)
let fxs =
the_squares_stream
let (x1, fxs) = uncons(fxs)
let (x2, fxs) = uncons(fxs)
let (x3, fxs) = uncons(fxs)
let (x4, fxs) = uncons(fxs)
let (x5, fxs) = uncons(fxs)
let (x6, fxs) = uncons(fxs)
(* ****** ****** *)
let () = assert(x1 = 1)
let () = assert(x2 = 3)
let () = assert(x3 = 6)
let () = assert(x4 = 10)
let () = assert(x5 = 15)
let () = assert(x6 = 21)
(* ****** ****** *)
let () = print_string("Assign4-2-test passed!\n")
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign4-2-test.sml] *)
