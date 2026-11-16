-- A quick complete hand-in order, improved with a sparse set of transport
-- estimates. Real Nav searches and stop optimization yield at cooperative
-- three-millisecond checkpoints, without spending other addons' Nav API budget.
local ADDON, ns = ...
local Route = {}
ns.HandinRoute = Route

function Route.Order(stops, from)
	-- A quick provisional route while full travel costs are being checked.
	local order, used, here = {}, {}, from
	for _ = 1, #stops do
		local best, seconds
		for i, s in ipairs(stops) do
			if not used[i] then
				local t = here and ns.DirectTravelCost(here, s.inP) or nil
				t = t or 1e9
				if not best or t < seconds then best, seconds = i, t end
			end
		end
		order[#order + 1], used[best], here = best, true, stops[best].outP
	end
	return order
end

-- done(order, unknown, partial): every known stop remains in order. unknown
-- marks only incoming edges the travel planner actually tried but could not
-- estimate, never unsampled straight estimates. Timeout keeps the estimates
-- already gathered and still optimizes with them. Only player-origin edges
-- may spend a Hearthstone or teleport; later origins are explicit points.
function Route.Refine(stops, from, keep, done)
	local n, nav = #stops, ns.Nav
	if not (from and n > 0 and nav and nav.EstimateTravelCooperative) then return end
	local costs, index = { [0] = {} }, { [from] = 0 }
	for i, s in ipairs(stops) do
		costs[i], index[s.inP], index[s.outP] = {}, i, i
	end
	local clock, cpu, last, sliceStart = debugprofilestop, 0, 0, 0
	local calls, started, estimating = 0, GetTime(), true
	local dataVersion = nav.travel and nav.travel.dataVersion
	local function work()
		if clock then
			local now = clock()
			cpu, last = cpu + now - last, now
			if cpu - sliceStart >= 3 then coroutine.yield() end
		end
		return cpu
	end
	local function finish(partial)
		estimating = false
		local order = ns.Dungeons.PlanStops(stops, from, nil, function(a, b)
			local t = costs[index[a]][index[b]]
			if type(t) == "number" then return t end
			return ns.DirectTravelCost(a, b) or 1e9
		end, work)
		local unknown, previous = {}, 0
		for _, i in ipairs(order) do
			if costs[previous][i] == false then unknown[i] = true end
			previous = i
		end
		done(order, unknown, partial)
	end
	local worker = coroutine.create(function()
		local queue, seen = {}, {}
		local function add(i, j)
			local key = i * (n + 1) + j
			if i ~= j and not seen[key] then
				seen[key], queue[#queue + 1] = true, { i, j }
			end
		end
		-- Price each possible first stop, then the existing route's edges, so
		-- even a partial pass has useful travel costs before local alternatives.
		for j = 1, n do add(0, j) end
		local previous = 0
		for _, j in ipairs(Route.Order(stops, from)) do add(previous, j); previous = j end
		for i, s in ipairs(stops) do
			local first, second, a, b
			for j, target in ipairs(stops) do
				work()
				if i ~= j then
					local t = ns.DirectTravelCost(s.outP, target.inP) or 1e9
					if not first or t < a then second, b, first, a = first, a, j, t
					elseif not second or t < b then second, b = j, t end
				end
			end
			if first then add(i, first) end
			if second then add(i, second) end
		end
		for _, edge in ipairs(queue) do
			local i, j, seconds, reason = edge[1], edge[2]
			repeat
				work()
				if calls >= 4 then coroutine.yield() end
				calls = calls + 1
				seconds, reason = nav.EstimateTravelCooperative(i > 0 and stops[i].outP or nil, stops[j].inP, work)
				if reason == "busy" then coroutine.yield() end
			until reason ~= "busy"
			costs[i][j] = type(seconds) == "number" and seconds >= 0 and seconds < math.huge and seconds or false
		end
		finish(false)
	end)
	local function slice()
		if not keep() then return end
		local version = nav.travel and nav.travel.dataVersion
		local changed = version ~= dataVersion
		if changed then
			-- A newly loaded graph must not be mixed with vertices or costs
			-- from a suspended search over the old graph.
			dataVersion = version
			for i = 0, n do costs[i] = {} end
		end
		if changed or (estimating and GetTime() - started > 30) then
			-- Abandon only the unfinished search, not earlier answers. The
			-- replacement optimizer uses the same accumulated sparse costs.
			estimating = false
			worker = coroutine.create(function() finish(true) end)
		end
		last, sliceStart, calls = clock and clock() or 0, cpu, 0
		local ok, err = coroutine.resume(worker)
		if not ok then error(err) end
		if coroutine.status(worker) ~= "dead" then ns.After(0.05, slice) end
	end
	ns.After(0.05, slice)
end
