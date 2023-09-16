(* ****** ****** *)
#use "./../MySolution/assign1-2.ml";;
(* ****** ****** *)
let () =
assert(string_merge("")("") = "")
(* ****** ****** *)
let () =
assert(string_merge("135")("") = "135")
let () =
assert(string_merge("")("2468") = "2468")
(* ****** ****** *)
let () =
assert(string_merge("135")("2468") = "1234568")
(* ****** ****** *)
let () =
assert(string_merge("abcde")("1234") = "1234abcde")
(* ****** ****** *)
let () =
print_string("Assign1-2-test passed!\n")
(* ****** ****** *)
;;(* end-of-let *)

(* ****** ****** *)

(* end of [CS320-2023-Fall-assign1-2-test.sml] *)
