class ExclusiveQueue {
    int leaders = 0;
    int followers = 0;
    boolean dancing = false;
    boolean danceOver = false;

    public synchronized void leader() throws InterruptedException {
        if (followers > 0) {
            followers--;
            dancing = true;
            notifyAll();
        }
        else {
            leaders++;
            while(!dancing) wait();
        }

        dance();
        while(!danceOver) wait();
        dancing = false;
        danceOver = false;
        notifyAll();
    }

    // Followers
    public synchronized void follower() throws InterruptedException {
        if (leaders > 0) {
            leaders--;
            dancing = true;
            notifyAll();
        } else {
            followers++;
            while (!dancing) wait();
        }
        dance();
        danceOver = true;
        notifyAll();
    }
}