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
from assign3_6 import *
####################################################
xs0 = mylist_nil()
xs1 = mylist_cons(1, xs0)
xs2 = mylist_snoc(xs0, 2)
xs3 = mylist_append2(xs1, xs2) # length = 2
xs4 = mylist_append2(xs3, xs3) # length = 4
xs5 = mylist_reverse(xs4)
xs6 = mylist_append2(xs5, xs5) # length = 8
xs7 = mylist_append2(xs6, xs6) # length = 16
####################################################
def foreach_to_map_pylist(foreach):
    def map_pylist(xs, fopr_func):
        res = []
        def work_func(x0):
            nonlocal res
            res.append(fopr_func(x0))
            return None
        foreach(xs, work_func)
        return res
    return map_pylist # foreach-function is turned into map_pylist-function
####################################################
assert(len(foreach_to_map_pylist(mylist_foreach)(xs6, lambda x: x)) == 8)
assert(len(foreach_to_map_pylist(mylist_rforeach)(xs6, lambda x: x)) == 8)
assert(len(foreach_to_map_pylist(mylist_foreach)(xs7, lambda x: x)) == 2*8)
assert(len(foreach_to_map_pylist(mylist_rforeach)(xs7, lambda x: x)) == 2*8)
####################################################
print("Assign3-6-test passed!")
####################################################
