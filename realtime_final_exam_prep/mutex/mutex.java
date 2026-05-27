class mutex {
    private int count = 0;

    public synchronized void increment() {
        count += 1;
    }
}
counter.increment();
