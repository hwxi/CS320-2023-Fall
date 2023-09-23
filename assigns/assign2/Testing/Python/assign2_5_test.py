####################################################
#!/usr/bin/env python3
####################################################
import sys
####################################################
sys.setrecursionlimit(16000)
####################################################
sys.path.append('./../../MySolution/Python')
sys.path.append("./../../../../classlib/Python")
####################################################
from MyPython import *
from assign2_5 import *
######################################################
assert(fnlist_make_fwork(lambda work: work(0)).cons1 == 0)
assert(fnlist_make_fwork(lambda work: work(1)).cons1 == 1)
assert(fnlist_make_fwork(lambda work: work(2)).cons1 == 2)
assert(fnlist_make_fwork(lambda work: work(3)).cons1 == 3)
assert(fnlist_make_fwork(lambda work: work(4)).cons1 == 4)
####################################################
print("Assign2-5-test passed!")
####################################################
