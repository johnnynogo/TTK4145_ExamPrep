procedure Main is
   protected ManyReadersSingleWriter is
      entry StartWriting;
      procedure EndWriting;
      entry StartReading;
      procedure EndReading;
   private
      Readers : Natural := 0;
      Writing : Boolean := False;
   end ManyReadersSingleWriter;

   protected body ManyReadersSingleWriter is
   entry StartWriting when not Writing and Readers = 0 is          -- TODO: WANT NOT WRITING AND READERS == 0?
   begin
      Writing := True;
   end StartWriting;

   procedure EndWriting is
   begin
      Writing := False;
   end EndWriting;

   entry StartReading when not Writing is
   begin
      Readers := Readers + 1;
   end StartReading;

   procedure EndReading;
   begin
      Readers := Readers - 1;
   end EndReading;

   end ManyReadersSingleWriter; 

begin
   null;
end Main;
