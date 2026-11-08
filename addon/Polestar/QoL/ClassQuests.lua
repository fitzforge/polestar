-- Class quests: when one of the character's Class guides opens (its level
-- reached and its first quest offered: Engine.StartGate has nothing to wait
-- on) and nothing of it is under way, fires CLASS_QUEST_READY so the guide
-- window's banner offers to open it in a tab. One guide at a time; taking or
-- dismissing it lets the next through. Off with Options, Guide, Automation,
-- Route extras, "Offer class quests" (behavior.offerClassQuests).
--
-- Before the offer, the heads-up (ClassQuests.Heads, from the compiled
-- guide): how long the chain is, escorts, and its objectives' mobs. A chain
-- whose objectives are elites is offered only from 2 levels below the
-- highest of them (the elites' `group.lvl`); any other chain as soon as it
-- opens.
--
-- Per-character state in CharState().flags.classOffered (guide id ->):
--   true    offered and taken, or dismissed: never again
--   <level> "Later" at that level: again at a higher level
--
-- Public API:
--   ClassQuests.Ready()        the guides that can be offered now, in list order
--   ClassQuests.Check()        offer the first of them (PLAYER_LEVEL_UP,
--                              QUEST_TURNED_IN, login)
--   ClassQuests.Resolve(id, later)  called by GuideFrame on take, Later or dismiss
--   ClassQuests.Heads(g, player) the chain's facts for this character
--   ClassQuests.HeadsLine(h, g)  -> the card's line under its title, or nil

local ADDON, ns = ...
local QoL = ns.QoL

local ClassQuests = {}
QoL.ClassQuests = ClassQuests

local L = ns.L
local max, tonumber, gmatch, match = math.max, tonumber, string.gmatch, string.match

-- An elite chain is offered from this many levels below its highest elite.
ClassQuests.ELITE_MARGIN = 2
-- A chain this long (quests, or zones, or two continents) is called long.
local LONG_QUESTS, LONG_ZONES = 5, 3
-- Non-elite mobs this many levels above the chain's start are named.
local MOBS_ABOVE = 5

local function offered()
	local flags = ns.CharState().flags
	if type(flags.classOffered) ~= "table" then flags.classOffered = {} end
	return flags.classOffered
end

-- Whether a quest of guide g is in the log or turned in: the guide is under way.
local function underWay(g)
	local C = ns.Compat
	for _, step in ipairs(g.steps or {}) do
		for _, goal in ipairs(step.goals or {}) do
			local q = goal.quest
			if q and (C.IsOnQuest(q) or C.IsQuestCompleted(q)) then return true end
		end
	end
	return false
end

-- The highest level of a goal's spawn areas: its `lvl` and each area's own
-- (packed "x,y,z,r,n,alt,lvl" or tables), read raw so no spot table is built.
local function spotLevel(goal)
	local top = tonumber(rawget(goal, "lvl")) or 0
	local packed = rawget(goal, "spotsPacked")
	if type(packed) == "string" then
		for spot in gmatch(packed, "[^;]+") do
			local lvl = tonumber(match(spot, "^[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,([^,]*)"))
			if lvl and lvl > top then top = lvl end
		end
	elseif type(rawget(goal, "spots")) == "table" then
		for _, spot in ipairs(goal.spots) do
			if tonumber(spot.lvl) and spot.lvl > top then top = spot.lvl end
		end
	end
	return top
end

local function applies(only, player)
	if type(only) ~= "table" then return true end
	local G = ns.Guides
	if not (G and G.Matches) then return true end
	local ok, yes = pcall(G.Matches, only, player)
	return not ok or yes
end

-- The chain's facts for this character (its steps and goals that apply,
-- optional ones aside): { quests, zones, continents, escort, eliteMin,
-- eliteMax, mobMax }. eliteMin/eliteMax: its elite objectives' highest levels
-- (nil: none, or none known); mobMax: the highest objective mob level (0: none known).
function ClassQuests.Heads(g, player)
	local quests, maps, conts = {}, {}, {}
	local h = { quests = 0, zones = 0, continents = 0, escort = false, mobMax = 0 }
	local C = ns.Compat
	for _, step in ipairs(g.steps or {}) do
		if applies(step.only, player) then
			for _, goal in ipairs(step.goals or {}) do
				if not goal.optional and applies(goal.only, player) then
					if goal.t == "accept" and goal.quest and not quests[goal.quest] then
						quests[goal.quest] = true
						h.quests = h.quests + 1
					end
					local m = tonumber(goal.map)
					if m and not maps[m] then
						maps[m] = true
						h.zones = h.zones + 1
						local c = C and C.GetContinentMap and C.GetContinentMap(m)
						if c and not conts[c] then
							conts[c] = true
							h.continents = h.continents + 1
						end
					end
					if goal.escort == true then h.escort = true end
					if goal.t == "kill" or goal.t == "collect" then
						local lvl = spotLevel(goal)
						local grp = goal.group
						if type(grp) == "table" and grp.kind == "elite" then
							local e = tonumber(grp.lvl) or (lvl > 0 and lvl) or nil
							if e then
								h.eliteMin = h.eliteMin and math.min(h.eliteMin, e) or e
								h.eliteMax = h.eliteMax and max(h.eliteMax, e) or e
								lvl = max(lvl, e)
							end
						end
						h.mobMax = max(h.mobMax, lvl)
					end
				end
			end
		end
	end
	return h
end

-- The card's line under its title: only what applies, or nil.
-- "Long chain: 6 quests across 4 zones · elite mobs at 28-29: bring a group"
function ClassQuests.HeadsLine(h, g)
	local parts = {}
	if h.quests >= LONG_QUESTS or h.zones >= LONG_ZONES or h.continents >= 2 then
		if h.continents >= 2 then
			parts[#parts + 1] = string.format(L["Long chain: %d quests across %d zones on %d continents"], h.quests, h.zones, h.continents)
		else
			parts[#parts + 1] = string.format(L["Long chain: %d quests across %d zones"], h.quests, h.zones)
		end
	end
	if h.escort then parts[#parts + 1] = L["an escort"] end
	if h.eliteMax then
		local range = h.eliteMin < h.eliteMax and (h.eliteMin .. "-" .. h.eliteMax) or tostring(h.eliteMax)
		parts[#parts + 1] = string.format(L["elite mobs at %s: bring a group"], range)
	elseif h.mobMax > 0 and h.mobMax >= (tonumber(g and g.minLevel) or 0) + MOBS_ABOVE then
		parts[#parts + 1] = string.format(L["mobs up to level %d"], h.mobMax)
	end
	if #parts == 0 then return nil end
	return table.concat(parts, " \194\183 ")
end

-- Whether an elite chain is still too hard to offer at this level.
local function tooHard(h, level)
	return h.eliteMax ~= nil and level < h.eliteMax - ClassQuests.ELITE_MARGIN
end

-- The pending notice: its guide id, so a level-up does not offer it twice.
local pending

function ClassQuests.Ready()
	local G, E, C = ns.Guides, ns.Engine, ns.Compat
	if not (G and G.List and G.Get and G.GuideMatches and E and E.StartGate and E.GetGuideState) then return {} end
	local ok, player = pcall(C.GetPlayerInfo)
	if not (ok and type(player) == "table") then return {} end
	local level = player.level or 1
	local seen = offered()
	local out = {}
	for _, h in ipairs(G.List()) do
		local v = seen[h.id]
		local due = v == nil or (type(v) == "number" and level > v)
		if h.category == "Class" and due and G.GuideMatches(h, player) and E.GetGuideState(h.id) == "new" then
			local g = G.Get(h.id)
			if g and not E.StartGate(h.id) and not underWay(g) and not tooHard(ClassQuests.Heads(g, player), level) then out[#out + 1] = g end
		end
	end
	return out
end

function ClassQuests.Check()
	if not ns.Get("behavior.offerClassQuests") or pending then return end
	local g = ClassQuests.Ready()[1]
	if not g then return end
	pending = g.id
	local ok, player = pcall(ns.Compat.GetPlayerInfo)
	local heads = ClassQuests.HeadsLine(ClassQuests.Heads(g, ok and type(player) == "table" and player or {}), g)
	ns.Fire("CLASS_QUEST_READY", { guideId = g.id, title = g.title or g.id, heads = heads, why = g.why })
end

-- take: opened in a tab; later: "Later" (again at a higher level); neither:
-- dismissed for good. Then the next ready guide, if any.
function ClassQuests.Resolve(id, later)
	if id then
		local level = 1
		local ok, player = pcall(ns.Compat.GetPlayerInfo)
		if ok and type(player) == "table" then level = player.level or 1 end
		offered()[id] = later and level or true
	end
	pending = nil
	ClassQuests.Check()
end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

-- After the level-up has reached the player info and the engine's gates.
ns.RegisterEvent("PLAYER_LEVEL_UP", function()
	ns.After(1, function() ns.SafeCall(ClassQuests.Check) end)
end)

-- A prerequisite turned in may open a guide.
ns.RegisterEvent("QUEST_TURNED_IN", function()
	ns.After(1, function() ns.SafeCall(ClassQuests.Check) end)
end)

ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	ns.After(3, function() ns.SafeCall(ClassQuests.Check) end)
end)
