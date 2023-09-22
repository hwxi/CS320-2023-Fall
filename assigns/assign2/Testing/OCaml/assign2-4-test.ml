(* ****** ****** *)
#use "./../../MySolution/OCaml/assign2-4.ml";;
(* ****** ****** *)
let () =
assert
("abc" =
 string_sepjoin_list("")(["a";"b";"c"]));;
(* ****** ****** *)
let () =
assert
("a;b;c" =
 string_sepjoin_list(";")(["a";"b";"c"]));;
(* ****** ****** *)
let () = print_string("Assign2-4-test passed!\n");;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign2-4-test.sml] *)
