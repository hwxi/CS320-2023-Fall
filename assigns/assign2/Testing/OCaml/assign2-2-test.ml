(* ****** ****** *)
#use "./../../MySolution/OCaml/assign2-2.ml";;
(* ****** ****** *)
let xs0 = MyNil
let xs1 = MyCons(10, xs0)
let xs2 = MySnoc(xs0, -10)
let xs3 = MyAppend2(xs1, xs2)
let xs4 = MyReverse(xs3)
let xs5 = MyAppend2(xs4, xs4)
let xs6 = MyAppend2(xs5, xs5)
let xs7 = MyAppend2(xs6, xs6)
;;
(* ****** ****** *)
let ( ) = assert(10 = mylist_get_at(xs7)(1))
let ( ) = assert(10 = mylist_get_at(xs7)(3))
let ( ) = assert(10 = mylist_get_at(xs7)(5))
let ( ) = assert(10 = mylist_get_at(xs7)(7))
;;
(* ****** ****** *)
let ( ) = assert(10 = -mylist_get_at(xs7)(0))
let ( ) = assert(10 = -mylist_get_at(xs7)(2))
let ( ) = assert(10 = -mylist_get_at(xs7)(4))
let ( ) = assert(10 = -mylist_get_at(xs7)(6))
;;
(* ****** ****** *)
let () = print_string("Assign2-2-test passed!\n");;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign2-2-test.sml] *)
