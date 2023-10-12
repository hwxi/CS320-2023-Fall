(* ****** ****** *)
#use "./../../MySolution/OCaml/assign4-4.ml";;
(* ****** ****** *)

let perm4 =
list_permute([1;2;3;4]);;
let perm5 =
list_permute([1;2;3;4;5]);;
let perm10 =
list_permute([1;2;3;4;5;6;7;8;9;10]);;
let perm20 = list_permute
([1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20]);;

(* ****** ****** *)
let () =
assert
(
list_make_fwork(fun work -> stream_foreach(perm4)(work))
=
[[1; 2; 3; 4]; [1; 2; 4; 3]; [1; 3; 2; 4]; [1; 3; 4; 2]; [1; 4; 2; 3];
 [1; 4; 3; 2]; [2; 1; 3; 4]; [2; 1; 4; 3]; [2; 3; 1; 4]; [2; 3; 4; 1];
 [2; 4; 1; 3]; [2; 4; 3; 1]; [3; 1; 2; 4]; [3; 1; 4; 2]; [3; 2; 1; 4];
 [3; 2; 4; 1]; [3; 4; 1; 2]; [3; 4; 2; 1]; [4; 1; 2; 3]; [4; 1; 3; 2];
 [4; 2; 1; 3]; [4; 2; 3; 1]; [4; 3; 1; 2]; [4; 3; 2; 1]
]
)
(* ****** ****** *)
let () =
assert(foreach_to_length(stream_foreach)(perm5) = 120);;
let () =
assert(foreach_to_length(stream_foreach)(perm10) = 1*2*3*4*5*6*7*8*9*10);;
(* ****** ****** *)

let () = print_string("Assign4-4-test passed!\n")
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign4-4-test.sml] *)
