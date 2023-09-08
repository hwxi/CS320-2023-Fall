(* ****** ****** *)

#use "./../assign0.ml";;

(* ****** ****** *)

let rec
fact(x: int): int =
if x > 0 then fact(x-1) * x  else 1
;;

(* ****** ****** *)

let rec
myloop(x: int): int =
if fact(x) = 0 then x else myloop(x+1)

(* ****** ****** *)
let myans = myloop(0)
(* ****** ****** *)
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign0-1.ml] *)
