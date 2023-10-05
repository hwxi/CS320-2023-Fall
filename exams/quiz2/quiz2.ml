(* ************************************************ *)

(*

let k_combo = fun x y -> x
let s_combo = fun x y z -> x z (y z)
let church_two = fun f x -> f( f( x ) )
let church_three = fun f x -> f( f( f( x ) ) )

*)

(* ************************************************ *)

(*

Q1: 3 points
 
let mystery1 =
s_combo(k_combo)(k_combo)(fun x -> 10)(100)

What is the value of mystery1 ?
*)

(* ************************************************ *)

(*

Q2: 3 points
 
let mystery2 = church_three(fun x -> x * x)(2)

What is the value of mystery2 ?

*)

(* ************************************************ *)

(*

Q3: 4 points
let mystery3 =
church_three(church_two)(fun x -> x + x)(2)

What is the value of mystery3 ?

*)

(* ************************************************ *)

(*

Q4: 5 points
The function list_last returns the last element of a given
list. Please give a NON-RECURSIVE implementation of list_last
based on pattern matching and list_foldleft. If the given list
is empty, raise the Empty exception

exception Empty
let list_last(xs: 'a list): 'a = ....

*)

(* ************************************************ *)

(*

Q5: 5 points
The function list_last returns the last element of a given
list. Please give a NON-RECURSIVE implementation of list_last
based on pattern matching and list_foldright. If the given list
is empty, raise the Empty exception

exception Empty
let list_last(xs: 'a list): 'a = ....

*)

(* ************************************************ *)

(*

Q6: 10 points

The function list_reverse return the reverse of a given list.
Please give an implementation of list_reverse based on list_foldright
(not list_foldleft).

*)

(* ************************************************ *)

(*

Q7: 10 points

The following implementation of list_append is not tail-recursive.
Please give an implementation of list_append that is tail-recursive.

Note that you can only use pattern matching and list_foldleft in your
implementation.
 
let rec
list_append(xs: 'a list)(ys: 'a list) =
match xs with
  [] -> ys | x1 :: xs -> x1 :: list_append(xs)(ys)

*)

(* ************************************************ *)

(*

Q8: 20 points

Recall the 'foreach' function and the 'get_at' function.
For instance, list_foreach(xs)(work) applies 'work' to
each element in the given list 'xs'; list_get_at(xs)(i)
returns the element at position 'i' in 'xs' if 'i' is a
valid index; otherwise the Subscript exception is raised.

Please implement in *Python* a function 'foreach_to_get_at'
that turns a 'foreach' function into a 'get_at' function.

(*

This is the type for 'foreach_to_get_at' in ocaml:

fun
foreach_to_get_at
( foreach
: ('xs, 'x0) foreach): ('xs -> int -> 'x0) = ...
*)

def foreach_to_get_at(foreach):
  # your implementation here

*)

(* ************************************************ *)
