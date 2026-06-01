procedure Main is
   protected ProducerConsumer is
      entry Produce;
      entry Consume;
   private
      Count : Natural := 0;
      N : Natural := 10;
   end ProducerConsumer;

   protected body ProducerConsumer is
      entry Produce when Count /= N is
      begin
         -- something object.add()
         Count := Count + 1;
      end Produce;

      entry Consume when Count /= 0 is
      begin
         -- something object.get()
         Count := Count - 1;
      end Consume;
   end ProducerConsumer;
begin
   null;
end Main;

