####################################################
#!/usr/bin/env python3
####################################################
import sys
sys.path.append('./../../classlib/Python')
from MyPython import *
####################################################
"""
HX-2023-03-24: 20 points
Solving the N-queen puzzle
"""
####################################################
"""
Please revisit assign04-04.sml.
A board of size N is a tuple of length N.
######
For instance, a tuple (0, 0, 0, 0) stands
for a board of size 4 (that is, a 4x4 board)
where there are no queen pieces on the board.
######
For instance, a tuple (2, 1, 0, 0) stands
for a board of size 4 (that is, a 4x4 board)
where there are two queen pieces; the queen piece
on the 1st row is on the 2nd column; the queen piece
on the 2nd row is on the 1st column; the last two rows
contain no queen pieces.
######
This function [solve_N_queen_puzzle] should return
a stream of ALL the boards of size N that contain N
queen pieces (one on each row and on each column) such
that no queen piece on the board can catch any other ones
on the same board.
"""
####################################################
def board_empty(N):
    bdlst = []
    for _ in range(N):
        bdlst.append(0)
    return tuple(bdlst)
####################################################
def nqueen(bd):
    res = 0
    for j0 in bd:
        if j0 <= 0:
            break
        else:
            res = res + 1
    return res
def board_safety_all(bd):
    return \
        int1_forall \
        (nqueen(bd), \
         lambda i0: board_safety_one(bd, i0))
def board_safety_one(bd, i0):
    def helper(j0):
        pi = bd[i0]
        pj = bd[j0]
        return pi != pj and abs(i0-j0) != abs(pi-pj)
    return int1_forall(i0, helper)
####################################################
def board_extend(bd):
    n0 = len(bd)
    i0 = nqueen(bd)
    children = [  ]
    if i0 < n0:
        bdlst = list(bd)
        for j0 in range(n0):
            bdlst[i0] = j0+1
            if board_safety_one(bdlst, i0):
                children.append(tuple(bdlst))
    # end-of-(if(i0 < n0)-then-else)
    return children
####################################################
import queue
####################################################
def gtree_bfs(nxs, fchlds):
    qnxs = queue.Queue()
    for nx1 in nxs:
        qnxs.put(nx1)
    while True:
        if qnxs.empty():
            raise StopIteration
        else:
            nx1 = qnxs.get()
            for nx2 in fchlds(nx1):
                qnxs.put(nx2)
            yield nx1
        # end-of-(if(qnxs.empty())-then-else)
####################################################
def gtree_dfs(nxs, fchlds):
    qnxs = queue.LifoQueue()
    for nx1 in reversed(nxs):
        qnxs.put(nx1)
    while True:
        if qnxs.empty():
            raise StopIteration
        else:
            nx1 = qnxs.get()
            for nx2 in reversed(fchlds(nx1)):
                qnxs.put(nx2)
            yield nx1
        # end-of-(if(qnxs.empty())-then-else)
####################################################
def solve_N_queen_puzzle(N):
    nx0 = board_empty(N)
    bds = gtree_bfs([nx0], board_extend)
    for bd in bds:
        if nqueen(bd) == N:
            yield bd
####################################################
N = 11
for i0, bd in enumerate(solve_N_queen_puzzle(N)):
    print("Solution", i0+1, ":")
    for nr in bd:
        for nc in range(N):
            if nr != nc+1:
                print(" .", end='')
            else:
                print(" Q", end='')
        print()
    print()
####################################################
