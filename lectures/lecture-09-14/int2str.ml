(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

let
int2str(n0: int): string =
let rec
foreach(n0: int)
(work: char -> unit) =
if
n0 >= 10
then
let
d0 =
char_of_digit(n0 mod 10) in
(work(d0); foreach(n0/10)(work))
else work(char_of_digit(n0))
in
  string_rmake_fwork(foreach(n0))

(* ****** ****** *)

let test1 = int2str(12345);;
let test2 = int2str(987654321);;

(* ****** ****** *)

(* end of [lecture-09-14-int2str.ml] *)  
