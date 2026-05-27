procedure Main is

   protected Multiplex is
      entry Enter;
      procedure Leave;
   private
      Inside : Natural := 0;
      MaxThreads : Natural := 3;
   end Multiplex;

   protected body Multiplex is
      entry Enter when Inside < MaxThreads is
      begin
         Inside := Inside + 1;
      end Enter;

      procedure Leave is
      begin
         Inside := Inside - 1;
      end Leave;
   end Multiplex;

begin
   null;
end Main;