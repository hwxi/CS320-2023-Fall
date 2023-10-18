(* ************************************ *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
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

(*
 This question should reinforce the claim that
 references are to be avoided.
*)

let
tricky =
let
global = ref(0) in
let rec
f(i: int) : int =
global := !global + i;
if i > 0
then f(i-1) else !global in fun(i:int) -> f(i)
;;
(*
 What is the value of the expression tricky(10)?
*)

let tricky10 = tricky(10);;

(* ************************************ *)

let
mystream =
let
rec
fstream(n: int): int stream = fun() ->
StrCons(n, stream_map(fstream(n+1))(fun(x) -> x+x+1)) in
fstream(0)
;;
(*
 The first element of mystream is 0.
 What is the 5th (fifth) element in mystream?
 *)
;;
(* ************************************ *)

let rec
fff(n: int): int =
if n = 0 then 0 else 10*fff(n / 2) + n mod 2
;;
(*
 What is the value of fff(1023)?
*)

(* ************************************ *)

type intcont = (int) -> int;;

let rec
kf(n: int)(k1: intcont)(k2: intcont): int =
if n = 0
then k1(0) else
kf(n-1)(fun(res) -> k2(res+n))(fun(res) -> k1(res-n))
;;
let
kf0(n: int): int = kf(n)(fun res -> res)(fun res -> res)
;;

(*
 What is the value of kf0(10)?
*)
			     
(* ************************************ *)

