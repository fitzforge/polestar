-- Polestar.Maps (docs/ARCHITECTURE.md, "Maps"): the world
-- map without fog of war, coordinates, zone level ranges, dungeon entrance and
-- travel icons, the flight timer and the instance tracker. This file holds the
-- namespace, the settings and their options page, and helpers the feature
-- files share.
--
-- Every client call goes through Polestar.Compat where Compat has it; the few
-- Maps needs that Compat lacks (taxi, saved instances, instance info) are
-- wrapped in Maps.Client below, each checked against the Forever 1.60.1
-- FrameXML/API documentation and guarded so a missing one degrades to nil.

local ADDON, ns = ...
local L = ns.L

local type, floor, format, pcall = type, math.floor, string.format, pcall

local Maps = {}
ns.Maps = Maps

ns.RegisterDefaults("maps", {
	zoneLevels = true,      -- level ranges on the continent and zone maps
	coords = true,          -- player and cursor coordinates on the world map
	minimapCoords = false,  -- a small player coordinate readout on the minimap
	reveal = "tint",        -- unexplored areas: "off" | "on" (revealed) | "tint" (revealed, tinted)
	dungeonPins = false,    -- dungeon entrances on the world map (from the Codex pack)
	taxiPins = false,       -- flight masters
	dockPins = false,       -- boats, zeppelins, tram
	innPins = false,        -- inns
	travelMinimap = false,  -- travel icons on the minimap too
	flightTimer = true,
	instances = true,       -- record instance entries and runs
	instanceDisplay = false, -- compact tracker on screen, opt in
	perHour = 5,            -- Classic: 5 instances per hour per account
	perDay = 30,            -- Classic Era: 30 instances per day per account (0 = no daily cap)
	timerPos = false,       -- { point, x, y } once dragged
	trackerPos = false,
})

---------------------------------------------------------------------------
-- Shared helpers
---------------------------------------------------------------------------

-- 75 -> "1:15", 3725 -> "1:02:05".
function Maps.FormatTime(seconds)
	seconds = floor((seconds or 0) + 0.5)
	if seconds < 0 then seconds = 0 end
	local h = floor(seconds / 3600)
	local m = floor(seconds % 3600 / 60)
	local s = seconds % 60
	if h > 0 then return format("%d:%02d:%02d", h, m, s) end
	return format("%d:%02d", m, s)
end

-- Map percent (0-100) to one decimal: 42.04, 30 -> "42.0, 30.0"; nil -> "—".
-- Rounded half up on the tenth, so the readout never flickers between two
-- renderings of the same position.
function Maps.FormatCoords(x, y)
	if not (type(x) == "number" and type(y) == "number") then return "—" end
	return format("%.1f, %.1f", floor(x * 10 + 0.5) / 10, floor(y * 10 + 0.5) / 10)
end

-- 1 Alliance, 2 Horde, 0 anything else (TravelData faction masks).
function Maps.Faction()
	local C = ns.Compat
	local info = C and C.GetPlayerInfo and C.GetPlayerInfo()
	local f = info and info.faction
	return f == "Alliance" and 1 or f == "Horde" and 2 or 0
end

-- A faction mask this character may use (3 = both).
function Maps.Allowed(mask, faction)
	return mask == 3 or (faction ~= 0 and mask == faction)
end

-- A saved table under CharState(), recreated when SavedVariables came back nil.
function Maps.CharTable(key)
	local s = ns.CharState()
	if type(s[key]) ~= "table" then s[key] = {} end
	return s[key]
end

-- Account-wide data (the instance cap is per account): PolestarDB[key].
function Maps.AccountTable(key)
	local db = ns.DB()
	if type(db[key]) ~= "table" then db[key] = {} end
	return db[key]
end

---------------------------------------------------------------------------
-- Client calls Compat does not cover (verified against Forever FrameXML)
---------------------------------------------------------------------------

local Client = {}
Maps.Client = Client

local readable = ns.Compat.Readable

-- name, instanceType ("party"|"raid"|...), difficultyID, instanceID (map) | nil
function Client.GetInstance()
	if not (IsInInstance and GetInstanceInfo) then return nil end
	local inside, kind = IsInInstance()
	if not inside then return nil end
	local name, itype, difficultyID, _, _, _, _, instanceID = GetInstanceInfo()
	return name, itype or kind, difficultyID, instanceID
end

-- { { name, id, reset (seconds), difficulty, locked, extended, isRaid, maxPlayers,
--     difficultyName, total, done }, ... }   (GetSavedInstanceInfo, as
-- Blizzard_GroupFinder_VanillaStyle reads it on Forever)
function Client.GetSavedInstances()
	local out = {}
	if not (GetNumSavedInstances and GetSavedInstanceInfo) then return out end
	for i = 1, GetNumSavedInstances() or 0 do
		local name, id, reset, difficulty, locked, extended, _, isRaid, maxPlayers, difficultyName, total, done = GetSavedInstanceInfo(i)
		if name then
			out[#out + 1] = {
				name = name, id = id, reset = reset or 0, difficulty = difficulty,
				locked = locked and true or false, extended = extended and true or false,
				isRaid = isRaid and true or false, maxPlayers = maxPlayers,
				difficultyName = difficultyName, total = total, done = done,
			}
		end
	end
	return out
end

function Client.RequestRaidInfo()
	if RequestRaidInfo then RequestRaidInfo() end
end

-- XP state: level, xp, xpMax (UnitXP may be secret in combat: nil then).
function Client.GetXP()
	local level = readable(UnitLevel and UnitLevel("player"))
	local xp = readable(UnitXP and UnitXP("player"))
	local xpMax = readable(UnitXPMax and UnitXPMax("player"))
	return level, xp, xpMax
end

-- The taxi map's nodes: current node and the node in `slot`, as
-- (nodeID or nil, name). C_TaxiMap.GetAllTaxiNodes gives node IDs; the slot
-- API (TaxiNodeName/TaxiNodeGetType) gives names on any client.
function Client.TaxiSlot(slot)
	local id, name
	local mapID = GetTaxiMapID and GetTaxiMapID()
	if mapID and C_TaxiMap and C_TaxiMap.GetAllTaxiNodes then
		local ok, list = pcall(C_TaxiMap.GetAllTaxiNodes, mapID)
		if ok and type(list) == "table" then
			for i = 1, #list do
				local info = list[i]
				if type(info) == "table" and info.slotIndex == slot then
					id, name = info.nodeID, info.name
					break
				end
			end
		end
	end
	if not name and TaxiNodeName then
		name = TaxiNodeName(slot)
		if name == "" then name = nil end
	end
	return id, name
end

function Client.TaxiCurrent()
	if not (NumTaxiNodes and TaxiNodeGetType) then return nil end
	for i = 1, NumTaxiNodes() or 0 do
		if TaxiNodeGetType(i) == "CURRENT" then return Client.TaxiSlot(i) end
	end
	return nil
end

---------------------------------------------------------------------------
-- Options: the map features on the Map page (its sections are declared by
-- the options window, UI/Options.lua); the flight timer and the instance
-- tracker on the Quality of Life page (Travel and Trackers)
---------------------------------------------------------------------------

local function off(key)
	return function() return not ns.Get(key) end
end

local MAP = L["Map"]

local function register(spec)
	if not ns.RegisterOptions then return end
	local ok, err = ns.RegisterOptions(spec)
	if not ok and err then ns.Debug(err) end
end

register({
	page = MAP, tab = L["Rares & travel"], section = L["Dungeons and travel"],
	controls = {
		{ kind = "toggle", key = "maps.dungeonPins", label = L["Dungeon entrances"],
			help = L["Marks each dungeon entrance with its level range. Click to open the dungeon's guide, or to set a waypoint when there is none; Shift-click always sets a waypoint. Needs the Codex pack."] },
		{ kind = "toggle", key = "maps.taxiPins", label = L["Flight masters"],
			help = L["Your faction's and neutral flight masters: green when known, amber when not yet discovered. The tooltip lists destinations and flight times."] },
		{ kind = "toggle", key = "maps.dockPins", label = L["Boats and zeppelins"],
			help = L["Docks, zeppelin towers and the Deeprun Tram, with where they go."] },
		{ kind = "toggle", key = "maps.innPins", label = L["Inns"],
			help = L["Innkeepers; the one your Hearthstone is bound to is marked."] },
		{ kind = "toggle", key = "maps.travelMinimap", label = L["Travel icons on the minimap"],
			help = L["Shows the flight masters, docks and inns turned on here on the minimap as well."] },
	},
})

register({
	page = MAP, tab = L["Zones"], section = L["Zones"],
	controls = {
		{ kind = "dropdown", key = "maps.reveal", label = L["Unexplored areas"],
			help = L["Shows the parts of each zone you have not explored yet, so the whole map is there before you visit. Tinted keeps them apart from where you have been."],
			choices = { { value = "off", label = L["Hidden"] }, { value = "on", label = L["Revealed"] }, { value = "tint", label = L["Revealed and tinted"] } } },
		{ kind = "toggle", key = "maps.zoneLevels", label = L["Zone level ranges"],
			help = L["Shows each zone's level range on the continent and zone maps, coloured by difficulty for your level."] },
	},
})

register({
	page = MAP, tab = L["Zones"], section = L["Coordinates"],
	controls = {
		{ kind = "toggle", key = "maps.coords", label = L["Coordinates"],
			help = L["Shows your position and the cursor's position under the world map."] },
		{ kind = "toggle", key = "maps.minimapCoords", label = L["Coordinates on the minimap"],
			help = L["A small readout of your position at the bottom of the minimap."] },
	},
})

-- The flight timer and the instance tracker join Quality of Life's Travel
-- and Trackers tabs; their sections are declared there, in order.
do
	local QOL = L["Quality of Life"]
	register({
		page = QOL, tab = L["Travel"], section = L["Flight timer"],
		controls = {
			{ kind = "toggle", key = "maps.flightTimer", label = L["Flight timer"],
				help = L["While flying, shows the destination and the time left. Learns each route's real duration for this character; drag to move."] },
			{ kind = "button", label = L["Forget learned flight times"],
				help = L["Clears this character's recorded flight durations; estimates are used until they are flown again."],
				onClick = function()
					ns.CharState().flightTimes = {}
					ns.Print(L["Learned flight times cleared."])
				end },
		},
	})
	register({
		page = QOL, tab = L["Trackers"], section = L["Instances"],
		controls = {
			{ kind = "toggle", key = "maps.instances", label = L["Track instances"],
				help = L["Records dungeon and raid entries, time and experience per run. /pole instances lists them."] },
			{ kind = "toggle", key = "maps.instanceDisplay", label = L["Compact display"],
				help = L["Shows the hourly instance count and the current run while it matters; drag to move."],
				disabled = off("maps.instances") },
		},
	})
	register({
		page = QOL, tab = L["Trackers"], section = L["Instance limits"],
		controls = {
			{ kind = "slider", key = "maps.perHour", label = L["Instances per hour"], min = 1, max = 10, step = 1, format = "%d",
				help = L["Classic allows 5 new instances per hour per account. Forever may differ; adjust if it does."],
				disabled = off("maps.instances") },
			{ kind = "slider", key = "maps.perDay", label = L["Instances per day"], min = 0, max = 60, step = 1, format = "%d",
				help = L["Classic Era allows 30 new instances per 24 hours per account; 0 ignores the daily cap. Forever may differ."],
				disabled = off("maps.instances") },
			{ kind = "button", label = L["Clear instance history"],
				help = L["Forgets recorded entries and runs (the server's own limit is not affected)."],
				onClick = function() if Maps.ClearInstances then Maps.ClearInstances() end end },
		},
	})
end

---------------------------------------------------------------------------
-- Draggable compact frames (flight timer, instance tracker)
---------------------------------------------------------------------------

-- A small panel on UIParent; its position persists in setting `posKey`.
function Maps.CompactFrame(name, posKey, defaultPoint, dx, dy)
	local f = CreateFrame("Frame", name, UIParent)
	f:SetFrameStrata("MEDIUM")
	f:SetClampedToScreen(true)
	f:SetMovable(true)
	f:EnableMouse(true)
	f:RegisterForDrag("LeftButton")
	local T = ns.Theme
	if T and T.Skin then T.Skin(f, "panel") end
	local function place()
		f:ClearAllPoints()
		local p = ns.Get(posKey)
		if type(p) == "table" and type(p[1]) == "string" then
			f:SetPoint(p[1], UIParent, p[1], p[2] or 0, p[3] or 0)
		else
			f:SetPoint(defaultPoint, UIParent, defaultPoint, dx, dy)
		end
	end
	f:SetScript("OnDragStart", function(self) self:StartMoving() end)
	f:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local cx, cy = self:GetCenter()
		local ux, uy = UIParent:GetCenter()
		local s = self:GetEffectiveScale() / UIParent:GetEffectiveScale()
		ns.Set(posKey, { "CENTER", floor(cx * s - ux + 0.5), floor(cy * s - uy + 0.5) })
	end)
	f.Place = place
	place()
	f:Hide()
	return f
end
