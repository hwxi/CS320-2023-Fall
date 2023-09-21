(* ****** ****** *)

type 'a mylist = 
  MyNil | MyCons of 'a * 'a mylist
;;

(* ****** ****** *)

let rec
mylist_foreach
(xs: 'a mylist)(work: 'a -> unit): unit =
match xs with
| MyNil -> ()
| MyCons(x1, xs) -> (work(x1); mylist_foreach(xs)(work))
;;

(* ****** ****** *)

let rec
mylist_rforeach
(xs: 'a mylist)(work: 'a -> unit): unit =
match xs with
| MyNil -> ()
| MyCons(x1, xs) -> (mylist_rforeach(xs)(work); work(x1))
;;

(* ****** ****** *)

let rec
mylist_foldleft
(xs: 'a mylist)
(r0: 'r0)(fopr: 'r0 -> 'a -> 'r0): 'r0 =
(*
fun xs r0 fopr ->
foreach_to_foldleft(mylist_foreach)(xs)(r0)(fopr)
*)
match xs with
| MyNil -> r0
| MyCons(x1, xs) -> mylist_foldleft(xs)(fopr(r0)(x1))(fopr)
;;

let rec
mylist_foldright
(xs: 'a mylist)
(r0: 'r0)(fopr: 'a -> 'r0 -> 'r0): 'r0 =
(*
fun xs r0 fopr ->
foreach_to_foldright(mylist_foreach)(xs)(r0)(fopr)
*)
match xs with
| MyNil -> r0
| MyCons(x1, xs) -> fopr(x1)(mylist_foldright(xs)(r0)(fopr))
;;

(* ****** ****** *)

(* end of [lecture-09-21-mylist_forloops.ml] *)
