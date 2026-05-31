procedure Main is
   protected ExclusiveQueue is
      entry ArriveLeader;      -- leader arrives and checks for follower
      entry ArriveFollower;    -- follower arrives and checks for leader
      entry WaitForPartner;    -- wait until a partner signals ready
      entry WaitForDanceOver;  -- wait until dance is complete
      procedure DanceDone;     -- called after dance to signal completion
   private
      Leaders      : Natural := 0;
      Followers    : Natural := 0;
      Dancing      : Boolean := False;
      DanceOver    : Boolean := False;
   end ExclusiveQueue;

   protected body ExclusiveQueue is

      -- Leader arrives
      entry ArriveLeader when True is
      begin
         if Followers > 0 then
            Followers := Followers - 1;
            Dancing := True;       -- wake waiting follower
         else
            Leaders := Leaders + 1;
            requeue WaitForPartner; -- wait for a follower to arrive
         end if;
      end ArriveLeader;

      -- Follower arrives
      entry ArriveFollower when True is
      begin
         if Leaders > 0 then
            Leaders := Leaders - 1;
            Dancing := True;       -- wake waiting leader
         else
            Followers := Followers + 1;
            requeue WaitForPartner; -- wait for a leader to arrive
         end if;
      end ArriveFollower;

      -- Wait until a partner is ready
      entry WaitForPartner when Dancing is
      begin null; end WaitForPartner;

      -- Called after dance to signal done
      procedure DanceDone is
      begin
         DanceOver := True;
         Dancing   := False;
      end DanceDone;

      -- Wait until dance is over
      entry WaitForDanceOver when DanceOver is
      begin
         DanceOver := False;
      end WaitForDanceOver;

   end ExclusiveQueue;

   -- Task for Leader
   task LeaderTask;
   task body LeaderTask is
   begin
      ExclusiveQueue.ArriveLeader;
      ExclusiveQueue.WaitForPartner;  -- blocks if no follower yet
      Dance;                          -- dance with partner
      ExclusiveQueue.WaitForDanceOver; -- wait for follower to finish
   end LeaderTask;

   -- Task for Follower
   task FollowerTask;
   task body FollowerTask is
   begin
      ExclusiveQueue.ArriveFollower;
      ExclusiveQueue.WaitForPartner;  -- blocks if no leader yet
      Dance;                          -- dance with partner
      ExclusiveQueue.DanceDone;       -- signal dance is complete
   end FollowerTask;
begin
   null;
end Main;
