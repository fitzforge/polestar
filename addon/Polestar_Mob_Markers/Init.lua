-- Polestar: Mob Markers' interface strings: ns.L[key], the key is the English text and a missing
-- key returns itself. Loaded first, so Locales/<locale>.lua can fill it before MobMarkers.lua reads it.
local _, ns = ...
ns.L = setmetatable({}, { __index = function(_, key) return key end })
