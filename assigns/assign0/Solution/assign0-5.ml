(* ****** ****** *)
#use "./../assign0.ml";;
(* ****** ****** *)

let
stringrev(cs) =
let
len = string_length(cs) in
string_init len
(fun i -> string_get(cs, len-1-i))

(* ****** ****** *)

let myans1 = stringrev("abcdefgh")
let myans2 = stringrev("0123456789")
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign0-5.ml] *)
