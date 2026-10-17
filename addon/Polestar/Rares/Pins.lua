-- Rares on the world map and the minimap, through Polestar.Pins (Nav): one
-- layer per kind ("rares.rare", "rares.treasure"), each on the world map
-- and/or the minimap by its own setting (rares.worldRares, worldTreasures,
-- minimapRares, minimapTreasures).
--
-- Spawns come from the Codex pack, which loads on demand: the first time the
-- world map opens with a world-map kind on, at login (out of combat) when a
-- minimap kind is on, or whenever something else loaded it (CODEX_LOADED).
-- With every kind off nothing loads and both layers are cleared.
--
--   Rares.BuildPins(o) -> pins       pure: the pin selection
--     o = { kind = "rare"|"treasure", list = { Rares.Info records }, level = player level,
--           hideGrey, history = { [key] = entry }, now = epoch,
--           onClick = fn(rec, spawn, button) }
--   Rares.RefreshPins()

local ADDON, ns = ...
local Rares = ns.Rares
local serverTime = ns.Compat.Now
local L = ns.L

local type, ipairs, floor, abs, format = type, ipairs, math.floor, math.abs, string.format

local LAYER = { rare = "rares.rare", treasure = "rares.treasure" }
local SETTINGS = {
	rare = { world = "worldRares", minimap = "minimapRares" },
	treasure = { world = "worldTreasures", minimap = "minimapTreasures" },
}
local RECENT = 2 * 3600 -- a sighting this fresh lights its pins
local NEAR = 1.5 -- spawns of one rare closer than this (map percent) share a pin

-- The highest level that gives no experience (grey) for a player level.
function Rares.GreyLevel(level)
	if not level then return 0 end
	if level <= 5 then return 0 end
	if level <= 39 then return level - 5 - floor(level / 10) end
	if level <= 59 then return level - 1 - floor(level / 5) end
	return level - 9
end

local function rgb(name)
	local T = ns.Theme
	if T and T.Color then return T.Color(name) end
	return 1, 1, 1, 1
end

local function tooltip(rec, entry, now)
	return function(tip)
		tip:SetText(rec.name or "?", rgb(Rares.ColorName(rec.kind)))
		local lv = Rares.LevelText(rec.level, rec.levelMax)
		local kind = Rares.KindText(rec.kind, rec.elite)
		tip:AddLine(lv and (format(L["Level %s"], lv) .. " " .. kind) or kind, rgb("textDim"))
		if entry and entry.t then
			tip:AddLine(format(L["Last seen %s"], Rares.AgoText(entry.t, now)), rgb("text"))
		end
		local n = type(rec.loot) == "table" and #rec.loot or 0
		if n > 0 then tip:AddLine(n == 1 and L["1 item of loot"] or format(L["%d items of loot"], n), rgb("textDim")) end
		tip:AddLine(" ")
		tip:AddLine(L["Click: show it in Rares"], rgb("textDim"))
		tip:AddLine(L["Shift-click: set a waypoint"], rgb("textDim"))
	end
end

function Rares.BuildPins(o)
	local pins = {}
	if type(o) ~= "table" or type(o.list) ~= "table" then return pins end
	local kind = o.kind == "treasure" and "treasure" or "rare"
	local grey = o.hideGrey and kind == "rare" and Rares.GreyLevel(o.level) or nil
	local r, g, b = rgb(Rares.ColorName(kind))
	local color = { r, g, b, 1 }
	local icon = kind == "treasure" and "icon-treasure" or "qol-target"
	local now = o.now or 0
	for _, rec in ipairs(o.list) do
		local key = Rares.Key(kind, rec.id)
		local top = rec.levelMax or rec.level
		local skip = grey and top and top > 0 and top <= grey
		if not skip then
			local entry = o.history and o.history[key]
			local recent = entry and entry.t and now - entry.t < RECENT
			local placed = {}
			for _, s in ipairs(rec.spawns or {}) do
				if s.map and s.x and s.y then
					local dup = false
					for _, p in ipairs(placed) do
						if p.map == s.map and abs(p.x - s.x) < NEAR and abs(p.y - s.y) < NEAR then dup = true break end
					end
					if not dup then
						placed[#placed + 1] = s
						local spawn = s
						pins[#pins + 1] = {
							map = s.map, x = s.x, y = s.y, f = s.f,
							icon = icon, size = kind == "treasure" and 13 or 15, minimapSize = kind == "treasure" and 11 or 13,
							color = color, backdrop = true,
							ring = rec.elite and color or nil,
							glow = recent or nil,
							priority = recent and 4 or (rec.elite and 3 or 2),
							kind = kind, id = rec.id, key = key,
							tooltip = tooltip(rec, entry, now),
							onClick = o.onClick and function(button) o.onClick(rec, spawn, button) end or nil,
						}
					end
				end
			end
		end
	end
	return pins
end

---------------------------------------------------------------------------
-- Applying the layers
---------------------------------------------------------------------------

-- kind -> { Rares.Info, ... }, built once per Codex load. Decoding every rare
-- and treasure costs tens of milliseconds on the real pack, so the pins build
-- their lists a batch per frame (BATCH records), and only once pins are due:
-- a minimap kind is on, or a world kind is on and the world map has been
-- opened. The Rares section builds a list at once when it shows one.
local lists = {}
local BATCH = 40
local building = {} -- kind -> { ids, i, list } while a batch build runs
local mapSeen = false

local function finish(kind, list)
	table.sort(list, function(a, b) return a.id < b.id end)
	lists[kind] = list
	building[kind] = nil
	return list
end

local function collect(kind)
	local C = Rares.Codex(false)
	if not C then return nil end
	local ids = {}
	C.Each(kind, function(id) ids[#ids + 1] = id end)
	return ids
end

local function decode(kind, ids, from, to, list)
	for i = from, to do
		local rec = Rares.Info(kind, ids[i])
		if rec and #rec.spawns > 0 then list[#list + 1] = rec end
	end
end

-- The whole list now (the section, a sample alert).
local function listOf(kind)
	if lists[kind] then return lists[kind] end
	local b = building[kind]
	if b then
		decode(kind, b.ids, b.i, #b.ids, b.list)
		return finish(kind, b.list)
	end
	local ids = collect(kind)
	if not ids then return nil end
	local list = {}
	decode(kind, ids, 1, #ids, list)
	return finish(kind, list)
end
Rares.ListOf = listOf

local function click(rec, spawn, button)
	if button ~= "LeftButton" then return end
	if IsShiftKeyDown and IsShiftKeyDown() then
		local N = ns.Nav
		if N and N.SetTarget then N.SetTarget(spawn.map, spawn.x, spawn.y, rec.name, spawn.f) end
	else
		Rares.Show(rec.kind, rec.id)
	end
end

local function wanted(kind)
	local s = SETTINGS[kind]
	if not Rares.Get("enabled") then return false, false end
	return Rares.Get(s.world) and true or false, Rares.Get(s.minimap) and true or false
end

-- A kind's layer is due when it is on for the minimap, or on for the world
-- map once the world map has been opened this session.
local function due(kind)
	local world, minimap = wanted(kind)
	return minimap or (world and mapSeen)
end

local function later(fn)
	if C_Timer and C_Timer.After then C_Timer.After(0, fn) else fn() end
end

local function apply(kind)
	local Pins = ns.Pins
	local layer = LAYER[kind]
	local world, minimap = wanted(kind)
	local list = due(kind) and lists[kind]
	local pins = list and Rares.BuildPins({
		kind = kind, list = list, level = ns.Compat.GetPlayerInfo().level, hideGrey = Rares.Get("hideGrey"),
		history = Rares.History(), now = serverTime(), onClick = click,
	})
	if pins and #pins > 0 then
		Pins.SetLayer(layer, pins, { world = world, minimap = minimap, edge = false })
	else
		Pins.ClearLayer(layer)
	end
end

-- One batch of a kind's list per frame, then its layer.
local function step(kind)
	local b = building[kind]
	if not b then return end
	if not Rares.Codex(false) then
		building[kind] = nil
		return
	end
	local to = math.min(#b.ids, b.i + BATCH - 1)
	decode(kind, b.ids, b.i, to, b.list)
	b.i = to + 1
	if b.i > #b.ids then
		finish(kind, b.list)
		apply(kind)
	else
		later(function() step(kind) end)
	end
end

-- Layers from the lists at hand; a due kind without its list starts a batch
-- build (from the next frame) and gets its layer when that ends.
function Rares.RefreshPins()
	local Pins = ns.Pins
	if not (Pins and Pins.SetLayer) then return end
	for kind in pairs(LAYER) do
		if lists[kind] or not due(kind) then
			apply(kind)
		elseif not building[kind] and Rares.Codex(false) then
			local ids = collect(kind)
			if ids then
				building[kind] = { ids = ids, i = 1, list = {} }
				later(function() step(kind) end)
			end
		end
	end
end

local function anyWorld()
	local r = wanted("rare")
	local t = wanted("treasure")
	return r or t
end

local function anyMinimap()
	local _, r = wanted("rare")
	local _, t = wanted("treasure")
	return r or t
end

-- The world map opened: from now on world pins are due; load the Codex the
-- first time they are wanted.
local function onMapShown()
	if not anyWorld() then return end
	local first = not mapSeen
	mapSeen = true
	if Rares.Codex(true) and first then Rares.RefreshPins() end -- a fresh load fires CODEX_LOADED
end

-- The world map's view (Core/MapCanvas.lua) says when it opens; the map is
-- only read.
local hooked = false
local function hookMap()
	if hooked then return end
	local M = ns.MapCanvas
	if not (M and WorldMapFrame) then return end
	hooked = M.Watch(WorldMapFrame, function(_, what)
		if what == "show" then onMapShown() end
	end) ~= nil
end

local function minimapLoad()
	if anyMinimap() then Rares.Codex(true) end
end

-- A new sighting lights its pins; at most one rebuild per half minute.
local dirty = false
local function onHistory()
	if dirty or not (lists.rare or lists.treasure) then return end
	dirty = true
	local function run()
		dirty = false
		Rares.RefreshPins()
	end
	if C_Timer and C_Timer.After then C_Timer.After(30, run) else run() end
end

-- Never inside Codex.Load: the first search or tooltip that loads it must
-- not pay for the pins. Nothing is decoded unless a layer is due.
ns.On("CODEX_LOADED", function()
	lists, building = {}, {}
	later(Rares.RefreshPins)
end)
ns.On("RARES_HISTORY", onHistory)

ns.On("SETTING_CHANGED", function(path)
	if not ns.IsLoggedIn() then return end
	if path == "" or path == "rares" or (type(path) == "string" and path:find("^rares%.")) then
		if path ~= "rares.toastPoint" then
			if WorldMapFrame and WorldMapFrame:IsShown() then onMapShown() end
			minimapLoad()
			Rares.RefreshPins()
		end
	end
end)

ns.RegisterEvent("ADDON_LOADED", function(_, name)
	if name == "Blizzard_WorldMap" and ns.IsLoggedIn() then hookMap() end
end)
ns.RegisterEvent("PLAYER_LEVEL_UP", function()
	if Rares.Get("hideGrey") then Rares.RefreshPins() end
end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	-- A minimap kind wanted the Codex while the player was fighting.
	if anyMinimap() and not Rares.Codex(false) then minimapLoad() end
end)

ns.OnLogin(function()
	hookMap()
	local T = ns.Theme
	if T and T.OnChanged then
		T.OnChanged(function()
			if lists.rare or lists.treasure then Rares.RefreshPins() end
		end)
	end
	if C_Timer and C_Timer.After then C_Timer.After(5, minimapLoad) else minimapLoad() end
	Rares.RefreshPins()
end)
