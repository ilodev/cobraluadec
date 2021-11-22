-- Decompiled using luadec 2.2 rev:  for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: C:\Users\ilo\AppData\Local\Temp\tmp98zmjlhp-cobra\database.gamedatabase.lua.bin 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Main = require("Database.Main")
local global = _G
local coroutine = global.coroutine
local pairs = global.pairs
local setmetatable = global.setmetatable
local api = global.api
local table = require("Common.tableplus")
local tostring = global.tostring
local next = global.next
local GameDatabase = module(...)
GameDatabase.tDatabaseFunctions = {}
GameDatabase.tPlayers = {}
GameDatabase.tPlayerMethods = {}
GameDatabase.tPlayerAdvanceMethods = {}
GameDatabase.bInitialised = false
GameDatabase.IsInitialised = function()
  -- function num : 0_0 , upvalues : GameDatabase
  return GameDatabase.bInitialised
end

GameDatabase.CallPlayerMethod = function(_nKey, _sMethodName, ...)
  -- function num : 0_1 , upvalues : GameDatabase, api
  local tPlayers = GameDatabase.tPlayers
  local tPlayer = tPlayers[_nKey]
  ;
  ((api.debug).Assert)(tPlayer ~= nil, "No player for key: " .. _nKey)
  do return (tPlayer[_sMethodName])(tPlayer, ...) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

GameDatabase.AddPlayer = function(_player)
  -- function num : 0_2 , upvalues : GameDatabase
  (GameDatabase.CreateTableForPlayer)(_player)
end

GameDatabase.RemovePlayerTable = function(_nPlayerKey)
  -- function num : 0_3 , upvalues : GameDatabase, api, Main, pairs, tostring
  local tPlayers = GameDatabase.tPlayers
  ;
  ((api.debug).Assert)(_nPlayerKey ~= 0 and tPlayers[_nPlayerKey] ~= nil, "Attempted to remove an invalid player key")
  do
    if _nPlayerKey ~= 0 and tPlayers[_nPlayerKey] ~= nil then
      local tPlayerTable = tPlayers[_nPlayerKey]
      ;
      (Main.CallOnContent)("RemovePlayer", tPlayerTable)
      tPlayers[_nPlayerKey] = nil
    end
    local nCount = 0
    for nKey,tPlayer in pairs(tPlayers) do
      nCount = nCount + 1
    end
    ;
    ((api.debug).Trace)("Removed player table from game database (total tables now " .. tostring(nCount) .. ").")
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

GameDatabase.RemoveAllPlayers = function()
  -- function num : 0_4 , upvalues : GameDatabase, pairs
  local tPlayers = GameDatabase.tPlayers
  for nKey,tPlayer in pairs(tPlayers) do
    (GameDatabase.RemovePlayer)(nKey)
  end
end

GameDatabase.GetPlayer = function(_nKey)
  -- function num : 0_5 , upvalues : GameDatabase, api
  if _nKey == 0 then
    return nil
  end
  local tPlayers = GameDatabase.tPlayers
  local tPlayer = tPlayers[_nKey]
  ;
  ((api.debug).Assert)(tPlayer ~= nil, "No player for key: " .. _nKey)
  do return tPlayer end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local SetupDatabaseFunctionsMetatable = function()
  -- function num : 0_6 , upvalues : setmetatable, GameDatabase
  setmetatable(GameDatabase, GameDatabase)
  GameDatabase.__index = function(_table, _key)
    -- function num : 0_6_0 , upvalues : GameDatabase
    return (GameDatabase.tDatabaseFunctions)[_key]
  end

end

local InitImpl = function(_tMainModules)
  -- function num : 0_7 , upvalues : Main, GameDatabase, SetupDatabaseFunctionsMetatable
  (Main.InitContentToCall)(_tMainModules)
  ;
  (Main.CallOnContentEx)("Init")
  GameDatabase.tDatabaseFunctions = {}
  ;
  (Main.CallOnContent)("AddDatabaseFunctions", GameDatabase.tDatabaseFunctions)
  SetupDatabaseFunctionsMetatable()
  GameDatabase.tPlayerMethods = {}
  ;
  (Main.CallOnContent)("AddPlayerMethods", GameDatabase.tPlayerMethods)
  ;
  (Main.CallOnContent)("Setup")
  GameDatabase.bInitialised = true
end

GameDatabase.Init = function(_tMainModules)
  -- function num : 0_8 , upvalues : api, coroutine, GameDatabase, InitImpl
  ((api.debug).Assert)(_tMainModules ~= nil, "GameDatabase must be given a list of modules to initialise on Init.")
  if (coroutine.running)() == nil then
    ((api.debug).StartTimer)("GameDatabase.Init")
  end
  GameDatabase.tMainModules = _tMainModules
  InitImpl(_tMainModules)
  if (coroutine.running)() == nil then
    ((api.debug).EndTimer)("GameDatabase.Init")
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

GameDatabase.ReInit = function()
  -- function num : 0_9 , upvalues : next, GameDatabase, api, Main, InitImpl
  if next(GameDatabase.tPlayers) ~= nil then
    ((api.debug).Warning)("Players found within the game database when ReInit called.  This will break horribly, so skipping re-init.")
    return 
  end
  ;
  (Main.CallOnContentEx)("ShutdownForReInit")
  InitImpl(GameDatabase.tMainModules)
end

GameDatabase.Shutdown = function()
  -- function num : 0_10 , upvalues : Main, GameDatabase
  (Main.CallOnContent)("Shutdown")
  ;
  (Main.Shutdown)()
  GameDatabase.bInitialised = false
end

GameDatabase.Save = function(_saver)
  -- function num : 0_11 , upvalues : pairs, GameDatabase
  for player,tPlayer in pairs(GameDatabase.tPlayers) do
    local playersaver = {}
    _saver[player] = playersaver
    ;
    (GameDatabase.SavePlayer)(player, playersaver)
  end
end

GameDatabase.SavePlayer = function(_player, _saver)
  -- function num : 0_12 , upvalues : api, GameDatabase, Main
  ((api.debug).StartTimer)("GameDB.SavePlayer")
  local tPlayerTable = (GameDatabase.tPlayers)[_player]
  ;
  (Main.CallOnContent)("SavePlayer", tPlayerTable, _saver)
  ;
  ((api.debug).EndTimer)("GameDB.SavePlayer")
end

GameDatabase.LoadPlayer = function(_player, _loader)
  -- function num : 0_13 , upvalues : Main, GameDatabase
  (Main.CallOnContent)("LoadPlayer", (GameDatabase.tPlayers)[_player], _loader)
end

GameDatabase.SavePlayerToTable = function(_player)
  -- function num : 0_14 , upvalues : GameDatabase
  local saver = {}
  ;
  (GameDatabase.SavePlayer)(_player, saver)
  return saver
end

GameDatabase.LoadPlayerFromTable = function(_player, _table)
  -- function num : 0_15 , upvalues : GameDatabase, api
  local playerKey = (GameDatabase.GetPlayerKey)(_player)
  if playerKey ~= 0 then
    (GameDatabase.RemovePlayerTable)(playerKey)
  end
  ;
  (GameDatabase.CreateTableForPlayer)(_player)
  ;
  (GameDatabase.SetPlayerKey)(_player, _player)
  if _table == nil then
    ((api.debug).Warning)("Asked to load from a nil table - assuming undetected save corruption so aborting lua-side of load")
  else
    ;
    (GameDatabase.LoadPlayer)(_player, _table)
  end
end

local bTestsInProgress = false
GameDatabase.TestsInProgress = function()
  -- function num : 0_16 , upvalues : api, bTestsInProgress
  if not ((api.debug).IsDebugAllowed)() then
    return false
  end
  return bTestsInProgress
end

GameDatabase.SetTestsInProgress = function(_bValue)
  -- function num : 0_17 , upvalues : api, bTestsInProgress
  bTestsInProgress = not ((api.debug).IsDebugAllowed)() or _bValue or false
end

GameDatabase.CreateTableForPlayer = function(_player)
  -- function num : 0_18 , upvalues : api, GameDatabase, setmetatable, Main, pairs, tostring
  ((api.debug).Assert)((GameDatabase.tPlayers)[_player] == nil)
  local tPlayer = {}
  setmetatable(tPlayer, tPlayer)
  tPlayer.__index = GameDatabase.tPlayerMethods
  ;
  (Main.CallOnContent)("AddPlayer", tPlayer)
  tPlayer.nKey = _player
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (GameDatabase.tPlayers)[_player] = tPlayer
  local nCount = 0
  for _,_ in pairs(GameDatabase.tPlayers) do
    nCount = nCount + 1
  end
  ;
  ((api.debug).Trace)("Added player table to game database (total tables now " .. tostring(nCount) .. ").")
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end


