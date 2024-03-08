import multiprocessing as mp
def myPID():
        # Returns relative PID of a pool process
        return mp.current_process()._identity[0]
def testfunc(i):
        # do actual work, or...
        return myPID()
def valueDefinition(i, j):
        return 1 # some value defined by i & j
# Create a pool of 8 processes, and run helloWorker
poolSize = 8
p = mp.Pool(poolSize)
inputlist={}
someSummaryVar= []
for i in (range(10)):
        for j in range(8,10):
                k=i*10+j
                inputlist[k] = valueDefinition(i, j)
someSummaryVar += p.map_async(testfunc, inputlist).get()
p.close()
p.join()
print("%s"%someSummaryVar)

