(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

type lunit =
| LNone
| LSome of (unit -> lunit)

(* ****** ****** *)

let rec
stream_lforeach
(fxs: 'a stream)
(work: 'a -> unit): lunit =
match fxs() with
|
StrNil -> LNone
|
StrCons(x1, fxs) ->
(work(x1);
 LSome(fun () -> stream_lforeach(fxs)(work)))
;;
(* ****** ****** *)

let rec
list_lforeach(xs)(work) =
match xs with
|
[] -> LNone
|
x1 :: xs ->
(work(x1); LSome(fun() -> list_lforeach(xs)(work)))
;;
(* ****** ****** *)     

(* end of [stream_lforeach.ml] *)
