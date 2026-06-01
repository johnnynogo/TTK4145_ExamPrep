class criticalConditionalRegion {
    private boolean condition = false;

    public synchronized void entry() throws InterruptedException {
        while (!condition) wait();
        // critical section
    }

    public synchronized void leave() throws InterruptedException {
        condition = true;
        notifyAll();
    }
}