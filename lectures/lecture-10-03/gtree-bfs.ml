(* ****** ****** *)
(*
** This is an example of streamization
*)
(* ****** ****** *)

type 'a strcon =
  StrNil
| StrCons of
  'a * (unit -> 'a strcon)

(* ****** ****** *)

type 'a stream =
unit -> 'a strcon (* thunk *)

(* ****** ****** *)

type node = NODE of int

(* ****** ****** *)

let rec
gtree_bfs
( nxs
: node list)
( fchildren
: node -> node list): node stream = fun() ->
(
match nxs with
  [] -> StrNil
| nx1 :: nxs ->
  StrCons(nx1, gtree_bfs(nxs @ fchildren(nx1))(fchildren))
)
;;
(* ****** ****** *)

(* end of [CS320-2023-Spring-lectures-gtree-bfs.ml] *)
