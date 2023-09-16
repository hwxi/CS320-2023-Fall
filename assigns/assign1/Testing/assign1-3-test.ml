(* ****** ****** *)
#use "./../MySolution/assign1-3.ml";;
(* ****** ****** *)
let () =
assert(string_avoid_132("12345") = true);;
let () =
assert(string_avoid_132("54321") = true);;
(* ****** ****** *)
let () =
assert(string_avoid_132("123465789") = false);;
(* ****** ****** *)
let () = print_string("Assign1-3-test passed!\n");;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign1-3-test.sml] *)
