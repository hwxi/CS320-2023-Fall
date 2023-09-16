(* ****** ****** *)
#use "./../MySolution/assign1-6.ml";;
(* ****** ****** *)
let () =
assert(string_avoid_1324("12345") = true);;
let () =
assert(string_avoid_1324("54321") = true);;
(* ****** ****** *)
let () =
assert(string_avoid_1324("123465789") = false);;
(* ****** ****** *)
let () = print_string("Assign1-6-test passed!\n");;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign1-6-test.sml] *)
