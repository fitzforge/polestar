-- World map zone info:
--   * on a continent map, every zone's level range drawn at the zone (name
--     and range, coloured by difficulty for the player's level), and the
--     range of the zone under the cursor in the info bar;
--   * on a zone map, that zone's range in the info bar;
--   * player and cursor coordinates (map percent) in the info bar.
-- Level ranges come from ZoneLevels.lua (`node tools/polestar.js maps build`,
-- heuristic in tools/lib/maps/zonelevels.js).
--
-- The world map's view (Core/MapCanvas.lua) tells us about map, size and
-- zoom changes, reading the map and writing nothing into it; labels are
-- Polestar's own frames on the canvas, counter-scaled so they keep their
-- size when zooming. The info bar, Polestar's frame on the map, ticks ten
-- times a second while the map is open and repaints only when a shown
-- number changed.

local ADDON, ns = ...
local Maps = ns.Maps
local L = ns.L

local type, pairs, floor = type, pairs, math.floor

local CONTINENT, ZONE = 2, 3 -- Enum.UIMapType
local TICK = 0.1

---------------------------------------------------------------------------
-- Data
---------------------------------------------------------------------------

local levels = {} -- uiMapID -> { min, max, labelX, labelY }

function Maps.RegisterZoneLevels(tbl)
	if type(tbl) ~= "table" then return end
	for id, v in pairs(tbl) do
		if type(v) == "table" and type(v[1]) == "number" and type(v[2]) == "number" then levels[id] = v end
	end
end

-- min, max | nil
function Maps.GetZoneLevels(uiMapID)
	local v = uiMapID and levels[uiMapID]
	if not v then return nil end
	return v[1], v[2]
end

-- Every zone with a level range: for uiMapID, min, max in Maps.EachZoneLevels() do ... end
function Maps.EachZoneLevels()
	local id
	return function()
		local v
		id, v = next(levels, id)
		if id ~= nil then return id, v[1], v[2] end
	end
end

-- Palette name for a zone's range seen from `level`: red well under it,
-- amber just under, gold inside, green a little over, muted when trivial.
function Maps.LevelColor(min, max, level)
	if not (min and max and level) then return "textDim" end
	if level < min - 2 then return "danger" end
	if level < min then return "warning" end
	if level <= max then return "quest" end
	if level <= max + 5 then return "success" end
	return "textMuted"
end

-- "1-10" (en dash)
function Maps.FormatLevels(min, max)
	if min == max then return tostring(min) end
	return min .. "–" .. max
end

local function playerLevel()
	local C = ns.Compat
	local info = C and C.GetPlayerInfo and C.GetPlayerInfo()
	return info and info.level
end

local function mapInfo(id)
	return id and C_Map and C_Map.GetMapInfo and C_Map.GetMapInfo(id) or nil
end

---------------------------------------------------------------------------
-- Zone labels on the continent canvas
---------------------------------------------------------------------------

local view, owner
local labels, used = {}, 0

local function label(i)
	local f = labels[i]
	if f then return f end
	local W = ns.Widgets
	local T = ns.Theme
	f = ns.CreateFrameUnder("Frame", nil, view.canvas)
	f:SetSize(120, 30)
	f.Name = W.Text(f, "small", "textDim")
	f.Name:SetPoint("BOTTOM", f, "CENTER", 0, 0)
	f.Name:SetJustifyH("CENTER")
	f.Range = W.Text(f, "number", "quest")
	f.Range:SetPoint("TOP", f, "CENTER", 0, -1)
	f.Range:SetJustifyH("CENTER")
	if T and T.SetOutline then
		T.SetOutline(f.Name, true)
		T.SetOutline(f.Range, true)
	end
	labels[i] = f
	return f
end

local function hideLabels(from)
	for i = from, #labels do labels[i]:Hide() end
end

local function placeLabels()
	if not view then return end
	local canvas = view.canvas
	local inv = 1 / view.scale
	local w, h = view.width, view.height
	for i = 1, used do
		local f = labels[i]
		f:SetScale(inv)
		f:ClearAllPoints()
		f:SetPoint("CENTER", canvas, "TOPLEFT", f.nx * w / inv, -f.ny * h / inv)
	end
end

local function layoutLabels()
	used = 0
	local mapID = view and view.mapID
	local info = mapInfo(mapID)
	if not (info and info.mapType == CONTINENT and ns.Get("maps.zoneLevels") and C_Map.GetMapRectOnMap) then
		hideLabels(1)
		return
	end
	local W = ns.Widgets
	if not W then return end
	local level = playerLevel()
	for zone, v in pairs(levels) do
		local minX, maxX, minY, maxY = C_Map.GetMapRectOnMap(zone, mapID)
		local child = minX and mapInfo(zone)
		if child and child.parentMapID == mapID and maxX > minX then
			used = used + 1
			local f = label(used)
			f.nx = minX + (maxX - minX) * (v[3] or 50) / 100
			f.ny = minY + (maxY - minY) * (v[4] or 50) / 100
			f.Name:SetText(child.name)
			f.Range:SetText(Maps.FormatLevels(v[1], v[2]))
			W.Color(f.Range, Maps.LevelColor(v[1], v[2], level))
			f:Show()
		end
	end
	hideLabels(used + 1)
	placeLabels()
end

---------------------------------------------------------------------------
-- Info bar: zone range, player and cursor coordinates
---------------------------------------------------------------------------

local bar
local shownZone, shownPX, shownPY, shownCX, shownCY
local acc = 0

local function tenth(v)
	return v and floor(v * 10 + 0.5) or nil
end

-- Player position on the viewed map, percent.
local function playerOn(mapID)
	local C = ns.Compat
	if not (C and C.GetPlayerMapPosition) then return nil end
	local m, x, y = C.GetPlayerMapPosition()
	if not m then return nil end
	if m == mapID then return x, y end
	local c, wx, wy = C.MapToWorld(m, x, y)
	if not c then return nil end
	x, y = C.WorldToMap(c, wx, wy, mapID)
	if x and x >= 0 and x <= 100 and y >= 0 and y <= 100 then return x, y end
	return nil
end

-- Zone whose range the bar shows: the viewed zone, or the zone under the
-- cursor on a continent.
local function zoneFor(mapID, info, cx, cy)
	if not info then return nil end
	if info.mapType == ZONE then return mapID end
	if info.mapType == CONTINENT and cx and C_Map.GetMapInfoAtPosition then
		local at = C_Map.GetMapInfoAtPosition(mapID, cx / 100, cy / 100)
		return at and at.mapID ~= mapID and at.mapID or nil
	end
	return nil
end

local function update(force)
	local mapID = view.mapID
	local coords, zones = ns.Get("maps.coords"), ns.Get("maps.zoneLevels")
	local cx, cy
	if owner.GetNormalizedCursorPosition and (not owner.IsCanvasMouseFocus or owner:IsCanvasMouseFocus()) then
		local nx, ny = owner:GetNormalizedCursorPosition()
		if nx and nx >= 0 and nx <= 1 and ny >= 0 and ny <= 1 then cx, cy = nx * 100, ny * 100 end
	end
	local px, py
	if coords then px, py = playerOn(mapID) end
	local tcx, tcy, tpx, tpy = tenth(cx), tenth(cy), tenth(px), tenth(py)
	local zone
	if zones then
		if tcx ~= shownCX or tcy ~= shownCY or force then
			zone = zoneFor(mapID, mapInfo(mapID), cx, cy)
		else
			zone = shownZone
		end
	end
	if not force and zone == shownZone and tpx == shownPX and tpy == shownPY
		and ((tcx == shownCX and tcy == shownCY) or not coords) then
		return
	end
	shownZone, shownPX, shownPY, shownCX, shownCY = zone, tpx, tpy, tcx, tcy

	local lo, hi = Maps.GetZoneLevels(zone)
	if lo then
		local info = mapInfo(zone)
		bar.Zone:SetText((info and info.name or "") .. "  " .. Maps.FormatLevels(lo, hi))
		local W = ns.Widgets
		if W then W.Color(bar.Zone, Maps.LevelColor(lo, hi, playerLevel())) end
	else
		bar.Zone:SetText("")
	end
	if coords then
		local p = L["Player"] .. " " .. Maps.FormatCoords(tpx and tpx / 10, tpy and tpy / 10)
		if tcx then p = p .. "     " .. L["Cursor"] .. " " .. Maps.FormatCoords(tcx / 10, tcy / 10) end
		bar.Coords:SetText(p)
	else
		bar.Coords:SetText("")
	end
end

local function barWanted()
	return ns.Get("maps.coords") or ns.Get("maps.zoneLevels")
end

local function buildBar()
	local W = ns.Widgets
	if bar or not W then return end
	local host = owner.ScrollContainer or owner
	bar = ns.CreateFrameUnder("Frame", "PolestarMapInfo", owner)
	bar:SetHeight(22)
	bar:SetPoint("BOTTOMLEFT", host, "BOTTOMLEFT", 0, 0)
	bar:SetPoint("BOTTOMRIGHT", host, "BOTTOMRIGHT", 0, 0)
	bar:SetFrameLevel((host:GetFrameLevel() or 1) + 20)
	local bg = W.Fill(bar, "bg")
	bg:SetAlpha(0.82)
	local rule = W.Divider(bar)
	rule:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
	rule:SetPoint("TOPRIGHT", bar, "TOPRIGHT", 0, 0)
	bar.Zone = W.Text(bar, "small", "quest")
	bar.Zone:SetPoint("LEFT", bar, "LEFT", 10, 0)
	bar.Coords = W.Text(bar, "small", "textDim")
	bar.Coords:SetPoint("RIGHT", bar, "RIGHT", -10, 0)
	bar.Coords:SetJustifyH("RIGHT")
	bar:SetScript("OnUpdate", function(_, dt)
		acc = acc + dt
		if acc < TICK then return end
		acc = 0
		update(false)
	end)
end

local function refreshBar()
	if not bar then return end
	if barWanted() then
		bar:Show()
		update(true)
	else
		bar:Hide()
	end
end

---------------------------------------------------------------------------
-- The view
---------------------------------------------------------------------------

local function onView(_, what)
	if what == "show" or what == "map" then
		layoutLabels()
		refreshBar()
	elseif what == "size" or what == "scale" then
		placeLabels()
	end
end

local function install()
	if view then return true end
	local M = ns.MapCanvas
	view = WorldMapFrame and M and M.Watch(WorldMapFrame, onView) or nil
	if not view then return false end
	owner = WorldMapFrame
	buildBar()
	return true
end

function Maps.RefreshWorldMap()
	if view and view.shown then
		layoutLabels()
		refreshBar()
	end
end

ns.On("SETTING_CHANGED", function(path)
	if path == "maps.zoneLevels" or path == "maps.coords" or path == "maps" or path == "" then Maps.RefreshWorldMap() end
end)

ns.RegisterEvent("PLAYER_LEVEL_UP", function() Maps.RefreshWorldMap() end)

ns.OnLogin(function()
	if install() then return end
	local function onLoaded(_, name)
		if name == "Blizzard_WorldMap" and install() then ns.UnregisterEvent("ADDON_LOADED", onLoaded) end
	end
	ns.RegisterEvent("ADDON_LOADED", onLoaded)
end)
