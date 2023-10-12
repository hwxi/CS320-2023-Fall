############################################################
import queue
############################################################
# Tree-based breath-first search
############################################################
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
############################################################
# Tree-based depth-first search
############################################################
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
############################################################
