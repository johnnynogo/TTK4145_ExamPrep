class ReusableBarrier {
    private int count = 0;
    private int n;
    private boolean phase1Complete = false;
    private boolean phase2Complete = true;

    public ReusableBarrier(int n) {
        this.n = n;
    }

    public synchronized void arrive() throws InterruptedException {
        count++;
        if (count == n) {
            phase1Complete = true;
            phase2Complete = false;
            notifyAll();
        }
        while (!phase1Complete) {
            wait();
        }
    }

    public synchronized void leave() throws InterruptedException {
        count--;
        if (count == 0) {
            phase1Complete = false;
            phase2Complete = true;
            notifyAll();
        }
        while (!phase2Complete) {
            wait();
        }
    }
}

// Every thread runs in a loop:
rendezvous();
barrier.arrive();
criticalPoint();
barrier.leave();