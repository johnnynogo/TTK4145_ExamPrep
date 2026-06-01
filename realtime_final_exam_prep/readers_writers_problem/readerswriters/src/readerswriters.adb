procedure Main is
   protected ReadersWriters is
      entry StartWrite;
      procedure EndWrite;
      entry StartRead;
      procedure EndRead;
      procedure AddWriter;
   private
      Readers : Natural := 0;
      Writers : Natural := 0;
      Writing : Boolean := False;
   end ReadersWriters;

   protected body ReadersWriters is

      procedure AddWriter is
      begin
         Writers := Writers + 1;
      end AddWriter;

      entry StartWrite when not Writing and Readers = 0 is
      begin
         Writers := Writers - 1;
         Writing := True;
      end StartWrite;

      procedure EndWrite is
      begin
         Writing := False;
      end EndWrite;

      entry StartRead when not Writing and Writers = 0 is
      begin
         Readers = Readers + 1;
      end StartRead;

      procedure EndRead is
      begin
         Readers = Readers - 1;
      end EndRead;
   end ReadersWritersM
   
begin
   null;
end Main;
