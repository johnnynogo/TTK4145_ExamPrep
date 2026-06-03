procedure Main is
   protected CoordinatorWorkerAction is
      entry EnterWorker;
      entry EnterCoordinator;
      procedure MarkFinished;
      entry WaitForAll;
   private
      Workers          : Natural := 0;
      AllParticipants  : Natural := 0;
      Finished         : Natural := 0;
      Capacity         : Natural := 0;
      NeedCoordination : Boolean := False;
      AllDone          : Boolean := False;
   end CoordinatorWorkerAction;

   protected body CoordinatorWorkerAction is

      entry EnterWorker when Capacity > 0 is
      begin
         Workers         := Workers + 1;
         AllParticipants := AllParticipants + 1;
         Capacity        := Capacity - 1;
         if Workers mod 3 = 1 then
            NeedCoordination := True;
         end if;
      end EnterWorker;

      entry EnterCoordinator when NeedCoordination is
      begin
         AllParticipants  := AllParticipants + 1;
         Capacity         := Capacity + 3;
         NeedCoordination := False;    -- reset for next batch
      end EnterCoordinator;

      procedure MarkFinished is
      begin
         Finished := Finished + 1;
         if Finished = AllParticipants then
            AllDone := True;           -- Ada re-evaluates WaitForAll guard
         end if;
      end MarkFinished;

      entry WaitForAll when AllDone is
      begin
         Finished        := Finished - 1;
         AllParticipants := AllParticipants - 1;
         if AllParticipants = 0 then   -- last one out resets
            AllDone          := False;
            Workers          := 0;
            Capacity         := 0;
            NeedCoordination := False;
         end if;
      end WaitForAll;

   end CoordinatorWorkerAction;

begin
   null;
end Main;


--Sverre's solution
--Protected Object Begin
--    Private int capacity = 0;
--    Private bool isOpen = True;
--    Private int participants = 0;
--    
--    Entry workerEntry when capacity > 0 and isOpen Begin
--        capacity--;
--        participants++;
--    End
--
--    Entry coordinatorEntry when workerEntry’count > 0 and isOpen Begin
--        capacity = capacity + 3;
--        participants++;
--    End
--
--    Entry exit when exit’count == participants Begin
--        isOpen = False;
--        participants--;
--        if(participants==0){
--            // I am the last one, reset
--            isOpen = True;
--        }
--    End
--End