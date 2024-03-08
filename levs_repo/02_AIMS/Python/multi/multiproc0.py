from multiprocessing import Process, Queue

def worker(queue):
    data = queue.get()
    print(f"Worker received: {data}")

if __name__ == "__main__":
    # Create a Queue for communication
    my_queue = Queue()

    # Create a process and pass the Queue to it
    my_process = Process(target=worker, args=(my_queue,))

    # Put data into the Queue
    my_queue.put("Hello from the main process!")

    # Start the process
    my_process.start()

    # Wait for the process to finish
    my_process.join()
