procedure Main is
   protected LeftAndRight is
      entry EnterRight;
      entry EnterLeft;
      procedure RightDoneProc;
      procedure LeftDoneProc;
      entry WaitForPair;
   private
      RightBusy  : Boolean := False;
      LeftBusy   : Boolean := False;
      RightDone  : Boolean := False;
      LeftDone   : Boolean := False;
      ExitCount  : Natural := 0;
      BothDone   : Boolean := False;
   end LeftAndRight;

   protected body LeftAndRight is

      entry EnterRight when not RightBusy is
      begin
         RightBusy := True;
      end EnterRight;

      entry EnterLeft when not LeftBusy is
      begin
         LeftBusy := True;
      end EnterLeft;

      procedure RightDoneProc is
      begin
         RightDone := True;
         if RightDone and LeftDone then
            BothDone := True;
         end if;
      end RightDoneProc;

      procedure LeftDoneProc is
      begin
         LeftDone := True;
         if RightDone and LeftDone then
            BothDone := True;
         end if;
      end LeftDoneProc;

      entry WaitForPair when BothDone is
      begin
         ExitCount := ExitCount + 1;
         if ExitCount = 2 then
            RightBusy := False;
            LeftBusy  := False;
            RightDone := False;
            LeftDone  := False;
            BothDone  := False;
            ExitCount := 0;
         end if;
      end WaitForPair;

   end LeftAndRight;

begin
   null;
end Main;