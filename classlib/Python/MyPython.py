###########################################################################
#
# MyPython.ml is a library
# built for CS320, Fall, 2023
#
###########################################################################

def int1_forall(n0, test_func):
    i0 = 0
    while(i0 < n0):
        if not test_func(i0):
            return False
        i0 = (i0 + 1)
    return True # test_func(i0)==True for all 0 <= i0 < n0

def int1_foreach(n0, work_func):
    i0 = 0
    while(i0 < n0):
        work_func(i0)
        i0 = (i0 + 1)
    return None # work_func(i0) is done for all 0 <= i0 < n0

def int1_rforeach(n0, work_func):
    i0 = 0
    while(i0 < n0):
        work_func(n0-1-i0)
        i0 = (i0 + 1)
    return None # work_func(i0) is done for all n0 > i0 >= 0

def int1_map_fnlist(xs, fopr_func):
    return foreach_to_map_fnlist(int1_foreach)(xs, fopr_func)
def int1_map_pylist(xs, fopr_func):
    return foreach_to_map_pylist(int1_foreach)(xs, fopr_func)

def int1_foldleft(xs, r0, fopr_func):
    return foreach_to_foldleft(int1_foreach)(xs, r0, fopr_func)
def int1_foldright(xs, r0, fopr_func):
    return rforeach_to_foldright(int1_rforeach)(xs, r0, fopr_func)

###########################################################################

# datatype 'a list =
# nil | cons of ('a * 'a list)

class fnlist:
    ctag = -1
    def get_ctag(self):
        return self.ctag
    def __iter__(self):
        return fnlist_iter(self)
    def __reversed__(self):
        return fnlist_reverse(self)
# end-of-class(fnlist)

class fnlist_iter:
    def __iter__(self):
        return self
    def __init__(self, itms):
        self.itms = itms
    def __next__(self):
        if (self.itms.ctag==0):
            raise StopIteration
        else:
            itm1 = self.itms.cons1
            self.itms = self.itms.cons2
            return itm1
    # end-of-[__next__]

###########################################################################

class fnlist_nil(fnlist):
    def __init__(self):
        self.ctag = 0
        # return None
# end-of-class(fnlist_nil)

class fnlist_cons(fnlist):
    def __init__(self, cons1, cons2):
        self.ctag = 1
        self.cons1 = cons1
        self.cons2 = cons2
        # return None
    def get_cons1(self):
        return self.cons1
    def get_cons2(self):
        return self.cons2
# end-of-class(fnlist_cons)

####################################################
def fnlist_sing(x0):
    res = fnlist_nil()
    res = fnlist_cons(x0, res)
    return res
####################################################
def fnlist_print(xs):
    nx = 0
    sep = "; "
    print("fnlist[",end='')
    while(xs.ctag > 0):
        if (nx > 0):
            print(sep,end='')        
        print(xs.cons1,end='')
        nx = nx + 1; xs = xs.cons2
    print("]", end='')
####################################################
def fnlist_reverse(xs):
    res = fnlist_nil()
    for x1 in xs:
        res = fnlist_cons(x1, res)
    return res
####################################################

############### end of [CS320-2023-Fall-classlib-MyPython.py] ###############
