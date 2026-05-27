with Ada.Text_IO; use Ada.Text_IO;

procedure Rendezvousada is
   protected type Semaphore(Initial : Natural := 0) is
      entry Wait;
      procedure Signal;
   private
      Value : Natural := Initial;
   end Semaphore;

   protected body Semaphore is
      entry Wait when Value > 0 is
      begin
         Value := Value - 1;
      end Wait;
   
   procedure Signal is
      begin
         Value := Value + 1;
      end Signal;
   end Semaphore;

   A1Done : Semaphore(0);
   B1Done : Semaphore(0);

   task ThreadA;
   task body ThreadA is
   begin
      Put_line("a1 running");          -- statement a1
      A1Done.Signal;                   -- signal
      B1Done.Wait;                     -- wait
      Put_Line("a2 running");          -- statement a2
   end ThreadA;

   task ThreadB;
   task body ThreadB is
   begin
      Put_line("b1 running");         -- statement b1
      B1Done.Signal;                  -- signal
      A1Done.Wait;                    -- wait
      Put_line("b2 running");         -- statement b2
   end threadB;

begin
   null;
end Rendezvousada;
