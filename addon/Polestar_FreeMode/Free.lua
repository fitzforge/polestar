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
--   Free.Stop()                         -- close its tab; the tab the player came
--                                          from (else none) is active again
--   Free.Toggle() ; Free.Command(arg)   -- /polestar free [on | off | back | nearest | xp]
--   Free.ReturnTitle() -> title | nil   -- the guide Stop hands back to
--   Free.Pin(questID, on)               -- that quest first, whatever the rule
--   Free.LeaveOut(questID, on)          -- not listed (on = false: back)
--   Free.Pinned() -> questID | nil ; Free.LeftOut() -> { questID, ... }
--   Free.Steps(from?) -> steps, info    -- what a plan holds now (the planner's
--                                          build; info.rows: the quests in order,
--                                          each { quest, title, travel, xp, tier,
--                                          score, place }; info.hint)
--   Free.Plan(force?)                   -- plan again now if anything it reads moved
--   Free.MenuItems() -> { item, ... }   -- the guide window menu's rows
--   Free.RowItems(questID) -> { item, ... } | nil  -- a quest line's right-click rows

local ns = Polestar

local Lookup, L = ns.Lookup, ns.L
local Free = ns.Free

local type, pairs, ipairs, tonumber, tostring = type, pairs, ipairs, tonumber, tostring
local format, floor, min, max, sort, concat = string.format, math.floor, math.min, math.max, table.sort, table.concat

local KIND, ID = "free", "log"
local GID = Free.GUIDE

-- The pick rule's numbers (DESIGN: AreChen's prototype, #4104, gave the
-- shape: tiers, the work left, the hold).
local RUN = 7 -- yards a second, as Guides' travel estimate runs
local NEAR_YARDS = 150 -- another quest's place this close: the same area
local NEAR_BONUS, NEAR_MAX = 10, 3 -- seconds off a quest per such neighbour, at most this many
local READY_BONUS = 6 -- seconds off a hand-in
local FAR_SECONDS = 300 -- the nearest quest further than this: a zone hint first
local LOW_CHANCE = 20 -- a collect whose best source gives it under this percent says so
local HOLD_SHARE, HOLD_SECONDS = 1.2, 6 -- the first quest stays unless another scores this much better
local HARD_ABOVE = 3 -- a quest this many levels above the player ranks after the rest
local EFFORT = { monster = 27, item = 22, other = 12, start = 15, ready = 6 } -- seconds of work
local HINT_ABOVE = 3 -- a zone hint counts quests up to this many levels above the player
local HUB_YARDS = 150 -- givers this close to one another make one hub
local HINT_SLICE = 300 -- Codex quests judged per frame while a hint is worked out
local PLAN_DELAY = 0.3 -- seconds: a burst of quest-log events makes one plan

local function Codex() return ns.Codex end
local function Engine() return ns.Engine end

---------------------------------------------------------------------------
-- Saved: CharState().free = { pin = questID, out = { [questID] = true },
-- from = guideId (the tab Stop goes back to) }
---------------------------------------------------------------------------

local function saved()
	local s = ns.CharState()
	local f = s.free
	if type(f) ~= "table" then
		f = {}
		s.free = f
	end
	if type(f.out) ~= "table" then f.out = {} end
	return f
end

local function pick()
	return ns.Get("free.pick") == "xp" and "xp" or "near"
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

local direct = ns.DirectTravelCost

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

-- The seconds of work left in a quest: per count left of each open line.
local function effort(lines, ready)
	if ready then return EFFORT.ready end
	local s = EFFORT.start
	for _, line in ipairs(lines or {}) do
		if not line.finished then
			local left = max(1, (line.numRequired or 1) - (line.numFulfilled or 0))
			s = s + left * (EFFORT[line.type] or EFFORT.other)
		end
	end
	return s
end

-- One held quest -> its row { quest, title, step, ready, xp, effort, qlvl,
-- hard, place, travel }: its step is Lookup's quest step (the giver's accept
-- left out: it is held) with the open goals' places measured from `from`.
local function questRow(q, from, p, details)
	local C, K = Codex(), ns.Compat
	local rec = C and C.Quest(q)
	local title = K.GetQuestTitle(q) or (rec and rec.title) or ("#" .. q)
	local ready = K.IsQuestReadyForTurnIn(q) and true or false
	local lines = not ready and K.GetQuestObjectives(q) or nil
	local qlvl = K.GetQuestLevel(q) or (rec and rec.level)
	local row = { quest = q, title = title, ready = ready, qlvl = qlvl, effort = effort(lines, ready) }
	row.xp = questXP(rec, qlvl, p.level)
	row.hard = (qlvl and qlvl >= p.level + HARD_ABOVE) and true or false
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
	if from then
		local best, bestD
		for _, g in ipairs(goals) do
			if goalOpen(g, ready, lines) then
				for _, pt in ipairs(places(g, {})) do
					local d = direct(from, pt)
					if d and (not bestD or d < bestD) then best, bestD = pt, d end
				end
			end
		end
		if best then row.place, row.travel = best, walk(from, best) or bestD end
	end
	return row
end

---------------------------------------------------------------------------
-- The pick rule
---------------------------------------------------------------------------

local CROSS = ns.TRAVEL_CROSS_CONTINENT or 3600

local function tierOf(r)
	if not r.place or not r.travel or r.travel >= CROSS then return 2 end
	return r.hard and 1 or 0
end

local function before(a, b)
	if a.tier ~= b.tier then return a.tier < b.tier end
	if a.score ~= b.score then return a.score < b.score end
	return a.quest < b.quest
end

-- The quests in the order Free mode takes them. Nearest: tiers (at your
-- level here; then hard; then elsewhere), then the walk less a little for
-- each other quest's place nearby and for a hand-in; after the first, each
-- next one nearest the last one's place. Best XP a minute: tiers, then XP
-- over the walk and the work left. A pinned quest first; the first of the
-- last plan stays first unless another beats it clearly (`last`).
local function order(rows, rule, pin, last)
	for _, r in ipairs(rows) do
		r.tier = tierOf(r)
		local near = 0
		for _, o in ipairs(rows) do
			if o ~= r and r.place and o.place then
				local d = direct(r.place, o.place)
				if d and d * RUN <= NEAR_YARDS then near = near + 1 end
			end
		end
		local t = r.travel or CROSS
		r.score = max(1, t - min(near, NEAR_MAX) * NEAR_BONUS - (r.ready and READY_BONUS or 0))
		if rule == "xp" then
			r.rate = (r.xp or 0) * 60 / max(1, t + r.effort)
			-- Higher rate first: a score as low as the rate is high.
			r.score = -r.rate
		end
	end
	sort(rows, before)
	local best = rows[1]
	-- The hold: the last plan's first quest keeps its place while it scores
	-- within HOLD_SHARE and HOLD_SECONDS of the best (so a few yards never flip
	-- the arrow).
	if best and last and best.quest ~= last then
		for i, r in ipairs(rows) do
			if r.quest == last and r.tier == best.tier then
				local holds
				if rule == "xp" then
					holds = r.rate * HOLD_SHARE + 1 >= best.rate
				else
					holds = r.score <= best.score * HOLD_SHARE + HOLD_SECONDS
				end
				if holds then
					table.remove(rows, i)
					table.insert(rows, 1, r)
				end
				break
			end
		end
	end
	if rule ~= "xp" then
		-- Nearest-next from the first, tier by tier: an area's quests stay together.
		local out, left = { rows[1] }, {}
		for i = 2, #rows do left[#left + 1] = rows[i] end
		while #left > 0 do
			local prev, bi, bd = out[#out], nil, nil
			for i, r in ipairs(left) do
				local d = (prev.place and r.place) and direct(prev.place, r.place) or CROSS
				if not bi or r.tier < left[bi].tier or (r.tier == left[bi].tier and (d < bd or (d == bd and r.quest < left[bi].quest))) then
					bi, bd = i, d
				end
			end
			out[#out + 1] = table.remove(left, bi)
		end
		rows = out
	end
	if pin then
		for i, r in ipairs(rows) do
			if r.quest == pin then
				table.remove(rows, i)
				table.insert(rows, 1, r)
				break
			end
		end
	end
	return rows
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

local lastFirst -- the first quest of the last plan (the hold)

function Free.Steps(from)
	from = from or ns.PlayerPoint()
	local f, p = saved(), Lookup.PlayerInfo()
	local details = ns.Get("free.details") and true or false
	local rows = {}
	for _, q in ipairs(heldQuests()) do
		if not f.out[q] then rows[#rows + 1] = questRow(q, from, p, details) end
	end
	local rule = pick()
	rows = order(rows, rule, f.pin, lastFirst)
	local steps, info = {}, { rows = rows }
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
	for _, r in ipairs(rows) do
		if rule == "xp" and r.rate and r.rate > 0 then
			local text = format(L["About %s XP a minute"], ns.Thousands(floor(r.rate + 0.5)))
			r.step.note = r.step.note and (text .. ". " .. r.step.note) or text
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
	lastFirst = info.first
	return { title = L["Free mode"], steps = steps, category = "Lookup" }
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
ns.On("SETTING_CHANGED", function(path)
	if open and type(path) == "string" and path:find("^free") then Free.Plan(true) end
end)

---------------------------------------------------------------------------
-- On and off
---------------------------------------------------------------------------

function Free.Start()
	local E, C = Engine(), Codex()
	if not (E and E.OpenTab and ns.IsLoggedIn()) then return nil, "login" end
	if not C then return nil, "missing" end
	local i, active, tabs = tabIndex()
	if i then
		E.SelectTab(i)
		return true
	end
	local loaded, reason = C.Load()
	if not loaded then return nil, reason end
	local cur = active and tabs[active]
	saved().from = cur and cur.guideId or nil
	lastFirst = nil
	local ok, err = Lookup.Guide(KIND, ID)
	if not ok then return nil, err end
	planned = signature()
	ns.Fire("FREE_MODE", true)
	return true
end

-- The guide Stop hands back to: the tab the player came from, else the
-- first other tab -> its title, index | nil.
local function returnTab()
	local i, _, tabs = tabIndex()
	if not tabs then return nil end
	local from = saved().from
	for k, t in ipairs(tabs) do
		if k ~= i and t.guideId == from then return t.title, k end
	end
	for k, t in ipairs(tabs) do
		if k ~= i then return t.title, k end
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
	saved().from = nil
	planned, lastFirst = nil, nil
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

function Free.Pin(q, on)
	local f = saved()
	if on then
		f.pin = q
		f.out[q] = nil
	elseif f.pin == q then
		f.pin = nil
	end
	Free.Plan(true)
end

function Free.LeaveOut(q, on)
	local f = saved()
	f.out[q] = on and true or nil
	if on and f.pin == q then f.pin = nil end
	Free.Plan(true)
end

function Free.LeftOut()
	local out = {}
	for q in pairs(saved().out) do out[#out + 1] = q end
	sort(out)
	return out
end

---------------------------------------------------------------------------
-- The guide window's rows (UI/GuideFrameMenu.lua, UI/GuideFrame.lua)
---------------------------------------------------------------------------

function Free.MenuItems()
	local items = {}
	local on = Free.IsOn()
	items[1] = { text = L["Free mode"], icon = "icon-explore", checked = on, tip = L["Your own quests as a guide: the arrow leads to the nearest one, then the next."],
		onClick = function() if on then Free.Stop() else Free.Toggle() end end }
	if on then
		local xp = pick() == "xp"
		items[#items + 1] = { text = xp and L["Order: nearest first"] or L["Order: most XP a minute first"], icon = "sliders",
			onClick = function() Free.SetPick(xp and "near" or "xp") end }
		local out = Free.LeftOut()
		if #out > 0 then
			items[#items + 1] = { text = format(L["Bring back left-out quests (%d)"], #out), icon = "reset", onClick = function()
				saved().out = {}
				Free.Plan(true)
			end }
		end
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
	if arg == "nearest" or arg == "near" then return Free.SetPick("near") end
	if arg == "xp" then return Free.SetPick("xp") end
	if arg == "on" then
		local ok, why = Free.Start()
		if not ok then Free.Say(why) end
		return
	end
	Free.Toggle()
end
