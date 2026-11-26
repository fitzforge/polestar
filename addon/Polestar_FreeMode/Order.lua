-- Free mode's pick rule (#3701): the held quests in the order Free mode takes
-- them, and why the first is first. Pure: rows in, rows out, no client calls,
-- so Free.lua plans with it and the same code can be replayed outside the game.
--
--   Order.Sort(rows, rule, pin, last, dist) -> rows   -- rule "balanced" | "near" | "xp"
--   Order.Why(rows, rule) -> { { key, n? }, ... }      -- the 1-3 strongest reasons for rows[1]
--   Order.Effort(lines, ready) -> seconds              -- the work left in a quest
--
-- A row: { quest, ready, xp, effort, travel, place, hard, started, open, mobs,
-- ender } (Free.lua's questRow): travel the walking planner's seconds to its
-- next place; open the places of its open objectives; mobs a set of the mobs
-- its open objectives are had from ("n<id>"); ender the hand-in NPC's key while
-- it is ready. dist(a, b) -> the straight line's seconds between two places
-- (ns.DirectTravelCost), CROSS across continents, nil when either is unplaced.

local ns = Polestar
local Order = {}
ns.FreeOrder = Order

local ipairs, pairs, type = ipairs, pairs, type
local floor, min, max, sort, remove, insert = math.floor, math.min, math.max, table.sort, table.remove, table.insert

local RUN = 7 -- yards a second, as Guides' travel estimate runs
Order.RUN = RUN
local CROSS = ns.TRAVEL_CROSS_CONTINENT or 3600

-- Seconds of work (DESIGN: AreChen's prototype, #4104, gave the shape: tiers,
-- the work left, the hold): 15 s to start, then each count left of an open
-- line; a quest ready to hand in, the hand-in. A kill or an item counts the
-- seconds players' recordings show one takes at the player's level (the
-- median time between two ticks of an objective line, quests of levels 1-9,
-- 10-19, ... 50-60, 26 Nov 2026); anything else, `other`.
Order.EFFORT = {
	monster = { 23, 30, 36, 43, 45, 48 },
	item = { 36, 53, 56, 61, 59, 67 },
	other = 12,
	start = 15,
	ready = 6,
}

-- Nearest first: the walk, less NEAR.bonus seconds for each other quest's
-- place within NEAR.yards (at most NEAR.max) and NEAR.ready for a hand-in.
Order.NEAR = { yards = 150, bonus = 10, max = 3, ready = 6 }

-- The hold: the last plan's first quest stays first while the best beats it
-- by less than this (nearest: within share times its score plus seconds;
-- most XP and balanced: a rate within share of the best), so a few yards
-- walked never flip the arrow.
Order.HOLD = { share = 1.2, seconds = 6 }

-- Balanced: one score per next stop, the XP it pays a minute of the trip and
-- the work (gain * 60 / (travel * walk + work + leaving)), the gain raised by
-- what the stop does besides, and the best of the stop alone or with the
-- best next stop from it. Every weight is here; the replay of players'
-- recorded quest logs (14,435 sessions, 26 Nov 2026) set walk, leave and
-- here, and measured the order against the other two.
Order.BALANCED = {
	-- XP counted for a quest the data gives none: the median of the rows that
	-- have it (else this), so it neither wins nor loses on a gap.
	xp = 500,
	-- A hand-in, each quest at the NPC: the seconds at its window. A finished
	-- quest's stop counts every finished quest that NPC takes, one trip.
	ready = 6,
	-- Another held quest with an open objective this close to the stop, or
	-- with the same mobs: the trip serves it too. Each such quest adds this
	-- share to the gain, up to shareMax of them.
	shareYards = 150,
	share = 0.35,
	shareMax = 3,
	-- Progress made (a line finished or counted): less left to do than the
	-- estimate's start, and the mobs already found.
	started = 0.15,
	-- An NPC that takes 2+ of the finished quests on the way: within wayYards
	-- of the stop, or the walk through it no longer than wayDetour times the
	-- walk straight there plus waySlack seconds.
	way = 0.25,
	wayYards = 150,
	wayDetour = 1.25,
	waySlack = 20,
	-- A second walked counts this many seconds of work: walking pays nothing,
	-- and a far stop's XP rarely makes up for it (replayed: 1 lost a fifth of
	-- Nearest's XP an hour at levels 1-9).
	walk = 2,
	-- Leaving open quests behind: while another open quest is within `here`
	-- seconds, a stop further than that also costs `leave` times its walk
	-- (the way back for the ones left).
	here = 45,
	leave = 4,
}

-- The seconds of work left in a quest at the player's `level`: per count left
-- of each open line ({ finished, type, numRequired, numFulfilled }, the
-- client's).
function Order.Effort(lines, ready, level)
	local E = Order.EFFORT
	if ready then return E.ready end
	local band = min(6, max(1, floor((level or 1) / 10) + 1))
	local s = E.start
	for _, line in ipairs(lines or {}) do
		if not line.finished then
			local left = max(1, (line.numRequired or 1) - (line.numFulfilled or 0))
			local per = E[line.type]
			s = s + left * (type(per) == "table" and per[band] or E.other)
		end
	end
	return s
end

local function tierOf(r)
	if not r.place or not r.travel or r.travel >= CROSS then return 2 end
	return r.hard and 1 or 0
end

local function before(a, b)
	if a.tier ~= b.tier then return a.tier < b.tier end
	if a.score ~= b.score then return a.score < b.score end
	return a.quest < b.quest
end

-- Whether two rows' open objectives are one stop: a place of b's within
-- `yards` of a's next place, or a mob both are had from.
local function shares(a, b, yards, dist)
	if a.mobs and b.mobs then
		for k in pairs(a.mobs) do
			if b.mobs[k] then return true end
		end
	end
	if not a.place then return false end
	for _, p in ipairs(b.open or {}) do
		local d = dist(a.place, p)
		if d and d * RUN <= yards then return true end
	end
	return false
end

-- Balanced's parts of each row: its gain, its work, the quests its stop
-- shares, a finished-quest stop on the way, progress made, and what leaving
-- the quests here would cost.
local function balanced(rows, dist)
	local B = Order.BALANCED
	local xps = {}
	for _, r in ipairs(rows) do
		if r.xp and r.xp > 0 then xps[#xps + 1] = r.xp end
	end
	sort(xps)
	local fill = #xps > 0 and xps[floor((#xps + 1) / 2)] or B.xp
	-- The NPCs that take 2+ finished quests, each with its XP and count.
	local stops = {}
	for _, r in ipairs(rows) do
		if r.ready and r.ender then
			local s = stops[r.ender]
			if not s then
				s = { n = 0, xp = 0, row = r }
				stops[r.ender] = s
			end
			s.n, s.xp = s.n + 1, s.xp + (r.xp or fill)
			if r.travel and (not s.row.travel or r.travel < s.row.travel) then s.row = r end
		end
	end
	local here = 0
	for _, o in ipairs(rows) do
		if not o.ready and o.travel and o.travel <= B.here then here = here + 1 end
	end
	for _, r in ipairs(rows) do
		local b = { gain = r.xp or fill, work = r.effort or 0, share = 0, way = false, stop = 1, leave = 0 }
		r.bal = b
		if r.ready then
			local s = r.ender and stops[r.ender]
			if s then b.gain, b.work, b.stop = s.xp, B.ready * s.n, s.n end
		else
			for _, o in ipairs(rows) do
				if o ~= r and not o.ready and shares(r, o, B.shareYards, dist) then
					b.share = b.share + 1
					if b.share >= B.shareMax then break end
				end
			end
			b.started = r.started and true or false
		end
		if r.place and r.travel then
			for key, s in pairs(stops) do
				local at = s.row
				if s.n >= 2 and key ~= r.ender and at.place and at.travel then
					local d = dist(at.place, r.place)
					if d and (d * RUN <= B.wayYards or at.travel + d <= r.travel * B.wayDetour + B.waySlack) then
						b.way = true
						break
					end
				end
			end
		end
		b.mult = 1 + B.share * b.share + (b.started and B.started or 0) + (b.way and B.way or 0)
		local t = r.travel
		local others = here - ((not r.ready and t and t <= B.here) and 1 or 0)
		if t and t > B.here and others > 0 then b.leave = t * B.leave end
	end
end

-- r's score from `travel` (`first`: from where the player stands, leaving
-- the quests here).
local function rateOf(r, travel, first)
	local b = r.bal
	return b.gain * b.mult * 60 / max(1, travel * Order.BALANCED.walk + b.work + (first and b.leave or 0))
end

-- Balanced looking one stop ahead: r's rate, or r and the best next stop from
-- its place together when that pays more a minute.
local function lookahead(rows, dist)
	local B = Order.BALANCED
	for _, r in ipairs(rows) do
		local b, t = r.bal, r.travel or CROSS
		local best = b.rate
		if r.place then
			for _, o in ipairs(rows) do
				if o ~= r and o.tier == r.tier and o.place then
					local d = dist(r.place, o.place) or CROSS
					local v = (b.gain * b.mult + o.bal.gain * o.bal.mult) * 60 / max(1, (t + d) * B.walk + b.work + o.bal.work + b.leave)
					if v > best then best = v end
				end
			end
		end
		b.ahead = best
	end
	for _, r in ipairs(rows) do
		r.bal.rate = r.bal.ahead
		r.score = -r.bal.rate
	end
end

-- The quests in the order Free mode takes them. Every order: tiers first (at
-- your level here; then 3+ levels above or a group's; then another continent
-- or nowhere placed). Nearest: the walk less a little for each other quest's
-- place nearby and for a hand-in; after the first, each next one nearest the
-- last one's place. Most XP a minute: XP over the walk and the work left.
-- Balanced: Order.BALANCED's score; after the first, each next one scored
-- from the last one's place. A pinned quest first; the first of the last plan
-- stays first unless another beats it clearly (`last`).
function Order.Sort(rows, rule, pin, last, dist)
	local N = Order.NEAR
	if rule == "balanced" then balanced(rows, dist) end
	local minTravel = {}
	for _, r in ipairs(rows) do
		r.tier = tierOf(r)
		local near = 0
		for _, o in ipairs(rows) do
			if o ~= r and r.place and o.place then
				local d = dist(r.place, o.place)
				if d and d * RUN <= N.yards then near = near + 1 end
			end
		end
		local t = r.travel or CROSS
		r.rate = (r.xp or 0) * 60 / max(1, t + (r.effort or 0))
		if rule == "xp" then
			-- Higher rate first: a score as low as the rate is high.
			r.score = -r.rate
		elseif rule == "balanced" then
			r.bal.rate = rateOf(r, t, true)
			r.score = -r.bal.rate
		else
			r.score = max(1, t - min(near, N.max) * N.bonus - (r.ready and N.ready or 0))
		end
		if not minTravel[r.tier] or t < minTravel[r.tier] then minTravel[r.tier] = t end
	end
	if rule == "balanced" then lookahead(rows, dist) end
	sort(rows, before)
	local best = rows[1]
	if best then
		best.held = nil
		best.nearest = (best.travel or CROSS) <= minTravel[best.tier] + 5
	end
	if best and last and best.quest ~= last then
		for i, r in ipairs(rows) do
			if r.quest == last and r.tier == best.tier then
				local holds
				if rule == "near" then
					holds = r.score <= best.score * Order.HOLD.share + Order.HOLD.seconds
				else
					holds = -r.score * Order.HOLD.share + 1 >= -best.score
				end
				if holds then
					remove(rows, i)
					insert(rows, 1, r)
					r.held = true
					r.nearest = (r.travel or CROSS) <= minTravel[r.tier] + 5
				end
				break
			end
		end
	end
	if rule ~= "xp" then
		-- From the first, tier by tier: nearest, the next nearest the last one's
		-- place (an area's quests stay together); balanced, the best score from it.
		local out, left = { rows[1] }, {}
		for i = 2, #rows do left[#left + 1] = rows[i] end
		while #left > 0 do
			local prev, bi, bv = out[#out], nil, nil
			for i, r in ipairs(left) do
				local d = (prev.place and r.place) and dist(prev.place, r.place) or CROSS
				local v = d
				if rule == "balanced" then v = -rateOf(r, d) end
				local b = left[bi]
				if not bi or r.tier < b.tier or (r.tier == b.tier and (v < bv or (v == bv and r.quest < b.quest))) then
					bi, bv = i, v
				end
			end
			out[#out + 1] = remove(left, bi)
		end
		rows = out
	end
	if pin then
		for i, r in ipairs(rows) do
			if r.quest == pin then
				remove(rows, i)
				insert(rows, 1, r)
				break
			end
		end
	end
	return rows
end

-- The 1-3 strongest reasons the first row is first, strongest first: { key,
-- n? } with key "pinned" | "stop" (n finished quests at one NPC) | "ready" (a
-- finished quest) | "shared" (n of your quests at this stop) | "way" (a
-- hand-in on the way) | "started" | "nearest" | "xp" (most XP for the trip:
-- the order's own rate, Balanced's with its weights) | "held" (kept while you
-- walk).
function Order.Why(rows, rule, pin)
	local r = rows[1]
	if not r then return {} end
	if pin and r.quest == pin then return { { key = "pinned" } } end
	local list = {}
	local function add(key, strength, n) list[#list + 1] = { key = key, s = strength, n = n } end
	local B = Order.BALANCED
	local b = rule == "balanced" and r.bal or nil
	if b then
		if b.stop >= 2 then add("stop", B.share * b.stop, b.stop) elseif r.ready then add("ready", 0.3) end
		if b.share > 0 then add("shared", B.share * b.share, b.share + 1) end
		if b.way then add("way", B.way) end
		if b.started then add("started", B.started) end
	end
	local function rate(x)
		if b then return x.bal and x.bal.rate or 0 end
		return x.rate or 0
	end
	local topRate = true
	for i = 2, #rows do
		if rows[i].tier == r.tier and rate(rows[i]) > rate(r) then topRate = false end
	end
	if r.nearest then add("nearest", rule == "near" and 1 or 0.1) end
	if topRate and rate(r) > 0 then add("xp", rule == "xp" and 1 or 0.05) end
	if r.held and #list == 0 then add("held", 0) end
	-- Strongest first; equal ones in the order added.
	for i, e in ipairs(list) do e.i = i end
	sort(list, function(a, c)
		if a.s ~= c.s then return a.s > c.s end
		return a.i < c.i
	end)
	local out = {}
	for i = 1, min(3, #list) do out[i] = { key = list[i].key, n = list[i].n } end
	return out
end
