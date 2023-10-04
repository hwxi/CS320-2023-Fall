(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let rec
stream_filter
(fxs: 'a stream)
(test: 'a -> bool) = fun () -> (* full laziness *)
match fxs() with
|
StrNil -> StrNil
|
StrCons(x1, fxs) ->
if test(x1) then
StrCons
(x1, stream_filter(fxs)(test))
else stream_filter(fxs)(test)()
;;
(* ****** ****** *)

let rec
stream_from
(n: int): int stream =
fun () ->
StrCons(n, stream_from(n+1))
;;
(* ****** ****** *)

let theNats = stream_from(0)

(* ****** ****** *)

let theNats1M =
stream_filter(theNats)(fun x -> x > 1000000)
;;
(* ****** ****** *)

let StrCons(x1, fxs) = theNats1M();;

(* ****** ****** *)

(* end of [stream_filter.ml] *)
