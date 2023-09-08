#use "./../MySolution/assign0-5.ml";;

(* ****** ****** *)

let () = assert(stringrev("") = "")
let () = assert(stringrev("1") = "1")
let () = assert(stringrev("12") = "21")
let () = assert(stringrev("123") = "321")
let () = assert(stringrev("1234") = "4321")
let () = assert(stringrev("12345") = "54321")

(* ****** ****** *)
let () = print_string("Assign0-5-test passed!\n")
(* ****** ****** *)
;;
(* ****** ****** *)

(* end of [CS320-2023-Spring-assign0-5-test.sml] *)
