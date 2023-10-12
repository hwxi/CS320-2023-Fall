(* ****** ****** *)
let
rec
fact(n: int): int =
if n > 0 then n * fact(n-1) else 1
;;
(* ****** ****** *)
let
rec
kfact
(n: int)(k: int -> 'ans): 'ans =
if n > 0 then
kfact(n-1)(fun res -> k(n * res)) else k(1)
;;
(* ****** ****** *)

let () =
kfact(10)(fun res -> Printf.printf "res = %i\n" res)
;;
(* ****** ****** *)

let () =
Printf.printf
"kfact(10)(fun res -> res) = %i\n" (kfact(10)(fun res->res))
;;
(* ****** ****** *)
