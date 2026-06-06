procedure Main is
   protected DiningSavages is
      entry CookFill;
      entry SavageEat;
   private
      Servings : Natural := 0;
      M        : constant Natural := 10;
   end DiningSavages;

   protected body DiningSavages is

      entry CookFill when Servings = 0 is
      begin
         Servings := M;
      end CookFill;

      entry SavageEat when Servings > 0 is
      begin
         Servings := Servings - 1;
      end SavageEat;

   end DiningSavages;

begin
   null;
end Main;