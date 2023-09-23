(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let rec
list_map(xs: 'a list)(fopr: 'a -> 'b): 'b list =
match xs with
| [] -> []
| x1 :: xs -> fopr(x1) :: list_map(xs)(fopr)
;;
let
list_map(xs: 'a list)(fopr: 'a -> 'b): 'b list =
list_foldright(xs)([])(fun x0 r0 -> fopr(x0) :: r0)
;;
let
list_map(xs: 'a list)(fopr: 'a -> 'b): 'b list =
list_make_fwork
(
fun work -> list_foreach(xs)(fun x -> work(fopr(x))))
;;
(* ****** ****** *)

let
string_map_list
(xs: string)(fopr: char -> 'a): 'a list =
string_foldright(xs)([])(fun x0 r0 -> fopr(x0) :: r0)
;;
let
string_map_list
(xs: string)(fopr: char -> 'a): 'a list =
list_make_fwork
(
fun work -> string_foreach(xs)(fun x -> work(fopr(x))))
;;
(* ****** ****** *)

let
foreach_to_map_list
( foreach
: ('xs, 'x0) foreach): ('xs, 'x0, 'y0) map_list =
fun xs fopr ->
list_make_fwork(fun work -> foreach(xs)(fun x -> work(fopr(x))))
;;
(* ****** ****** *)

let
list_map =
fun xs -> foreach_to_map_list(list_foreach)(xs)
;;
let
string_map_list =
fun xs -> foreach_to_map_list(string_foreach)(xs)
;;
(* ****** ****** *)

(* end of [lecture-09-26-map_list.ml] *)  
