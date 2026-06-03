class AtomicAction {
    private boolean errorDetected = false;
    private int finished = 0;
    private boolean started = false;
    private boolean allDone = false;

    // Client
    public synchronized boolean doAction()
            throws InterruptedException {
        errorDetected = false;
        finished = 0;
        allDone = false;
        started = true;
        notifyAll();                    // wake all roles
        while (!allDone) wait();        // wait for all roles to finish
        return !errorDetected;
    }

    // Called by each role at start
    public synchronized void waitForStart()
            throws InterruptedException {
        while (!started) wait();
    }

    // Called periodically during work
    public synchronized boolean checkError() {
        return errorDetected;
    }

    // Called when role detects error
    public synchronized void reportError() {
        errorDetected = true;
        notifyAll();
    }

    // Called when role finishes (success or after error handling)
    public synchronized void arrive()
            throws InterruptedException {
        finished++;
        if (finished == 3) {
            allDone = true;
            started = false;
            notifyAll();
        }
        while (!allDone) wait();
    }
}

// Every role (symmetric):
action.waitForStart();
try {
    doWork();
    if (action.checkError()) throw new Exception();
} catch (Exception e) {
    action.reportError();
    doErrorHandling();
}
action.arrive();