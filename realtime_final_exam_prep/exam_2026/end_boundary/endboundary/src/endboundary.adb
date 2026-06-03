protected AtomicAction is
    procedure StartAction;        -- client calls to begin
    entry WaitForStart;           -- roles wait here
    procedure ReportError;        -- role calls when error detected
    function CheckError return Boolean;  -- roles poll this
    procedure Arrive;             -- role calls when finished
    entry WaitForDone;            -- client waits here
private
    Started       : Boolean := False;
    ErrorDetected : Boolean := False;
    Finished      : Natural := 0;
    AllDone       : Boolean := False;
end AtomicAction;

protected body AtomicAction is

    -- client calls this to start the action
    procedure StartAction is
    begin
        Started       := True;
        ErrorDetected := False;
        Finished      := 0;
        AllDone       := False;
    end StartAction;

    -- roles block here until client starts
    entry WaitForStart when Started is
    begin null; end WaitForStart;

    -- role reports an error
    procedure ReportError is
    begin
        ErrorDetected := True;
    end ReportError;

    -- roles poll this during work
    function CheckError return Boolean is
    begin
        return ErrorDetected;
    end CheckError;

    -- role arrives at end barrier
    procedure Arrive is
    begin
        Finished := Finished + 1;
        if Finished = 3 then
            AllDone := True;    -- Ada re-evaluates WaitForDone guard
            Started := False;   -- reset for next action
        end if;
    end Arrive;

    -- client blocks here until all roles done
    entry WaitForDone when AllDone is
    begin
        AllDone  := False;    -- reset for reuse
        Finished := 0;
    end WaitForDone;

end AtomicAction;

-- Client usage:
AtomicAction.StartAction;
AtomicAction.WaitForDone;
-- result is not ErrorDetected

-- Every role (symmetric):
AtomicAction.WaitForStart;
-- do work, periodically:
if AtomicAction.CheckError then
    AtomicAction.ReportError;
    doErrorHandling;
end if;
AtomicAction.Arrive;