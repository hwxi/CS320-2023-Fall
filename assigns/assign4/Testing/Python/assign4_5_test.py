####################################################
#!/usr/bin/env python3
####################################################
import sys
####################################################
sys.path.append('./../../MySolution/Python')
sys.path.append("./../../../../classlib/Python")
####################################################
from MyPython import *
from assign4_5 import *
####################################################
assert(len(list_of_buddies("love")) == 25*len("love"))
assert(len(list_of_buddies("water")) == 25*len("water"))
assert(len(list_of_buddies("silent")) == 25*len("silent"))
####################################################
print("Assign4-5-test passed!")
####################################################
