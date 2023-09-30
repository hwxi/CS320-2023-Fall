(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let rec
stream_foreach
(fxs: 'a stream)
(work: 'a -> unit): unit =
match fxs() with
|
StrNil -> ()
|
StrCons(x1, fxs) -> (work(x1); stream_foreach(fxs)(work))
;;
(* ****** ****** *)

(* end of [stream_foreach.ml] *)
