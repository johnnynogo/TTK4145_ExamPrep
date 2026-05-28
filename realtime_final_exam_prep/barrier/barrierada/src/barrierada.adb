procedure Main is
   protected Barrier is
      procedure Arrive;
      entry WaitForAll; 
   private
      Count : Natural := 0;
      N : Natural := 5;
      AllArrived : Boolean := False;
   end Barrier;

   protected body Barrier is
      procedure Arrive is
      begin
         Count := Count + 1;
         if Count = N then
            AllArrived := True;
         end if;
      end Arrive;

      entry WaitForAll when AllArrived is
      begin null; end WaitForAll;
   end Barrier;
begin
   null;
end Main;

-- Every thread calls:
-- Barrier.Arrive;
-- Barrier.WaitForAll;
-- criticalPoint();