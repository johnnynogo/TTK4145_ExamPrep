import java.util.concurrent.Semaphore;

class Rendezvous {
    static Semaphore a1Done = new Semaphore(0);
    static Semaphore b1Done = new Semaphore(0);

    public static void main(String[] args) throws InterruptedException {
        Thread threadA = new Thread(() -> {
            try {
                System.out.println("a1 running");           // statement a1
                a1Done.release();                             // signal
                b1Done.acquire();                            // wait
                System.out.println("a2 running");        // statement a2
            } catch (InterruptedException e) { e.printStackTrace(); }
        });

        Thread threadB = new Thread(() -> {
            try {
                System.out.println("b1 running");           // statement b1
                b1Done.release();                           // signal
                a1Done.acquire();                           // wait
                System.out.println("b2 running");           // statement b2
            } catch (InterruptedException e) { e.printStackTrace(); }
        });

        threadA.start();
        threadB.start();
        threadA.join();
        threadB.join();
    }
}