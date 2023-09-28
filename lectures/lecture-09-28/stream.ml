(*
type 'a list = (* eager *)
  Nil | Cons of 'a * 'a list
*)

(* ****** ****** *)

(*
let rec
list_from
(n: int) = n :: list_from(n+1)
*)

(* ****** ****** *)

type 'a strcon =
  StrNil
| StrCons of
  'a * (unit -> 'a strcon)

(* ****** ****** *)

type 'a stream =
unit -> 'a strcon (* thunk *)

(* ****** ****** *)

let rec
stream_from(n: int) =
fun () -> (* thunk *)
StrCons(n, stream_from(n+1))
;;

let theNats = stream_from(0)
;;
(*
let fxs = theNats
let StrCons(x0, fxs) = fxs()
let StrCons(x1, fxs) = fxs()
let StrCons(x2, fxs) = fxs()
;;
*)

(*
 2 :: 3 :: 5 ::
 7 :: 11 :: 13 :: [...]
*)
let rec
sieve
(fxs: int stream): int stream = fun() ->
match fxs() with
|
StrNil -> failwith "whatever!!!"
|
StrCons(p1, fxs) ->
let rec
filter(fxs) = fun() ->
match fxs() with
|
StrNil -> failwith "whatever!!!"
|
StrCons(x1, fxs) ->
if x1 mod p1 = 0
then filter(fxs)()
else StrCons(x1, filter(fxs))
in
  StrCons(p1, sieve(filter(fxs)))

let thePrimes = sieve(stream_from(2))
;;
(*
let fxs = thePrimes
let StrCons(p0, fxs) = fxs()
let StrCons(p1, fxs) = fxs()
let StrCons(p2, fxs) = fxs()
*)
;;

(* ****** ****** *)

(* end-of-lectures-lecture-09-28-[stream.ml] *)
