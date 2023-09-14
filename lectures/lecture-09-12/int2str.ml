
#use "./../../assigns/assign0/assign0.ml";;

let
nat2str(n0: int): string =

let rec
getLen(n0: int): int =
if n0 < 10 then 1 else 1+getLen(n0/10) in

let rec
getNum(n0:int)(i: int): int =
if i = 0 then n0 mod 10 else getNum(n0/10)(i-1) in
let
len = (getLen n0) in
string_init len (fun i -> chr(getNum(n0)(len-1-i)+48))

let
string_cons
(c0: char)(cs: string): string =
string_init
(string_length(cs) + 1)
(fun i ->
 if i <= 0
 then c0 else string_get(cs, i-1))

let
int2str(n0: int): string =
if n0 >= 0 then nat2str(n0) else string_cons('-')(nat2str(-n0))

(* end of [lectures-int2str.ml] *)
