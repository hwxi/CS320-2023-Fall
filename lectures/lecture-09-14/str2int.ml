(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let
str2int(cs: string): int =
string_foldleft(cs)(0)
(fun r0 d0 -> 10 * r0 + digit_of_char(d0))

(* ****** ****** *)

let test1 = str2int("12345");;
let test2 = str2int("987654321");;

(* ****** ****** *)

(* end of [lecture-09-14-str2int.ml] *)  
