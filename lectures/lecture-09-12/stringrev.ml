
#use "./../../assigns/assign0/assign0.ml";;

let
stringrev(cs: string): string =
  let len = string_length(cs) in
  string_init len (fun i -> string_get(cs, len-i-1))

let test1 = stringrev("test1")
let test2 = stringrev("test2")


(* end of [lectures-stringrev.ml] *)
