-- Guide registry: packs, guides and Era map frames registered by guide
-- packs at load time, plus the picker queries (List, Suggestions, Suggest).
-- Contract: docs/ARCHITECTURE.md, "Guide data" and "Engine".

local ADDON, ns = ...
local L = ns.L

local type, pairs, ipairs, tostring, tonumber = type, pairs, ipairs, tostring, tonumber

local Guides = {}
ns.Guides = Guides

local guides = {} -- id -> guide
local order = {} -- ids in first-registration order
local headers = {} -- id -> header (guide without steps, plus stepCount)
local packs = {} -- pack id -> the record holding that id
local records = {} -- every pack record, refused ones included, in registration order
local early = {} -- pack id -> { guide id, ... } registered before their pack

ns.MapFrames = ns.MapFrames or { era = {} }
local ourFrames = {} -- uiMapID -> true: a frame from Polestar itself or our guide pack

---------------------------------------------------------------------------
-- Conditions (`only` on steps and goals, races/classes on guides)
---------------------------------------------------------------------------

-- Race names compare with UnitRace's second return, the client's race file
-- (ChrRaces.ClientFileString in Forever 1.60.1): "Scourge" for the Forsaken
-- (guides may also write "Undead") and "Skyborne" on both sides; a guide's
-- `faction` (or an `only` faction) picks the side, not the race.
local RACE_ALIAS = { scourge = "undead" }
local function normRace(r)
	if not r then return "" end
	r = r:lower()
	return RACE_ALIAS[r] or r
end
Guides.NormRace = normRace

local function identity(v) return v and v:lower() or "" end

-- A list matches when no "!x" entry equals the value and, if the list has any
-- positive entry, one of them does. nil/empty lists match everything. norm
-- (optional) canonicalizes names before comparing.
local function listMatches(list, value, norm)
	if type(list) ~= "table" or #list == 0 then return true end
	norm = norm or identity
	value = norm(value)
	local positives, hit = false, false
	for i = 1, #list do
		local e = list[i]
		local neg = e:sub(1, 1) == "!"
		if neg then e = e:sub(2) end
		e = norm(e)
		if neg then
			if e == value then return false end
		else
			positives = true
			if e == value then hit = true end
		end
	end
	return hit or not positives
end
Guides.ListMatches = listMatches

-- only = { classes = {...}, races = {...}, factions = {...} }; player =
-- Compat.GetPlayerInfo(). AND across keys, OR within.
function Guides.Matches(only, player)
	if type(only) ~= "table" then return true end
	return listMatches(only.classes, player.class)
		and listMatches(only.races, player.race, normRace)
		and listMatches(only.factions, player.faction)
end

local function guideMatches(g, player)
	if g.faction and player.faction and g.faction:lower() ~= player.faction:lower() then return false end
	return listMatches(g.races, player.race, normRace) and listMatches(g.classes, player.class)
end
Guides.GuideMatches = guideMatches

-- Candidate NPCs (`candidates` on a goal): faction "A" | "H" | "AH" (nil:
-- anyone), optional races/classes lists.
local FACTION_CODE = { Alliance = "A", Horde = "H" }
function Guides.CandidateMatches(c, player)
	if c.faction and c.faction ~= "AH" then
		local code = FACTION_CODE[player.faction]
		if not code or not c.faction:find(code, 1, true) then return false end
	end
	return listMatches(c.races, player.race, normRace) and listMatches(c.classes, player.class)
end

---------------------------------------------------------------------------
-- Travel cost between two points { map, x, y, f }: Nav.EstimateTravel in
-- seconds when Nav provides it, else running time over the world distance on
-- one continent, with a large penalty across continents. nil when either
-- point cannot be placed.
---------------------------------------------------------------------------

local RUN_SPEED = 7 -- yards per second
local CROSS_CONTINENT = 3600 -- seconds
ns.TRAVEL_CROSS_CONTINENT = CROSS_CONTINENT

-- A cheap direct world-distance estimate: never touches the route planner.
local function directTravelCost(from, to)
	local C = ns.Compat
	local c1, x1, y1 = C.MapToWorld(from.map, from.x, from.y, from.f)
	local c2, x2, y2 = C.MapToWorld(to.map, to.x, to.y, to.f)
	if not (c1 and c2) then return nil end
	if c1 ~= c2 then return CROSS_CONTINENT end
	local dx, dy = x2 - x1, y2 - y1
	return (dx * dx + dy * dy) ^ 0.5 / RUN_SPEED
end
ns.DirectTravelCost = directTravelCost

function ns.TravelCost(from, to)
	local nav = ns.Nav
	if nav and nav.EstimateTravel then
		local ok, s = pcall(nav.EstimateTravel, from, to)
		if ok and type(s) == "number" then return s end
	end
	return directTravelCost(from, to)
end

-- The player's live position as a travel point, or nil (instance, loading).
function ns.PlayerPoint()
	local map, x, y = ns.Compat.GetPlayerMapPosition()
	if not map then return nil end
	return { map = map, x = x, y = y }
end

---------------------------------------------------------------------------
-- Validation
---------------------------------------------------------------------------

local function isNum(v) return type(v) == "number" end
local function isStr(v) return type(v) == "string" and v ~= "" end

-- verb -> { field = checker }
local REQUIRED = {
	accept = { quest = isNum, title = isStr },
	turnin = { quest = isNum, title = isStr },
	complete = { quest = isNum, title = isStr },
	kill = { target = isStr },
	collect = { item = isNum, itemName = isStr },
	["goto"] = { map = isNum, x = isNum, y = isNum },
	talk = { npc = isNum, npcName = isStr },
	interact = { object = isNum, objName = isStr },
	use = { item = isNum, itemName = isStr },
	sethome = {}, -- `location`, or `candidates` for `sethome nearest`
	hearth = { location = isStr },
	getfp = { location = isStr },
	fly = { location = isStr },
	train = {},
	buy = { item = isNum, itemName = isStr },
	vendor = {},
	level = { level = isNum },
	money = { money = isNum },
	task = { text = isStr },
	note = { text = isStr },
	skill = { skill = isStr, level = isNum },
	learn = { spell = isNum, spellName = isStr },
	craft = { spell = isNum, spellName = isStr },
	rep = { faction = isNum, factionName = isStr, standing = isNum },
	explore = { map = isNum, x = isNum, y = isNum },
	achieve = { achievement = isNum, achievementName = isStr },
}
Guides.VERBS = REQUIRED

-- Required fields per verb in a fixed (alphabetical) order, so the error for
-- a goal missing several fields is always the same.
local REQUIRED_ORDER = {}
for verb, rules in pairs(REQUIRED) do
	local fields = {}
	for field in pairs(rules) do fields[#fields + 1] = field end
	table.sort(fields)
	REQUIRED_ORDER[verb] = fields
end

-- The key lists the checks below walk, at file scope: as literals inside the
-- loops they were one throwaway table per goal, per step and per guide, and
-- registering the 220 guides walks about 12,000 goals (#60). One table, so the
-- chunk stays well inside Lua 5.1's cap on locals.
local KEYS = {
	only = { "classes", "races", "factions" },
	goalNumbers = { "skillLine", "untilSkill", "criteria", "level", "profLine", "profRank" },
	goalRanks = { "rank", "qlvl" },
	rewardLists = { "items", "choices" },
	guideMaps = { "names", "written" },
	guideLists = { "races", "classes", "nextChoices", "pros", "cons", "keywords" },
}

local function checkOnly(only)
	if only == nil then return true end
	if type(only) ~= "table" then return false end
	for _, key in ipairs(KEYS.only) do
		local list = only[key]
		if list ~= nil then
			if type(list) ~= "table" then return false end
			for i = 1, #list do
				if type(list[i]) ~= "string" then return false end
			end
		end
	end
	return true
end

-- A step's `when` (format 4): predicates, each { k, neg?, ... } by kind
-- (docs/PACK_FORMAT.md, "Format 4"); Engine.lua (Own.whenFails) reads them.
local WHEN_OPS = { ["<"] = true, ["<="] = true, [">"] = true, [">="] = true }
local WHEN_QUEST = { complete = true, turnedin = true, available = true, group = true }
local WHEN_PLACE = { zone = true, subzone = true, bound = true }
-- A point inside a level (format 4): the share of it done, strictly between 0 and 1.
local function isFrac(v) return isNum(v) and v > 0 and v < 1 end
local function checkWhen(list)
	if list == nil then return true end
	if type(list) ~= "table" or #list == 0 then return false end
	for i = 1, #list do
		local p = list[i]
		if type(p) ~= "table" then return false end
		local k = p.k
		if k == "level" then
			if not (WHEN_OPS[p.op] and isNum(p.n)) then return false end
			if p.frac ~= nil and not isFrac(p.frac) then return false end
		elseif k == "money" then
			if not (WHEN_OPS[p.op] and isNum(p.n)) then return false end
		elseif k == "onquest" then
			if type(p.q) ~= "table" or #p.q == 0 then return false end
			for j = 1, #p.q do
				if not isNum(p.q[j]) then return false end
			end
		elseif WHEN_QUEST[k] then
			if not isNum(p.q) then return false end
		elseif k == "has" or k == "upgrade" then
			if not isNum(p.item) then return false end
		elseif k == "dungeon" then
			if not (isStr(p.name) and (p.map == nil or isNum(p.map))) then return false end
		elseif k == "done" then
			-- A step label (format 5); validate checks it names a step of the guide.
			if not isStr(p.label) then return false end
		elseif k == "skill" then
			-- A profession by name, with its skill line when the compiler knew it (format 5).
			if not (isStr(p.name) and isNum(p.n) and (p.skillLine == nil or isNum(p.skillLine))) then return false end
		elseif k == "cooldown" then
			-- One item or one spell (format 5).
			if not ((isNum(p.item) and p.spell == nil) or (isNum(p.spell) and p.item == nil)) then return false end
		elseif not (WHEN_PLACE[k] and isStr(p.name)) then
			return false
		end
	end
	return true
end

-- A step's picture (docs/PACK_FORMAT.md, step `image`): { file, w?, h? },
-- `file` a path inside the pack's addon folder: folders and a name of
-- letters, digits, `_` and `-` separated by `\` or `/`, then `.tga`, `.blp`
-- or no extension (the compiler's rule, tools/lib/dsl/images.js).
local function checkImage(image)
	if image == nil then return true end
	if type(image) ~= "table" or not isStr(image.file) then return false end
	for _, key in ipairs({ "w", "h" }) do
		local v = image[key]
		if v ~= nil and not (isNum(v) and v > 0) then return false end
	end
	local file = image.file
	local ext = file:match("%.(%w+)$")
	if ext then
		ext = ext:lower()
		if ext ~= "tga" and ext ~= "blp" then return false end
		file = file:sub(1, #file - #ext - 1)
	end
	for part in (file:gsub("/", "\\") .. "\\"):gmatch("(.-)\\") do
		if not part:find("^[%w_%-]+$") then return false end
	end
	return true
end

local function checkGoal(goal)
	if type(goal) ~= "table" then return "not a table" end
	local rules = REQUIRED[goal.t]
	if not rules then return "unknown verb " .. tostring(goal.t) end
	local fields = REQUIRED_ORDER[goal.t]
	for i = 1, #fields do
		local field = fields[i]
		if not rules[field](goal[field]) then return goal.t .. " needs " .. field end
	end
	if goal.x ~= nil or goal.y ~= nil then
		if not (isNum(goal.map) and isNum(goal.x) and isNum(goal.y)) then return "coordinates need map, x and y" end
		if goal.x < 0 or goal.x > 100 or goal.y < 0 or goal.y > 100 then return "coordinates outside 0-100" end
	end
	if goal.f ~= nil and goal.f ~= "e" then return "unknown frame " .. tostring(goal.f) end
	if goal.r ~= nil and not (isNum(goal.r) and goal.r > 0) then return "bad radius" end
	if goal.oi ~= nil and not (isNum(goal.oi) and goal.oi >= 1) then return "bad objective index" end
	if goal.count ~= nil and not isNum(goal.count) then return "bad count" end
	if goal.text ~= nil and type(goal.text) ~= "string" then return "bad text" end
	if goal.t == "rep" and (goal.standing < 1 or goal.standing > 8) then return "standing outside 1-8" end
	if goal.t == "level" and goal.frac ~= nil and not isFrac(goal.frac) then return "bad frac" end
	for _, key in ipairs(KEYS.goalNumbers) do
		if goal[key] ~= nil and not isNum(goal[key]) then return "bad " .. key end
	end
	if goal.profName ~= nil and not isStr(goal.profName) then return "bad profName" end
	if goal.reagents ~= nil then
		if type(goal.reagents) ~= "table" then return "bad reagents" end
		for i = 1, #goal.reagents do
			local r = goal.reagents[i]
			if type(r) ~= "table" or not isNum(r.item) then return "bad reagent " .. i end
		end
	end
	if goal.t == "sethome" and not isStr(goal.location) and type(goal.candidates) ~= "table" then
		return "sethome needs location"
	end
	if goal.candidates ~= nil then
		if type(goal.candidates) ~= "table" or #goal.candidates == 0 then return "bad candidates" end
		for i = 1, #goal.candidates do
			local c = goal.candidates[i]
			if type(c) ~= "table" or not (isNum(c.map) and isNum(c.x) and isNum(c.y)) then return "bad candidate " .. i end
			if c.faction ~= nil and c.faction ~= "A" and c.faction ~= "H" and c.faction ~= "AH" then
				return "bad candidate faction " .. i
			end
		end
	end
	-- Spawn areas: centres in the goal's own map and frame, so they need its map.
	if goal.spots ~= nil then
		if type(goal.spots) ~= "table" or #goal.spots == 0 or not isNum(goal.map) then return "bad spots" end
		for i = 1, #goal.spots do
			local s = goal.spots[i]
			if type(s) ~= "table" or not (isNum(s.x) and isNum(s.y) and isNum(s.r) and s.r >= 0) or (s.alt ~= nil and s.alt ~= true) then return "bad spot " .. i end
		end
	end
	if goal.spread ~= nil and not (goal.spread == true and goal.spots ~= nil) then return "bad spread" end
	-- A collect's dominant source: its name (and a second's), their ids, kind, rank and faction.
	if goal.from ~= nil and not isStr(goal.from) then return "bad from" end
	if goal.fromAlso ~= nil and not isStr(goal.fromAlso) then return "bad fromAlso" end
	if goal.fromId ~= nil and not isNum(goal.fromId) then return "bad fromId" end
	if goal.fromAlsoId ~= nil and not isNum(goal.fromAlsoId) then return "bad fromAlsoId" end
	if goal.fromKind ~= nil and goal.fromKind ~= "npc" and goal.fromKind ~= "object" then return "bad fromKind" end
	if goal.fromRank ~= nil and not isNum(goal.fromRank) then return "bad fromRank" end
	if goal.fromFaction ~= nil and goal.fromFaction ~= "A" and goal.fromFaction ~= "H" and goal.fromFaction ~= "AH" then
		return "bad fromFaction"
	end
	for _, key in ipairs(KEYS.goalRanks) do
		if goal[key] ~= nil and not isNum(goal[key]) and not isStr(goal[key]) then return "bad " .. key end
	end
	if goal.pre ~= nil and type(goal.pre) ~= "table" then return "bad pre" end
	if goal.preAll ~= nil and type(goal.preAll) ~= "table" then return "bad preAll" end
	if goal.closedBy ~= nil and type(goal.closedBy) ~= "table" then return "bad closedBy" end
	if goal.rewards ~= nil then
		local r = goal.rewards
		if type(r) ~= "table" then return "bad rewards" end
		if (r.xp ~= nil and not isNum(r.xp)) or (r.money ~= nil and not isNum(r.money)) then return "bad rewards" end
		for _, key in ipairs(KEYS.rewardLists) do
			local list = r[key]
			if list ~= nil then
				if type(list) ~= "table" then return "bad rewards" end
				for i = 1, #list do
					local it = list[i]
					if type(it) ~= "table" or not isNum(it.item) then return "bad reward " .. i end
				end
			end
		end
	end
	if not checkOnly(goal.only) then return "bad only" end
	return nil
end

local function validate(def)
	if type(def) ~= "table" then return "guide is not a table" end
	if not isStr(def.id) then return "missing id" end
	if not isStr(def.title) then return "missing title" end
	if type(def.steps) ~= "table" or #def.steps == 0 then return "no steps" end
	if def.minLevel ~= nil and not isNum(def.minLevel) then return "bad minLevel" end
	if def.maxLevel ~= nil and not isNum(def.maxLevel) then return "bad maxLevel" end
	if def.next ~= nil and not isStr(def.next) then return "bad next" end
	if def.faction ~= nil and not isStr(def.faction) then return "bad faction" end
	if def.category ~= nil and not isStr(def.category) then return "bad category" end
	if def.pitch ~= nil and not isStr(def.pitch) then return "bad pitch" end
	if def.folder ~= nil and not isStr(def.folder) then return "bad folder" end
	if def.collects ~= nil then
		if type(def.collects) ~= "table" then return "bad collects" end
		for i = 1, #def.collects do
			if not isNum(def.collects[i]) then return "bad collects" end
		end
	end
	-- reward = { { item, itemName?, quality?, choice? } | { spell, spellName } | { text } }
	if def.reward ~= nil then
		if type(def.reward) ~= "table" then return "bad reward" end
		for i = 1, #def.reward do
			local r = def.reward[i]
			if type(r) ~= "table" or not (isNum(r.item) or isNum(r.spell) or isStr(r.text)) then return "bad reward " .. i end
		end
	end
	if def.why ~= nil and not isStr(def.why) then return "bad why" end
	for _, key in ipairs(KEYS.guideMaps) do
		local map = def[key]
		if map ~= nil then
			if type(map) ~= "table" then return "bad " .. key end
			for k, v in pairs(map) do
				if not (isStr(k) and isStr(v)) then return "bad " .. key end
			end
		end
	end
	for _, key in ipairs(KEYS.guideLists) do
		local list = def[key]
		if list ~= nil then
			if type(list) ~= "table" then return "bad " .. key end
			for i = 1, #list do
				if not isStr(list[i]) then return "bad " .. key end
			end
		end
	end
	-- nextWhen (format 4): an option of nextChoices -> its predicates, as a
	-- step's `when`; Engine.lua (Own.optionHolds) reads them at the hand-off.
	if def.nextWhen ~= nil then
		if type(def.nextWhen) ~= "table" or type(def.nextChoices) ~= "table" then return "bad nextWhen" end
		for id, list in pairs(def.nextWhen) do
			local listed = false
			for i = 1, #def.nextChoices do
				if def.nextChoices[i] == id then listed = true end
			end
			if not (listed and list ~= nil and checkWhen(list)) then return "bad nextWhen" end
			-- `done` checks a step of the guide being played, not of the one offering the option;
			-- `group` asks the player at a step, and a hand-off has none.
			for i = 1, #list do
				if list[i].k == "done" or list[i].k == "group" then return "bad nextWhen" end
			end
		end
	end
	-- A step's `label` (format 4) names it, once per guide; `along` is true or
	-- the label of a later step (docs/PACK_FORMAT.md, "Format 4").
	local labelAt = {}
	for s, step in ipairs(def.steps) do
		if type(step) ~= "table" then return ("step %d is not a table"):format(s) end
		if type(step.goals) ~= "table" or #step.goals == 0 then return ("step %d has no goals"):format(s) end
		if not checkOnly(step.only) then return ("step %d: bad only"):format(s) end
		if not checkWhen(step.when) then return ("step %d: bad when"):format(s) end
		if step.label ~= nil then
			if not isStr(step.label) then return ("step %d: bad label"):format(s) end
			if labelAt[step.label] then return ("step %d: duplicate label %s"):format(s, step.label) end
			labelAt[step.label] = s
		end
		if not checkImage(step.image) then return ("step %d: bad image"):format(s) end
		for g, goal in ipairs(step.goals) do
			local err = checkGoal(goal)
			if err then return ("step %d goal %d: %s"):format(s, g, err) end
		end
	end
	for s, step in ipairs(def.steps) do
		local along = step.along
		if along ~= nil and along ~= true and not (isStr(along) and (labelAt[along] or 0) > s) then
			return ("step %d: bad along"):format(s)
		end
		-- `skipto` (format 5): jumps { to = a later step's label, when = one predicate }.
		if step.skipto ~= nil then
			if type(step.skipto) ~= "table" or #step.skipto == 0 then return ("step %d: bad skipto"):format(s) end
			for _, k in ipairs(step.skipto) do
				if type(k) ~= "table" or not (isStr(k.to) and (labelAt[k.to] or 0) > s) or type(k.when) ~= "table"
					or not checkWhen({ k.when }) or k.when.k == "group" then
					return ("step %d: bad skipto"):format(s)
				end
			end
		end
		-- `done <label>` names a step of this guide.
		for _, p in ipairs(step.when or {}) do
			if p.k == "done" and not labelAt[p.label] then return ("step %d: bad when"):format(s) end
		end
		for _, k in ipairs(step.skipto or {}) do
			if k.when.k == "done" and not labelAt[k.when.label] then return ("step %d: bad skipto"):format(s) end
		end
	end
	return nil
end
Guides.Validate = validate

---------------------------------------------------------------------------
-- Packs (rules: docs/PACK_FORMAT.md, "Rules Polestar enforces"; API:
-- docs/ARCHITECTURE.md, "The guide registry"). A pack registers once, then
-- its guides; every guide id lives under its pack's prefix. Refusals are
-- recorded on the pack's record (problems) and printed by ns.Debug.
---------------------------------------------------------------------------

-- Every format Polestar has shipped (docs/PACK_FORMAT.md, "Versioning").
Guides.FORMATS = { [1] = true, [2] = true, [3] = true, [4] = true, [5] = true }
Guides.RESERVED = { guides = true, forever = true, lookup = true, draft = true, polestar = true, imported = true }
local OFFICIAL_ADDON = "Polestar_Guides"
local REQUIRED_META = { "addon", "title", "author", "version", "license" }
local OPTIONAL_META = { "website", "source", "notes" }

local find = string.find

-- Does pack `packId` own guide id `guideId`? Ours (`guides`) owns forever/
-- and draft/, the internal `lookup` pack lookup/, the `imported` pack (guides
-- pasted on the Import page, Core/Import.lua) every `<author>/` that is a
-- valid pack id no one reserved, every other pack `<id>/`.
function Guides.OwnsId(packId, guideId)
	if type(packId) ~= "string" or type(guideId) ~= "string" then return false end
	if packId == "guides" then return guideId:sub(1, 8) == "forever/" or guideId:sub(1, 6) == "draft/" end
	if packId == "lookup" then return guideId:sub(1, 7) == "lookup/" end
	if packId == "imported" then
		local prefix = guideId:match("^([a-z0-9][a-z0-9%-]*)/.")
		return prefix ~= nil and #prefix >= 2 and #prefix <= 32 and not Guides.RESERVED[prefix]
	end
	return guideId:sub(1, #packId + 1) == packId .. "/"
end
local ownsId = Guides.OwnsId

local function prefixOf(packId)
	if packId == "guides" then return "forever/, draft/" end
	if packId == "imported" then return "<author>/" end
	return packId .. "/"
end

local function validPackId(id)
	return type(id) == "string" and #id >= 2 and #id <= 32 and find(id, "^[a-z0-9][a-z0-9%-]*$") ~= nil
end

-- A pack holding its id takes guides; a refused or too-new one only keeps
-- the id so its guides drop without a problem each.
local function accepted(r)
	return r.status == "on" or r.status == "off"
end

-- Why a pack that needs a newer Polestar does not run; needs: its escaped
-- X-Polestar-Needs, or nil.
local function tooNewReason(needs)
	return needs and (L["Needs Polestar %s or newer."]):format(needs) or L["Needs a newer Polestar."]
end

local function problem(r, kind, message, guideId)
	r.problems[#r.problems + 1] = { kind = kind, guide = guideId, message = message }
	ns.Debug(("pack %s: %s"):format(tostring(r.id), message))
end

-- Author text prints literally: every `|` doubled, once, at registration.
local escape = ns.EscapeText
local ID_KEYS = { id = true, pack = true, next = true, nextChoices = true }
local function escapeTree(t, seen, skip)
	seen[t] = true
	for k, v in pairs(t) do
		if not (skip and skip[k]) then
			local tv = type(v)
			if tv == "string" then
				if find(v, "|", 1, true) then t[k] = escape(v) end
			elseif tv == "table" and not seen[v] then
				escapeTree(v, seen)
			end
		end
	end
end

local function newRecord(meta, addon)
	local r = {
		id = type(meta.id) == "string" and meta.id or tostring(meta.id),
		addon = type(addon) == "string" and addon or nil,
		format = meta.format,
		official = meta.id == "guides" and addon == OFFICIAL_ADDON,
		problems = {},
		guides = {},
		guideCount = 0,
	}
	for _, key in ipairs(REQUIRED_META) do
		if key ~= "addon" and type(meta[key]) == "string" then r[key] = escape(meta[key]) end
	end
	for _, key in ipairs(OPTIONAL_META) do
		if type(meta[key]) == "string" then r[key] = escape(meta[key]) end
	end
	-- The English of the texts its texts addon translates (GuideTexts.PackText).
	r.english = { title = type(meta.title) == "string" and meta.title or nil, notes = type(meta.notes) == "string" and meta.notes or nil }
	records[#records + 1] = r
	return r
end

local function refuse(r, message)
	r.status = "refused"
	r.reason = message
	r.refusal = message
	problem(r, "pack-refused", message)
	r.refusalProblem = r.problems[#r.problems]
	return false, message
end

-- The refused record whose addon is loading now: a pack refused for an id
-- another pack holds (or reserved for ours) is refused whole, so the guides
-- its files register next under that id are dropped, never given to the
-- holder. Cleared when that addon's files are done (ADDON_LOADED).
local loadingRefused = nil
local loaded = {} -- addon name -> true once its files are done (ADDON_LOADED)

-- Counts a guide dropped with refused record r in r's problem.
local function dropGuide(r, id)
	r.dropped = (r.dropped or 0) + 1
	local n = r.dropped == 1 and L["1 guide dropped."] or (L["%d guides dropped."]):format(r.dropped)
	r.reason = r.refusal .. " " .. n
	r.refusalProblem.message = r.reason
	ns.Debug(("guide %s dropped: pack %s from %s was refused"):format(id, tostring(r.id), tostring(r.addon)))
	return false, "pack refused"
end

-- meta = { addon, id, format, title, author, version, license, website?,
-- source?, notes? }; Polestar's own Lookup registers { id = "lookup", title,
-- internal = true } as its files load (Lookup/Guide.lua), before any pack
-- can: a later claim on it is refused and listed like any other. -> ok, err
function ns.RegisterPack(meta)
	if type(meta) ~= "table" then
		ns.Debug("RegisterPack: the pack is not a table")
		return false, "pack is not a table"
	end
	local id = meta.id
	if id == "lookup" and meta.internal and not packs[id] then
		local r = newRecord(meta, nil)
		r.internal = true
		packs[id] = r
		r.status = "on"
		return true
	end
	-- The guides pasted on the Import page (Core/Import.lua), registered as
	-- its file loads, before any pack can: listed in the guide menu as
	-- "Imported", never on the Community guides page, never suggested.
	if id == "imported" and meta.imported and not packs[id] then
		local r = newRecord(meta, nil)
		r.imported = true
		packs[id] = r
		r.status = "on"
		return true
	end
	-- Every other pack, refused ones included, is listed on the Community guides page.
	local addon = meta.addon
	local r = newRecord(meta, addon)
	loadingRefused = nil
	if meta.internal then
		-- Refused for the flag, but a reserved or taken id still drops what
		-- it registers while loading.
		if Guides.RESERVED[id] or packs[id] then loadingRefused = r end
		return refuse(r, L["Only Polestar's own Lookup pack may register as internal."])
	end
	if not validPackId(id) then
		return refuse(r, (L["Pack id %s is not valid: 2 to 32 lower-case letters, digits or hyphens, starting with a letter or digit."]):format(escape(r.id)))
	end
	if Guides.RESERVED[id] and not (id == "guides" and addon == OFFICIAL_ADDON) then
		loadingRefused = r
		return refuse(r, (L["Pack id %s is reserved for Polestar."]):format(id))
	end
	local holder = packs[id]
	if holder then
		loadingRefused = r
		return refuse(r, (L["Pack id %s is already taken by %s; %s was refused."]):format(id,
			escape(tostring(holder.addon or "?")), escape(tostring(addon or "?"))))
	end
	packs[id] = r
	if type(meta.format) ~= "number" then return refuse(r, L["The pack is missing format."]) end
	if not Guides.FORMATS[meta.format] then
		local needs = type(addon) == "string" and C_AddOns and C_AddOns.GetAddOnMetadata
			and C_AddOns.GetAddOnMetadata(addon, "X-Polestar-Needs") or nil
		r.status = "too-new"
		r.needs = type(needs) == "string" and needs ~= "" and escape(needs) or nil
		r.reason = tooNewReason(r.needs)
		problem(r, "pack-refused", r.reason)
		return false, r.reason
	end
	for _, key in ipairs(REQUIRED_META) do
		if not isStr(meta[key]) then return refuse(r, (L["The pack is missing %s."]):format(key)) end
	end
	r.status = "on"
	local before = early[id]
	if before then
		early[id] = nil
		for _, gid in ipairs(before) do
			problem(r, "guide-refused", (L["Guide %s was refused: it was registered before its pack."]):format(escape(gid)), gid)
		end
	end
	return true
end

-- def: a compiled guide (ARCHITECTURE, "Guide data"); def.pack names its
-- registered pack, which must own def.id. A pack registering one of its own
-- ids again replaces that guide in its first slot. -> ok, err
function ns.RegisterGuide(def)
	if type(def) ~= "table" or not isStr(def.id) then
		local err = type(def) ~= "table" and "guide is not a table" or "missing id"
		ns.Debug("RegisterGuide: rejected:", err)
		return false, err
	end
	local id, packId = def.id, def.pack
	if not isStr(packId) then
		ns.Debug(("guide %s rejected: no pack"):format(id))
		return false, "no pack"
	end
	if loadingRefused and loadingRefused.id == packId then return dropGuide(loadingRefused, id) end
	local r = packs[packId]
	if not r then
		local list = early[packId]
		if not list then
			list = {}
			early[packId] = list
		end
		list[#list + 1] = id
		ns.Debug(("guide %s rejected: pack %s is not registered"):format(id, packId))
		return false, "pack not registered"
	end
	if not accepted(r) then
		ns.Debug(("guide %s dropped: pack %s was not loaded"):format(id, packId))
		return false, "pack " .. r.status
	end
	if not ownsId(packId, id) then
		local message = (L["Guide %s was refused: its id must start with %s."]):format(escape(id), prefixOf(packId))
		problem(r, "guide-refused", message, id)
		return false, message
	end
	-- An imported guide shares no prefix rule with the packs: an id another
	-- pack's guide already holds stays that pack's, whichever came second.
	local held = guides[id]
	if held and held.pack ~= packId then
		local message = (L["Guide %s was refused: %s already holds that id."]):format(escape(id), escape(tostring(held.pack)))
		problem(r, "guide-refused", message, id)
		return false, message
	end
	local err = validate(def)
	if err then
		problem(r, "guide-refused", (L["Guide %s was refused: %s."]):format(escape(id), escape(err)), id)
		return false, err
	end
	-- A step's picture is a file in the pack's addon folder: its texture path
	-- from the addon that registered the pack. A pack without an addon
	-- folder (imported guides, Lookup's) has no files, so shows none.
	for _, step in ipairs(def.steps) do
		local image = step.image
		if image then
			image.texture = r.addon and ("Interface\\AddOns\\" .. r.addon .. "\\" .. (image.file:gsub("/", "\\"))) or nil
		end
	end
	-- The texts in the client's language (GuideTexts), then escaped like the
	-- rest. While the pack's files load its names stay English: the pack's
	-- ADDON_LOADED brings its texts addon and the names in.
	ns.GuideTexts.Prepare(def, not (r.addon and not loaded[r.addon]))
	escapeTree(def, {}, ID_KEYS)
	if not guides[id] then
		order[#order + 1] = id
		r.guides[#r.guides + 1] = id
		r.guideCount = #r.guides
	end
	guides[id] = def
	local h = {}
	for k, v in pairs(def) do
		if k ~= "steps" then h[k] = v end
	end
	h.stepCount = #def.steps
	headers[id] = h
	return true
end

-- { era = { [uiMapID] = { c, left, right, top, bottom } } }; merges. packId
-- nil is Polestar itself (its data addons, class trainers). Frames of
-- Polestar and our pack (`guides`) win for a map both cover, whatever the
-- load order; another pack only adds maps they lack.
function ns.RegisterMapFrames(frames, packId)
	if type(frames) ~= "table" then return end
	local era = frames.era
	if type(era) ~= "table" then return end
	-- A refused pack is refused whole: its frames go too, even under a
	-- holder's id.
	if loadingRefused and loadingRefused.id == packId then
		ns.Debug("RegisterMapFrames: pack", tostring(packId), "was refused")
		return
	end
	local ours = packId == nil or packId == "guides"
	if not ours then
		local r = packs[packId]
		if not (r and accepted(r)) then
			ns.Debug("RegisterMapFrames: pack not registered", tostring(packId))
			return
		end
	end
	for map, b in pairs(era) do
		if type(b) == "table" and isNum(b.c) and isNum(b.left) and isNum(b.right) and isNum(b.top) and isNum(b.bottom) then
			local key = tonumber(map) or map
			if ours then
				ns.MapFrames.era[key] = b
				ourFrames[key] = true
			elseif not ourFrames[key] then
				ns.MapFrames.era[key] = b
			else
				ns.Debug("RegisterMapFrames: pack", packId, "differs from ours for map", tostring(map))
			end
		else
			ns.Debug("RegisterMapFrames: bad bounds for map", tostring(map))
		end
	end
end

---------------------------------------------------------------------------
-- Switching packs off and on (account-wide: PolestarDB.packs[id].off)
---------------------------------------------------------------------------

local function packState(id)
	local db = PolestarDB
	local all = type(db) == "table" and db.packs
	local p = type(all) == "table" and all[id]
	return type(p) == "table" and p or nil
end

-- Is pack `id` shown? Internal packs always are.
function Guides.PackShown(id)
	local r = packs[id]
	if r and r.internal then return true end
	local p = packState(id)
	return not (p and p.off)
end
local packShown = Guides.PackShown

-- Is accepted pack record r on and shown?
local function packVisible(r)
	return accepted(r) and packShown(r.id)
end

-- A registered pack's guides are visible while it is on and shown.
local function visible(g)
	local r = packs[g.pack]
	return r ~= nil and packVisible(r)
end

local function syncStatus(r)
	if accepted(r) then r.status = packShown(r.id) and "on" or "off" end
	return r
end

-- Hides or shows pack `id`'s guides; fires PACKS_CHANGED(id) when that changes.
function Guides.SetPackShown(id, shown)
	if type(id) ~= "string" or (packs[id] and packs[id].internal) then return end
	shown = shown and true or false
	if packShown(id) == shown then return end
	local db = ns.DB()
	if type(db.packs) ~= "table" then db.packs = {} end
	if shown then
		local p = db.packs[id]
		if type(p) == "table" then
			p.off = nil
			if next(p) == nil then db.packs[id] = nil end
		end
	else
		if type(db.packs[id]) ~= "table" then db.packs[id] = {} end
		db.packs[id].off = true
	end
	if packs[id] then syncStatus(packs[id]) end
	ns.Fire("PACKS_CHANGED", id)
end

function Guides.Pack(id)
	if id == nil then return nil end
	local r = packs[id]
	if r then return syncStatus(r) end
	for i = 1, #records do
		if records[i].id == id then return syncStatus(records[i]) end
	end
	return nil
end

-- Every pack record but internal ones and the imported guides (registered
-- and installed, refused ones too): ours first, then by title.
function Guides.Packs()
	local out = {}
	for i = 1, #records do
		if not (records[i].internal or records[i].imported) then out[#out + 1] = syncStatus(records[i]) end
	end
	table.sort(out, function(a, b)
		if a.official ~= b.official then return a.official end
		local ta, tb = (a.title or a.id):lower(), (b.title or b.id):lower()
		if ta ~= tb then return ta < tb end
		if a.id ~= b.id then return a.id < b.id end
		return tostring(a.addon) < tostring(b.addon)
	end)
	return out
end

-- Problems over every listed pack (the Community guides page's dot).
function Guides.ProblemCount()
	local n = 0
	for _, r in ipairs(Guides.Packs()) do n = n + #r.problems end
	return n
end

---------------------------------------------------------------------------
-- Packs on disk: every addon whose TOC carries X-Polestar-Pack, loaded or
-- not, merged with the registered records (run at login; idempotent).
---------------------------------------------------------------------------

local installed = {} -- addon name -> record made from its TOC

local function meta(addon, field)
	local v = C_AddOns.GetAddOnMetadata(addon, field)
	return type(v) == "string" and v ~= "" and v or nil
end

-- The record `addon` registered itself (RegisterPack), refused or not.
local function registeredBy(addon)
	for i = 1, #records do
		local r = records[i]
		if r.addon == addon and r ~= installed[addon] then return r end
	end
end

local function forget(r)
	for i = #records, 1, -1 do
		if records[i] == r then table.remove(records, i) end
	end
end

local function noGuides(r)
	r.status = "broken"
	r.reason = L["Registered no guides."]
	if not r.noGuides then
		r.noGuides = true
		problem(r, "no-guides", r.reason)
	end
end

-- A pack that never registered, from its TOC and the client's state. The
-- compiler writes its Title as "Polestar Community: <title>" for the AddOns
-- list (community addons built before that say "Polestar Pack: <title>");
-- here it reads as the pack's own title, as a registered pack's does.
-- Priority: too-new > disabled > not-loaded > broken.
local function fromToc(r, name, reason, enabled)
	local title = meta(name, "Title")
	if title then title = title:gsub("^Polestar Community: ", ""):gsub("^Polestar Pack: ", "") end
	r.title = escape(title or name)
	for key, field in pairs({ author = "Author", version = "Version", license = "X-License", website = "X-Website" }) do
		local v = meta(name, field)
		r[key] = v and escape(v) or nil
	end
	r.format = tonumber(meta(name, "X-Polestar-Format"))
	local needs = meta(name, "X-Polestar-Needs")
	r.needs = needs and escape(needs) or nil
	r.reason = nil
	if r.format and not Guides.FORMATS[r.format] then
		r.status = "too-new"
		r.reason = tooNewReason(r.needs)
	elseif reason == "DISABLED" or not enabled then
		r.status = "disabled"
	elseif not C_AddOns.IsAddOnLoaded(name) then
		r.status = "not-loaded"
		local text = type(reason) == "string" and reason ~= "" and (_G["ADDON_" .. reason] or reason) or nil
		r.reason = text and escape(text) or nil
	else
		noGuides(r)
	end
end

function Guides.ScanInstalled()
	local A = C_AddOns
	if not (A and A.GetNumAddOns and A.GetAddOnInfo and A.GetAddOnMetadata and A.IsAddOnLoaded) then return end
	local player = UnitName and UnitName("player") or nil
	for i = 1, A.GetNumAddOns() do
		local name, _, _, _, reason = A.GetAddOnInfo(i)
		local id = type(name) == "string" and meta(name, "X-Polestar-Pack") or nil
		if id then
			local r = registeredBy(name)
			if r then
				if installed[name] then
					forget(installed[name])
					installed[name] = nil
				end
				if accepted(r) and r.guideCount == 0 then noGuides(r) end
			else
				r = installed[name]
				if not r then
					r = newRecord({ id = id }, name)
					installed[name] = r
				end
				local enabled = true
				if A.GetAddOnEnableState then
					local ok, state = pcall(A.GetAddOnEnableState, name, player)
					enabled = not (ok and state == 0)
				end
				fromToc(r, name, reason, enabled)
			end
		end
	end
end

---------------------------------------------------------------------------
-- Texts in the client's language (GuideTexts): once a pack's files are in,
-- its texts addon loads and its guides take the translations and the names;
-- again when the names pack lands late (NAMES_LOADED) or a texts addon
-- refused in combat loads after it.
---------------------------------------------------------------------------

local GuideTexts = ns.GuideTexts
local loggedIn = false

local function relocalise(packId)
	local changed = false
	for id, def in pairs(guides) do
		if (packId == nil or def.pack == packId) and GuideTexts.Refresh(def) then
			changed = true
			local h = headers[id]
			if h then
				for _, k in ipairs(GuideTexts.GUIDE_FIELDS) do h[k] = def[k] end
			end
		end
	end
	for _, r in ipairs(records) do
		if (packId == nil or r.id == packId) and r.english then
			if r.english.title then r.title = escape(GuideTexts.PackText(r.id, r.english.title)) end
			if r.english.notes then r.notes = escape(GuideTexts.PackText(r.id, r.english.notes)) end
		end
	end
	if changed and loggedIn then ns.Fire("GUIDES_REGISTERED") end
end

ns.RegisterEvent("ADDON_LOADED", function(_, name)
	loadingRefused = nil
	if type(name) ~= "string" then return end
	loaded[name] = true
	if not ns.Names.Localised() then return end
	for _, r in ipairs(records) do
		if r.addon == name and accepted(r) then
			GuideTexts.Load(name)
			relocalise(r.id)
		end
	end
end)

ns.On("NAMES_LOADED", function() relocalise(nil) end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	for _, addon in ipairs(GuideTexts.Pending()) do
		if GuideTexts.Load(addon) == "loaded" then
			for _, r in ipairs(records) do
				if r.addon == addon and accepted(r) then relocalise(r.id) end
			end
		end
	end
end)

---------------------------------------------------------------------------
-- Queries (guides of hidden packs are left out)
---------------------------------------------------------------------------

function Guides.Get(id)
	local g = id and guides[id]
	if g and visible(g) then return g end
	return nil
end

function Guides.List()
	local out = {}
	for i = 1, #order do
		local g = guides[order[i]]
		if visible(g) then out[#out + 1] = headers[order[i]] end
	end
	return out
end

-- Where a guide starts: its first goal with coordinates (cached).
local startOf = setmetatable({}, { __mode = "k" })
local function guideStart(g)
	local p = startOf[g]
	if p == nil then
		p = false
		for _, step in ipairs(g.steps) do
			for _, goal in ipairs(step.goals) do
				if goal.map and goal.x and goal.y then
					p = { map = goal.map, x = goal.x, y = goal.y, f = goal.f }
					break
				end
			end
			if p then break end
		end
		startOf[g] = p
	end
	return p or nil
end
Guides.Start = guideStart

-- Shown guides whose route choice (`nextChoices`) offers `id` now (an
-- option with `when` only while it holds: Engine.RouteOffered), in
-- registration order.
function Guides.OfferedBy(id)
	local out = {}
	local E = ns.Engine
	for i = 1, #order do
		local g = guides[order[i]]
		if g.nextChoices and visible(g) then
			for _, c in ipairs(g.nextChoices) do
				if c == id then
					if not (E and E.RouteOffered) or E.RouteOffered(g.id, id) then out[#out + 1] = g end
					break
				end
			end
		end
	end
	return out
end

local function hasLeveling(r)
	for _, id in ipairs(r.guides) do
		local g = guides[id]
		if g and (g.category == nil or g.category == "Leveling") then return true end
	end
	return false
end

-- Can pack `id` be where suggestions come from? Registered, not internal,
-- shown, with leveling guides. Ours always can.
local function canSuggest(id)
	if id == "guides" then return true end
	local r = type(id) == "string" and packs[id]
	return r and not r.internal and not r.imported and packVisible(r) and hasLeveling(r) or false
end

-- The packs suggestions can come from, ours ("guides") first, then the
-- others as Guides.Packs orders them (the Community guides page's choices).
function Guides.SuggestSources()
	local out = { "guides" }
	for _, r in ipairs(Guides.Packs()) do
		if r.id ~= "guides" and packs[r.id] == r and canSuggest(r.id) then out[#out + 1] = r.id end
	end
	return out
end

-- Where suggestions come from: behavior.suggestFrom when that pack can
-- (SuggestSources), else ours ("guides").
function Guides.SuggestSource()
	local from = ns.Get and ns.Get("behavior.suggestFrom")
	if type(from) == "string" and canSuggest(from) then return from end
	return "guides"
end

-- Travel times this close count as a tie (the race's own chain wins).
local TRAVEL_TIE = 120 -- seconds

local function less(a, b)
	for i = 1, #a do
		if a[i] ~= b[i] then return a[i] < b[i] end
	end
	return false
end

-- One pack's leveling guides for the player: the fitting ones, ranked, and
-- the best of the rest. -> fitting { id, ... }, best id | nil
local function rank(packId, player, here, zone)
	local r = packs[packId]
	if not (r and packVisible(r)) then return {}, nil end
	local level = player.level or 1
	local fitting, best, bestKey = {}, nil, nil
	for i, id in ipairs(r.guides) do
		local g = guides[id]
		if (g.category == nil or g.category == "Leveling") and guideMatches(g, player) then
			local lo, hi = g.minLevel or 1, g.maxLevel or g.minLevel or 1
			if hi < lo then hi = lo end
			if level >= lo and level <= hi then
				local specific = ((g.races and #g.races > 0) or (g.classes and #g.classes > 0)) and 0 or 1
				local inZone = ((here and g.zone == here.map) or (zone and g.zoneName == zone)) and 0 or 1
				local band = math.huge
				local start = here and guideStart(g)
				if start then
					local cost = ns.TravelCost(here, start)
					if cost then band = math.floor(cost / TRAVEL_TIE) end
				end
				fitting[#fitting + 1] = { id = g.id, key = { inZone, band, specific, hi - lo, lo, i } }
			elseif #fitting == 0 then
				local key = lo > level and { 1, lo - level, hi - lo, i } or { 2, level - hi, hi - lo, i }
				if not bestKey or less(key, bestKey) then best, bestKey = g.id, key end
			end
		end
	end
	table.sort(fitting, function(a, b) return less(a.key, b.key) end)
	local out = {}
	for i = 1, #fitting do out[i] = fitting[i].id end
	return out, best
end

-- Leveling guides for the player, best first (category "Leveling" or none;
-- other categories are only ever picked by the player), from the suggestion
-- source (SuggestSource); where it has nothing for the player, ours fill in.
-- Faction/race/class must match. Every guide whose level range contains the
-- player's level, in this order: the player's current zone first, then the
-- nearest by travel (in 2-minute bands), then race- or class-specific (the
-- race's own chain), then the narrowest range, the lowest minLevel and
-- registration order. If none contains the level: the nearest upcoming
-- guide, else the highest one below, alone. -> { id, ... }
function Guides.Suggestions()
	local player = ns.Compat.GetPlayerInfo()
	local here = ns.PlayerPoint()
	local zone = ns.Compat.GetZoneText()
	local source = Guides.SuggestSource()
	local fitting, best = rank(source, player, here, zone)
	if #fitting > 0 then return fitting end
	if source ~= "guides" then
		local ours, oursBest = rank("guides", player, here, zone)
		if #ours > 0 then return ours end
		best = oursBest or best
	end
	return { best }
end

-- The best leveling guide for the player: the first of Suggestions().
function Guides.Suggest()
	return Guides.Suggestions()[1]
end

-- Drops an imported guide from the registry (Import.Delete); a guide of any
-- other pack stays. Fire PACKS_CHANGED("imported") after. -> bool
function Guides.DropImported(id)
	local g = type(id) == "string" and guides[id]
	if not (g and g.pack == "imported") then return false end
	guides[id], headers[id] = nil, nil
	for i = #order, 1, -1 do
		if order[i] == id then table.remove(order, i) end
	end
	local r = packs.imported
	for i = #r.guides, 1, -1 do
		if r.guides[i] == id then table.remove(r.guides, i) end
	end
	r.guideCount = #r.guides
	return true
end

-- The leveling guide a new character of the player's race and class starts
-- with: the suggestion at level 1, from the suggestion source (ours where it
-- has none). The catch-up opens it when no guide is open and goes through
-- the guides from there to where the player is (Engine, login).
function Guides.FirstGuide()
	local p = {}
	for k, v in pairs(ns.Compat.GetPlayerInfo()) do p[k] = v end
	p.level = 1
	local source = Guides.SuggestSource()
	local fitting = rank(source, p, nil, nil)
	if #fitting == 0 and source ~= "guides" then fitting = rank("guides", p, nil, nil) end
	return fitting[1]
end

ns.OnLogin(function()
	loggedIn = true
	Guides.ScanInstalled()
	-- The imported guides, now that every community addon has registered and
	-- every installed one is listed (an addon keeps its ids: Import.Load
	-- leaves out an imported guide under an addon's id).
	if ns.Import then ns.Import.Load() end
	ns.Fire("GUIDES_REGISTERED")
end)
