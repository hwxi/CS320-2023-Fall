(* ****** ****** *)
#use "./../MySolution/assign1-1.ml";;
(* ****** ****** *)
let () =
assert(intrev10(1234) = 4321)
let () =
assert(intrev10(1020304) = 4030201)
let () =
assert(intrev10(intrev10(13579)) = 13579)
(* ****** ****** *)
let () =
print_string("Assign1-1-test passed!\n")
(* ****** ****** *)
;;(* end-of-let *)

(* ****** ****** *)

(* end of [CS320-2023-Fall-assign1-1-test.sml] *)
