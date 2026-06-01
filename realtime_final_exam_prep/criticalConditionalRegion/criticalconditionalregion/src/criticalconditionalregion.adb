procedure Main is
   protected CriticalConditionalRegion is
      entry Enter;
      procedure Leave;
   private   
      Condition : Boolean := False;
   end CriticalConditionalRegion;

   protected body CriticalConditionalRegion is
      
      entry Enter when Condition is
      begin
         null;                   -- proceed with critical operation
      end Enter;

      procedure Leave;
      begin
         Condition := False;     -- Ada automaticalle re-evaluates all guards
      end Leave;
begin
   null;
end Main;
