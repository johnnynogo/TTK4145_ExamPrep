protected HAMManager is
    entry Allocate;
    procedure Free;
private
    Busy : array(1..25) of Boolean := (others => False);
    AnyBusy : Boolean := False;
end HAMManager;

protected body HAMManager is

    entry Allocate when not AnyBusy is
    begin
        -- reserve HAMs in list
        -- update AnyBusy
        reserveHAMs;
        AnyBusy := checkAnyBusy;
    end Allocate;

    procedure Free is
    begin
        releaseHAMs;
        AnyBusy := checkAnyBusy;  -- Ada re-evaluates guard automatically
    end Free;

end HAMManager;

-- Sverre's solution

Procedure T1Allocate(list) begin
   LM.T1RegisterRequest(list)
   LM.T1Allocate()
end

Protected Object LM begin
private T1List, T2List,...T7List;

Procedure T1RegisterRequest(list) begin
   T1List = List
end

Entry T1Allocate when isFree(T1List) begin
   setBusy(T1List)
end

// Same with T2-T7

Procedure free(list) begin
   clearBusy(list)
end

End Protected Object