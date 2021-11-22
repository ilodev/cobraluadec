-- Decompiled using luadec 2.2 rev:  for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -s C:\Users\ilo\AppData\Local\Temp\tmptxw572bb-cobra\directionallight.lua.bin 

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
l_0_7.Type = "vector3"
l_0_7.Default = <1, 1, 1 >
l_0_6.Colour = l_0_7
l_0_6.DiffuseOnly, l_0_7 = l_0_7, {Type = "bool", Default = false, Optional = false}
l_0_6.DirectionalUsage, l_0_7 = l_0_7, {Type = "uint32", Default = "Generic", Optional = true, Enum = "SceneGraphLightUsage"}
l_0_6.Intensity, l_0_7 = l_0_7, {Type = "float", Default = 1}
l_0_6.LightingComplexity, l_0_7 = l_0_7, {Type = "uint32", Default = "DirectWithoutShadows", Enum = "SceneGraphLightingComplexity"}
l_0_6.Position, l_0_7 = l_0_7, {Type = "vector3", Optional = true}
l_0_6.Rotation, l_0_7 = l_0_7, {Type = "vector3", Optional = true}
l_0_5.Properties = l_0_6
local l_0_8 = {}
l_0_8.__property = "DiffuseOnly"
l_0_8 = {__property = "DirectionalUsage"}
local l_0_9 = {}
l_0_9.__property = "Colour"
l_0_9 = {__property = "Intensity"}
l_0_8 = {Colour = l_0_9, Intensity = l_0_9}
l_0_8 = {__property = "LightingComplexity"}
l_0_7 = {DiffuseOnly = l_0_8, DirectionalUsage = l_0_8, EnableVolume = false, HDRColour = l_0_8, LightingComplexity = l_0_8, LightType = "Directional", VolumeStrength = 0}
l_0_8 = {__property = "Position"}
l_0_8 = {__property = "Rotation"}
l_0_7 = {Position = l_0_8, Rotation = l_0_8}
l_0_5.Components, l_0_6 = l_0_6, {Light = l_0_7, Transform = l_0_7}
.Root = l_0_5
l_0_8 = {__property = "DiffuseOnly"}
l_0_8 = {__property = "DirectionalUsage"}
l_0_9 = {__property = "Colour"}
l_0_9 = {__property = "Intensity"}
l_0_8 = {Colour = l_0_9, Intensity = l_0_9}
l_0_8 = {__property = "LightingComplexity"}
l_0_7 = {DiffuseOnly = l_0_8, DirectionalUsage = l_0_8, EnableVolume = false, HDRColour = l_0_8, LightType = "Directional", LightingComplexity = l_0_8, VolumeStrength = 0}
l_0_8 = {__property = "Position"}
l_0_8 = {__property = "Rotation"}
l_0_7 = {Position = l_0_8, Rotation = l_0_8}
l_0_6 = {Light = l_0_7, Transform = l_0_7}
l_0_6 = {}
l_0_7 = {Default = <1, 1, 1 >, Type = "vector3"}
l_0_7 = {Default = false, Optional = false, Type = "bool"}
l_0_7 = {Default = "Generic", Enum = "SceneGraphLightUsage", Optional = true, Type = "uint32"}
l_0_7 = {Default = 1, Type = "float"}
l_0_7 = {Default = "DirectWithoutShadows", Enum = "SceneGraphLightingComplexity", Type = "uint32"}
l_0_7 = {Optional = true, Type = "vector3"}
l_0_7 = {Optional = true, Type = "vector3"}
l_0_6 = {Colour = l_0_7, DiffuseOnly = l_0_7, DirectionalUsage = l_0_7, Intensity = l_0_7, LightingComplexity = l_0_7, Position = l_0_7, Rotation = l_0_7}
.FlattenedRoot, l_0_5 = l_0_5, {Components = l_0_6, IncompleteComponents = l_0_6, Properties = l_0_6}
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

