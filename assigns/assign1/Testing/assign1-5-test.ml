(* ****** ****** *)
#use "./../MySolution/assign1-5.ml";;
(* ****** ****** *)
let () =
assert(string_longest_ascend "1324561111" = "13456");;
let () =
assert(string_longest_ascend "1234561111" = "123456");;
let () =
assert(string_longest_ascend "1234511111" = "111111");;
(* ****** ****** *)
let () =
print_string("Assign1-5-test passed!\n");;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign1-5-test.sml] *)
