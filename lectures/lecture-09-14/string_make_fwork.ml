(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let
string_cons
(c0:char)(cs:string): string =
string_make_fwork
(fun work ->
 (work(c0); string_foreach(cs)(work)))

(* ****** ****** *)

let
string_snoc
(cs:string)(c0:char): string =
string_make_fwork
(fun work ->
 (string_foreach(cs)(work); work(c0)))

(* ****** ****** *)

let
string_append
(cs1:string)
(cs2:string): string =
string_make_fwork
(fun work ->
 (string_foreach(cs1)(work); string_foreach(cs2)(work)))

(* ****** ****** *)

let
string_filter
(cs:string)
(test: char -> bool) =
string_make_fwork
(
fun(work) ->
   string_foreach(cs)
   (fun c -> if test(c) then work(c)))
;;
(* ****** ****** *)

(* end of [lecture-09-14-string_make_fwork.ml] *)  
