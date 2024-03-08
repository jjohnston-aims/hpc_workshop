import multiprocessing as mp
def myPID():
        # Returns relative PID of a pool process
        return mp.current_process()._identity[0]
def helloWorker(np):
        # np = number of processes in pool
        pid = myPID()
        print("Hello from process %i of %i"%(pid, np))
        if (pid == 2):
            print("special rank 2 message")
        # do actual work
        return 0
# Create a pool of 8 processes, and run helloWorker
poolSize = 8
p = mp.Pool(poolSize)
ret = p.map(helloWorker, [poolSize]*poolSize)
p.close()
p.join()

