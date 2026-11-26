-- Polestar Free mode (#3701): the character's own quest log as a guide. The
-- player picks up their own quests; Free mode lists them, the nearest (or the
-- most XP a minute) first, and the arrow leads to it. A guide Lookup builds
-- (planner kind "free", Lookup.RegisterPlanner), in a tab of its own, so the
-- Engine runs it as it runs every guide: the arrow, the target button, While
-- you're here, auto accept and hand-in, party, Make room. Contract:
-- docs/ARCHITECTURE.md, "Free mode".
--
-- This folder loads on demand (Data.Pack, the first time Free mode starts or
-- a saved Free mode tab comes back after /reload); Polestar's door
-- (Polestar/Lookup/Free.lua) holds its settings, its command, the planner
-- kind and what the window asks before it is loaded, and these take its
-- functions' place as it loads:
--
--   Free.Build() -> guide def | nil, reason   -- the planner's build
--   Free.Start() -> true | nil, reason  -- open it in a tab and make it active
--   Free.Stop()                         -- close its tab; the last guide of a pack
--                                          the player had in front (else none) is
--                                          active again (the door's Free.IsBackTarget)
--   Free.Toggle() ; Free.Command(arg)   -- /polestar free [on | off | back | balanced | nearest | xp]
--   Free.ReturnTitle() -> title | nil   -- the guide Stop hands back to
--   Free.Pin(questID, on)               -- that quest first, whatever the rule
--   Free.LeaveOut(questID, on)          -- not listed (on = false: back)
--   Free.Pinned() -> questID | nil ; Free.LeftOut() -> { questID, ... }
--   Free.Steps(from?) -> steps, info    -- what a plan holds now (the planner's
--                                          build; info.rows: the quests in order,
--                                          each { quest, title, travel, xp, tier,
--                                          score, place }; info.hint; info.why)
--   Free.Why() -> text | nil            -- why the last plan's first quest is first
--   Free.Route() -> rows, info          -- the quests in Free mode's order: the
--                                          last plan's while it is on, else the
--                                          plan it would make now (kept until what
--                                          a plan reads moves); info.why
--   Free.Reasons(rows, i) -> text | nil -- why rows[i] comes where it does
--   Free.Plan(force?)                   -- plan again now if anything it reads moved
--   Free.MenuItems() -> { item, ... }   -- the guide window menu's rows
--   Free.RowItems(questID) -> { item, ... } | nil  -- a quest line's right-click rows
--   Free.BringBack()                    -- every quest left out is listed again
--   Free.Quests() -> { row, ... }       -- every quest in the log for the quests
--                                          page (Page.lua): { quest, title, level,
--                                          zone, zoneName, ready, group, out, pinned }
--   Free.Zones() -> { { zone, name, quests }, ... }  -- the zones of those in the loop
--   Free.LeaveOutZone(zone) ; Free.LeaveOutGroup()   -- the quick actions
--   Free.Page                           -- the quests page (Page.lua)
--   Fires FREE_CHANGED when a pin or a left-out quest changes.

local ns = Polestar

local Lookup, L = ns.Lookup, ns.L
local Free = ns.Free

local type, pairs, ipairs, tonumber, tostring = type, pairs, ipairs, tonumber, tostring
local format, floor, min, max, sort, concat = string.format, math.floor, math.min, math.max, table.sort, table.concat

local KIND, ID = "free", "log"
local GID = Free.GUIDE

-- The pick rule is Order.lua's (ns.FreeOrder): its numbers, every order's.
local Order = ns.FreeOrder
local RUN = Order.RUN
local FAR_SECONDS = 300 -- the nearest quest further than this: a zone hint first
local LOW_CHANCE = 20 -- a collect whose best source gives it under this percent says so
local HARD_ABOVE = 3 -- a quest this many levels above the player ranks after the rest
local HINT_ABOVE = 3 -- a zone hint counts quests up to this many levels above the player
local HUB_YARDS = 150 -- givers this close to one another make one hub
local HINT_SLICE = 300 -- Codex quests judged per frame while a hint is worked out
local PLAN_DELAY = 0.3 -- seconds: a burst of quest-log events makes one plan

local function Codex() return ns.Codex end
local function Engine() return ns.Engine end

---------------------------------------------------------------------------
-- Saved: CharState().free = { pin = questID, out = { [questID] = true },
-- from = guideId (the guide Stop goes back to) }, the door's Free.State
---------------------------------------------------------------------------

local saved = Free.State

-- The order (setting free.pick, the door's Free.Pick): "balanced" | "near" | "xp".
local function pick()
	return Free.Pick()
end

---------------------------------------------------------------------------
-- The quest log
---------------------------------------------------------------------------

-- The quests held: the log as listed, plus those listed before whose header
-- is folded now (the client lists no quest under a folded header), while the
-- character is on them.
local held = {}
local logRead = false -- a QUEST_LOG_UPDATE came: what the log says is so
local function heldQuests()
	local K = ns.Compat
	for _, q in ipairs(K.GetLogQuests()) do held[q] = true end
	local out = {}
	for q in pairs(held) do
		if K.IsOnQuest(q) then out[#out + 1] = q else held[q] = nil end
	end
	sort(out)
	return out
end

-- The objective line of the quest log a goal stands for: by the name it
-- works on when exactly one line names it (the data and the client may not
-- list a quest's objectives alike), else by its place among the data's.
local function goalName(g)
	return g.target or g.itemName or g.objName or g.npcName
end
local function lineOf(g, lines)
	if not lines then return nil end
	local name = goalName(g)
	if type(name) == "string" and name ~= "" then
		local hit, label = nil, ns.Compat.ObjectiveLabel
		for i, line in ipairs(lines) do
			local l = label(line.text)
			if l ~= "" and (l == name or l:find(name, 1, true)) then
				if hit then
					hit = nil
					break
				end
				hit = i
			end
		end
		if hit then return lines[hit] end
	end
	return g.oi and lines[g.oi] or nil
end

local WORK = { kill = true, collect = true, interact = true, talk = true, use = true, complete = true }

-- Whether goal g of a held quest is still to do: a hand-in once the quest is
-- ready, the rest until their line is finished.
local function goalOpen(g, ready, lines)
	if g.t == "turnin" then return ready end
	if not WORK[g.t] or ready then return false end
	local line = lineOf(g, lines)
	if line then return not line.finished end
	return true
end

---------------------------------------------------------------------------
-- Places and travel
---------------------------------------------------------------------------

local function located(p)
	return type(p) == "table" and type(p.map) == "number" and type(p.x) == "number" and type(p.y) == "number"
end

-- A goal's places: its point and its spawn areas (Lookup's spots, on its map).
local function places(g, out)
	if located(g) then out[#out + 1] = g end
	for _, s in ipairs(g.spots or {}) do
		if not s.alt and s.x and s.y then out[#out + 1] = { map = g.map, x = s.x, y = s.y, f = g.f } end
	end
	return out
end

local CROSS = ns.TRAVEL_CROSS_CONTINENT or 3600

-- The straight line's seconds between two places, as ns.DirectTravelCost
-- (running time on one continent, CROSS across), each place's world position
-- worked out once a plan (Free.Steps starts a new cache): the Balanced order
-- asks for thousands of pairs, and a live-frame map position is a client call.
local worldAt = {}
local function world(p)
	local w = worldAt[p]
	if w == nil then
		local c, x, y = ns.Compat.MapToWorld(p.map, p.x, p.y, p.f)
		w = c and { c, x, y } or false
		worldAt[p] = w
	end
	return w
end
local function direct(a, b)
	local wa, wb = world(a), world(b)
	if not (wa and wb) then return nil end
	if wa[1] ~= wb[1] then return CROSS end
	local dx, dy = wb[2] - wa[2], wb[3] - wa[3]
	return (dx * dx + dy * dy) ^ 0.5 / RUN
end

-- The walking planner's seconds from the player (Nav.EstimateTravel, budgeted:
-- once this frame's planning time is spent, or with no answer, the straight
-- line's).
local function walk(from, to)
	local nav = ns.Nav
	if nav and nav.EstimateTravel then
		local ok, s = pcall(nav.EstimateTravel, from, to, true)
		if ok and type(s) == "number" then return s end
	end
	return direct(from, to)
end

---------------------------------------------------------------------------
-- A quest's step
---------------------------------------------------------------------------

local function percent(n)
	return format("%.3g%%", n)
end

-- The best chance a placed source gives item `id` (those that need no group
-- first, as Lookup places the collect), nil when no chance is known.
local function dropChance(id)
	local C = Codex()
	local item = C.Item(id)
	local best, group
	for _, src in ipairs(item and item.sources or {}) do
		local rec
		if src.type == "drop" and src.npc then
			rec = C.Npc(src.npc)
		elseif src.type == "object" and src.object then
			rec = C.Object(src.object)
		end
		if rec and type(src.chance) == "number" and rec.spawns and #rec.spawns > 0 then
			if src.type == "drop" and (rec.elite or rec.boss) then
				group = max(group or 0, src.chance)
			else
				best = max(best or 0, src.chance)
			end
		end
	end
	return best or group
end

local function questXP(rec, qlvl, level)
	if not (rec and type(rec.xp) == "number" and rec.xp > 0) then return nil end
	local share = ns.Levels and ns.Levels.Share
	return floor(rec.xp * (share and share(level, qlvl) or 1) + 0.5)
end

-- One held quest -> its row { quest, title, step, ready, xp, effort, qlvl,
-- hard, started, place, travel, open, mobs, ender } (Order.lua's row): its
-- step is Lookup's quest step (the giver's accept left out: it is held) with
-- the open goals' places measured from `from`.
local function questRow(q, from, p, details)
	local C, K = Codex(), ns.Compat
	local rec = C and C.Quest(q)
	local title = K.GetQuestTitle(q) or (rec and rec.title) or ("#" .. q)
	local ready = K.IsQuestReadyForTurnIn(q) and true or false
	local lines = not ready and K.GetQuestObjectives(q) or nil
	local qlvl = K.GetQuestLevel(q) or (rec and rec.level)
	local row = { quest = q, title = title, ready = ready, qlvl = qlvl, effort = Order.Effort(lines, ready, p.level) }
	row.xp = questXP(rec, qlvl, p.level)
	row.hard = (qlvl and qlvl >= p.level + HARD_ABOVE) and true or false
	for _, line in ipairs(lines or {}) do
		if line.finished or (line.numFulfilled or 0) > 0 then row.started = true end
	end
	local goals = {}
	local built = rec and Lookup.QuestStep(rec, from, { direct = true })
	for _, g in ipairs(built and built.goals or {}) do
		if g.t ~= "accept" and g.t ~= "note" then
			g.title = title
			goals[#goals + 1] = g
		end
	end
	local hasEnd = false
	for _, g in ipairs(goals) do
		if g.t == "turnin" then hasEnd = true end
		if g.group and not ready then row.hard = true end
		if details and g.t == "collect" and g.item then
			local chance = dropChance(g.item)
			if chance and chance > 0 and chance < LOW_CHANCE then
				local text = format(L["Low drop rate: %s"], percent(chance))
				g.note = g.note and (g.note .. " " .. text) or text
			end
		end
		if details and g.t == "turnin" and row.xp then g.rewards = { xp = row.xp } end
	end
	if not hasEnd then
		-- No place for its hand-in (or none of it in the data): the quest's
		-- own line, done once it is ready, so the step still reads right.
		goals[#goals + 1] = { t = "complete", quest = q, title = title }
	end
	row.step = { title = title, goals = goals, note = built and built.note or nil }
	-- Its next place: the hand-in when ready, else the open objective the
	-- player reaches soonest (straight lines among them, the walk to the one).
	-- Balanced reads the rest too: every open place, the mobs the open lines
	-- are had from, and the NPC a finished quest goes to.
	if from then
		local best, bestD, open, mobs = nil, nil, {}, {}
		for _, g in ipairs(goals) do
			if goalOpen(g, ready, lines) then
				for _, pt in ipairs(places(g, {})) do
					open[#open + 1] = pt
					local d = direct(from, pt)
					if d and (not bestD or d < bestD) then best, bestD = pt, d end
				end
				if g.t == "kill" and g.npc then mobs["n" .. g.npc] = true end
				if g.t == "collect" and g.fromKind == "npc" then
					if g.fromId then mobs["n" .. g.fromId] = true end
					if g.fromAlsoId then mobs["n" .. g.fromAlsoId] = true end
				end
				if g.t == "turnin" then
					row.ender = (g.npc and "n" .. g.npc) or (g.object and "o" .. g.object) or nil
					row.enderName = g.npcName or g.objName
				end
			end
		end
		row.open, row.mobs = open, mobs
		if best then row.place, row.travel = best, walk(from, best) or bestD end
	end
	return row
end

---------------------------------------------------------------------------
-- Why a quest comes where it does (Order.Why over it and those after it),
-- as the step's line and the page's
---------------------------------------------------------------------------

local WHY = {
	pinned = function() return L["pinned"] end,
	stop = function(n) return format(L["%d hand-ins at one stop"], n) end,
	ready = function() return L["ready to hand in"] end,
	shared = function(n) return format(L["%d of your quests here"], n) end,
	way = function() return L["hand-in on the way"] end,
	started = function() return L["started"] end,
	nearest = function() return L["nearest"] end,
	xp = function() return L["most XP for the trip"] end,
	held = function() return L["kept while you walk"] end,
}

-- rows[i]'s reasons against the quests after it, strongest first:
-- { { key, text }, ... } (Order.Why's keys: "ready", "xp", ...).
local function reasonList(rows, i, rule, pin)
	local rest = {}
	for k = i, #rows do rest[#rest + 1] = rows[k] end
	local out = {}
	for _, e in ipairs(Order.Why(rest, rule, pin)) do out[#out + 1] = { key = e.key, text = WHY[e.key](e.n) } end
	return out
end

-- The same as one line: "ready to hand in · most XP for the trip" | nil.
local function reasons(rows, i, rule, pin)
	local parts = {}
	for _, e in ipairs(reasonList(rows, i, rule, pin)) do parts[#parts + 1] = e.text end
	if #parts == 0 then return nil end
	return concat(parts, " \194\183 ")
end

local function whyText(rows, rule, pin)
	local r = reasons(rows, 1, rule, pin)
	return r and format(L["Why %s first: %s"], rows[1].title, r) or nil
end

function Free.Reasons(rows, i)
	if not (rows and rows[i]) then return nil end
	return reasons(rows, i, pick(), saved().pin)
end

function Free.ReasonList(rows, i)
	if not (rows and rows[i]) then return {} end
	return reasonList(rows, i, pick(), saved().pin)
end

---------------------------------------------------------------------------
-- Zone hints: the zone with the most quests this character can take now,
-- worked out over a few frames once per level (Codex quests: its side,
-- race, class, a level from just above grey to HINT_ABOVE above, the
-- prerequisites done, not done or held, a giver with a spawn), and the hub:
-- the giver with the most others within HUB_YARDS.
---------------------------------------------------------------------------

local hint = { level = nil, busy = false, zones = nil }

local function greyLevel(level)
	local Q = ns.QuestDB
	return Q and Q.GreyLevel and Q.GreyLevel(level) or 0
end

local function prereqsDone(q)
	local K = ns.Compat
	for _, id in ipairs(q.pre or {}) do
		if not K.IsQuestCompleted(id) then return false end
	end
	local any = q.preAny or {}
	if #any == 0 then return true end
	for _, id in ipairs(any) do
		if K.IsQuestCompleted(id) then return true end
	end
	return false
end

-- Quest q's giver for the character, at its spawn on the quest's zone (else
-- its first), or nil.
local function giverOf(q, p)
	local C = Codex()
	for _, id in ipairs(q.start and q.start.npc or {}) do
		local npc = C.Npc(id)
		if npc and npc.spawns and #npc.spawns > 0 and Lookup.SideOK(npc.faction, p) then
			local at = npc.spawns[1]
			for _, s in ipairs(npc.spawns) do
				if s.map == q.zone then
					at = s
					break
				end
			end
			if located(at) then return { npc = id, name = npc.name, map = at.map, x = at.x, y = at.y, f = at.f == "e" and "e" or nil } end
		end
	end
	return nil
end

local function takeable(q, p, grey)
	if type(q) ~= "table" or not q.level then return false end
	if q.level <= grey or q.level > p.level + HINT_ABOVE then return false end
	if Lookup.QuestBlock(q, p) then return false end
	local K = ns.Compat
	if K.IsOnQuest(q.id) then return false end
	return prereqsDone(q)
end

-- Starts the scan for the character's level; on its end, plans again.
local function scanHints()
	local C = Codex()
	local p = Lookup.PlayerInfo()
	if hint.busy or hint.level == p.level or not (C and C.IsLoaded()) then return end
	hint.busy = true
	local ids = {}
	C.Each("quest", function(id) ids[#ids + 1] = id end)
	local grey, zones, k = greyLevel(p.level), {}, 1
	local function slice()
		local stop = min(#ids, k + HINT_SLICE - 1)
		for i = k, stop do
			local q = C.Quest(ids[i])
			if takeable(q, p, grey) then
				local giver = giverOf(q, p)
				if giver then
					local z = zones[giver.map]
					if not z then
						z = { map = giver.map, n = 0, givers = {} }
						zones[giver.map] = z
					end
					z.n = z.n + 1
					z.givers[#z.givers + 1] = giver
				end
			end
		end
		k = stop + 1
		if k <= #ids then return ns.After(0, slice) end
		hint.zones, hint.level, hint.busy = zones, p.level, false
		Free.Plan(true)
	end
	-- Never inside the plan that asked: its end plans again.
	ns.After(0, slice)
end

-- The hub of zone z: the giver with the most others within HUB_YARDS, and
-- how many quests stand there.
local function hubOf(z)
	local best, bestN
	for _, a in ipairs(z.givers) do
		local n = 0
		for _, b in ipairs(z.givers) do
			local d = direct(a, b)
			if d and d * RUN <= HUB_YARDS then n = n + 1 end
		end
		if not bestN or n > bestN then best, bestN = a, n end
	end
	return best, bestN
end

-- The hint step for now, or nil: of the zones on the player's continent (any
-- with none there), the one with the most quests for the level for the trip:
-- its count over 1 + the straight walk's minutes / HINT_MINUTES, so a zone
-- of 20 quests a tram ride off loses to one of 10 a field away. None while
-- the player stands at a hub with quests to take: taking them is next.
local HINT_MINUTES = 5
local function hintStep(from)
	local zones = hint.zones
	if not zones then return nil end
	local list, near = {}, false
	for _, z in pairs(zones) do
		local hub, here = hubOf(z)
		if hub then
			local d = from and direct(from, hub)
			if d and d * RUN <= HUB_YARDS then return nil end
			local e = { z = z, hub = hub, here = here, d = d or CROSS }
			e.score = z.n / (1 + min(e.d, CROSS) / 60 / HINT_MINUTES)
			if e.d < CROSS then near = true end
			list[#list + 1] = e
		end
	end
	sort(list, function(a, b)
		if (a.d < CROSS) ~= (b.d < CROSS) then return a.d < CROSS end
		if a.score ~= b.score then return a.score > b.score end
		return a.z.map < b.z.map
	end)
	local best = list[1]
	if not best or (near and best.d >= CROSS) then return nil end
	local z, hub, here, n = best.z, best.hub, best.here, best.z.n
	local note
	if n == 1 then
		note = format(L["1 quest for your level: %s gives it."], hub.name)
	elseif here == n then
		note = format(L["%d quests for your level, all here."], n)
	else
		note = format(L["%d quests for your level, %d of them here."], n, here)
	end
	return {
		title = L["Quests for your level"],
		note = note,
		goals = { { t = "goto", map = hub.map, x = hub.x, y = hub.y, f = hub.f, text = hub.name, r = 30 } },
		hint = z.map,
	}
end

---------------------------------------------------------------------------
-- The guide
---------------------------------------------------------------------------

local lastFirst, lastWhy -- the first quest of the last plan (the hold), and why it is first
local lastRows, lastInfo -- the last plan built: its quests in order (the page's route)

function Free.Steps(from)
	from = from or ns.PlayerPoint()
	worldAt = {}
	local f, p = saved(), Lookup.PlayerInfo()
	local details = ns.Get("free.details") and true or false
	local rows = {}
	for _, q in ipairs(heldQuests()) do
		if not f.out[q] then rows[#rows + 1] = questRow(q, from, p, details) end
	end
	local rule = pick()
	rows = Order.Sort(rows, rule, f.pin, lastFirst, direct)
	local steps, info = {}, { rows = rows, why = whyText(rows, rule, f.pin) }
	local first = rows[1]
	local far = not (first and first.place and first.travel and first.travel <= FAR_SECONDS)
	if far and ns.Get("free.hints") then
		local h = hintStep(from)
		if h then
			steps[1] = h
			info.hint = h.hint
		elseif not hint.zones or hint.level ~= p.level then
			scanHints()
		end
	end
	for i, r in ipairs(rows) do
		if rule == "xp" and r.rate and r.rate > 0 then
			local text = format(L["About %s XP a minute"], ns.Thousands(floor(r.rate + 0.5)))
			r.step.note = r.step.note and (text .. ". " .. r.step.note) or text
		end
		-- The first quest's step says why it is first, one line under its header (Engine view `chosen`).
		if i == 1 then
			local because = reasons(rows, 1, rule, f.pin)
			r.step.chosen = because and format(L["Why first: %s"], because) or nil
		end
		steps[#steps + 1] = r.step
	end
	if #steps == 0 then
		steps[1] = { title = L["Free mode"], goals = { { t = "note", text = L["Pick up quests and Free mode leads you to them."] } } }
	end
	info.first = first and first.quest or nil
	return steps, info
end

-- The planner's build (the door registers the kind and loads this first).
function Free.Build()
	local C = Codex()
	if not (C and C.Load()) then return nil, "missing" end
	local steps, info = Free.Steps()
	lastFirst, lastWhy = info.first, info.why
	lastRows, lastInfo = info.rows, info
	return { title = L["Free mode"], steps = steps, category = "Lookup" }
end

-- Why the last plan's first quest is first: "Why <quest> first: <reasons>",
-- nil with no quest.
function Free.Why()
	return lastWhy
end

local function tabIndex()
	local E = Engine()
	if not (E and E.GetTabs) then return nil end
	local tabs, active = E.GetTabs()
	for i, t in ipairs(tabs) do
		if t.guideId == GID then return i, active, tabs end
	end
	return nil, active, tabs
end

function Free.IsOn()
	return tabIndex() ~= nil
end

-- What a plan reads, as a string: the quests, each one's ready state and
-- finished lines, the pin, those left out, the rule, the level, the map.
local function signature()
	local K, f = ns.Compat, saved()
	local parts = { pick(), tostring(f.pin), tostring(ns.Compat.GetPlayerLevel and K.GetPlayerLevel() or ""),
		tostring((ns.PlayerPoint() or {}).map), ns.Get("free.hints") and "h" or "", ns.Get("free.details") and "d" or "", tostring(hint.level) }
	for _, q in ipairs(heldQuests()) do
		local s = q .. (f.out[q] and "o" or "")
		if K.IsQuestReadyForTurnIn(q) then
			s = s .. "r"
		else
			for _, line in ipairs(K.GetQuestObjectives(q) or {}) do s = s .. (line.finished and "1" or "0") end
		end
		parts[#parts + 1] = s
	end
	return concat(parts, ",")
end

-- The quests in Free mode's order for the page. While it is on, the plan the
-- arrow follows; else the plan Start would make, kept while what a plan
-- reads holds and for PREVIEW_SECONDS (the walk changes its travel times).
local PREVIEW_SECONDS = 10
local preview -- { sig, at, rows, info }
function Free.Route()
	if lastRows and Free.IsOn() then return lastRows, lastInfo end
	local C = Codex()
	if not (C and C.Load()) then return {}, {} end
	local sig, now = signature(), GetTime()
	if preview and preview.sig == sig and now - preview.at < PREVIEW_SECONDS then return preview.rows, preview.info end
	local _, info = Free.Steps()
	preview = { sig = sig, at = now, rows = info.rows, info = info }
	return info.rows, info
end

-- The trip through every finished quest's hand-in, for the page's card: from
-- the player to the nearest NPC that takes one, then the nearest after it
-- (straight lines' running time, as a plan measures them), HANDIN_SECONDS
-- for each quest handed in -> seconds, stops | nil (none ready, or none of
-- their hand-ins placed).
local HANDIN_SECONDS = 6
function Free.HandinTrip()
	local C = Codex()
	if not (C and C.IsLoaded()) then return nil end
	local from, p, K = ns.PlayerPoint(), Lookup.PlayerInfo(), ns.Compat
	if not from then return nil end
	local stops, at = {}, {}
	for _, q in ipairs(heldQuests()) do
		if K.IsQuestReadyForTurnIn(q) then
			local r = questRow(q, from, p, false)
			if r.place then
				local key = r.ender or (tostring(r.place.map) .. ":" .. tostring(r.place.x) .. ":" .. tostring(r.place.y))
				local s = at[key]
				if not s then
					s = { place = r.place, n = 0 }
					at[key] = s
					stops[#stops + 1] = s
				end
				s.n = s.n + 1
			end
		end
	end
	if #stops == 0 then return nil end
	local total, here, left = 0, from, {}
	for i, s in ipairs(stops) do left[i] = s end
	while #left > 0 do
		local bi, bd
		for i, s in ipairs(left) do
			local d = direct(here, s.place) or CROSS
			if not bd or d < bd then bi, bd = i, d end
		end
		local s = table.remove(left, bi)
		total = total + bd + HANDIN_SECONDS * s.n
		here = s.place
	end
	return total, #stops
end

local planned -- the signature of the guide as built last

-- Builds the guide anew and opens it in its tab, at its place, active as it
-- was (Lookup's generated guides reopen rebuilt the same way: placed from
-- the quest log, its first open quest live).
local function rebuild()
	local E = Engine()
	local i, active = tabIndex()
	if not i then return false end
	local def = Lookup.BuildGuide(KIND, ID)
	if not def then return false end
	local ok = ns.RegisterGuide(def)
	if not ok then return false end
	planned = signature()
	local wasActive = i == active
	E.CloseTab(i, true)
	local j = E.OpenTab(GID, wasActive)
	-- MoveTab keeps whichever tab is active where it is.
	if j and j ~= i then E.MoveTab(j, i) end
	return true
end

-- Plans again when what a plan reads moved (force: whatever it reads).
function Free.Plan(force)
	if not Free.IsOn() then return end
	local C = Codex()
	if not (C and C.IsLoaded()) then return end
	if not force and planned == signature() then return end
	rebuild()
end

-- Quests that left the log take their pin and their "left out" with them
-- (once the log is read: before that it is not known to be empty).
local function forget()
	if not logRead then return end
	local f, K = saved(), ns.Compat
	if f.pin and not K.IsOnQuest(f.pin) then f.pin = nil end
	for q in pairs(f.out) do
		if not K.IsOnQuest(q) then f.out[q] = nil end
	end
end

local pending = false
local function later()
	if pending then return end
	pending = true
	ns.After(PLAN_DELAY, function()
		pending = false
		forget()
		Free.Plan()
	end)
end

-- Whether its tab is open, kept from TABS_CHANGED: the quest log's bursts
-- (50 events a frame) ask nothing more while Free mode is off.
local open = false
ns.On("TABS_CHANGED", function(list)
	open = false
	for _, t in ipairs(type(list) == "table" and list or {}) do
		if t.guideId == GID then open = true end
	end
end)

local function changed()
	if open then later() end
end
ns.RegisterEvent("QUEST_LOG_UPDATE", function()
	logRead = true
	changed()
end)
for _, event in ipairs({ "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_TURNED_IN", "ZONE_CHANGED_NEW_AREA", "PLAYER_ENTERING_WORLD", "PLAYER_LEVEL_UP" }) do
	ns.RegisterEvent(event, changed)
end
-- A free.* setting, or many at once ("": a profile switched, a page reset).
ns.On("SETTING_CHANGED", function(path)
	if open and type(path) == "string" and (path == "" or path:find("^free")) then Free.Plan(true) end
end)

---------------------------------------------------------------------------
-- On and off
---------------------------------------------------------------------------

function Free.Start()
	local E, C = Engine(), Codex()
	if not (E and E.OpenTab and ns.IsLoggedIn()) then return nil, "login" end
	if not C then return nil, "missing" end
	local i = tabIndex()
	if i then
		E.SelectTab(i)
		return true
	end
	local loaded, reason = C.Load()
	if not loaded then return nil, reason end
	lastFirst, lastWhy, lastRows, lastInfo, preview = nil, nil, nil, nil, nil
	local ok, err = Lookup.Guide(KIND, ID)
	if not ok then return nil, err end
	planned = signature()
	Free.MarkUsed()
	ns.Fire("FREE_MODE", true)
	return true
end

-- The guide Stop hands back to: the last guide of a pack the player had in
-- front (the door keeps it, CharState().free.from), else the first other
-- tab holding one; never a tab Polestar built (the hand-in route, a
-- dungeon's pick-up run) -> its title, index | nil.
local function returnTab()
	local i, _, tabs = tabIndex()
	if not tabs then return nil end
	local from = saved().from
	for k, t in ipairs(tabs) do
		if k ~= i and t.guideId == from and Free.IsBackTarget(t.guideId) then return t.title, k end
	end
	for k, t in ipairs(tabs) do
		if k ~= i and Free.IsBackTarget(t.guideId) then return t.title, k end
	end
	return nil
end

function Free.ReturnTitle()
	return (returnTab())
end

function Free.Stop()
	local E = Engine()
	local i = tabIndex()
	if not (E and i) then return end
	local _, k = returnTab()
	if k then
		E.SelectTab(k)
		i = tabIndex()
	end
	E.CloseTab(i, true)
	planned, lastFirst, lastWhy, lastRows, lastInfo = nil, nil, nil, nil, nil
	ns.Fire("FREE_MODE", false)
end

function Free.Toggle()
	local i, active = tabIndex()
	if i and i == active then return Free.Stop() end
	local ok, why = Free.Start()
	if not ok then Free.Say(why) end
end

function Free.Pinned()
	return saved().pin
end

-- The choices are the character's saved state; the quests page (Page.lua)
-- and the world map's click draw again on FREE_CHANGED.
local function changed()
	Free.Plan(true)
	ns.Fire("FREE_CHANGED")
end

function Free.Pin(q, on)
	local f = saved()
	if on then
		f.pin = q
		f.out[q] = nil
	elseif f.pin == q then
		f.pin = nil
	end
	changed()
end

function Free.LeaveOut(q, on)
	local f = saved()
	f.out[q] = on and true or nil
	if on and f.pin == q then f.pin = nil end
	changed()
end

function Free.LeftOut()
	local out = {}
	for q in pairs(saved().out) do out[#out + 1] = q end
	sort(out)
	return out
end

function Free.BringBack()
	saved().out = {}
	changed()
end

---------------------------------------------------------------------------
-- The quests page: every quest in the log, with what the page shows of it
-- and the quick actions that leave out many at once (Page.lua)
---------------------------------------------------------------------------

-- Whether a quest takes a group: an objective on an elite or a boss, or
-- inside an instance (a friendly one is no fight), or one the Codex marks
-- elite for this side. Read from the quest's record, once it is known.
local groupOf = {}
local function takesGroup(q, rec)
	local known = groupOf[q]
	if known ~= nil then return known end
	if not rec then return false end
	local C, code = Codex(), Lookup.PlayerInfo().code
	local group = false
	for _, o in ipairs(rec.objectives or {}) do
		local npc = o.type == "kill" and C.Npc(o.id) or nil
		if npc and (npc.elite or npc.boss or npc.instance) and not npc.faction then group = true end
		local mark = o.elites and code and o.elites[code]
		if mark and mark.rank then group = true end
	end
	groupOf[q] = group
	return group
end

-- Every quest in the log -> { { quest, title, level, zone (map id) | nil,
-- zoneName | nil, ready, group (a quest still to do that takes a group), out,
-- pinned }, ... }: those in the loop first, by zone, level and title, then
-- those left out. The Codex is loaded when it can be (zones and groups come
-- from it); without it a row has its title, level and state alone.
function Free.Quests()
	local f, K, C = saved(), ns.Compat, Codex()
	if C and not C.IsLoaded() then C.Load() end
	local known = C and C.IsLoaded()
	local rows = {}
	for _, q in ipairs(heldQuests()) do
		local rec = known and C.Quest(q) or nil
		local ready = K.IsQuestReadyForTurnIn(q) and true or false
		rows[#rows + 1] = {
			quest = q,
			title = K.GetQuestTitle(q) or (rec and rec.title) or ("#" .. q),
			level = K.GetQuestLevel(q) or (rec and rec.level),
			zone = rec and rec.zone or nil,
			zoneName = rec and rec.zone and K.MapName(rec.zone) or nil,
			ready = ready,
			group = not ready and takesGroup(q, rec),
			out = f.out[q] and true or false,
			pinned = f.pin == q,
		}
	end
	sort(rows, function(a, b)
		if a.out ~= b.out then return not a.out end
		local za, zb = a.zoneName or "", b.zoneName or ""
		if za ~= zb then return za < zb end
		if (a.level or 0) ~= (b.level or 0) then return (a.level or 0) < (b.level or 0) end
		if a.title ~= b.title then return a.title < b.title end
		return a.quest < b.quest
	end)
	return rows
end

-- The zones of the quests in the loop, each with its quests: the zone with
-- the most first -> { { zone, name, quests = { questID, ... } }, ... }.
function Free.Zones()
	local by, list = {}, {}
	for _, r in ipairs(Free.Quests()) do
		if r.zone and r.zoneName and not r.out then
			local z = by[r.zone]
			if not z then
				z = { zone = r.zone, name = r.zoneName, quests = {} }
				by[r.zone] = z
				list[#list + 1] = z
			end
			z.quests[#z.quests + 1] = r.quest
		end
	end
	sort(list, function(a, b)
		if #a.quests ~= #b.quests then return #a.quests > #b.quests end
		return a.name < b.name
	end)
	return list
end

local function leaveOutAll(list)
	local f = saved()
	for _, q in ipairs(list) do
		f.out[q] = true
		if f.pin == q then f.pin = nil end
	end
	changed()
end

-- Leaves out every quest of a zone (a map id) in the loop.
function Free.LeaveOutZone(zone)
	local list = {}
	for _, z in ipairs(Free.Zones()) do
		if z.zone == zone then list = z.quests end
	end
	leaveOutAll(list)
end

-- Leaves out every quest in the loop that takes a group and is still to do.
function Free.LeaveOutGroup()
	local list = {}
	for _, r in ipairs(Free.Quests()) do
		if r.group and not r.out then list[#list + 1] = r.quest end
	end
	leaveOutAll(list)
end

---------------------------------------------------------------------------
-- The guide window's rows (UI/GuideFrameMenu.lua, UI/GuideFrame.lua)
---------------------------------------------------------------------------

-- The guide window menu's rows. Off: start it. On: its page, the way back
-- (Back to <guide>, else Stop), the three orders with the one in use
-- checked, and the quests left out.
function Free.MenuItems()
	if not Free.IsOn() then
		return { { text = L["Free mode"], icon = "icon-freemode", checked = false, tip = L["Your own quests, planned for you: pick up what you like, Polestar orders them and the arrow leads."],
			onClick = function() Free.Toggle() end } }
	end
	local items = {}
	items[1] = { text = L["Free mode page"], icon = "icon-freemode", tip = L["Your route, the order and the quests left out."],
		onClick = function() if ns.UI.ShowFreeMode then ns.UI.ShowFreeMode() end end }
	local back = Free.ReturnTitle()
	items[2] = back and { text = format(L["Back to %s"], back), icon = "chevron-left", onClick = Free.Stop }
		or { text = L["Stop Free mode"], icon = "close", onClick = Free.Stop }
	local rule = Free.Pick()
	local ORDER_ROW = { balanced = L["Order: balanced"], near = L["Order: nearest first"], xp = L["Order: most XP a minute first"] }
	for _, r in ipairs(Free.ORDERS) do
		items[#items + 1] = { text = ORDER_ROW[r], icon = "sliders", checked = r == rule, tip = Free.PickRule(r), onClick = function() Free.SetPick(r) end }
	end
	local out = Free.LeftOut()
	if #out > 0 then
		items[#items + 1] = { text = format(L["Bring back left-out quests (%d)"], #out), icon = "reset", onClick = Free.BringBack }
	end
	return items
end

-- A quest line's right-click rows while Free mode is the guide shown: pin it
-- first or unpin it, and leave it out.
function Free.RowItems(q)
	if not q then return nil end
	local E = Engine()
	local g = E and E.GetGuide and E.GetGuide()
	if not (g and g.id == GID) then return nil end
	local pinned = saved().pin == q
	return {
		{ text = pinned and L["Unpin"] or L["Pin to the top"], icon = "flag", tip = L["Free mode takes this quest first, whatever the order."],
			onClick = function() Free.Pin(q, not pinned) end },
		{ text = L["Leave out of Free mode"], icon = "close", tip = L["Free mode stops listing this quest. The menu's Bring back left-out quests lists it again."],
			onClick = function() Free.LeaveOut(q, true) end },
	}
end

function Free.Command(arg)
	arg = type(arg) == "string" and arg:lower():match("^%s*(%S*)") or ""
	if arg == "off" or arg == "back" then return Free.Stop() end
	if arg == "balanced" then return Free.SetPick("balanced") end
	if arg == "nearest" or arg == "near" then return Free.SetPick("near") end
	if arg == "xp" then return Free.SetPick("xp") end
	if arg == "on" then
		local ok, why = Free.Start()
		if not ok then Free.Say(why) end
		return
	end
	Free.Toggle()
end
