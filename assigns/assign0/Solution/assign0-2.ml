(* ****** ****** *)

#use "./../assign0.ml";;

(* ****** ****** *)

(*
fun
isPrime
(n0: int): bool =
failwith "Not yet implemented!"
*)

(* ****** ****** *)

let rec
isPrime(n0: int): bool =
let rec
(* ****** ****** *)
helper(i0: int): bool =
if i0 >= n0
then true
else if (n0 mod i0) <> 0
     then helper(i0+1) else false
(* ****** ****** *)
in(*in-of-let*)
if n0 <= 1 then false else helper(2)
(* end-of-let: isPrime *)
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign0-2.ml] *)
