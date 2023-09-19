(* ************************************************ *)

(*

Question 1: 2 points

let rec f(x) = f(x)

Is 'f' tail-recursive? (1 for yes and 0 for no)

*)

(* ************************************************ *)

(*

Question 2: 2 points

let rec f(x) = f(x+1)

Is 'f' tail-recursive? (1 for yes and 0 for no)

*)

(* ************************************************ *)

(*

Question 3: 2 points

let rec f(x) = f(x)+1

Is 'f' tail-recursive? (1 for yes and 0 for no)

*)

(* ************************************************ *)

(*

Question 4: 2 points

let rec f(x) =
if x > 0 then f(f(x)) else f(f(f(x)))

How many tail-recursive calls in the definition of 'f'?

*)

(* ************************************************ *)

(*

Question 5: 2 points

let
rec f(x) = f(g(f(x))) + 1
and g(y) = f(g(f(g(f(g(x)))))

How many (mutual) tail-recursive calls in the definition of 'g'?

*)

(* ************************************************ *)

(*

Question 6: 10 points

let pp x y = fun f -> f(x,y)

let ff = (* WRITE YOUR CODE *)
(*
 Given an implementation of ff that
 makes the following assertions pass *)

let () = assert (pp 200 100 ff = 100)
let () = assert (pp 100 200 ff = -100)

*)

(* ************************************************ *)

(*
 Question 7: 10 points

 Given the following snippet, implement the test
 function so that isPrime returns true for prime
 number inputs and false otherwise.

 let isPrime(n) =
 let test(i:int): bool = (* YOUR CODE *)
 in
   if n < 2 then false else int1_forall(n)(test)
*)

(* ************************************************ *)

(*

 Question 8: 20 points
 Please give a NON-RECURSIVE implementation of sort5
 that takes 5 integers and returns a tuple that consists
 exactly of the 5 given integers ordered increasingly

 let sort5: int*int*int*int*int -> int*int*int*int*int =
   (* YOUR CODE *)

 For instance, sort5(1, 2, 1, 2, 1) = (1, 1, 1, 2, 2)
 For instance, sort5(1, 3, 4, 5, 2) = (1, 2, 3, 4, 5)
 For instance, sort5(1, 3, 5, 4, 2) = (1, 2, 3, 4, 5)

 You can implement your own helper functions as long as
 you do not make use of recursion.

*)

(* ************************************************ *)
