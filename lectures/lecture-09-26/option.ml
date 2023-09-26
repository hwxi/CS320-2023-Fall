(* ****** ****** *)
#use "./../../classlib/OCaml/MyOCaml.ml";;
(* ****** ****** *)

(*
 An option-value is
 just a list of length at most 1
*)

type 'a option = None | Some of 'a

(* ****** ****** *)

(*
Monadic style of error-handling
*)
let
intdiv(x:int)(y:int): int option =
  if y = 0 then None else Some(x / y)

(* ****** ****** *)

let
foreach_to_mapopt_list(foreach) =
fun xs fopr ->
list_make_fwork
(
fun work ->
foreach(xs)(fun x ->
let opt = fopr(x) in
match opt with None -> () | Some y -> work(y)))

;;
(* ****** ****** *)

(* end of [lecture-09-26-option.ml] *)  
