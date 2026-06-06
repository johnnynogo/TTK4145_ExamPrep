class SmokerCigarette {
    boolean TobaccoOnTable = false;
    boolean PaperOnTable = false;
    boolean MatchesOnTable = false;

    public synchronized void tobacco() {
        while(!TobaccoOnTable) wait();
        TobaccoOnTable = true;
        notifyAll();
    }

    public synchronized void tobaccoSmoker() {
        while(!MatchesOnTable && !PaperOnTable) wait();
        MatchesOnTable=false;
        PaperOnTable=false;
        notifyAll();
    }
}