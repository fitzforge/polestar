-- Travel estimates for the completed-quest route. Keep expensive Nav work
-- out of the guide builder: at most four budgeted estimates per frame,
-- cancelled when the quest list changes or the player closes the guide.
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

-- done(order, unplaced, partial): stop indices reachable in the chosen order and
-- those for which no travel estimate is known. A missing estimate is never
-- replaced by a fictitious cross-continent trip. Initial edges may use the
-- player's Hearthstone/teleports; subsequent edges cannot reuse them. On a
-- deadline, partial is true and no replacement order is supplied. The
-- final optimizer also yields at four-millisecond cooperation boundaries.
function Route.Refine(stops, from, keep, done)
	local n, nav = #stops, ns.Nav
	if not (from and n > 0 and nav and nav.EstimateTravel) then return end
	local costs, index = { [0] = {} }, { [from] = 0 }
	for k, s in ipairs(stops) do costs[k], index[s.inP] = {}, k end
	local i, j, started = 0, 1, GetTime()
	local function finish()
		local function cost(a, b)
			return costs[index[a]][index[b]] or nil
		end
		local clock, sliceStart = debugprofilestop, 0
		local worker = coroutine.create(function()
			local order = ns.Dungeons.PlanStops(stops, from, nil, cost, function()
				if clock and clock() - sliceStart >= 4 then coroutine.yield() end
			end)
			local placed, missing, prev = {}, {}, 0
			for _, k in ipairs(order) do
				if costs[prev][k] then
					placed[#placed + 1], prev = k, k
				else
					missing[#missing + 1] = k
				end
			end
			done(placed, missing)
		end)
		local function improve()
			if not keep() then return end
			sliceStart = clock and clock() or 0
			local ok, err = coroutine.resume(worker)
			if not ok then error(err) end
			if coroutine.status(worker) ~= "dead" then ns.After(0.05, improve) end
		end
		ns.After(0.05, improve)
	end
	local function slice()
		if not keep() then return end
		-- Even a permanently busy planner cannot leave a background job alive.
		-- Unfinished estimates are not evidence of an unreachable recipient.
		-- Retain the provisional route and explain its limits on timeout.
		if GetTime() - started > 30 then done(nil, nil, true); return end
		local calls = 0
		while i <= n and calls < 4 do
			if i ~= j then
				local source = i > 0 and stops[i].outP or nil
				local seconds, reason = nav.EstimateTravel(source, stops[j].inP, true)
				calls = calls + 1
				if reason == "busy" then break end
				costs[i][j] = type(seconds) == "number" and seconds >= 0 and seconds < math.huge and seconds or false
			else
				costs[i][j] = 0
			end
			j = j + 1
			if j > n then i, j = i + 1, 1 end
		end
		if i > n then finish() else ns.After(0.05, slice) end
	end
	ns.After(0.05, slice)
end
