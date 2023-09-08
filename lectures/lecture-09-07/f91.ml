(* ****** ****** *)

(*
 There are two recursive calls here:
 the outer one is a tail-call and the
 inner one is not.
*)
let rec
f91(x) = (* not tail-recursive *)
if x > 100 then x - 10 else f91(f91(x+11);;

(* ****** ****** *)
				   
(* end of [CS320-2023-Fall-lectures-f91.ml] *)				   
