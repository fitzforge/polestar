-- Open travelling-salesman route for the independent goals in one field
-- group. World coordinates only: no progress writes, movement or game calls.
local ADDON, ns = ...
local Route = {}
ns.FieldRoute = Route

local EPS = 1e-7
local EXACT = 8
local LIMIT = 32

local function distance(a, b)
	return ((a.x - b.x) ^ 2 + (a.y - b.y) ^ 2) ^ 0.5
end

local function matrix(points, start, finish)
	local d, from, to = {}, {}, {}
	for i, p in ipairs(points) do
		d[i] = {}
		from[i] = distance(start, p)
		to[i] = finish and distance(p, finish) or 0
		for j, q in ipairs(points) do d[i][j] = distance(p, q) end
	end
	return d, from, to
end

local function length(order, d, from, to)
	local total = from[order[1]] + to[order[#order]]
	for i = 2, #order do total = total + d[order[i - 1]][order[i]] end
	return total
end

local function delayCost(order, points)
	local cost = 0
	for i, p in ipairs(order) do cost = cost + (points[p].delay or 0) * (#order - i) end
	return cost
end

-- Held-Karp, with an optional fixed first stop. Arithmetic masks keep this
-- compatible with the client's Lua 5.1 (no bit operators or dependencies).
local function exact(n, d, from, to, fixed, points)
	local bits, dp, prev, first = {}, {}, {}, {}
	for i = 1, n do bits[i] = 2 ^ (i - 1) end
	for i = 1, n do
		if not fixed or i == fixed then
			dp[bits[i]], prev[bits[i]] = { [i] = from[i] + (points[i].delay or 0) * (n - 1) }, {}
			first[bits[i]] = { [i] = i }
		end
	end
	local all = 2 ^ n - 1
	for mask = 1, all do
		local row = dp[mask]
		if row then
			local count = 0
			for i = 1, n do if math.floor(mask / bits[i]) % 2 == 1 then count = count + 1 end end
			for i = 1, n do
				if row[i] then
					for j = 1, n do
						if math.floor(mask / bits[j]) % 2 == 0 then
							local nextMask = mask + bits[j]
							local cost = row[i] + d[i][j] + (points[j].delay or 0) * (n - count - 1)
							dp[nextMask], prev[nextMask] = dp[nextMask] or {}, prev[nextMask] or {}
							first[nextMask] = first[nextMask] or {}
							local old = dp[nextMask][j]
							if not old or cost < old - EPS or (math.abs(cost - old) <= EPS
								and from[first[mask][i]] < from[first[nextMask][j]] - EPS) then
								dp[nextMask][j], prev[nextMask][j] = cost, i
								first[nextMask][j] = first[mask][i]
							end
						end
					end
				end
			end
		end
	end
	local last, best
	for i = 1, n do
		local cost = dp[all][i] and dp[all][i] + to[i]
		if cost and (not best or cost < best - EPS or (math.abs(cost - best) <= EPS
			and from[first[all][i]] < from[first[all][last]] - EPS)) then last, best = i, cost end
	end
	local order, mask = {}, all
	for at = n, 1, -1 do
		order[at] = last
		local before = prev[mask][last]
		mask, last = mask - bits[last], before
	end
	return order, best
end

local function greedy(n, d, from, first)
	local order, seen = {}, {}
	for at = 1, n do
		local best, cost
		for i = 1, n do
			if not seen[i] and (at ~= 1 or not first or i == first) then
				local c = at == 1 and from[i] or d[order[at - 1]][i]
				if not cost or c < cost - EPS then best, cost = i, c end
			end
		end
		order[at], seen[best] = best, true
	end
	return order
end

-- Symmetric 2-opt also considers the open tail. A fixed start never moves.
local function improve(order, d, from, to, fixed, points)
	for _ = 1, 6 do
		local changed = false
		for i = fixed and 2 or 1, #order - 1 do
			for j = i + 1, #order do
				local a, b = order[i], order[j]
				local before = i > 1 and d[order[i - 1]][a] or from[a]
				local after = i > 1 and d[order[i - 1]][b] or from[b]
				before = before + (j < #order and d[b][order[j + 1]] or to[b])
				after = after + (j < #order and d[a][order[j + 1]] or to[a])
				for k = i, j do
					after = after + (points[order[k]].delay or 0) * (2 * k - i - j)
				end
				if after < before - EPS then
					local left, right = i, j
					while left < right do
						order[left], order[right] = order[right], order[left]
						left, right = left + 1, right - 1
					end
					changed = true
				end
			end
		end
		if not changed then break end
	end
	return order, length(order, d, from, to) + delayCost(order, points)
end

local function valid(p)
	return type(p) == "table" and type(p.x) == "number" and type(p.y) == "number"
		and p.x == p.x and p.y == p.y and math.abs(p.x) < math.huge and math.abs(p.y) < math.huge
		and (p.delay == nil or (type(p.delay) == "number" and p.delay >= 0 and p.delay < math.huge))
end

-- Returns input indices, straight-line yards and score. A point's optional
-- delay adds a soft cost for every stop after it, biasing hard quests later.
-- No tour closes back
-- to the player. A finish is a cost hint, never an extra task in the output.
-- Large groups fall back to the caller's existing nearest-goal selector.
function Route.Plan(points, start, finish, fixed)
	local n = #points
	if n == 0 or n > LIMIT or not valid(start) or (finish and not valid(finish)) then return nil end
	if fixed and (fixed < 1 or fixed > n or fixed % 1 ~= 0) then return nil end
	for _, p in ipairs(points) do if not valid(p) then return nil end end
	local d, from, to = matrix(points, start, finish)
	if n <= EXACT then
		local order, cost = exact(n, d, from, to, fixed, points)
		local baseline = greedy(n, d, from, fixed)
		local baseCost = length(baseline, d, from, to) + delayCost(baseline, points)
		if baseCost <= cost + EPS then order, cost = baseline, baseCost end
		return order, length(order, d, from, to), cost
	end
	local best, cost = improve(greedy(n, d, from, fixed), d, from, to, fixed, points)
	-- Compare authored order and four distinct starting points. Keeping the
	-- greedy baseline guarantees this heuristic never worsens its score.
	local authored = {}
	if fixed then authored[1] = fixed end
	for i = 1, n do if i ~= fixed then authored[#authored + 1] = i end end
	local order, total = improve(authored, d, from, to, fixed, points)
	if total < cost - EPS then best, cost = order, total end
	if not fixed then
		for seed = 1, 4 do
			local first = 1 + math.floor((seed - 1) * (n - 1) / 3)
			order, total = improve(greedy(n, d, from, first), d, from, to, nil, points)
			if total < cost - EPS then best, cost = order, total end
		end
	end
	return best, length(best, d, from, to), cost
end
