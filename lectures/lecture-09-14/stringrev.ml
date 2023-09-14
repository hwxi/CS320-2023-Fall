(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let
stringrev(cs:string): string =
string_make_fwork(string_rforeach(cs))

(* ****** ****** *)

let test1 = stringrev("12345");;
let test2 = stringrev("abcdefghijk");;

(* ****** ****** *)

(* end of [lecture-09-14-stringrev.ml] *)  
