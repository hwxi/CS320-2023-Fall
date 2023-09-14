(* ****** ****** *)

let rec
isevn(n: int): bool =
if n = 0 then true else isodd(n-1)
and
isodd(n: int): bool =
if n = 0 then false else isevn(n-1)

(* ****** ****** *)
;;
(* ****** ****** *)

(* end of [lecture-09-14-isevn_and_isodd.ml] *)
