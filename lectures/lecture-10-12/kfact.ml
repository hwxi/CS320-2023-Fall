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
if
n = 0
then k(1)
else kfact(n-1)(fun res -> k(n * res))
;;
(* ****** ****** *)

let () =
kfact(10)(fun res -> Printf.printf "fact(10) = %i\n" res)

(* ****** ****** *)

