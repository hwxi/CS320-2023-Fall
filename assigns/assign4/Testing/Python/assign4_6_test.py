####################################################
#!/usr/bin/env python3
####################################################
import sys
####################################################
sys.path.append('./../../MySolution/Python')
sys.path.append("./../../../../classlib/Python")
####################################################
from MyPython import *
from assign4_6 import *
####################################################
def cube_sum(ij):
    i = ij[0]
    j = ij[1]
    return i*i*i + j*j*j
####################################################
# theNatPairs_cubesum should return a GENERATOR
####################################################
def theNatPairs_count(N):
    res = 0
    for ij in theNatPairs_cubesum():
        if cube_sum(ij) < N:
            res += 1
        else:
            break
    return res
####################################################
assert(theNatPairs_count(1000) == 51)
assert(theNatPairs_count(10000) == 226)
assert(theNatPairs_count(100000) == 995)
assert(theNatPairs_count(1000000) == 4497)
assert(theNatPairs_count(10000000) == 20696)
####################################################
print("Assign4-6-test passed!")
####################################################
