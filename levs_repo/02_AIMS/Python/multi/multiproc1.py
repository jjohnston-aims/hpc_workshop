import multiprocessing as mp
import time
def square(x):
        return x * x
if __name__ == '__main__':
        pool = mp.Pool()
        inputs = [0,1,2,3,4]
        outputs_async = pool.map_async(square, inputs)
        outputs = outputs_async.get()
        print("Output: {}".format(outputs))

