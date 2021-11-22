-- Decompiled using luadec 2.2 rev:  for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -s C:\Users\ilo\AppData\Local\Temp\tmpvyyigl3u-cobra\cinematicsanchor.lua.bin 

-- params : ...
-- function num : 0 , upvalues : 
local l_0_0 = .setmetatable
local l_0_1 = {}
l_0_1.__index = ._G
local l_0_2 = (.module)(...)
l_0_0(l_0_2, l_0_1)
local l_0_3 = (.require)("Vector2")
local l_0_4 = (.require)("Vector3")
local l_0_5 = {}
local l_0_6 = {}
local l_0_7 = {}
l_0_7.Looping = false
l_0_6.Animation = l_0_7
l_0_6.BoneTransform, l_0_7 = l_0_7, {AnimEntity = ".", BoneName = "root"}
l_0_6.CinematicTarget, l_0_7 = l_0_7, {}
l_0_6.ModelSkeleton, l_0_7 = l_0_7, {ModelName = "CinematicAnchor"}
l_0_6.Transform, l_0_7 = l_0_7, {}
l_0_5.Components = l_0_6
.Root = l_0_5
l_0_7 = {Looping = false}
l_0_7 = {AnimEntity = ".", BoneName = "root"}
l_0_7 = {}
l_0_7 = {ModelName = "CinematicAnchor"}
l_0_7 = {}
l_0_6 = {Animation = l_0_7, BoneTransform = l_0_7, CinematicTarget = l_0_7, ModelSkeleton = l_0_7, Transform = l_0_7}
l_0_6 = {}
.FlattenedRoot, l_0_5 = l_0_5, {Components = l_0_6, IncompleteComponents = l_0_6}
l_0_5 = .Root
l_0_6 = .FlattenedRoot
.Root = nil
.FlattenedRoot = nil
l_0_7 = function()
  -- function num : 0_0 , upvalues : l_0_5
  return l_0_5
end

.GetRoot = l_0_7
l_0_7 = function()
  -- function num : 0_1 , upvalues : l_0_6
  return l_0_6
end

.GetFlattenedRoot = l_0_7

