(* ****** ****** *)
exception Done
exception True
exception False
(* ****** ****** *)

let
foreach_to_forall
( foreach
: 'xs -> ('x0 -> unit) -> unit) =
fun xs test ->
try foreach(xs)
(fun x -> if test(x) then () else raise False); true with False -> false
;;
(* ****** ****** *)

(* end of [lecture-09-26-exception.ml] *)  
