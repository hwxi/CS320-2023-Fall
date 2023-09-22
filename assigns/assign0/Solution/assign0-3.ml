(* ****** ****** *)

#use "./../assign0.ml";;

(* ****** ****** *)

let
strapp
((xs: string)
,(ys: string)) =
let m =
string_length(xs) in
let n =
string_length(ys) in
string_init (m + n)
(fun i ->
 if i < m
 then string_get(xs, i) else string_get(ys, i-m))
;;
(* ****** ****** *)

let rec
nat2str
(x: int): string =
(*
let
_ = assert(x >= 0)
in(*let*)
*)
if x < 10
then
str(chr((ord('0') + x mod 10)))
else
strapp
(nat2str(x / 10), str(chr((ord('0') + x mod 10))))
(* end-of-let *)
;;
(* ****** ****** *)

let rec
int2str(x: int) =
if x >= 0 then nat2str(x) else str('-') ^ nat2str(-x)

(* ****** ****** *)

let myans1 = int2str(-1)
let myans2 = int2str(12345)
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign0-3.ml] *)
