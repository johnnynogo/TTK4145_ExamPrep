Procedure Main is
   protected Mutex is
      procedure Increment;
   private
      Count : Natural := 0;
   end Mutex;

   protected body Mutex is
      procedure Increment is
      begin
         Count := Count + 1;
      end Increment;
   end Mutex;

   begin 
      Mutex.Increment;        -- Thread A
      Mutex.Increment;        -- Thread B
end Main;