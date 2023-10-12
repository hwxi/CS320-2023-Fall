(* ****** ****** *)
let
rec
fibo(n: int): int =
if n >= 2 then fibo(n-2) + fibo(n-1) else n
;;
(* ****** ****** *)
let
rec
kfibo
(n: int)(k: int -> 'ans): 'ans =
if n >= 2
then
kfibo(n-2)
(fun res1 ->
     kfibo(n-1)(fun res2 -> k(res1 + res2)))
else k(n)
;;
(* ****** ****** *)

let () =
kfibo(20)(fun res -> Printf.printf "res = %i\n" res)
;;

(* ****** ****** *)
(* ****** ****** *)
(* ****** ****** *)
