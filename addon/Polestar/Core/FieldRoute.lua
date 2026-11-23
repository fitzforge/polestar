-- Open travelling-salesman route for the independent goals in one field
-- group. World coordinates only: no progress writes, movement or game calls.
local ADDON, ns = ...
local Route = {}
ns.FieldRoute = Route

local EPS = 1e-7
local EXACT = 8 -- stops searched exactly (Held-Karp)
local LIMIT = 32 -- stops routed at all; more: the caller's own selector
Route.EXACT, Route.LIMIT = EXACT, LIMIT

-- Scratch kept between plans, so a plan allocates only the order it returns
-- (the Engine plans from its arrival poll; a table per subset was 158 KiB of
-- garbage for eight stops). For the n stops of the plan being made:
--   D[(i - 1) * n + j]  yards from stop i to stop j
--   FROM[i], TO[i]      yards from the start to i, from i on to the finish (0 without one)
--   DELAY[i]            stop i's delay
-- Held-Karp, per subset `mask` (stop i is bit 2 ^ (i - 1)) and last stop j:
--   COST[(mask - 1) * n + j]  the best score through mask's stops ending at j
--   PREV[...], FIRST[...]     the stop before j on that path, and its first stop
-- A subset is filled before any larger one reads it, so nothing is cleared.
local D, FROM, TO, DELAY = {}, {}, {}, {}
local COST, PREV, FIRST, MEMBER = {}, {}, {}, {}
local SEEN, SUM, WEIGHTED = {}, {}, {}
local BIT = {}
for i = 1, EXACT do BIT[i] = 2 ^ (i - 1) end

local function measure(points, n, start, finish)
	for i = 1, n do
		local p, row = points[i], (i - 1) * n
		FROM[i] = ((start.x - p.x) ^ 2 + (start.y - p.y) ^ 2) ^ 0.5
		TO[i] = finish and ((p.x - finish.x) ^ 2 + (p.y - finish.y) ^ 2) ^ 0.5 or 0
		DELAY[i] = p.delay or 0
		for j = 1, n do
			local q = points[j]
			D[row + j] = ((p.x - q.x) ^ 2 + (p.y - q.y) ^ 2) ^ 0.5
		end
	end
end

local function length(order, n)
	local total = FROM[order[1]] + TO[order[n]]
	for i = 2, n do total = total + D[(order[i - 1] - 1) * n + order[i]] end
	return total
end

local function delayCost(order, n)
	local cost = 0
	for i = 1, n do cost = cost + DELAY[order[i]] * (n - i) end
	return cost
end

-- Held-Karp, with an optional fixed first stop. Arithmetic masks keep this
-- compatible with the client's Lua 5.1 (no bit operators or dependencies).
-- Of equal scores, the path whose first stop is nearer the start wins.
local function exact(n, fixed)
	local huge = math.huge
	local all = 2 ^ n - 1
	for mask = 1, all do
		local k, rest = 0, mask
		for i = 1, n do
			local bit = rest % 2
			if bit == 1 then k = k + 1; MEMBER[k] = i end
			rest = (rest - bit) / 2
		end
		local base = (mask - 1) * n
		if k == 1 then
			local i = MEMBER[1]
			COST[base + i] = (not fixed or i == fixed) and FROM[i] + DELAY[i] * (n - 1) or huge
			PREV[base + i], FIRST[base + i] = 0, i
		else
			local later = n - k -- stops still to come after the k-th
			for a = 1, k do
				local j = MEMBER[a]
				local before, wait = (mask - BIT[j] - 1) * n, DELAY[j] * later
				local best, from, first = huge, 0, 0
				for b = 1, k do
					local i = MEMBER[b]
					local cost = i ~= j and COST[before + i] or huge
					if cost < huge then
						cost = cost + D[(i - 1) * n + j] + wait
						if from == 0 or cost < best - EPS or (math.abs(cost - best) <= EPS
							and FROM[FIRST[before + i]] < FROM[first] - EPS) then
							best, from, first = cost, i, FIRST[before + i]
						end
					end
				end
				COST[base + j], PREV[base + j], FIRST[base + j] = best, from, first
			end
		end
	end
	local base = (all - 1) * n
	local last, best
	for i = 1, n do
		local cost = COST[base + i]
		if cost < huge then
			cost = cost + TO[i]
			if not best or cost < best - EPS or (math.abs(cost - best) <= EPS
				and FROM[FIRST[base + i]] < FROM[FIRST[base + last]] - EPS) then last, best = i, cost end
		end
	end
	local order, mask = {}, all
	for at = n, 1, -1 do
		order[at] = last
		local before = PREV[(mask - 1) * n + last]
		mask, last = mask - BIT[last], before
	end
	return order, best
end

local function greedy(n, first)
	local order = {}
	for i = 1, n do SEEN[i] = false end
	for at = 1, n do
		local row = at > 1 and (order[at - 1] - 1) * n
		local best, cost
		for i = 1, n do
			if not SEEN[i] and (at ~= 1 or not first or i == first) then
				local c = row and D[row + i] or FROM[i]
				if not cost or c < cost - EPS then best, cost = i, c end
			end
		end
		order[at], SEEN[best] = best, true
	end
	return order
end

-- Running sums along an order, from place `from` on: of the stops' delays
-- (SUM) and of each delay times its place (WEIGHTED).
local function sums(order, n, from)
	for k = from, n do
		local delay = DELAY[order[k]]
		SUM[k], WEIGHTED[k] = SUM[k - 1] + delay, WEIGHTED[k - 1] + delay * k
	end
end

-- Symmetric 2-opt also considers the open tail. A fixed start never moves.
-- Reversing order[i..j] moves the stop at k to i + j - k, so its delay counts
-- for 2k - i - j stops more: read off the running sums, not walked per pair.
local function improve(order, n, fixed)
	SUM[0], WEIGHTED[0] = 0, 0
	sums(order, n, 1)
	for _ = 1, 6 do
		local changed = false
		for i = fixed and 2 or 1, n - 1 do
			for j = i + 1, n do
				local a, b = order[i], order[j]
				local into = i > 1 and (order[i - 1] - 1) * n
				local before = into and D[into + a] or FROM[a]
				local after = into and D[into + b] or FROM[b]
				before = before + (j < n and D[(b - 1) * n + order[j + 1]] or TO[b])
				after = after + (j < n and D[(a - 1) * n + order[j + 1]] or TO[a])
				after = after + 2 * (WEIGHTED[j] - WEIGHTED[i - 1]) - (i + j) * (SUM[j] - SUM[i - 1])
				if after < before - EPS then
					local left, right = i, j
					while left < right do
						order[left], order[right] = order[right], order[left]
						left, right = left + 1, right - 1
					end
					sums(order, n, i)
					changed = true
				end
			end
		end
		if not changed then break end
	end
	return order, length(order, n) + delayCost(order, n)
end

local function valid(p)
	return type(p) == "table" and type(p.x) == "number" and type(p.y) == "number"
		and p.x == p.x and p.y == p.y and math.abs(p.x) < math.huge and math.abs(p.y) < math.huge
		and (p.delay == nil or (type(p.delay) == "number" and p.delay >= 0 and p.delay < math.huge))
end

-- Returns input indices, straight-line yards and score. A point's optional
-- delay adds a soft cost for every stop after it, biasing hard quests later.
-- No tour closes back to the player. A finish is a cost hint, never an extra
-- task in the output. Up to EXACT stops the order is the best there is; up
-- to LIMIT a 2-opt improvement of several starting orders, never worse than
-- nearest-first. Larger groups fall back to the caller's existing
-- nearest-goal selector (nil).
function Route.Plan(points, start, finish, fixed)
	local n = #points
	if n == 0 or n > LIMIT or not valid(start) or (finish and not valid(finish)) then return nil end
	if fixed and (fixed < 1 or fixed > n or fixed % 1 ~= 0) then return nil end
	for _, p in ipairs(points) do if not valid(p) then return nil end end
	measure(points, n, start, finish)
	if n <= EXACT then
		local order, cost = exact(n, fixed)
		local baseline = greedy(n, fixed)
		local baseCost = length(baseline, n) + delayCost(baseline, n)
		if baseCost <= cost + EPS then order, cost = baseline, baseCost end
		return order, length(order, n), cost
	end
	local best, cost = improve(greedy(n, fixed), n, fixed)
	-- Compare authored order and four distinct starting points. Keeping the
	-- greedy baseline guarantees this heuristic never worsens its score.
	local authored = {}
	if fixed then authored[1] = fixed end
	for i = 1, n do if i ~= fixed then authored[#authored + 1] = i end end
	local order, total = improve(authored, n, fixed)
	if total < cost - EPS then best, cost = order, total end
	if not fixed then
		for seed = 1, 4 do
			local first = 1 + math.floor((seed - 1) * (n - 1) / 3)
			order, total = improve(greedy(n, first), n, nil)
			if total < cost - EPS then best, cost = order, total end
		end
	end
	return best, length(best, n), cost
end
