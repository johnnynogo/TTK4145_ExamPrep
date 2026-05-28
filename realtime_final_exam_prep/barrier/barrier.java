// rendezvous()

class Barrier {
    private int count = 0;
    private int n;
    private boolean allArrived = false;

    public Barrier(int n){
        this.n = n;
    }

    public synchronized void arrived() throws InterruptedException {
        count++;
        
        if (n == count) {
            allArrived = true;
            notifyAll();
        }

        while(!allArrived) {
            wait();
        }
    }
}