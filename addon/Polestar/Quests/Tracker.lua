-- Quest intel on the map: objective markers for every quest in the log,
-- turn-in markers once a quest is ready, and markers on quest givers with
-- quests this character can take now. Markers go through Polestar.Pins.
--
-- Work is event-driven and coalesced: quest log, level and setting events
-- only mark state dirty; one flush per THROTTLE seconds re-reads the log and
-- compares it with what it saw last time. Markers and the per-entity indexes
-- (Tooltips.lua) are rebuilt only when what they show changed: a quest came
-- or went, got ready, changed title, or an objective was done or undone. A
-- progress count alone ("3/10" to "4/10") only fires QUESTDB_UPDATED: tooltips
-- and nameplates read it live, and a marker covers every spawn of its target,
-- so rebuilding thousands of them on every kill would cost for nothing.
-- Markers are kept in a per-map index (QuestDB.GetMarkers(map)).
--
-- Look is applied when a layer is published (stylePin): objective spawn
-- clusters carry their radius as a Pins `area` (qol.objectiveAreas); while a
-- Polestar guide runs, the quests of its current step are enlarged and haloed
-- (qol.guideHighlight) and, with qol.guideDim, every other marker fades.

local ADDON, ns = ...

local Q = ns.QuestDB
local F = Q.F
local Each = Q.Each
local client = Q._client

local pairs, type, tostring = pairs, type, tostring

local THROTTLE = 0.25
-- How long a QUEST_TURNED_IN counts the quest done while the client has
-- not listed it yet (a repeatable quest it never lists).
local TURNIN_BRIDGE = 10

local LAYER_OBJECTIVES = "quests.objectives"
local LAYER_TURNIN = "quests.turnin"
local LAYER_AVAILABLE = "quests.available"
Q.LAYERS = { objectives = LAYER_OBJECTIVES, turnin = LAYER_TURNIN, available = LAYER_AVAILABLE }

local KIND_KILL, KIND_ITEM, KIND_OBJECT, KIND_EVENT = 1, 2, 3, 4

-- Marker look: Theme glyph and colour per kind, on a dark disc (Pins
-- `backdrop`) so it reads over any map art; size on the world map, mini on
-- the minimap; rank picks the glyph when objectives of several kinds share
-- one spawn cluster.
local STYLE = {
	kill = { icon = "icon-kill", color = "danger", size = 16, mini = 14, priority = 2, area = true, rank = 4 },
	collect = { icon = "icon-collect", color = "item", size = 16, mini = 14, priority = 2, area = true, rank = 2 },
	vendor = { icon = "icon-vendor", color = "item", size = 16, mini = 14, priority = 2, rank = 1 },
	interact = { icon = "icon-interact", color = "place", size = 16, mini = 14, priority = 2, area = true, rank = 3 },
	event = { icon = "icon-explore", color = "place", size = 16, mini = 14, priority = 2 },
	turnin = { icon = "icon-turnin", color = "quest", size = 18, mini = 16, priority = 3 },
	available = { icon = "icon-accept", color = "quest", size = 16, mini = 14, priority = 1 },
}
-- The active guide step's quests: the same glyph x FOCUS_SCALE, circled in
-- the accent, on top. Others, while a guide runs and qol.guideDim is on: the
-- same look at DIM_ALPHA (receding, still legible on its disc).
local FOCUS_SCALE, FOCUS_PRIORITY, DIM_ALPHA = 1.3, 3, 0.6
-- Spawn clusters tighter than this (yards) get no area: a single spawn point.
local MIN_AREA = 12
Q.STYLE, Q.FOCUS_SCALE, Q.DIM_ALPHA, Q.MIN_AREA = STYLE, FOCUS_SCALE, DIM_ALPHA, MIN_AREA

-- Only read when Theme is absent; the Dusk values.
local FALLBACK_COLORS = {
	danger = { 0.96, 0.45, 0.45, 1 }, item = { 0.78, 0.68, 1, 1 }, place = { 0.96, 0.68, 0.52, 1 },
	quest = { 1, 0.84, 0.45, 1 }, textDim = { 0.765, 0.793, 0.868, 1 }, success = { 0.42, 0.85, 0.6, 1 }, text = { 0.969, 0.973, 0.992, 1 },
	accent = { 0.902, 0.729, 0.4, 1 },
}

local colors = {} -- name -> { r, g, b, a }, refreshed on theme change
local dimmed = {} -- name -> the same at DIM_ALPHA
local function color(name)
	local c = colors[name]
	if c then return c end
	local r, g, b, a
	local Theme = ns.Theme
	if Theme and Theme.Color then r, g, b, a = Theme.Color(name) end
	if not r then
		local fb = FALLBACK_COLORS[name] or FALLBACK_COLORS.text
		r, g, b, a = fb[1], fb[2], fb[3], fb[4]
	end
	a = a or 1
	c = { r, g, b, a, r = r, g = g, b = b, a = a } -- positional per the Pins contract, named for tooltips
	colors[name] = c
	return c
end
Q.Color = color

local function dimColor(name)
	local d = dimmed[name]
	if d then return d end
	local c = color(name)
	local a = c.a * DIM_ALPHA
	d = { c.r, c.g, c.b, a, r = c.r, g = c.g, b = c.b, a = a }
	dimmed[name] = d
	return d
end

---------------------------------------------------------------------------
-- State
---------------------------------------------------------------------------

local running = false
local entries = {} -- questID -> entry (quests in the log)
local logIDs = {} -- scratch: quest IDs in log order
local generation = 0
local ctx = {} -- player context (QuestDB.PlayerContext)
local candidates = nil -- quest IDs this character could ever take (static filters)
local available = {} -- questID -> true
local availableCount = 0
local completed = {} -- scratch set for the bulk completed-quest call
local haveCompletedSet = false
-- questID -> GetTime() deadline: a QUEST_TURNED_IN counts the quest done
-- for TURNIN_BRIDGE seconds, as the client's completed flag and list can lag
-- the event; until then, the client listing it, or the quest accepted again.
local turnedIn = {}
local dirtyLog, dirtyAvailable, dirtyPublish = false, false, false
local pending = false

-- Per-entity indexes over quests in the log: id -> { objective, ... }.
-- objective = { q, kind, id, count, name, cur, max, done, entry }
local index = { npc = {}, item = {}, object = {}, objectName = {} }
Q._index = index

-- Markers: layer -> { [map] = { pin, ... } } and the flat list given to Pins.
local markers = { [LAYER_OBJECTIVES] = {}, [LAYER_TURNIN] = {}, [LAYER_AVAILABLE] = {} }
local flat = { [LAYER_OBJECTIVES] = {}, [LAYER_TURNIN] = {}, [LAYER_AVAILABLE] = {} }

local stats = { scans = 0, changes = 0, rebuilds = 0, availableScans = 0, availableChecks = 0, publishes = 0 }
Q.stats = stats

---------------------------------------------------------------------------
-- Quest log
---------------------------------------------------------------------------

-- The name an objective's client line is matched on: the client's language
-- where Polestar.Names has it (a French line says "Vermine kobold tuée"),
-- else the database's English.
local function entityName(kind, id)
	local N = ns.Names
	if kind == KIND_KILL then
		local r = Q.NpcRecord(id)
		return r and ((N and N.Npc(id)) or r[1])
	elseif kind == KIND_ITEM then
		local r = Q.ItemRecord(id)
		return r and ((N and N.Item(id)) or r[1])
	elseif kind == KIND_OBJECT then
		local r = Q.ObjectRecord(id)
		return r and ((N and N.Object(id)) or r[1])
	end
end

local function newEntry(q)
	local r = Q.QuestRecord(q)
	local e = { q = q, rec = r, objs = {}, ready = nil, seen = 0 }
	local obj = r and r[F.OBJ]
	if obj then
		for i = 1, #obj, 3 do
			local kind, id = obj[i], obj[i + 1]
			e.objs[#e.objs + 1] = {
				q = q, entry = e, kind = kind, id = id, count = obj[i + 2],
				name = entityName(kind, id), cur = 0, max = obj[i + 2] or 1, done = false, ci = nil,
			}
		end
	end
	return e
end

local find, sort = string.find, table.sort

-- Client objective lines carry counts: "Kobold Vermin slain: 3/10",
-- "Linen Cloth: 2/6", on some clients "3/10 Kobold Vermin slain". A line's
-- label is its text without them (Compat.ObjectiveLabel, shared with the
-- guide's objective goals), the name an objective is matched on; a line of
-- counts alone (" slain: 0/8", ": 0/1") has no name yet.
local lineLabel = ns.Compat.ObjectiveLabel

-- Same-name objectives, one group per name, longest name first (database
-- order between equal lengths).
local function nameGroups(objs)
	local groups, byName = {}, {}
	for i = 1, #objs do
		local o = objs[i]
		if o.name then
			local g = byName[o.name]
			if not g then
				g = { name = o.name, first = i }
				byName[o.name] = g
				groups[#groups + 1] = g
			end
			g[#g + 1] = o
		end
	end
	sort(groups, function(a, b)
		local la, lb = #a.name, #b.name
		if la ~= lb then return la > lb end
		return a.first < b.first
	end)
	return groups
end

-- Gives a group's objectives without a line the free lines `fits` accepts:
-- first a line requiring the objective's own count, then the first left,
-- in database order.
local function claim(g, client, n, used, fits)
	for pass = 1, 2 do
		for j = 1, #g do
			local o = g[j]
			if not o.ci then
				for k = 1, n do
					if not used[k] and fits(k) and (pass == 2 or client[k].numRequired == o.count) then
						o.ci, used[k] = k, true
						break
					end
				end
			end
		end
	end
end

-- Gives each database objective its client line (o.ci), one objective per
-- line, by precedence: a label equal to the name, then a name inside the
-- text (longest name first, so "Gnoll" never takes "Gnoll Brute slain"),
-- objectives of one name preferring the line with their count, then the
-- line an objective of the identical name holds (the database lists one
-- target twice, the client counts it once), then the same position, then,
-- when as many objectives as lines are left, the rest in order. An
-- objective left without a line reads 0 until the quest is ready. False
-- while a line has no name yet (no text, or only counts as in " slain:
-- 0/8"): match again on the next scan.
local function matchLines(objs, client, n)
	local labels, used, settled = {}, {}, true
	for k = 1, n do
		local text = client[k].text
		local label = type(text) == "string" and lineLabel(text) or ""
		if label ~= "" then
			labels[k] = label
		else
			settled = false
		end
	end
	for i = 1, #objs do objs[i].ci = nil end
	local groups = nameGroups(objs)
	for j = 1, #groups do
		local name = groups[j].name
		claim(groups[j], client, n, used, function(k) return labels[k] == name end)
	end
	for j = 1, #groups do
		local name = groups[j].name
		claim(groups[j], client, n, used, function(k)
			return labels[k] ~= nil and find(client[k].text, name, 1, true) ~= nil
		end)
	end
	for i = 1, #objs do
		local o = objs[i]
		if not o.ci and o.name then
			for j = 1, #objs do
				local p = objs[j]
				if p.ci and p.name == o.name then
					o.ci = p.ci
					break
				end
			end
		end
	end
	for i = 1, #objs do
		local o = objs[i]
		if not o.ci and i <= n and not used[i] then o.ci, used[i] = i, true end
	end
	local left, free = {}, {}
	for i = 1, #objs do
		if not objs[i].ci then left[#left + 1] = objs[i] end
	end
	for k = 1, n do
		if not used[k] then free[#free + 1] = k end
	end
	if #left == #free then
		for j = 1, #left do left[j].ci = free[j] end
	end
	return settled
end

-- Reads one quest's title, readiness and objective progress. Lines are
-- matched again when the client's count of them changes, and on every scan
-- until each has a name. Returns two
-- booleans: what markers show changed (title, ready, an objective done or
-- undone), and a progress count changed.
local function readProgress(e)
	local shape, progress = false, false
	local title = ns.Compat.GetQuestTitle(e.q) or (e.rec and e.rec[F.TITLE]) or ("Quest " .. e.q)
	if title ~= e.title then
		e.title = title
		shape = true
	end
	local ready = ns.Compat.IsQuestReadyForTurnIn(e.q) and true or false
	if ready ~= e.ready then
		e.ready = ready
		shape = true
	end
	local objs = e.objs
	if #objs == 0 then return shape, progress end
	local client = ns.Compat.GetQuestObjectives(e.q)
	local n = client and #client or 0
	if e.lines ~= n then e.lines = matchLines(objs, client, n) and n or nil end
	for i = 1, #objs do
		local o = objs[i]
		local ci = o.ci
		local cur, max, done
		if ci then
			local c = client[ci]
			cur, max, done = c.numFulfilled or 0, c.numRequired or o.max, c.finished and true or false
		else
			cur, max, done = 0, o.max, ready
		end
		if ready then done = true end
		if done ~= o.done then
			o.done = done
			shape = true
		end
		if cur ~= o.cur or max ~= o.max then
			o.cur, o.max = cur, max
			progress = true
		end
	end
	return shape, progress
end

-- Quests the log enumeration may not show (under a collapsed header): seeded
-- by a sweep at start and by QUEST_ACCEPTED, kept while the client says the
-- character is on them.
local hidden = {}

-- Read one quest; returns (shape, progress) as readProgress, a new quest
-- counting as a shape change.
local function visit(q)
	local e = entries[q]
	local added = false
	if not e then
		e = newEntry(q)
		entries[q] = e
		added = true
		dirtyAvailable = true
	end
	e.seen = generation
	local shape, progress = readProgress(e)
	return shape or added, progress
end

-- Re-read the log: (shape, progress) over every quest, a quest that left
-- the log counting as a shape change.
local function scanLog()
	stats.scans = stats.scans + 1
	generation = generation + 1
	local shape, progress = false, false
	client.LogQuestIDs(logIDs)
	for i = 1, #logIDs do
		local s, p = visit(logIDs[i])
		shape, progress = shape or s, progress or p
	end
	for q in pairs(hidden) do
		local e = entries[q]
		if not (e and e.seen == generation) and ns.Compat.IsOnQuest(q) then
			local s, p = visit(q)
			shape, progress = shape or s, progress or p
		end
		hidden[q] = nil
	end
	for q, e in pairs(entries) do
		if e.seen ~= generation then
			if ns.Compat.IsOnQuest(q) then
				e.seen = generation
				local s, p = readProgress(e)
				shape, progress = shape or s, progress or p
			else
				entries[q] = nil
				shape = true
				dirtyAvailable = true
			end
		end
	end
	return shape, progress
end

local function sweepLog()
	for q in pairs(Q._data.quests) do
		if ns.Compat.IsOnQuest(q) then hidden[q] = true end
	end
end

---------------------------------------------------------------------------
-- Indexes (tooltips, nameplates)
---------------------------------------------------------------------------

-- An objective is listed once per key: an item dropped by several objects
-- that share a name (Sapphire of Aku'Mai: three) meets the name key once per
-- object.
local function push(t, id, o)
	local list = t[id]
	if not list then
		t[id] = { o }
		return
	end
	for i = 1, #list do
		if list[i] == o then return end
	end
	list[#list + 1] = o
end

local function rebuildIndex()
	for _, t in pairs(index) do
		for k in pairs(t) do t[k] = nil end
	end
	for _, e in pairs(entries) do
		for i = 1, #e.objs do
			local o = e.objs[i]
			if o.kind == KIND_KILL then
				push(index.npc, o.id, o)
			elseif o.kind == KIND_OBJECT then
				push(index.object, o.id, o)
				if o.name then push(index.objectName, o.name, o) end
			elseif o.kind == KIND_ITEM then
				push(index.item, o.id, o)
				local r = Q.ItemRecord(o.id)
				if r then
					local nd = r[2] or 0
					for k = 1, nd do push(index.npc, r[1 + 2 * k], o) end
					local j = 3 + 2 * nd
					for k = 1, (r[j] or 0) do
						local obj = r[j + 2 * k - 1]
						push(index.object, obj, o)
						-- Matched against the object tooltip's name: the client's language.
						if Q.ObjectRecord(obj) then push(index.objectName, Q.EntityName(-obj), o) end
					end
				end
			end
		end
	end
end

-- Objectives (in the log) an NPC / item / object is for; nil when none.
function Q.ObjectivesForNpc(id) return id and index.npc[id] or nil end
function Q.ObjectivesForItem(id) return id and index.item[id] or nil end
function Q.ObjectivesForObject(id) return id and index.object[id] or nil end
function Q.ObjectivesForObjectName(name) return name and index.objectName[name] or nil end

-- "3/10", or the objective's done state.
function Q.ProgressText(o)
	if o.kind == KIND_EVENT or (o.max or 0) <= 1 then
		return o.done and ns.L["Done"] or ns.L["Not done"]
	end
	return (o.cur or 0) .. "/" .. (o.max or 0)
end

---------------------------------------------------------------------------
-- Markers
---------------------------------------------------------------------------

local function addTooltipLines(tt, pin)
	local head = pin.header
	if head then tt:AddLine(head, 1, 1, 1) end
	local qc, dim = color("quest"), color("textDim")
	local refs = pin.refs
	for i = 1, #refs do
		local ref = refs[i]
		if pin.kind == "turnin" then
			tt:AddLine(ns.L["Turn in"] .. ": " .. (ref.title or ""), qc.r, qc.g, qc.b)
		elseif pin.kind == "available" then
			local r = Q.QuestRecord(ref)
			local lvl = r and r[F.LEVEL]
			local title = (r and Q.GetQuestTitle(ref) or tostring(ref)) .. ((lvl and lvl > 0) and (" (" .. lvl .. ")") or "")
			tt:AddLine(title, qc.r, qc.g, qc.b)
		else
			local e = ref.entry
			tt:AddLine(e.title or ("Quest " .. e.q), qc.r, qc.g, qc.b)
			local what = ref.name and (ref.name .. ": ") or ""
			tt:AddLine("  " .. what .. Q.ProgressText(ref), dim.r, dim.g, dim.b)
		end
	end
end

-- Pins kept from the last rebuild of each layer, by key, and reused by the
-- next: no new tables or closures, and the world position (c, wx, wy) worked
-- out once, so Pins.SetLayer skips converting it. A key names one spawn
-- cluster (or event point), whose position the data never changes. Each
-- rebuild keeps only the pins it used (poolGen).
local pools = { [LAYER_OBJECTIVES] = {}, [LAYER_TURNIN] = {}, [LAYER_AVAILABLE] = {} }
local poolGen = 0

local function prune(layer)
	local pool = pools[layer]
	for key, pin in pairs(pool) do
		if pin.gen ~= poolGen then pool[key] = nil end
	end
end

-- One pin per entity spawn cluster and layer: a mob two objectives need
-- (killed for one quest, looted for another) carries both refs under the
-- glyph of the higher-ranked style (STYLE[*].rank).
local function newPin(layer, key, kind, style, map, f, x, y, header, byKey, radius)
	local s = STYLE[style]
	local area = s.area and radius and radius >= MIN_AREA and radius or nil
	local pin = byKey[key]
	if pin then
		if (s.rank or 0) > (STYLE[pin.style].rank or 0) then pin.style, pin.icon = style, s.icon end
		if area and area > (pin.radius or 0) then pin.radius = area end
		return pin
	end
	local pool = pools[layer]
	pin = pool[key]
	if pin then
		local refs = pin.refs
		for i = #refs, 1, -1 do refs[i] = nil end
		pin.kind, pin.header, pin.style, pin.icon, pin.radius = kind, header, style, s.icon, area
	else
		pin = {
			map = map, x = x, y = y, f = f,
			icon = s.icon, size = s.size, color = color(s.color), priority = s.priority,
			kind = kind, header = header, refs = {}, layer = layer, style = style, radius = area,
		}
		local C = ns.Compat
		if C and C.MapToWorld then pin.c, pin.wx, pin.wy = C.MapToWorld(map, x, y, f) end
		pin.tooltip = function(tt) addTooltipLines(tt, pin) end
		pool[key] = pin
	end
	pin.gen = poolGen
	byKey[key] = pin
	local byMap = markers[layer]
	local list = byMap[map]
	if not list then
		list = {}
		byMap[map] = list
	end
	list[#list + 1] = pin
	return pin
end

local function addRef(pin, ref)
	local refs = pin.refs
	for i = 1, #refs do
		if refs[i] == ref then return end
	end
	refs[#refs + 1] = ref
end

-- EachSpawn callback context: one table reused for the whole rebuild.
local spawnCtx = {}
local function onSpawn(c, _, map, f, x, y, r, ci)
	local key = c.prefix .. map .. ":" .. ci
	local pin = newPin(c.layer, key, c.kind, c.style, map, f, x, y, c.header, c.byKey, r)
	addRef(pin, c.ref)
end

local function spawnPins(layer, kind, style, entity, ref, byKey)
	local c = spawnCtx
	c.layer, c.kind, c.style, c.ref, c.byKey = layer, kind, style, ref, byKey
	c.prefix = layer .. ":" .. entity .. ":"
	c.header = Q.EntityName(entity)
	Q.EachSpawn(entity, onSpawn, c)
end

---------------------------------------------------------------------------
-- Guide focus: the active Polestar guide step's quests stand out
---------------------------------------------------------------------------

local guideQuests, nextGuideQuests = {}, {}
local guideRunning = false

-- Reads the active guide's current step; true when the set changed.
local function readGuide()
	local set = nextGuideQuests
	for k in pairs(set) do set[k] = nil end
	local E = ns.Engine
	local guide = E and E.GetGuide and E.GetGuide()
	local i = guide and E.GetStepIndex()
	local step = i and type(guide.steps) == "table" and guide.steps[i]
	local runningNow = type(step) == "table"
	if runningNow and type(step.goals) == "table" then
		for g = 1, #step.goals do
			local q = step.goals[g].quest
			if type(q) == "number" then set[q] = true end
		end
	end
	local changed = runningNow ~= guideRunning
	if not changed then
		for q in pairs(set) do
			if not guideQuests[q] then changed = true break end
		end
		for q in pairs(guideQuests) do
			if not set[q] then changed = true break end
		end
	end
	guideRunning = runningNow
	guideQuests, nextGuideQuests = set, guideQuests
	return changed
end

function Q.IsGuideQuest(q) return guideQuests[q] == true end

local function refQuest(ref)
	if type(ref) == "number" then return ref end
	return ref.q
end

-- "focus" (a quest of the guide step), "dim" or nil for a pin. highlight and
-- dim are qol.guideHighlight and qol.guideDim (read once per publish).
local function focusWith(pin, highlight, dim)
	if not (guideRunning and highlight) then return nil end
	local refs = pin.refs
	for i = 1, #refs do
		if guideQuests[refQuest(refs[i])] then return "focus" end
	end
	if dim then return "dim" end
	return nil
end

local function focusOf(pin)
	return focusWith(pin, ns.Get("qol.guideHighlight"), ns.Get("qol.guideDim"))
end
Q.FocusOf = focusOf

local function stylePin(pin, areas, highlight, dim)
	local s = STYLE[pin.style]
	local focus = focusWith(pin, highlight, dim)
	local k = focus == "focus" and FOCUS_SCALE or 1
	pin.focus = focus
	pin.icon, pin.backdrop = s.icon, true
	pin.size, pin.minimapSize = s.size * k, s.mini * k
	pin.priority = s.priority + (focus == "focus" and FOCUS_PRIORITY or 0)
	pin.ring = focus == "focus" and color("accent") or nil
	pin.color = focus == "dim" and dimColor(s.color) or color(s.color)
	pin.area = areas and pin.radius or nil
end


local function clearMarkers(layer)
	local byMap = markers[layer]
	for k in pairs(byMap) do byMap[k] = nil end
end

local function objectivePins(e, byKey)
	local r = e.rec
	if not r then return end
	if e.ready then
		for _, ref in Each(r[F.FINISH]) do spawnPins(LAYER_TURNIN, "turnin", "turnin", ref, e, byKey) end
		return
	end
	local ev = r[F.EVENTS]
	for i = 1, #e.objs do
		local o = e.objs[i]
		if not o.done then
			if o.kind == KIND_KILL then
				spawnPins(LAYER_OBJECTIVES, "objective", "kill", o.id, o, byKey)
			elseif o.kind == KIND_OBJECT then
				spawnPins(LAYER_OBJECTIVES, "objective", "interact", -o.id, o, byKey)
			elseif o.kind == KIND_ITEM then
				local ir = Q.ItemRecord(o.id)
				if ir then
					local nd = ir[2] or 0
					for k = 1, nd do spawnPins(LAYER_OBJECTIVES, "objective", "collect", ir[1 + 2 * k], o, byKey) end
					local j = 3 + 2 * nd
					local no = ir[j] or 0
					for k = 1, no do spawnPins(LAYER_OBJECTIVES, "objective", "collect", -ir[j + 2 * k - 1], o, byKey) end
					for k = j + 2 * no + 1, #ir do spawnPins(LAYER_OBJECTIVES, "objective", "vendor", ir[k], o, byKey) end
				end
			elseif o.kind == KIND_EVENT and ev and o.id and o.id > 0 then
				local k = (o.id - 1) * 4
				local map = ev[k + 1]
				local pin = newPin(LAYER_OBJECTIVES, "event:" .. e.q .. ":" .. o.id, "objective", "event", map,
					ev[k + 2] == 0 and "e" or nil, ev[k + 3], ev[k + 4], e.title, byKey)
				addRef(pin, o)
			end
		end
	end
end

-- Quests in ID order, so the pins (and the refs a shared pin lists) come
-- out in the same order whatever order pairs() walks the log in: overlapping
-- markers stack the same way in every session.
local rebuildIDs = {}
local function rebuildObjectiveMarkers()
	stats.rebuilds = stats.rebuilds + 1
	poolGen = poolGen + 1
	clearMarkers(LAYER_OBJECTIVES)
	clearMarkers(LAYER_TURNIN)
	local byKey = {}
	local n = 0
	for q in pairs(entries) do
		n = n + 1
		rebuildIDs[n] = q
	end
	for i = #rebuildIDs, n + 1, -1 do rebuildIDs[i] = nil end
	table.sort(rebuildIDs)
	for i = 1, n do objectivePins(entries[rebuildIDs[i]], byKey) end
	prune(LAYER_OBJECTIVES)
	prune(LAYER_TURNIN)
end

---------------------------------------------------------------------------
-- Available quests
---------------------------------------------------------------------------

-- True while quest q's turn-in still bridges the client's lag; drops the
-- mark once the client lists the quest (`listed`) or the window has passed.
local function bridged(q, listed)
	local t = turnedIn[q]
	if not t then return false end
	if listed or GetTime() >= t then
		turnedIn[q] = nil
		return false
	end
	return true
end

local function isDone(q)
	if haveCompletedSet then return completed[q] == true end
	if ns.Compat.IsQuestCompleted(q) then
		turnedIn[q] = nil
		return true
	end
	return bridged(q, false)
end
-- After a log scan (always first in a flush) `entries` holds every quest in
-- the log, collapsed headers included.
local function isOn(q)
	return entries[q] ~= nil
end
local function skillRank(line)
	if not (ns.Compat.Supports and ns.Compat.Supports("skill")) then return nil end
	return ns.Compat.GetSkillRank(line) or 0
end
local checkOpts = { lowLevel = false, skillRank = skillRank, levelAbove = nil }

-- Settings that filter available quests: grey ones and the level window.
function Q.RefreshCheckOptions()
	checkOpts.lowLevel = ns.Get("qol.lowLevelQuests") and true or false
	local window = tonumber(ns.Get("qol.questLevelWindow"))
	checkOpts.levelAbove = (window and window < Q.LEVEL_WINDOW_ANY) and window or nil
	return checkOpts
end

local function hasGiver(r)
	for _, ref in Each(r[F.START]) do
		if Q.HasSpawns(ref) then return true end
	end
	return false
end

-- Candidates, and for each quest the candidates whose availability reads its
-- done or in-log state (QuestDB.EachAvailabilityRef), so a turn-in or accept
-- rechecks only the quests it can affect.
local dependents = {} -- questID -> { candidate, ... }
local skillCandidates = {} -- candidates that need a profession skill
local fullAvailable = true -- the next scan rechecks every candidate
local lastCompleted = {} -- the completed set at the last scan (swapped with `completed`)
local lastOn = {} -- quests in the log at the last scan

local function buildCandidates()
	candidates, dependents, skillCandidates = {}, {}, {}
	for q, r in pairs(Q._data.quests) do
		if Q.IsEligible(r, ctx) and hasGiver(r) then candidates[#candidates + 1] = q end
	end
	table.sort(candidates)
	for i = 1, #candidates do
		local q = candidates[i]
		local needsSkill = Q.EachAvailabilityRef(q, function(ref)
			local list = dependents[ref]
			if not list then
				list = {}
				dependents[ref] = list
			end
			if list[#list] ~= q then list[#list + 1] = q end
		end)
		if needsSkill then skillCandidates[#skillCandidates + 1] = q end
	end
	fullAvailable = true
end

-- Rechecks one candidate; true when its availability changed.
local function recheck(q)
	stats.availableChecks = stats.availableChecks + 1
	local ok = Q.CheckAvailable(q, ctx, isDone, isOn, checkOpts)
	if ok then
		if not available[q] then
			available[q] = true
			availableCount = availableCount + 1
			return true
		end
	elseif available[q] then
		available[q] = nil
		availableCount = availableCount - 1
		return true
	end
	return false
end

-- Recomputes the available set; true when it changed. A full pass after a
-- level, skill or filter change (or without the bulk completed-quest call);
-- otherwise only the dependents of quests whose done or in-log state moved
-- since the last scan.
local function scanAvailable()
	stats.availableScans = stats.availableScans + 1
	local changed = false
	if not candidates then
		buildCandidates()
		-- Only candidates are ever available: start from nothing.
		if next(available) then
			for q in pairs(available) do available[q] = nil end
			changed = true
		end
		availableCount = 0
	end
	local prev = completed
	completed, lastCompleted = lastCompleted, prev
	local hadSet = haveCompletedSet
	haveCompletedSet = client.CompletedSet(completed)
	if haveCompletedSet then
		for q in pairs(turnedIn) do
			if bridged(q, completed[q]) then completed[q] = true end
		end
	end
	Q.RefreshCheckOptions()
	if fullAvailable or not (haveCompletedSet and hadSet) then
		for i = 1, #candidates do
			if recheck(candidates[i]) then changed = true end
		end
	else
		local touched = {}
		for q in pairs(completed) do
			if not prev[q] then touched[q] = true end
		end
		for q in pairs(prev) do
			if not completed[q] then touched[q] = true end
		end
		for q in pairs(entries) do
			if not lastOn[q] then touched[q] = true end
		end
		for q in pairs(lastOn) do
			if not entries[q] then touched[q] = true end
		end
		for q in pairs(touched) do
			local list = dependents[q]
			if list then
				for i = 1, #list do
					if recheck(list[i]) then changed = true end
				end
			end
		end
		for i = 1, #skillCandidates do
			if recheck(skillCandidates[i]) then changed = true end
		end
	end
	for q in pairs(lastOn) do lastOn[q] = nil end
	for q in pairs(entries) do lastOn[q] = true end
	fullAvailable = false
	return changed
end

local function rebuildAvailableMarkers()
	poolGen = poolGen + 1
	clearMarkers(LAYER_AVAILABLE)
	local byKey = {}
	for i = 1, #candidates do
		local q = candidates[i]
		if available[q] then
			for _, ref in Each(Q.QuestRecord(q)[F.START]) do spawnPins(LAYER_AVAILABLE, "available", "available", ref, q, byKey) end
		end
	end
	prune(LAYER_AVAILABLE)
end

-- Sorted IDs of the quests this character can take now (needs a flush).
function Q.GetAvailableQuests()
	local out = {}
	if candidates then
		for i = 1, #candidates do
			if available[candidates[i]] then out[#out + 1] = candidates[i] end
		end
	end
	return out
end

function Q.IsAvailable(q) return available[q] == true end

-- Why a quest is or is not available to this character right now.
function Q.WhyUnavailable(q)
	local ok, reason = Q.CheckAvailable(q, ctx, isDone, isOn, checkOpts)
	return ok and nil or reason
end

---------------------------------------------------------------------------
-- Publishing to Polestar.Pins
---------------------------------------------------------------------------

-- World map: each layer's own toggle. Minimap: qol.minimapObjectives for the
-- objective layer; available quests and turn-ins also need their own toggle.
local function layerOpts(layer)
	local mm = ns.Get("qol.minimapObjectives") and true or false
	local world
	if layer == LAYER_AVAILABLE then
		world = ns.Get("qol.availableQuests") and true or false
		return world, mm and world
	elseif layer == LAYER_TURNIN then
		world = ns.Get("qol.turnInMarkers") and true or false
		return world, mm and world
	end
	return ns.Get("qol.mapObjectives") and true or false, mm
end

local function flatten(layer)
	local out = {}
	local byMap = markers[layer]
	local maps = {}
	for map in pairs(byMap) do maps[#maps + 1] = map end
	table.sort(maps)
	local areas = layer == LAYER_OBJECTIVES and ns.Get("qol.objectiveAreas") and true or false
	local highlight, dim = ns.Get("qol.guideHighlight"), ns.Get("qol.guideDim")
	for i = 1, #maps do
		local list = byMap[maps[i]]
		for k = 1, #list do
			local pin = list[k]
			stylePin(pin, areas, highlight, dim)
			out[#out + 1] = pin
		end
	end
	flat[layer] = out
	return out
end

local published = {} -- layer -> true while Pins holds it

local function publish(layer)
	local Pins = ns.Pins
	if not (Pins and Pins.SetLayer) then return end
	local world, minimap = layerOpts(layer)
	local pins = flatten(layer)
	if not running or (not world and not minimap) or #pins == 0 then
		if published[layer] then
			Pins.ClearLayer(layer)
			published[layer] = nil
			stats.publishes = stats.publishes + 1
		end
		return
	end
	Pins.SetLayer(layer, pins, { world = world, minimap = minimap, edge = false, scale = 1 })
	published[layer] = true
	stats.publishes = stats.publishes + 1
end

-- Pins on one map for a layer ("objectives" | "turnin" | "available"), or all.
function Q.GetMarkers(map, which)
	local out = {}
	for name, layer in pairs(Q.LAYERS) do
		if not which or which == name then
			local list = markers[layer][map]
			if list then
				for i = 1, #list do out[#out + 1] = list[i] end
			end
		end
	end
	return out
end

---------------------------------------------------------------------------
-- Flush
---------------------------------------------------------------------------

local function flush()
	pending = false
	if not running then return end
	local logChanged, progressChanged, availChanged = false, false, false
	if dirtyLog then
		dirtyLog = false
		logChanged, progressChanged = scanLog()
	end
	if logChanged then
		stats.changes = stats.changes + 1
		rebuildIndex()
		rebuildObjectiveMarkers()
		publish(LAYER_OBJECTIVES)
		publish(LAYER_TURNIN)
		ns.Fire("QUESTDB_UPDATED")
	elseif progressChanged then
		-- Counts only: markers and indexes stay; tooltips and nameplates re-read.
		stats.changes = stats.changes + 1
		ns.Fire("QUESTDB_UPDATED")
	end
	if dirtyAvailable then
		dirtyAvailable = false
		if ns.Get("qol.availableQuests") then
			availChanged = scanAvailable()
		else
			-- Off: nothing is tracked, so the next scan starts over.
			fullAvailable = true
			if availableCount > 0 or next(available) then
				for k in pairs(available) do available[k] = nil end
				availableCount = 0
				availChanged = true
			end
		end
		if availChanged then
			rebuildAvailableMarkers()
			publish(LAYER_AVAILABLE)
		end
	end
	if dirtyPublish then
		dirtyPublish = false
		if not logChanged then
			publish(LAYER_OBJECTIVES)
			publish(LAYER_TURNIN)
		end
		if not availChanged then publish(LAYER_AVAILABLE) end
	end
end

local function schedule()
	if pending or not running then return end
	pending = true
	C_Timer.After(THROTTLE, flush)
end

local function onLogEvent(event, arg)
	if event == "UNIT_QUEST_LOG_CHANGED" and arg ~= "player" then return end
	if event == "QUEST_ACCEPTED" and type(arg) == "number" then
		hidden[arg] = true
		turnedIn[arg] = nil
	elseif event == "QUEST_TURNED_IN" and type(arg) == "number" then
		turnedIn[arg] = GetTime() + TURNIN_BRIDGE
		-- Recheck once the window has passed, in case the client never lists it.
		C_Timer.After(TURNIN_BRIDGE, function()
			if not running then return end
			dirtyAvailable = true
			schedule()
		end)
	end
	dirtyLog = true
	if event == "QUEST_TURNED_IN" or event == "QUEST_ACCEPTED" or event == "QUEST_REMOVED" then dirtyAvailable = true end
	schedule()
end

local function onLevel(_, level)
	Q.PlayerContext(nil, ctx)
	if type(level) == "number" and level > ctx.level then ctx.level = level end
	dirtyAvailable, fullAvailable = true, true
	schedule()
end

local function onSkill()
	dirtyAvailable, fullAvailable = true, true
	schedule()
end

local LOG_EVENTS = { "QUEST_LOG_UPDATE", "UNIT_QUEST_LOG_CHANGED", "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_TURNED_IN", "QUEST_WATCH_UPDATE" }

function Q.Start()
	if running or not Q.IsEnabled() then return false end
	running = true
	Q.PlayerContext(nil, ctx)
	candidates = nil
	sweepLog()
	for i = 1, #LOG_EVENTS do ns.RegisterEvent(LOG_EVENTS[i], onLogEvent) end
	ns.RegisterEvent("PLAYER_LEVEL_UP", onLevel)
	ns.RegisterEvent("SKILL_LINES_CHANGED", onSkill)
	dirtyLog, dirtyAvailable = true, true
	schedule()
	ns.Fire("QUESTDB_STARTED")
	return true
end

function Q.Stop()
	if not running then return end
	running = false
	for i = 1, #LOG_EVENTS do ns.UnregisterEvent(LOG_EVENTS[i], onLogEvent) end
	ns.UnregisterEvent("PLAYER_LEVEL_UP", onLevel)
	ns.UnregisterEvent("SKILL_LINES_CHANGED", onSkill)
	for q in pairs(entries) do entries[q] = nil end
	for q in pairs(available) do available[q] = nil end
	availableCount = 0
	candidates = nil
	for q in pairs(hidden) do hidden[q] = nil end
	for q in pairs(turnedIn) do turnedIn[q] = nil end
	rebuildIndex()
	for layer in pairs(markers) do
		clearMarkers(layer)
		local pool = pools[layer]
		for key in pairs(pool) do pool[key] = nil end
		publish(layer)
	end
	ns.Fire("QUESTDB_UPDATED")
end

function Q.IsRunning() return running end

-- Run a pending update now (tests, /polestar commands).
function Q.Flush()
	if pending or dirtyLog or dirtyAvailable or dirtyPublish then flush() end
end

---------------------------------------------------------------------------
-- Settings and lifecycle
---------------------------------------------------------------------------

-- Loads the pack and starts when a quest feature wants it, stops when none
-- does. A load refused in combat is retried once combat ends.
local retryAfterCombat = false
local function enable()
	if not Q.IsWanted() then
		Q.Stop()
		return
	end
	local ok, reason = Q.Load()
	if ok then
		Q.Start()
	elseif reason == "combat" and not retryAfterCombat then
		retryAfterCombat = true
		local function again()
			ns.UnregisterEvent("PLAYER_REGEN_ENABLED", again)
			retryAfterCombat = false
			enable()
		end
		ns.RegisterEvent("PLAYER_REGEN_ENABLED", again)
	end
end

local function onGuide()
	if not running then return end
	if readGuide() then
		dirtyPublish = true
		schedule()
	end
end

-- Settings that need the database (Q.IsWanted), filter available quests,
-- or only change how layers are published.
local WANT = { ["qol.questDB"] = true, ["qol.mapObjectives"] = true, ["qol.minimapObjectives"] = true, ["qol.availableQuests"] = true,
	["qol.turnInMarkers"] = true, ["qol.questTooltips"] = true, ["qol.nameplateIcons"] = true }
local FILTER = { ["qol.availableQuests"] = true, ["qol.lowLevelQuests"] = true, ["qol.questLevelWindow"] = true }
local LOOK = { ["qol.mapObjectives"] = true, ["qol.minimapObjectives"] = true, ["qol.availableQuests"] = true,
	["qol.turnInMarkers"] = true, ["qol.objectiveAreas"] = true, ["qol.guideHighlight"] = true, ["qol.guideDim"] = true }

ns.On("SETTING_CHANGED", function(path)
	if type(path) ~= "string" then return end
	local all = path == "" or path == "qol"
	if not (all or path:sub(1, 4) == "qol.") then return end
	if all or WANT[path] then enable() end
	if not running then return end
	if all or FILTER[path] then dirtyAvailable, fullAvailable = true, true end
	if all or LOOK[path] then
		readGuide()
		dirtyPublish = true
	end
	schedule()
end)

ns.On("STEP_CHANGED", onGuide)
ns.On("GUIDE_CHANGED", onGuide)
ns.On("QUESTDB_STARTED", onGuide)

-- The names pack arrived late (refused in combat, Core/Names.lua): the
-- objectives were named in English, so read their names again, match the
-- client's lines anew and rebuild what is keyed by name.
ns.On("NAMES_LOADED", function()
	for _, e in pairs(entries) do
		for i = 1, #e.objs do
			local o = e.objs[i]
			o.name = entityName(o.kind, o.id)
		end
		e.lines = nil
	end
	if not running then return end
	rebuildIndex()
	rebuildObjectiveMarkers()
	publish(LAYER_OBJECTIVES)
	dirtyLog = true
	schedule()
end)

local function onTheme()
	for k in pairs(colors) do colors[k] = nil end
	for k in pairs(dimmed) do dimmed[k] = nil end
	if not running then return end
	-- Pins keep a reference to their colour table: restyle on the next publish.
	dirtyPublish = true
	schedule()
end

ns.OnInit(function()
	if ns.Theme and ns.Theme.OnChanged then ns.Theme.OnChanged(onTheme) end
end)

ns.OnLogin(enable)
