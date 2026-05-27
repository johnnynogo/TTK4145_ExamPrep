class Rendezvous {
    private boolean a1Finished = false;
    private boolean b1Finished = false;

    public synchronized void a1Done() {
        a1Finished = true;
        notifyAll();
    }

    public synchronized void waitForA1() throws InterruptedException {
        while (!a1Finished) wait();
    }

    public synchronized void b1Done() {
        b1Finished = true;
        notifyAll();
    }

    public synchronized void waitForB1() throws InterruptedException {
        while (!b1Finished) wait();
    }
}

// Thread A:
statement a1
rendezvous.a1Done();
rendezvous.waitForB1();
statement a2

// Thread B:
statement b1
rendezvous.b1Done();
rendezvous.waitForA1();
statement b2