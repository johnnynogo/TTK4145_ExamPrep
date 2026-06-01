class NoStarveMutex {
    private int room1 = 0;
    private int room2 = 0;
    private boolean t1Open = true;
    private boolean t2Open = false;
    private boolean t1Busy = false;
    private boolean t2Busy = false;

    public synchronized void enter() throws InterruptedException {
        room1++;

        while (!t1Open) wait();
        t1Open = false;
        room2++;
        room1--;

        if (room1 == 0) {
            t2Open = true;
            notifyAll();
        } else {
            t1Open = true;
            notifyAll();
        }

        while (!t2Open) wait();
        t2Open = false;
        room2--;
    }

    public synchronized void exit() {
        if (room2 == 0) {
            t1Open = true;
            notifyAll();
        } else {
            t2Open = true;
            notifyAll();
        }
    }
}

// Every thread:
mutex.enter();
    // critical section
mutex.exit();