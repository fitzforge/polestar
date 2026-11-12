-- Loaded with the client stubs, before the addons (tools/studio/studio.js).
-- The stub answers any capitalised key with a no-op method (an API it lacks);
-- these are fields the addon keeps on its own frames, which no client frame
-- has as a method, so they read nil until the addon sets them, as in game
-- (QoL/Buttons.lua's b.Glow and its Pulse).
local ADDON_FIELDS = { Glow = true, Pulse = true }
local mt = getmetatable(UIParent)
local index = mt.__index
mt.__index = function(t, k)
	if ADDON_FIELDS[k] then return nil end
	return index(t, k)
end
