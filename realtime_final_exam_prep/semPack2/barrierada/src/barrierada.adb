protected Barrier is
    procedure Arrive;
    entry Wait;
    entry Leave;
private
    Count     : Natural := 0;
    ExitCount : Natural := 0;
    AllHere   : Boolean := False;
end Barrier;

protected body Barrier is

    procedure Arrive is
    begin
        Count := Count + 1;
        if Count = 3 then
            AllHere := True;
        end if;
    end Arrive;

    entry Wait when AllHere is
    begin null; end Wait;

    entry Leave when AllHere is
    begin
        ExitCount := ExitCount + 1;
        if ExitCount = 3 then   -- last out resets
            AllHere   := False;
            Count     := 0;
            ExitCount := 0;
        end if;
    end Leave;

end Barrier;