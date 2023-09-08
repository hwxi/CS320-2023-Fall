#use "./../assign0.ml";;

let rec
fact(n:int) =
  if n > 0 then n * fact(n-1) else 1
;;

let fact10 = fact(10)
;;

let fact100 = fact(100)
;;

