-- Dungeon entrances on the world map, through Polestar.Pins: one pin per entrance with the
-- dungeon's level range in its tooltip. A click opens the dungeon's page in
-- the hub (Polestar.Dungeons.Open), or sets a waypoint when the Dungeons
-- module is off; Shift-click always sets the waypoint.
--
-- Entrances come from the Codex pack's instances (data/forever/dungeons.json
-- is not licence-clean, so the core ships none). The pack is local and loads
-- on demand: this file never loads it at login, only the first time the world
-- map opens with the setting on, or it builds as soon as something else
-- loaded the Codex (CODEX_LOADED). With the setting off nothing loads and the
-- layer is cleared.

local ADDON, ns = ...
local Maps = ns.Maps
local L = ns.L

local type, ipairs, format = type, ipairs, string.format

local LAYER = "maps.dungeons"

local function rgb(name)
	local T = ns.Theme
	if T and T.Color then return T.Color(name) end
	return 1, 1, 1
end

local function playerLevel()
	local C = ns.Compat
	local info = C and C.GetPlayerInfo and C.GetPlayerInfo()
	return info and info.level
end

-- The dungeon's page can open: the Dungeons module is there and on.
local function canOpen()
	local D = ns.Dungeons
	return D and D.Open and D.IsEnabled and D.IsEnabled() and true or false
end

local function openPage(key)
	local D = ns.Dungeons
	if D and D.Open then D.Open(key) end
end

-- Codex levels are { min, recommended min, recommended max }: the range a
-- group runs it at.
local function rangeOf(rec)
	local lv = rec.levels
	if type(lv) ~= "table" then return nil end
	local lo, hi = lv[2] or lv[1], lv[3] or lv[2] or lv[1]
	if not (lo and hi) then return nil end
	return lo, hi
end

local function waypoint(rec)
	local N, e = ns.Nav, rec.entrance
	if N and N.SetTarget then N.SetTarget(e.map, e.x, e.y, rec.name, e.f, "dungeon") end
end

local function tooltip(rec, page)
	return function(tip)
		tip:SetText(rec.name or rec.key, rgb("text"))
		local lo, hi = rangeOf(rec)
		local kind = rec.kind == "raid" and L["Raid"] or L["Dungeon"]
		if lo then
			tip:AddLine(format("%s · %s %s", kind, L["Levels"], Maps.FormatLevels(lo, hi)), rgb(Maps.LevelColor(lo, hi, playerLevel())))
		else
			tip:AddLine(kind, rgb("textDim"))
		end
		tip:AddLine(" ")
		if page then
			tip:AddLine(L["Click to open its page"], rgb("textDim"))
			tip:AddLine(L["Shift-click to set a waypoint"], rgb("textDim"))
		else
			tip:AddLine(L["Click to set a waypoint"], rgb("textDim"))
		end
	end
end

-- Pure: o = { instances = { codex instance record, ... }, page = bool (the
-- dungeon page can open), open = function(key) (default Dungeons.Open) }
-- -> pins (only instances with an entrance), in the order given
function Maps.BuildDungeonPins(o)
	local pins = {}
	if type(o) ~= "table" or type(o.instances) ~= "table" then return pins end
	local page = o.page and true or false
	local open = o.open or openPage
	local r, g, b = rgb("dungeon")
	local color = { r, g, b, 1 }
	for _, rec in ipairs(o.instances) do
		local e = type(rec) == "table" and rec.entrance
		if type(e) == "table" and e.map and e.x and e.y then
			pins[#pins + 1] = {
				map = e.map, x = e.x, y = e.y, f = e.f,
				icon = "icon-dungeon", size = 16, color = color, priority = 2,
				key = rec.key, page = page,
				tooltip = tooltip(rec, page),
				onClick = function(button)
					if button ~= "LeftButton" then return end
					if page and not (IsShiftKeyDown and IsShiftKeyDown()) then
						open(rec.key)
					else
						waypoint(rec)
					end
				end,
			}
		end
	end
	return pins
end

---------------------------------------------------------------------------
-- Applying the layer
---------------------------------------------------------------------------

local function codexInstances()
	local X = ns.Codex
	if not (X and X.IsLoaded and X.IsLoaded() and X.Each and X.Instance) then return nil end
	local list = {}
	X.Each("instance", function(key)
		local rec = X.Instance(key)
		if rec and rec.entrance then list[#list + 1] = rec end
	end)
	table.sort(list, function(a, b) return (a.key or "") < (b.key or "") end)
	return list
end

function Maps.RefreshDungeonPins()
	local Pins = ns.Pins
	if not (Pins and Pins.SetLayer) then return end
	local list = ns.Get("maps.dungeonPins") and codexInstances()
	local pins = list and Maps.BuildDungeonPins({ instances = list, page = canOpen() })
	if pins and #pins > 0 then
		Pins.SetLayer(LAYER, pins, { world = true, minimap = false, edge = false })
	else
		Pins.ClearLayer(LAYER)
	end
end

-- The world map opened: load the Codex the first time pins are wanted.
local function onMapShown()
	if not ns.Get("maps.dungeonPins") then return end
	local X = ns.Codex
	if X and X.IsLoaded and not X.IsLoaded() and X.Load then X.Load() end -- fires CODEX_LOADED
end

-- The world map's view (Core/MapCanvas.lua) says when it opens; the map is
-- only read.
local hooked = false
local function hookMap()
	if hooked then return true end
	local M = ns.MapCanvas
	if not (M and WorldMapFrame and M.Watch(WorldMapFrame, function(_, what)
		if what == "show" then onMapShown() end
	end)) then
		return false
	end
	hooked = true
	return true
end

ns.On("CODEX_LOADED", Maps.RefreshDungeonPins)

ns.On("SETTING_CHANGED", function(path)
	if not ns.IsLoggedIn() then return end
	if path == "maps.dungeonPins" or path == "maps" or path == "" then
		if ns.Get("maps.dungeonPins") and WorldMapFrame and WorldMapFrame:IsShown() then onMapShown() end
		Maps.RefreshDungeonPins()
	end
end)

ns.RegisterEvent("ADDON_LOADED", function(_, name)
	if name == "Blizzard_WorldMap" and ns.IsLoggedIn() then hookMap() end
end)

ns.OnLogin(function()
	hookMap()
	local T = ns.Theme
	if T and T.OnChanged then
		T.OnChanged(function()
			if ns.Pins and ns.Pins.GetLayer and ns.Pins.GetLayer(LAYER) then Maps.RefreshDungeonPins() end
		end)
	end
	Maps.RefreshDungeonPins()
end)
