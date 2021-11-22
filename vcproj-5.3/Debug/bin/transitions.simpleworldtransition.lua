-- Decompiled using luadec 2.2 rev:  for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: C:\Users\ilo\AppData\Local\Temp\tmpzik1q5pv-cobra\transitions.simpleworldtransition.lua.bin 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Object = require("Common.object")
local WorldLoadTransition = require("Transitions.WorldLoadTransition")
local require = require
local api = api
local coroutine = coroutine
local SimpleWorldTransition = module(..., (Object.subclass)(WorldLoadTransition))
SimpleWorldTransition.Run = function(self)
  -- function num : 0_0 , upvalues : api
  ((api.messaging).SubmitGlobalMessage)((api.messaging).MsgType_WorldTransitionMessage, "fadeincompleted", self.sNewWorld)
  if self.sOldWorld and ((api.world).IsActive)(self.sOldWorld) then
    ((api.world).Deactivate)(self.sOldWorld)
  end
  self:FinishedWithOldWorld()
  self:WaitForNewWorldLoaded()
  self:ReadyForNewWorld()
  ;
  ((api.messaging).SubmitGlobalMessage)((api.messaging).MsgType_WorldTransitionMessage, "fadeoutstarted", self.sNewWorld)
end


