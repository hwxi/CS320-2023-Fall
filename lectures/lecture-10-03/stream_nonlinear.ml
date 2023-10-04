(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)
let rec
stream_merge
(fxs0)(fys0)(lte) = fun() ->
match fxs0(), fys0() with
  | StrNil, _ -> fys0()
  | _, StrNil -> fxs0()
  | StrCons(x1, fxs1), StrCons(y1, fys1) ->
    if
    lte(x1)(y1)
    then StrCons(x1, stream_merge(fxs1)(fys0)(lte))
    else StrCons(y1, stream_merge(fxs0)(fys1)(lte))
;;
(* ****** ****** *)

(* end of [stream_nonlinear.ml] *)
