################################################
#
# Generators
#
############################################################

def negate_elements(xs):
    out = []
    for x in xs:
        out.append(-x)
    return out

############################################################

def g_negate_elements(xs):
    for x in xs:
        yield(-x)

############################################################

def g_append(gxs, gys):
    for x in gxs:
        yield x
    for y in gys:
        yield y

############################################################
gxs = g_negate_elements([1,2,3])
gys = g_negate_elements([1,2,3])
test1 = g_append(gxs, gxs) # linearity violation
test2 = g_append(gxs, gys) # No linearity violation
############################################################
