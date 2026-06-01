class readers_writers {
    private int readers = 0;
    private int writers = 0;
    private boolean writing = false;

    public synchronized void startWrite() throws InterruptedException {
        writers++;
        while (writing || readers > 0) wait();
        writers--;
        writing = true;
    }

    public synchronized void endWrite() throws InterruptedException {
        writing = false;
        notifyAll();
    }

    public synchronized void startRead() throws InterruptedException {
        while (writing || writers > 0) wait();
        readers++;
    }

    public synchronized void endRead() throws InterruptedException {
        readers--;
        if (readers == 0) notifyAll();
    }
}

// Writer:
rw.startWrite();
write();
rw.endWrite();

// Reader:
rw.startRead();
read();
rw.endRead();