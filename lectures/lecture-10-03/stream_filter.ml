(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let rec
stream_filter
(fxs: 'a stream)
(test: 'a -> bool) = fun () ->
match fxs() with
|
StrNil -> StrNil
|
StrCons(x1, fxs) ->
if test(x1) then
StrCons(x1, stream_filter(fxs)(test)) else stream_filter(fxs)(test)()
;;
(* ****** ****** *)

(* end of [stream_filter.ml] *)
