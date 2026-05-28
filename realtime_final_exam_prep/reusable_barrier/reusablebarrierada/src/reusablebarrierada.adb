procedure Main is

   protected ReusableBarrier is
      entry Arrival;
      entry Leave;
      private
         Count : Natural := 0;
         N : Natural := 3;
         Phase1Completed : Boolean := False;
         Phase2Completed : Boolean := True;
   end ReusableBarrier;

   protected body ReusableBarrier is
      entry Arrival when not Phase1Completed is
      begin
         Count := Count + 1;
         if Count = N then
            Phase1Completed := True;
            Phase2Completed := False;
         end if;
      end Arrival;
      
      entry Leave when not Phase2Completed is
      begin
         Count := Count - 1;
         if Count = 0 then
            Phase1Completed := False;
            Phase2Completed := True;
         end if;
      end Leave;
      
   end ReusableBarrier;
begin
   null;
end Main;
