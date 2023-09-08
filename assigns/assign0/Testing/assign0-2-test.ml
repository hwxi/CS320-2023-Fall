(* ****** ****** *)
#use "./../MySolution/assign0-2.ml";;
(* ****** ****** *)

let () =
assert(isPrime(5) == true)
let () =
assert(isPrime(7) == true)
let () =
assert(isPrime(57) == false)
let () =
assert(isPrime(101) == true)
let () =
assert(isPrime(1001) == false)
let () =
assert(isPrime(10001) == false)

(* ****** ****** *)
let () = print_string("Assign0-2-test passed!\n")
(* ****** ****** *)
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign0-2-test.sml] *)
