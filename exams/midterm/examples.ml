(* ************************************ *)
let rec
f(x) = f(g(x+1)) + 1
and
g(x) = g(f(x-2)) + 2
;;
(* ************************************ *)

(*
 The above
 CPS-translates into the following *)

(* ************************************ *)

let rec
kf(x)(k) =
kg(x+1)(fun r -> kf r (fun r -> k(r + 1)))
and
kg(x)(k) =
kf(x-2)(fun r -> kg r (fun r -> k(r + 2)))
;;

(* ************************************ *)
