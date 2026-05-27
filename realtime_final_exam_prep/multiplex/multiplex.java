package Java.realtime_final_exam_prep.multiplex;

class Multiplex {
    private int count = 0;
    private int inside = 0;
    private int n;

    public Multiplex(int n) {
        this.n = n;
    }

    public synchronized void enter() throws InterruptedException {
        while (inside >= n)
            wait();
        inside++;
    }

    public synchronized void leave() {
        inside--;
        count = count + 1;
        notifyAll();
    }
}

// Every thread calls:
multiplex.enter();
    // critical section
multiplex.leave();