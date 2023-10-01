(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let rec
string_streamize
(xs: string): char stream =
int1_map_stream(string_length(xs))(string_get_at(xs))
;;
(* ****** ****** *)

(* end of [string_streamize.ml] *)
