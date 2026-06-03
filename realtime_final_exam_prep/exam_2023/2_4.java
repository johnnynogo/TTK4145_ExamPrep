class CoordinatorWorkerAction {
    private int workers = 0;
    private int coordinators = 0;
    private int totalIn = 0;
    private int finishedCount = 0;
    private boolean needCoordinator = false;
    private boolean actionDone = false;

    // Entry
    public synchronized void entryCoordinator() {
        while (!needCoordinator) wait(); // woken when there are three workers
        needCoordinator = false;
        coordinators++;
        totalIn++;
        notifyAll();
    }

    public synchronized void entryWorker() {
        workers++;
        totalIn++;
        if (workers % 3 == 1) {
            needCoordinator = true;
            notifyAll();
        }
    }

    // Exit
    public synchronized void exit() {
        finishedCount++;
        if (finishedCount == totalIn) {
            actionDone = true;
            notifyAll();
        }

        while (!actionDone) wait();

        finishedCount--;
        if (finishedCount == 0) {
            workers = 0;
            coordinators = 0;
            totalIn = 0;
            actionDone = false;
            needCoordinator = false;
            notifyAll();
        }
    }
}

// Sverre's solution
class Controller {
    private int capacity=0;
    private int waitingWorkers=0;
    private int participants = 0;
    private int finished = 0;
    private bool exitAll = false;
    
    synchronized workerEntry(){
        while(capacity<1 or exitAll){
            waitingWorkers++;
            notifyAll();
            wait();
            waitingWorkers--;
        }
        capacity--;
        participants++;
    }
    
    synchronized coordinatorEntry(){
        while(waitingWorkers == 0 or capacity>0 or exitAll) wait();
        capacity = capacity+3;
        participants++;
        notifyAll();
    }

    synchronized exit(){
        finished++;
        while(finished < participants) wait();
        exitAll = true;
        finished--;
        participants--;
        if(participants==0){
            // I am the last one, reset
            exitAll = false;
        }
    }
}
