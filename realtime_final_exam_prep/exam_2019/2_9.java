class SafeThreadInit {
    private boolean initDone = false;
    private boolean reinitNeeded = false;
    private int workersRunning = 0;

    public synchronized void setInit() {
        initDone = true;
        reinitNeeded = false;
        notifyAll();
    }

    public synchronized void waitForInit() throws InterruptedException {
        while (!initDone || reinitNeeded) wait();
        workersRunning++;
    }

    public synchronized void checkInit() throws InterruptedException {
        if (!reinitNeeded) return;
        workersRunning--;
        if (workersRunning == 0) notifyAll();
        while (reinitNeeded) wait();
        workersRunning++;
    }

    public synchronized void requestInit() throws InterruptedException {
        reinitNeeded = true;
        initDone = false;
        notifyAll();
        while (workersRunning > 0) wait(); 
    }
}

// Sverre's solution
class softRestart{
    private:
        int nOfThreads = 0;
        int error = 1;
        int nOfWaiters = 0;
    public:
    // Called first in any starting thread
    synchronized threadStart(){
        if(nOfThreads == 0){
            // I am first; must do initialization!
            init()
        }
        nOfSystemThreads++;
    }
    
    // Called by anybody discovering an error.
    synchronized forceReinitialization(){
        error = true;
    }
    
    // Called by all threads at regular intervals
    synchronized allOk(){
        while(error){
            if(nOfWaiters == nOfThreads-1){
                // I am the only one running! I must do the reinitialization
                init();
                error = 0;
                notifyAll()
            } else {
                nOfWaiters++;
                wait()
                nOfWaiters--;
            }
        }
    }
}