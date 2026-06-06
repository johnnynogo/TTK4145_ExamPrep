class DiningSavages {
    private int servings = 0;
    private int M;

    public DiningSavages(int m) {
        this.M = m;
    }

    // Cook
    public synchronized void cookFill()
            throws InterruptedException {
        while (servings > 0) wait();   // wait until pot is empty
        servings = M;                  // refill pot
        notifyAll();                   // wake waiting savages
    }

    // Savage
    public synchronized void savageTakes()
            throws InterruptedException {
        while (servings == 0) {        // wait if pot empty
            notifyAll();               // wake cook to refill
            wait();                    // wait for cook to fill
        }
        servings--;                    // take a serving
        notifyAll();
    }
}