
#use "./../../assigns/assign0/assign0.ml";;

let
str2int(cs: string): int =
let x = 5
and len = string_length(cs) in
let rec loop(i:int)(res: int): int =
if i < len then loop(i+1)(10*res + (ord(string_get(cs, i)) - ord('0'))) else res in
  loop(0)(0)
;;

let test1 = str2int("12345")
let test1 = str2int("9876543210")
;;

(* end of [lectures-str2int.ml] *)
