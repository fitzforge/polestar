-- Polestar.Dungeons: a journal page per dungeon and raid:
-- every quest with where it starts and ends,
-- its objective, chain and rewards, the bosses in kill order with the quests
-- tied to them, and the entrance. No loot tables. Scope: docs/SUITE.md,
-- "Modules"; data and runtime: docs/ARCHITECTURE.md, "Reference data"
-- (`dungeons.json` and the journal pages).
--
-- The data rides in the load-on-demand Codex pack (Dungeons1.lua, written by
-- `codex build` through tools/lib/codex/journal.js): per dungeon a summary
-- table and its page as Lua source, compiled only when that page is asked
-- for. One page is kept decoded at a time.
--
--   Dungeons.Load() -> ok, reason   -- "off" (dungeons.enabled false), Data.Pack's reasons
--                                     ("missing", "disabled", "combat", ...), "nodata" (pack built without Dungeons)
--   Dungeons.IsEnabled() ; Dungeons.Meta()
--   Dungeons.List() -> { { key, name, kind, forever, minLevel, maxLevel, players, map, zone, zoneName,
--       entrance = { map, x, y, f } | nil, quests = { A = n, H = n }, bosses = n,
--       attune = { A = n, H = n } } }   -- level order, no page decoded
--       (name and zoneName in the client's language when it has them; map: the instance's Map id)
--   Dungeons.Get(key) -> { key, name, kind, forever, minLevel, maxLevel, players, map, zone, zoneName, entrance } | nil
--   Dungeons.Entrance(key) -> map, x, y, f | nil
--   Dungeons.Quests(key, faction) -> { quest, ... }   -- faction "A" | "H" | nil (all); level order
--   Dungeons.Quest(key, id) -> quest | nil           -- page and chain quests
--       quest = { id, title, level, minLevel, faction, classes, inside, shareable,
--         objectives = { { k = "kill"|"item"|"object"|"event", id, n (count over one), name (English) } },
--         start, finish (= { kind, id, name, map, x, y, f, inside }), startItem = { id, name },
--         chain = { ids }, rewards = { items = { { id, name, quality, choice } }, xp, money, rep = { { faction, name, value } } },
--         bosses = { names } }
--   Dungeons.ObjectiveText(quest) -> text | nil   -- its objectives in the client's language, one a line
--   Dungeons.Bosses(key) -> { { order, name, npc, level, object, role, encounter, quests = { { id, how, item, itemName } } } }
--       object: a chest boss's object id (npc nil); role: "rare" | "event" | "optional" for the
--       bosses after the encounters, nil for an encounter (and on pages built before roles);
--       encounter: its DungeonEncounter id (its name in every language: Names.Encounter)
--       how: "kill" (an objective), "item" (drops an objective item), "starts" (drops the item
--       that starts it), "involved" (DungeonJournal names it for the quest)
--   Dungeons.Open(key|nil)   -- fires SHOW_DUNGEON(key); the hub section listens
--   Dungeons.GuideTo(key) -> ok ; Dungeons.GuideToPoint(point, label[, stop]) -> ok   (Nav)
--   Dungeons.ShowOnMap(key) -> ok   -- the world map on the entrance's zone
--   Dungeons.Find(text) -> key | nil   -- by name (the client's language or English) or key
--   Dungeons.Register(group, a, b)  -- pack files only
--   Dungeons.Attunements(key, faction) -> { attunement, ... }   -- faction "A" | "H" | nil (all)
--       attunement = { id, name, kind = "attunement"|"key"|"item", need = "each"|"one", faction,
--         item = { id, name, quality }, note, level, any, goal = { questIds }, steps = { step, ... },
--         inside = { { kind = "npc"|"object", id, instance }, ... } | nil }   -- spawnless NPCs and objects it meets, placed
--       step: { kind = "quest", id, title, level, minLevel, faction, classes, start, finish,
--         startItem, after = { ids }, afterAny = { ids }, goal, rep = { faction, name, standing } }
--         | { kind = "drop", item, npc = point, chance, instance } | { kind = "object", item, object = point, chance }
--         | { kind = "rep", faction, name, standing } | { kind = "gift", item, npc = point }
--       (tools/lib/codex/attunements.js; their state and guide: Dungeons/Attune.lua)
--   Picking up a page's quests (PickupPlan, PickupGuide, PickUp, GiverTarget,
--   PlanStops, OrderStops): Dungeons/Pickup.lua. Handing them in after the
--   run (HandinPlan, HandinFollowUps, HandinGuide, HandIn, HandinText):
--   Dungeons/Handin.lua. Attunements and keys (AttunementState, AttuneGuide,
--   Attune): Dungeons/Attune.lua.
-- Settings: dungeons.enabled. Command: /polestar dungeons [name].

local ADDON, ns = ...
local L = ns.L

local Dungeons = {}
ns.Dungeons = Dungeons

local type, pairs, ipairs, pcall, tostring = type, pairs, ipairs, pcall, tostring
local find, lower, format, gsub = string.find, string.lower, string.format, string.gsub
local sort = table.sort

ns.RegisterDefaults("dungeons", { enabled = true })

local function enabled() return ns.Get("dungeons.enabled") and true or false end
Dungeons.IsEnabled = enabled

local meta
local summaries = {} -- key -> summary table
local sources = {} -- key -> page source (string)
local openKey, openPage -- the one decoded page

---------------------------------------------------------------------------
-- Registration and loading
---------------------------------------------------------------------------

function Dungeons.Register(group, a, b)
	if group == "meta" then
		if type(a) == "table" then meta = a end
	elseif group == "dungeon" then
		if type(a) == "table" then for k, v in pairs(a) do summaries[k] = v end end
		if type(b) == "table" then for k, v in pairs(b) do sources[k] = v end end
		openKey, openPage = nil, nil
	end
end

function Dungeons.Meta() return meta end

function Dungeons.Load()
	if not enabled() then return false, "off" end
	if meta then return true end
	local C = ns.Codex
	if not (C and C.Load) then return false, "missing" end
	local loaded, reason = C.Load()
	if not loaded then return false, reason end
	if not meta then return false, "nodata" end
	return true
end

local function ready()
	if meta then return enabled() end
	return (Dungeons.Load())
end

-- A page's quest, NPC, object and item names in the client's language
-- (Polestar.Names), in place: quest titles, start and finish points, items
-- (rewards, starting items, keys), boss names and the quests' boss lists.
-- English stays where the language has no name.
local ITEM_KEYS = { item = true, startItem = true, items = true }
local NAMED = { npc = true, object = true, item = true }

local function localise(N, t, key)
	local itemWas = type(t.item) == "table" and t.item.name
	for k, v in pairs(t) do
		if type(v) == "table" then localise(N, v, type(k) == "number" and key or k) end
	end
	local id = t.id
	if type(id) == "number" then
		if t.title then
			t.title = N.Quest(id) or t.title
		elseif t.name then
			local kind = NAMED[t.kind] and t.kind or (ITEM_KEYS[key] and "item")
			if kind then t.name = N.Get(kind, id) or t.name end
		end
	elseif itemWas and t.name == itemWas then
		t.name = t.item.name -- a key named after its item
	end
	if type(t.item) == "number" and t.itemName then t.itemName = N.Item(t.item) or t.itemName end
end

local function localisePage(p)
	local N = ns.Names
	if not (N and N.Localised()) then return end
	local bossName = {}
	for _, b in ipairs(p.bosses) do
		local was = b.name
		b.name = N.Encounter(b.encounter) or N.Npc(b.npc) or N.Object(b.object) or was
		if was then bossName[was] = b.name end
		for _, q in ipairs(b.quests or {}) do
			if type(q.item) == "number" and q.itemName then q.itemName = N.Item(q.item) or q.itemName end
		end
	end
	-- An attunement named after its goal quest takes that quest's title; one
	-- named otherwise (The Dread Citadel, its quests "The Dread Citadel -
	-- Naxxramas") takes its first goal quest's name in the client's language.
	local goalStep = {}
	for _, a in ipairs(p.attunement) do
		local g = type(a.goal) == "table" and a.goal[1]
		for _, s in ipairs(a.steps or {}) do
			if g and s.kind == "quest" and s.id == g and s.title == a.name then goalStep[a] = s end
		end
	end
	for _, group in ipairs({ p.quests, p.chain, p.attunement }) do
		localise(N, group)
		for _, q in pairs(group) do
			if type(q) == "table" and type(q.bosses) == "table" then
				for i, name in ipairs(q.bosses) do q.bosses[i] = bossName[name] or name end
			end
		end
	end
	for _, a in ipairs(p.attunement) do
		local g = a.kind == "attunement" and type(a.goal) == "table" and a.goal[1]
		if goalStep[a] then a.name = goalStep[a].title
		elseif type(g) == "number" then a.name = N.Quest(g) or a.name end
	end
end

-- key -> page | nil, compiled from its source in an empty environment.
local function page(key)
	if key == nil or not ready() then return nil end
	if key == openKey then return openPage end
	local src = sources[key]
	if type(src) ~= "string" then return nil end
	local fn = loadstring(src, "=Dungeons:" .. tostring(key))
	if not fn then return nil end
	setfenv(fn, {})
	local ok, p = pcall(fn)
	if not ok or type(p) ~= "table" then return nil end
	p.quests = p.quests or {}
	p.chain = p.chain or {}
	p.bosses = p.bosses or {}
	p.attunement = p.attunement or {}
	localisePage(p)
	openKey, openPage = key, p
	return p
end

-- The open page holds translated names: decode it again after the names
-- pack arrives late, or when a name it carries is learned anew.
ns.On("NAMES_LOADED", function() openKey, openPage = nil, nil end)
ns.On("NAME_LEARNED", function(_, id)
	local src = openKey and sources[openKey]
	if type(src) ~= "string" then return end
	for _, field in ipairs({ "id=", "npc=", "object=" }) do
		if find(src, field .. id .. ",", 1, true) or find(src, field .. id .. "}", 1, true) then
			openKey, openPage = nil, nil
			return
		end
	end
end)

---------------------------------------------------------------------------
-- Reading
---------------------------------------------------------------------------

-- The instance's name and its zone's in the client's language (Names: the
-- names pack's Map.csv name, the client's map name), else the data's English.
local function summary(key, s)
	local N = ns.Names
	local localised = N and N.Localised and N.Localised()
	local zoneName = s.zoneName
	if localised and s.zone then zoneName = ns.Compat.MapName(s.zone) or zoneName end
	return {
		key = key, name = (localised and s.map and N.Instance(s.map)) or s.name or key, kind = s.kind or "dungeon", forever = s.forever and true or false,
		minLevel = s.minLevel, maxLevel = s.maxLevel, players = s.players, map = s.map, zone = s.zone, zoneName = zoneName,
		entrance = s.entrance,
		quests = { A = s.quests and s.quests.A or 0, H = s.quests and s.quests.H or 0 }, bosses = s.bosses or 0,
		attune = { A = s.attune and s.attune.A or 0, H = s.attune and s.attune.H or 0 },
	}
end

function Dungeons.List()
	if not ready() then return {} end
	local out = {}
	for key, s in pairs(summaries) do out[#out + 1] = summary(key, s) end
	sort(out, function(a, b)
		local la, lb = a.minLevel or 99, b.minLevel or 99
		if la ~= lb then return la < lb end
		if a.name ~= b.name then return a.name < b.name end
		return a.key < b.key
	end)
	return out
end

function Dungeons.Get(key)
	local s = key ~= nil and ready() and summaries[key]
	if not s then return nil end
	return summary(key, s)
end

function Dungeons.Entrance(key)
	local s = key ~= nil and ready() and summaries[key]
	local e = s and s.entrance
	if not e then return nil end
	return e.map, e.x, e.y, e.f
end

function Dungeons.Quests(key, faction)
	local p = page(key)
	if not p then return {} end
	local out = {}
	for _, q in ipairs(p.quests) do
		if faction == nil or q.faction == nil or q.faction == faction then out[#out + 1] = q end
	end
	return out
end

function Dungeons.Quest(key, id)
	local p = page(key)
	if not (p and id) then return nil end
	for _, q in ipairs(p.quests) do if q.id == id then return q end end
	return p.chain[id]
end

function Dungeons.Bosses(key)
	local p = page(key)
	return p and p.bosses or {}
end

-- A quest's objective line in the client's language, one objective a line,
-- composed from the page's objective facts (quest.objectives = { { k, id, n,
-- name } }): "Kill 15 <npc>", "Collect 8 <item>", "Use <object>" with the
-- names from Polestar.Names, else the data's English. Objectives without an
-- id (escorts, events) read the quest's objective summary from the names
-- pack ("objective") once, else each its English text. A page built before
-- the objective facts (an older Codex pack) keeps its English line
-- (quest.objective). nil: none.
local OBJECTIVE = {
	kill = { L["Kill %s"], L["Kill %d %s"], "npc" },
	item = { L["Collect %s"], L["Collect %d %s"], "item" },
	object = { L["Use %s"], nil, "object" },
}

-- The quest text tokens a summary keeps: $B a line break (a space here),
-- $N name, $C class, $R race, $G male:female;
local function fill(s)
	local name = UnitName and UnitName("player") or ""
	local class = UnitClass and UnitClass("player") or ""
	local race = UnitRace and UnitRace("player") or ""
	local female = UnitSex and UnitSex("player") == 3
	s = gsub(gsub(s, "%s*%$[Bb]%s*", " "), "  +", " ")
	s = gsub(s, "%$[Gg]%s*([^:;]*):([^;]*);", function(m, f) return female and f or m end)
	s = gsub(s, "%$([NnCcRr])", function(t)
		t = lower(t)
		return t == "n" and name or t == "c" and class or race
	end)
	return s
end

function Dungeons.ObjectiveText(q)
	local list = type(q) == "table" and q.objectives
	if type(list) ~= "table" or #list == 0 then
		return type(q) == "table" and type(q.objective) == "string" and q.objective ~= "" and q.objective or nil
	end
	local N = ns.Names
	local lines, summaryDone = {}, false
	for _, o in ipairs(list) do
		local f = OBJECTIVE[o.k]
		if f then
			local name = (N and N.Get(f[3], o.id)) or o.name or ""
			lines[#lines + 1] = (o.n and f[2]) and format(f[2], o.n, name) or format(f[1], name)
		elseif not summaryDone then
			local text = N and N.Get("objective", q.id)
			if text then
				summaryDone = true
				lines[#lines + 1] = fill(text)
			elseif o.name then
				lines[#lines + 1] = o.name
			end
		end
	end
	if #lines == 0 then return nil end
	return table.concat(lines, "\n")
end

function Dungeons.Attunements(key, faction)
	local p = page(key)
	if not p then return {} end
	local out = {}
	for _, a in ipairs(p.attunement) do
		if not faction or not a.faction or a.faction == faction then out[#out + 1] = a end
	end
	return out
end

-- By name in the client's language or in English, or by key.
function Dungeons.Find(text)
	if type(text) ~= "string" or text == "" then return nil end
	local want, hit = lower(text), nil
	for _, d in ipairs(Dungeons.List()) do
		local n, en = lower(d.name), lower(summaries[d.key].name or d.key)
		if n == want or en == want or d.key == want then return d.key end
		if not hit and (find(n, want, 1, true) or find(en, want, 1, true)) then hit = d.key end
	end
	return hit
end

---------------------------------------------------------------------------
-- Acting
---------------------------------------------------------------------------

function Dungeons.Open(key)
	if not enabled() then
		ns.Print(L["Dungeons are turned off (Options > Discovery > Dungeons)."])
		return false
	end
	ns.Fire("SHOW_DUNGEON", key)
	return true
end

-- `stop`: Nav.SetTarget's stop kind ("dungeon" for an entrance).
function Dungeons.GuideToPoint(point, label, stop)
	local Nav = ns.Nav
	if not (type(point) == "table" and point.map and point.x and point.y and Nav and Nav.SetTarget) then return false end
	return Nav.SetTarget(point.map, point.x, point.y, label or point.name, point.f, stop) and true or false
end

function Dungeons.GuideTo(key)
	local d = Dungeons.Get(key)
	if not (d and d.entrance) then return false end
	return Dungeons.GuideToPoint(d.entrance, d.name, "dungeon")
end

-- Through Compat.OpenWorldMap: the client's C_Map opener, never in combat
-- (the global OpenWorldMap taints the map: NAV_QA C3).
function Dungeons.ShowOnMap(key)
	local map = Dungeons.Entrance(key)
	if not map then return false end
	return ns.Compat.OpenWorldMap(map)
end

ns.RegisterCommand("dungeons", function(rest)
	Dungeons.Open(rest ~= "" and Dungeons.Find(rest) or nil)
end, L["Dungeon quests, bosses and entrances"])

if ns.RegisterOptions then
	local ok, err = ns.RegisterOptions({
		page = L["Discovery"], tab = L["Dungeons"], section = ENCOUNTER_JOURNAL,
		controls = {
			{ kind = "toggle", key = "dungeons.enabled", label = L["Dungeons"],
				help = L["A page per dungeon and raid: every quest with where to get it, its chain and rewards, the bosses and the entrance."] },
		},
	})
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
