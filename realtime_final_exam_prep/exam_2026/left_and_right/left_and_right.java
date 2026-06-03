class LeftRight {
    private boolean RightFinished = false;
    private boolean LeftFinished = false;
    private boolean RightBusy = false;

    public synchronized void RightFunc() {
        while(RightBusy) wait();
        RightBusy = true;

        // R()
        RightFinished = true;
        while(!LeftFinished) wait();

        RightFinished = false;
        LeftFinished = false;
        RightBusy = false;
        notifyAll();
    }

    // LeftFunc symmetric
}