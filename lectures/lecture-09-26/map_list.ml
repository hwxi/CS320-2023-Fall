(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

(*
type 'a list =
  Nil | Cons of 'a * 'a list
*)

(* ****** ****** *)

(*
HX: pattern matching based
*)

let rec
list_map
(xs: 'a list)(fopr: 'a -> 'b): 'b list =
match xs with
| [] -> []
| x1 :: xs -> fopr(x1) :: list_map(xs)(fopr)
;;

(* ****** ****** *)

(*
HX: combinator based
*)

let
list_map
(xs: 'a list)(fopr: 'a -> 'b): 'b list =
list_foldright(xs)([])(fun x0 r0 -> fopr(x0) :: r0)
;;
let
list_map
(xs: 'a list)(fopr: 'a -> 'b): 'b list =
list_make_fwork
(
fun work -> list_foreach(xs)(fun x -> work(fopr(x))))
;;
(* ****** ****** *)

(*
HX:
Combinator-based coding is quite generic.
For instance, the above two implementations
of list_map can be readily adapted to implement
string_map_list.
*)

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

(*
HX: We can write even more generic code:
*)

let
foreach_to_map_list
( foreach
: ('xs, 'x0) foreach): ('xs, 'x0, 'y0) map_list =
fun xs fopr ->
list_make_fwork(fun work -> foreach(xs)(fun x -> work(fopr(x))))
;;
(* ****** ****** *)

(*
HX-2023-09-26:
//
list_map and string_map_list can be
readily implemented as follows with the use of
foreach_to_map_list.
//
This style of coding is very robust. Your can
practiced in a variety of programming languages
(e.g., Python, Javascript). Have fun!
//
*)

let
list_map =
fun xs -> foreach_to_map_list(list_foreach)(xs)
let
string_map_list =
fun xs -> foreach_to_map_list(string_foreach)(xs)

(* ****** ****** *)

(* end of [lecture-09-26-map_list.ml] *)  
