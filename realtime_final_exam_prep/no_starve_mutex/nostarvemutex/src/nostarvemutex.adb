protected NoStarveMutex is
    procedure AnnounceIntent;
    entry WaitT1;
    entry WaitT2;
    procedure Exit_Mutex;
private
    Room1  : Natural := 0;
    Room2  : Natural := 0;
    T1Open : Boolean := True;
    T2Open : Boolean := False;
end NoStarveMutex;

protected body NoStarveMutex is

    procedure AnnounceIntent is
    begin
        Room1 := Room1 + 1;
    end AnnounceIntent;

    entry WaitT1 when T1Open is
    begin
        T1Open := False;
        Room2  := Room2 + 1;
        Room1  := Room1 - 1;
        if Room1 = 0 then
            T2Open := True;
        else
            T1Open := True;
        end if;
    end WaitT1;

    entry WaitT2 when T2Open is
    begin
        T2Open := False;
        Room2  := Room2 - 1;
    end WaitT2;

    procedure Exit_Mutex is
    begin
        if Room2 = 0 then
            T1Open := True;
        else
            T2Open := True;
        end if;
    end Exit_Mutex;

end NoStarveMutex;

-- Every thread:
NoStarveMutex.AnnounceIntent;
NoStarveMutex.WaitT1;
NoStarveMutex.WaitT2;
    -- critical section
NoStarveMutex.Exit_Mutex;