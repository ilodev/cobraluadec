-- Decompiled using luadec 2.2 rev:  for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: C:\Users\ilo\AppData\Local\Temp\tmpr9j0hl1a-cobra\managers.playersavemanager.lua.bin 

-- params : ...
-- function num : 0 , upvalues : _ENV
local global = _G
local api = api
local tostring = tostring
local string = string
local pairs = pairs
local ipairs = ipairs
local coroutine = coroutine
local next = next
local require = require
local type = type
local table = require("common.tableplus")
local math = global.math
local SignIn = require("GameHelpers.SignIn")
local Mutators = require("Environment.ModuleMutators")
local GameDatabase = require("Database.GameDatabase")
local ISaveLoadError = require("Interfaces.ISaveLoadError")
local PlayerSaveManager = module(..., (Mutators.Manager)())
PlayerSaveManager.Init = function(self, _tProperties, _tEnvironment)
  -- function num : 0_0 , upvalues : api
  self.iSaveLoadError = _tEnvironment:RequireInterface("Interfaces.ISaveLoadError")
  self.exceptionToken = ((api.save).RegisterExceptionCallback)(function(tException)
    -- function num : 0_0_0 , upvalues : self
    self:OnExceptionCallback(tException)
  end
)
end

PlayerSaveManager.Advance = function(self, _nDeltaTime)
  -- function num : 0_1 , upvalues : api
  if (self.fnRunDelete or self.fnRunError) and ((api.world).IsActive)("introsequence") == false and ((api.world).IsActive)("loadingscreen") == false and ((api.player).GetGameOwner)() ~= nil then
    if self.fnRunDelete and (self.fnRunDelete)() then
      self.fnRunDelete = nil
    end
    if self.fnRunError and (self.fnRunError)() then
      self.fnRunError = nil
      ;
      ((api.time).Unpause)("World")
    end
  end
end

PlayerSaveManager.Shutdown = function(self)
  -- function num : 0_2 , upvalues : api
  ((api.save).UnregisterExceptionCallback)(self.exceptionToken)
  self.pendingDelete = nil
  if self.fnRunError ~= nil then
    self.fnRunError = nil
    ;
    ((api.time).Unpause)("World")
  end
  self.fnRunDelete = nil
end

PlayerSaveManager._RunDelete = function(self)
  -- function num : 0_3 , upvalues : api, coroutine
  local bOk = false
  local bDeleteComplete = false
  while bOk == false do
    bDeleteComplete = false
    bOk = ((api.save).RequestDelete)(self.pendingDelete, {oncomplete = function()
    -- function num : 0_3_0 , upvalues : bDeleteComplete
    bDeleteComplete = true
  end
})
    ;
    (coroutine.yield)()
  end
  while not bDeleteComplete do
    (coroutine.yield)()
  end
end

PlayerSaveManager._RunError = function(self)
  -- function num : 0_4 , upvalues : api, SignIn
  (self.iSaveLoadError):HandleErrorInterruptible(self._NAME, self.sLastErrorCode)
  do
    if self.sLastErrorCode == "InvalidStore" and ((api.game).CurrentTarget == (api.game).Target_Durango or (api.game).CurrentTarget == (api.game).Target_Scarlett) then
      local playerID = ((api.player).GetGameOwner)()
      ;
      (SignIn._ClearPlayerData)(playerID)
      ;
      ((api.player).RemovePlayer)(playerID)
    end
    self.sLastErrorCode = nil
  end
end

PlayerSaveManager.OnExceptionCallback = function(self, tException)
  -- function num : 0_5 , upvalues : api, coroutine
  local saveType = ((api.save).GetSaveType)(tException.save)
  if saveType == "player" then
    self.sLastErrorCode = tException.exception
    if tException.exception == "Corrupt" then
      self.sLastErrorCode = tException.exception .. "Destructive"
      self.pendingDelete = tException.save
      self.fnRunDelete = (coroutine.wrap)(function()
    -- function num : 0_5_0 , upvalues : self
    self:_RunDelete()
    return true
  end
)
    end
    if self.fnRunError == nil then
      ((api.time).Pause)("World")
    else
      ;
      (self.iSaveLoadError):Cancel(self._NAME)
    end
    self.fnRunError = (coroutine.wrap)(function()
    -- function num : 0_5_1 , upvalues : self
    self:_RunError()
    return true
  end
)
    ;
    ((api.debug).Trace)(" Player Save exception " .. tException.exception .. " " .. saveType .. " " .. self.sLastErrorCode)
  end
end

;
(Mutators.VerifyManagerModule)(PlayerSaveManager)

