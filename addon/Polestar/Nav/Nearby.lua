-- Nearby services: the nearest trainer, vendor, inn, bank and the like, by
-- travel time, as the arrow's target.
--
-- Adapted from Shortest Path Forever by Cillian Berragan (GPL-3.0-or-later,
-- used with permission): UI/Nearby.lua (the services, the tracking-menu
-- entry and the command), here on Polestar's own data.
-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
--
--   /polestar near <kind> [profession]   kinds: trainer, class, repair, reagents, vendor,
--                                        innkeeper, bank, auction, flight, stable;
--                                        `/polestar near mining` = trainer mining
--   Nearby.Find(kind, line) -> place, seconds | nil, reason
--       reason "kind" | "combat" | "none" | a Codex failure: "missing" (not installed, or no
--       Codex module), "disabled" (off in the AddOns list), "empty" (loaded, but its NPC roles
--       read as nothing: a broken install), else Data.Pack's reason ("interface_version", "error"...)
--   Nearby.Go(kind, line) -> true | false   points the arrow there, says so in one line
--   Nearby.Rank(places, here, estimate) -> place, seconds   pure, for the tests
--   place = { id, name, map, x, y, f, z? }   z: the class trainer's height (Core/ClassTrainers.lua);
--           the Codex's places carry none
--
-- Data: the Codex's NPC roles (Polestar_Codex, loaded on demand, never in
-- combat), faction-filtered, outside instances; profession trainers by skill
-- line ("trainer:<line>"); reagent vendors from QoL.data.reagentVendors (qol
-- build); the class trainer from Engine.NearestClassTrainer, which ranks the
-- character's own trainers already. Each role's spawns are placed once per
-- session.
--
-- Ranking: the nearest spawn of each NPC by straight line, the player's
-- continent first; the RANKED nearest of those get the route planner's
-- estimate (Journey.Estimate: flights, boats, the Hearthstone) and the
-- quickest wins.
--
-- The world map's and the minimap's tracking menus carry a "Nearby services"
-- submenu (nav.nearbyMenu).

local ADDON, ns = ...
local Nav = ns.Nav
local L = ns.L

local type, ipairs, pairs, sqrt, huge = type, ipairs, pairs, math.sqrt, math.huge
local format, lower = string.format, string.lower

local Nearby = {}
Nav.nearby = Nearby

ns.RegisterDefaults("nav", { nearbyMenu = true, nearbyButton = true })

local RANKED = 6
local RUN_SPEED = 7
local RIDING = 762 -- Compat.SKILL_LINES' riding: no trainer role
local FACTION = { Alliance = "A", Horde = "H" }

-- `stop`: the stop kind the target carries (Nav.SetTarget), for Shortest Path Forever's badge.
local KINDS = {
	{ key = "trainer", label = L["Profession trainer"], stop = "trainer" },
	{ key = "class", label = L["Class trainer"], stop = "trainer" },
	{ key = "weapon", label = L["Weapon master"], stop = "trainer" },
	{ key = "repair", role = "repair", label = L["Repair"] },
	{ key = "reagents", role = "vendor", only = "reagentVendors", label = L["Reagents"] },
	{ key = "vendor", role = "vendor", label = L["Vendor"] },
	{ key = "innkeeper", role = "innkeeper", label = L["Innkeeper"], stop = "innkeeper" },
	{ key = "bank", role = "banker", label = L["Bank"] },
	{ key = "auction", role = "auctioneer", label = L["Auction house"] },
	{ key = "flight", role = "flightmaster", label = L["Flight master"], stop = "flightmaster" },
	{ key = "stable", role = "stablemaster", label = L["Stable master"] },
}
local BY_KEY = {}
for _, k in ipairs(KINDS) do BY_KEY[k.key] = k end
local ALIAS = {
	inn = "innkeeper", banker = "bank", ah = "auction", auctioneer = "auction", fp = "flight",
	flightmaster = "flight", stablemaster = "stable", reagent = "reagents", trainers = "trainer",
}
Nearby.KINDS = KINDS

---------------------------------------------------------------------------
-- Weapon masters
---------------------------------------------------------------------------

-- The weapon skills each weapon master teaches (the game's skill line ids),
-- and its side. From Ding! by Yendi (GPL-3.0, v1.8.1, commit fb0a06a,
-- tools/data/corrections/10_weapon_masters.lua): noted by hand and checked
-- against the trainer lists of cMaNGOS classic-db (GPL-3.0).
local WEAPON_MASTERS = {
	[11867] = { "A", 43, 55, 136, 173, 226, 229 }, -- Woo Ping, Stormwind
	[11865] = { "A", 44, 46, 54, 160, 172, 473 },  -- Buliwyf Stonehand, Ironforge
	[13084] = { "A", 173, 176, 226 },              -- Bixi Wobblebonk, Ironforge
	[11866] = { "A", 45, 136, 173, 176, 473 },     -- Ilyenia Moonfire, Darnassus
	[2704] = { "H", 44, 45, 136, 172, 176 },       -- Hanashi, Orgrimmar
	[11868] = { "H", 44, 45, 172, 173, 176, 473 }, -- Sayoc, Orgrimmar
	[11869] = { "H", 46, 54, 136, 160 },           -- Ansekhwa, Thunder Bluff
	[11870] = { "H", 43, 55, 173, 226, 229 },      -- Archibald, Undercity
}

-- The weapons a master teaches: skill line, item subclass (Gear.PROFICIENCY's
-- weapons), the weapon skill's spell (known by its id in any language) and the
-- level it can be learned from.
local WEAPONS = {
	{ line = 43, subclass = 7, spell = 201, label = L["Swords"] },
	{ line = 55, subclass = 8, spell = 202, label = L["Two-handed swords"] },
	{ line = 44, subclass = 0, spell = 196, label = L["Axes"] },
	{ line = 172, subclass = 1, spell = 197, label = L["Two-handed axes"] },
	{ line = 54, subclass = 4, spell = 198, label = L["Maces"] },
	{ line = 160, subclass = 5, spell = 199, label = L["Two-handed maces"] },
	{ line = 229, subclass = 6, spell = 200, label = L["Polearms"], level = 20 },
	{ line = 136, subclass = 10, spell = 227, label = L["Staves"] },
	{ line = 173, subclass = 15, spell = 1180, label = L["Daggers"] },
	{ line = 473, subclass = 13, spell = 15590, label = L["Fist weapons"] },
	{ line = 45, subclass = 2, spell = 264, label = L["Bows"] },
	{ line = 226, subclass = 18, spell = 5011, label = L["Crossbows"] },
	{ line = 46, subclass = 3, spell = 266, label = L["Guns"] },
	{ line = 176, subclass = 16, spell = 2567, label = L["Thrown"] },
}
local WEAPON_BY_LINE = {}
for _, w in ipairs(WEAPONS) do WEAPON_BY_LINE[w.line] = w end
Nearby.WEAPON_MASTERS, Nearby.WEAPONS = WEAPON_MASTERS, WEAPONS

local function teaches(id, line, code)
	local m = WEAPON_MASTERS[id]
	if not m or (code and m[1] ~= code) then return false end
	if not line then return true end
	for i = 2, #m do
		if m[i] == line then return true end
	end
	return false
end

-- The weapons the character's class can use that a master of its side
-- teaches, in WEAPONS' order: { line, label, known, level }. `known`: true
-- (the character has the skill's spell), false (it has not), nil (the client
-- cannot tell). `level`: the level it can be learned from, when above the
-- character's. Nothing for a class the gear tables do not know.
function Nearby.Weapons()
	local C = ns.Compat
	local info = C.GetPlayerInfo and C.GetPlayerInfo() or {}
	local G = ns.Gear
	local prof = G and G.PROFICIENCY and G.PROFICIENCY[info.class or ""]
	if not prof then return {} end
	local code = FACTION[info.faction]
	local out = {}
	for _, w in ipairs(WEAPONS) do
		local taught = false
		for id in pairs(WEAPON_MASTERS) do
			if teaches(id, w.line, code) then taught = true end
		end
		if prof.weapons[w.subclass] and taught then
			local known
			if C.IsPlayerSpell then known = C.IsPlayerSpell(w.spell) end
			local level = w.level and (info.level or 1) < w.level and w.level or nil
			out[#out + 1] = { line = w.line, label = w.label, known = known, level = level }
		end
	end
	return out
end

---------------------------------------------------------------------------
-- Professions
---------------------------------------------------------------------------

-- Profession skill lines, sorted by name.
local function professionLines()
	local out = {}
	for _, line in pairs(ns.Compat.SKILL_LINES or {}) do
		if line ~= RIDING then out[#out + 1] = line end
	end
	table.sort(out, function(a, b) return Nearby.ProfessionName(a) < Nearby.ProfessionName(b) end)
	return out
end

-- A profession's name in the client's language: the client's skill-line
-- name, else its English name (the Lookup.PROFESSIONS keys, DATA_KEYS in
-- tools/lib/i18n/keys.js) through L.
function Nearby.ProfessionName(line)
	local client = ns.Compat.GetSkillLineName and ns.Compat.GetSkillLineName(line)
	if client then return client end
	local Lookup = ns.Lookup
	local name = Lookup and Lookup.ProfessionName and Lookup.ProfessionName(line)
	if name then return L[name] end
	for key, l in pairs(ns.Compat.SKILL_LINES or {}) do
		if l == line then return L[(key:gsub("^%l", string.upper))] end
	end
	return tostring(line)
end

-- A profession named in any case, English or the client's: its skill line.
local function professionLine(text)
	text = lower(text or "")
	if text == "" then return nil end
	local lines = ns.Compat.SKILL_LINES or {}
	if lines[text] and lines[text] ~= RIDING then return lines[text] end
	for _, line in pairs(lines) do
		if line ~= RIDING and lower(Nearby.ProfessionName(line)) == text then return line end
	end
end

---------------------------------------------------------------------------
-- Places
---------------------------------------------------------------------------

local index = {} -- role -> { place, ... } with world c, wx, wy

-- A Codex that can answer: true | false, reason (see Nearby.Find). A loaded
-- Codex with no vendors at all is a broken one, not a world without vendors.
local function codexReady()
	local X = ns.Codex
	if not (X and X.IsLoaded and X.WithRole and X.Npc) then return false, "missing" end
	if not X.IsLoaded() then
		if InCombatLockdown() then return false, "combat" end
		local ok, why = false, "missing"
		if X.Load then ok, why = X.Load() end
		if not ok then return false, why or "error" end
	end
	if #X.WithRole("vendor") == 0 then return false, "empty" end
	return true
end

local function friendly(faction, code)
	return faction == nil or faction == "AH" or (code ~= nil and faction:find(code, 1, true) ~= nil)
end

local function rolePlaces(role)
	local list = index[role]
	if list then return list end
	local X, C = ns.Codex, ns.Compat
	local info = C.GetPlayerInfo and C.GetPlayerInfo()
	local code = info and FACTION[info.faction]
	list = {}
	for _, id in ipairs(X.WithRole(role)) do
		local npc = X.Npc(id)
		if npc and not npc.instance and friendly(npc.faction, code) then
			for _, s in ipairs(npc.spawns or {}) do
				local c, wx, wy = C.MapToWorld(s.map, s.x, s.y, s.f)
				if c then
					list[#list + 1] = { id = id, name = npc.name, map = s.map, x = s.x, y = s.y, f = s.f, c = c, wx = wx, wy = wy }
				end
			end
		end
	end
	index[role] = list
	return list
end

-- Places carry the NPC's name as read: drop them when the names pack lands
-- late, or when an NPC's learned name changes.
ns.On("NAMES_LOADED", function() index = {} end)
ns.On("NAME_LEARNED", function(kind) if kind == "npc" then index = {} end end)

-- The candidate places of a kind: list | nil, reason.
local function candidates(kind, line)
	local ok, why = codexReady()
	if not ok then return nil, why end
	if kind.key == "trainer" then
		if line then return rolePlaces("trainer:" .. line) end
		local all = {}
		for _, l in ipairs(professionLines()) do
			for _, p in ipairs(rolePlaces("trainer:" .. l)) do all[#all + 1] = p end
		end
		return all
	end
	if kind.key == "weapon" then
		local key = "weapon:" .. tostring(line or "any")
		if index[key] then return index[key] end
		local X, C = ns.Codex, ns.Compat
		local info = C.GetPlayerInfo and C.GetPlayerInfo()
		local code = info and FACTION[info.faction]
		local list = {}
		for id in pairs(WEAPON_MASTERS) do
			local npc = teaches(id, line, code) and X.Npc(id)
			if npc then
				for _, s in ipairs(npc.spawns or {}) do
					local c, wx, wy = C.MapToWorld(s.map, s.x, s.y, s.f)
					if c then
						list[#list + 1] = { id = id, name = npc.name, map = s.map, x = s.x, y = s.y, f = s.f, c = c, wx = wx, wy = wy }
					end
				end
			end
		end
		index[key] = list
		return list
	end
	if kind.key == "class" then
		local info = ns.Compat.GetPlayerInfo and ns.Compat.GetPlayerInfo()
		if not (info and info.class) then return nil, "none" end
		return rolePlaces("class:" .. info.class)
	end
	local list = rolePlaces(kind.role)
	if not kind.only then return list end
	local QoL = ns.QoL
	local keep = QoL and QoL.data and QoL.data[kind.only] or {}
	local out = {}
	for _, p in ipairs(list) do
		if keep[p.id] then out[#out + 1] = p end
	end
	return out
end

---------------------------------------------------------------------------
-- Ranking
---------------------------------------------------------------------------

-- places with world c, wx, wy; here = { c, wx, wy } | nil; estimate(place)
-- -> seconds | nil. The nearest spawn of each NPC by straight line (the
-- player's continent first), the RANKED nearest of those estimated, the
-- quickest returned with its seconds (a straight-line run when the planner
-- has no answer on this continent; nil when nothing could be measured).
function Nearby.Rank(places, here, estimate)
	local nearest, tier, dist = {}, {}, {}
	for _, p in ipairs(places) do
		local t, d = 1, 0
		if here then
			d = (p.wx - here.wx) ^ 2 + (p.wy - here.wy) ^ 2
			if p.c == here.c then t = 0 end
		end
		local held = nearest[p.id]
		if not held or t < tier[held] or (t == tier[held] and d < dist[held]) then
			if held then tier[held], dist[held] = nil, nil end
			nearest[p.id] = p
			tier[p], dist[p] = t, d
		end
	end
	local list = {}
	for _, p in pairs(nearest) do list[#list + 1] = p end
	if #list == 0 then return nil end
	table.sort(list, function(a, b)
		if tier[a] ~= tier[b] then return tier[a] < tier[b] end
		if dist[a] ~= dist[b] then return dist[a] < dist[b] end
		return a.id < b.id
	end)
	local best, bestS
	for i = 1, math.min(RANKED, #list) do
		local p = list[i]
		local s = estimate(p)
		if not s and here and tier[p] == 0 then s = sqrt(dist[p]) / RUN_SPEED end
		if s and (not bestS or s < bestS) then best, bestS = p, s end
	end
	return best or list[1], bestS
end

local function estimate(p)
	return Nav.journey.Estimate(nil, p)
end

function Nearby.Find(key, line)
	key = ALIAS[key] or key
	local kind = BY_KEY[key]
	if not kind then return nil, "kind" end
	if key == "class" then
		local E = ns.Engine
		local t = E and E.NearestClassTrainer and E.NearestClassTrainer()
		if t then
			local place = { id = t.npc, name = t.npcName, map = t.map, x = t.x, y = t.y, f = t.f, z = t.z }
			return place, estimate(place)
		end
	end
	local places, why = candidates(kind, line)
	if not places then return nil, why end
	local C = ns.Compat
	local here
	local pc, px, py = C.GetPlayerWorldPosition()
	if pc then here = { c = pc, wx = px, wy = py } end
	local place, seconds = Nearby.Rank(places, here, estimate)
	if not place then return nil, "none" end
	return place, seconds
end

local function kindLabel(key, line)
	if key == "trainer" and line then return format(L["%s trainer"], Nearby.ProfessionName(line)) end
	if key == "weapon" and WEAPON_BY_LINE[line] then return format(L["Weapon master (%s)"], WEAPON_BY_LINE[line].label) end
	return BY_KEY[key].label
end

-- A trip to a service: the arrow's target until the player gets there, or
-- picks "Back to the guide" (the guide window's banner, the Nearby menu).
-- Then the arrow is back on the guide's step. Any other target (a step change,
-- a goal clicked, a map click) ends it too.
local trip

-- The trip under way: { target, name, label }, or nil.
function Nearby.Trip()
	if trip and not (Nav.IsOverride() and Nav.GetTarget() == trip.target) then trip = nil end
	return trip
end

-- Back to the guide: the trip's target lets go. `arrived`: said as "At <name>".
-- False when there is no trip.
function Nearby.EndTrip(arrived)
	local t = Nearby.Trip()
	if not t then return false end
	trip = nil
	Nav.ReleaseTarget()
	ns.Print(arrived and format(L["At %s: the arrow is back on the guide."], t.name) or L["The arrow is back on the guide."])
	ns.Fire("NEARBY_TRIP", nil)
	return true
end

-- There: the arrow goes back to the guide, after the arrival is drawn.
ns.On("NAV_ARRIVED", function(target)
	if not (trip and trip.target == target) then return end
	C_Timer.After(0, function()
		if trip and trip.target == target then Nearby.EndTrip(true) end
	end)
end)

-- Another target took over: the trip is over, without a word.
ns.On("WAYPOINT_CHANGED", function()
	if trip and not Nearby.Trip() then ns.Fire("NEARBY_TRIP", nil) end
end)

function Nearby.Go(key, line)
	key = ALIAS[key] or key
	local place, seconds = Nearby.Find(key, line)
	if not place then
		local why = seconds
		if why == "kind" then
			ns.Print(L["Usage: /polestar near trainer [profession] | class | weapon | repair | reagents | vendor | innkeeper | bank | auction | flight | stable"])
		elseif why == "combat" then
			ns.Print(L["Nearby services can be looked up after combat."])
		elseif why == "missing" then
			ns.Print(L["Nearby services need the Polestar Codex addon, which is not installed: install every folder of the Polestar zip."])
		elseif why == "disabled" then
			ns.Print(L["Nearby services need the Polestar Codex addon: turn it on in the AddOns list."])
		elseif why == "empty" then
			ns.Print(L["Nearby services could not read the Polestar Codex: reinstall Polestar."])
		elseif why == "none" then
			ns.Print(format(L["No %s known for your faction."], lower(kindLabel(key, line))))
		else
			ns.Print(format(L["Nearby services could not load the Polestar Codex (%s)."], tostring(why)))
		end
		return false
	end
	if not Nav.SetTarget(place.map, place.x, place.y, place.name, place.f, BY_KEY[key].stop, place.z) then return false end
	trip = { target = Nav.GetTarget(), name = place.name, label = kindLabel(key, line) }
	ns.Fire("NEARBY_TRIP", trip)
	local zone = ns.Compat.GetMapName(place.map) or "?"
	local Q = ns.QoL
	local time = seconds and Q and Q.Duration and Q.Duration(seconds)
	if time then
		ns.Print(format(L["Nearest %s: %s, %s, about %s away."], lower(kindLabel(key, line)), place.name, zone, time))
	else
		ns.Print(format(L["Nearest %s: %s, %s."], lower(kindLabel(key, line)), place.name, zone))
	end
	return true
end

-- "/polestar near <kind> [profession]"; a profession alone means its trainer.
function Nearby.Command(rest)
	local text = lower((rest or ""):match("^%s*(.-)%s*$"))
	local word, more = text:match("^(%S+)%s*(.-)$")
	if not word then
		ns.Print(L["Usage: /polestar near trainer [profession] | class | weapon | repair | reagents | vendor | innkeeper | bank | auction | flight | stable"])
		return
	end
	local key = ALIAS[word] or word
	if BY_KEY[key] then
		local line
		if key == "trainer" and more ~= "" then
			line = professionLine(more)
			if not line then
				ns.Print(format(L["No profession called %s."], more))
				return
			end
		end
		Nearby.Go(key, line)
		return
	end
	local line = professionLine(text)
	if line then
		Nearby.Go("trainer", line)
	else
		Nearby.Go(word)
	end
end

---------------------------------------------------------------------------
-- Menus
---------------------------------------------------------------------------

local function addMenu(_, root)
	if not ns.Get("nav.nearbyMenu") then return end
	local sub = root:CreateButton(L["Nearby services"])
	for _, k in ipairs(KINDS) do
		if k.key == "trainer" then
			local trainers = sub:CreateButton(k.label)
			trainers:CreateButton(L["Nearest"], function() Nearby.Go("trainer") end)
			for _, line in ipairs(professionLines()) do
				trainers:CreateButton(Nearby.ProfessionName(line), function() Nearby.Go("trainer", line) end)
			end
		elseif k.key == "weapon" then
			local masters = sub:CreateButton(k.label)
			masters:CreateButton(L["Nearest"], function() Nearby.Go("weapon") end)
			for _, w in ipairs(Nearby.Weapons()) do
				local line = w.line
				masters:CreateButton(w.label, function() Nearby.Go("weapon", line) end)
			end
		else
			local key = k.key
			sub:CreateButton(k.label, function() Nearby.Go(key) end)
		end
	end
end
Nearby.AddMenu = addMenu

-- The guide window's "Nearby" button (UI/GuideFrame.lua): the everyday
-- services first, then a trainer for each profession the character has (any
-- profession trainer when it has none), then the rest. Each entry is
-- { key, line, label, icon }, for Nearby.Go(key, line).
local BUTTON_ORDER = { "vendor", "repair", "innkeeper", "flight", "class", "trainer", "weapon", "-", "reagents", "bank", "auction", "stable" }
local ICONS = { vendor = "icon-vendor", repair = "icon-buy", innkeeper = "icon-sethome", flight = "icon-fly",
	class = "icon-train", trainer = "icon-skill", weapon = "icon-train" }

function Nearby.MenuItems()
	local items = {}
	for _, key in ipairs(BUTTON_ORDER) do
		if key == "-" then
			items[#items + 1] = { separator = true }
		elseif key == "trainer" then
			local known = 0
			for _, line in ipairs(professionLines()) do
				local rank = ns.Compat.GetSkillRank(line)
				if rank and rank > 0 then
					known = known + 1
					items[#items + 1] = { key = key, line = line, label = kindLabel(key, line), icon = ICONS.trainer }
				end
			end
			if known == 0 then items[#items + 1] = { key = key, label = BY_KEY[key].label, icon = ICONS.trainer } end
		elseif key == "weapon" then
			-- Its weapons, to pick from: { key, line, label, known, level } each.
			local weapons = {}
			for _, w in ipairs(Nearby.Weapons()) do
				weapons[#weapons + 1] = { key = key, line = w.line, label = w.label, known = w.known, level = w.level }
			end
			if #weapons > 0 then items[#items + 1] = { key = key, label = BY_KEY[key].label, icon = ICONS.weapon, weapons = weapons } end
		else
			items[#items + 1] = { key = key, label = BY_KEY[key].label, icon = ICONS[key] }
		end
	end
	return items
end

-- Not with the gamepad interface (ns.GamepadUI): the game's menus join its
-- focus as they open, and an entry of Polestar's runs in that flow.
ns.OnLogin(function()
	if ns.GamepadUI() or not (Menu and Menu.ModifyMenu) then return end
	Menu.ModifyMenu("MENU_WORLD_MAP_TRACKING", addMenu)
	Menu.ModifyMenu("MENU_MINIMAP_TRACKING", addMenu)
end)

ns.RegisterCommand("near", Nearby.Command,
	L["Point the arrow at the nearest trainer, class trainer, repair, reagents, vendor, innkeeper, bank, auction house, flight or stable master"])

if ns.RegisterOptions then
	local ok, err = ns.RegisterOptions({
		page = L["Guide"], tab = L["Arrow & routes"], section = L["Routes"],
		controls = {
			{ kind = "toggle", key = "nav.nearbyMenu", label = L["Nearby services in map menus"],
				help = L["The world map's and minimap's tracking menus find the nearest trainer, vendor, inn, bank and more (/polestar near)."] },
			{ kind = "toggle", key = "nav.nearbyButton", label = L["Nearby services button"],
				help = L["A button in the guide window's header, left of the menu, finds the nearest vendor, repair, inn, flight master or trainer and points the arrow there."] },
		},
	})
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
