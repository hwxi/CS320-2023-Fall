(* ****** ****** *)

#use "./../assign0.ml";;

(* ****** ****** *)

let
str2int
(cs: string): int =
let rec
helper(i0: int): int =
    if i0 <= 0 then 0 else
    10 * helper(i0 - 1) + 
    ord(string_get(cs, i0-1)) - ord('0')
in
  helper(string_length(cs))
;;
(* ****** ****** *)

let myans1 = str2int("12345")
let myans2 = str2int("98765")
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign0-4.ml] *)
