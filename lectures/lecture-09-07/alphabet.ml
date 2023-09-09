(*
 An example showing
 how to create a string with a call to String.init
*)

let chr = Char.chr
let ord = Char.code
let alphabet = String.init 26 (fun i -> chr(ord('a') + i))
;;

(* end of [CS320-2023-Fall-lectures-alphabet.ml] *)
