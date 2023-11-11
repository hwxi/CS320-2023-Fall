#use "./../../MySolution/OCaml/assign6-1.ml";;

(* ****** ****** *)


let test1 = sexpr_to_string(SAdd [SInt 1; SInt 2; SInt 3])
let () = assert(test1 = "(add 1 2 3)")
let () = assert (sexpr_parse(test1) = Some (SAdd [SInt 1; SInt 2; SInt 3]))


let test2 = sexpr_to_string(SMul [SAdd [SInt 1; SInt 2]; SInt 3; SMul [SInt 1]])
let () = assert(test2 = "(mul (add 1 2) 3 (mul 1))")
let () = assert(sexpr_parse(test2) = Some (SMul [SAdd [SInt 1; SInt 2]; SInt 3; SMul [SInt 1]]))

let test3 = sexpr_to_string(SMul [SAdd [SInt 1; SInt 2]; SInt 3; SMul [SInt 1; SInt 2; SInt 3]])
let () = assert(test3 = "(mul (add 1 2) 3 (mul 1 2 3))")
let () = assert(sexpr_parse(test3) = Some (SMul [SAdd [SInt 1; SInt 2]; SInt 3; SMul [SInt 1; SInt 2; SInt 3]]))

(* ****** ****** *)

let test4 = sexpr_parse("(add 1 2))")
let () = assert(test4 = None)

let test5 = sexpr_parse("(add 1 2 3")
let () = assert(test5 = None)

let test6 = sexpr_parse("(add 1 ()()))))2 3))")
let () = assert(test6 = None)

(* ****** ****** *)

let () = print_string("Assign6-1-test passed!\n")
;;
(* ****** ****** *)

(* end of [CS320-2023-Fall-assign6-1-test.sml] *)
