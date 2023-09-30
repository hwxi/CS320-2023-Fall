(* ****** ****** *)
#use "./../../MySolution/OCaml/assign3-5.ml";;
(* ****** ****** *)
let
the_solutions = queen8_puzzle_solve();;
(* ****** ****** *)

let () =
assert(List.length(the_solutions) = 92);;
(* ****** ****** *)

let
board_sum(bd: board_t): int =
foreach_to_foldleft
(board_foreach)(bd)(0)(fun res p -> res+p)

(* ****** ****** *)

let () = assert
(
list_forall
(the_solutions)
(
fun bd ->
let sum = board_sum(bd) in sum = 28 || sum = 36));;

(* ****** ****** *)

let () = print_string("Assign3-5-test passed!\n")
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign3-5-test.sml] *)
