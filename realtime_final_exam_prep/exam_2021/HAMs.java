// Sverre's solution
synchronized allocate(list){
    while(anyHAMInListIsBusy(list)) wait();
    setHAMsBusy(list);
}

synchronized free(list){
    clearBusy(list)
    notifyAll();
}