class ProducerConsumer {
    private int count = 0;
    private int n;

    public ProducerConsumer(int n) {
        this.n = n;
    }

    public synchronized void produce(Object event) throws InterruptedException {
        while (count == n) wait();
        buffer.add(event);
        count++;
        notifyAll();
    }

    public synchronized Object consume() throws InterruptedException {
        while (count == 0) wait();
        Object event = buffer.get();
        count--;
        notifyAll();
        return event;
    }
}

Object event = waitForEvent();
producer.produce(event);

Object event = consumer.consume();
event.process();