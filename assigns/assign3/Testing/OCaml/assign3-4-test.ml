(* ****** ****** *)
#use "./../../MySolution/OCaml/assign3-4.ml";;
(* ****** ****** *)

let () =
assert([] = list_of_buddies(""));;
let () =
assert
(List.length(list_of_buddies("love")) = 4*25);;
let () =
assert
(List.length(list_of_buddies("loveless")) = 8*25);;

(* ****** ****** *)

let () = print_string("Assign3-4-test passed!\n")
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign3-4-test.sml] *)
