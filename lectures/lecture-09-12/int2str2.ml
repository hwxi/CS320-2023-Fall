
#use "./../../classlib/OCaml/MyOCaml.ml";;

let rec
nat2str(n0: int): string =
if n0 < 10 then str(chr(n0+48))
else string_snoc(nat2str(n0/10))(chr(n0 mod 10 + 48))

let
int2str(n0: int): string =
if n0 >= 0 then nat2str(n0) else string_cons('-')(nat2str(-n0))

(* end of [lectures-int2str2.ml] *)
