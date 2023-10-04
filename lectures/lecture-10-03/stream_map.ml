(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let rec
stream_map
(fxs: 'a stream)
(fopr: 'a -> 'b): 'b stream = fun () -> (* full laziness *)
match fxs() with
|
StrNil -> StrNil
|
StrCons(x1, fxs) -> StrCons(fopr(x1), stream_map(fxs)(fopr))
;;
(* ****** ****** *)

(* end of [stream_map.ml] *)
