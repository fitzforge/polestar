-- What Polestar adds to OpenMap's own interface (Nav/OpenMap.lua hands it
-- over; OpenMap is optional and nothing here runs without it):
--   its menu    a switch per Polestar map layer, under "Polestar", that can
--               be starred onto OpenMap's button tray like its own
--   opening     with maps.openmapAtTarget, the stitched view glides to the
--               guide's target as the map opens
--   its dungeon card
--               Polestar's journal for the dungeon on the map: its quests for
--               this character (in the log, done, still to pick up) and its
--               attunements, with the command that opens the full page

local ADDON, ns = ...
local OpenMap = ns.OpenMap
if not OpenMap then return end
local L = ns.L

local format, ipairs = string.format, ipairs

local UI_MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\UI\\"
local NAV_MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Nav\\"

-- The switches, in the order they show. tab "show" is OpenMap's "On the
-- map", "look" how it looks.
for _, spec in ipairs({
	{ id = "guidePins", label = L["Guide pins"], setting = "nav.worldPins", icon = NAV_MEDIA .. "pin-fill" },
	{ id = "routeLines", label = L["Route lines"], setting = "nav.routeLines", icon = NAV_MEDIA .. "sparkle" },
	{ id = "dungeons", label = L["Dungeon entrances"], setting = "maps.omDungeonPins", icon = UI_MEDIA .. "game-dungeon" },
	{ id = "flightMasters", label = L["Flight masters"], setting = "maps.omTaxiPins", icon = UI_MEDIA .. "game-flight-neutral" },
	{ id = "docks", label = L["Boats and zeppelins"], setting = "maps.omDockPins", icon = UI_MEDIA .. "game-boat" },
	{ id = "inns", label = L["Inns"], setting = "maps.omInnPins", icon = UI_MEDIA .. "game-inn" },
	{ id = "services", label = L["NPC services"], setting = "maps.omServicePins", icon = UI_MEDIA .. "icon-vendor" },
	{ id = "network", label = L["Travel network"], setting = "maps.omTravelNetwork", icon = UI_MEDIA .. "game-flight-neutral" },
	{ id = "stepPreview", label = L["Steps ahead"], setting = "nav.stepPreview", icon = UI_MEDIA .. "icon-goto" },
	{ id = "lineFlow", label = L["Moving lines"], setting = "nav.lineFlow", icon = NAV_MEDIA .. "sparkle", tab = "look" },
	{ id = "lineLabels", label = L["Leg labels"], setting = "nav.lineLabels", icon = UI_MEDIA .. "info", tab = "look" },
	{ id = "lineWalkTime", label = L["Walking time on labels"], setting = "nav.lineWalkTime", icon = UI_MEDIA .. "hourglass", tab = "look" },
	{ id = "atTarget", label = L["Open at the guide's target"], setting = "maps.openmapAtTarget", icon = UI_MEDIA .. "icon-goto", tab = "more" },
}) do
	OpenMap.Toggle(spec)
end

---------------------------------------------------------------------------
-- Opening at the target
---------------------------------------------------------------------------

ns.RegisterDefaults("maps", { openmapAtTarget = false })

local watching = false
local function watch()
	if watching then return end
	local M = ns.MapCanvas
	if not (WorldMapFrame and M and M.Watch) then return end
	watching = M.Watch(WorldMapFrame, function(_, what)
		if what ~= "show" or not ns.Get("maps.openmapAtTarget") then return end
		local Nav = ns.Nav
		local c, wx, wy = Nav and Nav.GetTargetWorld and Nav.GetTargetWorld()
		if not c then return end
		-- OpenMap places its view as the map opens: glide once it has.
		if C_Timer and C_Timer.After then C_Timer.After(0, function() OpenMap.Show(c, wx, wy) end) end
	end) and true or false
end
ns.OnLogin(watch)
ns.RegisterEvent("ADDON_LOADED", function(_, name)
	if name == "Blizzard_WorldMap" and ns.IsLoggedIn() then watch() end
end)

---------------------------------------------------------------------------
-- The dungeon card
---------------------------------------------------------------------------

local MAX_LINES = 40 -- OpenMap shows at most this many

local function hex(name)
	local T = ns.Theme
	return T and T.Hex and T.Hex(name) or "ffffffff"
end

local function faction()
	local f = ns.Maps and ns.Maps.Faction and ns.Maps.Faction()
	return f == 1 and "A" or f == 2 and "H" or nil
end

-- A quest's line: its level and title, coloured by where this character is with it.
local function questLine(q)
	local C = ns.Compat
	local state, color
	if C.IsQuestCompleted(q.id) then
		state, color = L["done"], "textMuted"
	elseif C.IsOnQuest(q.id) then
		state, color = L["in your log"], "success"
	else
		state, color = nil, "text"
	end
	local text = format("|c%s[%d] %s|r", hex(color), q.level or 0, q.title or ("#" .. q.id))
	if state then text = text .. format(" |c%s(%s)|r", hex("textDim"), state) end
	return text
end

-- OpenMap's info -> title, lines (nil for nothing to add).
local function section(info)
	local D = ns.Dungeons
	if not (D and D.IsEnabled and D.IsEnabled() and D.Load and D.Load()) then return nil end
	local lines, side = {}, faction()
	for _, inst in ipairs(type(info) == "table" and info.instances or {}) do
		local key = inst.name and D.Find(inst.name)
		if key then
			local quests = D.Quests(key, side) or {}
			local open, inLog = 0, 0
			for _, q in ipairs(quests) do
				if not ns.Compat.IsQuestCompleted(q.id) then
					open = open + 1
					if ns.Compat.IsOnQuest(q.id) then inLog = inLog + 1 end
				end
			end
			if #info.instances > 1 then lines[#lines + 1] = format("|c%s%s|r", hex("accent"), inst.name) end
			if #quests > 0 then
				lines[#lines + 1] = format(L["%d quests to do, %d in your log"], open, inLog)
				for _, q in ipairs(quests) do
					if #lines >= MAX_LINES - 2 then break end
					lines[#lines + 1] = questLine(q)
				end
			else
				lines[#lines + 1] = format("|c%s%s|r", hex("textDim"), L["No quests for this dungeon."])
			end
			local attune = D.Attunements and D.Attunements(key, side) or {}
			for _, a in ipairs(attune) do
				if #lines >= MAX_LINES - 1 then break end
				lines[#lines + 1] = format("|c%s%s|r", hex("warning"), format(L["Attunement: %s"], a.name or "?"))
			end
			if #lines < MAX_LINES then
				lines[#lines + 1] = format("|c%s%s|r", hex("textDim"), format(L["Full page: /polestar dungeons %s"], inst.name))
			end
		end
	end
	if #lines == 0 then return nil end
	return L["Polestar"], lines
end

OpenMap.DungeonSection(section)
