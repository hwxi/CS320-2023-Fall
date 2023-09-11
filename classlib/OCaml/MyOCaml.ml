(* ****** ****** *)
(*
 MyOCaml.ml is a library
 built for CS320, Fall, 2023
*)
(* ****** ****** *)
exception False;;
(* ****** ****** *)

let chr = Char.chr
let ord = Char.code
let str(c0) = String.make 1 c0
;;
(* ****** ****** *)

let
char_islower(ch: char) =
(ch >= 'a' && ch <= 'z')
let
char_isupper(ch: char) =
(ch >= 'A' && ch <= 'Z')

let
char_isletter(ch: char) =
(ch >= 'a' && ch <= 'z')
||
(ch >= 'A' && ch <= 'Z')

(* ****** ****** *)

let
char_tolower(ch: char) =
if
char_isupper(ch)
then
chr(ord(ch) - ord('A') + ord('a')) else ch

let
char_toupper(ch: char) =
if
char_islower(ch)
then
chr(ord(ch) - ord('a') + ord('A')) else ch

(* ****** ****** *)

let
char_of_digit
(d0: int): char =
let
() = assert(d0 >= 0) in
let
() = assert(d0 <= 9) in chr(ord('0') + d0)
;;(* end of [char_of_digit] *)

(* ****** ****** *)

let
digit_of_char
(ch: char): int =
let
() = assert(ch >= '0') in
let
() = assert(ch <= '9') in ord(ch) - ord('0')
;;(* end of [digit_of_char] *)

(* ****** ****** *)

let
int1_foreach
(n0:int)
(work: int -> unit): unit =
for i0 = 0 to n0-1 do work(i0) done

(* ****** ****** *)

let
string_init = String.init;;

(* ****** ****** *)

let
string_length = String.length
;;
let
string_get_at
(cs:string)(i0:int): char = String.get cs i0
;;
(* ****** ****** *)

let
string_cons
(c0: char)(cs: string): string =
string_init
(string_length(cs) + 1)
(fun i ->
 if i <= 0
 then c0 else string_get_at cs (i-1))
;;
(* ****** ****** *)

let
string_toupper
(cs: string): string =
string_init
(string_length(cs))
(fun i0 ->
 char_toupper(string_get_at(cs)(i0)))

let
string_tolower
(cs: string): string =
string_init
(string_length(cs))
(
 fun i0 ->
 char_tolower(string_get_at(cs)(i0)))

(* ****** ****** *)

let
string_foreach
(cs: string)
(work: char -> unit) =
int1_foreach
(string_length(cs))
(fun i0 -> work(string_get_at(cs)(i0)))

(* ****** ****** *)

let
string_tabulate
(n0: int)
(f0: int -> char): string = String.init n0 f0
;;
(* ****** ****** *)

let rec
list_forall
(xs: 'a list)
(test: 'a -> bool): bool =
(
match xs with
  [] -> true
| x1 :: xs -> test(x1) && list_forall(xs)(test))

let rec
list_exists
(xs: 'a list)
(test: 'a -> bool): bool =
(
match xs with
  [] -> false
| x1 :: xs -> test(x1) || list_exists(xs)(test))

(* ****** ****** *)

let rec
list_foreach
(xs: 'a list)
(work: 'a -> unit): unit =
(
match xs with
  [] -> ()
| x1 :: xs -> (work(x1); list_foreach(xs)(work)))
;;
(* ****** ****** *)

let
forall_to_foreach
( forall
: 'xs -> ('x0 -> bool) -> bool
)
: 'xs -> ('x0 -> unit) -> unit =
fun(xs)(work) ->
let _ =
  forall(xs)(fun(x0) -> (work(x0); true)) in ()
;;
(* ****** ****** *)

let
foreach_to_forall
( foreach
: 'xs -> ('x0 -> unit) -> unit
)
: 'xs -> ('x0 -> bool) -> bool =
fun(xs)(test) ->
try
let
() = foreach(xs)
(
fun(x0) ->
if test(x0) then () else raise False)
in
  ( true )
with False(*void*) -> (false) 
;;(* end of [foreach_to_forall]: let *)

(* ****** ****** *)

let
foreach_to_foldleft
( foreach
: 'xs -> ('x0 -> unit) -> unit
)
: 'xs -> 'r0 -> ('r0 -> 'x0 -> 'r0) -> 'r0 =
fun
(xs)(r0)(fopr) ->
let
res = ref(r0) in
foreach(xs)
(fun(x0) -> res := fopr(!res)(x0)); !res
;;(* end of [foreach_to_foldleft]: let *)

(* ****** ****** *)

let rec
foreach_to_length
( foreach
: 'xs -> ('x0 -> unit) -> unit)
: ('xs -> int) =
foldleft_to_length(foreach_to_foldleft(foreach))

and
foldleft_to_length
( foldleft
: 'xs -> int -> (int -> 'x0 -> int) -> int)
: ('xs -> int) =
(
 fun(xs) -> foldleft(xs)(0)(fun(r0)(x0) -> r0+1)
)
;;
(* ****** ****** *)
(* ****** ****** *)
(* ****** ****** *)

let
int1_forall = foreach_to_forall(int1_foreach)
;;
let
string_forall = foreach_to_forall(string_foreach)
;;

(* ****** ****** *)
(* ****** ****** *)
(* ****** ****** *)

let
int1_foldleft = foreach_to_foldleft(int1_foreach)
;;
let
string_foldleft = foreach_to_foldleft(string_foreach)
;;

(* ****** ****** *)
(* ****** ****** *)
(* ****** ****** *)

(* end of [CS320-2023-Fall-classlib-MyOCaml.ml] *)
