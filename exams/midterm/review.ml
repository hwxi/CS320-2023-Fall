(*
## Midterm Review
*)

(*
## Names vs. Variables
*)

## Recursive functions

Functions are first-class values

## Tail-Recursion
Loops are tail-recursive functions
(However, many popular mainstream
programming languages (e.g., Python)
does not support tail-recursive call
optimization, which is rather unfortuate!)

## Higher-order functions
Loops are 2nd-order functions
Loop transformers are 3rd-order functions

## Mutual Recursion

For instance, ...

## Datatypes and Pattern Matching

There features are in the core of ML-like
functional programming languages; they, for
instance, can be used to greatly facilitate
compiler construction.

Here are some common datatypes

type 'a option =
  None | Some of 'a

type 'a list =
  Nil | Cons of 'a * 'a list

let
option_length(xs) =
  None -> -
| Some _ -> 1

let rec
list_length(xs) =
  Nil -> -
| Cons(_, xs) ->
  1 + list_length(xs)

## Option-based error handling

## Exception-based error handling

## Continuation

## Generators (LINEAR streams)
