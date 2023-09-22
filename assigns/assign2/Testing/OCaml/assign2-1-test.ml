(* ****** ****** *)
#use "./../../MySolution/OCaml/assign2-1.ml";;
(* ****** ****** *)
let xs0 = MyNil
let xs1 = MyCons(1, xs0)
let xs2 = MySnoc(xs0, 1)
let xs3 = MyAppend2(xs1, xs2)
let xs4 = MyReverse(xs3)
let xs5 = MyAppend2(xs4, xs4)
let xs6 = MyAppend2(xs5, xs5)
let xs7 = MyAppend2(xs6, xs6)
;;
(* ****** ****** *)
let () = assert(mylist_length(xs7) = 16)
;;
(* ****** ****** *)
let () = print_string("Assign2-1-test passed!\n")
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign2-1-test.sml] *)
