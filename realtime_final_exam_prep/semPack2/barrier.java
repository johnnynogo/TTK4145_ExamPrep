class Barrier {
    int count = 0;
    bool canExit = false;

    public synchronized void Arrive() {
        count++;
        if(count==3) {
            canExit = true;       
            notifyAll();
        }
    }

    public synchronized void Exit() {
        while (!canExit) wait();
        count--;
        if(count==0) {
            canExit = false;
            notifyAll();
        }
    }
}